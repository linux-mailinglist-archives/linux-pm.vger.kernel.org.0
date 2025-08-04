Return-Path: <linux-pm+bounces-31909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5DB1A3CF
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333C717D6C7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02503266B6F;
	Mon,  4 Aug 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HdTi3wpk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EEA1F4165;
	Mon,  4 Aug 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315282; cv=none; b=Fs4XqgA7DFahCReCkGK3G3X01kduFPUV9Ub5tUT9IXWNPb4NNSJXl192h8L8Z831D3FkEWlnKJRPyR2c6JD5iqeLjIRE4dppMNcKTTBsDBvH3/U+YkYjolk2laPKztbzklMhc/PYKtdkeEnpMrxrpMFcCB6/akhFI6JQFGfR8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315282; c=relaxed/simple;
	bh=bHp8uiRtuJmj15+pCToMeOeVeGgFzv/73NITBUlC2Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NpXBKckZDtY1TQlips2U5Rykpi3Jaialp85fJGoAIbktnSMTSUXdzTOag+XZR9mFvR1lu+wdraGru1Pj/AqkppsuRb1oKEemyvOF9VqgnxboTwgK4S8GAYmdgPbw1SHLLAw9Tn1VGqHLcP17gHndxHCgGbuLPjll5gjDgbXCjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HdTi3wpk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574Ch36A021753;
	Mon, 4 Aug 2025 13:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zK4uXfRRdG9hJ4nHTy30uSUldKYihGc8e+gTXfm/5o0=; b=HdTi3wpkHHhEZaRZ
	no2G9muXyN0LUvEcVUxvg2aw0Xad/YeOpVpN6ca/AX0XXiqX3E5vPknPur1CmOuO
	WcDkyG/ECPnjtckZ9yEtAEA6qKXv3+Krt8/51HVfZOOvTtnlyAJ/bt/LNipK8vt0
	1AMmQaqdaV1VvxOGBmzTpuYbLa1HjiRdclGXHWXAKqDQJEAuk7qZVePt2gjx0BXQ
	TGCBARjVHhiawa4WWIYDmmyww45ZU4EJI37XysrlDdqJkMxD4qe9y/tKHiB/X4eI
	RqTSN+tSVJc9MauZXRlQMC17ne1lg7a30CU5+Npq2tSJfbHWN6RlAdcSjzD1YxSm
	neUSRw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ak5a1yua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 13:47:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 574Dlpix004212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 13:47:51 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 4 Aug
 2025 06:47:48 -0700
Message-ID: <65340b7a-b706-45ce-b0d8-29b2081f7240@quicinc.com>
Date: Mon, 4 Aug 2025 21:47:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <pavel@kernel.org>, <tony.luck@intel.com>,
        <reinette.chatre@intel.com>, <Dave.Martin@arm.com>,
        <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhongqiu Han
	<quic_zhonhan@quicinc.com>
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <2379088e-e5d0-4766-9968-756aad04f9a3@arm.com>
 <819fb853-59f7-4296-8499-715c142487f5@quicinc.com>
 <f682e782-ffea-48b2-997d-ddbaf7ea8a8f@arm.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <f682e782-ffea-48b2-997d-ddbaf7ea8a8f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3NiBTYWx0ZWRfX4V5/AVz5azO2
 ngCSkTbVqWxS3F/xa7gxE6r2OwvJjFF2IwLfc3KYXxZ5Pjin8YftJaESXsNRHNRrK/ULr0GIZXy
 QkdaZher7WVtAABs3jnIhw7PqQDBtbF1cVA1Tdy+hOsIszzi9psWEowhQmyOfDSVM4HSu6lyB5i
 HEVBxGjJdsCJUH9wDIK7r47xJO0CVjduWwsvzx/7elBiPtCJ6hpFIXY5N8g2uAEZ7MyPCMRqVR2
 6DduFGxydycGx+2idOzTzH1aNkByfudBSXJZJjSDJsjkZD0ZgRPX7IOQB3+demWXqpkw5qsQUHv
 +gwdfbhHRVIuR7eJ0iwrsMuDtzLeOyn0csQXQtaveb8OAJgW2MpS4Ipzqubd+E3lElhh8bbfeSZ
 l2OPRzVR33svplwHf2O+PHusJ7otswfBjE7z6JB9Ay8HpcU4TY9tRcTc0ZGcbHnbu+fm8wXc
X-Proofpoint-GUID: bGYRVe1--RudNPS5bVEDHV9NXQY892Nx
X-Authority-Analysis: v=2.4 cv=LP1mQIW9 c=1 sm=1 tr=0 ts=6890ba08 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=wkvXqLCyMWt67K7M5qQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bGYRVe1--RudNPS5bVEDHV9NXQY892Nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040076

