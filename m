Return-Path: <linux-pm+bounces-27714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D8AC600A
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 05:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0837A62F6
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 03:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80B61DC997;
	Wed, 28 May 2025 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCX6Yf1N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7178F3B;
	Wed, 28 May 2025 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402671; cv=none; b=HjotqhGGNVEgbjgLPc//rJgsmeraO2Y5RfP43ve4gCOsoXEukocVF8UFoJ8U19xJrbfGAQzUu8TswtYHUdhRggbkzu5FMYXQZceXaHDwNflNhRlKDOR2NbnLPhRn5YuGhesuPZP0nEwyBDch830NbRzEFBlY02fDpJ+i0339lY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402671; c=relaxed/simple;
	bh=AnN/B27kEagr9d6C5Bkypl3yzdosXLiltUfCVuNie2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucuk6VfiBJIxhkb8Xq58VO1sdnEuWCXj80A0nRM2nlK7NhiV6Q/Wf2rsJ4nIKMXKM55ddCXXC6LTp0AX1lTEtpalQzPcmLafLljOGbu+fQP3YnLHHdkY3f+9VZ9UpDt7mamHnCD6yWU9/u2v5HdLx4QqzwMFCh9/xqdGDXqgdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCX6Yf1N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c46611b6so4581583b3a.1;
        Tue, 27 May 2025 20:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748402669; x=1749007469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkYvhTywMx4grIhTKWPdivO3y6dshUWyQwYQ0p9tsYs=;
        b=lCX6Yf1NJFLN7xqHqtJ17CMIMBlvqEE+x/7J2lbmDfFcgiGp2bQUcYneKsgJwAk5K2
         Sb+aT6BVffDGv+pPrxBv+K/IWuhoXhIAuxE4LzFzWBqq3WXVaN5ZAGvh6jV2MRNQIHYe
         jyaL/g7upaE5ilDMpwqaew7Ot5KwuQpZM7rst9g8SJSj0NC9L8KK+KYWXzix9phUZTgu
         tNwid6Ez2X+kVVebjcmTQpa3cYAxVqDrzJwPVUCjNuZ3CkQ0fXv7wOgabk4JoXreaHaW
         ABhY5loJF/BsUOF8hLIZ9t8pKO2112y3LqV+IVKltAdthfYzgzDvk3Hi/iXB7Z5jvUcC
         jKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402669; x=1749007469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkYvhTywMx4grIhTKWPdivO3y6dshUWyQwYQ0p9tsYs=;
        b=lsNxe2kBCwvD23R11c4midlwsjAa5GrOttqixsTGqw7geczUJGGP6bX3DR/HrPu3N2
         wXsUz9C5QDlsLxmXZ6WJ12S2lSBvaHSONkFR7KeNl7qp5ICcsbycXpL6B0DVAt8jUreH
         u2K375kocq64nPC+xfYvcu6CL1EFu9W5V/7d4rk883a24fUft0X/L7vqKUtsJurXJegj
         DWh9YpwImZsYCQx74yXbJoyY9nNPhfz1u3u70fjuQKnNFsRgpXzkmHKlwH3Z2epEcZX6
         gHSluNAjUT3WpoisvrrX8MnW+WG7yemaC61iAoF+40hRM1GcCgKi15p3dXDCPHamGoq/
         N80g==
X-Forwarded-Encrypted: i=1; AJvYcCUHtIe8XPd3LOzg8GSffiw8lbmt+G810fkr+GfYK8I7aY3HcBn4jOD+aEtJzsd/9cd3Wey3XajY8cg=@vger.kernel.org, AJvYcCUkxm4qO3BTo3JlpKGckZjw5tk3P/B15sr8vT6cTLvi8A+iITvl7yKYfIF+56gW2/U5u8NDpvSKNZOBLpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmso6J9zJvdBXBJHGrZM2b2fWzHsJ2NQ89vrWBE/PUaWVWsFNw
	p9A5hK/HJGaNJkJmTgcVBNXpAq6UsDp87+ZTX4VyLo2TjitvXJrOrKAc
X-Gm-Gg: ASbGncuZUvEQR26p/DwZkdB55T+fE2AIkU3jFZsMFr6cZKTK8FBB6Z7pQFvmPGvdQF6
	BG3TEAs+nkYKV8oYca+jSxnpiKgE4eIWyU+hDPL+/bI7ZN7B71NRUHCXiTb6FZ9zwNQ2NDgHTjm
	1wASrftOFVH3SEc+ik+1SXBOYnZqQx75D96tGt2F6A9x7sm3kc2pR91fCQaGdSlE7k0ygFNxkAg
	cFF+vvnrtkk9rIs6bApyYSMPiu3nxfqtC79UKNWYFqHVh7dKdvoqqlkFJ0SMOAYV/1AVZwkSqvX
	mfXgFHQRFTpTKgocVTqFuJoRLWM9L8RDGlfs9o4dz12KhaM8YQCWxzc=
