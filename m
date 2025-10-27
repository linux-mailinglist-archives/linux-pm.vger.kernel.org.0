Return-Path: <linux-pm+bounces-36911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03930C0D9AE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B6DC34DE8E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B75730F93C;
	Mon, 27 Oct 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FruOG2al"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A6303A09
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568722; cv=none; b=ML24pNg8QMFF70/uo6/tTxhmDELsFsvLii7pU2z7uzwafe2hZrO8jC/KkvMZen0vdxp0ZSd7W0xz40kgMXgBITqe2sYapB2DeqWKjKPJh1RLWSjIqqXMmkRrsyMtnI6+cRYNriaZDJgb4SBCQZ7nNnA2umwYc6BH28iUuAp206I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568722; c=relaxed/simple;
	bh=K9MThje/vm7kyGUxpZSfGbgu+RMSGEzgFkQaowpjs5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF4xBl2rN2lTNHNjwYdmFRmdE0iDmtDLTCDPSAgoTJga6eU4xXHAaX65Pz/9RXW48Pz8tn6SjGCP3oG0+PlLJplECHPFbB5HTJaGZz2s5TsuVEK32Wbx8MTAmBuc2PcXgapFWbTjYGLbh6OUhskloUvY0Sr0TGOrjcajIIe2f+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FruOG2al; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8IlQN1130364
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 12:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HM+QV7hPsWe4JbQ7/slMutv3h5j0OmFuFixBv/5OW7c=; b=FruOG2alL63ed/yA
	IpthnH3fl5GFRE8Tp+dPczSezeBEdGXaL88AfTkFwKALAFufmqgZqYL25sBQlawS
	cGtOJMY6/jPGJ355JTNLuJKZn4IL+gX5fjhyk571qSZtISNjbyq8Iay7gtUI9G6O
	kk0WsGd6McOMtirTuBT1YMoOElT1bO3hbarLHdmA0mqlJCGGOGuDMbbxOF4ON5DZ
	F/Ygjjux98Uloy96YP78V/mJHOEaq3g3GlN2tM/wpkh5J/J07rFbWTblqCU2eczu
	HdpTcfCkuc5OHFEux+HDJui5z7llyYFYKOqbUI9ZtLRnAPAqT7xNxoeZPVFR3X3v
	9bA+AA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nkamk4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 12:38:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78117b8e49fso10040122b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 05:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568718; x=1762173518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HM+QV7hPsWe4JbQ7/slMutv3h5j0OmFuFixBv/5OW7c=;
        b=ry7EYQaP0KAh+HyVcLE24poHDP9BuP/7JTKawiHc9Z5jD1Vgm1hjg2q5kUo0M4FHD/
         EdUkFZq1BrVP3jXNxpMxnB7KXLBcrXCyp8UVR1u9+AUR0wLEXIkfVb8wgJ5F0wsNx4o6
         YD/wQR0PTSFJU6c6y59BzNopd9xg8bUf4LTYpay26dzfKEMLMDZcHC2nGCnwxxQl3Mpm
         qyQMwgqtRqgyfVOj1G2FVBDBAyoalquGA6cGkgjb3sRiveGHZVtgzTXVnAW+bkEXMYhM
         5nQ203LEed3qWrWf4Y7VrZJDoDMASIJEyNqmWqxWiQjGzasj54tXko1tm2XECzD02vqK
         FaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOn4URuJvqDfUbH6l5kXhn9pvw87jQY6TgzkfbjyqpD9YQH30wCCCvKp/fpQyY1m5S6lgj19/Rtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNSBmSwd8SAskgbXQp3MrzC83DS/001toHcfKC7KNUMX1u1AQ
	SDN85NWgJDkqcRiL3kTlQahYg2/jEC8rRXrqzZGTN1v65CibkYHyP/Md7tPuH6ORslglQ4wKvDu
	w4FUp+wIGNlzU/bdfb9EAfLJEk3IVWnd9JE5ZcnV0UgetRdWEk7KL8KJ4ED5quw==
