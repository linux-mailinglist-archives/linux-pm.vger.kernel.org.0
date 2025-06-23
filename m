Return-Path: <linux-pm+bounces-29397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF5AE4B26
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 18:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6572166864
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF602777EC;
	Mon, 23 Jun 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXa4RjH5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AE1A08A3
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696814; cv=none; b=NPjR3iW+dLNspyE2XscpXyDWJCU5Ozaw6Vuy16oLkU3MO1RREP300ivUaCB/N0nx8dZp53dvasnHg/Nm11DysWToQlkskfXu//Dr8K7aiavxNUGbl5/5DFoUmytSOIlrIrGQdgdV353wucsp7rJrS1BfACPIwRWqLPNA04JsRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696814; c=relaxed/simple;
	bh=eR+ur1cKOg2flLGzDzwtH0YBRTLAIui1olriTCPWVSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrYDPriBBU08+Kp5LBUWGIkEf8ZRxd+Z6jNLkbpHReFXViKkt+HNLBbNBhWs32U2+b1aTXWfrGCjx870FJpm1BhAYwaYN6ix45SGPcl9NH2k09uD8E3BvzbGkwzTj26Zji8RKiurnJYgKWbBilo9xQy7RiDatEAUlwghzwUwTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hXa4RjH5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9RYfA032591
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 16:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2bRT9SJHlT97u3ops9Jk5UZrZDQEVjvrIec/PkyZq8=; b=hXa4RjH5lR/jBXAK
	vycZBatVTqXUgXL2Phf9cnXpke7WyRnccJu7Vnt2/+9AniZUphgSxHf2wuqm66ii
	z2jpYcW3KYpA+ioPWrMygtQ8wqPbnmL/1+W7agkiP3AF45mGFU6a+Ry5l+5fINN5
	GHiXxgeFx3T1EYprBp6jYa3YpOdV7XUA5QlDhbMRuCF71ND4YTYRYF/YZHY9FwKx
	TmridgQDpb8Q8HqiPPwaP1RKLpFCzMzGsR2Eev9gGhae+UAj1wZzDjvCPAANVmuG
	+50uYvHHG1ufCz6ll2mPrx2mozE/1TxixyRqciDJ4X0O6Q3RpOm/J345wJgshww8
	fvr2Fg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eah7um9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 16:40:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb5f7413beso8907996d6.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 09:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696811; x=1751301611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2bRT9SJHlT97u3ops9Jk5UZrZDQEVjvrIec/PkyZq8=;
        b=aO/56AF8FVylSC7hVvUnNMl24bjERnQfcpc8UqV9y4I7I4luxzEE+MPnQYPTM/9832
         oMZgu1P3Vm1q0jeO1XL4cDp0son/RqXyPpg3ZIS2/fdGPSlFMlD+MMYOgOXGrPRgTZ92
         W/X2NmPFtRefmyJzvauIg7V4hyPAO5hTM2i0SpdfkNgGSEAch7FsO3GmSdmboxQHfyUL
         XpPQ4/n72jijuVf2fKiW+CQE4LoG8H/RQXZSFD4PWXjgcDCpoQ9Xddt4C97W/bxjoyqU
         4eYqwpysHx0RmVR/gUJp2m4DS0TVnBqoe092nt4Qu/r1fpGYahmKnS1yHVBL3bQ7gIXu
         oH4g==
X-Forwarded-Encrypted: i=1; AJvYcCWcggGakraLjNcPnLc06ZNY4b3ooVKI0B8CpLcjdiThlTlANuLcMdzpDs8RZDmlzRqWGQ1C1Ea9GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GebAN3/DoOWFA2+kO42f2HWLvFDT7f0mjQupq70CipR14odb
	QBQ0d/18xPF82VHeQnVvrtxF2bWR3aEy8bRT7jdupb4ohoxKUhPlSmAur1YXL9jCotJbo8vT4fg
	3mnL/dN/r1561ftwIHh78xTzL+7JAxlLjHCPam2d/Hjglm9ZyieOZpGpLsK1jcA==
X-Gm-Gg: ASbGnctYdWVnpu8lv23h7kLf9k87yOKBkEzu3VcDQe+usWUwG9yrLoFELOdw00x99Rc
	uy92b6FxatJcxO0MWlyxppZaAILPCKPe2u0rgIHb0BaQ4MtOpT+0l99Xb0OxlFPQlYz3GJFRodb
	lbHiwTwR3IcHrZy/PD0GALA5usgEr3ywSfs+juEHeWs1hixxl+V+hOHAK2Yi6s3I7AdlWJOmhtV
	PY+3QwxoHFpKXuOH9iV6f9pSiFzE9DGw8OAI5HSh57uV3myriUKx39k3kZZ8Nc45Ho7xGoLUFYV
	bpr9NKp4qU/NhTvqQU7a3cTtVoi7IWBnET2HfJZo8NW632f11TKM5CjUcbjWqmI5KLaBu4SF0cq
	eQRk=
