Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF83136598F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 15:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhDTNM0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 09:12:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:40627 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232197AbhDTNMZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 09:12:25 -0400
IronPort-SDR: JPr5pjSstdXwC4OUIxfhdeZB1awBcBDArASyTNAeCXYkWCj11smrj/MTFUG6kVymOyxe4qFwIP
 l/ZoQtHA7rFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195616720"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="195616720"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:11:54 -0700
IronPort-SDR: rEkL+YshqyHjU36iExYVoiBAhkKaHFNZYcoQ0NSHs3ysYaB+t9B7KsbzIwggPGtRZPju85ONbY
 kaUI4LYC5qVw==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="420404669"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:11:51 -0700
Date:   Tue, 20 Apr 2021 21:15:41 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        calvin.walton@kepstin.ca, wei.huang2@amd.com, aros@gmx.com,
        yu.c.chen@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210420131541.GA388877@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420080701.GA2326@zn.tnic>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 10:07:01AM +0200, Borislav Petkov wrote:
> On Tue, Apr 20, 2021 at 10:03:36AM +0800, Chen Yu wrote:
> > On Mon, Apr 19, 2021 at 02:58:12PM -0500, Terry Bowman wrote:
> > > Turbostat fails to correctly collect and display RAPL summary information
> > > on Family 17h and 19h AMD processors. Running turbostat on these processors
> > > returns immediately. If turbostat is working correctly then RAPL summary
> > > data is displayed until the user provided command completes. If a command
> > > is not provided by the user then turbostat is designed to continuously
> > > display RAPL information until interrupted.
> > > 
> > > The issue is due to offset_to_idx() and idx_to_offset() missing support for
> > > AMD MSR addresses/offsets. offset_to_idx()'s switch statement is missing
> > > cases for AMD MSRs and idx_to_offset() does not include a path to return
> > > AMD MSR(s) for any idx.
> > > 
> > > The solution is add AMD MSR support to offset_to_idx() and idx_to_offset().
> > > These functions are split-out and renamed along architecture vendor lines
> > > for supporting both AMD and Intel MSRs.
> > > 
> > > Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Thanks for fixing, Terry, and previously there was a patch for this from Bas Nieuwenhuizen:
> > https://lkml.org/lkml/2021/3/12/682
> > and it is expected to have been merged in Len's branch already.
> 
> Expected?
> 
> So is it or is it not?
>
This patch was sent to Len and it is not in public repo yet. He is preparing for a new
release of turbostat as merge window is approaching.
> And can you folks agree on a patch already and give it to Artem for
> testing (CCed) because he's triggering it too:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=212357
> 
Okay. I would vote for the the patch from Bas as it was a combined work from two
authors and tested by several AMD users. But let me paste it here too for Artem to
see if this also works for him:


From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 12 Mar 2021 21:27:40 +0800
Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs

It was reported that on Zen+ system turbostat started exiting,
which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
offset_to_idx wasn't returning a non-negative index.

This patch combined the modification from Bingsong Si and
Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
MSR_PKG_ENERGY_STATUS.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Reported-by: youling257 <youling257@gmail.com>
Tested-by: youling257 <youling257@gmail.com>
Tested-by: sibingsong <owen.si@ucloud.cn>
Tested-by: Kurt Garloff <kurt@garloff.de>
Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a7c4f0772e53..a7c965734fdf 100644
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


thanks,
Chenyu

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
