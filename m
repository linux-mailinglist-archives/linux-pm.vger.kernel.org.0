Return-Path: <linux-pm+bounces-25570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2830AA90B0F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538253A8B82
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698721ABD4;
	Wed, 16 Apr 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M/SXTHBB"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18D215F43;
	Wed, 16 Apr 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827171; cv=none; b=Oy/xx/TOx9MPrqY0czZZMwcBrtsTYm8B73jTtbDtxNUAMoVYQ+Lyh23prh1Xv5qLO12CPIypnQBlPWS+AwDv9x+biHAUsKd8EbAxDNo7SkSfD5x/9c7m48L+2Pyb6ytRM3513uPDP13ncYnADW6yaX7eB8rv4QNhUWCXZ2YJ0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827171; c=relaxed/simple;
	bh=E23xdNKoe2mDxY9sAKw+UB4JLbdwV3PEW8QZm66WUAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDSDSj2dSOyX/pUE2e25BMmg5zwbvDZS/wBJ9Nk2n7Zc3HnQBNuouvqf346pBq+lczkUP+2kFkj8TTL5I7VwJqFDb9diMGgXUa9wQD7t8SZfIRU3/mtQDVYqfZbQKIxppWDmFG8OZE+vo0EZHENm/HLfeZ92gZQ0Xjhq/dhwhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M/SXTHBB; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9C6AF662715;
	Wed, 16 Apr 2025 20:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827167;
	bh=E23xdNKoe2mDxY9sAKw+UB4JLbdwV3PEW8QZm66WUAc=;
	h=From:Subject:Date;
	b=M/SXTHBBggDgj1khm+745Tm48eqxgEyxltDSOgxmFMr17CHkH2OcGx9JTX3MPQWbf
	 CsDmVwHpsszAUdHEZJ2RC3j+54+MpM+Cl9Lxzw/falybNIAp+/fZgCuLkI0Es29YWw
	 Z17uRKXZE7D52cMuvq1kEca6f0d+Zzjst8V05xSl783B6/9As0u10qWr+C6AiR1zhs
	 vJbV5u9RoQiquu4gqG3Rqe61493SNWS3pZX8m6cmY4KojihkmgDXIlz+y6ipWV2u3o
	 nAohMYgcLa+LxI2hDJQPN+J4V960edIH5Ai3zdmdyU1kiCSgf1PvqC90TuoKD6CxjM
	 jq7IMUuugFkEQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>
Subject:
 [RFT][PATCH v1 7/8] cpufreq: intel_pstate: Align perf domains with L2 cache
Date: Wed, 16 Apr 2025 20:10:50 +0200
Message-ID: <1964444.taCxCBeP46@rjwysocki.net>
In-Reply-To: <3344336.aeNJFYEL58@rjwysocki.net>
References: <3344336.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some hybrid platforms a group of cores (referred to as a module) may
share an L2 cache in which case they also share a voltage regulator and
always run at the same frequency (while not in idle states).

For this reason, make hybrid_register_perf_domain() in the intel_pstate
driver add all CPUs sharing an L2 cache to the same perf domain for EAS.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New in v1.

---
 drivers/cpufreq/intel_pstate.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -999,8 +999,11 @@
 {
 	static const struct em_data_callback cb
 			= EM_ADV_DATA_CB(hybrid_active_power, hybrid_get_cost);
+	struct cpu_cacheinfo *cacheinfo = get_cpu_cacheinfo(cpu);
+	const struct cpumask *cpumask = cpumask_of(cpu);
 	struct cpudata *cpudata = all_cpu_data[cpu];
 	struct device *cpu_dev;
+	int ret;
 
 	/*
 	 * Registering EM perf domains without enabling asymmetric CPU capacity
@@ -1014,9 +1017,25 @@
 	if (!cpu_dev)
 		return false;
 
-	if (em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &cb,
-					cpumask_of(cpu), false))
+	if (cacheinfo) {
+		unsigned int i;
+
+		/* Find the L2 cache and the CPUs sharing it. */
+		for (i = 0; i < cacheinfo->num_leaves; i++) {
+			if (cacheinfo->info_list[i].level == 2) {
+				cpumask = &cacheinfo->info_list[i].shared_cpu_map;
+				break;
+			}
+		}
+	}
+
+	ret = em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &cb,
+					  cpumask, false);
+	if (ret) {
+		cpudata->em_registered = ret == -EEXIST;
+
 		return false;
+	}
 
 	cpudata->em_registered = true;
 




