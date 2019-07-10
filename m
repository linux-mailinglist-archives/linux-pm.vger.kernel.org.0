Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87C64767
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 15:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfGJNpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 09:45:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:8351 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfGJNpL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 09:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 06:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170923454"
Received: from ygao39-mobl1.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.255.30.205])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2019 06:45:10 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V3 17/17] powercap/rapl: Add Ice Lake NNPI support to RAPL driver
Date:   Wed, 10 Jul 2019 21:44:38 +0800
Message-Id: <1562766278-7099-18-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562766278-7099-1-git-send-email-rui.zhang@intel.com>
References: <1562766278-7099-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

Enables support for ICL-NNPI, which is a neural network processor for deep
learning inference. From RAPL point of view it is same as Ice Lake Mobile
processor.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index b624a88..9fd6dd3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -975,6 +975,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_MOBILE, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_DESKTOP, rapl_defaults_core),
+	INTEL_CPU_FAM6(ICELAKE_NNPI, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(ICELAKE_XEON_D, rapl_defaults_hsw_server),
 
-- 
2.7.4

