Return-Path: <linux-pm+bounces-35705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97675BB817C
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC34AAAB6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00F2459C6;
	Fri,  3 Oct 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="lWIg+nTS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4114243954;
	Fri,  3 Oct 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522603; cv=pass; b=u9SdVt0YBxcsw+Kb8OM94ZYzjA0odBmMhByl57Ik/rgKCpVoPmcSdbqK1XXq9Sh2vktGtlvuwt6kOYUe7Tra6L6fyxfesYLeLq/FfhTsv55q7Wp0FJvIl2R9JdO9vjSU3rKpkt0YgaKxPXz0Gy00vRD9cR+qhrQ2c1uEARSbS6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522603; c=relaxed/simple;
	bh=BA9f+OnKiPcx4YVrAzQXqlkrVoq0ksNkmPZamQ/fZSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0jlqD+9asARTz3TRNFlezAclkjqw/El2KKo3NyTzYowYcePcTfPCxgT/jVN5IFVYkLFDoNUskNLOUrugpIQYDlFKTV0atB92VpxWDh64HAn7LAgsbF5vqIdi5z/SvwendEtt/YWP7CjvTzk1CB/iRe59K8Wf3tvm/tJRzS02DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=lWIg+nTS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759522561; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LrN3eiWbX8sYaIeBV3vNjqeNt0J2l+kKMNz0i9Yg1cPHCuC2EjJAUHHvaSzjHVOpsRE1r0osPfsobQGfIHXlE8PaCCsTrNrZ0A2RREG5gNLPL8MxQT5tWmHRBO5wDS2qu/fYAI5vJXgtCUJFk7izBreMhLLxLhbgr6/3A5Sa5IM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759522561; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DkJ/i7G36UnilumgirmfAaTl6Joa/b6u+SJB4HMpAQU=; 
	b=lafCvcxtsK2oDFxGrtxViEp1K/Fpv9QThMCgtF6G3uHfKwL3au3Y7PNicBesWgZmi9Qrz9z0bUL58BBdwaDi2dg6E2JfKa5OBzoS665sx8b7D1gjEoD6qH32DtbmAIO5Dg1oNmlVQq5znQo7/xwoDmK7VsyP88pCD6VQE8PB+5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759522561;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=DkJ/i7G36UnilumgirmfAaTl6Joa/b6u+SJB4HMpAQU=;
	b=lWIg+nTS8gxHsCyrZq2pYSjhKRSJiGdj1UjO6QYw3qmWDlBKuX2fR507FHyx9S6E
	XUh5CPpd9zXNJ6P5NibdFfYXt50DnacmmkffqZ5jZFI4lQtdPRAec6aggZNTZlp0/BY
	Wyvp6BVKYSRIq/khE1AcHLZqno8k5vMfo1oplQ0g=
Received: by mx.zohomail.com with SMTPS id 1759522560247312.65323254008854;
	Fri, 3 Oct 2025 13:16:00 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 03 Oct 2025 22:15:07 +0200
Subject: [PATCH v6 5/7] drm/panthor: call into devfreq for current
 frequency
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-mt8196-gpufreq-v6-5-76498ad61d9e@collabora.com>
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
In-Reply-To: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

As it stands, panthor keeps a cached current frequency value for when it
wants to retrieve it. This doesn't work well for when things might
switch frequency without panthor's knowledge.

Instead, implement the get_cur_freq operation, and expose it through a
helper function to the rest of panthor.

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 30 ++++++++++++++++++++++++++----
 drivers/gpu/drm/panthor/panthor_devfreq.h |  2 ++
 drivers/gpu/drm/panthor/panthor_device.h  |  3 ---
 drivers/gpu/drm/panthor/panthor_drv.c     |  4 +++-
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 3686515d368db5bb329f4858d4a7247a4957cc24..978f193a2aee561fadd9a976e9b1417118260889 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -62,7 +62,6 @@ static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
 static int panthor_devfreq_target(struct device *dev, unsigned long *freq,
 				  u32 flags)
 {
-	struct panthor_device *ptdev = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 	int err;
 
@@ -72,8 +71,6 @@ static int panthor_devfreq_target(struct device *dev, unsigned long *freq,
 	dev_pm_opp_put(opp);
 
 	err = dev_pm_opp_set_rate(dev, *freq);
-	if (!err)
-		ptdev->current_frequency = *freq;
 
 	return err;
 }
@@ -115,11 +112,21 @@ static int panthor_devfreq_get_dev_status(struct device *dev,
 	return 0;
 }
 
+static int panthor_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(ptdev->clks.core);
+
+	return 0;
+}
+
 static struct devfreq_dev_profile panthor_devfreq_profile = {
 	.timer = DEVFREQ_TIMER_DELAYED,
 	.polling_ms = 50, /* ~3 frames */
 	.target = panthor_devfreq_target,
 	.get_dev_status = panthor_devfreq_get_dev_status,
+	.get_cur_freq = panthor_devfreq_get_cur_freq,
 };
 
 int panthor_devfreq_init(struct panthor_device *ptdev)
@@ -198,7 +205,6 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 		return PTR_ERR(opp);
 
 	panthor_devfreq_profile.initial_freq = cur_freq;
-	ptdev->current_frequency = cur_freq;
 
 	/*
 	 * Set the recommend OPP this will enable and configure the regulator
@@ -296,3 +302,19 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
 
 	spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
 }
+
+unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
+{
+	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
+	unsigned long freq = 0;
+	int ret;
+
+	if (!pdevfreq->devfreq)
+		return 0;
+
+	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
+	if (ret)
+		return 0;
+
+	return freq;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/panthor/panthor_devfreq.h
index b7631de695f7d79456478c87e8af5dc47673cd1d..f8e29e02f66cb3281ed4bb4c75cda9bd4df82b92 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.h
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
@@ -18,4 +18,6 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev);
 void panthor_devfreq_record_busy(struct panthor_device *ptdev);
 void panthor_devfreq_record_idle(struct panthor_device *ptdev);
 
+unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
+
 #endif /* __PANTHOR_DEVFREQ_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 9f0649ecfc4fc697a21a8b2fc4dd89c8ecf298df..f32c1868bf6d782d99df9dbd0babcea049c917e0 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -214,9 +214,6 @@ struct panthor_device {
 	/** @profile_mask: User-set profiling flags for job accounting. */
 	u32 profile_mask;
 
-	/** @current_frequency: Device clock frequency at present. Set by DVFS*/
-	unsigned long current_frequency;
-
 	/** @fast_rate: Maximum device clock frequency. Set by DVFS */
 	unsigned long fast_rate;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index ea4a37b566a8b215f2b7a09c333a696f1dcdb58f..4d59d94c353c3ca76f4b98a411c8f8284efafd08 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -25,6 +25,7 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+#include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
 #include "panthor_gem.h"
@@ -1519,7 +1520,8 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
 		drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
 
 	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
-	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n", ptdev->current_frequency);
+	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
+		   panthor_devfreq_get_freq(ptdev));
 }
 
 static void panthor_show_internal_memory_stats(struct drm_printer *p, struct drm_file *file)

-- 
2.51.0


