Return-Path: <linux-pm+bounces-34575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0DB55677
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091A4581696
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90641338F23;
	Fri, 12 Sep 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YH+cFnNW"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FC18E25;
	Fri, 12 Sep 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702341; cv=pass; b=usz5HUkAHAfPuQG+T9U2iNdNMeSf+FciBVcZ/S3HMmyTYMY5J6lO7LF19ziBeZtiTl8axJ25icT5u3c8I7YwpCNU4MZBbAMKvuCfluC8ufW+d+/UAdG3DrP7UTM9+Vmw/E1edTiaK/IxT/zgte2RstZyRS8GGx8hfW1AKOpKiRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702341; c=relaxed/simple;
	bh=mfL1HzcwVpkb+79fo+AyJr0DAelm3Tm1QmTIFL8jzGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLSHPM/2djrnAExEdNAmYpca47K67GC7/rnjsl0Q3Cu2gL/6DBDZwL7N7tvVgLUseI3QGnEX1SUFsfWhdjT812aYGd5PoM9+yMFleZGIYSBu25Q5/81+k97AV++L6Elym5aZBfE2fBSOo+nmwqLBRJBvTq3O5FaRmwbGcRzKYb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=YH+cFnNW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757702311; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R3DvJYaoj1BUnHbfe6uM3o2Ogobavoh4l1FaRO4FIeGRKImX1aSPgN1ZXOUgALqTKziT9TiN0WylkUKECT1zHaqs24PjcyPBCl//vVvWIh/zfoxtzsrFiKp68ra3CsQQ1DYEhc7EjPitSdrSTbXtlBjooKAvqv9X5euZjNSkAB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757702311; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AptuEM6eGjHvUS3aWo1FiH8jUU8Yeeux1DBWCw1eemo=; 
	b=PmQdd57aGiE34GNnRETM80hEfkg7rgTgEJ6ACZvPuSH3E6EMu9VUpkQq0BNtY0JLnny3DvNeOOuvuYyCWVsGeg6c+SZqCONJb21owAyaST6q/x7Q6IFj+Y0KGSmPvNbnCUnGnCY+hgWBubTYk4yTLvhHmiGmr3KVya74pN+wKrU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757702311;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=AptuEM6eGjHvUS3aWo1FiH8jUU8Yeeux1DBWCw1eemo=;
	b=YH+cFnNWZugtBZCChnD9/4NvJrYtEZhzu8s36nm0iUOuFtj7XYJxypYwfM2IzE+n
	P08riJAcQGJ+JDzgj+1Hq2BsCyLHHccR/t2/Lv9lQBvNDH7Aj+1au1KrOld20dwCEi1
	Ebb5+vk7QuiYH5JJy3MFqEIU/CEENZ6Hth7Uu/NE=
Received: by mx.zohomail.com with SMTPS id 1757702309074253.43093313248596;
	Fri, 12 Sep 2025 11:38:29 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 12 Sep 2025 20:37:08 +0200
Subject: [PATCH v2 09/10] drm/panthor: devfreq: add pluggable devfreq
 providers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-mt8196-gpufreq-v2-9-779a8a3729d9@collabora.com>
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

On some devices, devfreq is not controlled directly by DT OPPs and the
common clock framework, but through an external devfreq driver. To
permit this type of usage, add the concept of devfreq providers.

Devfreq providers for panthor register themselves with panthor as a
provider. panthor then gets whatever device is pointed at on its
performance-domains property, finds the registered devfreq provider init
function for it, and calls it.

