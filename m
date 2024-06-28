Return-Path: <linux-pm+bounces-10162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A991B6E9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 08:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EF71C228F4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 06:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393834D8A5;
	Fri, 28 Jun 2024 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pR09LNDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A48208AD
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555598; cv=none; b=qncwpgxF9COS7i0qovneb2OJB4N3qYM2VjLMOGOlvE7/mVWPhp+o8hpnACb4u6jyrS6H9pgHvKyfcEQUHemRVrH9owGuWgWVUdhQ5YE5U7+ePK9MSwIm7WTFZbrMIC+8vmQLLwGsocUt3jC6Nm1rCj8FGf95t52Z9VWpKDRSVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555598; c=relaxed/simple;
	bh=MuQ95BaMaeZwU8yA90MkErGZw2uB+AK7NPDyeRPhKOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnnNU4Ki3hVrZlc4HKm8ygrMZYS7bS/BmjxoSWXki8IBjf6Ztv99GDhjJKqH4navsx+bK0KS/dxJ/gVL5NXUOGWzEnEA9xgVWRm5oBBgYjrI0TqSTgTfqVyZ3zbvfedlaWZDVjmQXx1R9w4RZS5eM6cDKAXmJMSBJHXdbP49WsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pR09LNDS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a725041ad74so7743766b.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719555592; x=1720160392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWv0w8vAo8GiD/pB2lZc+Ffji376dYRZbqdwsEaIfbQ=;
        b=pR09LNDSTtgTbV+mFqiA4zLA2EKIsauwSnU8CvwpE1qPLXe4ES4rOecJufnCAY5UHM
         SU6nEd+sg83KAtsirxP47kgjPJ685QBPHYa+6t9mX4GkbtQwMaWTm3COtfotY+NP38La
         H+9jLKossNgpyppm3iQS+NQQS8vX1McVCBgS1cW3JnFU9vTcq3ZaKO7ToyohNeGuVJ8o
         TOkCXg/7haagRxfpbThh9+xYik4oVZZN0OQzYq8ull8+AJEWc4EB1Xo9CQrrGO7oMIpv
         hm0gJNFTlb7SZtD6vwdkemNTEjpyf1DF0ePuaEysxe4neag665cNcq/DkfBvJY5DsqHW
         8ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719555592; x=1720160392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWv0w8vAo8GiD/pB2lZc+Ffji376dYRZbqdwsEaIfbQ=;
        b=ft4HAl/vIy6KLj2HHgFLvpiDgaqKfrjUPbtdwqXzLi/qklmwTmTBw6yJ1mfcUgCejp
         EwrYLQ6b2SFqvaq1FlI2F8MfqoVuLV5nQehcOR2L7d4n60lCrZOAGkuAr7gxjxvR8fSC
         NSc3rSbbyBLe0tKe/6KXfwEreLWb21lcvhN1Qn9a0MydYubqLscadStaqlSmOROzBDPk
         Z8HN9BPXg2bCgyGf1wNZGYeR/PcD4J8boG7YYn2NibIhY1+krfV34JCPPnJpAw83Ktn4
         JcndZYG97dlRhc0hpd3uViNyHtsyqZRrVTsd55Xv+7lwjgRIxnqjE0EEQmEhlQepdCsv
         A08A==
X-Forwarded-Encrypted: i=1; AJvYcCVynbR7omje0hBjYgp411qFSmpLui9W0fJPWPRVYqkXHwPuhVdqtwzPz7esZ6xrJ8+IIJ0oxFSCq219sWthPTjnxx2MhAoU5dM=
X-Gm-Message-State: AOJu0YwVfY8U/WH+VFQTLq6PxMnSqxINUgESpBrZc1IYCbvIG1WEbZMD
	82K2SHxRYfaVaU9ny4V48zBIGSaaQ/RdMBQXQ01Sb/y+jZAbCxsfpQdyHc98/js=
X-Google-Smtp-Source: AGHT+IHiCX799TPgCKQWgWwES345tt3l93lXFbbCZ3msBgpK/jOavx2uIDkrJ8d5HKBZTDTTLFzd6g==
X-Received: by 2002:a05:6402:4305:b0:582:1a24:76d5 with SMTP id 4fb4d7f45d1cf-5821a2478bcmr10314387a12.35.1719555591823;
        Thu, 27 Jun 2024 23:19:51 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:2d35:3c3:59a:94a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf62058sm44679866b.56.2024.06.27.23.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:19:51 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] PM / devfreq: sun8i-a33-mbus: Make use of devm_ functions for clks
Date: Fri, 28 Jun 2024 08:19:28 +0200
Message-ID: <20240628061929.89273-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3340; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=MuQ95BaMaeZwU8yA90MkErGZw2uB+AK7NPDyeRPhKOY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmflXxJBwsIWEFjBvCky8FpNk4ksgkkVuXrEY6w Sy/6dNUy32JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZn5V8QAKCRCPgPtYfRL+ TggBCACHNpfkOq7N2mcNIsiVfnEg4f+B/KE7bjdhsk1mpFcA1jnEzgqhzr93uh4gsLh768Ysnn5 00pbCMbD3QLnZ8uEr4+JtcygyF4iHJ0em7JDRmEzFggPlzZ3iXkqoQ6oCeLzJGl29ZLBq4b7qOA rakWuk/xvXbS8jafWJi0GlR0aY7BeWLr5w4+/puRUIxs7RydEWLtD3yviBKLbg2aNxUBAMhcDAX lVDCL9wwmkSAmha7epVzmEjZkxnnChD+C09xXnRrgvT3Z77YemyoyCGyhcg4rFGtY4C5UYv4DpS YHC49jFWvpKFfgyjKsvbN11/v7dxreXuvNgBRsCVq6BO1OZ2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Using devm_clk_get_enabled() and devm_clk_rate_exclusive_get() allows to
simplify the error paths in .probe() and the remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/devfreq/sun8i-a33-mbus.c | 38 +++++++++-----------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index bcf654f4ff96..4c179d7ddf0b 100644
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
@@ -375,24 +375,17 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
 				     "failed to get mbus clock\n");
 
-	ret = clk_prepare_enable(priv->clk_bus);
+	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk_dram);
 	if (ret)
 		return dev_err_probe(dev, ret,
-				     "failed to enable bus clock\n");
-
-	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_dram);
-	if (ret) {
-		err = "failed to lock dram clock rate\n";
-		goto err_disable_bus;
-	}
+				     "failed to lock dram clock rate\n");
 
 	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_mbus);
-	if (ret) {
-		err = "failed to lock mbus clock rate\n";
-		goto err_unlock_dram;
-	}
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to lock mbus clock rate\n");
 
 	priv->gov_data.upthreshold	= 10;
 	priv->gov_data.downdifferential	=  5;
@@ -405,10 +398,8 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
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
@@ -448,12 +439,6 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 
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
@@ -472,9 +457,6 @@ static void sun8i_a33_mbus_remove(struct platform_device *pdev)
 		dev_warn(dev, "failed to restore DRAM frequency: %d\n", ret);
 
 	dev_pm_opp_remove_all_dynamic(dev);
-	clk_rate_exclusive_put(priv->clk_mbus);
-	clk_rate_exclusive_put(priv->clk_dram);
-	clk_disable_unprepare(priv->clk_bus);
 }
 
 static const struct sun8i_a33_mbus_variant sun50i_a64_mbus = {

base-commit: 642a16ca7994a50d7de85715996a8ce171a5bdfb
-- 
2.43.0


