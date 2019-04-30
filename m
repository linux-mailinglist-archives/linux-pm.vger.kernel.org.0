Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424BDEF38
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 05:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfD3Dmn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 23:42:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:44621 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfD3Dmn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Apr 2019 23:42:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 20:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; 
   d="scan'208";a="320145165"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2019 20:42:42 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] drivers: thermal: processor_thermal: Downgrade error message
Date:   Mon, 29 Apr 2019 20:42:13 -0700
Message-Id: <20190430034213.40028-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Downgrade "Unsupported event" message from dev_err to dev_dbg. Otherwise it
floods with this message one some platforms.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 4b206b594825..436c256f111d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -275,7 +275,7 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
 				THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
 		break;
 	default:
-		dev_err(proc_priv->dev, "Unsupported event [0x%x]\n", event);
+		dev_dbg(proc_priv->dev, "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
-- 
2.17.2

