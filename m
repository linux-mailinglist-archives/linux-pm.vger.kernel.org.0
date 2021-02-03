Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC330D597
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 09:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhBCIvz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 03:51:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:35695 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233053AbhBCIvy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 03:51:54 -0500
IronPort-SDR: AHgleIZ7uXYE3P7Hm97cW4jYrMFBRqdRvKyCA086gmJAWgozol2ZTU6fmPvkNDXgJ/592zZEZl
 CHGM8mYvPgQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160769574"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="160769574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:51:13 -0800
IronPort-SDR: aSAv4mGarYqxl8FCjqWcnHA9yN7jxJjGnsdWkZ/8cciHBoFdPyYAAFq5aUWdJu7YfLS8pwljpz
 9oCbmanY1pbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="392337738"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.173])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2021 00:51:09 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH 2/2] tools/power turbostat: Support Ice Lake D
Date:   Wed,  3 Feb 2021 16:54:36 +0800
Message-Id: <fbf91a90f6414379dff110f9430122670487ffa4.1612341978.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612341978.git.yu.c.chen@intel.com>
References: <cover.1612341978.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ice Lake D is low-end server version of Ice Lake X, reuse
the code accordingly.

Tested-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 34628e3e7099..d3c2ef91ac49 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4993,6 +4993,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_ATOM_TREMONT;
 
 	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		return INTEL_FAM6_SKYLAKE_X;
 	}
-- 
2.25.1

