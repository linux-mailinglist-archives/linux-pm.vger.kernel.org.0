Return-Path: <linux-pm+bounces-28286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7DEAD16F2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 04:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C3A16913C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E22459DD;
	Mon,  9 Jun 2025 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n4sPMCxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A72459D8
	for <linux-pm@vger.kernel.org>; Mon,  9 Jun 2025 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436780; cv=none; b=aa0uHqig7MAf6IyGHqmzg9lA6EAD8FMG12J8JEQQ7IcZiFgZ6QQrqA3ZLeICEX9imYJ9WSqYoF2VmkqaGOtVnsLHUN7TNDUiiLPmRertDsuMuZ5MIol+lG+SVOZNLkDZfYDrTpmrCv4a343RK6ctrSHEIKcRfLLWTuk0Z5Qdy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436780; c=relaxed/simple;
	bh=W1QQ8EhK3mzfRDvT+gNkm/YvjT2L1IbpLRckPRMZEXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCZCSKSsINMVhmQBbErDvO3bC4+oFRl6R0z79TVcYlrQbvvmuIfEYqqp0ysgkt+8ZAL+71CvOP4wZnCRyU9KqYZDkprmb/pG8FSZFKFYeWvlbHhOUdx25cyW7jZj2jHt2sAp3vCnSZF84t4+5rJRdLWJAGgU3McSyVOe1Qr+7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n4sPMCxa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558Kt6pe007016
	for <linux-pm@vger.kernel.org>; Mon, 9 Jun 2025 02:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	79gimwLuIKakCRJhBaQFPvGydcA6kRtFQU9q5zp1ZW4=; b=n4sPMCxaDd1XQG3N
	00EpkiMhQYDs92W2FfGRxakPOUnqHvpy8ShPNNIEl5Un0KEbFCyqhGOf355rSw8n
	DQCVSF1Kkp8CqsVdqK/JuR7LZfMgVsNKKWotAfWH8XyyO1Lq73JES3S7qUdl4KPw
	X1GK62kk5thB9v77x2y5YTOjXOWjVigLF1A5+8ZMArKvvouz4sZJNlfW7t4IxFW3
	KK4xDc7pCgRXw2WjiFnFMwL5SX5UgXeFH0A74olRglRRuhotek0jLczGrYh0lbpB
	YCTitK12bXdKBKQqMiucPgzTqNJ0xDJOtf/8OrIhwSeN6ynONb5Jhj4wFkzK0xEs
	WNDhcQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn649hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Jun 2025 02:39:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23505adcac8so33629065ad.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Jun 2025 19:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749436777; x=1750041577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79gimwLuIKakCRJhBaQFPvGydcA6kRtFQU9q5zp1ZW4=;
        b=qD4TftDQXYksFWY4cidYX4MulVkiCcdgyTU4sGTFQq30sQImf3R3iIfjhtY5hM20fe
         ZlaIix/sILWy80DBYHdJbh2tB4+ZovEpwWVyA6ubvuc2LEPEYzp8BXVFMjygAks9RM2M
         ktN+C4c2zioPeCoB+OHLEacCbzCCZgl21HhHzwIhYq6tqxhv/CbG8tC/F81CXR6BVCwr
         DqpdDKlMlNtaQRrQvfGPyJxfsvQxAmEn7EJoW3mYOtoQqysCM1RfZI+GhtbuwpsI8JN3
         UTOOM/AvzwqvqlIs3FZDzJ+P+h6Y03yjbkAxQeoDz8uPQvuKlXrybFo0v7HWegZhrqWT
         HNlg==
X-Forwarded-Encrypted: i=1; AJvYcCWjEAnwqigHEVGR8pq9gkFbkjYRT8ZV6LzdWFKQJ0HQX2BeWLvimLwWYVu13g3NZj7Ig0YrfLRG7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWI15VT93OMVWwuGw6MP54s6IsvNrfY+VG1YKLRN3jClwwo8zI
	VAo9Oo6ocxbN7w9OimKUIyeAKZ3zkHJEXR+UP8Ruzvn17aFU71UQa/V9PQl7SABTarFXPWcXyDa
	U/1Wl5Y5vDEG6BgLiP5Ujgci7ehFNYeKv/8OF+dgqfO7169MAYS/7kUQEckjk7g==
X-Gm-Gg: ASbGncvt6PZodXCI8FAC/pVASTZHmnrnyh5YnY4y+ZNaG3s/CK5hayJ8rsxp6Lqi+ON
	yCbJkY3f4SEWKMz772U6NCyGzkSk4xPmybD/bcEqBPyEwJPFM6p6uGK7vHCjCyAVZrDXNq9TVri
	M10QV/SMo521FPonJL0OgQuOeV3siK57MSAYySD7KCiYZEvQgAWsyDM/A34oeVoAxozRkD6XitD
	gFMXTH1p0DGiyNoqQBqBXGjfmZFe/ntJaPFjipiX7dys6k7jR1oLKUVdjk6hV/3ZVIVsxvItVS/
	gzxapG4PDqSkwth4Vhv5vRKO5qbuLXddkVZafwkKSlVOvYDL2J2WvtzADsgxNWruyFXwKck6FdQ
	Sqz6qVXuCtak=
