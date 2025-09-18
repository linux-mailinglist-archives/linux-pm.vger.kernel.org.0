Return-Path: <linux-pm+bounces-34936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45878B8299F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 04:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48F7466AB2
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 02:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0E1A262D;
	Thu, 18 Sep 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brPPoXq0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500923A9B0
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160903; cv=none; b=Y2Um+Eb+xRvB0Eic3+wGNh+70uJVY0pq+vCKaQa+tHYbl3ps8MGLg/eLpxg7BAVLslZ2IhUGuICjqP9UTyo+5rLF3HCnnC0uTxRxRjTDmqSXRVt4ZS4kxzqWhgTRDDFQIrGv8c8b8IEkEN/JRHCPv2+ktpg2UB97Yw21XSGQ09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160903; c=relaxed/simple;
	bh=SBfy2aw9l6QAYSPL+WFnY56ROXf3Voafn/xHOw0URfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dut5/nrNZ54Z4VemKisvJjWi4hCWciHw7MkkGescQQ4XwNoTHAVuWPEnbd9jtpbT84LGGBNnNrkjp+oG8oDLvERd8uvUMo9BNjwGXQgwq0Msa7sv+RB7/Lene+Yf/cfJ0YZv5lt0W74F/eGMP07y7GMpLGEJcl8gXgTn00a2f5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brPPoXq0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIa6CL017659
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 02:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eb6fb+UFN97UGMhPu3oieNOs4MieyvfsC2uXdQt5UHU=; b=brPPoXq011Xz7v0W
	Z7MEOuMLXKxd7tIuEU8x7Hsy2PVC9+ToyER8DPumFqmbYCl8hIAcPPJczRWb6+90
	6lXn9cnrIOwhPFsUpXkRwiR8oJ1gYki1NnqrYekjCeeDeNkrfrKcwrXdTlGpzgVn
	ABb46/ZaHVbrCEsPDE+PhmWGjdtuKr7zv080lBNLS6X/3/x6SiwtLop5reKOXmQM
	4TEhevZWhLy0rGfwm/ZH/FUWrZbRvR1lSSi+vXKRgtp71RgFmyUNUDyZPTM9Vggi
	L9ZofDgB8tXTCBIJknApxw2HnFnuciLYF2hbP14yTvyOmYNxnDcfTNz9wr7Dtpz4
	SmPJXA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982de91wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 02:01:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77cd58a9939so419676b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160893; x=1758765693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eb6fb+UFN97UGMhPu3oieNOs4MieyvfsC2uXdQt5UHU=;
        b=ALcwgVvJQnho9q2SyOkksWzAF6o6I8Tpbg9kNRPFp0LQgU+rWQO3vZwCfNI2kket4E
         WYGdtywD85QWFIN/Q6E9UBz1auFVieZUwuPfqzCb9cKban32xPLyMewaw99cAZH/zhLA
         t4rANhbMPOyucB+S8LrhENBMhA30ZRtoiW4JZnmAyWWBdXFhEQXbOPfGmxonAzWfkCIc
         mz+2Zsrk4fuuJK+sJSinTTYp84r3kOsYSaiVTMfB4WcMTVAldGqSZkDqDQz6MM1H8pf0
         l5/KUeYnw/BPWPhuVTG/zJ3z70zU4en5lcPfSd4hDZACPtrIuitVyF+FNPZfkkrhlpbt
         R0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTbRXQpo22boFa6RqMygO9MsdIqCekhexnsS69BVGXvsePwm+GLBPcmSn8/dnH132bvNbf9HOt8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5mqh5fUSHdvMB3jIvfGsNXcULo9Nh/kaPM3OyUUpDJc6E23S
	ghiuyzRZ0qiS581omT+iCbeZcAd8TdePYo6UtMW0ZvTVgp2qo9hDcXyt/dVjpVuTEGe+CY3g8nu
	mLkVg0yAHIWZj0Tlg0JcLehKAI1MYnnFxWKSeLMuewI0ZBhVZFe6/BH5fS15l8g==
X-Gm-Gg: ASbGncuXbt8ukEv0jpDzuIKnaeZnYzWp7kbHM7XXkgpLQyI+T/Z8byvFVY4DCTw5/1w
	HQGErtdolmOjDeIMAahMyGj2UeAGIXFfZXHsoEIxKrlWKgbAzBTngPBL0anE5hWwF5z74zh2U63
	oYUKaX39IerDMYHdsV30UmAyIgeeo/sNrFuwfWPvdmK7TU8KRS74zIqTmblalTplZo6dj9T1BSK
	OOGAoaZe0lscMtv6fpE07iBOvEybk/MT/ZuKE72P6XuWdOnQWwaRIb9QA+lD9rFGqAg1Qd6p8+w
	TXRXYV6B+TKkehnplGaN5+bpe9B8pCn/4OCYuBXmKMtcuSy43lzwEUpnNESLgL1xow==
