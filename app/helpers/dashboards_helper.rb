module DashboardsHelper
  def link_to_toggle_save_entry(entry)
    if entry.saved?
      link_to icon('fas', 'check', class: 'strong text-success', title: 'Added to your digest')
    else
      link_to icon('far', 'star', class: 'strong text-dark', title: 'Save to your digest'),
        user_entry_path(current_user, entry), method: :patch, remote: true
    end
  end
end
