Return-Path: <linux-pm+bounces-37240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BDC275DB
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 03:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6845189B2B0
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B9253B66;
	Sat,  1 Nov 2025 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llT2g3WP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kL8uqpnX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90757082A
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963647; cv=none; b=l4iHYdTibU+x1gLntuWPUfVNbX0rgtWTKoUC4KelmEFM4TBUpCcrIQgSdw3pJcfO6pNJ0drRxWnJxmSEJOMfMsXSuOmzGZjNgcHMnl+CwgfW3F5NCcBnW34kBTwTJTvHwctuO+oSsZZR5JQM8SPs/XqU4ywXJTxxiYZs8fGovCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963647; c=relaxed/simple;
	bh=jf9nuEo/WZwv0Yv47DYo7uzLK5W5wJ2W9WpUgSib3Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBlSGc9xkHctbtK0qT6MbhbkrrtX+cKYgvVCLmJT0PvpHKr0tTSWtXiRsCAiZubSRvf+on5CIvc3prRKlOLqKkoCsGyDdj/cwBQidVAjrNGW/fsFp2inJXKuvgOESN+bsFofRMcQ7n59saU4IZa2l9muo9+btD7qF9CRnbd74c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llT2g3WP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kL8uqpnX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A1298wE313249
	for <linux-pm@vger.kernel.org>; Sat, 1 Nov 2025 02:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZvfEZK/lcMq9/a9VxgZ2s25HZusbbZGiu+j3EGbryv0=; b=llT2g3WPAh7zbrBa
	ecjQiRralvIf1qIJQkH2gcGrd4XFXPSveAf4MDNz/vpHU4O7CZJwEqLPbYNC3/qI
	t2LNUmSyiq37Nd2svsYEWpv+XIzoD73RiscEjtc3YFa6eMaCsIWz4/pHDkSi+38m
	fQ36fQquW3B6NB2ci1WH1lXhayJT2GYXz6ETOcz67xY7pKrxvLyiLfs1azSGRa8D
	COeEyIaFG0xCceJMlF2lgV5VjraZVJxgPfqmVtceaSV3yBLVZu2wXBuurI6q8zWo
	9qM9PAovpjjmU8NcbqHVZqSf+VHKr4avw7uMWPAc+hYzPVggTfL8L18tpVBCTPZ0
	IOaNIQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a595rr0ee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 01 Nov 2025 02:20:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3407734d98bso2209367a91.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 19:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761963636; x=1762568436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvfEZK/lcMq9/a9VxgZ2s25HZusbbZGiu+j3EGbryv0=;
        b=kL8uqpnXWdX/mxm4441fFb1geJDjWHxUHO9n+egEBSNirEjICurxgSCBrY6eMDsn2g
         Y0FcG5rrojCx+QenEEnrWfYFdYpbkkSp9T/H4dgL8y920NPR/HTaJ6FFxK0VAoRF/jRd
         gdFZQMT4GIltyqzCa/vp/WlKNwNWXsQH3FhrEH8S/6eN6AkC6r1RDuVsBcfW/I3x+Urn
         X7Wd9TtfDtKvnOHKhr0qKsrQ+9bFXMrHAhOj1VtSvnSEmee+c/f8pcYGvj5exeZArN5d
         rWC2rcp7eNgwwfNoLOufWVN7Js1HOs44T/E7kDo1KVvHcPuql2e2Keu0JeTSTRf4E2Gn
         keIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761963636; x=1762568436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvfEZK/lcMq9/a9VxgZ2s25HZusbbZGiu+j3EGbryv0=;
        b=Ayyo322VJaXYayi538aiH5JYX0BTJ8rG/7PELCdqpUKyvYoPuQ4roNmWhDSnGB4tq6
         s24i07crd0Os7uxKQHU66rUvnaKhnPMNxLWX0quV8V7/r59FhrcI8vcEsminEWMMCEmr
         1Rrm5QUZnthiRGNGqOoS7M9+c4otaktlHx6YSGWKmORtsM4VrlfRjif2Tv9CZ3FO4VN+
         jSWBh+c9bFD273ZZj8IPrNR6R9fdSsJBKG7ztjJJrxSrOLPx6l1bk37gAjouDZ+7jMDH
         YoQw3Rl2VUIysoKpc31u5OjgNKo7Eb1U0kdSCc5K0h0e0BfOJnh0qEqclcX4MVB7pR9T
         530w==
X-Forwarded-Encrypted: i=1; AJvYcCWtuBBBjDMd1l7mQ7KuIBVdcjLbfDhazlrOq1g9A0s7OqcrtuJMkVirUHDwgsVn4MKIanRo1t8BRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjHwPg5NIZVlNQXJtUX7fkj91ztmNp6YY3TZEchvcMMyALY23
	tzZCCQ4u27lur5gv1Mczw6i/f+z6IoEQpQdvBpnS5jsoQ9YIeGRNKGd5RGmQlAgBjE1FMWApRf5
	hrenDbrIew0QaqbudnAagH0yAIEC4nF0gWstYZB6Vu4GedcXq9+nPFTPO+EtOpQ==
