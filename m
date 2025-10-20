Return-Path: <linux-pm+bounces-36461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A24BF156A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4858A3E027D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F280311979;
	Mon, 20 Oct 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ORspb8Ty"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508C2F83DE
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964681; cv=none; b=ermTFCOhNNh2CFUIK63vabtz4hdkTpnOyqQao+jZDZFP3EqSEb7r0Ib1Ph8g/oiASNQzQNGpTTmqYPvQbEUjoUsx/7MeLxLEvF3B7n3jIaEVBZuJG1VF/ebX6iCUAGf9/Iq4eEkqp07fQVl6EqbiYAitYkHwJj/VUmg2tZQ5lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964681; c=relaxed/simple;
	bh=ln3N0eD1mHN/qzZ6VCul8UydO8Sg3MW1W9k+bSGA9Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vmpcj/1Hwl4R8xDtb1rEy8/+JUsW9za028sl/4157iWM0umUXOtNP3Q/mKjqdxBAgTyuagDoh/N4R4VcyORB+X2UxNGmthxXdqXSTRwAksg1jrOHNWimyAGk5W/XQetvfvjtMVI76eXEHD6GdEKNnwNSNGsO+xZXPsuu0QCoDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ORspb8Ty; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBO13D025465
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PJ+61rwdER9gcUCreUuCjRpUgCHO6zkOMnqhcWd789Y=; b=ORspb8TymTeopoK7
	i5VSDWZN/dKtL7ct2iPIJ4Gpx97/6P6wRkg9R421WVa8R/ZLuki6xfyOPANIKCsB
	yQTW/StjyMRFC442Q7BLxFuu8+pfOhOlF/EOiOsYVnOj/INSRyoqiBM+lvgQhJ+1
	my31sREFRcr3VqFHggeQUQM7TqHq4cQ3UBmijsedmYzJ81ZnSRVMCmlVL5sb+Lj0
	/pXWgbHNZEuR30oastX5iucD/Sh5yfNox2LJwCXlZDx4z/Bsi1omDpafw3emeDoF
	RXVM9Bkg1h3lNlswEn+hV9cMwVmX0a6tOFOi4WJSeg637Ckr2kSjnQNmxxIeXSWp
	Qi+uTA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv4q75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:51:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8747323272dso15605766d6.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 05:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964678; x=1761569478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ+61rwdER9gcUCreUuCjRpUgCHO6zkOMnqhcWd789Y=;
        b=w6tbhiwWIhTw8gQ8IBcsKLDOQtYr48DYynS2iClKEpJVeNIgM2NGOvEmiI6y3I7qZ1
         5Bb/Cl7CxwAjwSf2kqxJ3nvPyMHD6kHTPKw6uSMfFzsv/OYFaJFs4hu6ETRs5Zs7fvOw
         b3v+6efO0TGxgrnd7lj/L9goi6TqU6plz21QrneBRQjDJGg2W9xQapKDn2RjZ3PWzc5W
         GyMCVP0Sxsgf/qYdXa1J/XrFyg6BaI8mHK7aCAuC/zyNuRlqiar1AVsBOGtK/1jJxgxQ
         O+7IwYdJLyazJHMLjkkeoQm8fVVqqVUQqKFT3+5rtqwiEIQ86v+98ckH+U0RMHYUjkaR
         GHmg==
X-Forwarded-Encrypted: i=1; AJvYcCXNDRpfW+iT5k84VqrX0JH62desPftZiNSezlDTYD6GDVnCXe7zfv5fI9d0mvuIcpFH7b7mXxGTQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbeD+fxtfSPk29YKVT45t8XFhc8zLZuLEZ83FfOcg2YLsfHdEI
	9aHt80AVpObUYX/YSqfhfQ7Ewrk9/rHA+Si2Fxw+GNNfDT6Kgh5S5jv+b+GnCmwGTrk4I5H7Ibn
	39Xrun9ix/sgPskvrztcRMauv1uBNdJwleOYAh00PqJ3wglRIN4G0v/ZFrvMHqQ==
