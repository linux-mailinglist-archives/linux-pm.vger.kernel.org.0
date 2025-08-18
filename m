Return-Path: <linux-pm+bounces-32511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98166B29D11
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0009B3B38A9
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6446B30C368;
	Mon, 18 Aug 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BBXQsSOH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFA29E0FD
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507892; cv=none; b=OIhTuf+LgUeUTJfvdq2cdEgW6+Dbcjy/lg2eFmgaPW2XqjHseAywk0y7l/rZeobaWMPetIJnwbIlJdRg4v07mQabc2/ggrg1Za49jHi6yrg/It7WLMSL5ucD1tZKoTHvEoXYFFOVmLK80/j58map4J8rOM6cyHN0dLR8X6DSFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507892; c=relaxed/simple;
	bh=7eHIPEpHmH++L8mgdGXYq73W+DK/YmDiZBX3MvshN+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgCzvVz0CCTTftaTIlyc68eF+5D5uQmMHKBQJIIXJc3RqHvPOXwsbTU0fE9Eedj/crVVQj1v4tg5wUKxnbusyGLnmaizk6ER+ef2l3SDmAiD1NBtI5UV22WvQUg564UtNQ+gL4Z+dmyNQ30SoO57Fc3crdlzZO8HhHwlUuo8XOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BBXQsSOH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7V3Pb004103
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hx7GazS6KddK4CRvhI8Jo5HoBHvhj7rho2N3bAP0xhE=; b=BBXQsSOHU3PSvwE5
	uiIHg/p4zJqhnMmh4cRlqCScbU8dRhy0rS0Z8ghOpqF6zpIvCR5O2NAwOUdgCuFh
	Mgzp33WzxgCWICzxzFAavQcRuiVSuiPNWBN0ZfhQgAxK0RNe7DRWIXiIg78tT9vN
	nfHI54lhXikMwCNQS+g4vpAUyokmcJN/ZxLfLo0QOLVAi0P3BJ0brl4yteiw3FqY
	jme0gisUozr8yAWGVglJsitVQWJDBTTp1TfZLdifCypiTZJ+exO9CcpAXqqwz/43
	fEzEpQK5vkdgt51DCfdVZ4cG+quUC3eBgFkuYZsbBL22LD5jAHZxr6w2djbAU97X
	1vJR1A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyur88q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:04:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f440f0so41575055ad.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 02:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507889; x=1756112689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx7GazS6KddK4CRvhI8Jo5HoBHvhj7rho2N3bAP0xhE=;
        b=MuGdLe40Vk4S0hX+DWm5QnUjuBvj88pWy6G2PySlHjY50MFGf2x/xViGh5krCnXxjk
         UFbMrnzd8scbdFom9+qarTMCNeAto1T5s7NNoUtZ3HR4LNER6yDfBAo/8UFbBSpRHSum
         kfYdyFDfKr8pTZiZ5BKqOgHiTJ7G0xNaqwfcrNPJQlHX1xMlrCPlzBc/Eh/FDsyV3qMQ
         JA9zWiyJxznFsFuTFuBLxiPHwEjWD9kvVOF0pO7tBBw3kJQxsKFkDxNDMe2EYyZCB/yn
         3ySlvCd69QTKz9eFmk7iTLMx0Ei3omCiWoYLDAcgqh3cvfNwh/eko5vVK4MdmCJ6km9B
         kbQg==
X-Forwarded-Encrypted: i=1; AJvYcCVaeovMeHjrDwi4oNfU/jqmzLe9LjLm3Na6p6LmP9EuEuY02Bgq6VHcVdyjZ7/aQ5Ib2zh8Qwzx/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wSv4Hxnq7v5pbyNLztr/ckum6Mq7TBEReS9q3mpAeJHc5xxv
	wU7t8ZM/9KMoq88USXaU6SdIpuv5fxXD7p4Z/T8AMl8FdbUEYKuEk+aGvpIOerqIQHyF3koQFhZ
	l0h3n+6xxeszdgLoVutqxpY1q8xtaPLs1mwqqnUSV/ndNkx4IM3CXAVcR+tmgJQ==
