Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B944E263EF7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIJHtS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 03:49:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:26351 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgIJHtQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Sep 2020 03:49:16 -0400
IronPort-SDR: noE9taLUObXFJSR0fR6OwZsjVcFBRTDAOYR0lRTHE6Ixa9k17dNjcbCz/EnMwm89Imromi0u3A
 hKrMZk2M4RBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="155947292"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208,223";a="155947292"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:49:16 -0700
IronPort-SDR: saEGm+Xv05+p41oOzC3Zbh3UA4ULVJ7y3s/qwoTvVA3wsaVDgGuPvUHfEpt/Ild4pVqUIY21ns
 55GwUD4HV33w==
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208,223";a="317820581"
Received: from jhou15-mobl1.ccr.corp.intel.com ([10.255.29.228])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:49:14 -0700
Message-ID: <a7843d269db1ebac86006b5413975bc295a24146.camel@intel.com>
Subject: [PATCH 2/3] powercap/intel_rapl: add support for RocketLake
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Thu, 10 Sep 2020 15:49:11 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From 8db84f6b712132bca3e124484d00d5ae42b4c522 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 9 Sep 2020 22:37:35 +0800
Subject: [PATCH 2/3] powercap/intel_rapl: add support for RocketLake

Add intel_rapl support for RocketLake platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 60dbe0e43dd4..55a219e968b3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1036,6 +1036,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-- 
2.17.1


