Return-Path: <linux-pm+bounces-36970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C796DC14CA5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 14:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F8E3AF4E8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA1330D51;
	Tue, 28 Oct 2025 13:11:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03202EFD90;
	Tue, 28 Oct 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657115; cv=none; b=a3h63Cf0HfGlRM2GvXFT6ex6UsPYcVYTAHtzPT6PQaw2p8WpbCLFXoa/lzKqVX2PP4rNei7ls1LnWYsKauvDlbrC/60X32oApkbUV45Rw2R1KGsQ73pft9W09PtKzX76UXzuVhCg5LfqYmershiI0IoWvVBnGmgpyLmDX49i0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657115; c=relaxed/simple;
	bh=tGgMOwiHnEFu2eRiVpUtimjkdr+IfoZfTKO6O1q88+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3qbDX3sKdPB5PliLjisQs6IqvMKA72RGDJJXLi+bWLzb/IzEcDZOnlknSZOaq/c5VrKOCOvoedhBBSTNXN9CLR/Wug3Dxd04aRHLrFT1BPRfHnfh8X9Xq0rz3K54lyboxlqhocQKRX0lBvaFagjB4e34zPjqGLcDaHSCx0kEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E1E1168F;
	Tue, 28 Oct 2025 06:11:43 -0700 (PDT)