On 8/2/2025 10:38 PM, Christian Loehle wrote:
> On 7/28/25 11:40, Zhongqiu Han wrote:
>> On 7/28/2025 6:09 PM, Christian Loehle wrote:
>>> On 7/21/25 13:40, Zhongqiu Han wrote:
>>>> Hi all,
>>>>
>>>> This patch series introduces support for CPU affinity-based latency
>>>> constraints in the PM QoS framework. The motivation is to allow
>>>> finer-grained power management by enabling latency QoS requests to target
>>>> specific CPUs, rather than applying system-wide constraints.
>>>>
>>>> The current PM QoS framework supports global and per-device CPU latency
>>>> constraints. However, in many real-world scenarios, such as IRQ affinity
>>>> or CPU-bound kernel threads, only a subset of CPUs are
>>>> performance-critical. Applying global constraints in such cases
>>>> unnecessarily prevents other CPUs from entering deeper C-states, leading
>>>> to increased power consumption.
>>>>
>>>> This series addresses that limitation by introducing a new interface that
>>>> allows latency constraints to be applied to a CPU mask. This is
>>>> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
>>>> embedded systems where power efficiency is critical for example:
>>>>
>>>>                           driver A       rt kthread B      module C
>>>>     CPU IDs (mask):         0-3              2-5              6-7
>>>>     target latency(us):     20               30               100
>>>>                             |                |                |
>>>>                             v                v                v
>>>>                             +---------------------------------+
>>>>                             |        PM  QoS  Framework       |
>>>>                             +---------------------------------+
>>>>                             |                |                |
>>>>                             v                v                v
>>>>     CPU IDs (mask):        0-3            2-3,4-5            6-7
>>>>     runtime latency(us):   20             20, 30             100
>>>>
>>>> The current implementation includes only cpu_affinity_latency_qos_add()
>>>> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
>>>> planned for future submission, along with PM QoS optimizations in the UFS
>>>> subsystem.
>>>
>>> So what's needed for the UFS use-case additionally?
>>> Would adding that here be too much?
>>>
>>
>> Hi Christian,
>> Thanks for your review and discussion~
>>
>> Currently my plan is only to move forward with the current patch series,
>> which includes only the below interfaces:
>>
>> cpu_affinity_latency_qos_add()
>> cpu_affinity_latency_qos_remove()
>> cpu_affinity_latency_qos_active()
>>
>>
>> For most use-cases, seems these three interfaces already sufficient.
> 
> Probably, but IMO there's no real user of the new extended interface yet,
> making review harder and lacking justification.
> 
> FWIW in 2014 Lina also pushed for something like $SUBJECT
> https://lore.kernel.org/all/1407945689-18494-5-git-send-email-lina.iyer@linaro.org/
> Lina made an interface to tie the PM QoS to the relevant irq, which I think
> was a great idea. Maybe that series is interesting for you, too?
> 

Hi Christian,
Thanks for the review~

Just to clarify: in patch 5/5 of the current series, I’ve included a
user of the new extended interface — specifically,
cpu_affinity_latency_qos_active() is used internally within the add
remove interfaces.


I’ve roughly reviewed this patchset you mentioned. Please correct me if
my understanding is inaccurate.

https://lore.kernel.org/all/1407945689-18494-5-git-send-email-lina.iyer@linaro.org/

It seems that this patch series introduces an alternative implementation
and attempts to add a new type of PM QoS request — one that targets IRQs
instead of CPUs. Specifically, when the IRQ affinity changes, the
corresponding CPU latency constraint is updated to reflect the new CPUs
that the IRQ is now affine to.


And It appears that Kevin also recommended implementing this feature
using the per-device API:


https://lore.kernel.org/all/7h4mx9wdxe.fsf@paris.lan/

---->>> From Kevin:
I agree this is a needed feature.  I didn't study it in detail yet, but
after a quick glance, it looks like a good approach.
---->>>

https://lore.kernel.org/all/7hd2blerqz.fsf@paris.lan/

---->>> From Kevin:
I'm curious if you looked at using the per-device QoS API for this
instead of expending the system-wide API.  IOW, from a per-device QoS
POV, a CPU is no different than any other device, and since we already
have the per-device QoS API, I wondered if that might be a better choice
to implment this per-CPU feature.
---->>>


May I know are you suggesting that I should evaluate whether IRQ
affinity scenarios could also be valid use cases for the
cpu affinity latency pm qos interface?
However, there's a more fundamental assumption behind this — that a
particular IRQ actually requires a CPU latency PM QoS constraint, right?



>>
>>
>> The reason I mentioned UFS is to explain why the update
>> interface cpu_affinity_latency_qos_update()
>>
>> is not included at this stage. The UFS use-case is planned to
>> use the cpu_affinity_latency_qos_update() interface in the future, which
>> is similar to the global CPU PM QoS interface
>> cpu_latency_qos_update_request().
> 



-- 
Thx and BRs,
Zhongqiu Han