Should the probe order work out such that panthor probes before the
devfreq provider is finished probing and registering itself, then we
just defer the probe after adding a device link.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 74 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_devfreq.h | 16 +++++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 34b621b155f1324ba4f0a07c981da669d945a545..84157916350cf506d315603a47bfc99436a787f8 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -4,6 +4,7 @@
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq_cooling.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 
@@ -12,6 +13,34 @@
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 
+static LIST_HEAD(panthor_devfreq_providers);
+static DEFINE_MUTEX(panthor_devfreq_providers_lock);
+
+int panthor_devfreq_register_provider(struct panthor_devfreq_provider *prov)
+{
+	guard(mutex)(&panthor_devfreq_providers_lock);
+
+	list_add(&prov->node, &panthor_devfreq_providers);
+
+	return 0;
+}
+EXPORT_SYMBOL(panthor_devfreq_register_provider);
+
+static int panthor_devfreq_init_provider(struct panthor_device *ptdev,
+					 struct device *provider_dev)
+{
+	struct panthor_devfreq_provider *prov;
+
+	guard(mutex)(&panthor_devfreq_providers_lock);
+
+	list_for_each_entry(prov, &panthor_devfreq_providers, node) {
+		if (prov->dev == provider_dev)
+			return prov->init(ptdev, provider_dev);
+	}
+
+	return -EPROBE_DEFER;
+}
+
 static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
 {
 	ktime_t now, last;
@@ -102,7 +131,7 @@ static struct devfreq_dev_profile panthor_devfreq_profile = {
 	.get_cur_freq = panthor_devfreq_get_cur_freq,
 };
 
-int panthor_devfreq_init(struct panthor_device *ptdev)
+static int panthor_devfreq_init_of(struct panthor_device *ptdev)
 {
 	/* There's actually 2 regulators (mali and sram), but the OPP core only
 	 * supports one.
@@ -222,6 +251,49 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	return 0;
 }
 
+static int panthor_devfreq_init_platform(struct panthor_device *ptdev)
+{
+	struct device_node *pcnode;
+	struct platform_device *pdev;
+	struct device_link *link;
+	int ret;
+
+	pcnode = of_parse_phandle(ptdev->base.dev->of_node,
+				  "performance-domains", 0);
+	if (!pcnode)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(pcnode);
+	of_node_put(pcnode);
+	if (!pdev)
+		return -ENODEV;
+
+	link = device_link_add(ptdev->base.dev, &pdev->dev,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(ptdev->base.dev, "failed to add device link\n");
+		return -ENODEV;
+	}
+
+	ret = panthor_devfreq_init_provider(ptdev, &pdev->dev);
+	if (ret)
+		return dev_err_probe(ptdev->base.dev, ret,
+				     "failed to initialize devfreq provider\n");
+
+	DRM_DEV_INFO(ptdev->base.dev, "initialized devfreq provider %s\n",
+		     dev_name(&pdev->dev));
+
+	return 0;
+}
+
+int panthor_devfreq_init(struct panthor_device *ptdev)
+{
+	if (!of_property_present(ptdev->base.dev->of_node, "performance-domains"))
+		return panthor_devfreq_init_of(ptdev);
+
+	return panthor_devfreq_init_platform(ptdev);
+}
+
 void panthor_devfreq_resume(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/panthor/panthor_devfreq.h
index a891cb5fdc34636444f141e10f5d45828fc35b51..94c9768d5d038c4ba8516929edb565a1f13443fb 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.h
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
@@ -8,6 +8,7 @@
 
 struct devfreq;
 struct thermal_cooling_device;
+struct platform_device;
 
 struct panthor_device;
 
@@ -43,6 +44,19 @@ struct panthor_devfreq {
 	spinlock_t lock;
 };
 
+struct panthor_devfreq_provider {
+	/** @dev: device pointer to the provider device */
+	struct device *dev;
+	/**
+	 * @init: the provider's init callback that allocates a
+	 * &struct panthor_devfreq, adds it to panthor, and adds a devfreq
+	 * device to panthor. Will be called during panthor's probe.
+	 */
+	int (*init)(struct panthor_device *ptdev, struct device *dev);
+
+	struct list_head node;
+};
+
 
 int panthor_devfreq_init(struct panthor_device *ptdev);
 
@@ -57,4 +71,6 @@ int panthor_devfreq_get_dev_status(struct device *dev,
 
 unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
 
+int panthor_devfreq_register_provider(struct panthor_devfreq_provider *prov);
+
 #endif /* __PANTHOR_DEVFREQ_H__ */

-- 
2.51.0


