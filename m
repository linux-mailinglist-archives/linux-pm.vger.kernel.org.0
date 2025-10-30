Return-Path: <linux-pm+bounces-37100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A1C203BB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 14:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FF5405756
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DF62FB977;
	Thu, 30 Oct 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hnhdAaaU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQLOcJOB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591F2EC088
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830744; cv=none; b=q8LP8D4sKARNCeKUS+p3SlCWasSgCzFWSmblVXQTbqTVlGpn7zFdR/3NCeoS2Z4i+KCPFrig+mNt92STyZMtQDeEF06l0ZkRNL3riaFU2ZLxWReOCNnFGquxjc50FXrgU0tLdgbGRsINMxoTiDpzrs9Am8HRwXmi50MjbV1+NYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830744; c=relaxed/simple;
	bh=dtOU1ozf6cXnHz+12ZZBEI2OgJilzdYsw7nNix+lcZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEMm7FExNKUk3+wsPhxy14QmEW/GaP3ctC+mCQ7zl01lidSUu2xGXniLoSwtS8oPx0eLeTXCopMmWFfw5+28Pn1kPOnsmetGMSNuhayA4ruHj00RFqhAfi9x8aIzQtjrMPu6AKQ+Ptk0tGtLDHHqol4yBOIS8XVcKOgKPRodOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hnhdAaaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQLOcJOB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7ahdd1579002
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 13:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+msX6P+5D/LE/Fn2Jk3rO8gJso33GoGorcKjWRzk7s4=; b=hnhdAaaUldphRWae
	bUKY3V8wQ8RhY6yA9WmalNCJK8Mwer+IzlKa14y0rXIUnShZ0+3vKTqsXZzmnsj6
	bESD/AporSR7bJ5MLlJIIlvwiP/p3gx09i8IVz8KJctca0fxgoxwQAahYQPFs+jZ
	k4wmH2fW/NulGZEkTyYzAoju8DozPiBB3vKpQeoxFdJ9oLfwqVdcUBZw+SgBdUTJ
	FBTxdLQaLAmfoPXuUrqTDalAHQiijBpyoibI1jSnhGgYula4lwN1TZm2L3Eh8em5
	X/h7oZwtV4kHGQkFdEQszdMyHSS9A217A/+TP0UGhyVArjo/WlUjK1g4WVA0bzFP
	tRoU/w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjejf3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 13:25:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a43210187cso863097b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761830741; x=1762435541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+msX6P+5D/LE/Fn2Jk3rO8gJso33GoGorcKjWRzk7s4=;
        b=SQLOcJOBZN6utEQdVMWbawrNRH4vRo7KNc7mgicK8KTJzJrG0DXsv4Lds5LuVKaPIv
         jxKxij/KDTGJo5YEutnZ8DhGaZjkTTEgo18JP7T9FMlDqe0lo+pctpCHmfL9hmEdFa1O
         Fq2b2RX5AQJHtm/1F1qGxvEk7jL0TbtU/3PbiqGQCjIP+6pimWfYbNd+cdFdaUF7Cu3x
         mezJLs23VhEAoD+tjiS1O6VCcyRge4dhCIqUkPWEGKtEElNnWX2q60zyTKCh+l7EP30P
         rr/3XQGqyDNoqydw59LrJeQp2GKmcPzzIrt7UrqxETTM44t6MVPpHDwTD5Y9LjoZZpiY
         bQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761830741; x=1762435541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+msX6P+5D/LE/Fn2Jk3rO8gJso33GoGorcKjWRzk7s4=;
        b=Xj+32Amb3mTvpoM2ZUDN/Q4d64w0f9esd9kA07VQ1qbZpLF2OTBfMygzt710eNYTPM
         aW9lJ3t3KJqHB2fJycq6BmTgVHx4e0mgHu9g3qOZuEkmqajMfIXAsUWtZTBuP86CUwQp
         Ze4cpgZL5/ggr4w/oE6y3wkGH6RZyqOaXvGVvLD5f7WOxUeclSlvc480JsWMUvvg1wg5
         rEOXHsPaJGDv0LdXD1+NQiH8pDPH3VhkBkQY5ps5/fMas54IUZoRRtRyIZ4y142Eo455
         8lTMD6gPWjISnWcj3ostUmZ7g/92394RH9tyrEDBm9O8/BIaXMr9FYpD45dm0fYct4vs
         suBA==