X-Received: by 2002:a05:6a00:3a1d:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-77ce08f3559mr2056197b3a.6.1758160892869;
        Wed, 17 Sep 2025 19:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzPSMD+5HGPO/cxrBCgCsxRrR2tgIDSepWt3elrwuhXweOPyoaFCCEh+2YZA14TET9o4YWpg==
X-Received: by 2002:a05:6a00:3a1d:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-77ce08f3559mr2056145b3a.6.1758160892313;
        Wed, 17 Sep 2025 19:01:32 -0700 (PDT)
Received: from [10.239.30.180] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24b4f6sm703065b3a.37.2025.09.17.19.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 19:01:31 -0700 (PDT)
Message-ID: <d9db8b82-9000-478b-a7b5-93792f1e1bea@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 10:01:24 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] power: supply: qcom_battmgr: handle charging state
 change notifications
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
 <20250917-qcom_battmgr_update-v5-9-270ade9ffe13@oss.qualcomm.com>
 <fa258ad4-1efa-4fe8-9636-d70c5ea9c8e1@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <fa258ad4-1efa-4fe8-9636-d70c5ea9c8e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cb67fe cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8
 a=0T6ucZLnF1w6DCYMrR4A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: d50laO4iFfDVKMf6XRRfyXz92EnillvP
X-Proofpoint-ORIG-GUID: d50laO4iFfDVKMf6XRRfyXz92EnillvP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfXyvZyWoDB2pD7
 +abLjzzohvcYSY2TfUhsXLCX47w2sA2KAeznWIH3Z24bfSDoBhdwjFCiyS4FnRRo64he+45FaSE
 d+P2mugunD5krQ3B2VdMDg9ol234VZ/VMXpggANgTmrAGZOAVDlv8S+AbQzNBeF+E+/0DDPyxtf
 GJlD82l7xFY+Q1TCBlFFD3xjfLZtEhWExnTbQUdPSoDRdbjo+grUDiu4nzyqWPeMlJAS5JSqDhQ
 tofjvcPD97iAcGOZGDgExbujBkgX90wMSdw8lKAVfudQoinBQPLJ3RnvJxDpl2UP/oTAktBhpWz
 KUF2N+jJGK2eERNgN7HGQQbl4P/6BSDFUe/P59EgQ85UkIioZcFugTfhKSlU9TX/zn2hz8AGGm5
 1fOavhpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182


On 9/17/2025 7:14 PM, Konrad Dybcio wrote:
> On 9/17/25 12:15 PM, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> The X1E80100 battery management firmware sends a notification with
>> code 0x83 when the battery charging state changes, such as switching
>> between fast charge, taper charge, end of charge, or any other error
>> charging states. The same notification code is used with bit[16] set
>> if charging stops due to reaching the charge control end threshold.
>> Additionally, a 2-bit value is added in bit[18:17] with the same code
>> and used to indicate the charging source capability: a value of 2
>> represents a strong charger, 1 is a weak charger, and 0 is no charging
>> source. The 3-MSB [18:16] in the notification code is not much useful
>> for now, hence just ignore them and trigger a power supply change event
>> whenever 0x83 notification code is received. This helps to eliminate the
>> unknown notification error messages.
> Thank you for explaining the technical background.
>
> Please hit enter somewhere in your commit message, this is a very
> long paragraph, making it difficult to read.
I just realized I made a mistake on the bit position, it should be 
bit[8] for reaching to the charge control threshold, bit[10:9] for 
charging source capability. I don't know what I was thinking when 
writing the commit text :(. I will correct them in the next patch.
>
> I believe this maps to:
>
> 0 -> POWER_SUPPLY_CHARGE_TYPE_NONE
> 1 -> POWER_SUPPLY_CHARGE_TYPE_TRICKLE
> 2 -> POWER_SUPPLY_CHARGE_TYPE_FAST (or _STANDARD, I see battmgr code
> reports them both as 2)
>
> However, we already set it to none/trickle/standard(taper) based on
> the usual notifications, so I'm not sure if these are more common or
> arrive outside the normal state changes - if so, perhaps we can take
> them into account as well?

This is not related with the real charging status. I double checked in 
the battery management firmware, it is checking the charging source 
power capability by multiplying maximum voltage and current reading from 
the PDOs. Any charger adapter with a maximum power below 60W is 
identified as a slow/weak charger.

>
> I think it also warrants a:
>
> Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
ACK
> Konrad

