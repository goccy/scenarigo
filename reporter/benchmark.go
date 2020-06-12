package reporter

import "testing"

type benchReporter struct {
	*testing.B
}

func FromB(b *testing.B) Reporter {
	return &benchReporter{b}
}

func (r *benchReporter) Run(name string, f func(b Reporter)) bool {
	return r.B.Run(name, func(b *testing.B) {
		f(FromB(b))
	})
}

func (r *benchReporter) Parallel() {

}
