require 'test_helper'

class DroidAdbsCommonsWMTest < Minitest::Test
  def test_wms
    density = ::DroidAdbs::WM.get_density
    assert(density)

    assert(::DroidAdbs::WM.set_density(base_density: density, scale: :small))
    assert(::DroidAdbs::WM.reset_density)
  end
end
