Return-Path: <linux-pm+bounces-29625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2709AEA93E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0FF643AD5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDA2701BF;
	Thu, 26 Jun 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9bfy5sZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BF2641C6;
	Thu, 26 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975188; cv=none; b=LKWghVVcJ0d3bMmTP+yo8D8Wa8ki1GfNP8i85ekhoyqOTJUWsdBEtlDewmOmMI4lUqbdn2aWHPOIUnyNdt65mfiEpsSUsP48gUQyOgc2HCs1rktyyO4JH9EJO+5Ie4oRLcY/aljIJhzxVtzWpthYNz5fEPQURpgfvvdFYBbsBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975188; c=relaxed/simple;
	bh=k3zq9pu7WuH1hHhTGsaYg2LsWiWO/Oz0cFzLmODzdr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojshfQSUHC2a9urx9yKZEfpczFDX3JF09V2Aq+Jh1gnb2goo0scjd4onb++yZGbs+rPhhTbyngxspNgP6AE5Bu5O+kRSsflpDrTLrNMaEDAkoeiwB0puDqmE4ES86BTGTBpVZHldGjNwg/dEkga+Vwn8TgJxgZ34M8BhZVwbKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9bfy5sZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236377f00easo20280075ad.1;
        Thu, 26 Jun 2025 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750975186; x=1751579986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AuC+j/+IsbYylelRyqiT00La77hywMse6Qq0j4Ebms=;
        b=f9bfy5sZpywrFisyrSTR/Mh9L6RME5TBYK3c83V4ssSmcT6RxHv0CnscFtB8WrQ3st
         6Q8A0JtameGNQ/eRkRHzvw9dE7QFo1PAbwhykj+OyhUrL99eXtBVMZX9nThyET9JrhQE
         niBobz/4KH3HHyp3Ns/+28wsi2cmwXGBnjVow1bgODv030462lIHVWTyw2YKUk8wYdkS
         ikkRJPDxTd2jKBrKqkqCHa1+LUnNCOtifCy4JqAonpMBX58Gz6T4roX7zS12Mr6txZ7z
         D6NOh9jQn7J9Mo6ETVvgFbU9ZHW9tunz8MvRpqqpgRiXuDQaTmwko5/3I5t8X8A/5lLV
         oeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750975186; x=1751579986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AuC+j/+IsbYylelRyqiT00La77hywMse6Qq0j4Ebms=;
        b=TmZlwg4sQXz9GQ1cPsJMUdE9HAvu2PVNKrknzuIPEqNS4GuzcxYyqggk9ax31Ml4eH
         pEfRkRd8r6dOdmC0l1Ta9QdZQ58rRdlbZc503QC12a9q4Yj/j53TZmWqVFKsimASyzBe
         LpOBsycLPXrcSF1H66hEKmJFMq1XcCpc4jBfw/8pycBDekkfjBlxO+YdzzQ6T+1SLC/v
         bImfoS6/DuPVLJCJPadJIqQqHqUkCKHyBeNAYpuaQEhsCRXoQCUX+MVoOtkihSfrLOWv
         6E8nJae2RoTuCdJFOZef0zozuPM9LXa+K/0GAhNFGjllEbBXt2TnNmmndRpyHRtYivP6
         B7CA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eRrkgcNBSaJYnZDVYYeA0MtBkQichyccITD3bsFNJAUKeELJKxSw7uioSH84+uS/4Tg7uPQk6qi/YjY=@vger.kernel.org, AJvYcCUrao/1R7y9H9gOWQEEDY2HYBka0/YvqQwu9aSZf9RTCk05zEa4e2UGCnu+jHvoIFuNWTMyc84jC7Xb+ywZnmEGTA==@vger.kernel.org, AJvYcCVg38EvGxgsB6sF8emFoc3vG4dHCzO8tI8Pst1UvPhISAgJoXbjpctlVKFzJBqd3E+CiyqAC5TnMkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiA/BOpim/Ste2WNho3NQrVPs03Ndxc7qk2i6et7gq5GnLn3oO
	vb8qrqo2pfxniIfUCVx20KPzqU0Bxsn7SHg9mluiSVU+TdUyzH9frVYf
X-Gm-Gg: ASbGnctpa+6vBLQQCAatNK0fg7KCoqdHXz7YRQwCtbBysG0p6/aLm1PXwEj2y3AZBlK
	DzNGXMH4RWDzxN95mmQeCs8b0zZ9fd2pb6Y1v+qsozucOih36sFqv4NbZY6OoVp/mSFYOTcB2Zf
	y56fGgdlHoHbIZzVtLVaT+fwKdewhB2hdBjJmq4R6fwZZIZnF36lgFId4mD5q283JeQnQB3IkqA
	ac5s2zNLvP1h/sa/PdS//zn1J2qpOEfRNgeROccMIqHq9otJVFMv5RZbjj95Oc1c6FQ/E6QTkGa
	RMYDakTbaam+ruOzjZX0L5m3ZNQXXryG37LWfi3aH1t4JPTylBtH6JoiYbHL2s1QWgOjlPhDLcm
	JAV0=
X-Google-Smtp-Source: AGHT+IHYm6yWXmePXx+iACWxwFDVihZU8YA/nUsAgOctnIRwFpQL3m8bnSqHAPDOWVIimwF958Hqrw==
X-Received: by 2002:a17:903:19ce:b0:236:6f5f:caa9 with SMTP id d9443c01a7336-23ac4605d7cmr12135545ad.32.1750975186333;
        Thu, 26 Jun 2025 14:59:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b8b9sm585275ad.118.2025.06.26.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:59:45 -0700 (PDT)
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
Subject: [PATCH v6 3/3] remoteproc: imx_rproc: detect and attach to pre-booted remote cores
Date: Thu, 26 Jun 2025 18:59:11 -0300
Message-Id: <20250626215911.5992-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626215911.5992-1-hiagofranco@gmail.com>
References: <20250626215911.5992-1-hiagofranco@gmail.com>
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
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
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


