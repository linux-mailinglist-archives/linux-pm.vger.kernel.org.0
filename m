Return-Path: <linux-pm+bounces-32353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2FB25369
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34519A22FC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5BB3074BF;
	Wed, 13 Aug 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+oSBxtp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC7305E1E;
	Wed, 13 Aug 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111340; cv=none; b=eNCqVohTHY29hE4gdrWI8sxoVRyybW2JKgWQuIXecAPy0ejjZLN/WLO2MDa6sSF9HKZ8Wr/bH0diyTZPPu4xJe5ZfD1tr0W4zp9X2o+s0Gm1Mbax2wLrK6ltr94o/nzrxI6wOSA20uEnlkRXAD9OhvqufMR+GrHSVJbngBzy3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111340; c=relaxed/simple;
	bh=ch/o4xVd8lIYnBl2yT/WfH6wbEpaFaYG6SCxK0C0vl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdXcQ7s8AALNv2JIeuKdHOWYiXv8D5qqlpu8JqownqWdEbFG92H+ftCs6F1hYA4xJCR81XfTgyyTFs3sWWUBl3R6xTLgGxbozjwXokZj6nygbXh6i+Dz6tiTSiqfHHf/3uqkQajMISuEmbhMjGc2e7Mcbc3GilLph/IFEK/BHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+oSBxtp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755111339; x=1786647339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ch/o4xVd8lIYnBl2yT/WfH6wbEpaFaYG6SCxK0C0vl8=;
  b=D+oSBxtpGnjmYd+Xmm5RkDDjoMflcpaEBPuoWyXvkOpjUdR9VCB8Y7WY
   YupZAR0WL0s8jBcj2LsJLeN3VMp5WPlPP0yxOuAfL74J1i2whbetNrncn
   2sydmeI7EhHlI5qxsdgPcxQc2EKVNWR2GK9kSHIP9FprqympluQ0FhdcG
   17eWQIQKosRfORlDSP5QPpsF7LsKRtDQyFAB3ZU2+vt9kS+mUic9jI7K1
   vbQ9U+OJaggX64vHXYl9np8TaQRUWERmOgLPJejto/6+Vz+ZFm00iciav
   VD/V6yoDAsuqyLQdi7bJMEhYe4CtZKBHvmj76J+D3a5gQJMT7Ig0rSqY3
   w==;
X-CSE-ConnectionGUID: 16Z5I1g/Qn2qgutRdSe1Tw==
X-CSE-MsgGUID: UvKg+hZVSIC+7RXTOG4k9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56631248"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56631248"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:55:35 -0700
X-CSE-ConnectionGUID: 5McULt/1R8uzckTiEDCrKw==
X-CSE-MsgGUID: qX/1ACUpQOaNhZoe4fa5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170755040"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 11:55:35 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/5] thermal: intel: int340x: Add suspend and resume callbacks
Date: Wed, 13 Aug 2025 11:55:30 -0700
Message-ID: <20250813185530.635096-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During system suspend callback save slider register and restore during
resume callback.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_device.c    | 10 ++++++++++
 .../int340x_thermal/processor_thermal_device.h    |  2 ++
 .../processor_thermal_soc_slider.c                | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 4aea5c9baae9..a772c187bedb 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -338,10 +338,17 @@ static int tcc_offset_save = -1;
 
 int proc_thermal_suspend(struct device *dev)
 {
+	struct proc_thermal_device *proc_dev;
+
 	tcc_offset_save = intel_tcc_get_offset(-1);
 	if (tcc_offset_save < 0)
 		dev_warn(dev, "failed to save offset (%d)\n", tcc_offset_save);
 
+	proc_dev = dev_get_drvdata(dev);
+
+	if (proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_SLIDER)
+		proc_thermal_soc_power_slider_suspend(proc_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(proc_thermal_suspend);
@@ -357,6 +364,9 @@ int proc_thermal_resume(struct device *dev)
 	if (tcc_offset_save >= 0)
 		intel_tcc_set_offset(-1, tcc_offset_save);
 
+	if (proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_SLIDER)
+		proc_thermal_soc_power_slider_resume(proc_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(proc_thermal_resume);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index ba3f64742f2f..30760475102f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -130,5 +130,7 @@ int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_
 void proc_thermal_ptc_remove(struct pci_dev *pdev);
 
 int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_soc_power_slider_suspend(struct proc_thermal_device *proc_priv);
+void proc_thermal_soc_power_slider_resume(struct proc_thermal_device *proc_priv);
 
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index bd4ff26a488b..268bf9124d95 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -248,6 +248,21 @@ int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_thermal_
 }
 EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_add, "INT340X_THERMAL");
 
+static u64 soc_slider_save;
+
+void proc_thermal_soc_power_slider_suspend(struct proc_thermal_device *proc_priv)
+{
+	soc_slider_save = readq(proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
+
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_suspend, "INT340X_THERMAL");
+
+void proc_thermal_soc_power_slider_resume(struct proc_thermal_device *proc_priv)
+{
+	writeq(soc_slider_save, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_resume, "INT340X_THERMAL");
+
 MODULE_IMPORT_NS("INT340X_THERMAL");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Processor Thermal Power Slider Interface");
-- 
2.43.0


