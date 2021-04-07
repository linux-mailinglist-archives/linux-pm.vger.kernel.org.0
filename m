Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064753563C1
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhDGGKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 02:10:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:23493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhDGGKl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Apr 2021 02:10:41 -0400
IronPort-SDR: 5i8oDm3nKMWhlrzNLyi2vu9ocoVE8KSJMcrnlg0/xHDmVZGu/l8c4HZngnS6M4BgFdsfZIfzTp
 BIi2AQTPpQVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="193344296"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="193344296"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 23:10:30 -0700
IronPort-SDR: S5x9dEHJ08xW5NjN6YaWzRb+GWM4nAVCIxhD5gcr74aO0K6fwtFSt7B1KX/YGOpBIhdmIbyLTE
 Lx5JThFKWmag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379701369"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 23:10:29 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] intel_idle: add Iclelake-D support
Date:   Wed,  7 Apr 2021 09:10:28 +0300
Message-Id: <20210407061028.3072316-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch adds Icelake Xeon D support to 'intel_idle' driver. Since Icelake D
and Icelake SP C-state characteristics the same, we use Icelake SP C-states
table for Icelake D as well.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/idle/intel_idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3273360f30f7..3c2cdc766203 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1156,6 +1156,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
-- 
2.29.2

