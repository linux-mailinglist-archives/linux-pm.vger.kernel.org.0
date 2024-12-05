Return-Path: <linux-pm+bounces-18618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69AA9E5420
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41E0163B64
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532A207DED;
	Thu,  5 Dec 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="w2CZkcFq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0F207661;
	Thu,  5 Dec 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398832; cv=none; b=ExYZ/DxldZcycubNI9/TTBCF1QSEjErmxgQ+Y2NRPX6x0mO2SNLpF8LVs+K8XYV06wmFvSMg0JCpiHEKOFhCOjpfKgdxBA7G0j3f8YRBgv6Sh9gIPPwcFKnnYL4UhKVG6esNC0uaMUDrAoD8DsdvHLlYpK3VLDUHD4p77XoNcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398832; c=relaxed/simple;
	bh=GGOiq5PTQlEjdx5lCP5koyZN28p19F6m7KH62I+BD1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFYFqFigKec83n76SA/dRqBQk0aD9fqVYRFmujChD3a86pAv8uXpZY6GtE75reLA3J634c7j68WK6e5aBMgFRNYRWVNeSyvg14nwDQmcYe9EutYSXNpeNcDPCoBLICkAvrDyWYySgkDpzoP/Pjh0+zN5d3iKZ7aeZqW0gkutIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=w2CZkcFq; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id e21145b0a510d107; Thu, 5 Dec 2024 12:40:27 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8154A15F0421;
	Thu,  5 Dec 2024 12:40:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1733398826;
	bh=GGOiq5PTQlEjdx5lCP5koyZN28p19F6m7KH62I+BD1g=;
	h=From:Subject:Date;
	b=w2CZkcFqoqXkY4xSMTtLDsVWF1I+OBC06Yqj6qlLX9K0SNtB5w4LV1Td3tdqSNtA3
	 HD2o0LZNh/WxLdfy4ByXVo3hBGDHGabceLz+YjEVMVmggc/B9QCi9kv+NKNlHx5DqL
	 AJbA0aDxsObYXuwWH4U2ZbhgAE4GigoERw0C2ooZwwyHXZGvMC6nHAovluaMmZsSjo
	 hHdeDrcc6HSusXBVPyuu9dBGCBBfcoWAAdWSzKKMcdwcP3vLX311K64Ffw2S8Adk9f
	 v2iiWPI2zIdE3qouoPcYhyBxxGi23zXciyFfLv2jdWZlWTT1R4MZS0CWznktEoIbzE
	 1HGAQRk8e2NCw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 1/2] cpufreq: intel_pstate: Use CPPC to get scaling factors
Date: Thu, 05 Dec 2024 12:39:05 +0100
Message-ID: <8476313.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <1923452.tdWV9SEqCh@rjwysocki.net>
References: <1923452.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The perf-to-frequency scaling factors are used by intel_pstate on hybrid
platforms to cast performance levels to frequency on different types of
CPUs which is needed because the generic cpufreq sysfs interface works
in the frequency domain.

For some hybrid platforms already in the field, the scaling factors are
known, but for others (including some upcoming ones) they most likely
will be different and the only way to get them that scales is to use
information provided by the platform firmware.  In this particular case,
the requisite information can be obtained via CPPC.

If the P-core hybrid scaling factor for the given processor model is not
known, use CPPC to compute hybrid scaling factors for all CPUs.

Since the current default hybrid scaling factor is only suitable for a
few early hybrid platforms, add intel_hybrid_scaling_factor[] entries
for them and initialize the scaling factor to zero ("unknown") by
default.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   59 +++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -28,6 +28,7 @@
 #include <linux/pm_qos.h>
 #include <linux/bitfield.h>
 #include <trace/events/power.h>
+#include <linux/units.h>
 
 #include <asm/cpu.h>
 #include <asm/div64.h>
@@ -302,11 +303,11 @@ static bool hwp_is_hybrid;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
-#define HYBRID_SCALING_FACTOR		78741
+#define HYBRID_SCALING_FACTOR_ADL	78741
 #define HYBRID_SCALING_FACTOR_MTL	80000
 #define HYBRID_SCALING_FACTOR_LNL	86957
 
-static int hybrid_scaling_factor = HYBRID_SCALING_FACTOR;
+static int hybrid_scaling_factor;
 
 static inline int core_get_scaling(void)
 {
@@ -414,18 +415,15 @@ static int intel_pstate_get_cppc_guarant
 static int intel_pstate_cppc_get_scaling(int cpu)
 {
 	struct cppc_perf_caps cppc_perf;
-	int ret;
-
-	ret = cppc_get_perf_caps(cpu, &cppc_perf);
 
 	/*
-	 * If the nominal frequency and the nominal performance are not
-	 * zero and the ratio between them is not 100, return the hybrid
-	 * scaling factor.
-	 */
-	if (!ret && cppc_perf.nominal_perf && cppc_perf.nominal_freq &&
-	    cppc_perf.nominal_perf * 100 != cppc_perf.nominal_freq)
-		return hybrid_scaling_factor;
+	 * Compute the perf-to-frequency scaling factor for the given CPU if
+	 * possible, unless it would be 0.
+	 */
+	if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
+	    cppc_perf.nominal_perf && cppc_perf.nominal_freq)
+		return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ,
+			       cppc_perf.nominal_perf);
 
 	return core_get_scaling();
 }
@@ -2211,24 +2209,30 @@ static void hybrid_get_type(void *data)
 
 static int hwp_get_cpu_scaling(int cpu)
 {
-	u8 cpu_type = 0;
+	if (hybrid_scaling_factor) {
+		u8 cpu_type = 0;
+
+		smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 
-	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
-	/* P-cores have a smaller perf level-to-freqency scaling factor. */
-	if (cpu_type == 0x40)
-		return hybrid_scaling_factor;
+		/*
+		 * Return the hybrid scaling factor for P-cores and use the
+		 * default core scaling for E-cores.
+		 */
+		if (cpu_type == 0x40)
+			return hybrid_scaling_factor;
 
-	/* Use default core scaling for E-cores */
-	if (cpu_type == 0x20)
+		if (cpu_type == 0x20)
+			return core_get_scaling();
+	}
+
+	/* Use core scaling on non-hybrid systems. */
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
 		return core_get_scaling();
 
 	/*
-	 * If reached here, this system is either non-hybrid (like Tiger
-	 * Lake) or hybrid-capable (like Alder Lake or Raptor Lake) with
-	 * no E cores (in which case CPUID for hybrid support is 0).
-	 *
-	 * The CPPC nominal_frequency field is 0 for non-hybrid systems,
-	 * so the default core scaling will be used for them.
+	 * The system is hybrid, but the hybrid scaling factor is not known or
+	 * the CPU type is not one of the above, so use CPPC to compute the
+	 * scaling factor for this CPU.
 	 */
 	return intel_pstate_cppc_get_scaling(cpu);
 }
@@ -3665,6 +3669,11 @@ static const struct x86_cpu_id intel_epp
 };
 
 static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
+	X86_MATCH_VFM(INTEL_ALDERLAKE, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),




