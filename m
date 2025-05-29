Return-Path: <linux-pm+bounces-27822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2CAC8436
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 00:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5729E02CF
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2950221279;
	Thu, 29 May 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="llvfwWOv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843821E094
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557456; cv=none; b=s9zd6dnBKKZTKkjq4WZdFTsqQlEmypp+nNI4hStD7MjYKCXzC5wGZiS802qyOz3Wd5mFeH9VwuhQ7yZeB0q5W/3//VhR4tWHeK0t4TKFH5CeuDFnqQ1s3lMQFIprZyVfoxXU0F1Y0aW8cxVMoQsGGdq6cp5jryzcdGeYmfrLF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557456; c=relaxed/simple;
	bh=g3HrJI+i/qPWzFTH4SgOBu/2lO60y1spJ4g/6Mp0yD8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=pAsNgJkEQ8GgHu20MQ1n3Lk+uRpHtGQHRtpqeg61uLSTjeGSCkqI5xM9V1D9k2x2f9uNWKSvW0zWsLSck/gxOGng4ppt4G5xkJlUd8xu7PlJ66eDq9H6ndgv4zOt78I/Fyx9sRXelmXqH5xD2Bmb/Rc58pJiWB+/UBErV61ElRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=llvfwWOv; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222406euoutp02df6cbdb7cd378fbdb8844f293e1dd770~EH7vV2nCZ2213722137euoutp02z
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250529222406euoutp02df6cbdb7cd378fbdb8844f293e1dd770~EH7vV2nCZ2213722137euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557446;
	bh=l0+urxkDydJaXZt0i4z0eElhXfnETxRC93PMjjsxpdg=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=llvfwWOv0sO8NtmufNjuIBWK2vet2yjTAqstOr3zZg4XsoKpfav2awGlw7/jyJyXg
	 1UvbgDFg3uGtQI6nDAcTzb4a3akd2UIWHqCGMixCO5oHeGWWQ2me/ecSYRnVkLFYxH
	 RAy24GPFwLObzua/bmTej4qJg1+wIdvA3VuaPewM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1~EH7uSIjI11302113021eucas1p1A;
	Thu, 29 May 2025 22:24:05 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222404eusmtip2ba5a345a3bd699d30ca989a3242df931~EH7tZQdKj3031530315eusmtip2L;
	Thu, 29 May 2025 22:24:04 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:50 +0200
Subject: [PATCH v3 3/8] drm/imagination: Use pwrseq for TH1520 GPU power
 management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-3-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1
X-EPHeader: CA
X-CMS-RootMailID: 20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1@eucas1p1.samsung.com>

Update the Imagination PVR DRM driver to leverage the pwrseq framework
for managing the power sequence of the GPU on the T-HEAD TH1520 SoC.

In pvr_device_init(), the driver now attempts to get a handle to the
"gpu-power" sequencer target using devm_pwrseq_get(). If successful,
the responsibility for powering on and off the GPU's core clocks and
resets is delegated to the power sequencer. Consequently, the GPU
driver conditionally skips acquiring the GPU reset line if the pwrseq
handle is obtained, as the sequencer's match function will acquire it.
Clock handles are still acquired by the GPU driver for other purposes
like devfreq.

The runtime PM callbacks, pvr_power_device_resume() and
pvr_power_device_suspend(), are modified to call pwrseq_power_on() and
pwrseq_power_off() respectively when the sequencer is present.  If no
sequencer is found, the driver falls back to its existing manual clock
and reset management. A helper function,
pvr_power_off_sequence_manual(), is introduced to encapsulate the manual
power-down logic.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/Kconfig      |  1 +
 drivers/gpu/drm/imagination/pvr_device.c | 33 +++++++++++--
 drivers/gpu/drm/imagination/pvr_device.h |  6 +++
 drivers/gpu/drm/imagination/pvr_power.c  | 82 +++++++++++++++++++++-----------
 4 files changed, 89 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 3bfa2ac212dccb73c53bdc2bc259bcba636e7cfc..737ace77c4f1247c687cc1fde2f139fc2e118c50 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -11,6 +11,7 @@ config DRM_POWERVR
 	select DRM_SCHED
 	select DRM_GPUVM
 	select FW_LOADER
+  select POWER_SEQUENCING
 	help
 	  Choose this option if you have a system that has an Imagination
 	  Technologies PowerVR (Series 6 or later) or IMG GPU.
diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 8b9ba4983c4cb5bc40342fcafc4259078bc70547..19d48bbc828cf2b8dbead602e90ff88780152124 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -631,10 +632,34 @@ pvr_device_init(struct pvr_device *pvr_dev)
 	if (err)
 		return err;
 
-	/* Get the reset line for the GPU */
-	err = pvr_device_reset_init(pvr_dev);
-	if (err)
-		return err;
+	/*
+	 * Try to get a power sequencer. If successful, it will handle clocks
+	 * and resets. Otherwise, we fall back to managing them ourselves.
+	 */
+	pvr_dev->pwrseq = devm_pwrseq_get(dev, "gpu-power");
+	if (IS_ERR(pvr_dev->pwrseq)) {
+		int pwrseq_err = PTR_ERR(pvr_dev->pwrseq);
+
+		/*
+		 * If the error is -EPROBE_DEFER, it's because the
+		 * optional sequencer provider is not present
+		 * and it's safe to fall back on manual power-up.
+		 */
+		if (pwrseq_err == -EPROBE_DEFER)
+			pvr_dev->pwrseq = NULL;
+		else
+			return dev_err_probe(dev, pwrseq_err,
+					     "Failed to get power sequencer\n");
+	}
+
+	/* Get the reset line for the GPU, but since it's exclusive only
+	 * get it if the pwerseq is NULL.
+	 */
+	if (!pvr_dev->pwrseq) {
+		err = pvr_device_reset_init(pvr_dev);
+		if (err)
+			return err;
+	}
 
 	/* Explicitly power the GPU so we can access control registers before the FW is booted. */
 	err = pm_runtime_resume_and_get(dev);
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index 7cb01c38d2a9c3fc71effe789d4dfe54eddd93ee..0b6d53994d25abe32a2f1b133a4efa574e150da9 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -37,6 +37,9 @@ struct clk;
 /* Forward declaration from <linux/firmware.h>. */
 struct firmware;
 
