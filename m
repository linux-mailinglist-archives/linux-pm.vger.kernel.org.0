Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4A3B687B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhF1SfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 14:35:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:8039 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhF1SfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Jun 2021 14:35:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="195162442"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="195162442"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 11:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="454588644"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2021 11:32:37 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH -next] thermal: int340x: processor_thermal: Fix warning for return value
Date:   Mon, 28 Jun 2021 11:32:32 -0700
Message-Id: <20210628183232.62877-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix smatch warnings:
drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c:258 proc_thermal_pci_probe() warn: missing error code 'ret'

Use PTR_ERR to return failure of thermal_zone_device_register().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index fea4a3ffd838..99ac7994b8f4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -254,8 +254,10 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device
 	pci_info->tzone = thermal_zone_device_register("TCPU_PCI", 1, 1, pci_info,
 							&tzone_ops,
 							&tzone_params, 0, 0);
-	if (IS_ERR(pci_info->tzone))
+	if (IS_ERR(pci_info->tzone)) {
+		ret = PTR_ERR(pci_info->tzone);
 		goto err_ret_mmio;
+	}
 
 	/* request and enable interrupt */
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-- 
2.27.0