X-Received: by 2002:ac8:5c91:0:b0:48b:6eeb:f98e with SMTP id d75a77b69052e-4a780353b2fmr42899981cf.2.1750696810516;
        Mon, 23 Jun 2025 09:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq/XOpoxNvNR6RSBM0eTtgQkZh2y7a6j9L7YTt/WuGqvanSwKZAsgCnNh09krw6R1+H5c0WA==
X-Received: by 2002:ac8:5c91:0:b0:48b:6eeb:f98e with SMTP id d75a77b69052e-4a780353b2fmr42899651cf.2.1750696809833;
        Mon, 23 Jun 2025 09:40:09 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6e04sm730543266b.115.2025.06.23.09.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:40:09 -0700 (PDT)
Message-ID: <53a2cdba-0fb8-4b99-b58e-9318b1bd8ef6@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 18:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] power: supply: qcom_smbx: program aicl rerun time
To: Casey Connolly <casey.connolly@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-11-ac5dec51b6e1@linaro.org>
 <2d3ff07d-1cd8-4eb6-8b3b-2d0d6f64445f@oss.qualcomm.com>
 <613f2812-3c60-41fe-bdd3-fbe8ea7eeb69@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <613f2812-3c60-41fe-bdd3-fbe8ea7eeb69@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IJOv0phhJIbyxNOmJGd_REc0LQbQzBrw
X-Authority-Analysis: v=2.4 cv=PpWTbxM3 c=1 sm=1 tr=0 ts=6859836b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=NTzqWVVAQLbBsVAMQFsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMCBTYWx0ZWRfX6O2z0NY+fIYU
 TTlibQc0T9drF8qZwwnBwa5+8vbkxLmJijo5wWwFshPT0cqSRQrHoJlMg+Rhw0o7oSg3TTXtkof
 wg6YIDuovUzfX3WCfkxnVWVuXqstKPRcaue3no/ryFKxwIqZfA2gVcCmgg6ne+ib1lxzfRBonS/
 1vJtw8Aosohss6gWs81Kz047dNvpWhmGrsMfgpBSKdnxYHJjd4/qdUEcFxDtJbT6pTrLw6w3J1q
 Bg1xaxU1F6gqxeolrcI0iKRfF0P67dzd2nTShSm1j6MKcs85OC3m7dLwo3E7HKezq86e/lj3b/r
 vNtPDxlcgSP8fNXV8fO4N4KQ6inBpNCO1kU6agHJSC9naHv5JuTbmv5DCuXOjGlvwz8YvjJbUKc
 OF8ZJQU+FpS917VqRbupWagGNIIavJhnE/zMvyVb6254B0vFBU9kYi4Nhoedk4HMeicMpyEl
X-Proofpoint-GUID: IJOv0phhJIbyxNOmJGd_REc0LQbQzBrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230100

On 6/23/25 6:33 PM, Casey Connolly wrote:
> 
> 
> On 6/20/25 19:00, Konrad Dybcio wrote:
>> On 6/19/25 4:55 PM, Casey Connolly wrote:
>>> We don't know what the bootloader programmed here, but we want to have a
>>> consistent value. Program the automatic input current limit detection to
>>> re-run every 3 seconds. This seems to be necessary at least for smb5.
>>>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>> ---
>>>   drivers/power/supply/qcom_smbx.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
>>> index d902f3f43548191d3d0310ce90e699918ed0f16f..b723dba5b86daefb238ee6aae19b1b7e5236fce3 100644
>>> --- a/drivers/power/supply/qcom_smbx.c
>>> +++ b/drivers/power/supply/qcom_smbx.c
>>> @@ -1091,8 +1091,14 @@ static int smb_probe(struct platform_device *pdev)
>>>       if (rc < 0)
>>>           return dev_err_probe(chip->dev, rc,
>>>                        "Couldn't write fast charge current cfg");
>>>   +    rc = regmap_write_bits(chip->regmap, chip->base + AICL_RERUN_TIME_CFG,
>>> +                   AICL_RERUN_TIME_MASK, AIC_RERUN_TIME_3_SECS);
>>
>> FWIW a random downstream clone I have sets 0x01 which is claimed to
>> mean "every 12s" instead
> 
> hmm I saw that too, I think more documentation would be needed to understand this properly (I'm not exactly clear on what this actually means, when the AICL would re-run, etc).
> 
> I have reports that this works ok, so I'd just leave it unless we have info to suggest otherwise.

Well, in case of such lack of understanding I'd much prefer to see
a magic number that shipped on hundreds of millions of devices than
a magic number that was confirmed working on a couple dozen.. especially
since this looks like an improvement that people who had their hand in
the hw design wouldn't generally overlook unless there was reasons
(e.g. compatibility or some sort of a quirk)

Konrad

