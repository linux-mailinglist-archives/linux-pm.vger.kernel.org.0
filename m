Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C9C1221BA
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 02:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfLQB4f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 20:56:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:31847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLQB4e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 20:56:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="389661315"
Received: from rzhang1-mobile.sh.intel.com ([10.239.195.243])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2019 17:56:32 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] powercap/intel_rapl: add support for TigerLake Mobile
Date:   Tue, 17 Dec 2019 09:56:23 +0800
Message-Id: <20191217015623.10073-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add TigerLake Mobile support in intel_rapl driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a67701ed93e8..9f4119c42651 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -980,6 +980,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(ICELAKE_D, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(COMETLAKE_L, rapl_defaults_core),
 	INTEL_CPU_FAM6(COMETLAKE, rapl_defaults_core),
+	INTEL_CPU_FAM6(TIGERLAKE_L, rapl_defaults_core),
 
 	INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
 	INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
-- 
2.17.1

