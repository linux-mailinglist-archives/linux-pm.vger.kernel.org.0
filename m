Return-Path: <linux-pm+bounces-30580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDDB0027C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071343ADC5C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B526981C;
	Thu, 10 Jul 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HK1JI6X+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240425D21A
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151910; cv=none; b=e7PqA0c13JPnP6BA4fgaytFG59oiEkPQ/2lrQhlWXxjuiMLkiEiOcMF5UA60lXTQ0GeX6deonnKrQerITAmlkYbretBV0VGZbkqVZ0PnOQSWMX66PZgAlW/4ZiQXlsKQISHimxvWgXoacPYuqIYynEZuPtUBnR9AFcep8jnAPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151910; c=relaxed/simple;
	bh=qJVTFBo4M3xSTa06WUDvRL7tfPqLymiyJ5yF+X7E17A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9Kdv3DJHwfanYl3K3M1uthqsE74P11+BXdN8rdCJtCnHoOQhgGXx6uPBWjpo/aGevd13+AdqjzNZABErjI5gkYZ1pAbCaoqZFl5Vy541fv6m5O4mJTf3XcDb+/V3AQHiJJM/3S9oB7wr9hLQ9isoAQyWGxxaIVvHAqudz87soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HK1JI6X+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9mOpC002707
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2wFqoudmfrTbWJQztUs6Cb/RCXPYE6JgwnxS2IM1aJI=; b=HK1JI6X++Uk5l4+o
	jjyPacBM1++58Z7OuDwo7krtsAhI93JNJplCS6h98YMIHbelo8TjIuzYH2bK7TaS
	3pT3pnesAvO5dBE0rwrcuUXjqLhcSckRtrWyjiqx3aD8jKcdQ27v0xknihEIa4s0
	6UqDss277fDc0K/sLQgavC438RjUoIXtVMERwgyr8MPQ65ahENdRTXjOTb8loBFx
	+nyXYV9sRiSeIjM/kDkzywiYlSebgzubHSZf9vbk+uOfKF8uJGG5UYFmndzT50br
	nROkAZvbucGVDybTi6w6Wx63XijFGB7tO9sUr3Q861PdcgiKf586s13KDnPxmldt
	8/tfSw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bg8x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:51:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234c56afe28so2157255ad.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 05:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151906; x=1752756706;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wFqoudmfrTbWJQztUs6Cb/RCXPYE6JgwnxS2IM1aJI=;
        b=iOCMp2kRUzLNzNfNiK62qgRcHCVbTBPn0S88XhVCYVP281sPSHrppRFkchv0MpemlT
         SlsgI5FTpmk/DM9Krd1yaGXGD+KRmxwnmZ7sQ9kp+CcNv11s7sPGdCHfB78CPT0eBSlf
         H93VyxRoy0vAtofjSWTUZHkpPqFAykOG9vWBoUbREXIAP+V9ajeuJDIQ9inJzAYhirkt
         OirjmJlU478+7NRb5WMBcA4gGG7V+sKgRt4XiuT/mVCTTbgsW+y1OlIHhwCLHpnWyOoy
         8YwCYRUS0pk8kBs0ZLdKBg0kDFv4gde8aUOH5OwpBOEh2VU7Fbl5qe7JnuQE/piFGhR+
         3EOQ==
X-Gm-Message-State: AOJu0YwMb2waUZIR7almLCLh5Dhe0NZpa2DINM3ggPslYYaTYKA0QvMR
	A8uQ47f4+1QTGxhG9+osTxjOG1AWEKuI/+BXcNHJbSZ1Nrh6gQPT6y9vjfEcILyDVYIOdEzkWgw
	aEmGYgiHKqWzrRcPobaAix/K8f6ufWq/4awKKvX1VIPZuldeYlpGxuzF2SR5DTqLhmsJk03ZG
X-Gm-Gg: ASbGnctH2rcEZgSF1ZCHZ/vdGSt2hDysHtP+8ix9d4lZGDNM2dXyD2p33sED3cS/iv/
	C1598/mdU2+s9W+jQe4f0CYJkY5h780mnAKWpaoODbLjxl2lcQlp7bITpOrnBHu9JD4l/dxmat2
	pZ69pSSP3CzfXqSN66HMwLuJxxN1/rpr+up5p/XZo8By+AwOaLTkVyFP6uX73AF2aocFH3cGMyS
	8kOvG6kAUIimyK7T/kAdf/82qJi1ZXrMDAI5TJa9f1nYzzqUwSPV144+UC4tSh/ke18UY5klwt2
	bZs2bHbltT0WZ/+sDyyYXe9OyUJSNIlmPqfObDdv8X2lGfSygSfFSPkcsAgO2rybmB/9yBVaHCm
	eyy7mFDzo
