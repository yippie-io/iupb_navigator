class LockedSpawner
  def self.crawl
    if defined?(::REDIS) && ::REDIS.get("crawling") == 1
      return false
    else
      Spawner.spawn do
        ::REDIS.set "crawling", 1 if defined?(::REDIS)
        ZSBCrawler.new.fetch_all true
        ::REDIS.set "crawling", 0 if defined?(::REDIS)
      end
      return true
    end
  end
end