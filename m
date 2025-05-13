Return-Path: <linux-pm+bounces-27107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF1EAB5DEA
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06394C0C14
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1D51FCFE2;
	Tue, 13 May 2025 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qxh10uLo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553281FAC48
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168768; cv=none; b=bDDkmJe4zkavJiSpW/IYmeP6KYgQC3K0Aj9v+RferkiL6OQBNrmxSezX1uyJa5pbx20duHbtXK6g47oPI0zDQR4u5S5OltfNYiepR0nYBBkC19cGYm6TZL3iWWiSuTYPgS4r143pxUnEWNMykYNm0TH2uPpX9Xhsvdy4QWGeyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168768; c=relaxed/simple;
	bh=TJafEwdeqjrP6AcWhb1FzDP3OG9jHCSl2xxI4+oU+mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lX/9wojYAxp898gZVQHuGCZ4ZF6PSypA/X7avTkY8WDIc2xCndHsCJG7WKroUKJd5LAPrfCnY26mc3echcBF6kBihO4jyBb6auGAUMpIr/GbZQWxknx7TRHhlH5WL1JO+Z0ADVQuhOTd4RNKxgkkxi7Bna1xgs7FRvfqoi21C3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qxh10uLo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad257009e81so415850366b.2
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747168763; x=1747773563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=juaG+AmbI9q0dBfqd6nXXGHR850jBoYkaw6Nn2riiLQ=;
        b=qxh10uLou2liPYrjhRdGO49UtHX0NddfD1TQHCHbGtV4qCPdcI3mjBvkViefvG0VCV
         AFLxZcsjpJvvlbbBks/vInrzhUNrpO2Io3NJhQZh4LkkpRohhG9a7Owy7bLS7B2WPiu7
         JZEIlIU82tds8XglWR5YrheljfjzxF3845v7YyaVCqCWzyVw3EKVVMrkrgsOwbj8YVYq
         KLoQWnevSX0bS4k8gNnPGF54IsmMUdXo2lB3KEETlbOWi/oC9V5cNe3X57ovaYyEa6r2
         uI4TDda9IUMSuDxvgvU/lbvqENHk3NWEL6Xd11T9OOI3a/ZQUXbmfV5mRTX4O0nNk406
         HlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747168763; x=1747773563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juaG+AmbI9q0dBfqd6nXXGHR850jBoYkaw6Nn2riiLQ=;
        b=DXV9Gx7/VPOK4GxWT7uoAK+UAh+6zzMA7OYMflwz9c3VKc0ZnHLf9Sa3kftUqRH1Zg
         oejzb4ZojGv7dLi5DsCPEmWBemQ6u97uEREAAGg7suRs24xNvy9rcRsIcP1QNIC9LGBO
         soOCjqB4Lg8leklFfjPxLFaIZMDXyS0IEaIBqfX6AvJ5HZiFgbkA0vcXoX1hO4xQJS/c
         xBxWmgviq0m5veAC8dvMs42ZKZUWfiXi0sCH+JIjYE1CklkAgWV9ATUkCrZpU2luQx/Y
         kznVD673PqoORuvGE41RjNoRy6HuQpafZXtG5aNrHYB816Qi2zrxXRXkiy6b6bY/Zlux
         +BiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbxxJC00e7gIT488ns0BC/yd80ol7M4KNU1ytF4irNbWTzOQNA1NG7tRkwlq/NHogeNEFt5HiKJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVn1/h2iBVFnhQ1tD6KAHuCFCYqrcDXHctL4z1Qz1r2ukQiJG
	W/OKeXSsFLcbtNMFWldwGzw+8z/iiyBEf+pJtEnbhViDaN7Bh0kvR1h6zoZuHnM=
X-Gm-Gg: ASbGnct8JR4pSiKtf6T+ms5ymICZVCMfjZ/nBmvAnpxO6VSQQdDeotv/l31Vdwq+1xT
	jgX15NCE+fk4FoWQehFYcBSBom6VaEt7PFF89+p45EfCvgapkCahhtFa9s6Q9i+vD7JDOsBP4/v
	D+iw4olimy11tI8u0dG2wmbHd3EcCZCuAUWCerfkqYqid9CkclQ4jYYhasxTp0FKC+N+DLNozdB
	iTYbX6K2C+Ul4yZSE68n4Pr58MU8NHzhFSdjuEscYQIsYtUDWAsWARaD64JEBK/5Pe9rtHn+fzH
	RpE1jraTWxdme856IqhbReDyZWmqmNNAZ0CMizeVQ2B59gU1Y7NV7H12
X-Google-Smtp-Source: AGHT+IEWi0WXmXZATUkUPYXouuDIbFY4Wie5OHgl0qQme2z1Ey//pJl2AcKhRMhJ30qxF29lDPOGiA==
X-Received: by 2002:a17:907:7f93:b0:aca:d5a1:c324 with SMTP id a640c23a62f3a-ad4f6f2d088mr92332366b.0.1747168763600;
        Tue, 13 May 2025 13:39:23 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad2417f2341sm558309166b.19.2025.05.13.13.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 13:39:22 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions
