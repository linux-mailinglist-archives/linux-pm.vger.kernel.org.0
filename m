Return-Path: <linux-pm+bounces-34235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE982B4AB6F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAF3682CE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCCC324B02;
	Tue,  9 Sep 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGNoBs4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF532253D
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416300; cv=none; b=C+pNYPCf+1qUqCQ8w30fslTzRREJ91q+rnGCw+0IJoD1t5u1FZpM+inWlys1233sLt8CVP9wwqH0uFrXaQYDgiEP1IQ7j6C2CcA0B7gIGt9zMnQBgThPGqAehCYMmjvI4mLqo+XWa/xiTkEi66gcNXe+e+FpKMT3ql1kz6yAG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416300; c=relaxed/simple;
	bh=FT2wsbDyCZRzD2r+SnftPJClb+shQXg//V9P9Jil0eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd3cvLRiJKLdk1tFultZiEBDHecM7l+/yH4dj8C/wm4WdacQ0NCzsJl1ErZ62bRbBENs+ZDCAYZpNeFcuWt687SHwHy12wCX78u2cwUkt+2WyFYWdK3rHbiyOKu/K3jWEeIjfjg/PFIhsfEn3ZKo54EMZa8/Lvu+kXBHgSt7sLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGNoBs4X; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f72452a8eso6510182e87.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416296; x=1758021096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRRJzAp5T/AY0upYHHrWwdi9zh66HciwKxd1T/ME7rY=;
        b=yGNoBs4XjZ0kr82NOQ6fdutdX09iGIZuWcEw5FA3qVZ0BYpb1I13GrahPRwn7zrPqv
         DpRKsTwROhnigCx5P9jXgK17kfQneMIm9q9LVYEGoIaW09R5haFPM66THrxCJytbxeDp
         O5DK3H3ZzC64pOWED9GUIOlYnOS8VqClrW2HgjM12VRQcvyEATrBatjPRaJmr5TVo/NK
         WB3eDnIS0hUFyuz9v3WgZdKviaq0oqWQfEiC7SacT2M7qEIwDA7OgSFUgJUBY0mQN8y1
         A+MPIXX7olMWtIN0BuV+RbFlj0qeF/4m9KOzFrdWpPx1KhA5p5qwfWjL8KRBbsf1ndBO
         terg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416296; x=1758021096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRRJzAp5T/AY0upYHHrWwdi9zh66HciwKxd1T/ME7rY=;
        b=gKbA/swkl1oCTuWxA2tR5WXj+LdmXxGctdGLAJrem7vJGbM38r8OOzLccPZO19anib
         IYwFNPlw+xfPrLAAtVSUfPf6/tc3flHIVJijW9vFY6ZHsxttGw5yza64NVcIrNym228s
         Y9keYbgt4bN0w2pLVXmZj1sZjjbbkI+c1LOcJvIW7Qgn8CHLR30zWwrdl5qnWOlq2xTl
         OkWC3aLYLAj/tCEqpexPXhHrDV+FCuaLK7FqnzJs5hHvCXDKODBtguVccyQcqJ6j5oVN
         pRc2JUnn4tBTw3+2sXc7+YBaBK6lymS6vDIXt57mvlRqMqDXJ5dn1IHmuc0aXujI6noP
         NMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ugQJ/ZXmRpyhnzbUYe31XxPlzP0Pqvx4m5JvpsM7xr0BxY5gzUAbFJ7a8gEx+VLAVLAea1tOzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZr0yk3WEkeTripbsWSQzZZTJmDkgVVDssH1aPdiNtuInCkbzc
	hauBL6HA4AQGyVXJofSDltnl5RZ4DRS9HHQ7DEMnDHZszi3YVtMnnqaywL0VoRjxqcIhl9FahI9
	HMGl+
X-Gm-Gg: ASbGncshlcfhMDtB2pIwIvSAr9q1cHET8m0M9BayXnilUktShKZf3aYpglgvi51kUow
	I1v87sjAlE+SsXcZrIo0FHDrahI52svFbWPKZEaAW+ObEuRyaLRA6I9V6UoJfoXXGUkLCwb3EJy
	yBQvBCcCqaIgt1owSlz0GKTnFOk9/2ybCeEp5f0UFpzZewX4Rs9Hatc0Aou+HLxTg5BhdTqJNwI
	wthjYvEdy0pmyhifbSo575u0JZe0J7I/zdx+gyXmPssp0d0I32CrdJdTltLz/EuN8/v87IoHDmL
	H6QLkj505Tr0MDq1Zl450FnZoGV9iZcsP1PBYwTfUUfQDVah3rrApR19DRFYFFw0kSTXfsk/Yyn
	cN2awAYC3J6UV0YX2BNnSw6TpBfvBtt+ENk2sgrLYvyUBsMqSu0wBUrhIKKp/f7QRtenSE0c4Fb
	XNAR7b67k=
X-Google-Smtp-Source: AGHT+IE+Q6v2KTcckCRiOxW67dRfnlJxOytiBrBROHCosdo74CbcYnNRw9OtyMUXGt/Lx7pml2UICg==
X-Received: by 2002:a05:6512:b12:b0:560:8b56:5dc5 with SMTP id 2adb3069b0e04-56261cbe1f7mr4363060e87.18.1757416296383;
        Tue, 09 Sep 2025 04:11:36 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:35 -0700 (PDT)
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
Subject: [PATCH 2/5] pmdomain: rockchip: Fix regulator dependency with GENPD_FLAG_NO_STAY_ON
Date: Tue,  9 Sep 2025 13:11:21 +0200
Message-ID: <20250909111130.132976-3-ulf.hansson@linaro.org>
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

The deferred regulator retrieval for Rockchip PM domains are causing some
weird dependencies. More precisely, if the power-domain is powered-on from
the HW perspective, its corresponding regulator must not be powered-off via
regulator_init_complete(), which is a late_initcall_sync.

Even on platforms that don't have the domain-supply regulator specified for
the power-domain provider, may suffer from these problems.

More precisely, things just happen to work before, because
genpd_power_off_unused() (also a late_initcall_sync) managed to power-off
the PM domain before regulator_init_complete() powered-off the regulator.

Ideally this fragile dependency must be fixed properly for the Rockchip PM
domains, but until then, let's fallback to the previous behaviour by using
the GENPD_FLAG_NO_STAY_ON flag.

Link: https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com/
Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 242570c505fb..1955c6d453e4 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -865,7 +865,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->genpd.power_on = rockchip_pd_power_on;
 	pd->genpd.attach_dev = rockchip_pd_attach_dev;
 	pd->genpd.detach_dev = rockchip_pd_detach_dev;
-	pd->genpd.flags = GENPD_FLAG_PM_CLK;
+	pd->genpd.flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_NO_STAY_ON;
 	if (pd_info->active_wakeup)
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	pm_genpd_init(&pd->genpd, NULL,
-- 
2.43.0