X-Gm-Gg: ASbGncuwvkQeNfjcANuirHM5gx6liXA4mJRqZwSLIF/RUXWczFI9HBRSvBf4MoYTSCU
	htKO96l+4s050ZUrCQkJpVH7JaVaaiOHhfRZamrUXWLfdoP0UX9XaDj2RJfoaQJgBtQ+J4KtK2A
	FKhiLKKwXZl535d3NM6GRzitl+4nKeIYpHvyZEQKehyrdNeKO4syerUfXsq18mrYlIPM+8nOzGA
	N4BtbfC4AbVCAhhbtoPURUFRn5FgveAasaZFv/9cQgP8MbTrJbDMqhUyEpVTg/WBtYLz3ok7w6Q
	RiyhzwVV67TyDdkMJtODx/BYkR6bzDBBOSFsGT2u+OF0yu2GLCw90LvEOSijdM18x6y123hOUBO
	sTvsVRwbD0GUHcasEgC2cC10ijuIB
X-Received: by 2002:a17:90b:4f86:b0:32d:e75a:5009 with SMTP id 98e67ed59e1d1-34082fc40f5mr6185252a91.1.1761963635902;
        Fri, 31 Oct 2025 19:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmrUTOAVQUC5qvFh43h8kZ9c7nnsaSwK0Esi4Ukjz3kmt1bDnV0nhclIVnDDy9QDV0qq28SQ==
X-Received: by 2002:a17:90b:4f86:b0:32d:e75a:5009 with SMTP id 98e67ed59e1d1-34082fc40f5mr6185208a91.1.1761963635296;
        Fri, 31 Oct 2025 19:20:35 -0700 (PDT)
Received: from [10.216.5.37] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050bb7a29sm7309498a91.21.2025.10.31.19.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 19:20:34 -0700 (PDT)
Message-ID: <d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com>
Date: Sat, 1 Nov 2025 07:50:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
 <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
 <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
 <20250927144757.4d36d5c8@jic23-huawei>
 <a3158843-dfac-4adc-838a-35bb4b0cbea4@oss.qualcomm.com>
 <CAGE=qrrCvq28pr9Y7it-CGMW=szKUnU+XBj1TmpoUwuASM05ig@mail.gmail.com>
 <31bd08ce-823a-4a71-baca-a9d1e02fcb6a@oss.qualcomm.com>
 <08eb477f-ea34-4a31-b181-bfc629aef4c8@kernel.org>
 <68a9b8e8-bdf4-430f-baef-6a293ccea78d@oss.qualcomm.com>
 <d8a78b7c-e3a9-44b5-986d-8ac32f328eb6@kernel.org>
 <3a32746a-5b0e-4c0a-8322-00cd3a84394a@oss.qualcomm.com>
 <4979bd26-0a77-4390-9db2-6d40cd7f963c@kernel.org>
 <c4b2c474-c6d0-4b1d-bcc3-a3fddea699c7@oss.qualcomm.com>
 <d7627a5d-893a-4bc3-8b67-c151ee0bea32@kernel.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <d7627a5d-893a-4bc3-8b67-c151ee0bea32@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uy9loDUzQZjF9rEGo4NjUnLthKPFSL9P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX6JF12WtCQ3fs
 9bX8Y4EmB6w3WjdgxCSmEjOpquwvDlPxzI053MpV6mGonsgT2YGOAdabtWKD3yCsa4/lAjvbCYU
 y63UAIWmeFqfIMVEgE8g39qMLdUS+uCGYuCjbNTFJnJWxFBBlBOcI0IdvoqBG5wpYQSSq21gIXQ
 O76YG0BM9E70ibFHZE+yoPExQdbGNaIg9JU6+9Y7vDGTIioOozSUFxwPr4FPe5bNiwnMx5ZoC+t
 hwBsh3YqNrlSvURYYO6W3UAf3LrWOn2MdJcKjOqiy2E+sRt3ACrfaNsXIofWqmcD1WIWQ2xzPBR
 3bL76PXMQ3Xv6UKvBbWHlCEDcuJs3qkYoeypdToxzNrKk4ofMTkRkvPxx8r4cPSrb9RLAYGfpj/
 WwgzHucTGdj4DFLSm7VMevnd7o0NRw==
X-Proofpoint-ORIG-GUID: uy9loDUzQZjF9rEGo4NjUnLthKPFSL9P
X-Authority-Analysis: v=2.4 cv=XYeEDY55 c=1 sm=1 tr=0 ts=69056e77 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=X18Rc80VOUBE94RK4nMA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010018

Hi Krzysztof,

