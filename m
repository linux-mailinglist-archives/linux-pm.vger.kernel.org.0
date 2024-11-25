Return-Path: <linux-pm+bounces-18065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35559D871E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55426280E18
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF71ADFF1;
	Mon, 25 Nov 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V4jK/lhe"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE219258B;
	Mon, 25 Nov 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542798; cv=none; b=ocGnhb9u2BNCcR3YOfrt4hbXD3Z9CoHLT1SUwvMSuIv+uy8GQ/KRsVWXTv0CgL0diMLPMTwCGgoC5NdQktxjGLt6kVeuc7B8UdgyFAQ8hIX5Aopp9m+b5b9xsjXIFHXfHSyXVZ96UCuY1irB4puR4YVJFGOgea8JgP03jH8LENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542798; c=relaxed/simple;
	bh=XWCUwK/PoYcAAs49Ifxn10vi0EHgoAQd3CWIIPNoMzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxQfQxHeaoH4Z8qRTukMGG1FAzX2NyQPxkI6tmgtyQizzjTTZoO9t9o9nXnG216un0fS0dzlBkegDVOoNNmkn35wgDQPuuCCIG3IP4kzfWmfMA8MTGhjv8hdWzW667I1h0/VOKEP+9C0GCnjsFGPmI/DzKFwinYJQlY7Km7HgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V4jK/lhe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+9kxOqXrdQ208afg/L+x+CLtYAQ1dTZIvKG5Q7kB1Ts=; b=V4jK/lhe320XVTxP5O7yCxVm7b
	B/N6Z/Lwl6CwbuW1StowZ0u2ULgN30cMT5nCMAOrZTOctdNBbZVuIg8DsONYtD9/Sn3NZnVlgSlSz
	HB/wOTcxCl38W7wRHrC5nnpBVYS6Cr8JTvYIeLZbfH9fGSchDwsPNEPzeWqDsEcBkUIk9u+x8tOCH
	tpAsbRj9y5BzcPIt2bO4b6osu+IErqJds2loebxHiaqTUr5svVbLBvW06QxhScr9hGwmTkPX19tdb
	g/sNK4WT/HKxeLRdA6rQtGzuwUSp2SkZhYLHjphqqAO7SI06pj2gB7In0RnWFZMvW+6MSTCwJRA+d
	hbKke19Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFZWV-000000015nr-1GF3;
	Mon, 25 Nov 2024 13:53:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D33B130026A; Mon, 25 Nov 2024 14:53:06 +0100 (CET)
Date: Mon, 25 Nov 2024 14:53:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, gautham.shenoy@amd.com
Subject: Re: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for
 SRF
Message-ID: <20241125135306.GD38837@noisy.programming.kicks-ass.net>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com>

On Mon, Nov 25, 2024 at 02:20:26PM +0100, Patryk Wlazlyn wrote:
> Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
>     C6S  (hint 0x22)
>     C6SP (hint 0x23)
> 
> Hints 0x20 and 0x21 are skipped entirely, causing the generic
> implementation in mwait_play_dead() to compute the wrong hint, when
> looking for the deepest cstate. As a result, package with an offlined
> CPU can never reach PC6.
> 
> Define the enter_dead() handler for SRF.

How about you do something like so instead?

---
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8faa3886..c49ca89ee17c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -240,7 +240,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.exit_latency = 3,
 		.target_residency = 6,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -248,7 +248,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -256,7 +256,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.exit_latency = 20,
 		.target_residency = 80,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -264,7 +264,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -277,7 +277,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -285,7 +285,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -293,7 +293,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.exit_latency = 80,
 		.target_residency = 211,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -301,7 +301,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.exit_latency = 104,
 		.target_residency = 345,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x30",
@@ -309,7 +309,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.exit_latency = 109,
 		.target_residency = 345,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -322,7 +322,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6N",
 		.desc = "MWAIT 0x58",
@@ -330,7 +330,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.exit_latency = 300,
 		.target_residency = 275,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x52",
