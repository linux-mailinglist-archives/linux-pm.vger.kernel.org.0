Return-Path: <linux-pm+bounces-39307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE6CAD328
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 13:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97F313045F58
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A77311C30;
	Mon,  8 Dec 2025 12:47:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D3D221FCF;
	Mon,  8 Dec 2025 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765198038; cv=none; b=fIo6yRDNujnyqOpqPAIcANZ5uS9WaNz0IEggUtUvVc3c9/ZyeeWVQI+glBpkwbr6+Iu6vb4+RgGbXwLxiBBU2ZEKAth0r2JbXXRzOQnKyQ6ZgtHc3sfh47xCuopcUxkXKB+y2geFX6nw+F9h/QoDENf4B3a6wOlZPI4R2vkyY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765198038; c=relaxed/simple;
	bh=P0ubJJKxEVDXiytzW+1D+A2oljwWKuKAhLPU2XzbyTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTanAc6nkL28e15+iIlPjFjjG3Yr+YzNTxg8QQ9uooRpK0V8oZEP0g8bn4J+FGiqVMwy/ygl1afm/eXXIW+idKPAbSV7MnzfISWeYfcW1eEezyAQzC/m5oGwR3X+et1n25BqME7ZbQp0LYt3jnlg3pzEgLRbl8WORsbL6GlN+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE931691;
	Mon,  8 Dec 2025 04:47:07 -0800 (PST)
