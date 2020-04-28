Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4542A1BB48B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD1D1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 23:27:53 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48986 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgD1D1x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 23:27:53 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49B6Xm3wVYzFfJS;
        Mon, 27 Apr 2020 20:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588044472; bh=OUvPn4857xjzmIdpRHlPfk4A3+oc/m+VQZSSPSRUtdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWoF6PdNLPoNM7FQVKvzx2PR0WgcHnlhNC0IQ5qnKgchAt993XuclcGkyzBmlJTss
         GTvv+9yv8BQLB9PeSKes6Grs3QWtwlbZAg6MIJvCu6GkWwBq0cHM7HmHiZukOz2ywS
         QMAMckZkRHLRPd/PeSWY5Upv1x25Qyz++udxs+vY=
X-Riseup-User-ID: B6E7B908794E27E54288B204451D218F4CA8D016D1D825F1B336F55B4745D5EA
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49B6Xm1p73zJqbk;
        Mon, 27 Apr 2020 20:27:52 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHv2.99 10/11] OPTIONAL: cpufreq: intel_pstate: Add tracing of VLP controller status.
Date:   Mon, 27 Apr 2020 20:22:57 -0700
Message-Id: <20200428032258.2518-11-currojerez@riseup.net>
In-Reply-To: <20200428032258.2518-1-currojerez@riseup.net>
References: <20200428032258.2518-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/cpufreq/intel_pstate.c |  9 ++++++---
 include/trace/events/power.h   | 13 +++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2458a821195f..dd86505d7855 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2242,7 +2242,8 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 		sample->aperf,
 		sample->tsc,
 		get_avg_frequency(cpu),
-		fp_toint(cpu->iowait_boost * 100));
+		fp_toint(cpu->iowait_boost * 100),
+		cpu->vlp.status.value);
 }
 
 static void intel_pstate_adjust_pstate_range(struct cpudata *cpu,
@@ -2282,7 +2283,8 @@ static void intel_pstate_adjust_pstate_range(struct cpudata *cpu,
 			    sample->aperf,
 			    sample->tsc,
 			    get_avg_frequency(cpu),
-			    fp_toint(cpu->iowait_boost * 100));
+			    fp_toint(cpu->iowait_boost * 100),
+			    cpu->vlp.status.value);
 }
 
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
@@ -2789,7 +2791,8 @@ static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, in
 		sample->aperf,
 		sample->tsc,
 		get_avg_frequency(cpu),
-		fp_toint(cpu->iowait_boost * 100));
+		fp_toint(cpu->iowait_boost * 100),
+		0);
 }
 
 static int intel_cpufreq_target(struct cpufreq_policy *policy,
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 9065a3b084c4..57153d82547c 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -72,7 +72,8 @@ TRACE_EVENT(pstate_sample,
 		u64 aperf,
 		u64 tsc,
 		u32 freq,
-		u32 io_boost
+		u32 io_boost,
+		u32 vlp_status
 		),
 
 	TP_ARGS(core_busy,
@@ -83,7 +84,8 @@ TRACE_EVENT(pstate_sample,
 		aperf,
 		tsc,
 		freq,
-		io_boost
+		io_boost,
+		vlp_status
 		),
 
 	TP_STRUCT__entry(
@@ -96,6 +98,7 @@ TRACE_EVENT(pstate_sample,
 		__field(u64, tsc)
 		__field(u32, freq)
 		__field(u32, io_boost)
+		__field(u32, vlp_status)
 		),
 
 	TP_fast_assign(
@@ -108,9 +111,10 @@ TRACE_EVENT(pstate_sample,
 		__entry->tsc = tsc;
 		__entry->freq = freq;
 		__entry->io_boost = io_boost;
+		__entry->vlp_status = vlp_status;
 		),
 
-	TP_printk("core_busy=%lu scaled=%lu from=%lu to=%lu mperf=%llu aperf=%llu tsc=%llu freq=%lu io_boost=%lu",
+	TP_printk("core_busy=%lu scaled=%lu from=%lu to=%lu mperf=%llu aperf=%llu tsc=%llu freq=%lu io_boost=%lu vlp=%lu",
 		(unsigned long)__entry->core_busy,
 		(unsigned long)__entry->scaled_busy,
 		(unsigned long)__entry->from,
@@ -119,7 +123,8 @@ TRACE_EVENT(pstate_sample,
 		(unsigned long long)__entry->aperf,
 		(unsigned long long)__entry->tsc,
 		(unsigned long)__entry->freq,
-		(unsigned long)__entry->io_boost
+		(unsigned long)__entry->io_boost,
+		(unsigned long)__entry->vlp_status
 		)
 
 );
-- 
2.22.1

