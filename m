Return-Path: <linux-pm+bounces-39139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9DC9D911
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 03:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CB72348ECD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4420E00B;
	Wed,  3 Dec 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G/RXfCew";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IOlKM79F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213A1A9F82
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764728456; cv=none; b=lOKrjz0PI5JCQ2dT994FfVySsDp7wnlZwNvgm+fV/1TXtLiV+xxTLUUjxdNaIKfq9fT7gqJrxPAD7jXG1KLfz50fFiQ51RMJN0gIg1UMQ3/K6ABqnH+JwFakQivhrLWdf1LuaVucvF/8n8d4TStvObAPr5vYc8RaszOi4zWDFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764728456; c=relaxed/simple;
	bh=Yq4E4oHs86aEtNdAgCEdLITL6+HOrW27JPr7Z6YrTBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz9a8uIzvfqGSLDPfHBll5Ui5MUMvj8uuurzAv/oLxcNH2yj1Agpq5B6SEKWJ9RguOioa0Dd5khoqAP3/+xtmSPamIXt9Sb++NdBs8FeUSkPDBDcnM0eptMQFco5+le3VgHDzFmTGANS+NL/rtaO3lYBoEAoFZxeW3P8syhubbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G/RXfCew; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IOlKM79F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2N4cFL404815
	for <linux-pm@vger.kernel.org>; Wed, 3 Dec 2025 02:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDByvDOazZtMwBsVROQkN35F4yNKa1o3XDTu60lntnE=; b=G/RXfCew71h8wajt
	1ulzP/LWPjXjFbgAK7aAN7gwfbQwOebosMLoJWcKg7IdyoRqRvdqyIBFbPUw9Gqp
	bUhWvzd1kqYJdgIZTHFGcMy8FcHvNuh9n6kJNST30QGOP6w8Gxo696Tc6AGfFrQp
	hqhHABuJTSGnN0kjMb9kK8Jv+7MbnVJQsFIGU8hTwTsrm40CJXKfCpMeBeyCMEaN
	55jPrj6Sq54T6rdX8FChivEdkpHSHugtSjRtyjoOGGnGxlbjhJo5Omb2rHMxNn7B
	PMyKoomZ25nSjj/hW4xqpqGw83TfZUaPIVyJz3BfgmmNPwHmj0EgWLnnyRmCWsn4
	JbP/Kw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4at9fc8dka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 02:20:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso6209876a91.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 18:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764728453; x=1765333253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDByvDOazZtMwBsVROQkN35F4yNKa1o3XDTu60lntnE=;
        b=IOlKM79FkjUQiKvrjH01YN84oxwL8I+HW0ccy/z3k8uaYYGYSmQpavNpljqzXWBV6m
         Ed2bBKgSEtfVu9cfipbWVSKXNNGH3ucUxOYftR1RWhCjOHkVcRImeAplYqF3oAg1zKwb
         OxPuUbmOur1YhJtPTckNk7jKj8SBe5UaoJ0bZQB89Pi2+6ftgwxhOHkuFkX9p03lqxE7
         +/462iH0xAPr8EpcX+/ch9Fb9RNJ2h86WL+V1c+ztTpnnVKAFvLVb7TadSxjvwtjldNq
         JOW615D7HBbGn9JDlzC+bXQDkDHqwT+TVXwZ2rrK8+GcnIPz4XIQA75X3eeG5W6SKbm6
         k5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764728453; x=1765333253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDByvDOazZtMwBsVROQkN35F4yNKa1o3XDTu60lntnE=;
        b=d+QtH0Z5qJN1J5m1FK9ylv4Cla4ggha8BqM+B/sidhqygpC+qJj/dpBPML39yoM7+K
         40RLgyg8nDut7POdrELNwOGC+fGdq4baNirWQk7WyqT/Sj1WFrrM42HbtyUf8T6He5gZ
         7eUZ65trAMgdsVumRs8LwtKEwxM86WOZCS1RY+nufQIfcEN1hz1g5zVVYmDYBEIHp76J
         CctnuX9zQbuOVhKL30JTtgSt9e2jTOeqZl1LqQRIbYOnWZDHsGEdG8G+v9aUoKvb+rkO
         6koFXeC5mqPhgiWX17y/DYDIKuHv/iZyRpyNZpIKq3YaPHYn03jhkMEad4nAJ2GrMr0O
         G1MQ==