X-Gm-Message-State: AOJu0YxeNDU3X9I3g1xjc7v6ajekAoCz8MAFOwYaxwAFNSwbRA46TvlX
	MoM3Zzsur8Y7nfeli1WDqeZXDv06ocMTG6ZZbt5Zpd4q38xrFgL6At0pcm+ruAKUKLvrGoRLXs+
	XYtE7sVj6tCzKPBL15TyerML/omJUwit3BXvXAz/SSJYLQ2yYN3PzvTTxiRBSgQ==
X-Gm-Gg: ASbGncvYnj5LS4rINBmAF3t8Z1YWijaHeP28qOZtkDzW3icmSRBrEOBOKWwnUslTUJy
	ukkFmrzy6Dn2OGOsUA79jbdsLod6+f0cI8Gpl1fT1dsdSZ1RJyGity+bTbURD695479PsbC7xiz
	E/yoCToGwIXHorElSe7j/B+6nati/u/ZQ63MXdqsGTnc2p3HDVe4ON2btCu16PfNC12KTDgMQNg
	FA4J2nJvmVWH25ZReqwWOA6wDVQinYVPL9fP9X5oYlbg3Pd+v2Rb2eEP70HikWQbPWi7oN/ZycZ
	H7ULVAZjPZgzj91/KUHajXJ04v+970X9KQ9DuOEumy6JYVlbgox/B5LDND+D4Raz8154S6UZdzR
	V1KWLGkiLDe8OQBBndYGlEJGmapQZhY0ZHQh9Ty6ZMQv5zlU0CzmJpmhttpjcBMNgFLSPvg==
X-Received: by 2002:a17:903:22c3:b0:250:1c22:e78 with SMTP id d9443c01a7336-294dedf41e1mr75834875ad.1.1761830740364;
        Thu, 30 Oct 2025 06:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPJFsFt0d++fVThWv/Xc75HalJePcSX5MppiXvC93D70irk8ZiaIcLddFsfDqLv0mvJCcy2Q==
X-Received: by 2002:a17:903:22c3:b0:250:1c22:e78 with SMTP id d9443c01a7336-294dedf41e1mr75834155ad.1.1761830739354;
        Thu, 30 Oct 2025 06:25:39 -0700 (PDT)
Received: from [10.133.33.41] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm185260995ad.12.2025.10.30.06.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:25:38 -0700 (PDT)
Message-ID: <18d29353-bdb0-43f5-a12b-942a2f42d750@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 21:25:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Lukasz Luba <lukasz.luba@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, christian.loehle@arm.com,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org, james.morse@arm.com,
        Dave.Martin@arm.com, reinette.chatre@intel.com, tony.luck@intel.com,
        pavel@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <eb9abe9d-3d12-4bf1-85da-deb38b8da321@arm.com>
 <f1195632-d973-4339-a89d-e1e62b98015d@oss.qualcomm.com>
 <b4386726-9c50-47cb-b521-cd6f871d64de@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <b4386726-9c50-47cb-b521-cd6f871d64de@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5JLuWpDaxudCzMYcUh_tbyfM6WxVXBjj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwOSBTYWx0ZWRfXyJMjdmbyqi1A
 J97W4LIucz3RUiH9ILn2GGUs1iXMS1RQEFtQ5CacGwTBnkXzXGiyEcJDk8t+jUiUbg9O6zCB9+D
 8b4hpleKnb/l4hDBQeeJ5GInauziBip/PXwTBjHlCtiCniOogCvgPQHHOk3Ybzv8ifEX4hSLw3L
 b6xkwI0oUVlO96UKF5QVeuM+lMLOfkpIYZnebZ+Sz1f6+UwdEj1AXvioPCJyRQ71m44qnf4ZPO4
 Nt3dxnMSNsyFiDzIAGy2RYN1tQ5cy4GDE/DOCSceUMzTrcV657r2yLfHhDXK0IAiNYDHpz8SwOD
 BYA5PoUIs1ONxO9a/FD4cPSnMEowRMjUGxwAOg1q4TBXYRWpoxC1ywpLpULYqz2W6vIcIJ/RmYU
 8arw0vLiWNOdyYU+zgfQ6rWxC+naSA==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69036755 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2nlNoXgnAhGDjsmiPSgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 5JLuWpDaxudCzMYcUh_tbyfM6WxVXBjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300109

