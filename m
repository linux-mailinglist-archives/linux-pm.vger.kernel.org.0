Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D83D2906CE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405627AbgJPOJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 10:09:16 -0400
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:51211 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406133AbgJPOJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 10:09:13 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 568BFFBD9D
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 15:09:11 +0100 (IST)
Received: (qmail 5453 invoked from network); 16 Oct 2020 14:09:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Oct 2020 14:09:11 -0000
Date:   Fri, 16 Oct 2020 15:09:09 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201016140909.GV3227@techsingularity.net>
References: <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net>
 <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
 <20201008090909.GP3227@techsingularity.net>
 <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
 <20201008173436.GQ3227@techsingularity.net>
 <f6b04376-4214-ff5d-1069-890449a923e2@intel.com>
 <20201014223703.GT3227@techsingularity.net>
 <20201015183410.GU3227@techsingularity.net>
 <CAJZ5v0jzZ6iQGYNnkgi-pPmdbq3aH+RoH+tBbEoBxFfmt_0MDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jzZ6iQGYNnkgi-pPmdbq3aH+RoH+tBbEoBxFfmt_0MDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 03:41:12PM +0200, Rafael J. Wysocki wrote:
> > Turns out I didn't even have that. On another machine (same model,
> > same cpu, different BIOS that cannot be updated), enabling the C6 state
> > still did not enable it on boot and dmesg complained about CST not being
> > usable. This is weird because one would expect that if CST was unusable
> > that it would be the same as use_acpi == false.
> >
> > This could potentially be if the ACPI tables are unsuitable due to bad
> > bad FFH information for a lower c-state. If _CST is not found or usable,
> > should acpi_state_table.count be reset to go back to the old behaviour?
> 
> Yes, it should, although I would reset it in intel_idle_cst_usable()
> right away before returning 'false'.
> 

Good stuff.

> I can send a patch to do the above or please submit the one below as
> it works too.
> 

I'm happy to go with your alternative if you prefer. For a finish,
I decided it was worth reporting if the _CST was ignored regardless of
the reason. It performs roughly the same as setting use_acpi = false on
the affected machines.

---8<---
intel_idle: Ignore _CST if control cannot be taken from the platform

e6d4f08a6776 ("intel_idle: Use ACPI _CST on server systems") avoids
enabling c-states that have been disabled by the platform with the
exception of C1E.

Unfortunately, BIOS implementations are not always consistent in terms
of how capabilities are advertised and control cannot always be handed
over. If control cannot be handed over then intel_idle reports that "ACPI
_CST not found or not usable" but does not clear acpi_state_table.count
meaning the information is still partially used.

This patch ignores ACPI information if CST control cannot be requested from
the platform. This was only observed on a number of Haswell platforms that
had identical CPUs but not identical BIOS versions.  While this problem
may be rare overall, 24 separate test cases bisected to this specific
commit across 4 separate test machines and is worth addressing. If the
situation occurs, the kernel behaves as it did before commit e6d4f08a6776
and uses any c-states that are discovered.

The affected test cases were all ones that involved a small number of
processes -- exec microbenchmark, pipe microbenchmark, git test suite,
netperf, tbench with one client and system call microbenchmark. Each
case benefits from being able to use turboboost which is prevented if the
lower c-states are unavailable. This may mask real regressions specific
to older hardware so it is worth addressing.

C-state status before and after the patch

5.9.0-vanilla            POLL     latency:0      disabled:0 default:enabled
5.9.0-vanilla            C1       latency:2      disabled:0 default:enabled
5.9.0-vanilla            C1E      latency:10     disabled:0 default:enabled
5.9.0-vanilla            C3       latency:33     disabled:1 default:disabled
5.9.0-vanilla            C6       latency:133    disabled:1 default:disabled
5.9.0-ignore-cst-v1r1    POLL     latency:0      disabled:0 default:enabled
5.9.0-ignore-cst-v1r1    C1       latency:2      disabled:0 default:enabled
5.9.0-ignore-cst-v1r1    C1E      latency:10     disabled:0 default:enabled
5.9.0-ignore-cst-v1r1    C3       latency:33     disabled:0 default:enabled
5.9.0-ignore-cst-v1r1    C6       latency:133    disabled:0 default:enabled

Patch enables C3/C6.

Netperf UDP_STREAM

netperf-udp
                                      5.5.0                  5.9.0
                                    vanilla        ignore-cst-v1r1
Hmean     send-64         193.41 (   0.00%)      226.54 *  17.13%*
Hmean     send-128        392.16 (   0.00%)      450.54 *  14.89%*
Hmean     send-256        769.94 (   0.00%)      881.85 *  14.53%*
Hmean     send-1024      2994.21 (   0.00%)     3468.95 *  15.85%*
Hmean     send-2048      5725.60 (   0.00%)     6628.99 *  15.78%*
Hmean     send-3312      8468.36 (   0.00%)    10288.02 *  21.49%*
Hmean     send-4096     10135.46 (   0.00%)    12387.57 *  22.22%*
Hmean     send-8192     17142.07 (   0.00%)    19748.11 *  15.20%*
Hmean     send-16384    28539.71 (   0.00%)    30084.45 *   5.41%*

Fixes: e6d4f08a6776 ("intel_idle: Use ACPI _CST on server systems")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 drivers/idle/intel_idle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9a810e4a7946..4af2d3f2c8aa 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1212,14 +1212,13 @@ static bool __init intel_idle_acpi_cst_extract(void)
 		if (!intel_idle_cst_usable())
 			continue;
 
-		if (!acpi_processor_claim_cst_control()) {
-			acpi_state_table.count = 0;
-			return false;
-		}
+		if (!acpi_processor_claim_cst_control())
+			break;
 
 		return true;
 	}
 
+	acpi_state_table.count = 0;
 	pr_debug("ACPI _CST not found or not usable\n");
 	return false;
 }
