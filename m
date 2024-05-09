Return-Path: <linux-pm+bounces-7677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C38C0BAA
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 08:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43721C2247F
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D31272B7;
	Thu,  9 May 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDUPRgcS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7717C0AB;
	Thu,  9 May 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237298; cv=none; b=GnGm8bxVnIVA5MoVO5ulLLC0vmPJbjOrAZ+aVRUALS9noyU2olab+akVCuENOWCxgVc87K3/UKWFIdk5z8LzfwXIrTKVSinilSop/QnjCcLAC70rPwHcgFeKXo3L8Pm1Knb1DJXmeoKm2Vlc0JxdnIYVOmrYV1SloeaSKumq6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237298; c=relaxed/simple;
	bh=9fO7Sh5EZvY64yUxjL2+G14A1JjtaSjuLrIZNlIVsr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6lpEtuKora+trukyx/sk8HmAzMjr+9Cl06UGXp0fXVe6o1nhKWHr3F4pk3al2Lnm4E9EDBHp3I+s3UeIVaDJrPZyZFpdCue0Thoxh4hrWDRz1HHrvP7UIIqM/Toazb5ETJ53+uyw0Sopr18GZbJr/v00J4xNCCNMBSyf1g0OD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDUPRgcS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eeabda8590so3728975ad.0;
        Wed, 08 May 2024 23:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715237296; x=1715842096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZJ/qPvhWmaN0bPAlkl54j0+0U9B8BSbeBplUAy1OJA=;
        b=CDUPRgcSqfh3fEqXSLLVUrtUUgLjvBBTDLKpN2V3AcO58FV7Fs7YVVUUPffa/DGohX
         OsOQvKtbtnJx35xexgZqyXx/idaJvE9jhcETVo1NRc9jCZZdHWlCOCFTSpEVGPU9aAMO
         /JU+5AKMUiYE3YOM7lcunrP3EffMdPJZgIOkHYTX0jKwSm8di5GJ6hsPsEUWdbtP138G
         TWfIj0KAzRWZgwrndxjGu4XBPsH53zzXobYktTmKmrHH6U7aIfOXkN7IeRRJUpWyl9iS
         viSX6fbWp7VV7FkI3XfUEmfAtOV7fBag7RLLUhRNu0JXUKzpov350hQnbTKMEykvK9qZ
         IbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237296; x=1715842096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZJ/qPvhWmaN0bPAlkl54j0+0U9B8BSbeBplUAy1OJA=;
        b=RPlE8r6gwbd9p7ojpXEf62NTXJNHX5u269y6krgF8Zmymtu+JPBIGafMdaA2o6YA8i
         B+XGtYd1nlj6YLwxSTRrfuWtWWx+ZFeA9ZWg3QW1+4ODZzWOqb0v2APb9ja5Z2uusr6C
         /KKQbFaQg1B6tRJT4NpUBpC527ASm675k19rHNuWvQNI8eZmNQqKn7WBnnS1RPJUUjGk
         r7dDIARcMsyhmurUrh2VKxDKaUcgI8OarU7b7oL2Wunn8OuytAR49Dec6IH60sSDBPeo
         jhULk8AnEeaRj0F+qmn+F1xcNxEkWcV4XMUpMNqxCnZ6Qkzq4t0wG5ilf61f+9+3jd0F
         zCPg==
X-Forwarded-Encrypted: i=1; AJvYcCVxdCf47EIElc2egvPLHXosQiToi70pCQdoDq5JjmdgkaiX6N6Dj5pfRfuMS84l5BpFx85EBAxsyBFWXzNdefSuOjhx6uoOT8Rnj/OjtIUFVpIhYnMe03ZhxjL1q5rvnsS9dLTuwHMirBuEasAX6IZRkljx1gDT5osqFuYRzd4+18IJmbCUR38OPg==
X-Gm-Message-State: AOJu0YwH+YhL+gh7uZTZ/fE8ZcI+vH0xEFf2MNaSubJJ4Bcy8pfgFY8c
	gH3yr/ZwWgA3mhPAP1wWpkON5Oq0lmUR1RvYyUR3AJNyTGONTqST
X-Google-Smtp-Source: AGHT+IHuANNmgdYBKLvlqBD4TQvuUL2BgBfhsM6ZChKBoBdTPu/89MPDHwGCEaMcOqarwXUh+xlqsw==
X-Received: by 2002:a17:903:2451:b0:1eb:57a9:53f1 with SMTP id d9443c01a7336-1eeb03a56a8mr59339955ad.1.1715237295838;
        Wed, 08 May 2024 23:48:15 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31da2sm6685885ad.165.2024.05.08.23.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:48:15 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers
Date: Thu,  9 May 2024 12:17:48 +0530
Message-ID: <20240509064754.10082-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V4 - wrap up the error messagee within 80 char
v3 - No change
v2 - No change
---
 drivers/devfreq/exynos-bus.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 00118580905a..7d06c476d8e9 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 	dev_pm_opp_put_regulators(bus->opp_token);
 }
 
@@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 }
 
 static int exynos_bus_parent_parse_of(struct device_node *np,
@@ -247,23 +245,16 @@ static int exynos_bus_parse_of(struct device_node *np,
 	int ret;
 
 	/* Get the clock to provide each bus with source clock */
-	bus->clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(bus->clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(bus->clk);
-	}
-
-	ret = clk_prepare_enable(bus->clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to get enable clock\n");
-		return ret;
-	}
+	bus->clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(bus->clk))
+		return dev_err_probe(dev, PTR_ERR(bus->clk),
+				"failed to get bus clock\n");
 
 	/* Get the freq and voltage from OPP table to scale the bus freq */
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to get OPP table\n");
-		goto err_clk;
+		return ret;
 	}
 
 	rate = clk_get_rate(bus->clk);
@@ -281,8 +272,6 @@ static int exynos_bus_parse_of(struct device_node *np,
 
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
-err_clk:
-	clk_disable_unprepare(bus->clk);
 
 	return ret;
 }
@@ -453,7 +442,6 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 err:
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 err_reg:
 	dev_pm_opp_put_regulators(bus->opp_token);
 
-- 
2.44.0


