Return-Path: <linux-pm+bounces-27748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB66AC6E27
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC6316864E
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDF828D8C9;
	Wed, 28 May 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByvZ4mxD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AA28DB65;
	Wed, 28 May 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450386; cv=none; b=qS4PiT0ywq2BmjsAUZ2hR0Ujha+GzUzqoPVfycpu8uWS4Huhd6XWsikUj6pvMFnGpb1orK7fMTZLqwwikn+NwGsQ49ksOpOFquZaug5gIg7JHqKk5qMq5c41YMb4zy5OaWHBRrtTEByfn+G0XDSkhJYLqewC7fzogyQ9WAI4x/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450386; c=relaxed/simple;
	bh=PK5I36SR6KPvbVW5o/5/Nxx2H4DZmk3oW5UwCer9tb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtDZ/RJUQkARXd3nCu83H0gbj3Har4aWU2EZyxwzXts7bJfDT/6wF55m66a2+u51k/jdPUCLaANSHVGN2XLpQGSftWDUGuXIHGHyMGgUSCwvbfovzh0iVb5H//Xr6ybhQZDThtTlInUyfR+vsRJIQptOXAkbYePUnts527qC2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByvZ4mxD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad883afdf0cso531810266b.0;
        Wed, 28 May 2025 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748450382; x=1749055182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKX1pLwdxEywKNCdYX14Pz2UBR1qa4gDnMcpTfxzuao=;
        b=ByvZ4mxD15OlSA0j06VQ6oQDQ/wCcd9LA3T60RzohzwRaajn/pDtjp88scPFMil3Uc
         a7d78antlm2MQFGXTnxViJ2yNNjxQhWOw4/KyDvxhhhjl/ns6POnIfAacuTJxZPojTxB
         KrVqeFR6mGe8DdVH7zc4QepF8P14B7twFP2XXGii7fXI3B/5Q9f4BM9CZn4FFE1sOKCm
         LnqyikqbnB7VWXgn0EwwFYqe62sNP2IGSs2YyT73ep+H7n7HtisT4zsBJhaW35jcAmur
         HV/Jf2SIPMCdrtYRG5IaOKciiCBQJTDQkqUWR2VwTDErJBU1QrFH39tNNjCUruqEItPp
         wGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748450382; x=1749055182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKX1pLwdxEywKNCdYX14Pz2UBR1qa4gDnMcpTfxzuao=;
        b=ArqsscaoeiZtJC0DmAJdmolqsOvGDatW3QvSZ6Val3q4VgLpFrJoMJTM+txiEQnV2l
         DA4Z79SKCSh0NY3aw/534aGOyi2cZVGwesilKKDTaIUSlan5yHT9TwJ5OtoKM0jDdc9r
         vOnC5vsTUx7pHxbgfAPNVA4eVAONDnLw63aoQ6vwHkolXOJaT6M1kLB1g4phdURENHiq
         cVmH0UdyJaaLerxW3BZtQ6dmsV97SojI4xujWBlfiRvgaUy8/KxqlXVSkeJx8kqf7WOl
         bu1NrvGTJXSiB6BUPDcK2CZQbzVRd7JClrZG+ZROjI/UacKjZB6PhDLMk0QivP6eiRBu
         /PFg==
X-Forwarded-Encrypted: i=1; AJvYcCUGbWcv1P+MQtknStJdYHp8Xi2EAcBpKl1o0SKRTm1lJZyZ17FoyIWXM7bqpMylO+siQcj0Gxvr5mc=@vger.kernel.org, AJvYcCVfKx6cuvkUnxLePRMigMI6m548FXTvUfcWHs9NUK5agpu5BxiBIxSqNltgflCsuVZrK02T1HJqA3vZPX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdNVuvNqx/UQxsPnlPb3FsY6Uyf5z45jjVXw7OvMbooGhajta
	QIP2hXoNFmQ6mBWTn8JrAIiK46Wm2rHRFfCsoEBMl+xJNQH7HmAvzby88IL1lWIiQHVuK1lt3+N
	3Adyd1PjCOKOdyJ4Khcl9xV2CZ7FGSS4=
X-Gm-Gg: ASbGncuBSVHE1SC4/01rBvymeSeZVVFe47HjNf9D45tqxz54E0ZxwpFDteuQ2mvr0bT
	2B8Ab2DqcEHLtbvvzqJVqVlxyenPFCDvfBzDGq9uyHsbKW5mPoDNZSh5/1KBFAYhxDihDaPdnnT
	iDlxONSd70rfxk2Ogao4Z+0YxC1m/VGiI=
