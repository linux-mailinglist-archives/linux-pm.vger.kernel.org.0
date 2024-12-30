Return-Path: <linux-pm+bounces-19851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E49FE6CF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CA7A0859
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108981AA1C0;
	Mon, 30 Dec 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvR/qlWk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F241C32
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567597; cv=none; b=YKsiPfHuOl5lj5dOwiIUCRZHz29ifXgvPiHe3Mwp4pOPb0q8ecSpYeQfbW664EM/pPDDGjGJv8mwsHypyxf4cwkJvvYj4pPuAPb3q/1n9HAh3/JC0BgCruahz4kazjD/YueEtMHbDy5OBV5wJgZICE3bDFgxxVlJ47zcWIiEhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567597; c=relaxed/simple;
	bh=Pd7W2GaowCzBlhjM+FPZl5jVACnucqVoUpDs8LGL2i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0H4OcRBkEaaOXktmBQgAXsQuZ5qIkBC3/IqWpAGEjKV2MrHQk5eYUKpoUHCqQyi6lxTPAggPFtCDpEiZJnIrgkuptas2stbE1K+Z9SpcFnSgQQxZOjRHYUc7scCF6z7R4GIP9AvKx1IbmSMJqcNQrT/6zrVJN6bJi2RiP8TvtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lvR/qlWk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU2jpXg026640
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 14:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s2w02fJr/RtLzq61cZCWFNHIWP1TLDcvMW7PA8rh8QI=; b=lvR/qlWkgK665AdU
	wxhC0lOZU7UzFBWctL1dpWp+LrfOul7NjBklqJZ8NuL4v7uNaTVVQy73aDckWbwb
	Z+ow/0po2mCFPfvverxnxdUqgHQcNzsC+eFcygfIxuvlTbu1dODI4K6rsAANO95B
	nDRXdNUr/xwFED8mCLuWcKpd/55vy1pawgZzenHYczoIJiv3odmiTNO50BsK45JD
	wTTsMH1kQoqyUP7BB92I3uhWlSzoISKV43A1muSp1D11GJwM4U6sfSIscnTtPaTT
	8nhqL/r+kwGPjc76c+LSoWbMybVRg0hl/VpuRe9hGzzi/kR3w7N4m+c4VnE5tkR6
	cXAdcA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43uk121924-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 14:06:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6db1009a608so14927006d6.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 06:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735567592; x=1736172392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2w02fJr/RtLzq61cZCWFNHIWP1TLDcvMW7PA8rh8QI=;
        b=YAoyEqT/OKnklL8E5OMQuEMAkR4jrFYFlnxJdRwnrBhkBKl6J+rvBJWM2Dh4vFBgZk
         nDQYfkjNTfN+x8toTkp7dLqumC9PQllQaqRD1rLN+cO5Hwe+hulueyUgji5BVLawOnj2
         982Sw+Iujwx9IL5kGmNLbpsMgO+2EOTejJ0duU5p7OLgiq46RIG937tyR/bG6J3pYqlj
         mn18MFBSY2PKDCygNhZGSZrxCxyJ0D3pvFhf0uTddr6nacH8t3TsdIWh460YEgPc1G0O
         fCMqDCyg/Kd5gyqreD5cQBRCWlHvqO1EpwW3QxK6vp4i10v348P7he3aseCxD3tAkeFB
         ZRVw==
X-Forwarded-Encrypted: i=1; AJvYcCVtaQejkTCRmtr4cPNaAeRmAZdKtyVGwji9IpwjM+81o874RImoDL/SjlzdY0nGVItfZKNyANrf2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmA/cc5OKFD0M+tf2wWb421TG1efnj7R9FYp73+U43PN/ErQK
	+V71DTh2jQCgLx0ZtIu2NV0wRpk7W4ltAZVw6VpTqxgfqQRUVcBpfy5OyDGwE5ziJQympdtL95A
	15pnYLqaZ7EigeOLahvKf88xVwf1ua83oGoD8KHolBVF5+t8ZEM8boN9/Vw==
