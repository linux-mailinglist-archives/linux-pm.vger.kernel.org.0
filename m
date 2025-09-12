Return-Path: <linux-pm+bounces-34540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1900EB5481D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81FA17B51B
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EAE27CCC4;
	Fri, 12 Sep 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frl1N9yB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9F27EC7C
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670118; cv=none; b=TfbE0hgP+u/GbmOpkACexBtag4IQCNw7BuO7TBAqssTkQnIJDSU3XTowH3VS6WLCaavKS7dIjLyWh6xHsom7AqbI0KzL6V3UjVXIqsoI6LR6mKpTsYe+WYpJIKB8pnA4NhiZtImCYEk4JxoKcsFpKRxgJkSdYXCMys98+Fzquyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670118; c=relaxed/simple;
	bh=aHZH4YS5dVoOj6kl4jXgDRDoWhg+l0J0dv5TXRxoBzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPBq+9387PsAGyeni6kJYzIh/Djsmd14CB2Li6EKhPWEJuG+OGACAsrMtC+955Ee0xzd+tf2vPylYcsBxmTYPq2HVcEzjWaXOg7HYzmeBKp1UUIbeY72aSCoUXDqG6LMUypzZROCivgdaYsjJwvl4TGIBqqIAggX/n5ecp2q8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frl1N9yB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fEoS001280
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 09:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ubdZE+2MGy4tFDpQKrzviatnp7P+PiPFBJ3kNogasGs=; b=frl1N9yBvDBrBz+g
	vYpk/y637iCILK5KDEzRuFB1WIT4wlp3iA7Ak3xcVXtckYYSF94Zme5MDaBuQXn2
	91njJBp2xEcqFGcBQUSHSCBnCBuYDkDiHbsoiQ8yGQmexU7bb7Ntfmp0WyCqOTE2
	uGBhM20XnimXZfWw4fPpeDIuzI/fN9Fzes9TkxsPQT4QCeCepqUAKEdHfQ9GoQe4
	yyubFKuDfYboEzIEUsyPMdiDwshIPMZ43ycg4ycI1BYoYRnv3T+sAr8dN6p5Ydok
	7pBYoiTgxjeMZhxFiYq4EkyTupvgEh5gDNuWZbvNu3+AaZD0zNVjIQzDOtn6lQYg
	w+PA8g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h627d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 09:41:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-819d2492a75so52205785a.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 02:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757670115; x=1758274915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubdZE+2MGy4tFDpQKrzviatnp7P+PiPFBJ3kNogasGs=;
        b=X5rLqYaHMuFgoQxwC5tNYOoUjgVWs1QUPU8Yc6/hP442XKCALYSSA27vz8s8AnXKhC
         AYwOvn0LbUdQm0gw9JYRJSk0PQ8Nf56n+pxgOwgk2SCyJiECD0OFmBe5puMeJVIsGiRg
         WdrfRk9OB5rvGQ86OclZek0RjXypMqw5ZIdadZsuqrLXH2zWvPC8lXZksH1bzJcFwga3
         h+WsUrt/YbukOQ3gPSpre0Qd8KmVqS4KTCUh/sRsZJ2kr2MGNI4JDZA+oYqW/hCbuzzz
         wZVTXHeme33QzRiEznt0dgS5lqIxZQZfSoIf7CnMzPwNHIAr0JdF82X/3Kp7bczC2emQ
         LHbw==
X-Forwarded-Encrypted: i=1; AJvYcCV7NOwkL3vwlGLtM56QYMnwCOlT9J/vYBKHv2gNsubeqYps2ZrKv/ZmY4GpJ77qMI5Qb/nERtvCYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7dP5h9zJa93bNOTkJtwln6bG3olQLGPqaeVnwkqGjUs3o5Jo
	CHbmeEdkfN2HyJeq2vGUYZZvln6mMvSJnuhzB1iYmJNTBuTNx2icm1Yk+fWV5TcYVw9colAMb1A
	IoQsqPS5nl2VmWMoEE0HfV2e7x8zLCMAzBLzwXCgbNk1nqxWWisEc3Qn+F59/FA==
X-Gm-Gg: ASbGncsSXEIFuTQ1o7nS1UhIlD+kRZfXF7NB60jWq1Vz0zCo17oNvi7zLzYA2je6n2y
	m2h7UHjiPZLGKD0glmbmtj/F2EGCta7kDqRfIJyQS4nxLj4UsnII5rympR4wA1K5/KwRtBObAxp
	52RBBkcrfr2/gQtwMXFMl62K0H2Kvgkdq5XQrAf9LbIx7A3PLR29XEMz0iI1UlW7MHLM+TCbd+Q
	ZG2RVivRrTwR3Cf2zadtv8KdVeY34t2257QvCHfOWLYyLBAMvxkFaUXIQthdl2gElHqpdrgSBpf
	9k+mufKkAxmT14SbihucHd3ARK7vUztYRVl3bj5dkHykCwwEkAd8F9bU5Qc7Dfh2p9KQyaj2pTb
	oDNWl9doVzn9ZwoSOJcEE6w==
