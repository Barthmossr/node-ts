import { main } from '@/app/main'

describe('main', () => {
  it('should not return a value', () => {
    const result = main()

    expect(result).toBeUndefined()
  })
})