X-Google-Smtp-Source: AGHT+IF8LBwNLLyElUI/JflQFcxXUdTggKNrrDcK2kLzjjo8vOqAtMChiw2eFcJao6nBKQXKgIhD3A==
X-Received: by 2002:a05:6a00:3996:b0:740:9331:78f0 with SMTP id d2e1a72fcca58-745fe0700c1mr18554575b3a.22.1748402668581;
        Tue, 27 May 2025 20:24:28 -0700 (PDT)
Received: from localhost ([70.134.61.176])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-746e345b67fsm232750b3a.160.2025.05.27.20.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:24:28 -0700 (PDT)
Date: Tue, 27 May 2025 20:24:27 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adam Clark <Adam.Clark@amd.com>
Subject: Re: [PATCH] acpi-cpufreq: Fix max-frequency computation
Message-ID: <aDaB63tDvbdcV0cg@HQ-GR2X1W2P57>
References: <20250113044107.566-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113044107.566-1-gautham.shenoy@amd.com>

On Mon, Jan 13, 2025 at 10:11:07AM +0530, Gautham R. Shenoy wrote:
> commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
> boost frequencies") introduces an assumption in
> acpi_cpufreq_cpu_init() that the first entry in the P-state table is
> the nominal frequency. This assumption is incorrect. The frequency
> corresponding to the P0 P-State need not be the same as the nominal
> frequency advertised via CPPC.
> 
> Since the driver is using the CPPC.highest_perf and CPPC.nominal_perf
> to compute the boost-ratio, it makes sense to use CPPC.nominal_freq to
> compute the max-frequency. CPPC.nominal_freq is advertised on
> platforms supporting CPPC revisions 3 or higher.
> 
> Hence, fallback to using the first entry in the P-State table only on
> platforms that do not advertise CPPC.nominal_freq.
> 

Gautham, this got recently pulled in 5.15.179 [0] but it seems to have broken
what max CPU get reported.

I hit the issue on Ubuntu 22.04 with kernel 5.15.0-140-generic. My read from [1]
is that that kernel is pretty much 5.15.79.
I rebuilt it with this patch removed and max CPU now show as before.

Here some output that may help, which is what is mostly down to what is reported
by /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq . Posting the whole
lscpu hoping that contain more useful data. Happy to provide more if needed.

Ubuntu 22.04 with 5.15.0-140-generic (affected, note CPU max MHz: 2000.0000):

    $ lscpu
    Architecture:             x86_64
      CPU op-mode(s):         32-bit, 64-bit
      Address sizes:          48 bits physical, 48 bits virtual
      Byte Order:             Little Endian
    CPU(s):                   128
      On-line CPU(s) list:    0-127
    Vendor ID:                AuthenticAMD
      Model name:             AMD EPYC 7713P 64-Core Processor
        CPU family:           25
        Model:                1
        Thread(s) per core:   2
        Core(s) per socket:   64
        Socket(s):            1
        Stepping:             1
        Frequency boost:      enabled
        CPU max MHz:          2000.0000
        CPU min MHz:          1500.0000
        BogoMIPS:             3992.30
        Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
                              fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monit
                              or ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy a
                              bm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb
                               cat_l3 cdp_l3 invpcid_single hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm
                              rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm
                              _local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyas
                              id decodeassists pausefilter pfthreshold v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow
                              _recov succor smca fsrm
    Virtualization features:
      Virtualization:         AMD-V
    Caches (sum of all):
      L1d:                    2 MiB (64 instances)
      L1i:                    2 MiB (64 instances)
      L2:                     32 MiB (64 instances)
      L3:                     256 MiB (8 instances)
    NUMA:
      NUMA node(s):           1
      NUMA node0 CPU(s):      0-127
    Vulnerabilities:
      Gather data sampling:   Not affected
      Itlb multihit:          Not affected
      L1tf:                   Not affected
      Mds:                    Not affected
      Meltdown:               Not affected
      Mmio stale data:        Not affected
      Reg file data sampling: Not affected
      Retbleed:               Not affected
      Spec rstack overflow:   Mitigation; safe RET
      Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl and seccomp
      Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
      Spectre v2:             Mitigation; Retpolines; IBPB conditional; IBRS_FW; STIBP always-on; RSB filling; PBRSB-eIBRS Not affected; BHI Not affe
                              cted
      Srbds:                  Not affected
      Tsx async abort:        Not affected

