Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C2135573
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 10:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgAIJSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 04:18:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:8755 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgAIJSQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jan 2020 04:18:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 01:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="246606171"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 01:18:14 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Zhang <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] tools/power turbostat: Add Elkhart Lake support
Date:   Thu,  9 Jan 2020 17:17:01 +0800
Message-Id: <20200109091701.8197-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Elkhart Lake(TREMONT) succeed GOLDMONT, reuse the code.

Elkhart Lake does not support group turbo limit counter
register and might trigger failure in has_turbo_ratio_group_limits(),
so it is not applicable to reuse GOLDMONT cpuid in intel_model_duplicates().

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5d0fddda842c..2d3d0a3d5e07 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3265,6 +3265,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
+	case INTEL_FAM6_ATOM_TREMONT:	/* ELK */
 		pkg_cstate_limits = glm_pkg_cstate_limits;
 		break;
 	default:
@@ -3888,6 +3889,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_TREMONT:	/* ELK */
 		do_rapl = RAPL_PKG | RAPL_PKG_POWER_INFO;
 		if (rapl_joules)
 			BIC_PRESENT(BIC_Pkg_J);
@@ -4295,6 +4297,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
+	case INTEL_FAM6_ATOM_TREMONT:		/* ELK */
 		return 1;
 	}
 	return 0;
@@ -4324,6 +4327,7 @@ int has_c8910_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_TREMONT:	/* ELK */
 		return 1;
 	}
 	return 0;
-- 
2.17.1