On 10/28/2025 9:12 PM, Lukasz Luba wrote:
> 
> 
> On 10/24/25 09:25, Zhongqiu Han wrote:
>> On 10/23/2025 9:09 PM, Lukasz Luba wrote:
>>> Hi Zhongqui,
>>>
>>> My apologies for being a bit late with my comments...
>>>
>>> On 7/21/25 13:40, Zhongqiu Han wrote:
>>>> Hi all,
>>>>
>>>> This patch series introduces support for CPU affinity-based latency
>>>> constraints in the PM QoS framework. The motivation is to allow
>>>> finer-grained power management by enabling latency QoS requests to 
>>>> target
>>>> specific CPUs, rather than applying system-wide constraints.
>>>>
>>>> The current PM QoS framework supports global and per-device CPU latency
>>>> constraints. However, in many real-world scenarios, such as IRQ 
>>>> affinity
>>>> or CPU-bound kernel threads, only a subset of CPUs are
>>>> performance-critical. Applying global constraints in such cases
>>>> unnecessarily prevents other CPUs from entering deeper C-states, 
>>>> leading
>>>> to increased power consumption.
>>>>
>>>> This series addresses that limitation by introducing a new interface 
>>>> that
>>>> allows latency constraints to be applied to a CPU mask. This is
>>>> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
>>>> embedded systems where power efficiency is critical for example:
>>>>
>>>>                          driver A       rt kthread B      module C
>>>>    CPU IDs (mask):         0-3              2-5              6-7
>>>>    target latency(us):     20               30               100
>>>>                            |                |                |
>>>>                            v                v                v
>>>>                            +---------------------------------+
>>>>                            |        PM  QoS  Framework       |
>>>>                            +---------------------------------+
>>>>                            |                |                |
>>>>                            v                v                v
>>>>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>>>>    runtime latency(us):   20             20, 30             100
>>>>
>>>> The current implementation includes only cpu_affinity_latency_qos_add()
>>>> and cpu_affinity_latency_qos_remove() interfaces. An update 
>>>> interface is
>>>> planned for future submission, along with PM QoS optimizations in 
>>>> the UFS
>>>> subsystem.
>>>>
>>>> Patch1 introduces the core support for CPU affinity latency QoS in 
>>>> the PM
>>>> QoS framework.
>>>>
>>>> Patch2 removes redundant KERN_ERR prefixes in WARN() calls in the 
>>>> global
>>>> CPU PM QoS interface. This change addresses issues in existing code 
>>>> and is
>>>> not related to the new interface introduced in this patch series.
>>>>
>>>> Patch3 adds documentation for the new interface.
>>>>
>>>> Patch4 fixes a minor documentation issue related to the return type of
>>>> cpu_latency_qos_request_active(). This change addresses issues in 
>>>> existing
>>>> doc and is not related to the new interface introduced in this patch
>>>> series.
>>>>
>>>> Patch5 updates the resctrl pseudo-locking logic to use the new CPU
>>>> affinity latency QoS helpers, improving clarity and consistency. The 
>>>> only
>>>> functional and beneficial change is that the new interface actively 
>>>> wakes
>>>> up CPUs whose latency QoS values have changed, ensuring the latency 
>>>> limit
>>>> takes effect immediately.
>>>
>>> Could you describe a bit more the big picture of this proposed design,
>>> please?
>>>
>>> Ideally with some graph of connected frameworks & drivers and how they
>>> are going to work together.
>>
>> Hi Lukasz,
>> Thank you very much for your review and discussion~
>>
>> I will describe you one big picture if needed, please allow me
>> illustrate a simple scenario using pseudo code first:
>>
>> Suppose there is a USB driver. This driver uses the kernel existing
>> cpu_latency_qos_* interfaces to boost its IRQ execution efficiency. Its
>> IRQ affinity is set to core0 and core1 according to DTS config, and the
>> affinity of its threaded IRQ (bottom half) is also set to CPU0 and CPU1.
>>
>>
>> =================================================================
>> Using the kernel existing cpu_latency_qos_* interfaces:
>> =================================================================
>> static int dwc3_sample_probe(struct platform_device *pdev)
>> {
>>    cpu_latency_qos_add_request(&foo->pm_qos_req,DEFAULT_VALUE);
>>    xxxx;
>>    ret = devm_request_threaded_irq(xxx,xxx,foo_dwc3_pwr_irq, ....)
>>    xxxx;
>> }
>>
>> static irqreturn_t foo_dwc3_pwr_irq(int irq, void *dev)
>> {
>>    xxxx;
>>    cpu_latency_qos_update_request(&foo->pm_qos_req, 0);
>>
>>    /*.... process interrupt ....*/
>>
>>    cpu_latency_qos_update_request(&foo->pm_qos_req, DEFAULT_VALUE);
>>
>>    return IRQ_HANDLED;
>>
>> }
>>
>>
>> The number of IRQ executions on each CPU:
>> ==================================================================
>> IRQ  HWIRQ   affinity CPU0    CPU1   CPU2 CPU3 CPU4 CPU5 CPU6 CPU7
>> 320  0xb0    0x3      9782468 415472  0    0    0    0    0    0
>> ==================================================================
>>
>> ==================================================================
>> Process: irq/320-dwc3, [affinity: 0x3]  cpu:1    pid:5250   ppid:2
>> ==================================================================
>>
>>
>>  From the code, we can see that the USB module using the kernel existing
>> cpu_latency_qos_* interfaces sets the CPU latency to 0, which prevents
>> all CPUs from entering idle states—even C1. During operation, the USB
>> IRQs is triggered 9,782,468 times on CPU0, and each time it runs, all
>> CPUs are blocked from entering deeper C-states. However, only CPU0, CPU1
>> are actually involved in handling the IRQ and its threaded bottom half.
>> It will cause unnecessary power consumption on other CPUs.
>> (Please note, due to the simplicity of the pseudocode, I did not show
>> how the IRQ bottom-half thread is synchronized to restrict CPU idle
>> states via PM QoS. In reality, it's clear that we can also apply a CPU
>> latency limit to the bottom-half thread.)
>>
>>
>> If we use current patch series API cpu_affinity_latency_qos_xxx, such
>> as:
>>
>> =================================================================
>> Using current patch series cpu_affinity_latency_qos_* interfaces:
>> =================================================================
>> static int dwc3_sample_probe(struct platform_device *pdev)
>> {
>>    cpu_affinity_latency_qos_add(&foo->pm_qos_req,DEFAULT_VALUE, mask);
>>    xxxx;
>>    ret = devm_request_threaded_irq(xxx,xxx,foo_dwc3_pwr_irq, ....)
>>    xxxx;
>> }
>>
>> We can only constrain the CPU latency PM QoS on CPU0 and CPU1 in order
>> to save power.
> 
> Thank you for this explanation. IMO this could be part of the
> documentation patch.
> 
Hi Lukasz,
Thanks for the nice suggestion. Yes, having documentation with examples
would definitely make it more convenient for users.