X-Gm-Gg: ASbGncsj/2/JubnBg+hZVh4DKPA9YOtbKQWgXGvbWvPtsT0yGWMmr09il8A3Dg5zESa
	s0Re5kNhD9ytHrF2gUIii0L6ID84xuvLSH72r1JGzrjX3OnHNsRkvPlTx+9qAwBA6pcIsmBO6IG
	TjO71j9KzzUUWjogyOViV2NmGSSBWipnBustdRFeSPn+lZg9Bt/nnmEC+SKs62x4xQ4kf35nSug
	IX+D56tolsqOVj+b1pvWsbNJoz60SXaPf397fmm+b+xZzPoKLfsTziRlwNxsyUN6iimYfUXZrSv
	6qSs1HmzHfN5DPjsUgvJFRicWOxzraAe/GQZ9nzXSAj78YXTn3Q7CV6RmeotA2GlEk8EuOOQM+W
	6wiug3dwwnigHLCP+ZnDKogjz4vgTQW/1pKEymf+TiZRXOD4+dBvND0w6ySY=
X-Received: by 2002:a05:6a00:13a0:b0:781:189:ae43 with SMTP id d2e1a72fcca58-7a220b06cd9mr35721421b3a.20.1761568718182;
        Mon, 27 Oct 2025 05:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPSGwlBz+HN+tj7YlXXDid70Q5ThXSM/+InuvM9haESMOarKb3WO/5QpH1uFNnSINTjzomOA==
X-Received: by 2002:a05:6a00:13a0:b0:781:189:ae43 with SMTP id d2e1a72fcca58-7a220b06cd9mr35721382b3a.20.1761568717536;
        Mon, 27 Oct 2025 05:38:37 -0700 (PDT)
Received: from [10.133.33.217] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012899sm8170181b3a.0.2025.10.27.05.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:38:37 -0700 (PDT)
Message-ID: <4108296c-399c-453d-b339-7e70a423d14c@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 20:38:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
        lenb@kernel.org, pavel@kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
        amit.kucheria@linaro.org, christian.loehle@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, zhongqiu.han@oss.qualcomm.com
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <CAPDyKFprP1d-9Ojwz7QaVBbdFumPmRoVnifrP8v+eL6FHR3Unw@mail.gmail.com>
 <7acba50b-8c1e-4509-8100-3a65467d2d87@oss.qualcomm.com>
 <CAPDyKFqVKWCApVFjYpgXa2x3N9F7O1bGBBPz0JfNrWBYtg=M0A@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAPDyKFqVKWCApVFjYpgXa2x3N9F7O1bGBBPz0JfNrWBYtg=M0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=68ff67cf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=l6s8cBgvcr9gq9MuNTsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: o3X9-aXYorw1fIs0RZx2mFpKUYp1Mn1F
X-Proofpoint-GUID: o3X9-aXYorw1fIs0RZx2mFpKUYp1Mn1F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNyBTYWx0ZWRfX2NNbFsVOkXFn
 84nYUts3rrPo2E7XbTC8ehYo09ZXpw34Pek3V3LL/0XNp8icRoaVMcKwNXRQIyI0njWALMTUPvQ
 A3Y7O+y/2TvXdu5EiJb7ETj20ftb9xl90POHy1r6jqNEe9Kmzb6hbUaIUo197M/SWvxRGGQGS1S
 xc40hJP37uwQDIt5wonbsThIL/iuT9HVYNNsiL1R+mZQ1a6LZfQiNXwnofGwwXT3Nq1Q3VqYMKW
 21aE2V0KrxkfR5Hqbju8f1i0YZBHKqYaY7AIA/uVC8rFrq8s9imlVhFwjem17LrIuQofYPMLqs8
 9t78uyY06sHza/pgB1rAYnU4Dqt5q+LQgDoLGE7hVUnCZQLF7gC31h8WWbOm+7UK/4DQV6pUhtQ
 Bj4pBpHsnDFda6abprWRIV5fPzVfGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270117