Received: from [10.1.31.65] (e127648.arm.com [10.1.31.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8840F3F740;
	Mon,  8 Dec 2025 04:47:13 -0800 (PST)
Message-ID: <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
Date: Mon, 8 Dec 2025 12:47:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Doug Smythies <dsmythies@telus.net>
Cc: 'Sasha Levin' <sashal@kernel.org>,
 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
 stable@vger.kernel.org, "'Rafael J. Wysocki'" <rafael@kernel.org>,
 'Daniel Lezcano' <daniel.lezcano@linaro.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/8/25 11:33, Harshvardhan Jha wrote:
> Hi Doug,
> 
> On 04/12/25 4:00 AM, Doug Smythies wrote:
>> On 2025.12.03 08:45 Christian Loehle wrote:
>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>> Hi there,
>>>>
>>>> While running performance benchmarks for the 5.15.196 LTS tags , it was
>>>> observed that several regressions across different benchmarks is being
>>>> introduced when compared to the previous 5.15.193 kernel tag. Running an
>>>> automated bisect on both of them narrowed down the culprit commit to:
>>>> - 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
>>>> information" for 5.15
>>>>
>>>> Regressions on 5.15.196 include:
>>>> -9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
>>>> -6.3% : Phoronix system/sqlite on OnPrem X6-2
>>>> -18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth & 1
>>>> thread & 1M buffer size on OnPrem X6-2
>>>> -4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 depth &
>>>> 1 thread & 1M buffer size on OnPrem X6-2
>>>> Up to -30% : Some Netpipe metrics on OnPrem X5-2
>>>>
>>>> The culprit commits' messages mention that these reverts were done due
>>>> to performance regressions introduced in Intel Jasper Lake systems but
>>>> this revert is causing issues in other systems unfortunately. I wanted
>>>> to know the maintainers' opinion on how we should proceed in order to
>>>> fix this. If we reapply it'll bring back the previous regressions on
>>>> Jasper Lake systems and if we don't revert it then it's stuck with
>>>> current regressions. If this problem has been reported before and a fix
>>>> is in the works then please let me know I shall follow developments to
>>>> that mail thread.
>>> The discussion regarding this can be found here:
>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA-b9PW7hw$ 
>>> we explored an alternative to the full revert here:
>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/4687373.LvFx2qVVIh@rafael.j.wysocki/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA9PSf_uMQ$ 
>>> unfortunately that didn't lead anywhere useful, so Rafael went with the
>>> full revert you're seeing now.
>>>
>>> Ultimately it seems to me that this "aggressiveness" on deep idle tradeoffs
>>> will highly depend on your platform, but also your workload, Jasper Lake
>>> in particular seems to favor deep idle states even when they don't seem
>>> to be a 'good' choice from a purely cpuidle (governor) perspective, so
>>> we're kind of stuck with that.
>>>
>>> For teo we've discussed a tunable knob in the past, which comes naturally with
>>> the logic, for menu there's nothing obvious that would be comparable.
>>> But for teo such a knob didn't generate any further interest (so far).
>>>
>>> That's the status, unless I missed anything?
>> By reading everything in the links Chrsitian provided, you can see
>> that we had difficulties repeating test results on other platforms.
>>
>> Of the tests listed herein, the only one that was easy to repeat on my
>> test server, was the " Phoronix pts/sqlite" one. I got (summary: no difference):
>>
>> Kernel 6.18									Reverted			
>> pts/sqlite-2.3.0			menu rc4		menu rc1		menu rc1		menu rc3	
>> 				performance		performance		performance		performance	
>> test	what			ave			ave			ave			ave	
>> 1	T/C 1			2.147	-0.2%		2.143	0.0%		2.16	-0.8%		2.156	-0.6%
>> 2	T/C 2			3.468	0.1%		3.473	0.0%		3.486	-0.4%		3.478	-0.1%
>> 3	T/C 4			4.336	0.3%		4.35	0.0%		4.355	-0.1%		4.354	-0.1%
>> 4	T/C 8			5.438	-0.1%		5.434	0.0%		5.456	-0.4%		5.45	-0.3%
>> 5	T/C 12			6.314	-0.2%		6.299	0.0%		6.307	-0.1%		6.29	0.1%
>>
>> Where:
>> T/C means: Threads / Copies
>> performance means: intel_pstate CPU frequency scaling driver and the performance CPU frequencay scaling governor.
>> Data points are in Seconds.
>> Ave means the average test result. The number of runs per test was increased from the default of 3 to 10.
>> The reversion was manually applied to kernel 6.18-rc1 for that test.
>> The reversion was included in kernel 6.18-rc3.
>> Kernel 6.18-rc4 had another code change to menu.c
>>
>> In case the formatting gets messed up, the table is also attached.
>>
>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
>> HWP: Enabled.
> 
> I was able to recover performance on 5.15 and 5.4 LTS based kernels
> after reapplying the revert on X6-2 systems.
> 
> Architecture:                x86_64
>   CPU op-mode(s):            32-bit, 64-bit
>   Address sizes:             46 bits physical, 48 bits virtual
>   Byte Order:                Little Endian
> CPU(s):                      56
>   On-line CPU(s) list:       0-55
> Vendor ID:                   GenuineIntel
>   Model name:                Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
>     CPU family:              6
>     Model:                   79
>     Thread(s) per core:      2
>     Core(s) per socket:      14
>     Socket(s):               2
>     Stepping:                1
>     CPU(s) scaling MHz:      98%
>     CPU max MHz:             2600.0000
>     CPU min MHz:             1200.0000
>     BogoMIPS:                5188.26
>     Flags:                   fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr pg
>                              e mca cmov pat pse36 clflush dts acpi mmx
> fxsr sse 
>                              sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp
> lm cons
>                              tant_tsc arch_perfmon pebs bts rep_good
> nopl xtopol
>                              ogy nonstop_tsc cpuid aperfmperf pni
> pclmulqdq dtes
>                              64 monitor ds_cpl vmx smx est tm2 ssse3
> sdbg fma cx
>                              16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic
> movbe po
>                              pcnt tsc_deadline_timer aes xsave avx f16c
> rdrand l
>                              ahf_lm abm 3dnowprefetch cpuid_fault epb
> cat_l3 cdp
>                              _l3 pti intel_ppin ssbd ibrs ibpb stibp
> tpr_shadow 
>                              flexpriority ept vpid ept_ad fsgsbase
> tsc_adjust bm
>                              i1 hle avx2 smep bmi2 erms invpcid rtm cqm
> rdt_a rd
>                              seed adx smap intel_pt xsaveopt cqm_llc
> cqm_occup_l
>                              lc cqm_mbm_total cqm_mbm_local dtherm arat
> pln pts 
>                              vnmi md_clear flush_l1d
> Virtualization features:     
>   Virtualization:            VT-x
> Caches (sum of all):         
>   L1d:                       896 KiB (28 instances)
>   L1i:                       896 KiB (28 instances)
>   L2:                        7 MiB (28 instances)
>   L3:                        70 MiB (2 instances)
> NUMA:                        
>   NUMA node(s):              2
>   NUMA node0 CPU(s):         0-13,28-41
>   NUMA node1 CPU(s):         14-27,42-55
> Vulnerabilities:             
>   Gather data sampling:      Not affected
>   Indirect target selection: Not affected
>   Itlb multihit:             KVM: Mitigation: Split huge pages
>   L1tf:                      Mitigation; PTE Inversion; VMX conditional
> cache fl
>                              ushes, SMT vulnerable
>   Mds:                       Mitigation; Clear CPU buffers; SMT vulnerable
>   Meltdown:                  Mitigation; PTI
>   Mmio stale data:           Mitigation; Clear CPU buffers; SMT vulnerable
>   Reg file data sampling:    Not affected
>   Retbleed:                  Not affected
>   Spec rstack overflow:      Not affected
>   Spec store bypass:         Mitigation; Speculative Store Bypass
> disabled via p
>                              rctl
>   Spectre v1:                Mitigation; usercopy/swapgs barriers and
> __user poi
>                              nter sanitization
>   Spectre v2:                Mitigation; Retpolines; IBPB conditional;
> IBRS_FW; 
>                              STIBP conditional; RSB filling; PBRSB-eIBRS
> Not aff
>                              ected; BHI Not affected
>   Srbds:                     Not affected
>   Tsa:                       Not affected
>   Tsx async abort:           Mitigation; Clear CPU buffers; SMT vulnerable
>   Vmscape:                   Mitigation; IBPB before exit to userspace
> 

It would be nice to get the idle states here, ideally how the states' usage changed
from base to revert.
The mentioned thread did this and should show how it can be done, but a dump of
cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
before and after the workload is usually fine to work with:
https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/