>>
>>>
>>> E.g.:
>>> 1. what are the other components in the kernel which would use this
>>> feature?
>>
>> 1.Drivers such as Audio, USB, and UFS, which currently rely on the
>> kernel's global CPU Latency PM QoS interface, but only require latency
>> constraints on a subset of CPUs, can leverage this new interface to
>> achieve improved power efficiency.
>>
>> 2.I’m considering supporting this feature in userspace.
>> Once implemented, userspace threads—such as mobile gaming threads that
>> aim to constrain CPU latency and are already bound to big cores—will be
>> able to use the API to help save power.
>>
>>> 2. is there also a user-space interface planned for it so a HAL in
>>> the middle-ware would configure these "short-wake-up-CPU"?
>>
>> Yes, I am considering to support userspace on patch V3.
>>
>>> 3. Is it possible to view/debug from the user-space which component
>>> requested this setting for some subsets of cpus?
>>
>> I'm uncertain whether we should provide the ability to inspect
>> which components are applying constraints on CPU latency. However,
>> what I do want to ensure is that—similar to the existing /dev
>> cpu_dma_latency interface in the current kernel—I can offer per-CPU
>> level latency value setting and querying.
>>
>>
> 
> OK, I think this is a good approach to not tackle all in single
> step, but in some phases. The user-space would need more thinking.
> 
Acked, I will focus on the kernel space side first.


> Regards,
> Lukasz


-- 
Thx and BRs,
Zhongqiu Han