Received: from [10.57.39.55] (unknown [10.57.39.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1B6E3F673;
	Tue, 28 Oct 2025 06:11:48 -0700 (PDT)
Message-ID: <b4386726-9c50-47cb-b521-cd6f871d64de@arm.com>
Date: Tue, 28 Oct 2025 13:12:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, christian.loehle@arm.com,
 amit.kucheria@linaro.org, ulf.hansson@linaro.org, james.morse@arm.com,
 Dave.Martin@arm.com, reinette.chatre@intel.com, tony.luck@intel.com,
 pavel@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <eb9abe9d-3d12-4bf1-85da-deb38b8da321@arm.com>
 <f1195632-d973-4339-a89d-e1e62b98015d@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <f1195632-d973-4339-a89d-e1e62b98015d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/24/25 09:25, Zhongqiu Han wrote:
> On 10/23/2025 9:09 PM, Lukasz Luba wrote:
>> Hi Zhongqui,
>>
>> My apologies for being a bit late with my comments...
>>
>> On 7/21/25 13:40, Zhongqiu Han wrote:
>>> Hi all,
>>>
>>> This patch series introduces support for CPU affinity-based latency
>>> constraints in the PM QoS framework. The motivation is to allow
>>> finer-grained power management by enabling latency QoS requests to 
>>> target
>>> specific CPUs, rather than applying system-wide constraints.
>>>
>>> The current PM QoS framework supports global and per-device CPU latency
>>> constraints. However, in many real-world scenarios, such as IRQ affinity
>>> or CPU-bound kernel threads, only a subset of CPUs are
>>> performance-critical. Applying global constraints in such cases
>>> unnecessarily prevents other CPUs from entering deeper C-states, leading
>>> to increased power consumption.
>>>
>>> This series addresses that limitation by introducing a new interface 
>>> that
>>> allows latency constraints to be applied to a CPU mask. This is
>>> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
>>> embedded systems where power efficiency is critical for example:
>>>
>>>                          driver A       rt kthread B      module C
>>>    CPU IDs (mask):         0-3              2-5              6-7
>>>    target latency(us):     20               30               100
>>>                            |                |                |
>>>                            v                v                v
>>>                            +---------------------------------+
>>>                            |        PM  QoS  Framework       |
>>>                            +---------------------------------+
>>>                            |                |                |
>>>                            v                v                v
>>>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>>>    runtime latency(us):   20             20, 30             100
>>>
>>> The current implementation includes only cpu_affinity_latency_qos_add()
>>> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
>>> planned for future submission, along with PM QoS optimizations in the 
>>> UFS
>>> subsystem.
>>>
>>> Patch1 introduces the core support for CPU affinity latency QoS in 
>>> the PM
>>> QoS framework.
>>>
>>> Patch2 removes redundant KERN_ERR prefixes in WARN() calls in the global
>>> CPU PM QoS interface. This change addresses issues in existing code 
>>> and is
>>> not related to the new interface introduced in this patch series.
>>>
>>> Patch3 adds documentation for the new interface.
>>>
>>> Patch4 fixes a minor documentation issue related to the return type of
>>> cpu_latency_qos_request_active(). This change addresses issues in 
>>> existing
>>> doc and is not related to the new interface introduced in this patch
>>> series.
>>>
>>> Patch5 updates the resctrl pseudo-locking logic to use the new CPU
>>> affinity latency QoS helpers, improving clarity and consistency. The 
>>> only
>>> functional and beneficial change is that the new interface actively 
>>> wakes
>>> up CPUs whose latency QoS values have changed, ensuring the latency 
>>> limit
>>> takes effect immediately.
>>
>> Could you describe a bit more the big picture of this proposed design,
>> please?
>>
>> Ideally with some graph of connected frameworks & drivers and how they
>> are going to work together.
> 
> Hi Lukasz,
> Thank you very much for your review and discussion~
> 
> I will describe you one big picture if needed, please allow me
> illustrate a simple scenario using pseudo code first:
> 
> Suppose there is a USB driver. This driver uses the kernel existing
> cpu_latency_qos_* interfaces to boost its IRQ execution efficiency. Its
> IRQ affinity is set to core0 and core1 according to DTS config, and the
> affinity of its threaded IRQ (bottom half) is also set to CPU0 and CPU1.
> 
> 
> =================================================================
> Using the kernel existing cpu_latency_qos_* interfaces:
> =================================================================
> static int dwc3_sample_probe(struct platform_device *pdev)
> {
>    cpu_latency_qos_add_request(&foo->pm_qos_req,DEFAULT_VALUE);
>    xxxx;
>    ret = devm_request_threaded_irq(xxx,xxx,foo_dwc3_pwr_irq, ....)
>    xxxx;
> }
> 
> static irqreturn_t foo_dwc3_pwr_irq(int irq, void *dev)
> {
>    xxxx;
>    cpu_latency_qos_update_request(&foo->pm_qos_req, 0);
> 
>    /*.... process interrupt ....*/
> 
>    cpu_latency_qos_update_request(&foo->pm_qos_req, DEFAULT_VALUE);
> 
>    return IRQ_HANDLED;
> 
> }
> 
> 
> The number of IRQ executions on each CPU:
> ==================================================================
> IRQ  HWIRQ   affinity CPU0    CPU1   CPU2 CPU3 CPU4 CPU5 CPU6 CPU7
> 320  0xb0    0x3      9782468 415472  0    0    0    0    0    0
> ==================================================================
> 
> ==================================================================
> Process: irq/320-dwc3, [affinity: 0x3]  cpu:1    pid:5250   ppid:2
> ==================================================================
> 
> 
>  From the code, we can see that the USB module using the kernel existing
> cpu_latency_qos_* interfaces sets the CPU latency to 0, which prevents
> all CPUs from entering idle states—even C1. During operation, the USB
> IRQs is triggered 9,782,468 times on CPU0, and each time it runs, all
> CPUs are blocked from entering deeper C-states. However, only CPU0, CPU1
> are actually involved in handling the IRQ and its threaded bottom half.
> It will cause unnecessary power consumption on other CPUs.
> (Please note, due to the simplicity of the pseudocode, I did not show
> how the IRQ bottom-half thread is synchronized to restrict CPU idle
> states via PM QoS. In reality, it's clear that we can also apply a CPU
> latency limit to the bottom-half thread.)
> 
> 
> If we use current patch series API cpu_affinity_latency_qos_xxx, such
> as:
> 
> =================================================================
> Using current patch series cpu_affinity_latency_qos_* interfaces:
> =================================================================
> static int dwc3_sample_probe(struct platform_device *pdev)
> {
>    cpu_affinity_latency_qos_add(&foo->pm_qos_req,DEFAULT_VALUE, mask);
>    xxxx;
>    ret = devm_request_threaded_irq(xxx,xxx,foo_dwc3_pwr_irq, ....)
>    xxxx;
> }
> 
> We can only constrain the CPU latency PM QoS on CPU0 and CPU1 in order
> to save power.

Thank you for this explanation. IMO this could be part of the
documentation patch.

> 
>>
>> E.g.:
>> 1. what are the other components in the kernel which would use this
>> feature?
> 
> 1.Drivers such as Audio, USB, and UFS, which currently rely on the
> kernel's global CPU Latency PM QoS interface, but only require latency
> constraints on a subset of CPUs, can leverage this new interface to
> achieve improved power efficiency.
> 
> 2.I’m considering supporting this feature in userspace.
> Once implemented, userspace threads—such as mobile gaming threads that
> aim to constrain CPU latency and are already bound to big cores—will be
> able to use the API to help save power.
> 
>> 2. is there also a user-space interface planned for it so a HAL in
>> the middle-ware would configure these "short-wake-up-CPU"?
> 
> Yes, I am considering to support userspace on patch V3.
> 
>> 3. Is it possible to view/debug from the user-space which component
>> requested this setting for some subsets of cpus?
> 
> I'm uncertain whether we should provide the ability to inspect
> which components are applying constraints on CPU latency. However,
> what I do want to ensure is that—similar to the existing /dev
> cpu_dma_latency interface in the current kernel—I can offer per-CPU
> level latency value setting and querying.
> 
>

OK, I think this is a good approach to not tackle all in single
step, but in some phases. The user-space would need more thinking.

Regards,
Lukasz

