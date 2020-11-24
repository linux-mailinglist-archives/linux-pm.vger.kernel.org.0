Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF672C1B59
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 03:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgKXCPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 21:15:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:31688 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgKXCPu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Nov 2020 21:15:50 -0500
IronPort-SDR: PibJq8XEaKZsf0YvzD7CCcwVJkn7I1FtgI0I98yJEaxQyWFF5Xy5jcgKJ08m8eymM74ObeVWbR
 4RURHuimNgjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168369175"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="168369175"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 18:15:49 -0800
IronPort-SDR: Dr/pLy8FUF0nGfrPoQJpMUyqKJ2yHpmKMwZ8r7imoZeHNmyPZIKmZgBPO2nS8OfnrWGZe5X9dM
 FngoJ13ba4/Q==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="478339232"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 18:15:47 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wendy Wang <wendy.wang@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] tools/power turbostat: Support Ice Lake D
Date:   Tue, 24 Nov 2020 10:18:10 +0800
Message-Id: <20201124021810.32226-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
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
index f3a1746f7f45..f81714d78ecf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4973,6 +4973,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_ATOM_TREMONT;
 
 	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		return INTEL_FAM6_SKYLAKE_X;
 	}
-- 
2.17.1