X-Gm-Gg: ASbGncumGN7dGzVR4L1cAxOhf0WMrskkDUxWojYaC7XLqBJqhGerB82ldrljFpO0qSM
	NjYXjKWIPMmK/C3PpzKRSGTT5ki9bi649epTlaJWAm10vgcu2wFWlWRjVEq7Vy+dt6lSQmrqb80
	JD+jgRGRu68GFbVemreMwNqpCMw1uyB9jeNpF85nb2KIrFcWRYi5HJo35jkeHYXtBIYGDH3gxmX
	2SBt2MbxRva2Vd6LBKcPQlJ6vmwO2shZQFe9AEUYB1ReU6YuxGcrVOnoHD7G6k6ufBofy7SVZ/p
	OwGeAMuox2MPErRpij3hN6nV1QPjIpBAPV4=
X-Received: by 2002:a05:6214:3c8c:b0:6d4:d1c:47d with SMTP id 6a1803df08f44-6dd233171a2mr203952806d6.2.1735567592549;
        Mon, 30 Dec 2024 06:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH77jxsTRMTz1j7SVmCPzUC+ea33QNSEU2xCeoOd+ROJs9SrbfLMz9IWwQQ+fHWoMxGXdjy8A==
X-Received: by 2002:a05:6214:3c8c:b0:6d4:d1c:47d with SMTP id 6a1803df08f44-6dd233171a2mr203952456d6.2.1735567592148;
        Mon, 30 Dec 2024 06:06:32 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0160f8sm1477380366b.168.2024.12.30.06.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 06:06:30 -0800 (PST)
Message-ID: <ba764e00-2968-447f-99d1-5925e7782491@oss.qualcomm.com>
Date: Mon, 30 Dec 2024 15:06:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] thermal: qcom: Add support for MBG thermal
 monitoring
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-3-3249a4339b6e@quicinc.com>
 <cf2f2510-9d27-4473-bf50-45b14725f4c5@oss.qualcomm.com>
 <c5079172-e127-4dfc-826a-b32489d852f8@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c5079172-e127-4dfc-826a-b32489d852f8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v0xWMoJCH2EqQ3w8LWP-Kx-UXnY6Zf7X
X-Proofpoint-GUID: v0xWMoJCH2EqQ3w8LWP-Kx-UXnY6Zf7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412300122

On 30.12.2024 10:45 AM, Satya Priya Kakitapalli wrote:
> 
> On 12/13/2024 9:18 PM, Konrad Dybcio wrote:
>> On 12.12.2024 5:11 PM, Satya Priya Kakitapalli wrote:
>>> Add driver for the MBG thermal monitoring device. It monitors
>>> the die temperature, and when there is a level 1 upper threshold
>>> violation, it receives an interrupt over spmi. The driver reads
>>> the fault status register and notifies thermal accordingly.
>>>
>>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>> ---
>> [...]
>>
>>> +static const struct mbg_map_table map_table[] = {
>> Is this peripheral/pmic-specific?
> 
> 
> Yes, peripheral specific.

Okay, I asked a question that I don't recall what I meant by.

To be clear, is this table specific to all instances of MBG on
different kinds of PMIC7, or does it only apply to PM8775
specifically?

> 
>>> +    /* minT    vtemp0    tc */
>>> +    { -60000, 4337, 1967 },
>>> +    { -40000, 4731, 1964 },
>>> +    { -20000, 5124, 1957  },
>>> +    { 0,      5515, 1949 },
>>> +    { 20000,  5905, 1940 },
>>> +    { 40000,  6293, 1930 },
>>> +    { 60000,  6679, 1921 },
>>> +    { 80000,  7064, 1910 },
>>> +    { 100000, 7446, 1896 },
>>> +    { 120000, 7825, 1878 },
>>> +    { 140000, 8201, 1859 },
>>> +};

Konrad