X-Gm-Message-State: AOJu0Ywh4Y9JKS92tOxOhJ/3C8vgx1bMhpMCtnlgAWvJSLpVrK0qDtVZ
	UPTtnkQ+2Pqdtt3IdGUwYbbfb9A92Kz2CG+SmxY7ZO4UuuEnIjCtDNdibcVQDX5bMiY3kUDorjM
	C+kgLCkFMROMGQgvF1vV8k4Bs6vuy6Dr0ZcN4uTJmj5NVxnR7fpHJogadv3BNIJons7lUqJHh
X-Gm-Gg: ASbGncvCyOer1qSUn0OTCkywYWjYAs3laJajXeLMKAAsrh3ChC027z0JM8zunFqlulp
	0yUvpQInT4m6Ih5G1In2D1Tv/1ZMz5+DMNpNMNJRvWOe2dmANwOlVvNvDpd4X1+LTNMglLtwWPq
	KQ1+h+yKHxj5GFFid2L/gG//PaGsIMSRbAkwd9EQSj2w8LLh/9L8Uycpb1vNiVDCNht2355NtKr
	VF6NKLTNBKrtnaxGIxdg66S7a2Zm44ysF5rHRkTGoiIhHoAm2q2Ib+MKrhnhpk2vipCVHlSdMND
	K/+c/YPnq5vE8TAfArVTF9qjDSpAVRXzXK78eLWHdSdl+yO08gVBzGbrf5+DNYzxbvK8o5IY+3l
	/L2CbstRVSyN/Qrp8BOly0g+voeUZyLnX+f5ncRFZxxxu/xgsV4wZO6rouOuUmUhQb6e2zAm17g
	==
X-Received: by 2002:a05:6a20:a124:b0:35e:d336:2818 with SMTP id adf61e73a8af0-363f5d4cf1amr1114132637.17.1764728452690;
        Tue, 02 Dec 2025 18:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/I4e3KRedmyngWONDAGx91EACDbwgLzxFY7mVQclJGntTqzy/bUaeZgR9UTaanW00g586ng==
X-Received: by 2002:a05:6a20:a124:b0:35e:d336:2818 with SMTP id adf61e73a8af0-363f5d4cf1amr1114115637.17.1764728452160;
        Tue, 02 Dec 2025 18:20:52 -0800 (PST)
Received: from [10.133.33.185] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5093b5b79sm16411183a12.25.2025.12.02.18.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 18:20:51 -0800 (PST)
Message-ID: <560a7dab-1f3e-4bda-bec3-3ed1723501cb@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 10:20:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] interconnect: Use rt_mutex for icc_bw_lock
To: Georgi Djakov <djakov@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_aiquny@quicinc.com, quic_okukatla@quicinc.com
References: <20250506145159.1951159-1-quic_mdtipton@quicinc.com>
 <fe647905-d852-4b0d-81b7-c2abab8b39ca@kernel.org>
Content-Language: en-US
From: Yin Li <yin.li@oss.qualcomm.com>
In-Reply-To: <fe647905-d852-4b0d-81b7-c2abab8b39ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAxNiBTYWx0ZWRfXwHhgI0PEe2qc
 zNCf+644NrXFooyKBhRNJrL/OZxPORhe041Qi24vy2fxZKbYGbliJ0INMqoatztNfhDdst8B7Ml
 54MQ5FntYx7DYB6ND/P/XKdxmI5qNmpQJt9/7514oeimlFwzMoPED8psDyAt+ZBR9D6KsfF/g/1
 gV+SyQZmYCqVYIiWcCI9KsHmgsu2X23t7vzFrkIOcyeU8Jtoej7ZkJTyOwu1b/q/ysL7r9YoQ2e
 YwB6smejinNrgm+WafkeysGhL1HaXvJAuv/s1FXHI4PUlnpgNE3/QTeC1IPMYKCTD7cCGZOv2eP
 iMWJa0/eCzfqL6t3a1DpqkgMAayCBVwws0e+aY0kDtiHlOG0ZOFTlOtUqtM2XsinorWJVhHLnfj
 Md8Mn9xHgqEJ9d9kDggKFfxhv72P9A==
X-Authority-Analysis: v=2.4 cv=Qblrf8bv c=1 sm=1 tr=0 ts=692f9e85 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=1XWaLZrsAAAA:8
 a=dDA9lvMg8NtrYOsEGZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: k1XZpM-XZq_KAn0fPZV_4TdQowcYlzJN
X-Proofpoint-ORIG-GUID: k1XZpM-XZq_KAn0fPZV_4TdQowcYlzJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030016


