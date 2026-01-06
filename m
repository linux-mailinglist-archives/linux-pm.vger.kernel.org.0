Return-Path: <linux-pm+bounces-40318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2DCF8D73
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7609C3023D6E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA4322C88;
	Tue,  6 Jan 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="audbgGpR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YX8Z9wh7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051363233F4
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710742; cv=none; b=tbROBRJIAOlw+0wNBPjfdoR+6ySLhiHvD24Ozsr+lJtcGOYouGI2nZlCO3UR5cJMO3hj3/GN60+KwB1YhyAl4lZsm3sPcgMQ8m3ImkKF4LsbVA9NPVRpsV6heufl3oO1S//jReNijhPUm3qxUAVJ0aWBfhanEHVqpNCHpn03ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710742; c=relaxed/simple;
	bh=eNAOjNVr92F3tFRWKgIvOrOHSLIqRZLwoWnifg549Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/Sy7K+lqp6zmaGiWRpO6EYKBoNBY0dGhNfsBhLZSnO/1OOlnnb5UHOlHaL3+FAJs/XPJd8ULV9weYGDOudAvuJWXthOYm7eIFz+iDZqWsLzivvfrx6IRjwRjw+R768sYd+rfdc5OYckQPMIvvGZc1jmkUvmwgkR9ysX4fT40sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=audbgGpR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YX8Z9wh7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606CAEUC4048526
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 14:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNziTKXq6hMou1yZMEV+qqX8ioqkSFVAbA4CKr8vH74=; b=audbgGpRpDXwSWqb
	mpAeUqvDjLRcZ8AmY+JGq683g8RaoXdSi9AG1Wewbp0deReUU4SFHePOD3dDRK+g
	+HlCQR6e1sWti4woU8UIM2nOlVjNFg6V7LQOzIvbmxqvxhb5fJqqB1EhXrxD5vo3
	cyO9nkjZ1a+i0vrw1nHPbsIfgXrk3JHq28ZgbHQ8Pl+rp1hCF6HnfAi1jv1kN8wV
	sFSRh+EUy0RnrbW2FFqM3MCCQB6R1SLM6xzLQGn5dUYkoCdtXAqagVvYOUQ0q4Nj
	PY3NTaHA9QZYPvdglh0r6QKebjZT6fHBuJ/DAeo/vmxw1F25bV+3rugiQtc73urA
	nPfy3g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh25rrdvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 14:45:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b9c91b814cso2945222b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 06:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767710738; x=1768315538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNziTKXq6hMou1yZMEV+qqX8ioqkSFVAbA4CKr8vH74=;
        b=YX8Z9wh73uDhlIe8cEAkBI5p2Ffq2ZbHo0hYKsfAcRh3xkUIv0jsnSedLJMXf402LN
         4iayRKuybJaie3hDyPudnoux5BGo1aIga395uyO/DvjJIZgEHYnoad0JhsJhtly8u1/U
         ub7SeHdAB/n5c8cA3NA71wG373/FYwB49v5NCMUE34+qR94eOTkUGm+FXAKFCShDgHhp
         wqgL8obPByZZZaNPwA5aOPBbvllKmTJT5d4wRh5NAo8F/8rOAFTeJ767+ptoMKA6H0YF
         wEONqJruN+9z1FRrIsifcZYXbRfM1Owz9CEoikLZXxPq0+5pb9C5JP8VJAgGwE8wNq3s
         /l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767710738; x=1768315538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNziTKXq6hMou1yZMEV+qqX8ioqkSFVAbA4CKr8vH74=;
        b=dJqs9XpD2vGLUNBxvntlKHc0pJA2qV4YeXgcK8qOFvSrd+sW6b4vPcg03GzRZNe2aw
         cLF265vn/DtY0HMeW86Vu1tFaE1ytB89VaYGqY6B0aBA1LI+LN+HmdZZszVEa1oH4pzS
         3LaWtP6qWWURWrCclW+Kg8J6N1ZmvPv1ZtgiRx2AavNGkNrBls4eUDXiPgQcnMED+q16
         6aGeb3aT1UMN00HjVFkp3mY3gY457Jela+KDoSMAYjPl7dGAavFZWRu3C1UiU+5/OLHf
         02rQFtfd/K0YdrE3/bKkPq80fQ/xnYxwpjkylfl8Rjj5wtTtVMnKTDPOcrbWkQfvp+ga
         lj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6K5jxIfTJbfPN/IL9hV5HN4Gjv/7gxHuljRJQtUZ2M8P+4F9+0ETunP9465NFDAB2aQ6W00ZyjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzws06YrSjoadSefeUEm2hpcUK+4VBQb44OpF6HkwGPQmhOfmX6
	aG9YKCS4FX/5asiSPsoyoaUAbStpMZuIt3fgbOy0TeHDtkmquCG4hWsaj/n91vPqcNT2UfWB/hE
	9PSDPlkJ4LRti7u+Q5VlAFo4jzcvP2q2wVjXw+p1+xxdN0+CtN7OiiLMxMPYGOA==
