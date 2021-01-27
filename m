Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D45305D1D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 14:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhA0N1d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 08:27:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:6122 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238328AbhA0NZ2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 08:25:28 -0500
IronPort-SDR: e9V1Cqb77SvbpOwCBDyh5PsYqTb/H6n9FpDSlh8emYkDt2Icb5jboCeCZ8cKk+2k48mCz61fLp
 /l2Fnjfx3n8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177500299"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="177500299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 05:24:46 -0800
IronPort-SDR: hrTlhC4YlaoeQSEq/w5rYJSKrxkyrKkgN/Qy2aq4c40njQySDoY/4nghRO7DCc/0D7E5S+7Yuc
 sjvib9PcZBMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="573274965"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2021 05:24:44 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] tools/power/turbostat: fix compatibility with older kernels
Date:   Wed, 27 Jan 2021 15:24:44 +0200
Message-Id: <20210127132444.981120-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Commit

6d6501d912a9 tools/power/turbostat: Read energy_perf_bias from sysfs

added a useful EPB print by reading EPB from sysfs's 'energy_perf_bias' file.
However, older kernels, which do not necessarily have that sysfs file (e.g.,
Centos 7's stock kernel does not have it). As a result, turbostat fails with
older kernels.

This patch fixes the problem by ignoring the sysfs file read errors.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea5209a83..12e014f2c24b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1839,7 +1839,9 @@ int get_epb(int cpu)
 
 	sprintf(path, "/sys/devices/system/cpu/cpu%d/power/energy_perf_bias", cpu);
 
-	fp = fopen_or_die(path, "r");
+	fp = fopen(path, "r");
+	if (!fp)
+		return -1;
 
 	ret = fscanf(fp, "%d", &epb);
 	if (ret != 1)
-- 
2.26.2

