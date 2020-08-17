Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A734B24602F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHQIbV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 04:31:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:1808 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgHQIbV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 04:31:21 -0400
IronPort-SDR: 8dTlWI76XhtspZhuWhxnXqRFBetY563pZ1St6IJCW7SMbERy9mIl1k0mwmf4C8cab0v2mRifd6
 eo2uUxOifkcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="142284607"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="142284607"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:31:20 -0700
IronPort-SDR: 3H0imvvqwXYvalrcURB4ZVobiAarxMXgSw6lf9x2eqV5SI+GV4MUYrcqDXTJrPae8Bu5XIQNhP
 kFOSTAAyMv7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="440798680"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2020 01:31:18 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] tools/power turbostat: Support Sapphire Rapids
Date:   Mon, 17 Aug 2020 16:32:23 +0800
Message-Id: <20200817083223.18697-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enumerate Saphire Rapids.
Treat it like Sky Lake and Ice Lake server in turbostat.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..bf09f8bc000b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4694,6 +4694,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_ATOM_TREMONT;
 
 	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		return INTEL_FAM6_SKYLAKE_X;
 	}
 	return model;
-- 
2.17.1

