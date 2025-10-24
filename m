Return-Path: <linux-pm+bounces-36769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304C3C051AF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 10:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5EC1A065E5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F4305978;
	Fri, 24 Oct 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HTxv+aCQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684D305970
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295222; cv=none; b=rjgioHHJccdXxQEHvUDt9iMglgnfj588XGbsyzTAjrMoxPUG+2Gth57kvOQtBfbIP2Ixawyda5CxwP6Fh7KyFWNy0ml5yGhN0EqxHdcn/ZECpQxMp1B1p02RW7jBEhj2qowbaw7QGdDL2RNoZGF7iJDpRXgftYsZmgt3wt5qmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295222; c=relaxed/simple;
	bh=0/HpiekOuEFr+v52Q3cJ2AGl82ZF3h/HF23ETfIgSA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5EH4HRy0cQHowvjXSmTyV+EBNr/NBJeysaF1FnkMtal4lvbpRDs4UQEUjayu0cHuEBsCHNsEGxLvjV2NQWTRq6oTGV9ZEaTAHjVREC/rFet1PLIcZHVPR34KH0dqwuXvIxOjpV6MOafRifKSmm87pzwRXS7UrrVUhxBQ+wrR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HTxv+aCQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3MBTw010242
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 08:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0YNZn1RokASQE3KKlYOedjoJZiFwTtAXJpMFIu09VVg=; b=HTxv+aCQv5oDG+x/
	rnxvxt2M7hj+cY7ldAl3EO0aMgMscSfySpJEgL9oE9M+tImGRTRrkdFCM2CJnakn
	CQO2QLMcjzF65POzlo0EZYiXT1o2gRaLfydbo0gLUNfvBy1j3jI/vljf/TDC19TS
	pebIv15e6TrTcvekhBeaJFiRfS7Zhd2f+HKCm6y3+FyDOf0iE6fE7or0Duozcbge
	LF7+kNtQAouaM7KGzsVCk66Z0tN/z6xmEKSRxEZfCKSI7xrbt41rnkzhwxvm/sM9
	iYjRIAgR+SXlKQIVNvZsooyWZpol/J1QwfY52HTDYZp+veUqCVPnlrCQyijnaapo
	1bBX+w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524dknq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 08:40:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6d0121b1c5so968019a12.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 01:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295220; x=1761900020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YNZn1RokASQE3KKlYOedjoJZiFwTtAXJpMFIu09VVg=;
        b=b8mS00ZQFFTO/KdNROU8l2nwFwZ2yFY8iS9wioNcnlGANxCgaV7zygsRPCWcF1Ab8F
         ZjLkGoxQkNqm/pYv5cSttYVpStMjvADhaRj2s1HGQSh/db/Bqm5qMr0L85bAGdirCXv+
         EEyNqei+iYBJcVZaoipoHFJ5SHsxmfhKq3lvyKacWdEF1XAhb/e/e5ksG3JbalIZ7nrL
         r3A/xAxF7OviD6S4/FRy86mDPmHjdHw5x6PemM3BOUZzmy9YUzo2yGDBOrCch31z7/t9
         Ia6UCjJ/CRe950nuh16eQ4zxX70HSjTyfb9SIwY8BjL28tx/1I3ZSAc7xM2wNPsYJBdB
         qtTA==
X-Forwarded-Encrypted: i=1; AJvYcCVyUrQMR1un/dFS8HJdMzf60tLz/qa6CRe75ZOr5wocU8V/FecqudbvVS2/1mLHIKnPgI25o4hqVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziHKuH92SP7rUsvg6RL5cIY/CGMQjyRoGhRS9KpuSuTHR7XlTS
	/VofnuUE64iQ5wJA65upcq5U9keNSHYCi4ANbmBACmwScn8Qvlo2dLymGHbTplbI5p2qtwfuQXq
	LqLpU+uvMJFMldGF2nR92E1bE2uWkvZ2dBVOM5pyvSR9OkQps6Om+uPGa1sXBxA==
X-Gm-Gg: ASbGncskDIfx2fYXkrj5sf57prl16h9oDop7Jjf2z4C+I/P83CZnKgiqXD66rqdWoKZ
	zF/vUBKlvWT61+umLu4nWuaRucBWT8+J3Se3kWB+KY8dF4JkvR2005TUDnF/dWxYfvU4y3fIEic
	WabbL2LUqk0HRYAMrJujL24QXsOvLfE80WjOkUw8VyeqlxSBNDQVnrhuEXkKQ9zrFEwByoy3AQ5
	O3wC0QB9LdDd6PNSjt36q+zNrxGPsvAnzRAYot+ZUZ2FWK5rstOl4rD0kJqyF0X2W4c9S+JAMiy
	kRt6ALA5yShveknb7J0FPY2xAX19GE8Liab9hVkC6mZv3I/IAGqbryZ61Q4X3I+XLqMy1pzPP4G
	Y4St/BWrtMnjbSDFdu2dkC/l4beC2KyewTFFrzaNTwY7nJscOqB2L6C3mFD9UDXLnhmgNLx4=
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr349464315ad.3.1761295219551;
        Fri, 24 Oct 2025 01:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTLNLn36/S60d7SJ13jy0mBlisBmviibNNbAEb8dy9ARhITndfXKQBcdUXHY27mLHKLz3ivg==
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr349464025ad.3.1761295219031;
        Fri, 24 Oct 2025 01:40:19 -0700 (PDT)
