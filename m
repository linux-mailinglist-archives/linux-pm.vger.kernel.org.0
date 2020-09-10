Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBC263EF9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 09:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIJHt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 03:49:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:11940 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgIJHtZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Sep 2020 03:49:25 -0400
IronPort-SDR: 03wO0rqOTRrsAutDjjhcWhoeUgkqlb7Iy1vLOnp3mcMFLis0/o//QXfTpESo/1gCDjES+TeR1B
 pOCvNXMocl8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158522452"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208,223";a="158522452"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:49:25 -0700
IronPort-SDR: voETmE1X0Gaf/K5ElS9MwFuj3PRIS9p+j/7z2/qvAJGkrwNMjaRFirvQNZpyVwo8lTPwAukInr
 jMffyRKFuKSQ==
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208,223";a="285147160"
Received: from jhou15-mobl1.ccr.corp.intel.com ([10.255.29.228])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:49:23 -0700
Message-ID: <9a26e733f331218768f2001ed5d5801b5b6fcd2d.camel@intel.com>
Subject: [PATCH 3/3] powercap/intel_rapl: add support for AlderLake
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Thu, 10 Sep 2020 15:49:21 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From d8f5447e909914317db8582521ebf0fb51cd853e Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 9 Sep 2020 22:39:01 +0800
Subject: [PATCH 3/3] powercap/intel_rapl: add support for AlderLake

Add intel_rapl support for AlderLake platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 55a219e968b3..25c764905f9b 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1037,6 +1037,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-- 
2.17.1


