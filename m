Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4030D595
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 09:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhBCIvr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 03:51:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:53813 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhBCIvp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 03:51:45 -0500
IronPort-SDR: cCzr+0jycim8QFx8Dr1dFfejGPHAHLMZsHSpZnwI2eDrnADBKrjovhnYP47XGlbs5OZ/geBlE1
 kvk/cneFW66g==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="245085341"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="245085341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:51:04 -0800
IronPort-SDR: ZNKt+5El5N9Mz9+AjqPQudgHW4Zj4OUdnVqJhfl6yl7V5afCRtPPqBSPad29gBVRqHz6EnPVpO
 aozfyb2dzNAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="392337663"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.173])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2021 00:51:00 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH 1/2] tools/power turbostat: Support Alder Lake P
Date:   Wed,  3 Feb 2021 16:54:26 +0800
Message-Id: <1355736401e160d29326a222fd3af5492883da61.1612341978.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612341978.git.yu.c.chen@intel.com>
References: <cover.1612341978.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Share the code between Alder Lake P and Alder Lake S.

Tested-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea5209a83..34628e3e7099 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4986,6 +4986,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_ROCKETLAKE:
 	case INTEL_FAM6_LAKEFIELD:
 	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
 		return INTEL_FAM6_CANNONLAKE_L;
 
 	case INTEL_FAM6_ATOM_TREMONT_L:
-- 
2.25.1

