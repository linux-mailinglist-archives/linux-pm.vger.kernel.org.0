Return-Path: <linux-pm+bounces-27966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242EACAED8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83381BA1369
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22BF221FAD;
	Mon,  2 Jun 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLEKDtlr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B522068E;
	Mon,  2 Jun 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870404; cv=none; b=u0/c6EvkYu00sOj1qbsmzVaciAvhDtdEcS6ZIlU52e8+FG4qRrGe3knxeQ2uNjroYgCisoZUW24m7ZUXbzq9Naw7GL9ZLU55JWDvHuzB5y/HDLj+uFkrfBeCp3a3kV+5PQUNbpWo0x+KXkHdk2KGCtzub7/B0eVYxnztsDDhpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870404; c=relaxed/simple;
	bh=kWoyBBVAR9Ha1I3eVXr883D+sm5esK1y5bluwlJLzPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7Tvr/VPZMVh8jY/ZkWQ8dJBRv4H1TAEQ6MT2U8I8SZFFCbNmeOyzn4sx+NRT/1DdVINMm1uASJwaeNmqM8QFnZN/xDJ9jWxsLA5xXEthyvtndZHGy40dE8yY9dRRgsK1IpimyqMfSU8uQmsmFYJFV3K08EcPMRfH1M8QWt8CVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLEKDtlr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so3129033a91.1;
        Mon, 02 Jun 2025 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748870402; x=1749475202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhKP5iYORRYNLEnbf33EP9epGoMRKymXdxcO+qLp2CY=;
        b=LLEKDtlrBqfa+3v6+COKWMroTzEVNCzNF9mAGBKQhjgP912z9I2GVgijbKYPM8VErF
         5y0W0L8U0yoGyikwp/mJ2zCZ+OLSAmezILaIeITLoyBz9Igyd6uZsNwnXAf1Xt05JG2j
         gWJXux2JYDcXbOQNqK24UeS3stIzANx8yffbfdf/LwBLZjLTMl/YqHBOiUD2HXLT4Ehp
         zwCThO7q8cODxr7a8IpwW4w0ZO2os7QGgAvrNg0ab5Y9bq5z7AM8eKS9MLgQWyuv9bBN
         3HuqYiPBcG2Wes9FSTfsXqqjHDZ4QP5KgXTt4OlNQD6kwXIJx/1Ny8ZOUHXVGhMx0ADK
         L0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870402; x=1749475202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhKP5iYORRYNLEnbf33EP9epGoMRKymXdxcO+qLp2CY=;
        b=eCDrGdDuqEYnkc/dRdopYm/Pp9A1bB0oKjGgqJPNAn0kegDpe/ksRNl3xocDGohHuq
         9Oe8zp2mAaxZgzZ+ICmK0sin476NVJozzo/Tb4xjX2Ab0akks2x0Y6rzDgycKn5dp+Jq
         q9CnHO0//FpCnciGsCZfRZfm+l0nlnJnr2Siurwvri3izHYhk0uQumpyjuNANN+VjJEw
         t3YoLT5IHCJsrRV/YGfDnWblUIx1sBDo+1hwrR1i0BVGOynb5dd1FgrbYnrlu4507nq4
         f6r5P2NgcsDq/9DywOZ5oHmPoYMawSp9UxAh14M7KvvuHpwsrwugPDz2l7+ntO8O7kXa
         F8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUeiYaGZUdZ7g+DGOZ+czK2IjHhXhZJYrqZ8fygztSdOSYXT6xslny2XZ4mMEzuHu8fMwNEw1xKtXCM3MY=@vger.kernel.org, AJvYcCVjgGvD9yo+sHm7ZO0Ins17Byw8nByYBiEMA9lDQpy/P68g4o6auyERdWdJT+XlbVVAR7nCMLgZXG8=@vger.kernel.org, AJvYcCVyK4Nhp5ooJg9FfcVTuPRnEJvZiIlHoEmfPZZ8rRGUMe+/FBprtKiG1XhB2Bao54511fKlkccvBma58rb7DEdy2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vIJYHuwSlI9vAo5X6TJ+8dxQG53FApD7JyjCpJBklHBq1Z9P
	Ira2EN+MTa+ADDLShswJtvl0PhYM6fRhK5IqfwNeLSwgQO5aq3roWJPi
