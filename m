Return-Path: <linux-pm+bounces-11389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2D93BC81
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 08:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A709FB20A4A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 06:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB216C694;
	Thu, 25 Jul 2024 06:24:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220329CF7
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888681; cv=none; b=HUq0OAdlWoPy49PcPD0rDq271Zr+b8cD5AJ0RKVg3+I23zHdk9nAqyLYbubBJh6eQoMo1p81MUThrUh++2PhlOm8WXDNekW7VvMQl1H1+dnj6rm0/vnBbiZXdcoSQqRJQD+pnIdmpw0SMw7cYTFCx+mZqbyvcinPxMKWnUGemFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888681; c=relaxed/simple;
	bh=lZBwmoEorzjL77CEqlDLs6FXsDcw+eGuHtCndAvfQA0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:CC:Content-Type; b=MAcyCFwb50G5ZCGHOh4zWdXXMLRhLzkqrFNgwqYDgQNZwjN3JO8HmuQ55s7VyVrOtP4JAMOrtzhttlhdab54kxcAGMbR5PNjbv0yKQWajhFzzNINTgxI0klsQi2RJX1xrTcZX2uKy7CUXTAOVVzY5FZ0nrapR7ImuAPpPxIBXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1721888666-086e23073fc1ac0001-MQbzy6
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id p2tqQ4xbqLOPtuxR (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 25 Jul 2024 14:24:26 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 14:24:26 +0800
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 14:24:25 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Thu, 25 Jul 2024 14:24:25 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from [10.32.57.247] (10.32.57.247) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 10:31:31 +0800
Message-ID: <14cf0b83-7030-4ec5-97b1-40c90424fe3f@zhaoxin.com>
Date: Thu, 25 Jul 2024 10:31:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, <akpm@linux-foundation.org>,
	<dianders@chromium.org>, <tglx@linutronix.de>, <song@kernel.org>,
	<liusong@linux.alibaba.com>, <yaoma@linux.alibaba.com>,
	<kjlx@templeofstupid.com>, <lizhe.67@bytedance.com>, <linux@weissschuh.net>,
	<j.granados@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Unknown NMI after S4 resume
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, <SilviaZhao@zhaoxin.com>, "Linda Chai(BJ-RD)"
	<LindaChai@zhaoxin.com>, <Felixzhang@zhaoxin.com>
X-ASG-Orig-Subj: Unknown NMI after S4 resume
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 7/25/2024 2:24:24 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1721888666
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5154
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128091
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Hi,

When running S4 test on Zhaoxin platform with Ubuntu22.04 kernel-6.10 we 
got unknown NMI messages after S4 resumed:

[  115.792224] Uhhuh. NMI received for unknown reason 2d on CPU 0.
[  115.792226] Do you have a strange power saving mode enabled?
[  115.792228] Dazed and confused, but trying to continue

And reproduced on Intel platform.

After tracing, we find that the reason for this Unknown NMI occurs is as 
follows:
a, 1st kernel starts normally and NMI watchdog is enabled on all cores;
b, NMI watchdog is disabled on all cores through the sys interface, then 
variable active_events goto zero;
c, Start hibernate, create & save hibernation image, then go hibernated;
d, S4 resume event happened, 2nd kernel starts normally and NMI watchdog 
is enabled on All cores;
e, 2nd kernel find S4 image and try to restore S4 image;
f, 2nd kernel disable non-boot CPUs, which would disable NMI watchdog 
for APs;
g, Restore S4 image saved at step c;
h, 1st-hibernated kernel restore, re-enable non-boot CPUs, as NMI 
watchdog is disabled in step b, this which would keep APs NMI watchdog 
disabled; Besides, the variable active_events is restored to zero;

But BSP NMI watchdog is still enabled, and the PMC will trigger NMI 
interrupt periodically.
If PMC NMI triggered, perf_event_nmi_handler will be called, but it 
would see active_events is zero, so it goes out directly and return 
NMI_DONE;
This then leads to unknown NMI messages.

static int
perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
{
        u64 start_clock;
        u64 finish_clock;
        int ret;

        /*
        * All PMUs/events that share this PMI handler should make sure to
        * increment active_events for their events.
        */
        if (!atomic_read(&active_events))
               return NMI_DONE;
......

It seems that the BSP does not refer to the settings of the NMI watchdog 
sys interface previously saved to the S4 image to configure the NMI 
watchdog when doing S4 resume.
Should consider this situation and patch it?

---
Zhaoxin platform /proc/cpuinfo
processor	: 0
vendor_id	: CentaurHauls
cpu family	: 7
model		: 59
model name	: ZHAOXIN KaiXian KX-U6780A@2.7GHz
stepping	: 0
cpu MHz		: 2694.594
cache size	: 4096 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon rep_good nopl nonstop_tsc cpuid 
aperfmperf pni pclmulqdq monitor vmx smx est tm2 ssse3 cx16 xtpr pcid 
sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
rng rng_en ace ace_en ace2 phe phe_en pmm pmm_en lahf_lm abm 
3dnowprefetch ibrs ibpb tpr_shadow ept vpid fsgsbase tsc_adjust bmi1 
smep bmi2 invpcid rdseed adx smap sha_ni xsaveopt dtherm vnmi umip pku 
ospke rdpid arch_capabilities
vmx flags	: vnmi invvpid ept_x_only ept_1gb tsc_offset vtpr mtf ept vpid 
unrestricted_guest ple
bugs		: spectre_v1
bogomips	: 5389.21
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

Intel platform /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 151
model name	: 12th Gen Intel(R) Core(TM) i7-12700K
stepping	: 2
microcode	: 0x35
cpu MHz		: 4653.842
cache size	: 25600 KB
physical id	: 0
siblings	: 20
core id		: 0
cpu cores	: 12
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 32
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq 
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm 
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c 
rdrand lahf_lm abm 3dnowprefetch cpuid_fault cat_l2 cdp_l2 ssbd ibrs 
ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdt_a rdseed adx 
smap clflushopt clwb intel_pt sha_ni xsaveopt xsavec xgetbv1 xsaves 
split_lock_detect avx_vnni dtherm ida arat pln pts hwp hwp_notify 
hwp_act_window hwp_epp hwp_pkg_req hfi vnmi umip pku ospke waitpkg gfni 
vaes vpclmulqdq rdpid movdiri movdir64b fsrm md_clear serialize pconfig 
arch_lbr ibt flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad 
ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid 
unrestricted_guest vapic_reg vid ple shadow_vmcs ept_violation_ve 
ept_mode_based_exec tsc_scaling usr_wait_pause
bugs		: spectre_v1 spectre_v2 spec_store_bypass swapgs eibrs_pbrsb rfds bhi
bogomips	: 7219.20
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

BRs!
TonyWWang-oc

