Return-Path: <linux-pm+bounces-28715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A0AD9EC6
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAC91897E26
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F72E92AD;
	Sat, 14 Jun 2025 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YzLTPmxz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7C2D5404
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924561; cv=none; b=baJdmXZ1MiRjF40zsH0gkQtgiTHwBAQsZt3lx5HaKGvnCVNMQWtvoJmBzgqKmoimMfGvgNovt0tTJ7KHSq9dxmT8EHv1Ic20rslyU5iiCvqlM12Hm0XtSfwTn2v2p36eq3ZmowOpsDpV+KYqP2G0hG+NEFcTaA5qKJtgCxCZars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924561; c=relaxed/simple;
	bh=w50HxEtb1HX0jqTQg0fb8R4wK97AKoiLMQWm9+Ki6vo=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=E6n3HVh5LgH7RMLvs7yZsW40gBQm6qwFKshMZj9K5xBw03XHXS/yXR9enkyUTMuczVFwCRGtKS6GAKUClQH2Gd1m1dNVCtLo9EP4lBmr4L6mVoKj62HRMg88ab1SpQQX+/tTeMokiLkAc0RP3ZuxJMK7cM0jpvwryGd2UYzan5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YzLTPmxz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250614180911euoutp0103a0a00683d208d1a3ed07b2ea5d1af9~I_xuqVRS30844108441euoutp01K
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 18:09:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250614180911euoutp0103a0a00683d208d1a3ed07b2ea5d1af9~I_xuqVRS30844108441euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749924551;
	bh=o4L0V+xOrkyiHYkxYBU3iTr+XvJFcrC7GTCBNOr94MM=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=YzLTPmxzre52eaQ2TUyCvf5McKcvJT6KkPiik/uZIum/0stGVXvvBH5z413HwwrsP
	 68seIijMFNoKfHwvJ7ETUEDlDExEYfqGMA7lho91MNI09GiihgPX0608j+J/zHeQhe
	 VV9ZXzvH16dHorKgNOU5tn8qzsHwlVAoKGdIcOpo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250614180909eucas1p2a34e3242fb42f7fd25e4038c291276ff~I_xtBbA1M2679426794eucas1p2z;
	Sat, 14 Jun 2025 18:09:09 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250614180908eusmtip146d8003bdf8d8b7eef56198cf49309ea~I_xsAY2Rl2797327973eusmtip1c;
	Sat, 14 Jun 2025 18:09:08 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 14 Jun 2025 20:06:09 +0200
Subject: [PATCH v4 3/8] pmdomain: thead: Instantiate GPU power sequencer via
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250614-apr_14_for_sending-v4-3-8e3945c819cd@samsung.com>
In-Reply-To: <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
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
X-CMS-MailID: 20250614180909eucas1p2a34e3242fb42f7fd25e4038c291276ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250614180909eucas1p2a34e3242fb42f7fd25e4038c291276ff
X-EPHeader: CA
X-CMS-RootMailID: 20250614180909eucas1p2a34e3242fb42f7fd25e4038c291276ff
References: <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
	<CGME20250614180909eucas1p2a34e3242fb42f7fd25e4038c291276ff@eucas1p2.samsung.com>

In order to support the complex power sequencing required by the TH1520
GPU, the AON power domain driver must be responsible for initiating the
corresponding sequencer driver. This functionality is specific to
platforms where the GPU power sequencing hardware is controlled by the
AON block.

Extend the AON power domain driver to check for the presence of the
"gpu-clkgen" reset in its own device tree node.

If the property is found, create and register a new auxiliary device.
This device acts as a proxy that allows the dedicated `pwrseq-thead-gpu`
auxiliary driver to bind and take control of the sequencing logic.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pmdomain/thead/Kconfig             |  1 +
 drivers/pmdomain/thead/th1520-pm-domains.c | 53 ++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/pmdomain/thead/Kconfig b/drivers/pmdomain/thead/Kconfig
index 7d52f8374b074167d508a80fd807929c53faef12..208828e0fa0dc91256bf808b905bea32bb84250d 100644
--- a/drivers/pmdomain/thead/Kconfig
+++ b/drivers/pmdomain/thead/Kconfig
@@ -4,6 +4,7 @@ config TH1520_PM_DOMAINS
 	tristate "Support TH1520 Power Domains"
 	depends on TH1520_AON_PROTOCOL
 	select REGMAP_MMIO
+	select AUXILIARY_BUS
 	help
 	  This driver enables power domain management for the T-HEAD
 	  TH-1520 SoC. On this SoC there are number of power domains,
diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
index f702e20306f469aeb0ed15e54bd4f8309f28018c..9f2cd833e5f554d4a9154e276e5fe5720fc4d50f 100644
--- a/drivers/pmdomain/thead/th1520-pm-domains.c
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -5,8 +5,10 @@
  * Author: Michal Wilczynski <m.wilczynski@samsung.com>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/firmware/thead/thead,th1520-aon.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 
@@ -128,6 +130,51 @@ static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
 	}
 }
 
+static void th1520_pd_pwrseq_unregister_adev(void *adev)
+{
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int th1520_pd_pwrseq_gpu_init(struct device *dev)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	/*
+	 * Correctly check only for the property's existence in the DT node.
+	 * We don't need to get/claim the reset here; that is the job of
+	 * the auxiliary driver that we are about to spawn.
+	 */
+	if (of_property_match_string(dev->of_node, "reset-names",
+				     "gpu-clkgen") < 0)
+		/*
+		 * This is not an error. It simply means the optional sequencer
+		 * is not described in the device tree.
+		 */
+		return 0;
+
+	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = "pwrseq-gpu";
+	adev->dev.parent = dev;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, th1520_pd_pwrseq_unregister_adev,
+					adev);
+}
+
 static int th1520_pd_probe(struct platform_device *pdev)
 {
 	struct generic_pm_domain **domains;
@@ -186,8 +233,14 @@ static int th1520_pd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clean_genpd;
 
+	ret = th1520_pd_pwrseq_gpu_init(dev);
+	if (ret)
+		goto err_clean_provider;
+
 	return 0;
 
+err_clean_provider:
+	of_genpd_del_provider(dev->of_node);
 err_clean_genpd:
 	for (i--; i >= 0; i--)
 		pm_genpd_remove(domains[i]);

-- 
2.34.1


