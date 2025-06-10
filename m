Return-Path: <linux-pm+bounces-28362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFB7AD35F1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE98E176C67
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1728FAAF;
	Tue, 10 Jun 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gb5f+v3w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511328FAA0
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558005; cv=none; b=utDM96SCq3eY6k/y3rtzQnP89VrPz10VutXTzNwrCTvhR9sZL64PQuJt1DhlDc4OjbiCyLsVjvgLYdpkjWH1OpcmG6P3pdmuy3wI08LeDy0Qp/wIJqSDvzkmwb5qmXZF4aWMNhkTXgBZ0uEy3JTJrOE/OBHb8q4C3MZst1KMYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558005; c=relaxed/simple;
	bh=GnMINJ+rcQerWjj/m73j4gOd+J0Oo877g1bdajEn74A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6dp1oVvHQfFSw5tyIuSCwSBJFbt6HWW4vQ6TWkBJf3hXVL4nSur+Bl5whrexh+/cgGjiLNnpebefEhyPtyjFqZ5pRs6Urag7W1snpzVhhm/HeK6RQYsLfKqpKByprf0fUkyWVGKjzyzNMHMy1mFzmAVu2frR4X36Xrb25VU7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gb5f+v3w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AACwFX010145
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 12:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vhau6mD0BxB2kfcVfZ6o+4OrKjXeXzy3kAMgYfwD+6c=; b=Gb5f+v3wiAXBOjWm
	U3/Z+qc1ffSG11W0f7W/Quc4XETq5jiRUQb1TG1U7qV8tsfoQdsjZzTMywHCFIPi
	dKiK52++dhjN90+tHo9F2Z6e+TaW3b0LkZmc/R1B7GFfdUjaFcuMt7E5z+fmVKA8
	wvShmWzIdVcAohoyLuxxzBZCHcvlKGEDOKMqU9sSZncRLA0sq5SlyaWJ9bcv7da7
	7vmS5r34ZIQFrgV8AITons19LyYvgjMwLuj9M9I+b87NOoj9RWgxi6Iy5Oayq72G
	d3mR4DSp4Xg53G18kSTsq9XiEPWqzu+HSuFzN1b/UAnPYB1Jg48MzDfJ5yqMf8jp
	4B6/Mw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476jrh8bps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 12:20:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d097083cc3so96731085a.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 05:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558002; x=1750162802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhau6mD0BxB2kfcVfZ6o+4OrKjXeXzy3kAMgYfwD+6c=;
        b=NMY7NvBsGdGyM7i3Ud23ExV2/LWiAyzUUlvMDFNafi/LX/iRAzO4a00ooNU228BR+Q
         Wd+uJy7oDxMpyH+Q+l1FhSPGcVUgyetf3aDUTExt4tjpXjEGKNY0XRV/xU/kwMLuuuJk
         qwTDzYOL0C9uzf8IuhROcPc9lli9k4BMCWV7x59RG+5OHViG7SPCoe09beQuLDexuTUl
         bobLCBRQrVtOtJpFeCGTDnIZpnmyzHFzVPpuN5jUaWHnflsNpLgTWiQIjrOH7wWbTXI4
         c8G0MP4ZGp4WzxKbtgdcHjV864hNGlmbnVnTUGhm8BftJREvkPLAXQhIZf5noCIKYv22
         WVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwe1KISn/RQe6djvXBUz6MkgSdB15Z7HY3lGpJRgkUPZiaXvnRE33IUc7adtURCDrVVaL9DLZ4vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1PQXKfdJlFe5YMCyjOvk/df4MfzaCpJkdqTz5j1Qo5gHdEh9
	KvE5Vz9eyhJEhXyj48NR4EvrEyiRtInLHoSk2SPO27mxw5v3p3PgJTX7AYpKnZGqG8Bvoy3g+k9
	50fCvC3sNYh/PS3vVLr6JjacU5bRI4KypGnKEUIxNf5FSSPUGfvQ76Ht001IkAA==
X-Gm-Gg: ASbGncsm4f3/QM5gL7yUw02yW/yV591dbfMHv1InXh74ZgnCIxAEl/kxFUq1pIwJn4S
	1iZ5DveueR79TKTA5FIXB/FHVMRe5izKysJiN9hpSkPHnVpWCGECQ38LZpIxjHK6Wf1YKzGXxOi
	xgQIifaBiq9DtmdUHIpyKXnI+ZdaeeAE5wl62+XXXUsuDwwzHq5/3oVuzhTdKX+azlFghSZTVHj
	kbw/7gOh/dar5QCAn0GZdrYEHSV6Wy1BopoiRPNc49skz27+zx9AuOUutKz7UHWHlztkndC+abb
	8Ej8FK/+SmqAomYZoQKF1+myt7UfCrehJSN0Cxtr+vgGo0MpAGYffl5wA+GbKXMQqFp1rNF2N8I
	R
X-Received: by 2002:a05:620a:4494:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7d33df21327mr843521685a.14.1749558001935;
        Tue, 10 Jun 2025 05:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf2HmxcJv0wsb0YZ7xLVm6b6ibXcsPzLTTHoRArwARqQqeSPVzstDTUy8hZeAaa52emy+X7w==