X-Gm-Gg: ASbGncspUClNW1Ur7P87E+rQmW0S0FHoy9wU29CWMgCUl0sLuDA5Lq+9vxpp4fsJMHH
	O2WzBgwcUDpcMod+Eg+BZvaTK+5vnSvPw384OHqqMX2apiK3VrQ8GvyPRSBVrZN3oJuX0wWGEsi
	ApoEwT2USih1t+dre87k/X/o03T7GjhGakc/g7lYsPjLeDfCl8zlzn0Fa+nre7tzRWOHtkZqxIl
	4I9WHkp4a+jl2rjg/hcI2lPpHR37IaHbfgel1Yr0N+Ad+Yr/Sf4egWJinJFIoX8c1O7WuR+Qmg4
	VPhO+221tRWk+E19Tfc0XeZe+CXwMYt4M/zfT2af1X/+G9Whm+gVkcQbGEhh7+7hElRmMi7A2Q=
	=
X-Received: by 2002:a17:902:ebca:b0:234:8e78:ce8a with SMTP id d9443c01a7336-2446d93a799mr162537925ad.48.1755507888998;
        Mon, 18 Aug 2025 02:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJmiHRJLFufB9IO8hcgWH6q7B7pvAk/hvQzVpakplvV5KEBqQ7f56zxSxhND4Y0wxQpYb9DA==
X-Received: by 2002:a17:902:ebca:b0:234:8e78:ce8a with SMTP id d9443c01a7336-2446d93a799mr162536185ad.48.1755507888387;
        Mon, 18 Aug 2025 02:04:48 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm73988355ad.135.2025.08.18.02.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:04:48 -0700 (PDT)
Message-ID: <1f9d1b45-9267-4633-94ef-33f6f1c51401@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:34:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
 <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA2OSBTYWx0ZWRfXwOQbRfLY65dI
 FgLrG6K6UNVa6ljFHo8MxHtRSGbRYxsHe0G1xNo81OkCDL/iOKSes3eQlGdVEtA1h7lvm06B2tV
 dLkUPit3RBW6eb8sEpZJi6zluq9DhBaJsDlZLoKKMuLHGf+jnKItZV868cQcybbSj3xXqhaa/Yj
 btuiAnaMO4M4aRQYTlTVeuL9sv5Y98A0e6yGM5cVrL9E+4pMh/pklMrDbA+wW4L8A9ofuggHRCS
 OXYXNLMupNqGWyS/DQVM3jw8dh33Kp4R7sUU14RayIZcwkXP0VkpVUGXjyCzUZd0U5tUgeT4vKL
 E6CrbipxpghcERD49ECk70ZiMI7z0JKK+vjgaNT5fRC/fYhA9SzCsCCq9bTB4kGcPHaOCdoRyQp
 k0RWHme1
X-Proofpoint-ORIG-GUID: iut1JpN8OSRvCEElcQ5Hgk6r1Q0TR6BT
X-Proofpoint-GUID: iut1JpN8OSRvCEElcQ5Hgk6r1Q0TR6BT
X-Authority-Analysis: v=2.4 cv=YtIPR5YX c=1 sm=1 tr=0 ts=68a2ecb2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1nWJchpGOjdSI0JMKxwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180069



On 8/18/2025 2:25 PM, Viresh Kumar wrote:
> On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
>> +static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>> +				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
>> +{
>> +	bool freq_match = (opp_key.freq == 0 || key.freq == 0 || opp_key.freq == key.freq);
> 
> Why !opp_key.freq is okay ? If the user has provided a freq value,
> then it must match. Isn't it ?
> 
ok I will fix this in next patch.
>> +	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||
>> +			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
> 
> We should compare bw too I guess in the same routine.
ok I will add bw similar to level,
> 
>> +	if (freq_match && level_match) {
>> +		*opp = temp_opp;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +/**
>> + * dev_pm_opp_find_freq_level_exact() - Search for an exact frequency and level
> 
> Instead dev_pm_opp_find_key_exact() and let the user pass the key
> struct itself.
> 
ack
>> +struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
>> +						    unsigned long freq,
>> +						    unsigned int level,
>> +						    bool available)
>> +{
>> +	struct opp_table *opp_table __free(put_opp_table);
> 
> The constructor here must be real, i.e. initialize opp_table here
> itself. This is well documented in cleanup.h. Yes there are examples
> like this in the OPP core which are required to be fixed too.
ack.

- Krishna Chaitanya.
> 

