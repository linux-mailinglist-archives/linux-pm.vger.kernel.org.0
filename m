Return-Path: <linux-pm+bounces-14923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B51989C83
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4769A1C2184C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6517839C;
	Mon, 30 Sep 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMfdhUHi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2F152E1C;
	Mon, 30 Sep 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684388; cv=none; b=PNvVJueasPb7XsPRmvch4jqoZrsg+SThp9JQNmA6ODj7Lvo+bT+GFCWKrd1TGSjYdHtkKpAZcjWJVTvgfMva72oY3O61rcPyqFZbmrfXY7jlsibKv+oUyeWKy18lu/w4iqZz/9Jd4khoz/P901cBEeY3lmxPjifS0tX9IHv1c1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684388; c=relaxed/simple;
	bh=UiBl2UAfZ5jkKQJ30HaG7GtfKxgzF3LqEHQ9vzopWMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l06ugBKa7ww4aee/4myJEFAgHRBT8zLhZAzEnBb1RcN1vqBr3PFsJ5FOPLjuGiTTqpllx3I+QEM+NvldFRXxx00u5rUvlgJio8unP8itE3cQRQlCxJ31NDWkoQpRuynP6yzNF4tFit7CDdA1dZgl+zBTM6muk5IQs8Y3nsidArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMfdhUHi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684387; x=1759220387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UiBl2UAfZ5jkKQJ30HaG7GtfKxgzF3LqEHQ9vzopWMA=;
  b=MMfdhUHiFfB9ozCdROocbFJQdYcBaLt15UPlAd5yQEv9KMHA8X+FqTxR
   ozyJ5rz65itEPD2wMMvB4ejySIeKCnm7TM9iktdSJ3E/aw3OgWQFGdx2M
   aXCuIF0DfWHBAiqkP7gWlyVN1Q9zZ6ZoF8MsozNozDy2vh0Ep8MyEZ7MV
   i8b9I4GD9N7oPlXKITClhIhOic6WAJaKiJCUQEei2C6GoNtI/hB93UWKz
   FAGfyQkeMOts7ND2JFq2sQYYXWbjQZOcIKpXiSx4dcdFGHNoiWVogeV7h
   ErJ2ZrEMyFDyT9Nsyo5U/vI5j8Yh1k7ofmWvcLavouBPPV53dV3HvoU4o
   Q==;
X-CSE-ConnectionGUID: pH3j0GcHSmaMxmMKVn0z6w==
X-CSE-MsgGUID: qlFpR4PIRS6RbeketBntnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26638958"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26638958"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:28 -0700
X-CSE-ConnectionGUID: 2i3p16WMQveSKdAuEexl2A==
X-CSE-MsgGUID: xZO9lH2hQ++vts/VA9pNTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96549423"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:24 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 2/6] thermal: proc_thermal: Fix WARNING during module unload
Date: Mon, 30 Sep 2024 16:17:57 +0800
Message-Id: <20240930081801.28502-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930081801.28502-1-rui.zhang@intel.com>
References: <20240930081801.28502-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_thermal driver uses pcim_device_enable() to enable the pci device,
which means the device will be automatically disabled on driver detach.
Thus there is no need to call pci_disable_device() again.

With recent PCI device resource management improvements, e.g. commit
f748a07a0b64 ("PCI: Remove legacy pcim_release()"), this problem is
exposed and triggers below WARNING,

 [  224.010735] proc_thermal_pci 0000:00:04.0: disabling already-disabled device
 [  224.010747] WARNING: CPU: 8 PID: 4442 at drivers/pci/pci.c:2250 pci_disable_device+0xe5/0x100
 ...
 [  224.010844] Call Trace:
 [  224.010845]  <TASK>
 [  224.010847]  ? show_regs+0x6d/0x80
 [  224.010851]  ? __warn+0x8c/0x140
 [  224.010854]  ? pci_disable_device+0xe5/0x100
 [  224.010856]  ? report_bug+0x1c9/0x1e0
 [  224.010859]  ? handle_bug+0x46/0x80
 [  224.010862]  ? exc_invalid_op+0x1d/0x80
 [  224.010863]  ? asm_exc_invalid_op+0x1f/0x30
 [  224.010867]  ? pci_disable_device+0xe5/0x100
 [  224.010869]  ? pci_disable_device+0xe5/0x100
 [  224.010871]  ? kfree+0x21a/0x2b0
 [  224.010873]  pcim_disable_device+0x20/0x30
 [  224.010875]  devm_action_release+0x16/0x20
 [  224.010878]  release_nodes+0x47/0xc0
 [  224.010880]  devres_release_all+0x9f/0xe0
 [  224.010883]  device_unbind_cleanup+0x12/0x80
 [  224.010885]  device_release_driver_internal+0x1ca/0x210
 [  224.010887]  driver_detach+0x4e/0xa0
 [  224.010889]  bus_remove_driver+0x6f/0xf0
 [  224.010890]  driver_unregister+0x35/0x60
 [  224.010892]  pci_unregister_driver+0x44/0x90
 [  224.010894]  proc_thermal_pci_driver_exit+0x14/0x5f0 [processor_thermal_device_pci]
 ...
 [  224.010921] ---[ end trace 0000000000000000 ]---

Remove the pci_disable_device() calls.

Fixes: acd65d5d1cf4 ("thermal/drivers/int340x/processor_thermal: Add PCI MMIO based thermal driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c        | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 006614921870..ba5d36d36fc4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -416,7 +416,6 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	if (!pci_info->no_legacy)
 		proc_thermal_remove(proc_priv);
 	proc_thermal_mmio_remove(pdev, proc_priv);
-	pci_disable_device(pdev);
 
 	return ret;
 }
@@ -438,7 +437,6 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
 	if (!pci_info->no_legacy)
 		proc_thermal_remove(proc_priv);
-	pci_disable_device(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1


