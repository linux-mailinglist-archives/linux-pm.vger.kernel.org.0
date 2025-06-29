Return-Path: <linux-pm+bounces-29805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F60EAECF30
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 19:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D95918966C8
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5281F239585;
	Sun, 29 Jun 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebHmg64/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BE238D57;
	Sun, 29 Jun 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217951; cv=none; b=iVR+sFm4cVGxBxzZyZmz+YiqksSUg6d5Y+g9lZvAVGnc4urYVBm9RriCg3DarR9aaALjbbndPSuAhZxVkt+qn7CIcKBKXJRwXXL7mHPOERrAMvoHFx+hhPHJ7sZKZ2Yf/R6h18FiEABKUzxKJINH+zGh0mubn1VIOCih3Wnl6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217951; c=relaxed/simple;
	bh=dX5CgCff38oCxVYrv1myAPN8VV6/co07Gu9nbEQT2ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfYxJdcz5jraFbjMx/kDjUHEHK1XRxN/e1O7WS2QtD28aPPSm4kOirVTRkWXI1DB0BKidPQmvySMsOloBOuFRzG0sl8Xy86mWrc0RuDv1Y4aqCwe2wpbJH0ZKhBYIPR2AhJdI8DG3FvmM1Om3a4cxpxoRUbd/wbpyCBN2gc9BII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebHmg64/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a818ed5b51so1825011cf.1;
        Sun, 29 Jun 2025 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751217948; x=1751822748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC9iUQpNk2KWt1DZhVabqrPCsFfxqA98Z3a6X4JvyBM=;
        b=ebHmg64/Hx8o5Q46lfBuqitsGPMhQK1A4ZNTeO68+qZSP4h/DAPRsqm7isITBySEjw
         idSE3xFvpjvToM/clc1y4Sq25aKGewRIiM+D69YHsDgDosLSsmi3t+n80CYqPi+j2fci
         1R7Oj+tKyr7gzFH9oBJxMlcDdYBlmhXVO/1F4q5+KJl9PKWR4mndqAJYspiCrL2escLA
         CbI7dyKXUplnaF/S4IiHfei6KbM2Ih1QfxiTem6eCM0io1zwTLlCaUEBIYauTvv4kqAR
         hwFJg4j4eJuLqA94/2Tystao86FG9arT3WI2Xs6VeLa6mMPtuX1zHoQxXYZKvN4HYgEh
         2OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751217948; x=1751822748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC9iUQpNk2KWt1DZhVabqrPCsFfxqA98Z3a6X4JvyBM=;
        b=jzFuaDuLZFyWry7XVaWQuA03tesf6vKwBgaJ+uplsEh5zf6zfMQHV2eyRQ/vEOGW12
         pppSSJ1iAFoc8BZA77UoQtlzwKLRPnyRBAmaMl8T1oJUA6LFGZDsuVtic5biF6c9XlST
         tFE2JLfdfFB48iFZ3nnoPBnY0Pr+jw0KTmYmyMowgotnqBi3PeOyVNMY2ug3Q1jmGP2s
         ZvvIbCB7G/ZrcqOihxpfi8tppQa13QoeGP3orYffpHIfy0ZJHisqlBFCov7UYdgFMFE7
         qqHD6OdDbzzafH8L8cyUkdSl8YNcDHLTbmkDr5D+q9Na8bgrZFnx063aY/F1rM3meQ38
         dOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVOgC8cJhFDCu2zjUNeaHG9CvKMwq4f7dqgNji6/BQ4VxtBcRbET2CZBncIE7lVwdRyh/7xUdCWirxmYg=@vger.kernel.org, AJvYcCUk8Rq8hSwGYbJUB3pM8wXjJeu1jmn/Urh2Ieyd/NSDsWczKnS+u3dKbDtkqZbEyTC1WIeOLQU+VNsXMcqAX3F3Sg==@vger.kernel.org, AJvYcCVDgCRx1n3MhgZOTzMx3z9bNuw+Ujiqn9eGGkVEvLm4hGADLvB25T3my4UwDEn9WvimN7657awrhao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwphXE4EMRiJDH/udE4n5naEfSAAxTWMFbHqlFQAnyvsEbIJjQ2
	HUoUwQMAeRVPnTLujYJdgv/Otrr84SbQxL4jJRusM3f9QapH+ZDkT0lG