Date: Tue, 13 May 2025 22:39:02 +0200
Message-ID: <20250513203908.205060-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4304; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=TJafEwdeqjrP6AcWhb1FzDP3OG9jHCSl2xxI4+oU+mY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoI63sY58Twokv5DGNH6EVESTwuHi9qJrQuljDW 0TZ/o6436uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaCOt7AAKCRCPgPtYfRL+ ThdmCACTnKilk91CPrcwCCc8E6w6Qkeu1s7JX1d7nbxmop8SKujh1EkNmq3VZsh6Jmr/lrNMsq0 TFJEt8AsI9PDKE8pgk/O0HnavuU+wFSXMqkXvfho7F/bZ3AH0YqB6FzcVQTq2SdjR/fdfYedDAN xq5za9VcjV9tJsNETgJBu4lk1F34qD5+EMsTcWU3zInCUMoiJjsvox/8DV/olg3mWnNDgbiZPbr 6FfbQaBKYIais3/ScGfPoThGaKJgqhNGJur1JjCHlG4tuO44gtIcd4lMg5gDiiuj+ox/6MqCxUy Q6n84JggAIId8OQOhKXPjNL9k8hlNKcF5kcVyRqNgrwaAkO/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use devm allocators for enabling the bus clock and
clk_rate_exclusive_get(). This simplifies error handling and the remove
callback.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

On Wed, May 14, 2025 at 01:25:51AM +0900, Chanwoo Choi wrote in the
thread at
https://lore.kernel.org/linux-pm/CAGTfZH2uk-6-R5QNZwsssQ1UtnqexKeo=e=SsXB26NMwqf8c9g@mail.gmail.com:
> Instead of fix-up patch, I'd like you to send the v2 of patch[1].
> [1] https://patchwork.kernel.org/project/linux-pm/patch/20241111112237.336310-2-u.kleine-koenig@baylibre.com/

Ah, then I misunderstood. Here comes the requested v2. The changes since
(implicit) v1 are:

 - Fix the build failure that I introduced by forgetting to add the dev
   parameter to devm_clk_rate_exclusive_get(dev, priv->clk_mbus);

 - Added the Reviewed-by tag for Chen-Yu.

 - Actually compile tested. I would have sworn I did that for v1
   already, but that is proven to be a perjury now. Don't know how that
   slipped through.

Best regards and again sorry for the mess
Uwe

 drivers/devfreq/sun8i-a33-mbus.c | 38 ++++++++------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index 7c6ae91ede1f..4bd5657558d6 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -360,7 +360,7 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->reg_mbus))
 		return PTR_ERR(priv->reg_mbus);
 
-	priv->clk_bus = devm_clk_get(dev, "bus");
+	priv->clk_bus = devm_clk_get_enabled(dev, "bus");
 	if (IS_ERR(priv->clk_bus))
 		return dev_err_probe(dev, PTR_ERR(priv->clk_bus),
 				     "failed to get bus clock\n");
@@ -375,24 +375,15 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
 				     "failed to get mbus clock\n");
 
-	ret = clk_prepare_enable(priv->clk_bus);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to enable bus clock\n");
-
 	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_dram);
-	if (ret) {
-		err = "failed to lock dram clock rate\n";
-		goto err_disable_bus;
-	}
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk_dram);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to lock dram clock rate\n");
 
 	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_mbus);
-	if (ret) {
-		err = "failed to lock mbus clock rate\n";
-		goto err_unlock_dram;
-	}
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to lock mbus clock rate\n");
 
 	priv->gov_data.upthreshold	= 10;
 	priv->gov_data.downdifferential	=  5;
@@ -405,10 +396,8 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	priv->profile.max_state		= max_state;
 
 	ret = devm_pm_opp_set_clkname(dev, "dram");
-	if (ret) {
-		err = "failed to add OPP table\n";
-		goto err_unlock_mbus;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add OPP table\n");
 
 	base_freq = clk_get_rate(clk_get_parent(priv->clk_dram));
 	for (i = 0; i < max_state; ++i) {
@@ -448,12 +437,6 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 
 err_remove_opps:
 	dev_pm_opp_remove_all_dynamic(dev);
-err_unlock_mbus:
-	clk_rate_exclusive_put(priv->clk_mbus);
-err_unlock_dram:
-	clk_rate_exclusive_put(priv->clk_dram);
-err_disable_bus:
-	clk_disable_unprepare(priv->clk_bus);
 
 	return dev_err_probe(dev, ret, err);
 }
@@ -472,9 +455,6 @@ static void sun8i_a33_mbus_remove(struct platform_device *pdev)
 		dev_warn(dev, "failed to restore DRAM frequency: %d\n", ret);
 
 	dev_pm_opp_remove_all_dynamic(dev);
-	clk_rate_exclusive_put(priv->clk_mbus);
-	clk_rate_exclusive_put(priv->clk_dram);
-	clk_disable_unprepare(priv->clk_bus);
 }
 
 static const struct sun8i_a33_mbus_variant sun50i_a64_mbus = {

base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.47.2


