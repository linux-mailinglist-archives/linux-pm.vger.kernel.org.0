Return-Path: <linux-pm+bounces-37941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E179C57157
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E9FE354916
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6233892F;
	Thu, 13 Nov 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjbrXA50";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TQUbJ9x4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778E3396F0
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031650; cv=none; b=CfnnUXM9++rmW15iBYEso1srk2GLW3XOtkF+G6wn8hQohFS8JGM64uQGl9Qg2d4SXUU0aMw1URnW93i0Gmu7VJrrWUZtvWjdE8RufUAJGFaaaQeK6mv8C97s6D6kOkhXuZ9Ty1j2YTkKYilfd75X6oKP3mEnHfLEmOWmJbojKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031650; c=relaxed/simple;
	bh=m5MeXEG3jZ6w84sxyLlnVWrLy9Qi9HUWIDgjc4XX0dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/YSY9pwXOWZahCXmWc5A0wowLUPiT1vokGh/fp2bhmM4QtId4rH5nSD/Zxk88wjYo6rX1hTPGtI94q8NrDKCMye1pXthik8WU5sUtFA9nTDRyJ16jKZo7VKKNFHAaQW+J50XScRjiFCS++lgmqwhMps0i8ijrN1X+7QudDTqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjbrXA50; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TQUbJ9x4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8w15K3035353
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dctm8dTwaNPV9EO1BqVmXYSJCSP7ANhI7WYmBi6vq2c=; b=RjbrXA50z6h7NNvg
	jOCNuSSFppBjleq/dMjJ6ijGPRgNDSWUbjMfByueEa18RzFDKdyhNbzY/l8qkkVE
	FBTEl0I/4TMpsiCyaAdwDROO+BLSNJOU8EQCmDotWjsW/jepZRq2C48sRc0Ph3wT
	ChkTBLlZL+/Yglk1uQTJoSIo9jDXEYRql3QF1INXtKAgMEziQkGwu8jMOHtDkT7t
	X8KB2KJcTGh3QEGxFF1taxqg2LlrxDvSUh3z9livUcPjBfFsRnfGItETb/9SZe3q
	LzlI0P8HJsuMFvHcrHT7Haf6kE8oLJXRj9sT7me/jpaNyATHWUOd1XFbFpqUTCdg
	6Vo0pQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad4ju9tr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:00:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b196719e0fso22723085a.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 03:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763031647; x=1763636447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dctm8dTwaNPV9EO1BqVmXYSJCSP7ANhI7WYmBi6vq2c=;
        b=TQUbJ9x4yT/KgkMH8gZ9QTwq5GswlIpdu5NB9mhhZ0qka+rbcd2DhGGyB3UV1ZIiWE
         DsyO9Wjdx2z1MpOeZIsOcOi/mebqLKIwJZxPYOeHYS0nQ0C1xKnutSe2iJcSN0zFZBl+
         yPaWIq4XF4uG67piEMzdHPGNs77ppLaAmcMSFkTT/D7HAnLJEs22phAwxu9BwluYqvYo
         YWSOlgbPJEHwHVag5izD1W36THoOMoWTxO+rfDPyaB/zvRHQHv6n5W/GUAQuIqfQbtuT
         2+r5ntQgwXyZlHrtbN7wpUvHqLVlRaJQAAVZ62j/ncQ9Lt8ETOSTUIbZwL2lSM/jhMDi
         quQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031647; x=1763636447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dctm8dTwaNPV9EO1BqVmXYSJCSP7ANhI7WYmBi6vq2c=;
        b=R+FpaHsVVnqAHSFU9pWq1dn8Glrs6EYeZ+ECA/DGcUK/ok8d4+UisnMRnd83UK2eOf
         axS4aza8pS81AvLwi+tyYeqNq4pZhru8Ww6Izwx4irBgwaCeY9HclszT5JrShyKYzvTQ
         7C8kDH5mzHd56ZNevr5dNBZn9RAJpAqcyLTCkeyX3HKpfTUvA0NBuL12rSH+SrfXJ5Ku
         BdEWmwDQXFnhIrCUiAj/mLHBUeIFPz/YyTBODNortlch27hgBVASfwmJ/2LzwkAMY4hh
         0hU+yEb/XzmqF53c9Y4q29iVhDDzt53ueqy2K5z/t5RqJYQEnKilDjb4lX+PNxs3QInk
         vFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU29yCg06A7A/dtW4xonpVfyFQ1+glQLkkYddpNOEuunYoqe/UTNZ/bEWOiS4SmUbO11e9LopZoIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvL/Dl1oMqq8HVc6KAQKFbvj1xmIPpJ4cNVAiskmDz1WDpeH/
	vd2ME2uluzAVFwvty38aujKqbGiKpkh7nnVPRB8ZonGcLaAinWvWtACEjfMY8J7vTK4wOHQ8xpw
	Z9R29vJ59kJqbbv8lT04fJMGCgFhgJVhG35lk74bPB5aDDUnCKfAUhmlSE9NVQw==
