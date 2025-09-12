Return-Path: <linux-pm+bounces-34536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D5B5476D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0107BF242
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB402D1913;
	Fri, 12 Sep 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="psmAV4uh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAE2D0C84
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668923; cv=none; b=biMmgxEDUWvipJ8ZHsNKRYukfqNqv+X4IS2VU1jEkqhKJsY1osArQ+D68rbnX83AXFe8NTmCVhdMZcU+ef5RQAYLG+aJgj7BjQXy657lMddPh6KYybINcgqr2k9ptW84vjFX4zbk8OFfqEoCsnbgXmcVhWbSh+tWtUdKhXLN5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668923; c=relaxed/simple;
	bh=A1c0vcXgcruE0vFqM/raPLs69yF0uaISuMGxTvyDAyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntvzNWVRL/dKyCZFQJsPhYa/6ejw2RqITUz33a0vdI27T+wjXIGZ1Hu0Kb6+dk1n+h68YNZ/UvleZ4CibG+Tp4cskp0dJCGQT/NQic7g9doUGhCs01qZ0LA2ktO1wXfRlxSdxgvG6QLjS7KAzUCyGM8qRyI9li02Vaxocfc21Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=psmAV4uh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7MS5P005772
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 09:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	211TaafuVdmwmFpTWX2T7r+JSbXlFt0Mtw+hMPa5lqU=; b=psmAV4uhJDui1mD2
	TpCjvU8MQQJRkxDuw3yqKkng4nptAa5x/7xUSHj6EX1X6oUbpT8FF28zsrmre7yu
	6p/Fp2rav/iYRUYCqDi++eNdmU0cYLSY3LSWJ+tX3FS0MmKDSL8p4IePtThsrg/z
	Ac7+4k4XpROaSNMzt9ybKtn3X8B783KyfS5kAUKtMZPEDpMpPdotPDoiRuFREgPa
	pg9//ykOut1X5Rjq7PwNqZFRjrYipChc66NfW+GoX/UZm+8We35j13Jt+hH62Gtl
	F6u0m5V5mD8j29L+7+62Pb1B5wvt2owSxXuoK0JQQiSo9icMMzJ7VUQ0QyT0iZD5
	YEREwA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2f284-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 09:22:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5eb710c8eso4543941cf.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 02:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668919; x=1758273719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=211TaafuVdmwmFpTWX2T7r+JSbXlFt0Mtw+hMPa5lqU=;
        b=ot1qifB202MdXnlzzO9+OrFr44IXY1jIouEgiyDuyw8TczqKGI614uXMvvRLsET4vf
         i7uyyHdQpmb9xf+4Tg78jKliQhWU4BYi75EfYozYuC5rydiRbmgmDHvFPbwcBcO0W239
         3nWWXjCJOgsTReAdqIkN01aAqiAqECE9mvR8veLwDLWs/eUwp1bMHEiJHHQAAJEK0aIV
         WatXoN7Rn8TvKoG/ApPndK6xPV9PK/gBmm2ToZYI/skVeEEwvHWq0C7KfKnuVs+1UFqD
         6+bskqVBtn7sR/VePDk1PCdtCWs0zz47Hn2hbBMdy1zL19/DstkCNyyFsUcBxSCrF0lc
         9gPA==
X-Forwarded-Encrypted: i=1; AJvYcCUSDGczfkIq8QOEm6Fi/4D+zyvF9TPiF+F51RWxdMyUJFGXKplutOOT31jWqJP865yxwJR+uiEjDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6v23ND3wtbrhnLe3dkF4iESyFcG10yURWotu6UCiaAPVlwenB
	rWWOtMMqM1PXIaQYgOZDpzUnV5YUBKGm6MB3R5eR2Ci6itm6MiacpgRDCocWiJGc1r9GfjdBSGn
	MWZHr+lEMQPCwH33PXZuPWl0BAZgtSeqMm/vQt1AdDKwACivWKHQpM45apagtHA==