+/* Forward declaration from <linux/pwrseq/consumer.h */
+struct pwrseq_desc;
+
 /**
  * struct pvr_gpu_id - Hardware GPU ID information for a PowerVR device
  * @b: Branch ID.
@@ -148,6 +151,9 @@ struct pvr_device {
 	 */
 	struct reset_control *reset;
 
+	/** @pwrseq: Pointer to a power sequencer, if one is used. */
+	struct pwrseq_desc *pwrseq;
+
 	/** @irq: IRQ number. */
 	int irq;
 
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index 41f5d89e78b854cf6993838868a4416a220b490a..b7dcc03d7d9e06f03f059124fbe21dd844de713e 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -21,6 +21,7 @@
 #include <linux/reset.h>
 #include <linux/timer.h>
 #include <linux/types.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/workqueue.h>
 
 #define POWER_SYNC_TIMEOUT_US (1000000) /* 1s */
@@ -234,6 +235,19 @@ pvr_watchdog_init(struct pvr_device *pvr_dev)
 	return 0;
 }
 
+static int pvr_power_off_sequence_manual(struct pvr_device *pvr_dev)
+{
+	int err;
+
+	err = reset_control_assert(pvr_dev->reset);
+
+	clk_disable_unprepare(pvr_dev->mem_clk);
+	clk_disable_unprepare(pvr_dev->sys_clk);
+	clk_disable_unprepare(pvr_dev->core_clk);
+
+	return err;
+}
+
 int
 pvr_power_device_suspend(struct device *dev)
 {
@@ -252,11 +266,10 @@ pvr_power_device_suspend(struct device *dev)
 			goto err_drm_dev_exit;
 	}
 
-	clk_disable_unprepare(pvr_dev->mem_clk);
-	clk_disable_unprepare(pvr_dev->sys_clk);
-	clk_disable_unprepare(pvr_dev->core_clk);
-
-	err = reset_control_assert(pvr_dev->reset);
+	if (pvr_dev->pwrseq)
+		err = pwrseq_power_off(pvr_dev->pwrseq);
+	else
+		err = pvr_power_off_sequence_manual(pvr_dev);
 
 err_drm_dev_exit:
 	drm_dev_exit(idx);
@@ -276,44 +289,55 @@ pvr_power_device_resume(struct device *dev)
 	if (!drm_dev_enter(drm_dev, &idx))
 		return -EIO;
 
-	err = clk_prepare_enable(pvr_dev->core_clk);
-	if (err)
-		goto err_drm_dev_exit;
+	if (pvr_dev->pwrseq) {
+		err = pwrseq_power_on(pvr_dev->pwrseq);
+		if (err)
+			goto err_drm_dev_exit;
+	} else {
+		err = clk_prepare_enable(pvr_dev->core_clk);
+		if (err)
+			goto err_drm_dev_exit;
 
-	err = clk_prepare_enable(pvr_dev->sys_clk);
-	if (err)
-		goto err_core_clk_disable;
+		err = clk_prepare_enable(pvr_dev->sys_clk);
+		if (err)
+			goto err_core_clk_disable;
 
-	err = clk_prepare_enable(pvr_dev->mem_clk);
-	if (err)
-		goto err_sys_clk_disable;
+		err = clk_prepare_enable(pvr_dev->mem_clk);
+		if (err)
+			goto err_sys_clk_disable;
 
-	/*
-	 * According to the hardware manual, a delay of at least 32 clock
-	 * cycles is required between de-asserting the clkgen reset and
-	 * de-asserting the GPU reset. Assuming a worst-case scenario with
-	 * a very high GPU clock frequency, a delay of 1 microsecond is
-	 * sufficient to ensure this requirement is met across all
-	 * feasible GPU clock speeds.
-	 */
-	udelay(1);
+		/*
+		 * According to the hardware manual, a delay of at least 32 clock
+		 * cycles is required between de-asserting the clkgen reset and
+		 * de-asserting the GPU reset. Assuming a worst-case scenario with
+		 * a very high GPU clock frequency, a delay of 1 microsecond is
+		 * sufficient to ensure this requirement is met across all
+		 * feasible GPU clock speeds.
+		 */
+		udelay(1);
 
-	err = reset_control_deassert(pvr_dev->reset);
-	if (err)
-		goto err_mem_clk_disable;
+		err = reset_control_deassert(pvr_dev->reset);
+		if (err)
+			goto err_mem_clk_disable;
+	}
 
 	if (pvr_dev->fw_dev.booted) {
 		err = pvr_power_fw_enable(pvr_dev);
 		if (err)
-			goto err_reset_assert;
+			goto err_power_off;
 	}
 
 	drm_dev_exit(idx);
 
 	return 0;
 
-err_reset_assert:
-	reset_control_assert(pvr_dev->reset);
+err_power_off:
+	if (pvr_dev->pwrseq)
+		pwrseq_power_off(pvr_dev->pwrseq);
+	else
+		pvr_power_off_sequence_manual(pvr_dev);
+
+	goto err_drm_dev_exit;
 
 err_mem_clk_disable:
 	clk_disable_unprepare(pvr_dev->mem_clk);

-- 
2.34.1


