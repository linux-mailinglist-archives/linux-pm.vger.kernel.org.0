Return-Path: <linux-pm+bounces-30436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B26CAFE2B0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98A97AECAA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0626B74E;
	Wed,  9 Jul 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZSBR7BL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71327511F
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049941; cv=none; b=ut+G0yiJUBpLb3fMpOdkjGkoHLYhPD43yhbvrOJ2jLGFAVhMrbu1qf+0fsPrp0vmJ1b5VuC9zmB4C1UVH+3HraMEBNtKHLEZurotcpUdeXUCceXDS2m+zINrYHzgJxI2po97BgU8XAlcco8L5JPdSagNhpUB+XK+JibJTF4OJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049941; c=relaxed/simple;
	bh=DzcH7L60UbeOJ9WOUsF8qxsGcS7+hgTpKAgmlponWSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6LddJfJ+bGIdh1fbkTtn66vqgXSnSEvne12PQmwUnGptqb54jgcTVjJSxFKO6fuPZ8szCKfN6YTD3/uFhSYIf2+iyyxyESdrt4blFJ3hb64tPbSq9ZzCk1ymEpsIKW+zWhtpbU1mR48KrQREwuqG3htswOtrsxY8KdmQ6ZLFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZSBR7BL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56988Bhl008293
	for <linux-pm@vger.kernel.org>; Wed, 9 Jul 2025 08:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AEc/ZNFmxnMuleR9FhMEb0OULDquczMqvJCfIuUAe8U=; b=WZSBR7BLHEagmRl5
	rwWr0YWWaDnIhlQGDUzVVYTUESQ1ALhOfI8h+wBnANG2Atyh4CZQBk17oBrgZxtr
	bOYbddBy1A8xEFGQl/hZfpKsnet0m5TyggaSgRcI9BPg1RMy+72kZriYoRIEuaba
	/kKwLwa5DycQ2FLAOKndTf3+bpPMJ8QFrHbOZrzmWXM4LLx/G3VS29GtYBsAmBA8
	IaHFHqA8OVgel+o/Mjw2zCCB78uDZKzf+3/64FLCdBhRGke7Z0oABVWnLhd2YY10
	CUAfElFQzBdb6f46IpkNT8D8SPXKGSytf7aZhA0ju8mcjnlvueDLSc2s7mkOwTFF
	WwYQIg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn3qdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 08:32:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31df10dfadso3373107a12.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 01:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049937; x=1752654737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEc/ZNFmxnMuleR9FhMEb0OULDquczMqvJCfIuUAe8U=;
        b=HJUomsRiq3xjciJ02MA3REix/RY7GrVFAAqT/+Bbyty2Uu5wN2fK8bdVcshPD9P09B
         eQP0B83n22SnSgIGA/gS74R9yu9pECheCkVKspgfoRzDI2+qWrnLnXNuVRMbD/H3skZb
         9RRluCzCHYWyA33PyuaksnIMsOydKbuHNhVZsO3R4V8Y6lLmbtCAVGLgLtM3n6nIhvsq
         OUiGxNWrGZqItImqCeaLXp+5wSxKCiaFLKt99XWFKaoPhQCtLLcizYz9HE1qa5QV287b
         qQ0uczwGxMDq4Mh/4OkSHcNJh2/tlXFQzgkA4HPQpu/84h+kt3t3UHl1y3vZwKoBGJuJ
         XCrw==
X-Gm-Message-State: AOJu0YwIgPiqIQBFKMxIm8/u3X8Wq8q4a0QX+58yz4NqzIcR7Dx+wKlV
	VTO0LckVzCaqncxW8b7jTDYRvq5Un3ol9SpMLhxoAa/wC/+6gue3e4AwOb2hGgpMZVUSdkNvOPf
	JtXPX/mpZ0ucpLqnXqMNQjYN7uGQPXEPrZJwmVcsnlvHUpMqMFhpkcaymmRI1iZInKGFFrw==
X-Gm-Gg: ASbGnctHBPJ7PJ7dSqiZC5C1lfaqC+w5acVTJqv40Y/RSk1BpItXhS75OAUHH2YymkG
	7epHGtwayIdyRzoKJayQRMwi9y90lWXT/IWBN5WY1XAKybv0WXtP0qNhu7alThhZL2lYgJkr/R4
	naQHRALHvRUQlSi68KTDuOQ6ZRqLN6luguJTsUux9K7ja95Pns7KMPPCL8nUCrRkPLhGwLpHShm
	uiCPH6hc0PhSqk+ttaKTrxp3XIRz8hqs0vLLrvUdcPxHUNopFPvF+oxWED7X0HsjLU1Th0sY1o4
	t1NWvPSuk3dIT0+d4uKOYJV6VeL+VQqFQ/mI2c8qd7f9GLU=