X-Gm-Gg: ASbGncvWUONb7aKEP2x18i29wmsDmyVrJALUwUWUUt3DgLJ2Fq28FT4EM/QnroUap/+
	j7VbiJkcSm5nSnZgcOkyDhdaPgksYsCnxsMVFhK23kw4DWV9pC+9UBfzE5ustCqsBSmt0UJXgyC
	oPynUPyYekiLxIDKZ/FNuYWxPQdziw1Udwz3fbewjoopAMZlLZVZx1MxD8lNWGqJe2J6DzWm57s
	kobkz/KS81jWTAvl53/AsLgoDzh//H+ZXgnb6WZXjkuPey/DPdatnml8BbphDk2KaSdUJUV2rw0
	oTQL6J7ipJtOUxBBGBEI1peGSMXlPSl0dydR89zH7VXAORe0AGyR6DERl2Bn0UPnSN/pp5X+Urc
	6jDUYYbMKrCk4rBppUqycUw+neudw2Gnz3H+Jc5wCtbt4DU3WNv9BRuf8
X-Received: by 2002:a05:622a:1a18:b0:4ed:afb4:5e30 with SMTP id d75a77b69052e-4ede794dc16mr20378501cf.11.1763031645535;
        Thu, 13 Nov 2025 03:00:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlVsSXjGAfEYJjZnev0pvnXR+ZCVmOPqmdnlNGvxTXW2vNS2YbvXEmH1mcjxmr+DTcdG+UNw==
X-Received: by 2002:a05:622a:1a18:b0:4ed:afb4:5e30 with SMTP id d75a77b69052e-4ede794dc16mr20376831cf.11.1763031643184;
        Thu, 13 Nov 2025 03:00:43 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734ff75e4fsm137001066b.12.2025.11.13.03.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 03:00:42 -0800 (PST)
Message-ID: <fcb093e3-05e6-4e77-9150-25f9a76f8937@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 12:00:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
To: Bjorn Andersson <andersson@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
 <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
 <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com>
 <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>
 <sdhnchve6r5i4frhlx5q7lod5npzosbfdjjyd56l2z5ksoe4t4@lhm6d2pzsztm>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <sdhnchve6r5i4frhlx5q7lod5npzosbfdjjyd56l2z5ksoe4t4@lhm6d2pzsztm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oCnDxRF2axyoSIzSZZpS3SGdmZK2Yo4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4MSBTYWx0ZWRfX2pXVXPBKYgZr
 HEaPvFNdGsizWOSbUR9FEBv9uhLG8V3MGkH0Q2PGHUVkylntzXPVJIATxymoKMCwrwiCNSs4S8A
 Sig7uNRjaDuPI3KEi5g0Y3/OTTzpGPGz8Bv10vSf25e3S0brBErsHdlf3Zsxzlwvurlrs7daD1G
 Yl2aA0QpGFthJzN2XyaxE9XpHxh+R1EdDNyRzi1z6/fMsplfWXuo7D+zQ+ekZWpaSbjIQlIlZ5S
 /x4oR7rgTfRzE68Zu3nPSR0LIsuiujE0J/irZ93VG6wy82w9SAMHkBPMQbk2vz00TP9278MLrTL
 AtWp0a268H7aEnjh6EPJe1wOORZFpNZcxma5njo9v1iKmKI6E1j8+OfHH/q6672Sms1V0310iOv
 cHM6A1KCw42JfD18XBqHiGiNGqS1kQ==
X-Authority-Analysis: v=2.4 cv=BdnVE7t2 c=1 sm=1 tr=0 ts=6915ba60 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=hsPK79fdjXi5lFZ4yDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: oCnDxRF2axyoSIzSZZpS3SGdmZK2Yo4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130081

On 11/12/25 5:36 PM, Bjorn Andersson wrote:
> On Wed, Nov 05, 2025 at 10:44:05AM +0100, Konrad Dybcio wrote:
>> On 11/4/25 10:19 PM, Loic Poulain wrote:
>>> On Tue, Nov 4, 2025 at 3:12 AM Bjorn Andersson <andersson@kernel.org> wrote:
>>>>
>>>> On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
>>>>> SCM can be used to support reboot mode such as Emergency Recovery Mode.
>>>>
>>>> "such as"? Do we have any other useful bits in here?
>>>
>>>  I heard we may have different EDL modes supported like USB or SD
>>> based EDL, but I don't know much about the details.
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>> index b913192219e4..c8bb7dacd900 100644
>>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>> @@ -121,6 +121,10 @@ properties:
>>>>>            - description: offset of the download mode control register
>>>>>      description: TCSR hardware block
>>>>>
>>>>> +patternProperties:
>>>>> +  "^mode-.*$":
>>>>
>>>> I'd only ever expect mode-edl = <1>. Do we have additional modes that
>>>> warrant the generic nature of this?
>>>
>>> We may extend this to mode-ramdump if it makes sense, but as of now
>>> it's indeed only edl, will fix it.
>>
>> Would adding ramdump here be a matter of:
>>
>> + mode-ramdump = <0xmagic>
>>
>> ?
>>
>> If so, please add it too
>>
> 
> But what does that mean? "Hey computer, perform a graceful shutdown and
> when you're done, give me a ramdump"?

I.. guess?

Perhaps it could be useful for registering a panic handler to reboot
into ramdump in case that's not enabled by deafult (but is that
possible with our fw?)

Konrad

