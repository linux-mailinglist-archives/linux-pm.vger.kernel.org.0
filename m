Return-Path: <linux-pm+bounces-21343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91367A27771
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5401F18818EB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AEA215767;
	Tue,  4 Feb 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s3Qfw2uq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA662153E4;
	Tue,  4 Feb 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687344; cv=none; b=X/wU89ueZLKX+n9I8t2IScGU2GBO3Eh58oGu23L1h4QN7AVPCdweySVzVthoLWL6VThdEkKeWPfOxuaorJBXwnbpfJpUtFsLcX+4kyeLsLB5FRUBnQ4eyPEvfcP2F1TGPttQ42PZVd04QRAIPYOxVjLYT4YjpWGmDApb0/9Vrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687344; c=relaxed/simple;
	bh=wsijlzgMdoHW4uBDacfOb2+5G542Bpq47cnyb4TwGWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=cqWoHBPYZzQuYO97mSw5WKLACz5Wuke1gUAp3iOJH8zCConLuS9V0/miuexlBBommstQKhBu5zfD4s/2qmMdMraLPbSAfPHKjPB4mTeqYSMVmKHAjcllUeDFrSXH+PO7ZrxQC4RCPe1NxHVmxGWFBuhcwtYnq+bomla6bqtXTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s3Qfw2uq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEovB023103;
	Tue, 4 Feb 2025 16:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lsnxs4
	YYuwcy4ednIOPPvdwcYVW7AaeXTcdlCgi8uJI=; b=s3Qfw2uqHujKVOQsorwMPx
	FTlDtXqE1ID/TJrm8Bgz/UTc1/t4eKIWRFSbqWEiv6QAKNhLCNWMWOC+wRda8Uat
	DRpr/bmgmBstkrQ4JD6xdioee2jn1pHfux+4DcdVU+lVbl0syOwc4vIQqvLub1AV
	3EzuNmEYVQX7EWH10i7SWkbnX/YUwwZO5YEPOA3d//CIxYvmtkzexMJnpiNb9zuZ
	ca3hRrGgAsT8q/UCIewK+yrFL/O3Khc9KJv/Tt1VUPIZWkS2MoNSmmjFiP7Y90wd
	LHAS8nX7wRkB86Ng10N5KI1eNiGt1JKvvc3YlIItr3nMJjHkUrzyyx9H4Ln8do3w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kcq7u7tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 16:42:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514FZg47016271;
	Tue, 4 Feb 2025 16:41:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxsckh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 16:41:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514GfwUN22217308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 16:41:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CDE058055;
	Tue,  4 Feb 2025 16:41:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 000D958059;
	Tue,  4 Feb 2025 16:41:52 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.171.15.121])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 16:41:52 +0000 (GMT)
Message-ID: <c9e56c5f54cc33338762c94e9bed7b5a0d5de812.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
        viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        zhanjie9@hisilicon.com, lihuisong@huawei.com, fanghao11@huawei.com,
        gautam@linux.ibm.com, aboorvad@linux.ibm.com
Date: Tue, 04 Feb 2025 22:11:50 +0530
In-Reply-To: <20250117101457.1530653-3-zhenglifeng1@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
	 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bXPXgGszO0mZJjVHWcNz1aleg5HtmDpS
X-Proofpoint-ORIG-GUID: bXPXgGszO0mZJjVHWcNz1aleg5HtmDpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040127

On Fri, 2025-01-17 at 18:14 +0800, Lifeng Zheng wrote:

> In cpufreq_online() of cpufreq.c, the per-policy boost flag is already set
> to mirror the cpufreq_driver boost during init but using freq_table to
> judge if the policy has boost frequency. There are two drawbacks to this
> approach:
> 
> 1. It doesn't work for the cpufreq drivers that do not use a frequency
> table. For now, acpi-cpufreq and amd-pstate have to enable boost in policy
> initialization. And cppc_cpufreq never set policy to boost when going
> online no matter what the cpufreq_driver boost flag is.
> 
> 2. If the cpu goes offline when cpufreq_driver boost enabled and then goes
> online when cpufreq_driver boost disabled, the per-policy boost flag will
> unreasonably remain true.
> 
> Running set_boost at the end of the online process is a more generic way
> for all cpufreq drivers.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5882d7f5e3c1..5a3566c2eb8d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1409,10 +1409,6 @@ static int cpufreq_online(unsigned int cpu)
>  			goto out_free_policy;
>  		}
>  
> -		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
> -			policy->boost_enabled = true;
> -
>  		/*
>  		 * The initialization has succeeded and the policy is online.
>  		 * If there is a problem with its frequency table, take it
> @@ -1573,6 +1569,18 @@ static int cpufreq_online(unsigned int cpu)
>  	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>  		policy->cdev = of_cpufreq_cooling_register(policy);
>  
> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +	if (policy->boost_enabled != cpufreq_boost_enabled()) {
> +		policy->boost_enabled = cpufreq_boost_enabled();
> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
> +		if (ret) {
> +			/* If the set_boost fails, the online operation is not affected */
> +			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
> +				policy->boost_enabled ? "enable" : "disable");
> +			policy->boost_enabled = !policy->boost_enabled;
> +		}
> +	}
> +
>  	pr_debug("initialization complete\n");
>  
>  
> 	return 0;

