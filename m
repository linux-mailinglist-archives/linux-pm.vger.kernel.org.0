Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB236D471
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbhD1JGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 05:06:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:46664 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1JGH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Apr 2021 05:06:07 -0400
IronPort-SDR: XpYaQ+wPj9yDF9Oxd+PDgusaFFj7lB9J3G+zSzM24T8YV41u1LFTI0KSNcc/+9stAuDImjDWDh
 1CO9cCj1CNZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="282031124"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="282031124"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 02:05:23 -0700
IronPort-SDR: 5Aoaam7uvDmGnboMp2m4iJXVJ8msCtP8Aj6SHv7pgkoOjkwJqUzomvWFvz7pNjJu4Ieyb7OaZg
 QuPOQqcSLDxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="458084228"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.173])
  by fmsmga002.fm.intel.com with ESMTP; 28 Apr 2021 02:05:20 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     youling257 <youling257@gmail.com>, Kurt Garloff <kurt@garloff.de>,
        Bingsong Si <owen.si@ucloud.cn>,
        "Artem S . Tashkinov" <aros@gmx.com>
Cc:     Terry Bowman <terry.bowman@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Calvin Walton <calvin.walton@kepstin.ca>,
        Borislav Petkov <bp@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
Date:   Wed, 28 Apr 2021 17:09:03 +0800
Message-Id: <3172c45b6e06627e19f3a6f71be7746d89ee8c2e.1619600637.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619600637.git.yu.c.chen@intel.com>
References: <cover.1619600637.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

It was reported that on Zen+ system turbostat started exiting,
which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
offset_to_idx wasn't returning a non-negative index.

This patch combined the modification from Bingsong Si and
Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
MSR_PKG_ENERGY_STATUS.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Reported-by: youling257 <youling257@gmail.com>
Tested-by: youling257 <youling257@gmail.com>
Tested-by: Kurt Garloff <kurt@garloff.de>
Tested-by: Bingsong Si <owen.si@ucloud.cn>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5939615265f1..37759d6c463d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -297,7 +297,10 @@ int idx_to_offset(int idx)
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		offset = MSR_PKG_ENERGY_STATUS;
+		if (do_rapl & RAPL_AMD_F17H)
+			offset = MSR_PKG_ENERGY_STAT;
+		else
+			offset = MSR_PKG_ENERGY_STATUS;
 		break;
 	case IDX_DRAM_ENERGY:
 		offset = MSR_DRAM_ENERGY_STATUS;
@@ -326,6 +329,7 @@ int offset_to_idx(int offset)
 
 	switch (offset) {
 	case MSR_PKG_ENERGY_STATUS:
+	case MSR_PKG_ENERGY_STAT:
 		idx = IDX_PKG_ENERGY;
 		break;
 	case MSR_DRAM_ENERGY_STATUS:
@@ -353,7 +357,7 @@ int idx_valid(int idx)
 {
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		return do_rapl & RAPL_PKG;
+		return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
 	case IDX_DRAM_ENERGY:
 		return do_rapl & RAPL_DRAM;
 	case IDX_PP0_ENERGY:
-- 
2.25.1

