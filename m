Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0150628C980
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbgJMHmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 03:42:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:42706 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390040AbgJMHmo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 03:42:44 -0400
IronPort-SDR: 2lqU9iT9h+XszXVTuBCrcPBx6WJYdwazeycywvEp9PeCzAF2wp22ZNkEnudpNcSFyazzzhCvmH
 6YnpjtVwOW2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165928900"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="165928900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 00:42:43 -0700
IronPort-SDR: UiMy9DDcO+a7ju4aqHBDk7Z5lhpSaf7PKo5w6BeDmaytbp1rL8Bg6Eh/5/+IX3BOpGLGH2tmOz
 y3Rnl1XjOFuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="318210256"
Received: from lkp-server02.sh.intel.com (HELO inn.sh.intel.com) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2020 00:42:42 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 1/2] powercap/intel_rapl: Fix domain detection
Date:   Tue, 13 Oct 2020 15:42:40 +0800
Message-Id: <20201013074241.8797-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As only the low 32 bits of the RAPL_DOMAIN_REG_STATUS register
represents the energy counter, and the high 32 bits are reserved,
detecting the existence of a RAPL domain by checking the low 32 bits only.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 983d75bd5bd1..2651ea6cd6d3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1228,7 +1228,7 @@ static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 	 * values, otherwise skip it.
 	 */
 
-	ra.mask = ~0;
+	ra.mask = ENERGY_STATUS_MASK;
 	if (rp->priv->read_raw(cpu, &ra) || !ra.value)
 		return -ENODEV;
 
-- 
2.17.1