Hi,

This patch causes a boot-time crash on PowerNV (Power9-baremetal systems) when WoF
(Workload Optimized Frequency - boost) is enabled, starting from v6.14-rc1.

The crash happens due to null pointer dereference of the `set_boost` function.

`set_boost` is only assigned after the cpufreq driver is registered on PowerNV
as below, 

Initialization Flow: (powernv_cpufreq_init -> cpufreq_enable_boost_support -> 
                      initializes set_boost).

However, with this patch, `set_boost` is invoked in `cpufreq_register_driver`
before it is initialized.

Access Flow:         (powernv_cpufreq_init -> cpufreq_register_driver -> cpufreq_online -> 
                      attempts to access cpufreq_driver->set_boost,
                      which is still NULL at this point).

This causes a boot-time crash as follows:

[    9.393946][    T1] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
[    9.393946][    T1] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
[    9.396285][    T1] Faulting instruction address: 0x00000000
[    9.396285][    T1] Faulting instruction address: 0x00000000
[    9.398545][    T1] Oops: Kernel access of bad area, sig: 7 [#1]
[    9.398545][    T1] Oops: Kernel access of bad area, sig: 7 [#1]
[    9.398804][    T1] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[    9.398804][    T1] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[    9.400114][    T1] Modules linked in:
[    9.400114][    T1] Modules linked in:
[    9.400283][    T1] CPU: 19 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc1-dirty #23
[    9.400283][    T1] CPU: 19 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc1-dirty #23
[    9.400605][    T1] Hardware name: 0000000000000000 POWER9 0x4e1202 opal:v6.6-111-gd362ae4f-root-dirty-157d5e1 PowerNV
[    9.400605][    T1] Hardware name: 0000000000000000 POWER9 0x4e1202 opal:v6.6-111-gd362ae4f-root-dirty-157d5e1 PowerNV
[    9.403093][    T1] NIP:  0000000000000000 LR: c000000000f7a574 CTR: 0000000000000000
[    9.403093][    T1] NIP:  0000000000000000 LR: c000000000f7a574 CTR: 0000000000000000
[    9.404397][    T1] REGS: c00020000419f680 TRAP: 0400   Not tainted  (6.14.0-rc1-dirty)
[    9.404397][    T1] REGS: c00020000419f680 TRAP: 0400   Not tainted  (6.14.0-rc1-dirty)
[    9.407771][    T1] MSR:  9000000002089033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 84000482  XER: 00000000
[    9.407771][    T1] MSR:  9000000002089033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 84000482  XER: 00000000
[    9.409191][    T1] CFAR: c000000000f7a570 IRQMASK: 0 
[    9.409191][    T1] GPR00: c000000000f7a51c c00020000419f920 c000000001ea3200 c00020002455f800 
[    9.409191][    T1] GPR04: 0000000000000001 0000000000000000 0000000000000001 0000000000000000 
[    9.409191][    T1] GPR08: 0000000000000000 c000000002a1f280 0000000000000001 0000000000000000 
[    9.409191][    T1] GPR12: 0000000000000000 c000003ffefe0900 c00000000001101c 0000000000000000 
[    9.409191][    T1] GPR16: 0000000000000000 0000000000000000 c000000002c20b80 000000000000005a 
[    9.409191][    T1] GPR20: c00000007ffa0a14 c000000002973200 c000000002c1ff38 c00020002455fc48 
[    9.409191][    T1] GPR24: c0000000029752f8 c000000002c1ff10 c00020002455fcb8 0000000000000000 
[    9.409191][    T1] GPR28: c000000002a71be0 0000000000000000 c00020002455f800 c000000002a1f0a0 
[    9.409191][    T1] CFAR: c000000000f7a570 IRQMASK: 0 
[    9.409191][    T1] GPR00: c000000000f7a51c c00020000419f920 c000000001ea3200 c00020002455f800 
[    9.409191][    T1] GPR04: 0000000000000001 0000000000000000 0000000000000001 0000000000000000 
[    9.409191][    T1] GPR08: 0000000000000000 c000000002a1f280 0000000000000001 0000000000000000 
[    9.409191][    T1] GPR12: 0000000000000000 c000003ffefe0900 c00000000001101c 0000000000000000 
[    9.409191][    T1] GPR16: 0000000000000000 0000000000000000 c000000002c20b80 000000000000005a 
[    9.409191][    T1] GPR20: c00000007ffa0a14 c000000002973200 c000000002c1ff38 c00020002455fc48 
[    9.409191][    T1] GPR24: c0000000029752f8 c000000002c1ff10 c00020002455fcb8 0000000000000000 
[    9.409191][    T1] GPR28: c000000002a71be0 0000000000000000 c00020002455f800 c000000002a1f0a0 
[    9.415226][    T1] NIP [0000000000000000] 0x0
[    9.415226][    T1] NIP [0000000000000000] 0x0
[    9.417435][    T1] LR [c000000000f7a574] cpufreq_online+0x440/0xe14
[    9.417435][    T1] LR [c000000000f7a574] cpufreq_online+0x440/0xe14
[    9.419701][    T1] Call Trace:
[    9.419701][    T1] Call Trace:
[    9.422849][    T1] [c00020000419f920] [c000000000f7a51c] cpufreq_online+0x3e8/0xe14 (unreliable)
[    9.422849][    T1] [c00020000419f920] [c000000000f7a51c] cpufreq_online+0x3e8/0xe14 (unreliable)
[    9.430225][    T1] [c00020000419fa00] [c000000000f7b030] cpufreq_add_dev+0xb4/0xd8
[    9.430225][    T1] [c00020000419fa00] [c000000000f7b030] cpufreq_add_dev+0xb4/0xd8
[    9.434547][    T1] [c00020000419fa30] [c000000000c89e18] subsys_interface_register+0x18c/0x1d4
[    9.434547][    T1] [c00020000419fa30] [c000000000c89e18] subsys_interface_register+0x18c/0x1d4
[    9.440934][    T1] [c00020000419faa0] [c000000000f763a8] cpufreq_register_driver+0x1f0/0x370
[    9.440934][    T1] [c00020000419faa0] [c000000000f763a8] cpufreq_register_driver+0x1f0/0x370
[    9.444314][    T1] [c00020000419fb20] [c000000002093340] powernv_cpufreq_init+0x690/0xa10
[    9.444314][    T1] [c00020000419fb20] [c000000002093340] powernv_cpufreq_init+0x690/0xa10
[    9.444686][    T1] [c00020000419fc30] [c000000000010cb8] do_one_initcall+0x60/0x2c8
[    9.444686][    T1] [c00020000419fc30] [c000000000010cb8] do_one_initcall+0x60/0x2c8
[    9.445024][    T1] [c00020000419fd00] [c0000000020059ec] kernel_init_freeable+0x33c/0x530
[    9.445024][    T1] [c00020000419fd00] [c0000000020059ec] kernel_init_freeable+0x33c/0x530
[    9.446375][    T1] [c00020000419fde0] [c000000000011048] kernel_init+0x34/0x26c
[    9.446375][    T1] [c00020000419fde0] [c000000000011048] kernel_init+0x34/0x26c
[    9.448684][    T1] [c00020000419fe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
[    9.448684][    T1] [c00020000419fe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c

[    9.455840][    T1] ---[ end trace 0000000000000000 ]---
[    9.455840][    T1] ---[ end trace 0000000000000000 ]---

The fix will be to initialize set_boost earlier in powernv_cpufreq_init before calling
cpufreq_register_driver.

Quickly tried this patch and it resolves the issue:

---

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index ae79d909943b..2dd61de34a28 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1127,8 +1127,10 @@ static int __init powernv_cpufreq_init(void)
        if (rc)
                goto out;
 
-       if (powernv_pstate_info.wof_enabled)
+       if (powernv_pstate_info.wof_enabled) {
                powernv_cpufreq_driver.boost_enabled = true;
+               powernv_cpufreq_driver.set_boost = cpufreq_boost_set_sw;
+       }
        else
                powernv_cpu_freq_attr[SCALING_BOOST_FREQS_ATTR_INDEX] = NULL;
 
@@ -1138,9 +1140,6 @@ static int __init powernv_cpufreq_init(void)
                goto cleanup;
        }
 
-       if (powernv_pstate_info.wof_enabled)
-               cpufreq_enable_boost_support();
-
        register_reboot_notifier(&powernv_cpufreq_reboot_nb);
        opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 
---

I noticed that Viresh is working on a similar patch [1] as part of a broader patchset
to simplify boost handling, which should also resolve this issue.

Should we merge this patch [1] and related patches since this is causing a crash,
or submit a separate patch to fix this?

[1]: https://lore.kernel.org/all/9b4af20d5b415f41e866ddd8bde9cf6441c463b8.1737707712.git.viresh.kumar@linaro.org/

Regards,
Aboorva