Received: from [10.133.33.181] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e25ba2esm47313615ad.104.2025.10.24.01.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:40:18 -0700 (PDT)
Message-ID: <7acba50b-8c1e-4509-8100-3a65467d2d87@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 16:40:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
        amit.kucheria@linaro.org, christian.loehle@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, zhongqiu.han@oss.qualcomm.com
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <CAPDyKFprP1d-9Ojwz7QaVBbdFumPmRoVnifrP8v+eL6FHR3Unw@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAPDyKFprP1d-9Ojwz7QaVBbdFumPmRoVnifrP8v+eL6FHR3Unw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX0WmVig8Q4XqP
 YNSiqAFdKjyIWPEeI+E7SKNX9GdEAUPUQPAxott2qBp7xe/ulcA5iRTeQ+RPmbdaxwUaXdZbNeg
 Q+zm0OKfCeG2eZCEM3wbrgzazE00cScB+02nmS9M8BPYTH13z1JsSn3pWVQqInZbHFe6mWpadbF
 ZucP42/A7TbMOGJHlLstkPHwH1GsJxPwYdgYkPiXhmV+4hsrF/adZ4SUDx8RDbQxlZI7/B97zvE
 S+7LdinGpkD78Nw8/sxavNhmWnxKcBSP+Zt8i9rNwie7pafZn7d7qiy+DXWaLaV3OlvdB4zeoZQ
 H/oQvWK2n6psUjfyRwGtF7JfGpWg/lVam6e747lxJQq3Z/ks4N1i8hhCQqV8uboNBv9ELmPt1o0
 a3JUeFb3WVBtPAsaKU+INHdwtjefNA==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fb3b74 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=Ni59kdHh3PmOLRpg5VwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mv7swp-SIKr2NFbGJJo5M_4B-JaRWJ_1
X-Proofpoint-ORIG-GUID: mv7swp-SIKr2NFbGJJo5M_4B-JaRWJ_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On 10/23/2025 7:03 PM, Ulf Hansson wrote:
> On Mon, 21 Jul 2025 at 14:41, Zhongqiu Han <quic_zhonhan@quicinc.com> wrote:
>>
>> Hi all,
>>
>> This patch series introduces support for CPU affinity-based latency
>> constraints in the PM QoS framework. The motivation is to allow
>> finer-grained power management by enabling latency QoS requests to target
>> specific CPUs, rather than applying system-wide constraints.
>>
>> The current PM QoS framework supports global and per-device CPU latency
>> constraints. However, in many real-world scenarios, such as IRQ affinity
>> or CPU-bound kernel threads, only a subset of CPUs are
>> performance-critical. Applying global constraints in such cases
>> unnecessarily prevents other CPUs from entering deeper C-states, leading
>> to increased power consumption.
>>
>> This series addresses that limitation by introducing a new interface that
>> allows latency constraints to be applied to a CPU mask. This is
>> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
>> embedded systems where power efficiency is critical for example:
>>
>>                          driver A       rt kthread B      module C
>>    CPU IDs (mask):         0-3              2-5              6-7
>>    target latency(us):     20               30               100
>>                            |                |                |
>>                            v                v                v
>>                            +---------------------------------+
>>                            |        PM  QoS  Framework       |
>>                            +---------------------------------+
>>                            |                |                |
>>                            v                v                v
>>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>>    runtime latency(us):   20             20, 30             100
>>
>> The current implementation includes only cpu_affinity_latency_qos_add()
>> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
>> planned for future submission, along with PM QoS optimizations in the UFS
>> subsystem.
> 
> My apologies for the very late reply.
> 

Hi Uffe,
I truly appreciate your review and discussion~


> To fully understand how this new QoS interface is going to be used, I
> really think we need to include a user of it, as part of the $subject
> series.

Yes, Patch 5/5 using the cpu_affinity_latency_qos_* helper functions to
replace the logic in pseudo-locking that uses dev_pm_qos_request to
restrict CPU latency for known CPUs (via a mask). Actually, I'm also
looking for more users — for example, we plan to use these interfaces
in our UFS module in the future to implement optimizations. And I also
plan to support it in userspace on patch V3.

> 
> Besides the comments from Rafael and Christian, I also wonder how the
> user of the interface should know what CPU-mask it should use? For
> example, how does it know the CPU-mask for the big-cores and for the
> little-cores? In particular as I assume the user isn't a platform
> specific driver, but rather a generic driver that should work across
> various platforms.

This patch introduces cpu_affinity_latency_qos_* helper functions as an
extension to the kernel existing cpu_latency_qos_* interfaces. These new
helpers enable users to apply latency constraints to specific CPUs via a
mask, allowing for more precise power management when the target CPUs
are known in advance.
If the user is a generic driver, there are two options:

1.One is to use the existing cpu_latency_qos_* interfaces to directly
restrict all CPUs from entering idle, since the driver may not know
which specific CPUs need to be constrained.


2.However, for generic drivers with specific workload characteristics
such as the ufshcd driver in this patch:

https://lore.kernel.org/all/20231213124353.16407-1
-quic_mnaresh@quicinc.com/
— if a user knows exactly which CPUs should be restricted, they can
provide a custom mask via a hook function and use the extended API
accordingly. The default return value of the hook is the system-wide
possible CPUs, so it won't affect other users.

In summary, this patch is mainly intended for users who know which CPUs
they want to restrict. For users who don't, the extended API can still
be used by passing a system-wide CPU mask, or they can simply use the
existing cpu_latency_qos_* interfaces.

Please kindly let me know if you have any more question.

> 
> [...]
> 
> Kind regards
> Uffe
> 


-- 
Thx and BRs,
Zhongqiu Han