@@ -338,7 +338,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.exit_latency = 500,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x60",
@@ -346,7 +346,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.exit_latency = 1200,
 		.target_residency = 4000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7S",
 		.desc = "MWAIT 0x64",
@@ -354,7 +354,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.exit_latency = 10000,
 		.target_residency = 20000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -367,7 +367,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6N",
 		.desc = "MWAIT 0x58",
@@ -375,7 +375,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.exit_latency = 80,
 		.target_residency = 275,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x52",
@@ -383,7 +383,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.exit_latency = 200,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x60",
@@ -391,7 +391,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.exit_latency = 1200,
 		.target_residency = 4000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7S",
 		.desc = "MWAIT 0x64",
@@ -399,7 +399,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.exit_latency = 10000,
 		.target_residency = 20000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -412,7 +412,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -420,7 +420,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -428,7 +428,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.exit_latency = 59,
 		.target_residency = 156,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -436,7 +436,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.exit_latency = 80,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x30",
@@ -444,7 +444,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.exit_latency = 87,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -457,7 +457,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -465,7 +465,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 80,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -473,7 +473,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.exit_latency = 59,
 		.target_residency = 156,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -481,7 +481,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.exit_latency = 82,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -494,7 +494,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -502,7 +502,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 250,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -510,7 +510,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.exit_latency = 59,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -518,7 +518,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.exit_latency = 84,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -531,7 +531,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -539,7 +539,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -547,7 +547,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.exit_latency = 59,
 		.target_residency = 600,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -555,7 +555,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.exit_latency = 88,
 		.target_residency = 700,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -568,7 +568,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -576,7 +576,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -584,7 +584,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 33,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -592,7 +592,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 133,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x32",
@@ -600,7 +600,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 166,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -608,7 +608,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 300,
 		.target_residency = 900,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -616,7 +616,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 600,
 		.target_residency = 1800,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -624,7 +624,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.exit_latency = 2600,
 		.target_residency = 7700,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -636,7 +636,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -644,7 +644,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -652,7 +652,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 40,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -660,7 +660,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 133,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x32",
@@ -668,7 +668,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 166,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -676,7 +676,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 300,
 		.target_residency = 900,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -684,7 +684,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 600,
 		.target_residency = 1800,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -692,7 +692,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.exit_latency = 2600,
 		.target_residency = 7700,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -705,7 +705,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -713,7 +713,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -721,7 +721,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 70,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -729,7 +729,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 85,
 		.target_residency = 200,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x33",