X-Gm-Gg: ASbGncsyH0BX0IdJvIT8bqwEEt5z5mmmGgk/m2kp4kGn92paKZYClXD8lb3Kg2XkarT
	JfrQPubM8to/O1GspKRHh//8vwyPjE/sFM3Q67p/W8+BeiulXrIsCW2qyjN9lOBPpvdX0iZEBf2
	F3YxsQO+q3kLtkgiUVDubGKeoiUdusjdZYj4dOrLZ+yMgBA40K4P9pEzaRkXW1ZU/nRTJZVI/MH
	y2Ua8HSoauPau7Pwld5qAFMiLaITsbveGZdueQmpMrqET2XmegwiI/XAwWUIRwzxCfDOMpDWh23
	QS0jeYkSn96uh38iqj5YqH6JQQvJBiWXbbp5YIpbQwIcsxMjQuCwAxuUTer/V4u9ebygTTxKxqA
	boubdESNMMVjsezHP9K2MWCPZmf0nC9m2ODZdHM5wLwRPoCyrCwF5p1/3
X-Received: by 2002:ac8:464e:0:b0:4e8:9e21:4ca with SMTP id d75a77b69052e-4e89e210cecmr83045041cf.9.1760964677715;
        Mon, 20 Oct 2025 05:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvM+g0CMV8MpZIMjGVAhYclAyO4aaFAi6pIps6GwKxBRdXkhzeODilTIsQNa+3DVgXnvy0Eg==
X-Received: by 2002:ac8:464e:0:b0:4e8:9e21:4ca with SMTP id d75a77b69052e-4e89e210cecmr83044651cf.9.1760964677300;
        Mon, 20 Oct 2025 05:51:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914d0sm779690266b.21.2025.10.20.05.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:51:16 -0700 (PDT)
Message-ID: <3a32746a-5b0e-4c0a-8322-00cd3a84394a@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:51:12 +0200
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
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d8a78b7c-e3a9-44b5-986d-8ac32f328eb6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yAXJOhumOvEZ3OQoP8TmaiquNARzQF-l
X-Proofpoint-GUID: yAXJOhumOvEZ3OQoP8TmaiquNARzQF-l
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f63046 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4QpUlTompLYQ2UVP18oA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX66cCwW6svft/
 pMB7Pc9AbEwZ0P49zkFyaYX5wekkN9Q9TkSH1gdxOmQ/5aKnuv7G5A8Li150FQKmBWaWoXw52aX
 nFwLb0+WWmwZmfBZyBRN0dXHFCFqMir8K70ON58+sykFfCN3OIwA5xgoNv0gdpmw+ILsZcqEQQE
 hU3ygyt5neXF+93NsfHxTpTGOcbbwew8wsxOgwg/k3VsJ9ZVBT48fTfuobH/KD2djHsmeqQaU4z
 FQ5lsbQr3ICSdRNpPhyIM0pgChVcFsdWrBMRSwnmbIjKHKSYXVsCeqq/ZtZNRF6z0hEdpGFBT06
 dvlDLY5K9eLnAMGH3GMSpqboyNnRob6mzrBLf1cr7k6liC0LtibIOs+uWLtmTxtXE0fWgeAA6Wm
 HZfF03UJW/TiFLxuNZ7dFIlxklaSPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

On 10/17/25 3:40 PM, Krzysztof Kozlowski wrote:
> On 17/10/2025 13:18, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 10/9/2025 5:22 AM, Krzysztof Kozlowski wrote:
>>> On 08/10/2025 23:20, Jishnu Prakash wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 10/4/2025 12:22 PM, Krzysztof Kozlowski wrote:
>>>>> On Sat, 4 Oct 2025 at 11:42, Jishnu Prakash
>>>>> <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Hi Jonathan,
>>>>>>
>>>>>> On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
>>>>>>> On Fri, 19 Sep 2025 20:17:43 +0530
>>>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

[...]

>> Can you please provide your suggestions on changes we can make
>> in the above points ?
> 
> You just pasted DT. I asked about SW, software. Please read carefully
> previous comments.

Is the problem that Jishnu included some indices in dt-bindings without
also adding them in the driver's adc5_gen3_chans_pmic[] array?

As in, would the resolution to this thread be simply handling all of
them in the driver correctly?

Konrad

