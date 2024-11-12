Return-Path: <linux-pm+bounces-17397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779379C564B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CF128FB39
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED91FA83F;
	Tue, 12 Nov 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zf7Wpbgl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145011FA829
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409424; cv=none; b=BQt7vLkiSb9nqYB0a4Zj07Ype7yBaAvbEFX9krsN7cCmDmKe9iGfB2y2R4e6dGZOmvQqjUqBFye6jXsPZW0335+u4+f1F1o+xVslHmQukRTdeZRIm2Zu+tfcocY8atXDd8vPsYO4r8l+3nkT4sZgtTwc4xC+SCyGlzD2X2CxlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409424; c=relaxed/simple;
	bh=G0Qe2OADcAQsfACZt2BcP1eMIcjortGkp4YDbkFFOYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxcAd0WxXFrRp1opP+aRP54PCuaFcNPfrGgbsHdGK2+kAUyF5PLPhpOw2fPCtVEpXlCEjjAUPa3R93rdx0TYLmzJH4RghiTex365q7tnJNE0/FCOS4eUQslzhIrhS3T0Th3Mvp+jRXGsWqGO+1wG6rh6gi+lJ4WP/cLwvoJ+Lv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zf7Wpbgl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC2oLMA009701
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 11:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d7fGoZsQujJug+U+jHgYocLKquVR4HJgVH5ELiDsVtU=; b=Zf7WpbglOftzO5UU
	RfZHbfYkITaFaGhwrV1yrBSs5M1xbbNUQsN9bUq3jv/mxRma5h2n9xa7b9OOge1p
	JVBehQDw3O2+TXgrm2j/wjWhyvSmuEZLZah0sos6cURsHaY9x5d5sqcl3rRR72ez
	1oE+dpjtDYrITI997+zOZhZnB3DapTO7XzzxaU2Z/sWCUmyxhvJJPycxes3QeMv0
	hfBrCC7NEEDXIwTkRzAs6oobyqXTBHhY/gG60sXF778vhrVmr0cCm6jg06HYfQh/
	Fd8p+aCBGwAnjzID8jAiY4GrYffP2HM527rmH+KATLNEctonMd76aFi/CJfPCvxg
	L/KrcQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42syax7218-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 11:03:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d395f187f6so1583146d6.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 03:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409421; x=1732014221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7fGoZsQujJug+U+jHgYocLKquVR4HJgVH5ELiDsVtU=;
        b=oFG9U2202jwGXUvgeSy55VX1nA4A+SmTRSl8IdZyT0WI9WSb4UG4COdhO0w/qD4MP3
         GmnhHQNUehi8odv1QgCjgAafsaR6TEij2XyXOUpIpsYLuoiIBHeZ2cl3Gq9XA89wMc3q
         EBl/zeL/ZVbj/gEwDtcERC3q2JZN/aFNrRMG7EpK/E/CaWZUblyqVcLTFA8y4hTBVg9e
         z+LwM78GOdLemA4Sbkwkre7Mx2NrzakJKqqTZ13ds6s+/bWluxpmOR0RZsqJVwP4Ntne
         OFKQJHV5vsDHS6vD2114z7MtehlpNp/c9EuKJHdkv9GMIKi5ErhM6rUE07CYeV+0/cQ1
         kk2A==
X-Forwarded-Encrypted: i=1; AJvYcCVu6WUYDJVrnjVrzUjvgwtC+6Ctc+1JxTUTcc6/8+mXdBl48AcBTeAnlFhcMXBFlTVR63LJtV3p0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRD6HsU1xEW1HuRh0YRSocaj/CODo+nkn5uHc1vMVJ6SlOs+QT
	DQSO+u7az6F8w8p9KwGgW9OSWIqmtePDvxW/o1Bh1k5j7zzbuNDlShqvh0aCJqNQDJJQXcyuZJn
	Hy3uXI4RJe65Hz/8eKyEREs+LhOBNbgyma8TtyuLK0qgywErR9BCm+qp9Nw==
