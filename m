Return-Path: <linux-pm+bounces-12504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C88957AE9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 03:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16F11C23E4A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 01:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E033FD;
	Tue, 20 Aug 2024 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAGtY0Um"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21620B657
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117187; cv=none; b=JqAaaiJyrLhDz/eqqr/WEEjieTygjc4LWhIJ1R+Sga2Zj3UeHAGtuVEkLhLTmfU5f32bnvu4oJxH4UoiQgTv81BocOA3NhyLuFlmIvaow0Hcrvgdh5QWu7+bfEu5wjXlRjzgCeTZw59AsAKT7To954yligh2XhEg/dSGktZLe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117187; c=relaxed/simple;
	bh=n0ox3inuNJY4PcPhDinLaTHitqCQE4xQYSQhy2E/Ayc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gpbmg9e3T79QMGBi5OA6PnMYkbaQjzx8V8OFjpwl8Xj+oiMrO0l2+oi+qGIs5tAjUauCDWsUUQ/RN25tOL0gx1ok8Jt2oiMWBa5K/BYJ3KdZcJwMT2PLitbUn5fpLTWMPnxH5A4gd3bTi0RZOCXsn30roSId+8xvR5Q9XdmskxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAGtY0Um; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201e2fe323aso2776785ad.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 18:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724117185; x=1724721985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayKww0j5FdJl6Q5VnO6Xfpm8usKnNXSqgVhAkZT6vlQ=;
        b=aAGtY0UmGc3C6epFVlpfgj3J9QWj7YkN6WTWc2yQ0Dz9Sxtsut7KA6VtFzyco1R4Jx
         OXKlvBDRnSApiLWHfTiSAK8AQaxvaLkDURVNAjFJGx7TQEZX+BdB2xWhKYnCpq5ZaAu2
         l1ToDK+aDbDvFN09ElrvBLxHvHJPSg+6NBrvs3KxS9M08FiiHJy6kUDBITmLRURUGO3T
         x12pM9bEG0SFx2ZL5H4/Y9CAj7q8Noyx7/MxXV8pK4stG78rqBdbnL7ec3vr25zlEg/d
         sPSRmVABrBF7OAHk8jQxzodGxzMNqLwNaf1TG3RZZxP+Xqs0hvTaUR24vOWt96kjLVUy
         d8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724117185; x=1724721985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayKww0j5FdJl6Q5VnO6Xfpm8usKnNXSqgVhAkZT6vlQ=;
        b=E4qHNkwPfapIwedQ8F5G5mYjxZggNtuCf5BMQFUsuCKww5toywE71qpXkMNt8NCkEM
         HOtVYeylvkEgafVM6uzGqOF6ncGJT3w0M79gINDN0VDlb103+sl9ew+6fXt2zsOfidTH
         RQOwPRqvw4D28xf1JjMQZteIrXckZLnXQ7+ixzbtzHpULM0N/uj2OkRhWbZB3FhpxQI7
         bukey+YjmQp30adxm1boay0cwWtiNeYtMYOzK5Vr/QNiYv3kzlUdBBngB8h9apZutvLO
         61VKXfUMcFTZHOyWEoEFFCNuptY1r5tedQi195NXemg5PKwaZSacIL49v12SwSG7Hob5
         NY+A==
X-Forwarded-Encrypted: i=1; AJvYcCWs8/+4AGv7honFJi43ohaXrQ5F0zM257bj1vMciJe0Pla/ULOrcuWkYvsP+a+uswz1FaOC8mm8SfU8K8vDTCRRFb16+MavIjo=
X-Gm-Message-State: AOJu0Ywv8TsMY77z1iAxRzIvEwtxmTI/pbt2qUw7K2FgkhtiTzNFFbwc
	kl0ko11dAgLtGSzdsh+9casa+/Olkc4X+pOD6z2LgeL9Mbpq4JJA
X-Google-Smtp-Source: AGHT+IGZq5FxLK2SRjoF4/bHuJHPHUkFxYTDo4gjtSTg1VWULJAOET1/ZAHgIawRZMptvNH19POjtQ==
X-Received: by 2002:a17:902:c406:b0:1fb:1ae6:6aa7 with SMTP id d9443c01a7336-202060c4774mr91705755ad.3.1724117185241;
        Mon, 19 Aug 2024 18:26:25 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9187:7fc0:77bb:926e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-202405921e6sm23193785ad.265.2024.08.19.18.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:26:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/2] thermal: imx: Remove __maybe_unused notations
Date: Mon, 19 Aug 2024 22:26:16 -0300
Message-Id: <20240820012616.1449210-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820012616.1449210-1-festevam@gmail.com>
References: <20240820012616.1449210-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with their modern
RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.

The combined usage of pm_ptr() and RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
allows the compiler to evaluate if the runtime suspend/resume() functions
are used at build time or are simply dead code.

This allows removing __maybe_unused notations from the suspend/resume()
functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None.

 drivers/thermal/imx_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 091fb30dedf3..495ff2eeb0a1 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -773,7 +773,7 @@ static void imx_thermal_remove(struct platform_device *pdev)
 	imx_thermal_unregister_legacy_cooling(data);
 }
 
-static int __maybe_unused imx_thermal_suspend(struct device *dev)
+static int imx_thermal_suspend(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -792,7 +792,7 @@ static int __maybe_unused imx_thermal_suspend(struct device *dev)
 	return pm_runtime_force_suspend(data->dev);
 }
 
-static int __maybe_unused imx_thermal_resume(struct device *dev)
+static int imx_thermal_resume(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -804,7 +804,7 @@ static int __maybe_unused imx_thermal_resume(struct device *dev)
 	return thermal_zone_device_enable(data->tz);
 }
 
-static int __maybe_unused imx_thermal_runtime_suspend(struct device *dev)
+static int imx_thermal_runtime_suspend(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	const struct thermal_soc_data *socdata = data->socdata;
@@ -826,7 +826,7 @@ static int __maybe_unused imx_thermal_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
+static int imx_thermal_runtime_resume(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	const struct thermal_soc_data *socdata = data->socdata;
@@ -857,15 +857,15 @@ static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops imx_thermal_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(imx_thermal_suspend, imx_thermal_resume)
-	SET_RUNTIME_PM_OPS(imx_thermal_runtime_suspend,
-			   imx_thermal_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(imx_thermal_suspend, imx_thermal_resume)
+	RUNTIME_PM_OPS(imx_thermal_runtime_suspend,
+		       imx_thermal_runtime_resume, NULL)
 };
 
 static struct platform_driver imx_thermal = {
 	.driver = {
 		.name	= "imx_thermal",
-		.pm	= &imx_thermal_pm_ops,
+		.pm	= pm_ptr(&imx_thermal_pm_ops),
 		.of_match_table = of_imx_thermal_match,
 	},
 	.probe		= imx_thermal_probe,
-- 
2.34.1