X-Gm-Gg: ASbGncsESPHPln1r5Lxxa6lHH9zN3ZsjCBTPDdgM82rHQmwpa96DsgFHuwFPShh2Svp
	FgqjEFnPX5FoYWvg0NQ9BUg0D/N/KP2KY4zUt9DKX6T+8cRc87RvnGT8cKhuGD/efWG60bRCIqe
	94+Hf1cN/IsltmHrSR2AhyzuJfXrzlB5BSqqVtevPIxFzYEsq2YjYMKx+uo0P8k/bW0iKVTAMv0
	tEZulUCccf3T5lEMWqMP1LIrhghX2W2irZAYplM8+MicdjsRYP5D4g1hAzZ3xlOqUTaoz+FBqCE
	yIHJ2fqkppVb4ao4L7VQ6IHFGWUbLv4OC9H9SYSVupVyLGgUDCqMD+I8x/w/xHIodjqrqBpLW1x
	OTLI=
X-Google-Smtp-Source: AGHT+IHL+yIWTipjXDrBIV1HOTDHYJtyQk3xOUCkDv6eXNSuiH8iXZMcrL3wqtORw+/eQhaCGyQTew==
X-Received: by 2002:a05:622a:5b03:b0:4a7:6e64:a52b with SMTP id d75a77b69052e-4a804b3926dmr128171311cf.35.1751217948303;
        Sun, 29 Jun 2025 10:25:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d7dcsm45549761cf.60.2025.06.29.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 10:25:47 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v7 3/3] remoteproc: imx_rproc: detect and attach to pre-booted remote cores
Date: Sun, 29 Jun 2025 14:25:12 -0300
Message-Id: <20250629172512.14857-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629172512.14857-1-hiagofranco@gmail.com>
References: <20250629172512.14857-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

When the Cortex-M remote core is started and already running before
Linux boots (typically by the Cortex-A bootloader using a command like
bootaux), the current driver is unable to attach to it. This is because
the driver only checks for remote cores running in different SCFW
partitions. However in this case, the M-core is in the same partition as
Linux and is already powered up and running by the bootloader.

This patch adds a check using dev_pm_genpd_is_on() to verify whether the
M-core's power domains are already on. If all power domain devices are
on, the driver assumes the M-core is running and proceed to attach to
it.

To accomplish this, we need to avoid passing any attach_data or flags to
dev_pm_domain_attach_list(), allowing the platform device become a
consumer of the power domain provider without changing its current
state.

During probe, also enable and sync the device runtime PM to make sure
the power domains are correctly managed when the core is controlled by
the kernel.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v6 -> v7:
 - Added Peng reviewed-by.
v5 -> v6:
 - Commit description improved, as suggested. Added Ulf Hansson reviewed
   by. Comment on imx-rproc.c improved.
v4 -> v5:
 - pm_runtime_get_sync() removed in favor of
   pm_runtime_resume_and_get(). Now it also checks the return value of
   this function.
 - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove()
   function.
v3 -> v4:
 - Changed to use the new dev_pm_genpd_is_on() function instead, as
   suggested by Ulf. This will now get the power status of the two
   remote cores power domains to decided if imx_rpoc needs to attach or
   not. In order to do that, pm_runtime_enable() and
   pm_runtime_get_sync() were introduced and pd_data was removed.
v2 -> v3:
 - Unchanged.
v1 -> v2:
 - Dropped unecessary include. Removed the imx_rproc_is_on function, as
   suggested.
---
 drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 627e57a88db2..24597b60c5b0 100644
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
+	 * core is already powered up and running when the kernel booted (e.g.,
+	 * started by U-Boot's bootaux command). In this case attach to it.
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
 
@@ -1146,6 +1160,15 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (dcfg->method == IMX_RPROC_SCU_API) {
+		pm_runtime_enable(dev);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(dev, "pm_runtime get failed: %d\n", ret);
+			goto err_put_clk;
+		}
+	}
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
@@ -1171,6 +1194,10 @@ static void imx_rproc_remove(struct platform_device *pdev)
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct imx_rproc *priv = rproc->priv;
 
+	if (priv->dcfg->method == IMX_RPROC_SCU_API) {
+		pm_runtime_disable(priv->dev);
+		pm_runtime_put(priv->dev);
+	}
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
 	imx_rproc_put_scu(rproc);
-- 
2.39.5


