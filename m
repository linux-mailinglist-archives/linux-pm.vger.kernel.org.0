Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4724C36D478
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhD1JGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 05:06:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:37426 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237995AbhD1JGR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Apr 2021 05:06:17 -0400
IronPort-SDR: YvRvMJjQP9sSqg3CASik2pSG8ZHHPyBVLJ/uag0x21Ktb5vqQ2Cnwxxc4gUgBbl6ogMZMhhxl6
 OzDuaC8BowwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="176176420"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="176176420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 02:05:32 -0700
IronPort-SDR: PwIgUXmzgjn8bi3GeVIzjJ1gcB0DhsL8DJ8zLPSXYIL5SNVovySYeXVz/ejif7dW8aCXdtuP2E
 xbjoQr41t/bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="458084311"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.173])
  by fmsmga002.fm.intel.com with ESMTP; 28 Apr 2021 02:05:30 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     youling257 <youling257@gmail.com>, Kurt Garloff <kurt@garloff.de>,
        Bingsong Si <owen.si@ucloud.cn>,
        "Artem S . Tashkinov" <aros@gmx.com>
Cc:     Terry Bowman <terry.bowman@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Calvin Walton <calvin.walton@kepstin.ca>,
        Borislav Petkov <bp@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/power turbostat: Fix offset overflow issue in index converting
Date:   Wed, 28 Apr 2021 17:09:16 +0800
Message-Id: <8167875a1d688b92b0ec707b95855a604afacf01.1619600637.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619600637.git.yu.c.chen@intel.com>
References: <cover.1619600637.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Calvin Walton <calvin.walton@kepstin.ca>

The idx_to_offset() function returns type int (32-bit signed), but
MSR_PKG_ENERGY_STAT is u32 and would be interpreted as a negative number.
The end result is that it hits the if (offset < 0) check in update_msr_sum()
which prevents the timer callback from updating the stat in the background when
long durations are used. The similar issue exists in offset_to_idx() and
update_msr_sum(). Fix this issue by converting the 'int' to 'off_t' accordingly.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
---
 tools/power/x86/turbostat/turbostat.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 37759d6c463d..085057daef86 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -291,9 +291,9 @@ struct msr_sum_array {
 /* The percpu MSR sum array.*/
 struct msr_sum_array *per_cpu_msr_sum;
 
-int idx_to_offset(int idx)
+off_t idx_to_offset(int idx)
 {
-	int offset;
+	off_t offset;
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
@@ -323,7 +323,7 @@ int idx_to_offset(int idx)
 	return offset;
 }
 
-int offset_to_idx(int offset)
+int offset_to_idx(off_t offset)
 {
 	int idx;
 
@@ -3276,7 +3276,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 
 	for (i = IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
 		unsigned long long msr_cur, msr_last;
-		int offset;
+		off_t offset;
 
 		if (!idx_valid(i))
 			continue;
@@ -3285,7 +3285,8 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 			continue;
 		ret = get_msr(cpu, offset, &msr_cur);
 		if (ret) {
-			fprintf(outf, "Can not update msr(0x%x)\n", offset);
+			fprintf(outf, "Can not update msr(0x%llx)\n",
+				(unsigned long long)offset);
 			continue;
 		}
 
-- 
2.25.1

