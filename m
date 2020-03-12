Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BF182C60
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLJZ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 05:25:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:15029 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCLJZ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 05:25:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 02:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="322413259"
Received: from schin20-mobl2.gar.corp.intel.com (HELO M5530.gar.corp.intel.com) ([10.249.69.254])
  by orsmga001.jf.intel.com with ESMTP; 12 Mar 2020 02:25:24 -0700
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v5] intel_idle: Add Comet Lake support
Date:   Thu, 12 Mar 2020 17:25:20 +0800
Message-Id: <20200312172457.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304194312.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
References: <20200304194312.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add built-in idle states table for Comet Lake.

This patch also respects the exposed ACPI _CST objects in platform firmware
to disable those non-matching C-state by default, defer its enabling to the
userspace through sysfs.

Summary:
 - With built-in table and without _CST table, all C-states are enabled
 - With both built-in and _CST tables, matching C-states are enabled

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 drivers/idle/intel_idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d55606608ac8..49b385c36eea 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1067,6 +1067,12 @@ static const struct idle_cpu idle_cpu_dnv = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_cml = {
+	.state_table = skl_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(NEHALEM_EP,		idle_cpu_nhx),
 	INTEL_CPU_FAM6(NEHALEM,			idle_cpu_nehalem),
@@ -1105,6 +1111,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_D,		idle_cpu_dnv),
 	INTEL_CPU_FAM6(ATOM_TREMONT_D,		idle_cpu_dnv),
+	INTEL_CPU_FAM6(COMETLAKE_L,		idle_cpu_cml),
+	INTEL_CPU_FAM6(COMETLAKE,		idle_cpu_cml),
 	{}
 };
 
-- 
2.24.1