X-Google-Smtp-Source: AGHT+IHtke/J7pX7aA75Lv72+AWPYtXUnawbwRg8keF4TFoH7myfHumge6n7abfdZpauiHv1YhpnhbXU7KZ+KKW/qZM=
X-Received: by 2002:a17:907:da3:b0:ad8:9b5d:2c26 with SMTP id
 a640c23a62f3a-ad89b5d2e87mr425218266b.30.1748450382185; Wed, 28 May 2025
 09:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113044107.566-1-gautham.shenoy@amd.com> <aDaB63tDvbdcV0cg@HQ-GR2X1W2P57>
 <aDb6Mgg3TqyR2IRT@BLRRASHENOY1.amd.com>
In-Reply-To: <aDb6Mgg3TqyR2IRT@BLRRASHENOY1.amd.com>
From: Manu Bretelle <chantr4@gmail.com>
Date: Wed, 28 May 2025 09:39:31 -0700
X-Gm-Features: AX0GCFutIJtBiXdzMO7ABReyuippZSjiExk3NiGS0UThEwallEw2Do4W0buLZVU
Message-ID: <CAArYzrJHSFgiiPamMDfp9-nvHr1+SGfQ-tgOpJ5tgR5Wtw+Mnw@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Fix max-frequency computation
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Adam Clark <Adam.Clark@amd.com>
Content-Type: text/plain; charset="UTF-8"

>
> No, the patch has a bug. The nominal_frequency returned from the
> get_max_boost_ratio() function was in MHz, while cpufreq maintains
> frequencies in KHz due to which the computed max_frequency was
> incorrect and thus as a fallback, cpufreq reported P0 frequency as the
> cpuinfo_max_freq.
>
> Can you please try the following patch on top of the original one?

Thanks for the quick turnaround Gautham.

I applied this patch on top of a fresh Ubuntu 22.04 5.15.0-140-generic tree and
confirmed that CPU max MHz reports its original value.

Thanks!

Manu

  $ uname  -r
  5.15.0-9991-generic
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
      Flags:                fpu vme de pse tsc msr pae mce cx8 apic
sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscal
                            l nx mmxext fxsr_opt pdpe1gb rdtscp lm
constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf
                            rapl pni pclmulqdq monitor ssse3 fma cx16
pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
                            cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perf
                            ctr_core perfctr_nb bpext perfctr_llc
mwaitx cpb cat_l3 cdp_l3 invpcid_single hw_pstate ssbd mba ibrs ibpb
                            stibp vmmcall fsgsbase bmi1 avx2 smep bmi2
erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xs
                            aveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdp
                            ru wbnoinvd amd_ppin arat npt lbrv
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists
pausef
                            ilter pfthreshold v_vmsave_vmload vgif
v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov succ
                            or smca fsrm
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
    Spec store bypass:      Mitigation; Speculative Store Bypass
disabled via prctl and seccomp
    Spectre v1:             Mitigation; usercopy/swapgs barriers and
__user pointer sanitization
    Spectre v2:             Mitigation; Retpolines; IBPB conditional;
IBRS_FW; STIBP always-on; RSB filling; PBRSB-eIBRS Not affected;
                            BHI Not affected
    Srbds:                  Not affected
    Tsx async abort:        Not affected

>
>
> ------------------------x8------------------------------------------------
>
> From 13d5c28823ed03353059801281d3b22e9f139a8d Mon Sep 17 00:00:00 2001
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> Date: Wed, 28 May 2025 16:43:33 +0530
> Subject: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()
>
> commit 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
> modified get_max_boost_ratio() to return the nominal_freq advertised
> in the _CPC object for the purposes of computing the maximum
> frequency. The frequencies advertised in _CPC objects are in MHz but
> cpufreq expects the frequency to be in KHz. Because the
> nominal_frequency was not converted to KHz, the cpuinfo_max_frequency
> that got computed was incorrect and the cpufreq reported the P0
> frequency as the cpuinfo_max_freq.
>
> Fix this by returning nominal_freq in KHz in get_max_boost_ratio()
>
> Reported-by: Manu Bretelle <chantr4@gmail.com>
> Closes: https://lore.kernel.org/lkml/aDaB63tDvbdcV0cg@HQ-GR2X1W2P57/
> Fixes: 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Tested-by: Manu Bretelle <chantr4@gmail.com>

> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index d26b610e4f24..76768fe213a9 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -660,7 +660,7 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
>         nominal_perf = perf_caps.nominal_perf;
>
>         if (nominal_freq)
> -               *nominal_freq = perf_caps.nominal_freq;
> +               *nominal_freq = perf_caps.nominal_freq * 1000;
>
>         if (!highest_perf || !nominal_perf) {
>                 pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
> --
> 2.34.1
>
>
> --
> Thanks and Regards
> gautham.

