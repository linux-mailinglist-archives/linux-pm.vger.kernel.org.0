Return-Path: <linux-pm+bounces-9537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9E90E266
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 06:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D70B226DC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 04:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88466381BD;
	Wed, 19 Jun 2024 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B880fJrT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F895208A0;
	Wed, 19 Jun 2024 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718772269; cv=none; b=pk2dZYabQ7Eb7ONwyqdxnvNnmqp5WQeFH4avFiIYRiihWMPMHSWD1GPe8Ks5JlclkkgHpfHUw+KEtbH5Df2LrkZI5wtbbPWWOcWagDLYdwHHFn7qinE5IFi8D1Z+RJp1xu7BBV5kxhW5eCQA7W8/yGdG1gDvWyOdP9UQQARmaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718772269; c=relaxed/simple;
	bh=pGqBZ94iK6V7CP40Pp3MipCFw43itk2w6Q4lEJg//+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bILCxL5I7wBvPkdsT823lUM6blDOe4ApSHBYG447nhDI9lHMCUnYoh6fC51/JI8UUMVnI346wTXOHTTUHF9DG7gHho30//Yolp+ALW6T12bL4fisCsRN4iSdd2wHNubm3jkIhhOXdPo6nuujrDBcMucXadrYOhnUbA767505E7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B880fJrT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718772268; x=1750308268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pGqBZ94iK6V7CP40Pp3MipCFw43itk2w6Q4lEJg//+o=;
  b=B880fJrTUvDmtn/mfjNLlZKSSKXPQnGEEx5/VgIIqIsvt6DGqLDjuGZk
   CDiavjTmy1hjXOasuGbQCPMioAp2ykZrYwjpsAVOLCbaaZJseXC73RmPq
   zZngWV3WTvpWAcwUF2xCDjfMotB7tJuBSoOVn+aqSE41k6XTLMEzUukD7
   kKXa3UO/zAQDo8r9o6NP1+f1uRe5oCMWWwB+shmawzWL9UD8YqRB/C959
   ug+rhOl+1QD+Ce3MEnbnRuFZ4fLG7mKAZgvK/AL5umy/0eEQFbhm4QZgW
   irF7OkHPR2DPCGRA3j8bPOc40Tm4PkpVRFuu6Lup1uhhqmtKTLz+p+N86
   w==;
X-CSE-ConnectionGUID: gJCz7bqVTP2Q5qshZSU6BQ==
X-CSE-MsgGUID: da5QOe+dROWT5EIw/o50Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15817635"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15817635"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 21:44:28 -0700
X-CSE-ConnectionGUID: W2p+cfZASme33qoWOap5hg==
X-CSE-MsgGUID: TqbUp/k2RPqKOX+qTDgs4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="41915896"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2024 21:44:27 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] thermal: int340x: processor_thermal: Support shared interrupts
Date: Tue, 18 Jun 2024 21:44:24 -0700
Message-ID: <20240619044424.481239-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems the processor thermal device interrupt is shared with
other PCI devices. In this case return IRQ_NONE from the interrupt
handler when the interrupt is not for the processor thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: f0658708e863 ("thermal: int340x: processor_thermal: Use non MSI interrupts by default")
Cc: <stable@vger.kernel.org> # v6.7+
---
This was only observed on a non production system. So not urgent.

 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 14e34eabc419..4a1bfebb1b8e 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -150,7 +150,7 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 {
 	struct proc_thermal_pci *pci_info = devid;
 	struct proc_thermal_device *proc_priv;
-	int ret = IRQ_HANDLED;
+	int ret = IRQ_NONE;
 	u32 status;
 
 	proc_priv = pci_info->proc_priv;
@@ -175,6 +175,7 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 		/* Disable enable interrupt flag */
 		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
 		pkg_thermal_schedule_work(&pci_info->work);
+		ret = IRQ_HANDLED;
 	}
 
 	pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
-- 
2.44.0


