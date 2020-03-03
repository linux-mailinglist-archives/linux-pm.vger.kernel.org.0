Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C917720D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 10:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgCCJKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 04:10:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:59453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgCCJKE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 04:10:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 01:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="232207666"
Received: from cliew10-mobl.gar.corp.intel.com (HELO M5530.gar.corp.intel.com) ([10.255.138.251])
  by fmsmga007.fm.intel.com with ESMTP; 03 Mar 2020 01:10:00 -0800
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v3] intel_idle: Add Comet Lake support
Date:   Tue,  3 Mar 2020 17:09:57 +0800
Message-Id: <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a general C-state table in order to support Comet Lake.

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 drivers/idle/intel_idle.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d55606608ac8..05bce595fafe 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1067,6 +1067,11 @@ static const struct idle_cpu idle_cpu_dnv = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_cml = {
+	.state_table = skl_cstates,
+	.disable_promotion_to_c1e = true,
+};
+
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(NEHALEM_EP,		idle_cpu_nhx),
 	INTEL_CPU_FAM6(NEHALEM,			idle_cpu_nehalem),
@@ -1105,6 +1110,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_D,		idle_cpu_dnv),
 	INTEL_CPU_FAM6(ATOM_TREMONT_D,		idle_cpu_dnv),
+	INTEL_CPU_FAM6(COMETLAKE_L,		idle_cpu_cml),
+	INTEL_CPU_FAM6(COMETLAKE,		idle_cpu_cml),
 	{}
 };
 
-- 
2.24.1

