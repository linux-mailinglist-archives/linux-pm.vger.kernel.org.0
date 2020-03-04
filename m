Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5673E178FB0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 12:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgCDLnZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 06:43:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:24267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgCDLnZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 06:43:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 03:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="352086389"
Received: from dbalacha-mobl2.gar.corp.intel.com (HELO M5530.gar.corp.intel.com) ([10.255.141.246])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2020 03:43:22 -0800
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v4] intel_idle: Add Comet Lake support
Date:   Wed,  4 Mar 2020 19:43:18 +0800
Message-Id: <20200304194312.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
References: <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a general C-state table in order to support Comet Lake.

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d55606608ac8..d838143f1422 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1105,6 +1105,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_D,		idle_cpu_dnv),
 	INTEL_CPU_FAM6(ATOM_TREMONT_D,		idle_cpu_dnv),
+	INTEL_CPU_FAM6(COMETLAKE_L,		idle_cpu_skl),
+	INTEL_CPU_FAM6(COMETLAKE,		idle_cpu_skl),
 	{}
 };
 
-- 
2.24.1

