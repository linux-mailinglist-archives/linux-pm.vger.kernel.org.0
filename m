Return-Path: <linux-pm+bounces-37501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D991C39FAE
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239204248BD
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5633330F526;
	Thu,  6 Nov 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNlZMLsb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IhbnKY5Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52430C634
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422670; cv=none; b=IWN1Pv6AeUeb7MCgvIToz2niZGj9VKqz8fHLXhay3J0tGMb75nEpFgLqp5XVr3xSHWgq13lTN3RHZ+Tt+5XtbxR5Uy+UEEvvIr/FSwhIFZ00hlHHQ8qwo0niCAMjjT+y3BmKtqNBWliEb7OFuxohMvGATk8RpxLbVDxO0+aiXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422670; c=relaxed/simple;
	bh=nXSRMf9/aZ7Q9VqSPsWiKmuE1hBg/kBZqOFH3xssUmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbJCO2y2VeZqmmd/lBRKNJPdo7lE1SRtRpeTgkptD1dlZbEoaDlCbKWScZzkg+7v2Gj5KtUaK4hekh670TVApa6f3HqZ6xds5Iba7GGud9dntnNR+6bxND5xpCAPdxuCZdHzhFn9RMsmiTnaTzBByO1RA51lnvoUML90KXnqkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TNlZMLsb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IhbnKY5Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68l3k82389024
	for <linux-pm@vger.kernel.org>; Thu, 6 Nov 2025 09:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tZsRCzXp9F2PQY4ggZIqyN7UEW8FExIqJdOsCcIvnqU=; b=TNlZMLsbj7CDm8hw
	biToZd0J9wQhXAyeUjAmL/EB4ts6sHqw54l1TTgkCeIWG1YDdcPAXRDZuPbb5Aac
	7v7dBAklyq36/LWH7D+pho6m7X7TOnYDrEYKmetg57G8akLonrVw2LN8WctArYIY
	doZI5SvBHzgIXCSQJbVmUI7d+0gv00jrqKbnuef4qIM1xjaI+hCjDiE/NNLQHAdg
	gj1ZpebOTriQfd4AKZqMt6CVHtPEOFZwpbCcnjH0zWbzSmqs9R4GqxU1SRuOMZFp
	TVdYTI2u85qzVPhI1AvSoJc7K7uqLE6fxy3OsHP9jo8Xp4dmq4K7LSRqqiwp5mXa
	bStvEg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9usdn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 09:51:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88088964786so710216d6.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762422666; x=1763027466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZsRCzXp9F2PQY4ggZIqyN7UEW8FExIqJdOsCcIvnqU=;
        b=IhbnKY5Z6QkhfIinFeCRgWJkWhkP1aqh5WPk98e1n6mgyuUcI+WmbcUoixsDyuKrKW
         xqsApusLJKYqXdvGPl13ltD9W0c26cloqAtsbb/ZarmP3SkPuqB9WpUMPkQCRVz3EuB0
         K6mIXxjcI9f8NO9IxFXxrgzDqBRnGbLfZeTSrq+kvB3dU8RhZOp3HlN2UIvzPKgtazrx
         UENzEjDOky6VxFkwLjYfG9s+G4EUcDxKVIwnMQAszonIBx1vV44shny0vI82WivC1g5a
         P/pN30l4a3YPSvYPCBZXff05MzFqcQDD9udgLGTDvtFm1kZSp3vFXsOrwlwA/WsgJ5b4
         Utzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422666; x=1763027466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZsRCzXp9F2PQY4ggZIqyN7UEW8FExIqJdOsCcIvnqU=;
        b=gNiRoMP9hfna7coMNyuytrHI2eQLYSM4Vaa/QBjmaufZIzApvYi+I3J82qwWujNSYH
         AH2nM9SlOKP2CQm5g58SMKhqPxV3wwbtkA+3sZEMFnt2RN+rvIqmg8Rp9tuLtBPXGytY
         AIupJEWvaJ2Ivbi3EuB87UWKFUUl1HOCGhUj10pyCofk6/mH7UdikKC6hGV2IIQlrUi/
         v4tvjg23DoZNA/7mzxrMpCwsQzvqKC3R2T8nnaul7UIS0iiK0XdLT+oOrrw3pz7IUwc5
         RWJ33N7vdHybmuY34pjAMsT4R2B9IkDA/NInUkWclfv8PfUY6VSgXWxwfkuuVtei5mtI
         WXIw==