X-Received: by 2002:a17:903:1d2:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-23601cf2febmr150513845ad.3.1749436776985;
        Sun, 08 Jun 2025 19:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdAMZcQZB+gjb2bkDYnCpUx//bQkJ+IMD+7wz3jyE7yFtKOaFJOuNjUmz081sjRi+XdKnPOw==
X-Received: by 2002:a17:903:1d2:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-23601cf2febmr150513435ad.3.1749436776554;
        Sun, 08 Jun 2025 19:39:36 -0700 (PDT)
Received: from [10.133.33.181] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b13addasm4592062a91.34.2025.06.08.19.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 19:39:35 -0700 (PDT)
Message-ID: <cf3479b4-5f02-4d19-8164-306214966248@oss.qualcomm.com>
Date: Mon, 9 Jun 2025 10:39:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] power: supply: qcom_battmgr: Add charge control
 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-5-9e377193a656@oss.qualcomm.com>
 <f2e0f1da-c626-4cf0-8158-8a5805138871@kuruczgy.com>
 <8bb3a056-c00f-4ae0-a790-d742d31f229a@oss.qualcomm.com>
 <5knsdgk7o5zifkvzlrqiplmhztnsyhlxnqiuikqf4l7wkx2qvh@s3vzkiezw2bc>
 <219a46d0-446c-4eed-8809-4f2400de0ef9@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <219a46d0-446c-4eed-8809-4f2400de0ef9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAyMSBTYWx0ZWRfX7Hexmlrb4I7p
 43S2fbTJOnhGJ1Y/3ccxTmy9iTP/ZGF34uX3Tm7Fyg0TYPCIqyp8NNh8dgWhyRjEEHSwCZAhBnG
 0veeSnIQjShCQq0FAEr6lg933DFaTZCgqjNNfCuOOY9Q1Z8E9QXp+WxigukGXKAyGGmnlQPu8K7
 b1a3bB1z9huKM79qAThDazZ0q+HfIGsCZphCpeU+gtvTKCl5EkCh57g0BnteJ2v/jqF0HZt6Mvm
 QtQ8no5IAZtWh+SNOaAJVQyLVM9KoaTvrqDLOgy8xgXo/HjBHHt4hYmXzv7iDIV4v0wrdUm0MkL
 myhmc+JRyBrQAgtM9U2bl0psrOT72TAYXwPMNE8iKAU9dKNDk1+POjXJKqaMJiYPX0HjjA9/Xra
 SxYlFGAZi9UcWPhZNbN5+clhYpbWkU516VzJNCUya8lRiMWN+8S1/RDSyx7klkJwgFskbkoe
X-Proofpoint-GUID: WosK39w_bHobBZwr5GRVB2GSnGb-6Twq
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=68464969 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=g7_sT98hAtsvE4oCy4kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: WosK39w_bHobBZwr5GRVB2GSnGb-6Twq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=965 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090021


On 6/7/2025 5:46 PM, Konrad Dybcio wrote:
> On 6/3/25 12:37 PM, Dmitry Baryshkov wrote:
>> On Tue, Jun 03, 2025 at 01:48:11PM +0800, Fenglin Wu wrote:
>>> On 5/31/2025 6:36 PM, György Kurucz wrote:
>>>>> Add charge control support for SM8550 and X1E80100.
>>>> Thank you for this, tested on my Lenovo Yoga Slim 7x, the limiting works
>>>> well, I finally don't have to worry about leaving my laptop plugged in
>>>> for too long.
>>>>
>>>> One small thing I noticed is that after setting the sysfs values and
>>>> rebooting, they report 0 again. The limiting appears to stay in effect
>>>> though, so it seems that the firmware does keep the values, but Linux
>>>> does not read them back. Indeed, looking at the code, it seems that
>>>> actually reading back the values is only implemented for the SM8550.
>>> Right.
>>>
>>> Based on offline information, X1E80100 doesn't support reading back those
>>> threshold values in battery management firmware, so I can only use the
>>> cached values for sysfs read.
>> Which limits usablity of the attribute, it is now impossible to identify
>> whether it is enabled or disabled. Is there a chance of fixing that for
>> the X1E80100 platform?
> Is there a chance we store that value in SDAM and can read it back?
>
> Konrad

The thresholds are stored in PMIC SDAM registers by ADSP after receiving 
the set requests, and ADSP reads them back during initialization. This 
is why ADSP retains them upon device reboot.

I spoke with the battery management firmware team, and they have no 
plans to update the battery management firmware for X1E80100 further. 
Consequently, they cannot provide any interfaces to read these 
thresholds through PMIC Glink.

Reading them from the existing SDAM registers requires adding 
"nvmem-cells" DT properties to specify the SDAM registers. However, the 
"pmic_glink.power-supply" device is an auxiliary device created by the 
pmic_glink driver and does not have an associated DT node. Is there any 
method to create a DT node and add DT properties for an auxiliary device?



