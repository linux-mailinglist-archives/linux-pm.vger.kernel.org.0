Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6609636948C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhDWOYl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 10:24:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:1726 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239433AbhDWOYk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 10:24:40 -0400
IronPort-SDR: YN3SxdbGSJPH35GwsuWjyJdwEnf92F90PfsmS7UT8VoYsNYn5i+ohc8PkdDxKcr1NIEH4EPW2r
 4g+GrCw6NJ8g==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="176196443"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="176196443"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 07:24:03 -0700
IronPort-SDR: rnqVjzOh+PgNs1niXbmYPkNux5I8Dd2kRUoYSCap5oovzlJiL/2mfqXZ5gIg3wTxodoKb9Lwr5
 6rlNza97J39Q==
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="421775191"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 07:24:01 -0700
Date:   Fri, 23 Apr 2021 22:27:49 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210423142749.GA428460@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
 <20210420143754.GA390118@chenyu-desktop>
 <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
 <20210423121607.GA426003@chenyu-desktop>
 <4080ac25f6c8ca4088a950eb9d63da641c020941.camel@kepstin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4080ac25f6c8ca4088a950eb9d63da641c020941.camel@kepstin.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 10:04:10AM -0400, Calvin Walton wrote:
> On Fri, 2021-04-23 at 20:16 +0800, Chen Yu wrote
> > 
> > Calvin, could you please take a look at the following version if it
> > is suitible?
> 
> I assume this patch is adapted from my earlier submission of the
> complete fix to be an incremental fix on top of the already applied
> patch? If so, you are OK to add
> 
> Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
>
Thanks Calvin. BTW, I did not receive your incremental patch on top of
already applied one, so I post this patch in the name of yours. 
> > From b2e63fe4f02e17289414b4f61237da822df115fb Mon Sep 17 00:00:00
> > 2001
> > From: Calvin Walton <calvin.walton@kepstin.ca>
> > Date: Fri, 23 Apr 2021 17:32:13 +0800
> > Subject: [PATCH 3/5] tools/power turbostat: Fix offset overflow issue
> > in index
> >  converting
> > 
> > The idx_to_offset() function returns type int (32-bit signed), but
> > MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather, would be
> > interpreted as a negative number). The end result is that it hits
> > the if (offset < 0) check in update_msr_sum() resulting in the timer
> > callback for updating the stat in the background when long durations
> > are used to not happen. The similar issue exists in offset_to_idx()
> > and update_msr_sum().
> > 
> > This patch fixes this issue by converting the 'int' type to 'off_t'
> > accordingly.
> 
> This patch covers all of the places I know about which had type issues
> - it should be good. Thanks!
> 
Okay, as per Boris' suggestion, this patch has changed the off_t to unsigned int,
and the print format is kept the same as '%x' without casting, how about this:


From d5923502d0010d5e4d722c2a01ee8bda4a13bf75 Mon Sep 17 00:00:00 2001
From: Calvin Walton <calvin.walton@kepstin.ca>
Date: Fri, 23 Apr 2021 17:32:13 +0800
Subject: [PATCH 3/5] tools/power turbostat: Fix offset overflow issue in index
 converting

The idx_to_offset() function returns type int (32-bit signed), but
MSR_PKG_ENERGY_STAT is u32 and would be interpreted as a negative number.
The end result is that it hits the if (offset < 0) check in update_msr_sum()
which prevents the timer callback from updating the stat in the background when
long durations are used. The similar issue exists in offset_to_idx() and
update_msr_sum().

This patch fixes this issue by converting the 'int' to 'unsigned int'
accordingly.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a211264b57fd..dcde41784059 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -296,9 +296,9 @@ struct msr_sum_array {
 /* The percpu MSR sum array.*/
 struct msr_sum_array *per_cpu_msr_sum;
 
-int idx_to_offset(int idx)
+unsigned int idx_to_offset(int idx)
 {
-	int offset;
+	unsigned int offset;
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
@@ -328,7 +328,7 @@ int idx_to_offset(int idx)
 	return offset;
 }
 
-int offset_to_idx(int offset)
+int offset_to_idx(unsigned int offset)
 {
 	int idx;
 
@@ -3338,7 +3338,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 
 	for (i = IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
 		unsigned long long msr_cur, msr_last;
-		int offset;
+		unsigned int offset;
 
 		if (!idx_valid(i))
 			continue;
-- 
2.25.1

> -- 
> Calvin Walton <calvin.walton@kepstin.ca>
> 