X-Received: by 2002:a05:620a:4441:b0:7b3:2107:397 with SMTP id af79cd13be357-7b331dc992cmr795518685a.15.1731409421130;
        Tue, 12 Nov 2024 03:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1fhQJCIFJPwzZ+PR7cMWjAglUJ/e3/68X4A0MvFsQcnHnwg/lt4fE0sGY44qyhmK5ZwJw9g==
X-Received: by 2002:a05:620a:4441:b0:7b3:2107:397 with SMTP id af79cd13be357-7b331dc992cmr795515285a.15.1731409420681;
        Tue, 12 Nov 2024 03:03:40 -0800 (PST)
Received: from [192.168.123.190] (public-gprs527294.centertel.pl. [31.61.178.255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf1d2cf5c5sm3562974a12.31.2024.11.12.03.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:03:40 -0800 (PST)
Message-ID: <6565a4ec-6db6-4442-a07f-ace467c47395@oss.qualcomm.com>
Date: Tue, 12 Nov 2024 12:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Konrad Dybcio <konradybcio@gmail.com>, srinivas.kandagatla@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
 <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
 <8cb665f5-4885-4853-804a-7313decc719c@quicinc.com>
 <2c7ece9d-95e8-4d01-a9da-c1d5d7388771@gmail.com>
 <fc676574-ffac-40d2-aa47-8d7cb61b5e3f@quicinc.com>
 <9bd3d4e2-aba1-423c-946a-f5c60da71497@oss.qualcomm.com>
 <f5ceee66-9d09-44f9-9217-3abd467d1086@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f5ceee66-9d09-44f9-9217-3abd467d1086@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5QZ-APgKJ86aadiyDFJxhsslI2KlHFq1
X-Proofpoint-GUID: 5QZ-APgKJ86aadiyDFJxhsslI2KlHFq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120090



On 11-Nov-24 12:51, Manikanta Mylavarapu wrote:
> 
> 
> On 11/7/2024 8:17 PM, Konrad Dybcio wrote:
>> On 6.11.2024 11:25 AM, Manikanta Mylavarapu wrote:
>>>
>>>
>>> On 11/6/2024 2:42 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 11/6/24 09:47, Manikanta Mylavarapu wrote:
>>>>>
>>>>>
>>>>> On 11/4/2024 7:21 PM, Konrad Dybcio wrote:
>>>>>> On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
>>>>>>> Add thermal zone nodes for sensors present in IPQ5424.
>>>>>>>
>>>>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>>>>> ---
>>>>>> [...]
>>>>>>
>>>>>>> +
>>>>>>> +        cpu3-thermal {
>>>>>>> +            polling-delay-passive = <0>;
>>>>>>> +            polling-delay = <0>;
>>>>>>> +            thermal-sensors = <&tsens 13>;
>>>>>>> +
>>>>>>> +            trips {
>>>>>>> +                cpu-critical {
>>>>>>> +                    temperature = <120000>;
>>>>>>> +                    hysteresis = <9000>;
>>>>>>> +                    type = "critical";
>>>>>>> +                };
>>>>>>> +
>>>>>>> +                cpu-passive {
>>>>>>> +                    temperature = <110000>;
>>>>>>> +                    hysteresis = <9000>;
>>>>>>> +                    type = "passive";
>>>>>>
>>>>>> You have a passive trip point without passive polling
>>>>>>
>>>>>
>>>>> Okay, will remove this.
>>>>
>>>> You most likely want to preserve it, while keeping a sensible
>>>> polling frequency, so that userspace will be aware of the current
>>>> CPU temperature. <100> sounds like a sensible value here.
>>>>
>>>> Konrad
>>>
>>> Temperature sensor's present in IPQ5424 supports interrupts.
>>
>> Correct.
>>
>>> Hence no need to configure polling frequency.
>>
>> No, that interrupt firing signifies crossing the temp threshold (meaning
>> no updates beyond that) or the tsens watchdog barking.
>>
>> Konrad
> 
> An interrupt fires when the temperature crosses a threshold.

Which means you can't monitor the temperature at runtime
without polling..

Konrad

