Return-Path: <linux-pm+bounces-34236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF8B4AB71
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FED4E0635
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BED326D75;
	Tue,  9 Sep 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zgu3nzuG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A20322A0E
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416301; cv=none; b=IsnOHTpF9c0RfG6KJQ5plnZnmp1DIL9O9EsSfthxD878cnr2h46svPvBRFln3GVEBOpbpG4lFVEQV2tlUSebUVrsKp+Opo3PZE/+L+RL3zHmqzJgDqkQ8Kh+oWWgUPnP07/0vHPUsHjyZpDyHaAcE1fnr5XHtXE5iAanEXo0kyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416301; c=relaxed/simple;
	bh=hk3zLwcEJKFdhvO6fbF4mETMi1Wbntn3yOBrNMw+h10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izN1D0V88ehriFzZ0Me/snaF1h68Ry0xlXurfdgzlzpFzdqQKC84BP75xr5bMWCKl4EWWl/9Qg9VeNe5qEO7XNRN+vTedHymvwRtwO2oNrGspgGxKploT+0Msczkglucih9ulPhwtX/9N5A+Fg2o1Y1mjjaocVSfDMhYHM9/CLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zgu3nzuG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso6041373e87.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416298; x=1758021098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYd82RFH6eK4wGWLoS9WCtFcsYKgozGDQMKLc16TQyQ=;
        b=Zgu3nzuGB123lSE87IXojwFVMX5+8TiabEOuS0glbhpwAV+oWPNObGzenm8UkEfiyJ
         XRIENXcxDWahii9aisNy1rkuBaZotUcdCQvYB3d2XkRKN7VAIgUVHglf5k9ofh1Uluza
         7YwzlQ6q58JZLCNtQY3O3o4YPKAyPwbLHvuQodJ0ahdP5ilN7C+kHAmwK8kmr3PAworQ
         3U3hH+cQCIEIZUWvXKp5ohBamS8m1u5bzy+dlOyuO9rUYmaHgTA5sksM5czjbVffz2qi
         TCK1RQMxnKd3SilGbitiZ3delYFpefzRVjGOEI6D44yu7ULQYYNXZj9R+bVl7L8ztNQB
         zyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416298; x=1758021098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYd82RFH6eK4wGWLoS9WCtFcsYKgozGDQMKLc16TQyQ=;
        b=P41K0NImDLhnQHdsx/zX+ecEKoiSjeyTNTtBNUbFg5DKrYbisJKpaZQHun2p5kAq6J
         iGx+4r49TY9/G2M5mQAVgdCs6RncDdFvAZ+38xiDJmKU4cfG7hnflgKRgPrBu+7HLUcD
         FsA9t+RZVcqmzIvOJGv7Dvi/N6cCvUwMc1kZKyd1T9wB+7h7f538TN6GMU+4wlpoJacB
         L7iC6dmtMgw/a0kjjM9uYDuRYT4B1uXVrVs2RiPWdpEF55e3y2x7qLMnPVeXuqvOQkRO
         AEfFtQnt6mVpMMlvDieYOTVcmM2nXOoVPAVrpqw39sAr5l2POAwuQC/Q2fKwSU0qlsYj
         N1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXO84Pj8NOuConaOCawVmEXnYMnstRc0nnsHjO0X74zmJw2YG0Z1kgw/3A7KUSEXbn+VjKNDC+3lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyg+RDH9uSsS43i1YRVV0bdmAJWPAehWeYSNKBpzxusBp+vCe
	rxhc572VydajospBHVXx+NsVYxykyAC5fLnULa/BSLUafth9o6ZmimfN2b9SLWItpkw=
X-Gm-Gg: ASbGncvCLigyuvNdS5CrlJuzmDmbrgsjBAPoaJZZg6eRhu7kBMBI+byH1hJWfwu3Lyp
	KkLCgzeMET7RPHlAi+2iVlcBSVxYVn9YpOZqjPyeV0LN0tRrN290MRp9zU4SGFMR81X5kbXunoB
	1gIDhf/N7XYLJSjON28Zztlj9gL4ZqsW1gh46jcTOUvs5zgsR5dZp3xQNnU2VWBvieMmexb6rBg
	6Gu4cADccuAI0jOt7h6AWpUt0EedykirFMimKVbBM+3lF0yPwlagxJA6obXghqQwjgdRg/1gjPT
	KxmMzr3YScIdQiOh+UiTQ3KZd/eNI72bwRkO2N+CDSNw3GDtlAossHwwi+tyT5q5d6lKI08mYZm
	6zBCyzq9zHflQRJhNh7KL2XbSC0irgvOceWN6xuGigEglPXbqs9bfXPo1cPyZu6tBqsU/hEt2Y5
	0W/5qQiiI=
X-Google-Smtp-Source: AGHT+IEDEezqBzu6WD5cRb0Yhvc1WCJvGMbiCnMcquxNLiuAz9Ox4q5bWS49Ks338WKrFgMjtbd8NQ==
X-Received: by 2002:a05:6512:220c:b0:55f:6bae:50c5 with SMTP id 2adb3069b0e04-5625ffc80ebmr3407675e87.19.1757416297700;
        Tue, 09 Sep 2025 04:11:37 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:37 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-pm@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
Date: Tue,  9 Sep 2025 13:11:22 +0200
Message-ID: <20250909111130.132976-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909111130.132976-1-ulf.hansson@linaro.org>
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent changes to genpd makes a genpd OF provider that is powered-on at
initialization to stay powered-on, until the ->sync_state() callback is
invoked for it.

This may not happen at all, if we wait for a consumer device to be probed,
leading to wasting energy. There are ways to enforce the ->sync_state()
callback to be invoked, through sysfs or via the probe-defer-timeout, but
none of them in its current form are a good fit for rcar-sysc PM domains.

Let's therefore opt-out from this behaviour of genpd for now, by using the
GENPD_FLAG_NO_STAY_ON.

Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 2d4161170c63..d8a8ffcde38d 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -241,6 +241,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		}
 	}
 
+	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_sysc_pd_power_off;
 	genpd->power_on = rcar_sysc_pd_power_on;
 
-- 
2.43.0


