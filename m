Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501CC3691CC
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 14:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbhDWMM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 08:12:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:43144 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhDWMM6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 08:12:58 -0400
IronPort-SDR: jYYpHDndd0T/zufYQoveVcg2eml7WeqawpWmT3HjYxCd+kR/wwiJFbTzGzMIPny/d1AleYaq+E
 lRR1vR1qB/pA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281386548"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="281386548"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 05:12:21 -0700
IronPort-SDR: 0lMZZPTxBtDnzuDdNKXYuRNdnnRJQ2ddD09lZisxSkqMCkkgLb0FmxuFzZqGVrjrcDCrv68zNK
 Bb+fWvx4e2cQ==
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="428362453"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 05:12:19 -0700
Date:   Fri, 23 Apr 2021 20:16:07 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210423121607.GA426003@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
 <20210420143754.GA390118@chenyu-desktop>
 <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 10:42:09AM -0400, Calvin Walton wrote:
> On Tue, 2021-04-20 at 22:37 +0800, Chen Yu wrote:
> > On Tue, Apr 20, 2021 at 09:28:06AM -0400, Calvin Walton wrote:
> > > This patch has the same issue I noticed with the initial revision
> > > of
> > > Terry's patch - the idx_to_offset function returns type int (32-bit
> > > signed), but MSR_PKG_ENERGY_STAT is greater than INT_MAX (or
> > > rather,
> > > would be interpreted as a negative number)
> > > 
> > > The end result is, as far as I can tell, that it hits the if
> > > (offset <
> > > 0) check in update_msr_sum() resulting in the timer callback for
> > > updating the stat in the background when long durations are used to
> > > not
> > > happen.
> > > 
> > > For short durations it still works fine since the background update
> > > isn't used.
> > > 
> > Ah, got it, nice catch. How about an incremental patch based on Bas'
> > one
> > to fix this 'overflow' issue? Would converting offset_to_idx(),
> > idx_to_offset() and
> > update_msr_sum() to use off_t instead of int be enough? Do you or
> > Terry have interest
> > to cook that patch? For Terry's version, I'm not sure if spliting
> > the code into different CPU vendor would benefit in the future,
> > except
> > that we would have plenty of new MSRs to be introduced in the future.
> 
> Yes, I believe updating the offset_to_idx(), idx_to_offset(), and
> update_msr_sum() functions is sufficient. I can do the incremental
> patch for that this evening if nobody beats me to it :)
>
Calvin, could you please take a look at the following version if it is suitible?

From b2e63fe4f02e17289414b4f61237da822df115fb Mon Sep 17 00:00:00 2001
From: Calvin Walton <calvin.walton@kepstin.ca>
Date: Fri, 23 Apr 2021 17:32:13 +0800
Subject: [PATCH 3/5] tools/power turbostat: Fix offset overflow issue in index
 converting

The idx_to_offset() function returns type int (32-bit signed), but
MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather, would be
interpreted as a negative number). The end result is that it hits
the if (offset < 0) check in update_msr_sum() resulting in the timer
callback for updating the stat in the background when long durations
are used to not happen. The similar issue exists in offset_to_idx()
and update_msr_sum().

This patch fixes this issue by converting the 'int' type to 'off_t'
accordingly.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a211264b57fd..77557122b292 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -296,9 +296,9 @@ struct msr_sum_array {
 /* The percpu MSR sum array.*/
 struct msr_sum_array *per_cpu_msr_sum;
 
-int idx_to_offset(int idx)
+off_t idx_to_offset(int idx)
 {
-	int offset;
+	off_t offset;
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
@@ -328,7 +328,7 @@ int idx_to_offset(int idx)
 	return offset;
 }
 
-int offset_to_idx(int offset)
+int offset_to_idx(off_t offset)
 {
 	int idx;
 
@@ -3338,7 +3338,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 
 	for (i = IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
 		unsigned long long msr_cur, msr_last;
-		int offset;
+		off_t offset;
 
 		if (!idx_valid(i))
 			continue;
@@ -3347,7 +3347,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 			continue;
 		ret = get_msr(cpu, offset, &msr_cur);
 		if (ret) {
-			fprintf(outf, "Can not update msr(0x%x)\n", offset);
+			fprintf(outf, "Can not update msr(0x%llx)\n", (long long int)offset);
 			continue;
 		}

thanks,
Chenyu 
-- 
2.25.1

 
> -- 
> Calvin Walton <calvin.walton@kepstin.ca>
> 
