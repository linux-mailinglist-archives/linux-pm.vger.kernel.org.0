Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C7F170628
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgBZReS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 12:34:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:9854 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgBZReS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Feb 2020 12:34:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 09:34:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="436710796"
Received: from yoyochua-mobl2.gar.corp.intel.com (HELO M5530.gar.corp.intel.com) ([10.249.74.169])
  by fmsmga005.fm.intel.com with ESMTP; 26 Feb 2020 09:34:15 -0800
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] intel_idle: Add Comet Lake support
Date:   Thu, 27 Feb 2020 01:34:13 +0800
Message-Id: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Comet Lake ID to enable intel_idle driver support.
This is required for PC10 and S0ix.

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 347b08b56042..3cf292b2b7f1 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1086,6 +1086,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(KABYLAKE_L,		idle_cpu_skl),
 	INTEL_CPU_FAM6(KABYLAKE,		idle_cpu_skl),
 	INTEL_CPU_FAM6(SKYLAKE_X,		idle_cpu_skx),
+	INTEL_CPU_FAM6(COMETLAKE_L,		idle_cpu_skl),
+	INTEL_CPU_FAM6(COMETLAKE,		idle_cpu_skl),
 	INTEL_CPU_FAM6(XEON_PHI_KNL,		idle_cpu_knl),
 	INTEL_CPU_FAM6(XEON_PHI_KNM,		idle_cpu_knl),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT,		idle_cpu_bxt),
-- 
2.24.1