X-Received: by 2002:a05:6214:f05:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-767c1c8fd01mr17754146d6.3.1757670114652;
        Fri, 12 Sep 2025 02:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW19WjSadyXUxnUE5X6AqSmTHftlhz5SicnK4cbK2PU6jUKPiXVwSAYDJJeeQH+UMau1p6vw==
X-Received: by 2002:a05:6214:f05:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-767c1c8fd01mr17753866d6.3.1757670114134;
        Fri, 12 Sep 2025 02:41:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62eed9aec1asm131613a12.3.2025.09.12.02.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:41:53 -0700 (PDT)
Message-ID: <0f9d55a4-83a1-48f6-aa19-e3117192bebb@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
 <2951b362-c3c1-4608-8534-4d25b089f927@oss.qualcomm.com>
 <52714c33-5bd7-4ca5-bf1d-c89318c77746@linaro.org>
 <d293a11b-155d-45d3-bafc-00c2f90e8c43@oss.qualcomm.com>
 <1cd6a0f9-2955-4189-8d1e-85fa8ad8dddd@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1cd6a0f9-2955-4189-8d1e-85fa8ad8dddd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AUrF67Vmpq1RUy6Nzsv8di58rnhFRcCE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfXwK6yys8MNVqo
 uTcPqFWP9oPlsvz+MshIyAKQq8LnHfG0INX5YP0Tv4U5KCSRJXGdwROZZdrAY9yu/eUhGbWvL2Y
 BRWt3bYXkeZpfZQH8VHxdpAeuTwtFhx7XQ+PgsmUMJH+ZoMuLeiIEiA9xQWuhineWlFXaOFaV3o
 LaPE7qz1qvqq2tpLrPnSi5WCx1uKDIrSU3lQ1wBBQ/1g+qzVZVB7CwF5pTZ+v04kkhk+XUaaA7z
 BSlP48vOroR/4OC+KfVnwm5ZnS0Gw7f3jRhYgthpu8J9Zzb/2WpioAcb2QHPercXFYQUR8e/YFA
 rypexr/tEFDUcvoNvnrbaXHmmVeu+r/uRy8D3IWVGqlAZqaa90uH2oEEbkFXZl7ech1N+AzGFn9
 NggKfWGY
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c3eae4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=r2WM0BnHFFIPBb0dDCkA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: AUrF67Vmpq1RUy6Nzsv8di58rnhFRcCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On 9/12/25 11:27 AM, Krzysztof Kozlowski wrote:
> On 12/09/2025 11:21, Konrad Dybcio wrote:
>> On 9/12/25 11:17 AM, Krzysztof Kozlowski wrote:
>>> On 12/09/2025 11:13, Konrad Dybcio wrote:
>>>> On 9/12/25 11:13 AM, Konrad Dybcio wrote:
>>>>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>>>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>>>>> provider and an interconnect provider. The #interconnect-cells property
>>>>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>>>>> the NSS ICC provider.
>>>>>>>
>>>>>>> Although this property is already present in the NSS CC node of the DTS
>>>>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>>>>> omitted from the list of required properties in the bindings documentation.
>>>>>>> Adding this as a required property is not expected to break the ABI for
>>>>>>> currently supported SoC.
>>>>>>>
>>>>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>>>>> binding requirements for interconnect providers.
>>>>>>
>>>>>> DT bindings do not require interconnect-cells, so that's not a correct
>>>>>> reason. Drop them from required properties.
>>>>>
>>>>> "Mark #interconnect-cells as required to allow consuming the provided
>>>>> interconnect endpoints"?
>>>>
>>>> "which are in turn necessary for the SoC to function"
>>>
>>> If this never worked and code was buggy, never booted, was sent
>>> incomplete and in junk state, then sure. Say like that. :)
>>>
>>> But I have a feeling code was working okayish...
>>
>> If Linux is unaware of resources, it can't turn them off/on, so it was
>> only working courtesy of the previous boot stages messing with them.
> 
> 
> Which is fine and present in all other cases/drivers/devices. Entire
> Linux in many places relies on bootloader and that is not a "work by
> coincidence".
> 
> Another thing is if you keep backwards compatibility in the driver but
> want to enforce DTS to care about these resources, but that is not
> explained here, I think.

I don't feel like arguing axiology today ;) But I see your point and I
won't object to either outcome, so long as the property is *allowed*

As a sidenote the IPQ SoCs have a rather thin layer of fw

Konrad

