Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B2F27B00A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1Ogi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 10:36:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:15624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgI1Ogi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Sep 2020 10:36:38 -0400
IronPort-SDR: M3g+HLk2PIalw2WgbrK1K0Kl+TrsaSTF13O+xrPgjuqi6hNBiNF0gn0H/wY4NRk9Knm9iv6Un1
 JIbx5mBQGSRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226150015"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208,223";a="226150015"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 07:36:38 -0700
IronPort-SDR: TosxMyTyx96L5a/Bgu+oreZfZlS5D7K/GkM3Ti1oCt/z+9iqReLUqguKFgSn/fq852zKPLdB7/
 FO4nAG1zidoQ==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208,223";a="488603680"
Received: from zhangch3-mobl.ccr.corp.intel.com ([10.249.175.1])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 07:36:36 -0700
Message-ID: <89e655dbf96777b897ceb721f82be0d5ea7210e0.camel@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix missing return statement
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Mon, 28 Sep 2020 22:36:34 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From 1027ed2cacb0b50676eb52dd0089076d951033d7 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 28 Sep 2020 11:33:42 +0800
Subject: [PATCH] cpufreq: intel_pstate: Fix missing return statement

Fix missing return statement when writing "off" to intel_pstate status
sysfs I/F.

Fixes: 55671ea3257a ("cpufreq: intel_pstate: Free memory only when turning off")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a827b000ef51..9a515c460a00 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2781,6 +2781,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 
 		cpufreq_unregister_driver(intel_pstate_driver);
 		intel_pstate_driver_cleanup();
+		return 0;
 	}
 
 	if (size == 6 && !strncmp(buf, "active", size)) {
-- 
2.17.1