X-Gm-Gg: ASbGncuWDVDbxCFchbD4PCMbdjGjVPVHq4qTbrlWJ1kb6B3Pa/bbQxibLm8QRE/y0oW
	smIwyQ9A8FK9oZ0HjgkWxADy5CzZJOKvkXlgUCE8kOplHPabo6ygPHfYkIHAFLYJqTs0J7iT32j
	0Rb8GZfEwcKBKiAbPSHxdquLSfI1A5Efr49goNZkkQN6hdjfnnohv1Bk8mlgd0W6wGp8f4ghdMs
	za95vDOvRylopQJnRUtcGuENb0caO2AThyCvkBr8JgntX8OhEK/2yIjNeL70Mw2yd8nlxCfgqXm
	aUO4VxWjmv+Nrdy5bP0GaEfWn+95JJBRuzc0eJZXtYkzPQpSrpTVkR0h3PU94ZikINrO5P/SF1g
	CF+d8k0NMXcw5IAz6slK5qg==
X-Received: by 2002:a05:622a:91:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b77cfcdec6mr20253811cf.2.1757668919101;
        Fri, 12 Sep 2025 02:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt3j5cbbw2xXdC7Iuoclxovs03WKjCh8mVblR4EhINwYFg0atoGoM3n750wMhgvxAjL7lHSQ==
X-Received: by 2002:a05:622a:91:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b77cfcdec6mr20253621cf.2.1757668918594;
        Fri, 12 Sep 2025 02:21:58 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2098sm337290866b.74.2025.09.12.02.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:21:58 -0700 (PDT)
Message-ID: <d293a11b-155d-45d3-bafc-00c2f90e8c43@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:21:55 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <52714c33-5bd7-4ca5-bf1d-c89318c77746@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c3e638 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=UDPjpuflI1CVcGcpNKsA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: -jF0kxppnoj9r5JREhdCTZk9xPntSd77
X-Proofpoint-GUID: -jF0kxppnoj9r5JREhdCTZk9xPntSd77
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX0I66bgPQj2q3
 K5vqOXfkoEWajdHYvOH/nY5BHrQfJpH/1Hj2VOJ4RIsbqd9Nhn4tNVaSqAXR4X1fGkM5KaBUt9t
 YEqlg4IwS6vDEbueZOrKEUgs98uF/DPy+c4mt4lHBzPYzKJVY93+zt0Kff6ulPQrRyuFLUZ6dTP
 lmdu8vbsiDA8buF5/AlgTPmfWlwR8qNJaMlkUax+drcJScXPF1GMOayoZb2vxfx3JCS8MmlcvWr
 OvyU7zVGvQb7TJhBGSn0O866f6Aw2EAjnd+CcRkgF90aCSA24uW0iv3K+7SjHBVF3II7XOAwsri
 rQAoapLJN/Zv5pLm4cLwd0cjy6HXevUg6QmXEMQjKQKS3JcJ/io+c3ziaEm+xS7214arIlMuWV3
 fbmRfN9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

On 9/12/25 11:17 AM, Krzysztof Kozlowski wrote:
> On 12/09/2025 11:13, Konrad Dybcio wrote:
>> On 9/12/25 11:13 AM, Konrad Dybcio wrote:
>>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>>> provider and an interconnect provider. The #interconnect-cells property
>>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>>> the NSS ICC provider.
>>>>>
>>>>> Although this property is already present in the NSS CC node of the DTS
>>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>>> omitted from the list of required properties in the bindings documentation.
>>>>> Adding this as a required property is not expected to break the ABI for
>>>>> currently supported SoC.
>>>>>
>>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>>> binding requirements for interconnect providers.
>>>>
>>>> DT bindings do not require interconnect-cells, so that's not a correct
>>>> reason. Drop them from required properties.
>>>
>>> "Mark #interconnect-cells as required to allow consuming the provided
>>> interconnect endpoints"?
>>
>> "which are in turn necessary for the SoC to function"
> 
> If this never worked and code was buggy, never booted, was sent
> incomplete and in junk state, then sure. Say like that. :)
> 
> But I have a feeling code was working okayish...

If Linux is unaware of resources, it can't turn them off/on, so it was
only working courtesy of the previous boot stages messing with them.

Konrad

