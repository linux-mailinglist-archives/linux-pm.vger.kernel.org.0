Return-Path: <linux-pm+bounces-37438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD8EC34EE8
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 545654E7895
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124BF2D0601;
	Wed,  5 Nov 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FVi7fzJl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B7gnfRDm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6D5D8F0
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335852; cv=none; b=h+HR3/bda1R3CRY/dmYxMUj5GqlARKxIIe28vvSLVI8jyykxBjf0XaAXMUaq1IqR3QUdFS1hHOFvAPUZtzM/MIr5ObJUQ4EmqyjOLKDuozS7rpgzr74X7O90cZXLGDlaoI5yeDq+RmrWPa9D2lFP27RLWrG1Ks1vQu2J50lXOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335852; c=relaxed/simple;
	bh=DMkuqg5VAkuWCJqsAfWtGwXFbjjVOeqWkTYPYP9H3T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABM5dx/jFNBF+GtSxnLK8xECB3D5z0MF3UstyH7slupRowcBcMC8KRXCs2Ci+5dm6ZA37ydLpaLrWacP9R2TkAZKHKxYdmmk7NputGtBRp28DRLiTLiWLIKO2ExbUQrM1gNLUdEpgiW2QrXWafhymeSQGYpTqv5AR6XNpUGDM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FVi7fzJl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B7gnfRDm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57xK7K2904880
	for <linux-pm@vger.kernel.org>; Wed, 5 Nov 2025 09:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5rWZ9Wy+DW2LaZXghe2naqODIIPVzpHfRZjYRvThAso=; b=FVi7fzJlJnZzrds+
	MxHV/GpqeEE81gLmlfAlOQnYsWdMl2o8UjCUv7igu7Ue1ifXcdEMtDQL8nllhZWz
	8w+dmLlmGZN6vJC1wm+ug/e3sHg+wD2jFTYEzvpTQ84iIe9GoL7+hRLIjcfr3FR5
	WIh5pooLhPc1fhgasf+6V2OjPxeTPWQ6Rerjb+oN716Ad2TLwM1OWnGV/IXUrkCx
	ezRjEin2pZ58+6//1wD5/53s5Xu/zG7UwjzAKXDEE11pVz8s158wZxgINBzM6bGc
	nMx1ffLsrkRrzsQae4lAGjyALfU65sNGNPxA0d1nnPzni1jNyUppNnouPnoAEaoh
	MaBC2w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbtu1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 09:44:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eb86039d9aso18366351cf.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 01:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762335849; x=1762940649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rWZ9Wy+DW2LaZXghe2naqODIIPVzpHfRZjYRvThAso=;
        b=B7gnfRDmGmFxYNXVG+ckYOxdQHG5Bx+NTcrqcxh14y80qKDj0oTQl+MKJCfUyIycb3
         M4OyKM7POBT4eb9iIqtbBrUIHkLXxwp6oLSkKfP32DHC5LXt7LuftZtPDt7ldwarYz0Q
         0C7RZX100nKJS23Kkwm3UHE1mrsU2pP7QIdk8Jt6gE8HKAQ418pBd7lx5fKYylhVPLLo
         0F9VJxZQ6mBidcbHs07GEJF5N3SfTtMbkMhYH9e2K+7iMKTLMnXObDEfPbWJmrVj2JsY
         0ahJHNtsENJdel4m72YYexZ5/mlZQrq93Jg7n5dxrM9GQU1s8kvRDvL+dd4yEFlA9+EW
         tpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335849; x=1762940649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rWZ9Wy+DW2LaZXghe2naqODIIPVzpHfRZjYRvThAso=;
        b=SYqDUIqD92KJkNW1JICtcYEIrDacMdUw/elwGVhoUz0x5PQXBCRaSyYiv2+8GesFte
         Wa1Eyu8jUSxSfGrNGvuAe2txvfUNfitjzW0CLZ410GJo9frJC3UjhYQLNgfXPD2oVjAs
         G70kdQNaJ07YRvgr7lA8zRU2vgy5qEKr37A09UFqBNqVu4rYnekgMCAbfCF+H1UYa6fk
         a9FXFHOIA+iI7xTdHjEgCp4I6PS292q5jtAZjuXrhXG3m52tLZGBNSmTn7SG+JIPuIXF
         6b8fUPWOgQbaqnnxmQS99ezfSzYpx3HeSLzILw728ilN+rUvWH0kelalBtwjO/oKVFXZ
         kWRw==
