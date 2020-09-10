Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E6263EF6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIJHtJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 03:49:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:26335 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgIJHtF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Sep 2020 03:49:05 -0400
IronPort-SDR: Ji1nE2qlDOPvF0tsIwIH8qWawyX6om1m8Huk/WC5uN1NuO9loIitcwK1IOtPUySG1cuIvFpPq4
 ZRLVVyZllRTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="155947281"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208,223";a="155947281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:49:04 -0700
IronPort-SDR: wyHWPU2etMaezl7Ssxe+YKHm+yzdg1mr/1pBZi/5TyVtxXmt9xe4gN9YjuwplxhT3jeB3R2ytu
 OiuU9hdRDcZQ==
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208,223";a="341839533"
Received: from jhou15-mobl1.ccr.corp.intel.com ([10.255.29.228])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:49:02 -0700
Message-ID: <6d3237551d3e9755a10f73698d102a63a9052bed.camel@intel.com>
Subject: [PATCH 1/3] powercap/intel_rapl: add support for TigerLake Desktop
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Thu, 10 Sep 2020 15:48:58 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From a6bca1219d998bd5505924ee2b67c5febb2e79d3 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 9 Sep 2020 22:37:08 +0800
Subject: [PATCH 1/3] powercap/intel_rapl: add support for TigerLake Desktop

Add intel_rapl support for TigerLake desktop platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 6f55aaef8afc..60dbe0e43dd4 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1035,6 +1035,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-- 
2.17.1


