Return-Path: <linux-pm+bounces-42695-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJNbEG0Gk2nF0wEAu9opvQ
	(envelope-from <linux-pm+bounces-42695-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 12:58:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D909514330D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 12:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770873016916
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5B308F23;
	Mon, 16 Feb 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+4CbngY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPZ9G7Fi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5303081D6
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243107; cv=none; b=jx9D93V56/QmDuR8UlxjeXl+kNVI0dK+CdiFPVa34rl1EQUTEFPz7tFvGBVsJHVdCxui2d0InoUCpWcUSLQL5e5LmLgnBdvOPwmOTfUWXTpSyxUpw/n0selvRJqvqVFsgkISg09uKKZxNnG7SkDFN6COWfazszbyOtljo8cvO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243107; c=relaxed/simple;
	bh=2OooSvG2whJSKkJTdjoPy7tsSXo0UE5qO+6648XFTYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWa1LrZ11tgm8x9Bzm23ZXv7PMx7crjbm7LH45kw1G91kn00QKe5PQczdlq7Eby5fYE4z6DqOfJo2l+MTkG8CQ1m4HU4RjpROphKEGzSWVB0B+BhemAqZbYySX1eLuEfML7whf34iNhbmOtpHGMWQcVTr9ThYn0/ojWzoQ/lW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+4CbngY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gPZ9G7Fi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GBHM4L3123820
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 11:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zi/BecWdHdYC4B4fsf+bAG0aGUqnDmYPyCY0bfoOq8U=; b=N+4CbngYHHA3XlVK
	ODgsg96iYBsO0hDps5dKFyfHSUHNZVVHMepyQmjFIWzPcU63fZaLB4gvY8kKcPyo
	YNMlY0Q3qGxEc54xuMxnUTjkE/FHKPE1TeqOiKlWf+m9Ur3qb2pZjpD37mZkPj7c
	k9ZkLRwdoIilCDvEf1XwlH6bOUmSyi7tkgjwlilQxlWxa+iPXnYk4NiwvWPP8DCW
	p0hddbCGmDkdyVEnWIL/MHxHmpMloQX11UPt5UpkUS0z5v0lyko2pUzsZuBvl/zp
	gYWBshQwqWDUIANMHn75gtPEm1BxoVGlIU/d7Ovx87UJ0VU9y8uvO4DyZEuhba+H
	TlDraw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cahtcma3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 11:58:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb50fb0abdso176383985a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 03:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771243103; x=1771847903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zi/BecWdHdYC4B4fsf+bAG0aGUqnDmYPyCY0bfoOq8U=;
        b=gPZ9G7FiF10QcDH1ZuJQjrXc1ZsnYZNvWNVzcb4QSAzifYvto1MchpUX1TbDUvNxE3
         rpvZj6oR/3gEt3ichj4XUyo5LggeOa2szCa+c8pERU8atVQU5ELsDg+EoEt7XQj3D9/W
         KLqXyUfidfGCE856tE6l30h178cnMMW/ydcD7Bl70S6FPm1rDsIZDB3imeTGRpKy5FWJ
         +qIObozfrOAzUpxhGIrm4zhGWQbl+jZ+bunXxB/LsXmvm8v7UeHUNHeKa80eHw+sIJpE
         spyAvjSl5rih3K7FgPzZiY05zEzmE2a3GNVYne7gwZXuju2ALZoB9adiHUX2rFs0KC8J
         55+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771243103; x=1771847903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zi/BecWdHdYC4B4fsf+bAG0aGUqnDmYPyCY0bfoOq8U=;
        b=To/uQj7bIM7jP5NE1g4nsOmA91Aa3JBo+T1516B1gd3he4FR3qSPVtBGt5Gd5525i1
         /jq3nQiDjqmcb37ceFKAHFDZc3BkYtT0B85vAOPP/dtD4TYFLBWPgYVU9w+xWJ/9+VdP
         1MXpTPeTsi6rs0rlhA9T027BCgma3DrEi9/QXw+0kWpnii6aNXe/TRDgndA4+sjqPsrd
         eXDNgjf9TylpnxRA3Ee2xDCygpRzsbtuC2nt6LlfbVWUe9eBmN0gWL9x8djSGIWPi+tC
         6Nn0gp8cyilYlPv6fimCSvp6eM7xJ9zNE18tguGvv/A1ESjzLkLnzOvfAV1Wy9XNitaT
         LqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP79EB5rOTr6IQX4Shar1IuSfWd5SpvZpKyxIFbyut9OnGbvr5f+FBL0mF1R3xoApVqB6cW6b+Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeN8Hps/dLAQk9rEQmj1Bra8ZT2kH4ulJ4kisWiepIppk1IIQd
	JAxuiYTIT+9TQYuZNTKDO5Sep/fcb4CoJpQUgYptqPbBgjyu+Xf6wonxUxUrNV9jLyW6ZPd88U5
	C/FyidDjoKRKio2//Ryf6uj/Amlu6d9wN6t/Zganvq7YKd1ghl0ZPlNjhyRmLyA==
X-Gm-Gg: AZuq6aJ61oPshnfupiw4OsM9Fage9K3MOcdSvDe6UZtTnmKDoeCuLmpwDa3hSnJnRKL
	EsBNIrUZIN/OekdmSC/vs+aBGzArodpoH3UJr60MFtfkvXeFdixcwO2I10zPQ7XssfoTZTurz3P
	lmIvgYxQArojzqMEZn1t3u9hSDJSdMFM9GtrEII5lZ+l1oZzqokJtV2sZLyEHLM0XThkZUrSgtT
	2B9umevp8br0p6930Ym94DNUOsXJwQLNIK/8tct324mlVhyOvf7xFkq3XsL1KCjpzuYrbHe/xDu
	VKtdmcOiSZH5iQW9yOnGRh6Rkrel5y78U2usRZaup5az7IxVP7fB1YNm6Dmr2oKABIuZpyi/lU+
	PCCtQZBuS90u/SboCXvUTr3LdMuV/VtiMwCciGXEdZsKZOAzHcehqLrlrpQEyvI/8bwUgo+toIy
	3TsyA=
X-Received: by 2002:a05:620a:7006:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cb408e956dmr1044830085a.9.1771243103479;
        Mon, 16 Feb 2026 03:58:23 -0800 (PST)
X-Received: by 2002:a05:620a:7006:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cb408e956dmr1044828285a.9.1771243102986;
        Mon, 16 Feb 2026 03:58:22 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc766554bsm250799166b.46.2026.02.16.03.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 03:58:21 -0800 (PST)
Message-ID: <83ae42ae-233d-49b2-a4e9-43ad879cbe39@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 12:58:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm660: add thermal monitor
To: Richard Acayan <mailingradian@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-4-mailingradian@gmail.com>
 <e72ede03-94cb-45c3-95e7-63dff0ca3888@oss.qualcomm.com>
 <aYvNX718diaXDsBy@rdacayan>
 <f1fc24ad-054f-4731-b982-4c579abf46c1@oss.qualcomm.com>
 <aY4br1BX9InqWUd6@rdacayan>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aY4br1BX9InqWUd6@rdacayan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwMCBTYWx0ZWRfX4nFHd6ayEECM
 +xS4YO+qxN9eGlyWTY1z/wfrlZ5VGrWtEw+TgyuVifl1u1EvT2QQpkCwgTVplVmB9/7wVf90nxj
 14IVSfEKf+mbynKow0MHPzbNN9AOYfxZDaf6LAGUWrWZQnChVGuoRbFlX9hNCuau3n+7mtqH7Jz
 QdjAPy+BRXsE+BbOI/UwN6Abgeq6SNUXgpvj3/O70tjyOlEnLXiEuYXMvodyfmxmVsqz91U4DFH
 W9d+eMF2U+W64q8PP3Ux64pqscU6rtyoaIAoJ8Si55c0Jjp6mJ8rET/uMa+CG0Dh+5MkCFqKLKr
 lxG/sHFSklN2+EHNcS3+1yYcUSx7Djjfa8s9QZvFQ6CwkbDtHUtAqDh6+XQYOPcr6G1Gbd3RhCV
 t/X6hmvnQDGZd0kVd13Z83F1czccqqCw1W/V+7dUpbDM96QilxKHy6rCflL+FFnnHM4VZv6DHG+
 lQx0eMgXc/7Ioth/0Yw==
X-Proofpoint-ORIG-GUID: v3NUQSzIokuNDMErJBFpwTn8WjDt9j3A
X-Authority-Analysis: v=2.4 cv=DJOCIiNb c=1 sm=1 tr=0 ts=69930660 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=-X_Uy8J1N6Iodyj9KHAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: v3NUQSzIokuNDMErJBFpwTn8WjDt9j3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42695-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,0.0.13.72:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D909514330D
X-Rspamd-Action: no action

On 2/12/26 7:27 PM, Richard Acayan wrote:
> On Thu, Feb 12, 2026 at 01:15:04PM +0100, Konrad Dybcio wrote:
>> On 2/11/26 1:29 AM, Richard Acayan wrote:
>>> On Tue, Feb 10, 2026 at 10:59:20AM +0100, Konrad Dybcio wrote:
>>>> On 2/10/26 3:18 AM, Richard Acayan wrote:
>>> (snip)
>>>>> +		pm660_adc_tm: adc-tm@3400 {
>>>>> +			compatible = "qcom,spmi-adc-tm-hc";
>>>>> +			reg = <0x3400>;
>>>>> +			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
>>>>> +			#thermal-sensor-cells = <1>;
>>>>> +			#address-cells = <1>;
>>>>> +			#size-cells = <0>;
>>>>> +			status = "disabled";
>>>>
>>>> Can we enable it by default?
>>>
>>> No, the thermal monitor fails to probe if it doesn't have any channels:
>>>
>>> 	[   17.728926] qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: error -EINVAL: get dt data failed
>>> 	[   17.728945] qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: probe with driver qcom-spmi-adc-tm5 failed with error -22
>>>
>>> Triggered by https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/thermal/qcom/qcom-spmi-adc-tm5.c?h=next-20260209#n945
>>
>> You can define the following ones in the common dt:
>>
>> REF_GND
> 
> Is there any (likely passive, if any) cooling device that should be
> activated when this goes above or below a certain reading?

I don't think so

> 
>> 1.25VREF
>> VREF_VADC
>> VPH_PWR
>> VCOIN
>> DIE_TEMP
> 
> Maybe this temperature can be included, but I don't see any other
> PMIC devicetree that has this channel ready-to-go.

This channel is internally connected and handled by temp_alarm, I think
describing it via the ADC just lets one peek into the raw values

Konrad

> 
>> ANA_IN

