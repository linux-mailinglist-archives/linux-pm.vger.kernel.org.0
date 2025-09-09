Return-Path: <linux-pm+bounces-34238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BC0B4AB68
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A8C1C6642F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FB63203BE;
	Tue,  9 Sep 2025 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuAI8+kr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0D32255F
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416305; cv=none; b=fSFrmGGv7vXcPG0A3TT1w4eA0xezqzG0odKap61J36DeBFZPj98pyHiNRpyxLAZTl60VizD4ykoN6q8tWQUwXCt55MFy9rZA2X7hVla1jDfDuqm8itlAgTPC9z1El+J3PDA9wt4DhmIGh5igltYlWqz5tc8JWNKM0lie9xqwMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416305; c=relaxed/simple;
	bh=qX2XQlnL77P0KB6EClM0+xTAM+le4yDduPWYxg1F5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/gHMNWdPYiWjPEH1DzNMWFcN3/kr00UywNsOZaHXExM/WUG0bV2ZDQlucJndeCVRHpkKE9/1R2fKaVMo2R0fD5nznY3jez6MtQrOwZBv2xrxYpVo7zvf9YmvLhFo7tLRU0uZtkhv9+einFNwsrNVx3pSUti7YrO/E3nEA3/KJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uuAI8+kr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso5446812e87.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416300; x=1758021100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s4ue+vxLshDaVNog/qaeHRfYjor1s3xeCpGVICPA0U=;
        b=uuAI8+kr6UZrPmjAi2JGqIXdQhh8kzvyBETXnFVd/rchL+995Q8kDzBZfYdR0m6oQ5
         IysC6wrN9/l6r7cHhbfbTiAycr3ojx493iByx6XlgS50dzcv9O288iSamqMuuEvHQUXy
         KC8sVTWScjQgGU0vYIUcmodQdoYDUsGfnRS93Sr6xFtjQvw9VEp3Vvca9KJBAcarsr5W
         V3wMjAaDNHR/m6YSHHwUsJYtI2uSV/OkbLAPJAurqynpJwM5ZRbDK8KZOkTylUP15Guk
         y8833WK5DN2PVhSteql9nSnHbZjKhWR+Qta4P6YJgVaLRXFYhy7iprbgswtjjA3/N2i6
         2V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416300; x=1758021100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s4ue+vxLshDaVNog/qaeHRfYjor1s3xeCpGVICPA0U=;
        b=l4iHryPxEyrpRIO/d1scEEY2uCMg91QYval4HCzcT5ubpy9MeuOYi7UkoTu/MnP/cE
         iEES6ZAskVRDUtmRfNFnIYVabuvPrzezeRsS//Q959dnEAJ1CY4A6L6Fr679kxKw8UHH
         ASewnxFttXVlWW5TXtXWD2Hsd9BxLlWCE2HbUi36fvN+AqnEmh1yCost4f+ktlpE5CBX
         3Rf8jT6yRCvBCYjcUrylOrFlt5jubaltyFQHkur0gvwqg5oI17B4s2xavF5qedIMog23
         tH2Tv+ognwzk5EXu9EufsmfOOfBlP/b/wDwe9NlDF1UZkhRtU6QuD0goQdqxFrXueiAQ
         5T8w==
X-Forwarded-Encrypted: i=1; AJvYcCW+UzNof/o5Pi0W2B4hiwnyK85dS4QAvCwo8Zoa+cpO1jZPYjApTa0DPWl9hMIeq5t3XByDZz71xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CfZIOznKu+SxVUvmJeet64dboG4nPI9/9RxaaMlr5w4d83ZD
	Zx1938FcYVnt/Cwnq069JvV6qB7TW54DEb0adDaJjUfW/rVxceIsXdGUiWnqWqywvVw=
X-Gm-Gg: ASbGnctE8YhTwzkSOsJVsm308HWW7sBgaSsxSUIn+CdzBqw8yYYgaFsg2APKdfgnFJv
	FQWqSoA23ulIteXwzzrCqOGAI0xIDJiBKJYAWOo2JrXjFTSrbZ7pcXmARR9BiCn2l1/y0es9CBN
	YCAkRrbqAlaVRSuMV/HqZmVfT6o2A4RiXd4skgfpprGf/mJmStcx/y2bun9W8oyWwYJoGX0mDOg
	yXRjIRVVGOZfcKmV5aOprK+UKsECWOoiH50V78IZWAODAY2GIJ0bcsOPvx/A5650TbbfcNbHgOp
	tWAfnlP5nChdLs7C9VypRoVMrER7lR9FhJKAU6tjRV2CqfH/cPzy0p+1CgzTrCFz++3T40z2hVw
	XKmHQs7vJwIb4/79JYT8El46cOiCrM2SDaYjXEmUkqasnLXb11RPviZzNs8/fF20ZpqyfRfl3Fc
	Ly+C88z08=
X-Google-Smtp-Source: AGHT+IH3If1E1wmdYnnMVHOIWDwlC5uh1BOrgxWYASzxhPPmZmGZqHrDzK8CUhRE0KdKbGrCF4Hbhg==
X-Received: by 2002:a05:6512:10ca:b0:55f:5942:43ca with SMTP id 2adb3069b0e04-56260f37a43mr3913159e87.20.1757416300440;
        Tue, 09 Sep 2025 04:11:40 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:40 -0700 (PDT)
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
Subject: [PATCH 5/5] pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on
Date: Tue,  9 Sep 2025 13:11:24 +0200
Message-ID: <20250909111130.132976-6-ulf.hansson@linaro.org>
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
none of them in its current form are a good fit for rmobile-sysc PM
domains.

Let's therefore opt-out from this behaviour of genpd for now, by using the
GENPD_FLAG_NO_STAY_ON.

Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rmobile-sysc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
index 8eedc9a1d825..a6bf7295e909 100644
--- a/drivers/pmdomain/renesas/rmobile-sysc.c
+++ b/drivers/pmdomain/renesas/rmobile-sysc.c
@@ -100,7 +100,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
+	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP |
+		GENPD_FLAG_NO_STAY_ON;
 	genpd->attach_dev = cpg_mstp_attach_dev;
 	genpd->detach_dev = cpg_mstp_detach_dev;
 
-- 
2.43.0


