namespace IronSulfurSimulation {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;

    // Hàm mô phỏng trạng thái cơ bản của cụm [2Fe-2S]
    operation SimulateFeSCluster() : Result[] {
        // Số qubit đại diện cho 2 electron trên 2 nguyên tử Fe
        use qubits = Qubit[2];
        
        // Áp dụng cổng Hadamard để tạo trạng thái siêu vị (superposition)
        for q in qubits {
            H(q);
        }

        // Mô phỏng tương tác giữa các electron (Hubbard model đơn giản)
        // Giả sử t = 1 (hằng số nhảy), U = 2 (tương tác Coulomb)
        let t = 1.0;
        let U = 2.0;

        // Áp dụng cổng lượng tử đơn giản để mô phỏng tương tác
        CNOT(qubits[0], qubits[1]);
        Rz(U, qubits[0]); // Tương tác onsite

        // Đo trạng thái cuối cùng
        let results = MultiM(qubits);
        
        // Reset qubits về trạng thái ban đầu
        ResetAll(qubits);
        
        return results;
    }

    // Hàm chính để chạy mô phỏng
    @EntryPoint()
    operation Main() : Unit {
        Message("Starting quantum simulation of [2Fe-2S] cluster...");
        
        // Chạy mô phỏng 100 lần để lấy thống kê
        mutable zeroCount = 0;
        mutable oneCount = 0;
        for _ in 1..100 {
            let results = SimulateFeSCluster();
            if (results[0] == Zero and results[1] == Zero) {
                set zeroCount += 1;
            } elif (results[0] == One and results[1] == One) {
                set oneCount += 1;
            }
        }

        // In kết quả
        Message($"State |00> observed: {zeroCount} times");
        Message($"State |11> observed: {oneCount} times");
    }
}