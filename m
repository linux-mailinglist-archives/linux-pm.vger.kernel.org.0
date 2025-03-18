Return-Path: <linux-pm+bounces-24267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE5A68055
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 00:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01328189DA4D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 23:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B67213E97;
	Tue, 18 Mar 2025 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RwW0M0A0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA22063FD
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338860; cv=none; b=kTN1A/68C6YLaM+hAsvqWelvjjD5lW6Gng0lq5qsi3wsFd2ZE2OYbiH3ewj1bkWj6nw5L0CYRIjYnbLsgTRQ1lYVyt1pDhEVsQx96H2BscJ4QINCLM4iJUA1519HXRRLKEAQC5QYCbqUJOeXC5bTfMEhIJIyYS7JmfMxwYFFjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338860; c=relaxed/simple;
	bh=KjTL/kc1eYTfSVbF1Y/4qPazi4UmfcO2nDxBcYIa/nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhLCf870TKzFhjGUWPCXRSgmMsTeGvxllYj0Q5j0p4V2EoTXI6zn2bQcSJf233WMLYQQ88dkLfD39+frhayz6B4gNM5cDKKxVpMTHYlCe0Q0fAlbpiBf2i6SeG/F3wqKf1j0il11fBQXCZs9vuAAlT8ieOrAzk4T63RaZoILYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RwW0M0A0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235189adaeso2532275ad.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338858; x=1742943658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsyWzi3KnCZDSIQ4SscmiQvCbCr+L8MktGb1FOBdF5k=;
        b=RwW0M0A0Y0a7zz2P4pEXs1H+dRCAgMyR+j9r+uuNFu1UL+LHBA/waleHBEjrpySV9a
         m42tz+7DF7WfEstgp3/4xZYeuFaAN+wZu9C9Y3QiZ4hONqeKN7240CxiTi0dwZm/O2lR
         HCxhRhze9uZ3+sSV9/YXBAv5395MulGA4lOXxN0XFkxj4sETLRQ36HtvE7KHlfNteKUc
         dGSupnZlmjdQqdQsVtqisUAHaSyb2CcZSiXUDm2SWKHdZAKxpYeqL/llkOnuEeQC0I86
         IfGRiI6mhwZs4wDg7tPU3dr5vslzur63/SV+1tHJQ+UaHzZJYAbjOC33IdOYKKpT83/b
         uiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338858; x=1742943658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsyWzi3KnCZDSIQ4SscmiQvCbCr+L8MktGb1FOBdF5k=;
        b=NJYGne/QD5slD1nsSzPNu2i2HGNjwlaHI1ZV/Tn0tBsL0+YfnlqsqD2Rge9zMHatRD
         md04mkWDqZ6yhMnkTAbzaThmR8W+8uzxH6PArN16hx7JogOJ/ZZFkK7+WuxbMdBkeqeS
         OhrDUjZN1FoZYiacnqNURKsbL21z0i4WEnXKcMOz8IGh7M0lDzE29yE8m8DZAHXeHj4Y
         fVw9TP8XwO0Z/1brttuN5sW45I0eR5HemjhKQ4H5snFDS1glmRHOzno6DTsGqMMbSQC3
         t0EPOhcb1g6bSAmARW/Ow9DoThQtz2Sj0PJaUqg/DtiYekFrIygnBrqZxWA0PymZvIEi
         E/kw==
X-Forwarded-Encrypted: i=1; AJvYcCWI5yVV8BBh3oUqyK+Lf24ggGGaUagPJoJ1lUlRFhytvPwGrI30tXFk8ZESd6bKIg4+USBPktvQTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbj6yzvnFkluZjAmgTQfz8hPL8wbJHw6aEzIa+Z0Y4+xEuF2l
	6Mr+22IhWfU5ePILobmRLTh8sdTsi5injrTrCKlydaXe5t/huacAb3PHwPM5pWQ=
X-Gm-Gg: ASbGnctK6m5txgPm6muWXvKyoDiCwyXYctxiJPqXZv8aN95VJOq53CyjwpyLdtmktOY
	k3erzZFiVbGW1vedq0/84N2p/gVsTAcTDmkBU793t4hw7dK0cq1mghLWymbMZgCGzdg/QkknLRA
	66VR1vS09I+YsrcGW1EcWC3Pje/al0+8kMxdGC1TT8rkPm1GkyODjU1xTytR8pkyL5kKczl7+9g
	A4Qc8XpdPOSc7LheMFm2+oLIv2iMATfkbyRsT0OuEHDbHGJVVQf9+J/ANkc7uxO0vAEKqR92SlB
	/M9rhJHHuCDl6SPrG9pAzBk+EeUSuVYyzSYmxgjLKLEAEJWHgOCuF7Fm4TUN78mzRuLoT0T4s/B
	Js8Fcytg=
X-Google-Smtp-Source: AGHT+IHUNJViFXE4mZINOgNDoCllQmqZOnocHLrF3VCSwCnt9Ce0i+DvhytxOw5IATvfS/lSW8+VYA==
X-Received: by 2002:a17:903:2301:b0:220:cfb7:56eb with SMTP id d9443c01a7336-226491f957dmr7833935ad.26.1742338857707;
        Tue, 18 Mar 2025 16:00:57 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f14sm100739465ad.111.2025.03.18.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:00:56 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>,
	Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Bajjuri Praneeth <praneeth@ti.com>,
	Raghavendra Vignesh <vigneshr@ti.com>,
	Bin Liu <b-liu@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/4] pmdomain: ti: Fix STANDBY handling of PER power domain
Date: Tue, 18 Mar 2025 16:00:40 -0700
Message-Id: <20250318230042.3138542-3-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318230042.3138542-1-sbellary@baylibre.com>
References: <20250318230042.3138542-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per AM335x TRM[1](section 8.1.4.3 Power mode), in case of STANDBY,
PER domain should be ON. So, fix the PER power domain handling on standby.

[1] https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 drivers/pmdomain/ti/omap_prm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
index b8ceb3c2b81c..7e36e675a8c6 100644
--- a/drivers/pmdomain/ti/omap_prm.c
+++ b/drivers/pmdomain/ti/omap_prm.c
@@ -18,7 +18,9 @@
 #include <linux/pm_domain.h>
 #include <linux/reset-controller.h>
 #include <linux/delay.h>
-
+#if IS_ENABLED(CONFIG_SUSPEND)
+#include <linux/suspend.h>
+#endif
 #include <linux/platform_data/ti-prm.h>
 
 enum omap_prm_domain_mode {
@@ -88,6 +90,7 @@ struct omap_reset_data {
 #define OMAP_PRM_HAS_RSTST	BIT(1)
 #define OMAP_PRM_HAS_NO_CLKDM	BIT(2)
 #define OMAP_PRM_RET_WHEN_IDLE	BIT(3)
+#define OMAP_PRM_ON_WHEN_STANDBY	BIT(4)
 
 #define OMAP_PRM_HAS_RESETS	(OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_RSTST)
 
@@ -404,7 +407,8 @@ static const struct omap_prm_data am3_prm_data[] = {
 		.name = "per", .base = 0x44e00c00,
 		.pwrstctrl = 0xc, .pwrstst = 0x8, .dmap = &omap_prm_noinact,
 		.rstctrl = 0x0, .rstmap = am3_per_rst_map,
-		.flags = OMAP_PRM_HAS_RSTCTRL, .clkdm_name = "pruss_ocp"
+		.flags = OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_ON_WHEN_STANDBY,
+		.clkdm_name = "pruss_ocp",
 	},
 	{
 		.name = "wkup", .base = 0x44e00d00,
-- 
2.34.1


