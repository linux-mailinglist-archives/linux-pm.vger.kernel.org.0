Return-Path: <linux-pm+bounces-11333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08EC93A232
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0EA1C227FB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20854153BF0;
	Tue, 23 Jul 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cxj76E0f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D115380D;
	Tue, 23 Jul 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743365; cv=none; b=pt1rQj7cEOe4Mnf1zphKISyhaj4x+vsLnsN18BCdyde1KClRsba7sYoKDW8rZ3P+M3t7bsaUC1NWG5UmewGKl3h8lcA+sp5dSqDrjdttttEYrdT/Ui+NvAyV0vrnpbtWojz2dka/wOX1tZprOYv8F7/bivePKPqJy7FRz3OM2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743365; c=relaxed/simple;
	bh=M6DI9h0CnzTGut/L7iNzIhz2wuKflPRN7qOYDOksjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQeKQHqTc0gk1q96N+Q/A0KF7ivhmDvU+TiDqHtOkow7OevooeTd100oRxOtZ1eh/deh45gNHjxJcqeSNzkcj5QXcFgBP+adLZbTFmDfR27CneVvdsVT7M6ufji9MzYB8td62+XvvkUZRS1dgUBFrkNDqd1i13OixQ00SL3TRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cxj76E0f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721743363; x=1753279363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6DI9h0CnzTGut/L7iNzIhz2wuKflPRN7qOYDOksjQo=;
  b=Cxj76E0f6lKbhcmQoRnNz77Ol1lyUujs6o4qmPWxi8SYz7KC0NO61khq
   bddBuC28uvUOdk4Zf8ZSHizQtO4L4PYQMQuwOSqdSNy2Jwl3nzn63CtKV
   EvuydCDcwluGo8TOmyJRu7DNEWpqeNDqj6FGswPaDJjYAm/E4gNigTOFi
   3Swifz450HEpfktdrW/wbaFxq3hP/Z9Sepsay4UexzW4FzGhH1ef0Y/SW
   OTOFuWw6u7Z2c8FEaG15BD3y29FiklncBuMszDuDafS+CvLPl50QTPNdh
   YJeJX9Z+IHluktuYp7GYbB7DN9LaVAw358uyuaktz8VszIn8/gRquI/nU
   g==;
X-CSE-ConnectionGUID: ukTSPJN4QayfBbQ38m3C7Q==
X-CSE-MsgGUID: gvKA1c+WTASjznxsJWwF7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19518126"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19518126"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 07:02:34 -0700
X-CSE-ConnectionGUID: cx6KRn3GRyabVDz4dCb18Q==
X-CSE-MsgGUID: tg1H8+4aTPat4RCOOZeAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56546559"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2024 07:02:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yijun.Shen@dell.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Yijun Shen <Yijun.shen@dell.com>
Subject: [PATCH 1/3] thermal: intel: int340x: Fix kernel warning during MSI cleanup
Date: Tue, 23 Jul 2024 07:02:26 -0700
Message-ID: <20240723140228.865919-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
References: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some pre-production Lunar Lake systems, there is a kernel
warning:

remove_proc_entry: removing non-empty directory 'irq/172'
WARNING: CPU: 0 PID: 501 at fs/proc/generic.c:717
	remove_proc_entry+0x1b4/0x1e0
...
...
remove_proc_entry+0x1b4/0x1e0
report_bug+0x182/0x1b0
handle_bug+0x51/0xa0
exc_invalid_op+0x18/0x80
asm_exc_invalid_op+0x1b/0x20
remove_proc_entry+0x1b4/0x1e0
remove_proc_entry+0x1b4/0x1e0
unregister_irq_proc+0xf2/0x120
free_desc+0x41/0xe0
irq_domain_free_irqs+0x138/0x1c0
irq_free_descs+0x52/0x80
irq_domain_free_irqs+0x151/0x1c0
msi_domain_free_locked.part.0+0x17e/0x1c0
msi_domain_free_irqs_all_locked+0x74/0xc0
pci_msi_teardown_msi_irqs+0x50/0x60
pci_free_msi_irqs+0x12/0x40
pci_free_irq_vectors+0x58/0x70

On these systems, not all the MSI thermal vectors are valid. This causes
devm_request_threaded_irq() to fail for some vectors. As part of the
clean up on this error, pci_free_irq_vectors() is called without calling
devm_free_irq(). This causes the above warning.

Add a function proc_thermal_free_msi() to call devm_free_irq() for all
successfully registered IRQ handlers, then call pci_free_irq_vectors().
Call this function for MSI cleanup.

Fixes: 7a9a8c5faf41 ("thermal: intel: int340x: Support MSI interrupt for Lunar Lake")
Reported-by: Yijun Shen <Yijun.shen@dell.com>
Tested-by: Yijun Shen <Yijun.shen@dell.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device_pci.c               | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 114136893a59..2c9c45eb5b4a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -278,6 +278,18 @@ static struct thermal_zone_params tzone_params = {
 
 static bool msi_irq;
 
+static void proc_thermal_free_msi(struct pci_dev *pdev, struct proc_thermal_pci *pci_info)
+{
+	int i;
+
+	for (i = 0; i < MSI_THERMAL_MAX; i++) {
+		if (proc_thermal_msi_map[i])
+			devm_free_irq(&pdev->dev, proc_thermal_msi_map[i], pci_info);
+	}
+
+	pci_free_irq_vectors(pdev);
+}
+
 static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci *pci_info)
 {
 	int ret, i, irq;
@@ -310,7 +322,7 @@ static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci
 	return 0;
 
 err_free_msi_vectors:
-	pci_free_irq_vectors(pdev);
+	proc_thermal_free_msi(pdev, pci_info);
 
 	return ret;
 }
@@ -397,7 +409,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 
 err_free_vectors:
 	if (msi_irq)
-		pci_free_irq_vectors(pdev);
+		proc_thermal_free_msi(pdev, pci_info);
 err_ret_tzone:
 	thermal_zone_device_unregister(pci_info->tzone);
 err_del_legacy:
-- 
2.45.0