X-Forwarded-Encrypted: i=1; AJvYcCWXeusXbZ78LB24J3iRQH+BnW2A/YVbAnfMxAIjdCONe2dKCvpTH6aA4thzSlO5AQq1mZVrtJHy4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnkTn0NHFTxgUOvROWDnZBF48KRYDonQszvPbUm0z3NlzaFpX
	jy9E1W4axiTD030lnDLM15EVXfGLaEgDtSIJkp69VGLPsPAbwawwkaJ4z1zJ2LEjDNZUbo8PbAW
	bKs6RDEHZmGSS6DZpDiOt3aVAbfTKkNdZpJ0P4nYpOZoJRhN+pJ9XR2EiyeoEQw==
X-Gm-Gg: ASbGnctg45CMpL11AGIoYiAvjZkPoCnKWUBg+LVHESl7Tu1nB2hw2nilBsQJfdd9DRK
	ICbRJLOuNYLDUcua6/2GkXqNVDNPEmAwKdkNETBxjJ0jBM3T5uj6cjo5m52FN7OJPSNHJayi52M
	0s9CItpyM0Vm+zqgD65zHWE/+XkfOAatwI1V3o7WQS/A+dh5LOMFv0ocFEgrBu9sJYYFn17sFoC
	k5pWUhbL7nafZWdGUBYa0H16cjKNajFFkF6YOgsL3iVydpqau6tsv9XJtWJAxP2DzTqWrKz1Bja
	+bel3jIn5AAwXxVzHd2B7wjYvcwY0NUeXdCoZ/gRlFXmhIg1A1r7U4ats6Uuh4a+Qxr5D2er/ia
	bw1uhqHTz9HzgIdTcaf9gtm3k1ejGiEJs8Ff/gNQ7cY9iD8VuOfKSeIjt
X-Received: by 2002:ad4:5f86:0:b0:87c:2360:d41f with SMTP id 6a1803df08f44-88082f23ee9mr18251086d6.3.1762422666539;
        Thu, 06 Nov 2025 01:51:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPT/BAVfUWlvYl6K4WhBqXTZmQpbLXz9xtVoeJwcK31/pU4lMp/uDh04+Fm7fJy69yKEsuhw==
X-Received: by 2002:ad4:5f86:0:b0:87c:2360:d41f with SMTP id 6a1803df08f44-88082f23ee9mr18250936d6.3.1762422666082;
        Thu, 06 Nov 2025 01:51:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289334257sm182354966b.6.2025.11.06.01.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:51:05 -0800 (PST)
Message-ID: <6bd38ab5-cf60-48b3-a27c-a33de9762cf0@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 10:51:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
 <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
 <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com>
 <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>
 <CAFEp6-1qPw7vdqYNKYv00M1sDo0HhEPgrHuEZAJ5vabErR7ChA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-1qPw7vdqYNKYv00M1sDo0HhEPgrHuEZAJ5vabErR7ChA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c6f8b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=U3JJaeWcYHlj1SPvQKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: hrXDrnUKtOSfGAMB4PZpQhmb8WGnzj-j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3OCBTYWx0ZWRfX1W6V8bv3XvaH
 ZTFvhSyWjePX1DdIZ3Mhnvz/u1y121oP0pdnLuRTAPRN37YROyo9D2ttymV8QZq2hFa9J5otiI7
 z+JT21E2VJom/B3t+fdAi7linxZtVlgKRvb0WNXQ9p6V/gFaBnUlblJg5xZ66mq0rILAoAtKCvY
 CeULZPSko5VD/tdo8AfMgTmC8HmbhvHlYvzgWxhr0ipb7Hzj8e/wyM3B82PeTTpuI5GMG8gTKHV
 z4z1ySXCrsFLMzcN334ri79MLf/W954AXdLUhxs2RKXtwkSn3a65qJpKK0FqStDIf0pWH2hf3q2
 5Fc4475mCuOrfuWtM3+XBr9533AeDLUcse41hjIHIlFmaxt5LCRXcA9Aw6WnwNAKKDG2C62QmJz
 4F9MymTZkVFft5BY3eE2ZuJ0k553Jg==
X-Proofpoint-GUID: hrXDrnUKtOSfGAMB4PZpQhmb8WGnzj-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060078

On 11/5/25 9:17 PM, Loic Poulain wrote:
> On Wed, Nov 5, 2025 at 10:44 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
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
> 
> Not in its current form, I’ll need to slightly adjust the qcom,scm
> driver mask for the reboot mode and also prevent the dload inhibit
> during reboot. I can include these changes in v2 if that would be
> helpful.

Let's do it incrementally, as changing the scope usually ends up
causing chaos

Konrad

