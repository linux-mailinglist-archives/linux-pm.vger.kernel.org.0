Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0DB48411
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfFQNdY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 09:33:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:5446 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFQNdY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 09:33:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 06:33:23 -0700
X-ExtLoop1: 1
Received: from unknown (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.255.29.180])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2019 06:33:22 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 3/3] powercap/intel_rapl: add support for ICX-D
Date:   Mon, 17 Jun 2019 21:33:15 +0800
Message-Id: <1560778395-15088-4-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560778395-15088-1-git-send-email-rui.zhang@intel.com>
References: <1560778395-15088-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add ICX-D support in intel_rapl driver

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 9415070..a722e30 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1147,6 +1147,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_DESKTOP,		rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_X,		rapl_defaults_hsw_server),
+	INTEL_CPU_FAM6(ICELAKE_XEON_D,		rapl_defaults_hsw_server),
 
 	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
-- 
2.7.4