X-Received: by 2002:a17:902:e5cd:b0:234:ba37:87a3 with SMTP id d9443c01a7336-23ddb19b4e4mr41885875ad.3.1752151906229;
        Thu, 10 Jul 2025 05:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNpPjMGYZw1nagLC1g4Vq18S4UvqTHhUCsBqkZdx212Vu1mHjiz+Yut2MPX53YHdJ0vn+tfA==
X-Received: by 2002:a17:902:e5cd:b0:234:ba37:87a3 with SMTP id d9443c01a7336-23ddb19b4e4mr41885665ad.3.1752151905695;
        Thu, 10 Jul 2025 05:51:45 -0700 (PDT)
Received: from [10.133.33.206] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322af6sm19823905ad.90.2025.07.10.05.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:51:45 -0700 (PDT)
Message-ID: <c758497c-b008-4fea-a4a3-fb8769ce8b2a@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 20:51:41 +0800
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
        quic_okukatla@quicinc.com
References: <20250506145159.1951159-1-quic_mdtipton@quicinc.com>
 <fe647905-d852-4b0d-81b7-c2abab8b39ca@kernel.org>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fe647905-d852-4b0d-81b7-c2abab8b39ca@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDExMCBTYWx0ZWRfXxYOYw6+SjMP1
 KFeu/kcHZC7g9pnN3SPnJyC43zFBzTXMKenp9LuHYfAxD6b7hx7OM4FcBW0dlt53n/Iapj2UErG
 e+vTzV1Upw6lA7uN0ERXixNf4Wdk/AEukOQK+kYItg3qRjaYk4r1A9vnFmJhLOTBKwPKgtjDZMT
 eD0SIQQ/roVxdKjIFVdG0dlZcohiUuRvAgP7lsCSnl2cyQeWa7/s3z4yo2gmPY7Bj0HfPpIw9Tj
 3Io6WJlANzv+YxT8KAzm8Sa0webrR6R1d813oLN3eHwu4oW/QmG2cjkovZp2qCYGFh9G8LkMBAi
 ABwUofxQeYzex/Yc+/e+WjkDv8qDmmyoXr5sjqwzXQQeQectSehJAYbqexBjtw5ztYnRRl1Wanw
 cI0MATh3zVupragKZKyzR6AIIi4nl4i6+JGmJqOkA5cus/U5gAyUXUAbYUXZM0zMxbDCML+C
X-Proofpoint-ORIG-GUID: OKUdrm-_zSztSvKZreadHWndFF_bcoZT
X-Proofpoint-GUID: OKUdrm-_zSztSvKZreadHWndFF_bcoZT
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686fb763 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=gJ3ddmUR-uWLB-3PzjQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=954 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100110

On 5/16/2025 11:50 PM, Georgi Djakov wrote:
> Hi Mike,
...
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
I have some preliminary latency numbers for the icc_lock mutex lock on
my Android phone under normal conditions, ranging from 50 to 1000
nanoseconds. I observed that three normal priority tasks and one
real-time (RT) task are contending for the icc_lock. The latency numbers
are not differentiated between RT and normal tasks, but the 1000ns
latency was observed on the RT task.

The latency numbers can vary significantly depending on the scenario.
Please feel free to suggest any specific testing scenarios to capture
the numbers you are interested in.

The delay numbers will be based on the scheduler's granular time. For
instance, with a 250Hz scheduler tick, single cpu case, the delay is
likely to be around 4ms granular per sched_tick and the other system
tasks's vruntime conditions. Since both real-time (RT) tasks and normal
tasks may compete for this particular mutex lock, it is advisable to use
an rt_mutex to enhance real-time performance.

Here is the potential flow for better understanding:
   +--------------+           +-----------------+


   | RT Task A  |           |Normal cfs task B|


   +--------------+           +-----------------+


                             mutex_lock(&icc_lock)

                             Runnable because of other high prio normal
tasks

                             4ms sched_tick to check chance to run


   call icc_set_bw()


   mutex_lock(&icc_lock)





                            Get the chance to run


                             -->mutex_unlock(&icc_lock)


                             -->deboost task_B prio


   get the lock

> increase latency for both uncontended and contended paths. I am curious

Yes, there will be some overhead. However, if we use an RT thread to
speed up the icc_lock mutex, and if the clock settings can benefit the
entire system, it could be advantageous. For example, increasing the
clock speed could lead to an overall performance boost. In theory, this
approach is worth considering.
> if there is any regression for the non-priority scenarios. Also if there
> are many threads, the mutex cost itself could become a bottleneck.
> 
>>
>> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>

-- 
Thx and BRs,
Aiqun(Maria) Yu

