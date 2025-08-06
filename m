Return-Path: <linux-pm+bounces-31984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D8B1C136
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 09:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8145164228
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0918219A67;
	Wed,  6 Aug 2025 07:22:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D19218E96;
	Wed,  6 Aug 2025 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464927; cv=none; b=YOeNbYgO8F8QbgQPjYqkKUL2yjgfhMs7DTYZ/Tk2scWyQqpXhnuhjbkfC9p94NjAJfppGlrrywr0wqzjGD8HMMeC/InFWXgHSY87POcYYZ9WUAjJrwH6Mf+VuYiCgZ7b2ttpVNzUCM5xH3mXk+j8dsIoosqf3Mtx29oZ/aGXb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464927; c=relaxed/simple;
	bh=SbBiYbQJKdCzUuHAUZWOYHds7ZPNE/HfIsqkc2KN1u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwPSQe4zIsha/B7pOlCC3p0ya7PcC7wj4P8aQ0Fih6bg5pMBUnzw65rfrAnO52MKlwMC5F1Wu/SkUZCMTUQymBaF7Irfj0BEz1UvTrECTk9a4JtUTOrZafCapnGw5uHn1LxRgWPCvSeybCIBa5B7Hw0nMYqivnrCUp76nsrTPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E44B1F37;
	Wed,  6 Aug 2025 00:21:56 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559BC3F5A1;
	Wed,  6 Aug 2025 00:21:59 -0700 (PDT)
Date: Wed, 6 Aug 2025 09:21:36 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Prashant Malani <pmalani@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJMCgGt5zu5Dhrd5@arm.com>
References: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
 <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>

On Mon, Aug 04, 2025 at 01:55:37PM -0700, Prashant Malani wrote:
> On Fri, 1 Aug 2025 at 02:16, Prashant Malani <pmalani@google.com> wrote:
> > On Thu, 31 Jul 2025 at 13:31, Beata Michalska <beata.michalska@arm.com> wrote:
> > > Thank you for the info, but I'm exploring ways that will not increase the time
> > > window between the reads.
> >
> > IMO this issue is intractable on non-RT OSes like Linux (at least,
> > Linux when it is not compiled for RT), since we basically need to
> > ensure atomicity for the reading of both ref and del registers together.
> > We can't disable preemption here, since some of
> > the code paths (like PCC regs) acquire semaphores [2].
> 
> Actually, minor correction here. The PCC path is not the issue.
> It's the ffh read path[3], which requires interrupts to be enabled.
> Larger point still stands.
> 
> [3] https://elixir.bootlin.com/linux/v6.16-rc7/source/arch/arm64/kernel/topology.c#L451
> 
> BR,
> 
> -Prashant

Would you mind giving it a go and see whether that improves things on your end ?
Note that this is a quick and semi-dirty hack though.

---
BR
Beata

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5d07ee85bdae..65adb78a9a87 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -479,6 +479,11 @@ bool cpc_ffh_supported(void)
 	return true;
 }
 
+bool cpc_burst_read_supported(void)
+{
+	return cpc_ffh_supported();
+}
+
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	int ret = -EOPNOTSUPP;
@@ -501,6 +506,61 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 	return ret;
 }
 
+
+struct cpc_burst_read {
+	struct cpc_reg_sample *samples;
+	size_t  count;
+};
+
+void counters_burst_read_on_cpu(void *arg)
+{
+	struct cpc_burst_read *desc = arg;
+	u64 value;
+	int i;
+
+	for (i = 0; i < desc->count; ++i) {
+		switch ((u64)desc->samples[i].reg->address) {
+		case 0x0:
+			value = read_corecnt();
+			break;
+		case 0x1:
+			value = read_constcnt();
+			break;
+		}
+		*(u64 *)desc->samples[i].sample_value = value;
+	}
+
+	for (i = 0; i < desc->count; ++i) {
+		struct cpc_reg *reg = desc->samples[i].reg;
+
+		value = *(u64 *)desc->samples[i].sample_value;
+		value &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
+				     reg->bit_offset);
+		value >>= reg->bit_offset;
+		*(u64 *)desc->samples[i].sample_value = value;
+	}
+}
+
+static inline bool cpc_reg_supported(struct cpc_reg *reg)
+{
+	return !((u64)reg->address != 0x0 || (u64)reg->address != 0x1);
+}
+
+int cpc_burst_read_ffh(int cpu, struct cpc_reg_sample *samples, size_t count)
+{
+	struct cpc_burst_read desc = { samples, count };
+	int ret = -EOPNOTSUPP;
+	int i;
+
+	for (i = 0; i < count; ++i) {
+		if (!cpc_reg_supported(samples[i].reg))
+			return ret;
+	}
+
+	smp_call_function_single(cpu, counters_burst_read_on_cpu, &desc, 1);
+	return 0;
+}
+
 int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6b649031808f..c070627e4a1e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -617,6 +617,11 @@ bool __weak cpc_supported_by_cpu(void)
 	return false;
 }
 
+bool __weak cpc_burst_read_supported(void)
+{
+	return false;
+}
+
 /**
  * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
  * @pcc_ss_id: PCC Subspace index as in the PCC client ACPI package.
@@ -1077,6 +1082,21 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	return 0;
 }
 
+static int cpc_burst_read(int cpu, struct cpc_reg_sample *samples, size_t count)
+{
+	int i;
+
+	// Just for now - only ffh
+	if (!cpc_ffh_supported())
+		return -EINVAL;
+
+	for (i = 0; i < count; ++i)
+		if (samples[i].reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)
+			return -EINVAL;
+	return cpc_burst_read_ffh(cpu, samples, count);
+}
+
+
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
@@ -1515,8 +1535,21 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	cpc_read(cpunum, delivered_reg, &delivered);
-	cpc_read(cpunum, reference_reg, &reference);
+	// Verify whether the registers can be requested in one go
+	if (delivered_reg->type != ACPI_TYPE_INTEGER &&
+	    reference_reg->type != ACPI_TYPE_INTEGER &&
+	    cpc_burst_read_supported()) {
+
+		struct cpc_reg_sample samples[] = {
+			{ &delivered_reg->cpc_entry.reg, &delivered },
+			{ &reference_reg->cpc_entry.reg, &reference }
+		};
+
+		cpc_burst_read(cpunum, samples, ARRAY_SIZE(samples));
+	} else {
+		cpc_read(cpunum, delivered_reg, &delivered);
+		cpc_read(cpunum, reference_reg, &reference);
+	}
 	cpc_read(cpunum, ref_perf_reg, &ref_perf);
 
 	/*
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 325e9543e08f..f094e275834a 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -52,6 +52,12 @@ struct cpc_reg {
 	u64 address;
 } __packed;
 
+
+struct cpc_reg_sample {
+	struct cpc_reg *reg;
+	void *sample_value;
+};
+
 /*
  * Each entry in the CPC table is either
  * of type ACPI_TYPE_BUFFER or
@@ -165,6 +171,7 @@ extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
+extern int cpc_burst_read_ffh(int cpunum, struct cpc_reg_sample *samples, size_t count);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
@@ -229,6 +236,10 @@ static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cpc_burst_read_ffh(int cpunum, struct cpc_reg_sample *samples, size_t count)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -EOPNOTSUPP;
-- 


