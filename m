Return-Path: <linux-pm+bounces-38178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48268C69E73
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F2D9B2AF70
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B935A135;
	Tue, 18 Nov 2025 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lkk2EVcC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b6G0znGQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5435503F
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475638; cv=none; b=W7L8Q8CwSRDh3+ate4AoVK3bWUuHuKar+MJfBI8U9GrFF8QGYalA+mQy9nuzRpBpj3wKIMQ75ThnUDo0BLcJYdFtwvyn53VKgepVuf4v/YYnuviZMpDzu7eF7h2b1b2ZW08jx48Cg11/ALMNkHbkSNUWDVsGOsaw0mGGQv68KLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475638; c=relaxed/simple;
	bh=yBuZpxbPhwoE9ApiClipPoDt4FBM4qUBQnCUmTKsdIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niwJe6IHA65rYECbJUfdh1C0zBaMztFp0DxISui+VpJZndt/Vybr1I2OPY3jVv5IC8smEv8Q2xK4fCG0uoHXTt2elPa+Ifohi+OxdyoObXfvidhch1taCZrQXvLC7GF1WVEpldg1zjkVvbLWBO0wHqV//ti7lBAfybqGtew5m+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lkk2EVcC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b6G0znGQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8l5jk2755013
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ORqv6M4KIpZhohWP0nchjhTLwssM6e06wxIHarVDt4=; b=Lkk2EVcCgQtOcSBm
	43aMYSTc5IqggQVfwComBUoZoR809kWvkt2Izbx/9n7feAhxanv5Vrv4196idMK3
	UhyelbNdRCAsXBGsKHMMwoHFyYbeybZDzHqcEAfzwmzwr/6k4B71rcJxmHntkhWy
	U742vO90IjuxSTWHcL9Bli0XcdmKXJmI+1g5RWxSnoRG8JExKW7dqHkQzHl+mzFj
	kh1y5vDCVwI3jLpyKTL03zbh/41cCyp+EjQ0pLAfkn+BYnPZx+ATPAg9sAWyBDHe
	wI2MYA9qU8zw6kJqRVP6UqsTTw32jib1/+KdgCv58KAYejeijlGciS3bTNCwLPeJ
	nMJTsg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnkj0wma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:20:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7bf15b82042so3798796b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 06:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763475634; x=1764080434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ORqv6M4KIpZhohWP0nchjhTLwssM6e06wxIHarVDt4=;
        b=b6G0znGQPM/gyg8eLltRZD6WnqwFQYpLaKPsUrjX8eBeL8EJfVmJ1y+Eu5KoIhOm6i
         CwNTKg4b/QJPzCCHKzcaK7bmCnAkYvPChQZJiBrDDxMGrI3AJPL8Xo4uidizeGmY6Ye4
         yY9zMIb2kX6ZcZ3T2zK3uU/8PE8FT8KhjOcM9U5m1r7l+lV/It5jeA1ixIoWDhByAwbt
         NhrvboaPkmozzyMpzRF+/dfmYUbQAzn190Tb/M92GNlgsE0jNf2Twgt8nZu0ySBeBm3f
         JVPKp2ZyPeN23kFFTo85/UX3WrhsAL7TLnVPRMdJSzhtdISau8GbfuOIc6JJZvwrfXTL
         Ce6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475634; x=1764080434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ORqv6M4KIpZhohWP0nchjhTLwssM6e06wxIHarVDt4=;
        b=qbSQnhivZ8M+0wDhs6MaI17KjNm41KVY4R4TgtXNBFXRoJ8SRVBLOPp367pi/69ztu
         RBV2I1QAmVWzgdVyH0nZdpSOOnc75TOYqdjo35XfLaAzD7G/GQhX96lEAHXRXr70+kXA
         9QfFig3eXGvczVtyCdqhvonH6NM319FIySGNszX8t0KKS2aKQa0dpmTJAwYrmESJavas
         onq8aY4uwS15COhAbdC+Eu3s7JTaksGLUgROFtptUgQmTpoO7abT5YngpM3WMSdTLmc8
         DjdpRz3aoWX6VwDSUynUcuWvenGNhOR0mifibjDY4kyFiyV/FBn30vLGv8vEyzE3lDV5
         mYcg==
X-Forwarded-Encrypted: i=1; AJvYcCUGzOA1qVCo1JusqUXqKdb8ncz58y/cGHLGQZoouw+dYmQPUj4qa6tSnQxJ/Hy6rMFR/IooIL5oFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkDJ6Iw9sRLZ2CKZOY9Z4ak6rQf795DSTIuWOSctk447oL7IV
	3+CQx1x3gmiVYJjJiltbUBVGdu4rid4qco2mD3XOsTBlRg1dw3jKj5oqQUeqSJPurF7XvIKJVYF
	123/BPHvQjx3YhdV6bg4W37xh/Qo6GcEoSq5Gcpu/QxUTa+TmpEW5nKvY191Utg==