X-Forwarded-Encrypted: i=1; AJvYcCWANrwunNME08FjJPTGAvQ3zBoJxZjdDmpUVPcwfYc4fFPbCtss4NeuifrcO5YN74xS5IkLgClquQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuc1fAzSvspdhwD8IbyT1vSa74ELc1CAte5uip2AEEdMOLhpJt
	ZuWnuBC5s2NmDBI2I8f9pWUtjesxK4cs8OLo9HKErM58cUmjbh+6VFK8IgKj1lEF6zDblMBsFts
	kK94mngrZlVsEzDYrMNpbMLBQbeIM53Mdg31d242qgNHdzrCb8qemrf3eDxKQIA==
X-Gm-Gg: ASbGncuZzytk4WJrvYv877BtkNOqfcda2/wihLUGEyW39+iGOhsOzH1MDHJufSIgBQT
	Oag8EiaVS3qGXzlpyIdGVz9qZMkusvkbEniR/6QHFUoQvFkLfz6dNux5QxIfCs8pCC6P1w2PmBh
	jo90EJzm9IwlGD3MFvpIxr4T9nf/ebc/7NY5AB6Dx3HFahr7KL+3J5OrOdocE9XyjyFpgMlE/Hd
	+EE5Vruhh2gFYXrbksZg75RFthWWV6HmOsbJVvWr201fEpqbpalxq1AoQflWpOD0qFr7t56RAY2
	7O8G8dN3pnMd33owyzVIQdSglLGur9s39G52i3S5CXtuaNdkqjdyMjJG3Vkx7wboDwQpG6JeGq9
	shTyLUh0is8jlqCMzKlK2srhaCwGiNf28zuV56hLS+hJ5b49HYyP2ljTJ
X-Received: by 2002:ac8:5f07:0:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4ed7232fd6cmr22564911cf.5.1762335848737;
        Wed, 05 Nov 2025 01:44:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOjp2WJAqb4WyIFDw5kdbrWt1vl0Vc7Taop84+JbYeR37rsPNmQdI4l+soohZeVyDF4RZ/dw==
X-Received: by 2002:ac8:5f07:0:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4ed7232fd6cmr22564751cf.5.1762335848183;
        Wed, 05 Nov 2025 01:44:08 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e680689dsm4449427a12.12.2025.11.05.01.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:44:07 -0800 (PST)
Message-ID: <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:44:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
 <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
 <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WCiVFdercWgraDbTLHklLsxEe_urMPAz
X-Proofpoint-GUID: WCiVFdercWgraDbTLHklLsxEe_urMPAz
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690b1c69 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ffFVQk_FFUogVfm1T8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3MiBTYWx0ZWRfX5brGOCn5Ahsz
 cknsssY+O6A4WZmtWF3DSWwInzjqwNtUxBIHC4PGZY9YnpNQ8xlMaRMzBUvAgDXb2w1J763Ip9t
 jOHijvQsfzAAJJ4czwJD61+PvZJNwy4rZ+YsS6ZcfvY0qGxJq//BwnvGRuj+i4W/h12adpk7GO4
 2mRTfJ1njHZIJf+VLeLpGJmbczYCbgfPXM8RWxnK4oZxOr5pFaID4/S1S5Dqw2dZuU8nArVXz35
 CjB4V4ER0ozbMvhNnDiS6Q6J9GeCZj5Q0EY+bYu9z5Iei8hEfhKUND8Kevt4QBWmBIxALoCOfHf
 EgqDMPNaYPUt10zPksvfWyDqNVPB8tEMPWSCvgyj9kbe/81D01DfEWtZMHpkbT+iIQCD0gxncxB
 TUnIBZJfQCwR19Foei2AvTNUDaZtMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050072

On 11/4/25 10:19 PM, Loic Poulain wrote:
> On Tue, Nov 4, 2025 at 3:12 AM Bjorn Andersson <andersson@kernel.org> wrote:
>>
>> On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
>>> SCM can be used to support reboot mode such as Emergency Recovery Mode.
>>
>> "such as"? Do we have any other useful bits in here?
> 
>  I heard we may have different EDL modes supported like USB or SD
> based EDL, but I don't know much about the details.
> 
>>
>>>
>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>> ---
>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>> index b913192219e4..c8bb7dacd900 100644
>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>> @@ -121,6 +121,10 @@ properties:
>>>            - description: offset of the download mode control register
>>>      description: TCSR hardware block
>>>
>>> +patternProperties:
>>> +  "^mode-.*$":
>>
>> I'd only ever expect mode-edl = <1>. Do we have additional modes that
>> warrant the generic nature of this?
> 
> We may extend this to mode-ramdump if it makes sense, but as of now
> it's indeed only edl, will fix it.

Would adding ramdump here be a matter of:

+ mode-ramdump = <0xmagic>

?

If so, please add it too

Konrad

