Return-Path: <linux-pm+bounces-12439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F1956D30
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3AC1C22C38
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E816F850;
	Mon, 19 Aug 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6rMFDw+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285616F0CE
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077635; cv=none; b=XSOIRHfBpbDZKSnpDt1MdCQ0dEZO9ANjOlkHpkYVGZ8hSi4nzqd8es9b7NWgMmR58doM9P8uS1+n493CDZJj8hHP+IuduF4b6ZmZYirgMwPkAdNbCGnh1RE152IF1qonnNsMa1tKp7f2CZuMzyeyLO2ypaMEhU/B44pksm6q+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077635; c=relaxed/simple;
	bh=M60816ytWMrETkM6QM1L+R00UOriHG1lsiQyGY/RYpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRdk1SyY5tnSsEA9NQe5lYNe2kUB/tUqE/7sI8iRerg3juVjFux9EeXtt32GfCN4II7s82Wo7FLUpwy/7KlVWkelo3kBP6GErMNWMBYdRv+9q4C7/SF47P6N2mo1f80TbnFE8dqDwrcy6CaJQYRPpjC5oL+hNeWlEAX1LMC30KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6rMFDw+; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d32b27f57so879795ab.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724077632; x=1724682432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr8L2hcQ7Wkw+B5RpS61bkAXN4QsrXdH+Dd+Y4DXHwo=;
        b=X6rMFDw+zenvQKYBomsse0wMqvgLtQY5RvAC/lf7ZKswTx0wEJJim8aZ86K+gemUBy
         nWBnqcHaVb0mkAjzjnzPtr9hwZuV2QJ8cDFqsdPwikvAgJKcCI8JXRtyKP6V4wlD+Xq8
         TQKg49LjztFbeSJcvpuYqkI6cskToF/q6OX7NHfXmrvrmvJvvx9y0rvThu/8tag+HMGx
         cDs5mNXj3hUuglikgHRPSM3qV0cpbzumMJRPXYPWJIuDtGOpwM3UswyrWbBDdV7/z+CI
         X9wYqDaXGAcG/hjiUpT7dNjpRtey9C+WM8A4YP4n+750qDsDQlJ8qpUzdgdjoHE7uSCq
         IQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077632; x=1724682432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr8L2hcQ7Wkw+B5RpS61bkAXN4QsrXdH+Dd+Y4DXHwo=;
        b=uovWgfgQiuNxoCvBDcP+Q9jNDPwviSS2EbWCHDHJhRTpH8r2lh30nwWq5v5GUvJQF5
         TZzGih02qLIRPFE9erErVgd8CLJrymZxdR9YjXJZCpR24UUWCBlSrjMJUFEWnaQy1FiM
         H57cbR2UTE28m7BoUTJ3EXx0OW5wwOY0KHJJMQLAAuX7z9KEww7jbnglJMTeton+HXG2
         KCCNYzYA98Gw7ursUzE6T4PwlnttqK8dO+r+ieNenWgNIeBk2ufGz9iXZbXsHpCuOvtO
         ho7eqoir8KtemyuLPpi/iA5HmEqQT5LlSDZXX+MgvRsL3W3DLObJs5Y7Wr7+ja4fXGWW
         cWjA==
X-Forwarded-Encrypted: i=1; AJvYcCXJjjztIV0WU0LG1u5TkfRImjRaUBa6oTxkl3k1CO6BozoAPsCDi1aiKYTZ8yySvRBj+FKTF+cH9gRtBADvJP1ZqJK8XL9E1w0=
X-Gm-Message-State: AOJu0Yydao9vW9YmUKzY90v3qWiiKRPYXnCc9POdj6lfafE++KyI4+MM
	3Oo2UxtBjkbisxCUu+dDU/BwvNuadZxhhhJIabigzVB3qX2A4LvGmyBv3g==
X-Google-Smtp-Source: AGHT+IFUa2lk37nfyOHT3H42dXde6MkbsnYwyAmTET+4ZMf5EoWn7CIn0GOfZyJZ/ih42mzZPlR4Ww==
X-Received: by 2002:a05:6e02:1d0e:b0:39a:f126:9d86 with SMTP id e9e14a558f8ab-39d27963062mr70556245ab.0.1724077632448;
        Mon, 19 Aug 2024 07:27:12 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9187:7fc0:77bb:926e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6124sm7610565a12.27.2024.08.19.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:27:11 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] thermal: imx: Remove __maybe_unused notations
Date: Mon, 19 Aug 2024 11:27:00 -0300
Message-Id: <20240819142700.1206586-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819142700.1206586-1-festevam@gmail.com>
References: <20240819142700.1206586-1-festevam@gmail.com>
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