With 5.15.0-999-generic (5.15.0-140-generic without this patch), max CPU is back
to 3720.7029, which is also what I get with 5.15.0-139-generic.

    $ lscpu
    Architecture:             x86_64
      CPU op-mode(s):         32-bit, 64-bit
      Address sizes:          48 bits physical, 48 bits virtual
      Byte Order:             Little Endian
    CPU(s):                   128
      On-line CPU(s) list:    0-127
    Vendor ID:                AuthenticAMD
      Model name:             AMD EPYC 7713P 64-Core Processor
        CPU family:           25
        Model:                1
        Thread(s) per core:   2
        Core(s) per socket:   64
        Socket(s):            1
        Stepping:             1
        Frequency boost:      enabled
        CPU max MHz:          3720.7029
        CPU min MHz:          1500.0000
        BogoMIPS:             3992.55
        Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
                              fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monit
                              or ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy a
                              bm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb
                               cat_l3 cdp_l3 invpcid_single hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm
                              rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm
                              _local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyas
                              id decodeassists pausefilter pfthreshold v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow
                              _recov succor smca fsrm
    Virtualization features:
      Virtualization:         AMD-V
    Caches (sum of all):
      L1d:                    2 MiB (64 instances)
      L1i:                    2 MiB (64 instances)
      L2:                     32 MiB (64 instances)
      L3:                     256 MiB (8 instances)
    NUMA:
      NUMA node(s):           1
      NUMA node0 CPU(s):      0-127
    Vulnerabilities:
      Gather data sampling:   Not affected
      Itlb multihit:          Not affected
      L1tf:                   Not affected
      Mds:                    Not affected
      Meltdown:               Not affected
      Mmio stale data:        Not affected
      Reg file data sampling: Not affected
      Retbleed:               Not affected
      Spec rstack overflow:   Mitigation; safe RET
      Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl and seccomp
      Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
      Spectre v2:             Mitigation; Retpolines; IBPB conditional; IBRS_FW; STIBP always-on; RSB filling; PBRSB-eIBRS Not affected; BHI Not affe
                              cted
      Srbds:                  Not affected
      Tsx async abort:        Not affected


Thought to post here instead of [0] to get your thought on this. Am I missing
something simple to get the right value? Or should this be pulled out of 5.15
LTS?

Thanks

[0]: https://lore.kernel.org/all/2025031356-rerun-remold-30b9@gregkh/
[1]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2106026

> Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 36 +++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index c9ebacf5c88e..744fcdeab173 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -623,7 +623,14 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>  #endif
>  
>  #ifdef CONFIG_ACPI_CPPC_LIB
> -static u64 get_max_boost_ratio(unsigned int cpu)
> +/*
> + * get_max_boost_ratio: Computes the max_boost_ratio as the ratio
> + * between the highest_perf and the nominal_perf.
> + *
> + * Returns the max_boost_ratio for @cpu. Returns the CPPC nominal
> + * frequency via @nominal_freq if it is non-NULL pointer.
> + */
> +static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
>  {
>  	struct cppc_perf_caps perf_caps;
>  	u64 highest_perf, nominal_perf;
> @@ -652,6 +659,9 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>  
>  	nominal_perf = perf_caps.nominal_perf;
>  
> +	if (nominal_freq)
> +		*nominal_freq = perf_caps.nominal_freq;
> +
>  	if (!highest_perf || !nominal_perf) {
>  		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
>  		return 0;
> @@ -664,8 +674,12 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>  
>  	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>  }
> +
>  #else
> -static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
> +static inline u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
> +{
> +	return 0;
> +}
>  #endif
>  
>  static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> @@ -677,7 +691,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	unsigned int valid_states = 0;
>  	unsigned int result = 0;
> -	u64 max_boost_ratio;
> +	u64 max_boost_ratio, nominal_freq = 0;
>  	unsigned int i;
>  #ifdef CONFIG_SMP
>  	static int blacklisted;
> @@ -827,16 +841,20 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
>  
> -	max_boost_ratio = get_max_boost_ratio(cpu);
> +	max_boost_ratio = get_max_boost_ratio(cpu, &nominal_freq);
>  	if (max_boost_ratio) {
> -		unsigned int freq = freq_table[0].frequency;
> +		unsigned int freq = nominal_freq;
>  
>  		/*
> -		 * Because the loop above sorts the freq_table entries in the
> -		 * descending order, freq is the maximum frequency in the table.
> -		 * Assume that it corresponds to the CPPC nominal frequency and
> -		 * use it to set cpuinfo.max_freq.
> +		 * The loop above sorts the freq_table entries in the
> +		 * descending order. If ACPI CPPC has not advertised
> +		 * the nominal frequency (this is possible in CPPC
> +		 * revisions prior to 3), then use the first entry in
> +		 * the pstate table as a proxy for nominal frequency.
>  		 */
> +		if (!freq)
> +			freq = freq_table[0].frequency;
> +
>  		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
>  	} else {
>  		/*
> -- 
> 2.34.1
> 

