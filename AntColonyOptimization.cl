; CPSC 481 - Artificial Intelligence
; Team: Chantalle Bril, Payne Lacsamana, Abdul Dergham, Luis Rangel

;========== GLOBAL VARIABLESS ==========;
;Please declare global vars in here
;Beware when using setq - you might be setting a global variable when a local variable is needed

; Our list of all ants
(defvar ants (list))

; The number of ants that have found the goal
(defvar num-ants-found-goal 0)

; The shortest path to the goal
(defvar shortest-path (list))

; Number of iterations / moves until program reached the end
(defvar iterations 0)

; The grid the ants will traverse
; -1.0 means there is an obstacle on the cell
; 0 means the cell is clear
; Positive values mean there is pheromone on the cell
(aref (setq grid (make-array '(40 60) 
                    :element-type 'single-float
                    :initial-contents '((0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0    -1.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0)
(0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(-1.0    -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0)
(0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0)
(0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0 )
(0.0  0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  0.0   -1.0)
(0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0)
(-1.0    -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0 )
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0    -1.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0 )
(0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0   -1.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0)
(0.0  -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0 )
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0 )
(0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0 )
(0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0 )
(0.0  0.0  0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0)
(-1.0    -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(-1.0    0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0  )
(0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0)
(0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0)
(0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0))))
        1 2)
;=======================================;

;========== FUNCTIONS ==========;

(defun spawn-ant ()
	; add documentation here
	(setq ants (append ants
		(list (list (list 0 0) nil (list (list 0 0)) (list (list 0 0))))
	)) 
)

;adds 20 to half the grid for testing
(defun test ()
	(loop for i from 0 to 19
		do(loop for j from 0 to 59
			do (if (= (aref grid i j) 0.0)
				(setf (aref grid i j) (+ (aref grid i j) 20))
				)
		)
	)
)


(defun migrate-scent (a b) 
	;documentation here
	"grabs 1% of the current gas"
	(setq gas (float(/ (aref grid a b) 500)))

	"checks to see if left cell exists and if it does the gas moves over if no wall exists"
	(if (> (- a 1) -1) 
		(if (> (aref grid (- a 1) b) -1) 
			(setf (aref grid (- a 1) b) (+ (aref grid (- a 1) b) gas))))

	"checks to see if right cell exists and if it does the gas moves over if no wall exists"
	(if (< (+ a 1) 40) 
		(if (> (aref grid (+ a 1) b) -1) 
			(setf (aref grid (+ a 1) b) (+ (aref grid (+ a 1) b) gas))))

	"checks to see if top cell exists and if it does the gas moves over if no wall exists"
	(if (> (- b 1) -1) (if (> (aref grid a (- b 1)) -1) (setf (aref grid a (- b 1)) (+ (aref grid a (- b 1)) gas))))

	"checks to see if bottom cell exists and if it does the gas moves over if no wall exists"
	(if (< (+ b 1) 60) (if (> (aref grid a (+ b 1)) -1) (setf (aref grid a (+ b 1)) (+ (aref grid a (+ b 1)) gas))))
)

(defun evaporate-scent ()
	; add documentation here
	(loop for i from 0 to 39
		do(loop for j from 0 to 59
			do (if (> (aref grid i j) 0.0)
				(progn
					(migrate-scent i j)
					;maybe make to 0 if it's less than 0
					(setf (aref grid i j) (- (aref grid i j) (* (aref grid i j) 0.01)))
				)
			)
		)
	)

)


(setq test-ant (list (list 0 1) nil (list (list 0 0) (list 0 1)) (list (list 0 0) (list 0 1))))

(setq test-ant2 (list (list 0 1) nil (list (list 0 1) ) (list (list 0 0) (list 0 1))))

(defun is-in (elem arr)
	; if element is in array, return 1
	; else, return nil
	(setf true nil)
	(loop for i in arr
		do (if (and (= (nth 0 elem) (nth 0 i)) (= (nth 1 elem) (nth 1 i)))
			(setf true 1)
			)
	)
	(return-from is-in true)
)

(defun open-list (ant)
	(setf arr (list))
	(setf row (nth 0 (nth 0 ant)))
	(setf col (nth 1 (nth 0 ant)))
	(setf tabu (nth 2 ant))

	(if (< (+ row 1) 39.0) ;row is less than 39, can move down
		(if (/= -1.0 (aref grid (+ row 1) col))
			(if (not (is-in (list (+ row 1) col) tabu))
				(setf arr (append arr (list (list (+ row 1) col)))) 
			)
		)
	)
	(if (> (- row 1) -1.0) ;row is more than 0, can move up
		(if (/= -1.0 (aref grid (- row 1) col))
			(if (not (is-in (list (- row 1) col) tabu))
				(setf arr (append arr (list (list (- row 1) col)))) 
			)
		)
	)
	(if (< (+ col 1) 59.0) ;col is less than 59, can move right
		(if (/= -1.0 (aref grid row (+ col 1)))
			(if (not (is-in (list row (+ col 1)) tabu))
				(setf arr (append arr (list (list row (+ col 1))))) 
			)
		)
	)
	(if (> (- col 1) -1.0) ; col is more than 0, can move left
		(if (/= -1.0 (aref grid row (- col 1)))
			(if (not (is-in (list row (- col 1)) tabu))
				(setf arr (append arr (list (list row (- col 1))))) 
			)
		)
	)

	(return-from open-list arr)
)

(defun at-start (ant)
	"Returns T if the ant at the given index is at the start position, or NIL otherwise"
	(if (equal (car ant) (list 0 0))
		(return-from at-start T)
		(return-from at-start NIL)
	)
)

(defun at-goal (ant)
	"Returns T if the ant at the given index is at the goal position, or NIL otherwise"
	(if (equal (car ant) (list 39 59))
		(return-from at-goal T)
		(return-from at-goal NIL)
	)
)

(defun clear_tabu (ant-index)
    "Resets the ant's tabu list to contain only its current position"
    (setq tabu (list (list(car (nth ant-index ants)))))
    (replace (nth ant-index ants) tabu :start1 2 :end1 3)
)

;===============================;

;========== MAIN ==========;

(loop while (< num-ants-found-goal 30)
	do
		(format t "========== Iteration ~D ==========~%" iterations)
		(setq iterations (+ 1 iterations))

	(loop for i from 0 to (- (list-length ants) 1)
		do
		( let ( (ant (nth i ants)) )
			(format t "Ant ~D :~S~%" i ant)
			;(move (nth 0 (car ant)) (nth 1 (car ant)))

			(if (at-goal ant)
				(progn
					(print "This ant found the goal!")
					(setq num-ants-found-goal (+ num-ants-found-goal 1))
					; Update shortest path
					; Change ant mode to 'returning'
					; drop-scent
				)
			)

			(if (at-start ant)
				(progn
					(format t "This ant is at the colony~%")
					; Remove the ant from the list of ants
				)
			)
		)
	)

	(spawn-ant)

	; Just so we don't have an infinite loop
	(setq num-ants-found-goal (+ 1 num-ants-found-goal))
)
;==========================;