X-Gm-Gg: ASbGncviFJqpaqBGjIRpbPQQJlXXIdTB2Fii7po5RxpVif4xoSeSNcLt2VArjrKNEEr
	aZTZDqBo2SbtD7nHDK9vb1dU6MBMYGFIOt4rsJ6koHJ1NWiPGdzV0aGKNSEb8ykOyZmZJ9zhzJ1
	EaEtT0ZYF018yTPR7fgarIKYyvhGFC7mLtjqDSMWmzyj4nIb5H6Abk+ciLeLyChYdWnz20jiTdG
	WR6KCWpIoPeUTN1+2PKcSeX54dGxbH55UmvqSL1da84p5BBqHTIEOH99ESBhtluqa+USvTRGziJ
	+pd44jQaObyYQW9NYi6LfDm6N9O9VLBKCexNLnJPzykxsKMUU8Cfbm2ha/a1tKKMJTxoyj0YQw=
	=
X-Google-Smtp-Source: AGHT+IGpk0MW40KUnLGhZi6aTcs7hziCgisIwOKdVotPNVMy0bYaTAXay/v52EDp38MmY2gyBOvaiQ==
X-Received: by 2002:a17:90b:5344:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-31241e9846dmr20882041a91.33.1748870402169;
        Mon, 02 Jun 2025 06:20:02 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2b67bcsm6130983a91.8.2025.06.02.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:20:00 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>,
	daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to pre-booted remote cores
Date: Mon,  2 Jun 2025 10:19:05 -0300
Message-Id: <20250602131906.25751-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250602131906.25751-1-hiagofranco@gmail.com>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

When the remote core is started before Linux boots (e.g., by the
bootloader), the driver currently is not able to attach because it only
checks for cores running in different partitions. If the core was kicked
by the bootloader, it is in the same partition as Linux and it is
already up and running.

This adds power mode verification through dev_pm_genpd_is_on(), enabling
the driver to detect when the remote core is already running and
properly attach to it if all the power domain devices are on.

To accomplish this, we need to avoid passing any attach_data or flags to
dev_pm_domain_attach_list(), letting the platform device become a
consumer of the power domain provider. With that the current power state
of the genpds will not change, allowing the detection of the remote core
power state.

We enable and sync the device runtime PM during probe to make sure the
power domains are correctly managed when the core is controlled by the
kernel.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v4: Changed to use the new dev_pm_genpd_is_on() function instead, as
suggested by Ulf. This will now get the power status of the two remote
cores power domains to decided if imx_rpoc needs to attach or not. In
order to do that, pm_runtime_enable() and pm_runtime_get_sync() were
introduced and pd_data was removed.
v3: Unchanged.
v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
suggested.
v1: https://lore.kernel.org/lkml/20250505154849.64889-4-hiagofranco@gmail.com/
---
 drivers/remoteproc/imx_rproc.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 627e57a88db2..6f9680142704 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -18,6 +18,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
@@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 static int imx_rproc_attach_pd(struct imx_rproc *priv)
 {
 	struct device *dev = priv->dev;
-	int ret;
-	struct dev_pm_domain_attach_data pd_data = {
-		.pd_flags = PD_FLAG_DEV_LINK_ON,
-	};
+	int ret, i;
+	bool detached = true;
 
 	/*
 	 * If there is only one power-domain entry, the platform driver framework
@@ -902,7 +901,22 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
 	if (dev->pm_domain)
 		return 0;
 
-	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
+	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
+	/*
+	 * If all the power domain devices are already turned on, the remote
+	 * core is already up when the kernel booted (e.g. kicked by the
+	 * bootloader). In this case attach to it.
+	 */
+	for (i = 0; i < ret; i++) {
+		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
+			detached = false;
+			break;
+		}
+	}
+
+	if (detached)
+		priv->rproc->state = RPROC_DETACHED;
+
 	return ret < 0 ? ret : 0;
 }
 
@@ -1146,6 +1160,11 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (dcfg->method == IMX_RPROC_SCU_API) {
+		pm_runtime_enable(dev);
+		pm_runtime_get_sync(dev);
+	}
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
-- 
2.39.5


