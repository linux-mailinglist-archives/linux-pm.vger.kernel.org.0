Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1830611FFE4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLPIeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 03:34:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:14638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfLPIeB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 03:34:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 00:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="217345392"
Received: from rzhang1-mobile.sh.intel.com ([10.239.195.243])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2019 00:33:59 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     x86@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, tony.luck@intel.com,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] powercap/intel_rapl: add support for JasperLake
Date:   Mon, 16 Dec 2019 16:33:45 +0800
Message-Id: <20191216083345.2782-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216083345.2782-1-rui.zhang@intel.com>
References: <20191216083345.2782-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add intel_rapl support for Jasper Lake.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a67701ed93e8..070d5744abd0 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -989,6 +989,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, rapl_defaults_core),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_D, rapl_defaults_core),
 	INTEL_CPU_FAM6(ATOM_TREMONT_D, rapl_defaults_core),
+	INTEL_CPU_FAM6(ATOM_TREMONT_L, rapl_defaults_core),
 
 	INTEL_CPU_FAM6(XEON_PHI_KNL, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(XEON_PHI_KNM, rapl_defaults_hsw_server),
-- 
2.17.1

