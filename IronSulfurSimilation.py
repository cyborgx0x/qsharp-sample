import numpy as np

# Hàm xây dựng Hamilton cho cụm [2Fe-2S] (mô hình Hubbard đơn giản)
def build_hamiltonian(t=1.0, U=2.0):
    # t: hằng số nhảy giữa các nguyên tử Fe
    # U: tương tác Coulomb onsite
    # Cơ sở: |00>, |01>, |10>, |11> (2 electron trên 2 site)
    H = np.zeros((4, 4))
    
    # Điền ma trận Hamilton
    H[0, 0] = 0  # |00> (không electron)
    H[1, 1] = U  # |01> (1 electron ở site 1)
    H[2, 2] = U  # |10> (1 electron ở site 2)
    H[3, 3] = 2 * U  # |11> (2 electron cùng site)
    
    # Nhảy giữa các site (t)
    H[1, 2] = -t  # |01> <-> |10>
    H[2, 1] = -t
    
    return H

# Hàm tính năng lượng trạng thái cơ bản
def compute_ground_state_energy():
    H = build_hamiltonian(t=1.0, U=2.0)
    eigenvalues, eigenvectors = np.linalg.eigh(H)
    ground_energy = eigenvalues[0]  # Năng lượng thấp nhất
    ground_state = eigenvectors[:, 0]  # Trạng thái cơ bản
    
    return ground_energy, ground_state

# Hàm chính
def main():
    print("Starting classical simulation of [2Fe-2S] cluster...")
    energy, state = compute_ground_state_energy()
    
    print(f"Ground state energy: {energy:.4f} eV")
    print("Ground state vector:", state)
    print("Probabilities of basis states (|00>, |01>, |10>, |11>):")
    for i, prob in enumerate(np.abs(state)**2):
        print(f"State {i}: {prob:.4f}")

if __name__ == "__main__":
    main()