X-Received: by 2002:a05:6a21:9995:b0:225:7617:66ff with SMTP id adf61e73a8af0-22cd7487ecfmr2576726637.20.1752049937298;
        Wed, 09 Jul 2025 01:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF21ezKBzrGdz4BI6Lzw1JTE2T+1doJUN0UmTgSxYTC/KdMGVYc+82ZfcvVJicGxGSuhavU4Q==
X-Received: by 2002:a05:6a21:9995:b0:225:7617:66ff with SMTP id adf61e73a8af0-22cd7487ecfmr2576700637.20.1752049936822;
        Wed, 09 Jul 2025 01:32:16 -0700 (PDT)
Received: from [10.217.199.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417dd7esm15183345b3a.97.2025.07.09.01.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 01:32:16 -0700 (PDT)
Message-ID: <803a7bea-68d6-4973-ad2a-0d8721865831@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 14:02:13 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: governor: Consider CPU latency tolerance from
 pm_domain_cpu_gov
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250708-pmdomain_qos-v1-1-7c502f4c901a@oss.qualcomm.com>
 <CAPDyKFrL63Jv4_cUbrjAaU4UtNNDVMpALt41Mu6NbGcAefmWUA@mail.gmail.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <CAPDyKFrL63Jv4_cUbrjAaU4UtNNDVMpALt41Mu6NbGcAefmWUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686e2912 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=p3CtfcOl4c16AG3dCFcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: aLkXvjjnLZ9p2CznZaGhoXvl2qeGAEo-
X-Proofpoint-ORIG-GUID: aLkXvjjnLZ9p2CznZaGhoXvl2qeGAEo-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA3NSBTYWx0ZWRfX+L9KLJhcF0z6
 vD1mbmEj2BJ8q8TG60B7FhP12sSXonSam7onYif0o94g2EYIcgkgyHQNSi+WUIU0yeaZoLPrMmL
 Dg8h/U0Jm9ZKcLFhFb3C69tijyCK5yW25PQYONGjY0pFboDHbRSiZvg+oVnig/wPnXryzI3Eo4r
 HQTdEyqCHZcSECWNiPXaCF/K8ei6dBsFfXfxnJ9FW7enuFir1rH7A4r0ziWTeCdFPqUUPjuOWWH
 RBHcDZbOtMI7SuvUI1+KFE1nTvo1KFW71cJTMX2Nn76qxgrktJhkbrnSArnuYnmdoa2xgyzjYJ5
 +GUjC690/RcmQ7giKSbqCLnltjjbEl4TRZBzeO+H0SzF8kCEbYank2u3BduzpzHKKZBBhfwyyxV
 X7ctom2GaQ1S7Em0+7UovT2x2MBLPUW4sv5I/83i1qG8QUuI/ci/yvddX78B1XhSXTmvv85V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090075



On 7/8/2025 8:11 PM, Ulf Hansson wrote:
> On Tue, 8 Jul 2025 at 07:15, Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
>>
>>
>> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
>> index c1e148657c873a6b5b4d9c0f058d54cb020c56e2..d5ac4c1b5b5a432f0072209d17379e58ec891202 100644
>> --- a/drivers/pmdomain/governor.c
>> +++ b/drivers/pmdomain/governor.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/pm_domain.h>
>>  #include <linux/pm_qos.h>
>>  #include <linux/hrtimer.h>
>> +#include <linux/cpu.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/ktime.h>
>> @@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>         struct cpuidle_device *dev;
>>         ktime_t domain_wakeup, next_hrtimer;
>>         ktime_t now = ktime_get();
>> +       struct device *device;
> 
> Nitpick: Maybe rename to "cpu_dev" to better distinguish between the
> cpuidle_device *dev, above?

Updated in v2.

> 
>> +       s64 cpu_constraint, global_constraint;
>>         s64 idle_duration_ns;
>>         int cpu, i;
>>
>> @@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>>                 return true;
>>
>> +       global_constraint = cpu_latency_qos_limit();
>>         /*
>>          * Find the next wakeup for any of the online CPUs within the PM domain
>>          * and its subdomains. Note, we only need the genpd->cpus, as it already
>> @@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>                         if (ktime_before(next_hrtimer, domain_wakeup))
>>                                 domain_wakeup = next_hrtimer;
>>                 }
>> +
>> +               device = get_cpu_device(cpu);
>> +               if (device) {
>> +                       cpu_constraint = dev_pm_qos_read_value(device, DEV_PM_QOS_RESUME_LATENCY);
> 
> We should be able to use dev_pm_qos_raw_resume_latency() here, similar
> to how cpuidle_governor_latency_req() does it. I think it's better as
> it avoids acquiring/releasing the spinlock.

Yes, updated to use dev_pm_qos_raw_resume_latency() in v2.

Thanks,
Maulik

