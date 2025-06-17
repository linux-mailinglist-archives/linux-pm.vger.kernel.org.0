Return-Path: <linux-pm+bounces-28922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EC1ADDC7B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 21:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3F94A15EA
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A42ED15A;
	Tue, 17 Jun 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aznWCBlq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643972EBB9F;
	Tue, 17 Jun 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188974; cv=none; b=jajKb+2O04y6a0FjnyeFlKVPod+uYLrG7Tm00UlVHY+4/ZE7uXcIS5uosOS71xGqXpsOZsHNBLpZjs+fGeGO8x9BQ6f8hzdm3p84sY84QplhcZ0epQWguvjAWJl/Du+EDlgvaLsscyhsdRATAt2ImS9+uXnAD8Vsu/coEFDNrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188974; c=relaxed/simple;
	bh=fiKFmvWMLDxz/CfyNaXTHlbGkJloAVbfV0MGXrNa5X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXuNvzLVLQP2llV6gcffcUJTl9bdBufoCoJVodHAGNF7o3fdi7mU7sJtFjO86Z/uw1x8EYn0tIvtEQRFZZEsh5UOVfnOlPQPP85nyslU54+DMqG0hQFOAv2aSnWrVTU0iHoVFS0amoZEZnt/5+tzQ7wip87aK2C6xoxXXY7PLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aznWCBlq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b1396171fb1so3819301a12.2;
        Tue, 17 Jun 2025 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188973; x=1750793773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r2c8EaAsxVPli8mnl+dP2Lkz2s+hxXrFoO6K6wz64E=;
        b=aznWCBlqwlNkhwq08Spogl0CPs0vf8tWECc9y415lXULbsWTPoM9SjycwZDPlGLWpi
         Hzt6SNUzCPIts1kPuxXBx3KRgXjWoqr6TBl25ic0BCjVQ1YDwbXuS2cfpEYQJsZan8s+
         CI2uxLjV7Cx2mgn2z9zgeFq3yxPOvHH08Dvs1D2Ow5zalyHe73+8z3CUlOpx6a8diRBF
         NSmMmveugCyiOSn23PggKbfzGYr83Mk1PWTFN9IYAOMU+iabBjB29CYmYt4WWaxjVU1o
         9SEDRZce7+yCnOJi7urh/vX/dqF6BOpXH/APM0YFjKUlS97mYhET++R388XmhZqYX7Z2
         afZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188973; x=1750793773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r2c8EaAsxVPli8mnl+dP2Lkz2s+hxXrFoO6K6wz64E=;
        b=acj7R5nlHOtfVussK/J4Fg9iK7H23zOSbTS1hpWUozUC6oFTf8QAv3cF8gBVJYeiDv
         WIvNoFHSbDGe8R2pNJw4sbZTxGRUKEtGzJIx1AZVXZma1ejQtisPyhIl4u5fREqPMElD
         Coo2uvZ9tVGi2dj+osVJInRySJktjgJdV5KwDhbKkx50KzUBGnuz7xzTKwqntHyOjY0V
         etkalw5FbtsnyBtAFUYwOWu+7NLWjCWLrxTn8kdJuWpirSuAgL4g7mlUzYlXhdyOsIoQ
         u7UKFchScg4EfNRWN4uWN7AISOxCmwwsSjl8WrGtPhxFF4N/SJEPSis2lynhqUxAdylF
         xySQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZp7fzyHEDUpl+ikomUvZjxtHlr4PS5K19rafbeeYIw6CupLpYrh+hC+lgtFD0I/G86eHjVLMLkE=@vger.kernel.org, AJvYcCVfHqsjvJhqOejIsom5mUL/mIAJq27z7l4CIOFo2CcspSX8gqA8G/N+uBOL68P0Hp3JzKCnKK3BMOtLh0M=@vger.kernel.org, AJvYcCWQOLSsvL9u7kfY3XoyTlgKHoIT2MsxdH8jjxkvJ84CRBCz1lQcx6vOz4yl3iZWlORH+sCehm5sL/+N3KoqNH2iog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xVRT7QtMf/5vS8DqKDuotuuz9W0111YjsX1Rr5N9bssZFQw7
	zwCQYAJOooKTIHghUjh8uh5VC1CMeEA60XaUssvjY3a7LNipn3PLmo28
X-Gm-Gg: ASbGncv//ioIYuoHy8cV1ApMq6Ua65cCkxsK6exrtZDPQuczT56O7Z4bzvPwrolkvxy
	8mAhqwjicDoOD54jitjJ+/wrBPbfOLyrvA2jvLBQ6OMQwP8VowOtUiOz1qPTgl65U+mMwYWHN0A
	HNBJ9tFAkFc4Dti73/2QTuIkx/cAv/xrgZxUBSGZwLQ3dQv/ixH0dwtR962BmHYbi/agURfN8pY
	3x3IjfU5QpGcpNcaDWerVJW0p6+vmTEsquVFWMJXvoyoKImGbM3LjuXLApF0QBGzIVmy3LfrqYc
	Tff1faucwGS1xIVzkACUs5xVlIxyHPlkDYDPsN1+fmx+ELBkc/hyYio8mkNF8b2OV8aT8DOUig+
	kb3d/9Zqs
X-Google-Smtp-Source: AGHT+IEcTxTFfNUX47ya/EUrbwJwh97FMbsvWdj3uruF5I0lImwMUF7tir/4Fz62IdKM4n1FplyKAQ==
X-Received: by 2002:a05:6a00:14c2:b0:742:a77b:8bc with SMTP id d2e1a72fcca58-7489ce0cd46mr19370746b3a.2.1750188972450;
        Tue, 17 Jun 2025 12:36:12 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d7340sm9648582b3a.179.2025.06.17.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:36:11 -0700 (PDT)
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
Subject: [PATCH v5 3/3] remoteproc: imx_rproc: detect and attach to pre-booted remote cores
Date: Tue, 17 Jun 2025 16:34:50 -0300
Message-Id: <20250617193450.183889-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617193450.183889-1-hiagofranco@gmail.com>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
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
index 627e57a88db2..b53083f2553e 100644
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