X-Gm-Gg: AY/fxX6oA3DS6W5/czJPoc6yeXHYHxDyB+dzMGaXxXBpYVuppi05jabXzqKCeIDpnxS
	V48MrhcfTbBeic8mJlCUuQhR6TkgPf0WqxJ1EB+FxUvOPa/+O+wivhjo+6ya5xgXySm/p7N2Y6F
	tnUZgeKk3dnzSwK4baaCtSz4pXVi4Y9B5ZHgvvz9mW4ydMWcBlTb6uCz33LLcevspuUW0e8XBwt
	scJKxHlO9pGY+mykLTaoaAXcgw4WnbrNSoI/ExWXw9ntfwvF69UqDLFVTXzHct5ci7z9R+QyEJo
	C3iRvfJj7l7j+lz9FMbryo+/iU4W2505aZh1Fon9G0ECd9pcmTMkN4PjZ+4e9k2bDjjYARdsXWO
	t4YsU1RDILPn6rMRPYmrDzDShaU9q3N4RJjpq+qb1kuU=
X-Received: by 2002:aa7:9a87:0:b0:800:902d:9fdb with SMTP id d2e1a72fcca58-8188115dd33mr2788991b3a.5.1767710737559;
        Tue, 06 Jan 2026 06:45:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFDkO1MPs6jk9DhiTL0y1oFq1kAN13vdOai6+rAL4mB8VzpMFwz2vdGbIXz2c0/G92FT+f9A==
X-Received: by 2002:aa7:9a87:0:b0:800:902d:9fdb with SMTP id d2e1a72fcca58-8188115dd33mr2788972b3a.5.1767710737035;
        Tue, 06 Jan 2026 06:45:37 -0800 (PST)
Received: from [10.216.40.68] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de6405sm2450578b3a.61.2026.01.06.06.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 06:45:36 -0800 (PST)
Message-ID: <466fac7a-e16d-9c49-80bc-c07ba5a5f334@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 20:15:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v19 06/10] power: reset: Add psci-reboot-mode driver
Content-Language: en-US
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-6-ebb956053098@oss.qualcomm.com>
 <CAMRc=Me8WQ=aMd-NJ1yzzHzqU8fT1u4eb7as=EjSpZ+Rpv9+rg@mail.gmail.com>
 <87f25d02-2805-9da7-0d7f-05ce8a022d25@oss.qualcomm.com>
 <CAMRc=McH6jsaKROyMGAhH_gGSiQtqvuVmrUODgtSp0hX8g06=A@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=McH6jsaKROyMGAhH_gGSiQtqvuVmrUODgtSp0hX8g06=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WnF1ngRW40pvHWPPJdyXLtyYHZqd8m0v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEyOCBTYWx0ZWRfX7Fp/syu3oxLJ
 t7wHBcf5eHNOd8lIW1fkhwZ6l4zofed43+XVAbfWVjJcYDdv+coYNCE2kL6Q2FBCtKP0r9LQGTm
 suk33ODzDI0ZK4ikU326JtvCtseX+o2Tut+LPYNIKL649PbTTTGE1VTXF+NjcjYxkbELYWGutUy
 oB8wWWfnf8OjcL7kKfH5auaPGJxS35X28WX1djHUbnB7Njvco2WjJPgTtVbMKvGwa7XnkyAUQ02
 Ev3OAUhFNkoRQKOzs15/SPgpiCVSMoi7UtB0jb8Iv0XttqGo3Wnf/B4lZVfFttk9UU3ARBGDsMu
 ocEVV4Et8/ZJGXT66sz1oPqpz7+rEIzX101wtPdVuJwsZyRYPgKGmlDM3wAXYusO0S8glgfHY19
 JAFXHbLB0XX+aTkJALgbxl5dqg8J7lQKRs5QKJPp73MQUwpbWLdEW0U8POxVT9DdYHZjwpcWN93
 Wzxy22NlV+08WtrjhOQ==
X-Proofpoint-ORIG-GUID: WnF1ngRW40pvHWPPJdyXLtyYHZqd8m0v
X-Authority-Analysis: v=2.4 cv=G48R0tk5 c=1 sm=1 tr=0 ts=695d2012 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jnZpEnBlv3Rj3AlvUe4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060128



On 1/6/2026 6:04 PM, Bartosz Golaszewski wrote:
> On Mon, Jan 5, 2026 at 7:06 PM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>>> +static int __init psci_reboot_mode_init(void)
>>>> +{
>>>> +       struct faux_device *fdev;
>>>> +
>>>> +       fdev = faux_device_create("psci-reboot-mode", NULL, &psci_reboot_mode_ops);
>>>> +       if (!fdev)
>>>> +               return -ENODEV;
>>>
>>> This will always create this device for everyone who includes this
>>> module. Move the of_find_compatible_node(NULL, NULL, "arm,psci-1.0")
>>> call from probe() here instead and don't create the device if it
>>> fails.
>>
>> Ack.
>> Will move both calls to init before creating the faux device.
>>
>> psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
>> and
>> np = of_find_node_by_name(psci_np, "reboot-mode");
>> --
>>
> 
> On a second glance - and I may be totally wrong - would it be possible
> to switch to using the auxiliary bus and create this device from
> drivers/firmware/psci/psci.c? That would be even cleaner.

Till v17, device was being created in psci.c. Lorenzo wanted to move it
outside psci similar to design of cpuidle-psci.
 
https://lore.kernel.org/all/aRIfc9iuC2b9DqI+@lpieralisi/

thanks,
Shivendra

