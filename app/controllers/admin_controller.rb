class AdminController < ApplicationController
  def status
    if defined?(::REDIS)
      @status = (::REDIS.get("crawling") == 1 ? "Crawler läuft gerade..." : "Crawler läuft nicht")
    else
      @status = "unbekannt - kein Redis verfügbar"
    end
    render json: (params[:pw] == pw ? @status : "Passwort fehlerhaft, bitte (noch einmal) eingeben")
  end
  def crawl
    if params[:pw] == pw && LockedSpawner.crawl
      render json: "Crawler gestartet"
    else
      render json: "Oops... Fehler beim Starten des Crawlers, evtl. läuft dieser schon oder das Passwort ist falsch."
    end
  end
  
  protected
  def pw
    ENV["ADMIN_PW"]||"test"
  end
end