X-Received: by 2002:a05:620a:4494:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7d33df21327mr843519085a.14.1749558001494;
        Tue, 10 Jun 2025 05:20:01 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c05a0sm6225865a12.44.2025.06.10.05.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:20:00 -0700 (PDT)
Message-ID: <bc1daec6-9198-43af-b5a6-c1057d7f2392@oss.qualcomm.com>
Date: Tue, 10 Jun 2025 14:19:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] power: supply: qcom_battmgr: Add charge control
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <cf3479b4-5f02-4d19-8164-306214966248@oss.qualcomm.com>
 <b938b358-301a-4842-bdf6-93ec3c459d41@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b938b358-301a-4842-bdf6-93ec3c459d41@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EovSrTcA c=1 sm=1 tr=0 ts=684822f2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=ZeCA1ImQhjoAQTjEC58A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: fbLYb_hAQf859efnyKlvnGUIV-SIc6bH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5NiBTYWx0ZWRfX14FVC4+5sZMD
 L1Qj9E+9Tpx6M9PAigp8cDZEA/jTF3LiEz4BobvACcxzSMByNEQ4VDh5bqzpeCWKD2KFMxVTpL4
 kuD4HNjNl3l0DVeVcJ3BE9RYlnCela2o02y7uTEMQh5CMWBftBkzh/j7R34fISKqvXjbbQsPqBE
 1meOj8heEZsQFFUWTbb6QcFwUN1YKbjSJBKe2j0bzEcNPaGattB+s1W4V2GnQ6V+kuMNRhX5vFp
 5gsSW8gzowsF56bCkn0UCTCxgkn7lAs/VDK18SJ4YKGv/fHlwOIrE+ZtjQstD9ftxOc0wuMFDXt
 QHh1I0israG8vAPaTIw3qhnTC4PcJZjpN2OsBxdKu2408VI2hSW0TvVcb0e82K4UvQfuRg/emZP
 W5cZ2U9ihYEwoeApc+3eh36yS9dBwMKxGTn04TLomzcOuTA/B2rpHaWHb0sCL/1XkEs6fU8H
X-Proofpoint-GUID: fbLYb_hAQf859efnyKlvnGUIV-SIc6bH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100096

On 6/9/25 9:17 AM, Dmitry Baryshkov wrote:
> On 09/06/2025 05:39, Fenglin Wu wrote:
>>
>> On 6/7/2025 5:46 PM, Konrad Dybcio wrote:
>>> On 6/3/25 12:37 PM, Dmitry Baryshkov wrote:
>>>> On Tue, Jun 03, 2025 at 01:48:11PM +0800, Fenglin Wu wrote:
>>>>> On 5/31/2025 6:36 PM, György Kurucz wrote:
>>>>>>> Add charge control support for SM8550 and X1E80100.
>>>>>> Thank you for this, tested on my Lenovo Yoga Slim 7x, the limiting works
>>>>>> well, I finally don't have to worry about leaving my laptop plugged in
>>>>>> for too long.
>>>>>>
>>>>>> One small thing I noticed is that after setting the sysfs values and
>>>>>> rebooting, they report 0 again. The limiting appears to stay in effect
>>>>>> though, so it seems that the firmware does keep the values, but Linux
>>>>>> does not read them back. Indeed, looking at the code, it seems that
>>>>>> actually reading back the values is only implemented for the SM8550.
>>>>> Right.
>>>>>
>>>>> Based on offline information, X1E80100 doesn't support reading back those
>>>>> threshold values in battery management firmware, so I can only use the
>>>>> cached values for sysfs read.
>>>> Which limits usablity of the attribute, it is now impossible to identify
>>>> whether it is enabled or disabled. Is there a chance of fixing that for
>>>> the X1E80100 platform?
>>> Is there a chance we store that value in SDAM and can read it back?
>>>
>>> Konrad
>>
>> The thresholds are stored in PMIC SDAM registers by ADSP after receiving the set requests, and ADSP reads them back during initialization. This is why ADSP retains them upon device reboot.
>>
>> I spoke with the battery management firmware team, and they have no plans to update the battery management firmware for X1E80100 further. Consequently, they cannot provide any interfaces to read these thresholds through PMIC Glink.
>>
>> Reading them from the existing SDAM registers requires adding "nvmem- cells" DT properties to specify the SDAM registers. However, the "pmic_glink.power-supply" device is an auxiliary device created by the pmic_glink driver and does not have an associated DT node. Is there any method to create a DT node and add DT properties for an auxiliary device?
> 
> Auxiliary-bus devices don't have their OF nodes. Instead they use the main device's of node thanks to the call to device_set_of_node_from_dev().

i.e. something like this is what we want:

---- socname.dtsi ----

pmic-glink {
	compatible = ...;
	[...]

	nvmem-cells = <&charge_limit_lower>, <&charge_limit_upper>;
	nvmem-cell-names = "charge-limit-lower", "charge-limit-upper";
}

---------------------

if you have better names for these cells than what i put here as
placeholders, go for it - just make sure to also add the -names
counterpart, as we won't be able to rely on just indices in the long run

Konrad