X-Gm-Gg: ASbGncsTpjUZTkZXonQytQvRO0Pg3tHNV5ghqKHgSZkRGQGzeqp2fbTsHK1YcQR7p8l
	/CR+mm6gA7DhQQnlleH7SGpoJNEPXrxxvWd4ustm4wNcoGt6ujfXryvWfuVomMly5OCgwCLpKCj
	DLSHPgqIq28ShshBqLhO9TxMykMFlJqCtaa1TcS8VEvhcPGtoKunl/JyGrny9G+klJkQg4j4V9E
	TobTI8ljfg1aXc9+yPtXCtZSEd7nJFfBAvNHz7DP+xAWQBNebgt/qxzuzwqlg9PHA1Z76sUPof+
	0DKG+rOaPPekFsUam0t2RzNYCX1utaAs8MOO+ucp6LvZjRyaL2LzsqoXXoo/ewlIqzzrCLT72CA
	IFjM/XL2+YiI56EsOzudtUP2pocwnGnA/
X-Received: by 2002:a05:6a21:9999:b0:35e:4b35:3669 with SMTP id adf61e73a8af0-35e4b35382cmr12646057637.31.1763475634239;
        Tue, 18 Nov 2025 06:20:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYoHzllakq0T+6BK9IKhCVI+aW2IeP9GCdHUw1sMDeDxu/C7mgoOm/dGvn2O6wnicuyKu3FA==
X-Received: by 2002:a05:6a21:9999:b0:35e:4b35:3669 with SMTP id adf61e73a8af0-35e4b35382cmr12646015637.31.1763475633669;
        Tue, 18 Nov 2025 06:20:33 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db21a0esm15120200a12.8.2025.11.18.06.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:20:33 -0800 (PST)
Message-ID: <b706ecd5-a564-35d7-9a02-8da9cd134b24@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 19:50:29 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] reboot-mode: Expose sysfs for registered reboot modes
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <CACMJSeuiL5XEZjh8mOSj7tUnR8wEYSJ6FfZA87v8TSu8xM8_JA@mail.gmail.com>
 <8b6ba46d-ab64-dbc5-8f09-e810bdef724e@oss.qualcomm.com>
 <CACMJSesPSt7LM2duVuBOToxL_5e=SQysW4T+hndMu1Ubs5oJwQ@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSesPSt7LM2duVuBOToxL_5e=SQysW4T+hndMu1Ubs5oJwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SFgK1pNcy1dvsD6X9QnZXwsrmwlJaWE5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDExNSBTYWx0ZWRfXzHNOmPJAIRwX
 1wdJsRDvQeA2CopOoIdXJQLOcdlyRxSihJThtVGzRQD0YX6VYrGvzz/y/Be6c4dhMqJp7z0Odmp
 7L0AbzPfXE/YkmSs9v+FghiNfTRYLMOULqEBANcebtBZSwI/X+d+wCyibM7x0hYJTB9DYBB+5c0
 T1ABt8XGSjy6U76yjICfQYUiUe//x9G56Nh/zbuzAetv73Vip3mMaNSZz9yK05nlWYPMyk91pg8
 MhOjS6trRsYXwKdqbvxC+6lVj+VoxaktNytZ+4vs4WmuwmTeCNZvEC6gMeJ4Zko3clDOf6W7oYb
 vx6nLQ0SCXktZSE9vUd+AMjuHZ7MxdKXhQOSKOW9WWfhB0DdAnGSvjM5s5BJpwK9gFyZyIaPKeK
 sDDPvO+AuMbJ27kwDkBtGYk9LoZFGQ==
X-Authority-Analysis: v=2.4 cv=cs+WUl4i c=1 sm=1 tr=0 ts=691c80b4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=llVMLCiusnd1_Z4tx68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: SFgK1pNcy1dvsD6X9QnZXwsrmwlJaWE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180115



On 11/18/2025 3:30 PM, Bartosz Golaszewski wrote:
> On Mon, 17 Nov 2025 at 19:05, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 11/17/2025 6:33 PM, Bartosz Golaszewski wrote:
>>> On Sun, 16 Nov 2025 at 16:20, Shivendra Pratap
>>> <shivendra.pratap@oss.qualcomm.com> wrote:
>>>>
>>>> The reboot-mode framework provides infrastructure for drivers that want
>>>> to implement a userspace reboot command interface. However, there is
>>>> currently no standardized way for userspace to discover the list of
>>>> supported commands at runtime. This series introduces a sysfs interface
>>>> in the reboot-mode framework to expose the list of supported reboot-mode
>>>> commands to userspace. This will enable userspace tools to query
>>>> available reboot modes using the sysfs interface.
>>>>
>>>> Example:
>>>>   cat /sys/class/reboot-mode/<driver-name>/reboot_modes
>>>>
>>>> The series consists of two patches:
>>>>   1. power: reset: reboot-mode: Expose sysfs for registered reboot_modes
>>>>   2. Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
>>>>
>>>> These patches were previously being reviewed as part of “vendor resets
>>>> for PSCI SYSTEM_RESET2”, until v17. Following the suggestions from
>>>> Bjorn, the reboot-mode sysfs patches have been split into a separate
>>>> series here, for focused discussions and better alignment.
>>>>
>>>> Previous discussion on these patches:
>>>> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com/
>>>> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-4-46e085bca4cc@oss.qualcomm.com/
>>>>
>>>
>>> When doing a split like this, please keep the versioning going. This
>>> should be v18.
>>
>> Focus of that original series was "Implementing vendor resets for PSCI SYSTEM_RESET2".
>> These two patches have been split out of that series. The original series will
>> still continue to its next version(v18) after addressing all other reviews.
>> So i thought that these two patches can be split out to v1?
>>
> 
> No, they both continue at v18 so that the origin of this smaller
> series is contained.

sure. I will resend this patch as v18, taking care of current comments
as-well.

thanks,
Shivendra