On 10/27/2025 10:00 PM, Krzysztof Kozlowski wrote:
> On 22/10/2025 13:02, Konrad Dybcio wrote:
>>>>>>>>
>>>>>>>> On 10/4/2025 12:22 PM, Krzysztof Kozlowski wrote:
>>>>>>>>> On Sat, 4 Oct 2025 at 11:42, Jishnu Prakash
>>>>>>>>> <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Jonathan,
>>>>>>>>>>
>>>>>>>>>> On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
>>>>>>>>>>> On Fri, 19 Sep 2025 20:17:43 +0530
>>>>>>>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>
>>>> [...]
>>>>
>>>>>> Can you please provide your suggestions on changes we can make
>>>>>> in the above points ?
>>>>>
>>>>> You just pasted DT. I asked about SW, software. Please read carefully
>>>>> previous comments.
>>>>
>>>> Is the problem that Jishnu included some indices in dt-bindings without
>>>> also adding them in the driver's adc5_gen3_chans_pmic[] array?
>>>>
>>>> As in, would the resolution to this thread be simply handling all of
>>>> them in the driver correctly?
>>>
>>> The solution is to remove them from the bindings, just like we do with
>>> many other hardware constants. Of course if these are not hardware
>>> constants, but part of ABI, then solution would be different but no one
>>> provided proof or argument that this is any binding. All proofs were
>>> "but I want to use it in my DTS", which proofs nothing. Not a binding.
>>>
>>> While this issue is not that important, we keep discussing it because
>>> author does not try to understand the problem or even keep up the
>>> discussion. Instead repeats the same without really reading my
>>> messages... and then disappears for month or more.
>>
>> In Bulgaria, people shake their heads left to right to say "yes", and
>> up&down to say "no" (or so I've heard).. I feel like we're having a
>> similar situation here..
>>
>> I'll try to make a case for keeping these defines in some form.
>> Here's hopefully all the related aspects, condensed down:
>>
>> 1. In a multi-PMIC setup, only the main PMIC's ADC is accessible by the OS.
>>    It then mediates accesses to secondary PMICs' ADCs through internal
>>    mechanisms, which requires the SID of the target to be retrieved and written
>>    to a register, along with the physical index of the desired channel to be
>>    measured (see patch 3/5 commit msg).
> 
> 
> SID is still a hardware value, right? Combination of two hardware values
> is still a hardware value, not a software ABI construct. Even if you
> claim only the driver can decode it. These are still the hardware values.
> 
> If you had two IIO cells - one for SID and one for ADC channel - would
> you claim they are both needed for software? Probably not.
> 
> io-channels = <&pm8550_adc SID_whatever CHANNEL_XYZ>
> 
> It's basically the same as some pin muxes, like NXP:
> git grep MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4
> 
> Complex value, which driver parses. Is it SW construct? No. These are
> register values.
> 
> 
>>
>> 2. The PMIC SIDs are fixed per board and are the values of PMIC top-level
>>    nodes' reg property (since forever)
>>
>> 3. The channel indices are fixed in HW, but this patchset proposed to reuse
>>    them for logical mappings consumed through io-channels = <> as well (because
>>    of 1.), with the drivers taking the lower 8 bits that of reg/io-channels[1]
>>    value as the ADC channel id and the higher 8 bits as the SID (this is the
>>    define macros with an argument)
>>
>> 4. Fixing 3. in a "simply define all possible options and bind them to
>>    consecutive integers" fashion would require a huge table matching 0..n to
>>    [0-max_sid][0-max_chan] which is unreasonable
> 
> I do not insist on fixing anything or changing the interface. I only
> question their necessity to be a binding.
> 
>>
>> The alternative to the SID packing would be to reference the target PMIC
>> somehow, be it by referencing the PMIC itself:
>>
>> io-channels = <&pm8550_adc &pmr735a CHANNEL_XYZ>
>>
>> or by creating a faux node for the actual inaccessible ADC onboard each of
>> the PMICs:
>>
>> io-channels = <&pm8550_adc &pmr735a_adc CHANNEL_XYZ>
>>
>> and have the OS retrieve the SID from the DT node & encode that value instead
>> of hardcoding it in the DT, leaving just the actual channel IDs in dt-bindings.
>>
>>
>> The define macros without an argument do specify physical channel indices, but
>> we do need some sort of an identifier to put into io-channels (which is why this
>> lives in dt-bindings in the first place), and a 1:1 mapping to the physical id
>> sounds like a good option.
>>
>>
>> I don't think anyone objects to any of these resolutions, so long as they
>> are acceptable from your side
> 
> You can go these ways, but I never proposed to change the interface.
> Just don't store these as bindings, so they don't have to be treated as
> ABI, because they are not. They do not constitute the contract between
> software (driver) and DTS. Treat them the same as we treat all hardware
> constants - directly encoded or moved to DTS headers (which we did for
> many of such cases already - see commit
> 9d9292576810d0b36897718c24dfbc1a2835314b 3 years ago and other)
> 

Thanks for your explanation and the above suggestion and example,
it's clear now. I'll move the macros we need into a DTS header file.


Also to Lee/Rob/Jonathan, as you had given your Acked-by tags on
patch 1 - based on the discussion in this thread, I think it's
also best to update patch 1 similarly now, to move the ADC channel macros
from the include/dt-bindings/iio folder to the arch/arm(64)/boot/dts/qcom
folders. I'll make this update in the next version, please have a look
at it too.

Thanks,
Jishnu

> Best regards,
> Krzysztof