On 5/16/2025 11:50 PM, Georgi Djakov wrote:
> Hi Mike,
> 
> On 6.05.25 17:51, Mike Tipton wrote:
>> The icc_set_bw() function is often used in latency sensitive paths to
>> scale BW on a per-frame basis by high priority clients such as GPU and
>> display. However, there are many low priority clients of icc_set_bw() as
>> well. This can lead to priority inversion and unacceptable delays for
>> the high priority clients. Which in the case of GPU and display can
>> result in frame drops and visual glitches.
> 
> Ok, so the issue we see is caused by lock contention, as we have many
> clients and some of them try to do very aggressive scaling.
> 
>> To prevent this priority inversion, switch to using rt_mutex for
>> icc_bw_lock. This isn't needed for icc_lock since that's not used in the
>> critical, latency-sensitive voting paths.
> 
> If the issue does not occur anymore with this patch, then this is a good
> sign, but we still need to get some numbers and put them in the commit
> message. The RT mutexes add some overhead and complexity that could
> increase latency for both uncontended and contended paths. I am curious
> if there is any regression for the non-priority scenarios. Also if there
> are many threads, the mutex cost itself could become a bottleneck.

Hi Georgi,

We constructed a priority inversion test scenario, which included 
multiple real-time threads with different priorities and CFS threads 
with different nice values ​​competing for a mutex, to verify the 
overhead of the RT thread acquiring the lock mutex.

The maximum, minimum, and average of overhead were determined through 
100 iterations of testing.

Then replace the mutex with an rt-mutex and perform the same test, 
obtaining the overhead's max, min, and average through 100 loops. 
Calculate the change in average.

Finally we can draw the conclusion:
1) In a scenario where the overhead of threads competing for a mutex is 
set to 5ms, using a mutex will result in an average overhead of 
4127687ns for the tested rt threads to acquire the mutex.

2) After replacing the mutex with rt-mutex, the latency can be reduced 
to 2010555ns, which greatly improves the mutex overhead brought by 
priority inversion and reduces latency by about 50%.

3) Furthermore, to align with the user's given overhead of 40ms, the 
test case was modified to have a competing mutex thread overhead of
40ms, and the experiment was repeated, yielding similar results.


After testing, the overhead of a single rt-mutex is approximately 937ns, 
and the overhead of a single mutex is approximately 520ns. The overhead 
of a single rt-mutex does indeed lead to more latency.

However, in scenarios where multiple clients frequently access the 
interconnect API, the latency of using mutexes far outweighs the 
overhead added by rt-mutexes themselves.

Compared to the performance improvement of rt-mutex in a 
thread-contention environment, the latency itself is perfectly acceptable.


>>
>> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
>> ---
>>
>> Since the original patch was posted a couple years ago, we've continued
>> to hit this for display and now for GPU as well. How frequently depends
>> heavily on the specific chip, product, and use case. Different
>> configurations hit it easier than others. But for both cases it results
>> in obvious visual glitches.
>>
>> The paths being voted for (primarily DDR) are fundamentally shared
>> between clients of all types and priority levels. We can't control their
>> priorities, so aside from having those priorities inherited we're always
>> subject to these sorts of inversions.
>>
>> The motivation isn't really for general performance improvement, but
>> instead to fix the rare cases of visual glitches and artifacts.
>>
>> A similar patch was posted last year [1] to address similar problems.
>>
>> [1] https://lore.kernel.org/all/20240220074300.10805-1- 
>> wangrumeng@xiaomi.corp-partner.google.com/
>>
>> Changes in v2:
>> - Rebase onto linux-next.
>> - Select RT_MUTEXES in Kconfig.
>> - Only use rt_mutex for icc_bw_lock since now there are separate locks
>>    and icc_lock isn't in the critical path.
>> - Reword commit text.
>> - Link to v1: https://lore.kernel.org/all/20220906191423.30109-1- 
>> quic_mdtipton@quicinc.com/
>>
>>   drivers/interconnect/Kconfig |  1 +
>>   drivers/interconnect/core.c  | 23 ++++++++++++-----------
>>   2 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>> index f2e49bd97d31..f6fd5f2d7d40 100644
>> --- a/drivers/interconnect/Kconfig
>> +++ b/drivers/interconnect/Kconfig
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   menuconfig INTERCONNECT
>>       bool "On-Chip Interconnect management support"
>> +    select RT_MUTEXES
> 
> This pulls in unconditionally all the RT-mutex stuff, which some people
> might not want (although today it's also selected by the I2C subsystem
> for example). I am wondering if we should make it configurable with the
> normal mutex being the default or just follow the i2c example... but
> maybe we can decide this when we have some numbers.
> 

Making locks configurable is not a common practice. We do not intend to 
make changes in this patch.



-- 
Thx and BRs,
Yin