@@ -737,7 +737,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 124,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -745,7 +745,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -753,7 +753,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 480,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -761,7 +761,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.exit_latency = 890,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -774,7 +774,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -782,7 +782,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -790,7 +790,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 		.exit_latency = 133,
 		.target_residency = 600,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -803,7 +803,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -811,7 +811,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.exit_latency = 4,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -819,7 +819,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.exit_latency = 170,
 		.target_residency = 600,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -842,7 +842,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -850,7 +850,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -858,7 +858,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.exit_latency = 220,
 		.target_residency = 600,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -866,7 +866,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.exit_latency = 280,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -874,7 +874,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.exit_latency = 680,
 		.target_residency = 2000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -887,7 +887,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -895,7 +895,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -903,7 +903,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.exit_latency = 170,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -911,7 +911,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.exit_latency = 200,
 		.target_residency = 600,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -919,7 +919,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.exit_latency = 230,
 		.target_residency = 700,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -932,7 +932,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -940,7 +940,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdata = {
 		.exit_latency = 140,
 		.target_residency = 420,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -948,7 +948,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdata = {
 		.exit_latency = 310,
 		.target_residency = 930,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -961,7 +961,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -969,7 +969,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -977,7 +977,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.exit_latency = 195,
 		.target_residency = 585,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -985,7 +985,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.exit_latency = 260,
 		.target_residency = 1040,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -993,7 +993,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.exit_latency = 660,
 		.target_residency = 1980,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1006,7 +1006,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1014,7 +1014,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -1023,7 +1023,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 		.exit_latency = 290,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1036,7 +1036,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1044,7 +1044,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.exit_latency = 4,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -1054,7 +1054,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.exit_latency = 170,
 		.target_residency = 650,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6P",
 		.desc = "MWAIT 0x21",
@@ -1064,7 +1064,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.exit_latency = 210,
 		.target_residency = 1000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1077,7 +1077,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1085,7 +1085,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 		.exit_latency = 4,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -1095,7 +1095,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 		.exit_latency = 220,
 		.target_residency = 650,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6P",
 		.desc = "MWAIT 0x21",
@@ -1105,7 +1105,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 		.exit_latency = 240,
 		.target_residency = 750,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1118,7 +1118,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C2",
 		.desc = "MWAIT 0x10",
@@ -1126,7 +1126,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.exit_latency = 20,
 		.target_residency = 80,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C4",
 		.desc = "MWAIT 0x30",
@@ -1134,7 +1134,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.exit_latency = 100,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x52",
@@ -1142,7 +1142,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.exit_latency = 140,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1154,7 +1154,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C4",
 		.desc = "MWAIT 0x30",
@@ -1162,7 +1162,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.exit_latency = 100,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x52",
@@ -1170,7 +1170,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.exit_latency = 140,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x60",
@@ -1178,7 +1178,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.exit_latency = 1200,
 		.target_residency = 4000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x64",
@@ -1186,7 +1186,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.exit_latency = 10000,
 		.target_residency = 20000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1198,7 +1198,7 @@ static struct cpuidle_state avn_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x51",
@@ -1206,7 +1206,7 @@ static struct cpuidle_state avn_cstates[] __initdata = {
 		.exit_latency = 15,
 		.target_residency = 45,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1239,7 +1239,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1247,7 +1247,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -1255,7 +1255,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.exit_latency = 133,
 		.target_residency = 133,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x31",
@@ -1263,7 +1263,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.exit_latency = 155,
 		.target_residency = 155,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -1271,7 +1271,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.exit_latency = 1000,
 		.target_residency = 1000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -1279,7 +1279,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.exit_latency = 2000,
 		.target_residency = 2000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -1287,7 +1287,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.exit_latency = 10000,
 		.target_residency = 10000,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1300,7 +1300,7 @@ static struct cpuidle_state dnv_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1308,7 +1308,7 @@ static struct cpuidle_state dnv_cstates[] __initdata = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -1316,7 +1316,7 @@ static struct cpuidle_state dnv_cstates[] __initdata = {
 		.exit_latency = 50,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1333,7 +1333,7 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1341,7 +1341,7 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.exit_latency = 15,
 		.target_residency = 25,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -1349,7 +1349,7 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.exit_latency = 130,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1362,7 +1362,7 @@ static struct cpuidle_state grr_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1370,7 +1370,7 @@ static struct cpuidle_state grr_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 10,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x22",
@@ -1378,7 +1378,7 @@ static struct cpuidle_state grr_cstates[] __initdata = {
 		.exit_latency = 140,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -1391,7 +1391,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -1399,7 +1399,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 10,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x22",
@@ -1408,7 +1408,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 270,
 		.target_residency = 700,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.name = "C6SP",
 		.desc = "MWAIT 0x23",
@@ -1417,7 +1417,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 310,
 		.target_residency = 900,
 		.enter = &intel_idle,
-		.enter_s2idle = intel_idle_s2idle, },
+	},
 	{
 		.enter = NULL }
 };
@@ -2143,10 +2143,15 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		if (intel_idle_max_cstate_reached(cstate))
 			break;
 
-		if (!cpuidle_state_table[cstate].enter &&
-		    !cpuidle_state_table[cstate].enter_s2idle)
+		if (!cpuidle_state_table[cstate].enter)
 			break;
 
+		if (!cpuidle_state_table[cstate].enter_dead)
+			cpuidle_state_table[cstate].enter_dead = intel_idle_enter_dead;
+
+		if (!cpuidle_state_table[cstate].enter_s2idle)
+			cpuidle_state_table[cstate].enter_s2idle = intel_idle_s2idle;
+
 		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
 			pr_debug("state %s is disabled\n",