On 10/24/2025 6:44 PM, Ulf Hansson wrote:
> On Fri, 24 Oct 2025 at 10:40, Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>>
>> On 10/23/2025 7:03 PM, Ulf Hansson wrote:
>>> On Mon, 21 Jul 2025 at 14:41, Zhongqiu Han <quic_zhonhan@quicinc.com> wrote:
>>>>
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
>>>>                           driver A       rt kthread B      module C
>>>>     CPU IDs (mask):         0-3              2-5              6-7
>>>>     target latency(us):     20               30               100
>>>>                             |                |                |
>>>>                             v                v                v
>>>>                             +---------------------------------+
>>>>                             |        PM  QoS  Framework       |
>>>>                             +---------------------------------+
>>>>                             |                |                |
>>>>                             v                v                v
>>>>     CPU IDs (mask):        0-3            2-3,4-5            6-7
>>>>     runtime latency(us):   20             20, 30             100
>>>>
>>>> The current implementation includes only cpu_affinity_latency_qos_add()
>>>> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
>>>> planned for future submission, along with PM QoS optimizations in the UFS
>>>> subsystem.
>>>
>>> My apologies for the very late reply.
>>>
>>
>> Hi Uffe,
>> I truly appreciate your review and discussion~
>>
>>
>>> To fully understand how this new QoS interface is going to be used, I
>>> really think we need to include a user of it, as part of the $subject
>>> series.
>>
>> Yes, Patch 5/5 using the cpu_affinity_latency_qos_* helper functions to
>> replace the logic in pseudo-locking that uses dev_pm_qos_request to
>> restrict CPU latency for known CPUs (via a mask). Actually, I'm also
>> looking for more users — for example, we plan to use these interfaces
>> in our UFS module in the future to implement optimizations. And I also
>> plan to support it in userspace on patch V3.
> 
> Right, in regards to the resctrl/pseudo-locking user of this new QoS
> interface, this whole series looks more like a refactoring to me.
> 
> My point is, for this reason alone, I don't think it makes sense to
> introduce this new QoS interface. We need another user too, like UFS,
> to understand how this would work in real practice and to allow it to
> be merged.
> 

Thanks Uffe, I will continue to collaborate with our UFS team, or find
other users as examples.

>>
>>>
>>> Besides the comments from Rafael and Christian, I also wonder how the
>>> user of the interface should know what CPU-mask it should use? For
>>> example, how does it know the CPU-mask for the big-cores and for the
>>> little-cores? In particular as I assume the user isn't a platform
>>> specific driver, but rather a generic driver that should work across
>>> various platforms.
>>
>> This patch introduces cpu_affinity_latency_qos_* helper functions as an
>> extension to the kernel existing cpu_latency_qos_* interfaces. These new
>> helpers enable users to apply latency constraints to specific CPUs via a
>> mask, allowing for more precise power management when the target CPUs
>> are known in advance.
>> If the user is a generic driver, there are two options:
>>
>> 1.One is to use the existing cpu_latency_qos_* interfaces to directly
>> restrict all CPUs from entering idle, since the driver may not know
>> which specific CPUs need to be constrained.
> 
> Right, which is how UFS does it currently.

Yes, exactly.

> 
>>
>>
>> 2.However, for generic drivers with specific workload characteristics
>> such as the ufshcd driver in this patch:
>>
>> https://lore.kernel.org/all/20231213124353.16407-1
>> -quic_mnaresh@quicinc.com/
>> — if a user knows exactly which CPUs should be restricted, they can
>> provide a custom mask via a hook function and use the extended API
>> accordingly. The default return value of the hook is the system-wide
>> possible CPUs, so it won't affect other users.
> 
> Sorry, but I couldn't find in the above series how exactly UFS knows
> about which CPUs it should constrain.
> 
> Again, please provide a user (UFS for example) of the new QoS
> interface as a part of the series.
> 

Sure, will do that.

>>
>> In summary, this patch is mainly intended for users who know which CPUs
>> they want to restrict. For users who don't, the extended API can still
>> be used by passing a system-wide CPU mask, or they can simply use the
>> existing cpu_latency_qos_* interfaces.
> 
> I understand, thanks for clarifying.

Thanks for the review and discussion~

> 
> This all said, I have to admit that it kind of starts to worry me when
> I see the number of different users of cpu_latency_qos interface
> increasing in the kernel. To me, it feels like these are just papering
> of another real problem that ideally should be solved in a more
> central place, for everyone. But hey, that's another separate problem
> that we can discuss at some other point.

Yes, We should strive to avoid unnecessary overhead. I will also look
into modules where it's clear which CPUs' PM QoS constraints are being
applied, as those might be optimized. I will also do an investigation.



> 
> Kind regards
> Uffe


-- 
Thx and BRs,
Zhongqiu Han

