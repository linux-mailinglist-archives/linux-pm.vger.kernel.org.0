Return-Path: <linux-pm+bounces-30681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7F6B01BD1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821C83ABA79
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C12980C2;
	Fri, 11 Jul 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S3GWZoan"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBBA21CC5D
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236189; cv=none; b=I1QVdwdEOH2cS7OTjfUlaYrOiCO8eTPyDAM8pG0KTRPPgLZXjR3nIQbQtj71a7hw2ZKeQTbrhUxjE54Budh0hxLI4QIpgAG9V5Q6bZxDDgdTuTBWVGyEx9JKNXZKjpaK+hUDsSWVR/k/2R6qpgdfWoBcDpGnfEyxr4WT/frddNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236189; c=relaxed/simple;
	bh=jzx49LWasGFGGlxR7Ivay1UaWJmdLn3HEDsV3AUB9C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6C7SfbXsrQ85tpfX3Q2n17SaUZlyXsjz/dK64oEp3YM00Z/5ybe8sa5FpYqJ/WEUk5sgC3f/H/VVBXWbSCJgn1vrOpzHrSBK+zhuLnGL5KK1eC6QhkZuT5aKRWfbsJw9LSFLikH9bqc+ikZbWO/5RmzD5JeRo2D7an8Gd75QjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S3GWZoan; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAUOuJ016277
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Ptpi4wEY0VGWKqhP6TpsQQpNA7vOEtkh/zteGyElO4=; b=S3GWZoan6d/rpmox
	q4U0H4l9UhJz6raT1pEsDusqo+f417src7m+DQAdVZB7kQtM0gQ6fbZibMCLMqIq
	1QqgAhdm84nWqNbsz8yJj0/L45TNBFWPxv+CyUbL6Kva+qVU+6lxMl0dPitizGEs
	MCYmTVlYh7+LmkmuW4iyW1sfVK609ikHEnfRn0BgQ48Oifo2Bd5Bxo+uEwyDSHBa
	FuEKVYdf/pHAvU0XpV2a4POtgq4z2KkQNUypj7blCgJaHzEb2HhLcDvmBwXtXyru
	+PG09gTglWi0/wrXXO0K1QrGwIIE1xJJ3knryTZRJ5VYKOlPVNJw51ZLO0ht5JY8
	a+4ocQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u4u2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:16:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7dfd0470485so15657785a.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 05:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236185; x=1752840985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ptpi4wEY0VGWKqhP6TpsQQpNA7vOEtkh/zteGyElO4=;
        b=UQT45owf2yq29WDDwDUbzQuMXmRz0VaZ79ccORwz6wxLvnz0AnnRpQsrP2UBpEXuvB
         u+ZEdw5zlmxnY57G8Fn641lwgPkv/+3VpREz+T5uU+G/8kIQkZC5zAl5yJqpoMIwROrA
         QsbMkErUXZ6xBG8Rdtoq+cRiKdayqfbkA26Hrkh10CM/O/HKC5nqkHQwzA/rPQCjdnHC
         LSxSdAyWbkju0knajuyTDjpOLcmwSRWwyUOaGK6DElt9LrQJUQiK/p6nr3PBIIWlwLfU
         Zrv0JVoOwWo9oRtTSZfrJoDnU2evYJ9cJQCljTTVxCkqOhydFji+GOL+pksLMqBbqTjE
         yWTw==
X-Forwarded-Encrypted: i=1; AJvYcCU/6nKPrHnocc6s/KShm1Zh7Q1XPUm/FitASJHWWz0koU/ryFWtecOBa9JbLFFZIuZcGQQuw7jyVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YysuRpOQ3L/aPKLDCrk8IvPUx/PC3CYrExIRbBkhqQilC2ewCsa
	j4EHHUcoAjbrr5YcSUBk1zHBGUaR1J3r1QBS4KCbuqrSd6GvNZPHVTShv2MgoK6uVPHhjCdCENR
	DcHbzz/4WI2XWPdoReIVJheRabL8MyZRtn//as3ZeDU4YJhumANdu+4p0gHoR+Q==
X-Gm-Gg: ASbGncsVEm+GrlN+Sa0b3Djl3T1I71GKoA2ExnGeoarXth10XNRQR4uUftcJIE0LCwb
	B2aJASI2isOnQ/U3dURHIC97odeGJUEhlFxfUOdYUyGoqAj5+qvMFnr3+C9UW502C8sVQe3A/5j
	gHhVTKpESFy1Ar6ZLSVbuTGfHMonbptVSE3N2hjufO82+Cd+YKpzh5Bq1vkYrd5mP57/A3iMS5P
	CzNn/ENh9wuEmmz7DdUXq+mhr05KCbTpcS9/PEikPuOzvlwDo0fxq+1xpwVqIoxtBSUe26jH/lz
	+HsX84gg0nP0Va+QQWpN1w3m/z8+nF7sVZEuCuBNbHUYXUSzKNGtKEUBcrw1hbmXTbMF/0w+tvy
	WwBR0mTX1GbrKKM5Iwgv/
X-Received: by 2002:a05:620a:4004:b0:7e0:1c52:685 with SMTP id af79cd13be357-7e01c522468mr49300985a.5.1752236185481;
        Fri, 11 Jul 2025 05:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwKjT0BW3S+d8V+GzTuZSU/tPNQqmTbJ/pUFGmyL6fSlH8EpT5RkkPdl3aoxFddiWPJQIw9g==
X-Received: by 2002:a05:620a:4004:b0:7e0:1c52:685 with SMTP id af79cd13be357-7e01c522468mr49295685a.5.1752236184618;
        Fri, 11 Jul 2025 05:16:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8265bbesm286528966b.80.2025.07.11.05.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:16:23 -0700 (PDT)
Message-ID: <0ef83a1e-38c3-41bb-8fd2-c28565f2a0ba@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5424 SoC
To: Rob Herring <robh@kernel.org>, Luo Jie <quic_luoj@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-7-f149dc461212@quicinc.com>
 <20250710225539.GA29510-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710225539.GA29510-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0ja3-wd16Q8BCTyxRR84ZCeIiMCWXx8S
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=6871009a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=AWTENMeICeJJ9JQOPWgA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NyBTYWx0ZWRfX1lS6gTkv1/+R
 0ZA+8Grjwr9gY6AjhL4MmwUYHKuoD6uY/Qe99HPPbkqPz4UWAtyxmuBwGs5LRWHJ3DQT/BejzLT
 PKLT23+gd2EQdn6u+edcCeQ9cSt/+pJ+THlK20f0Znx69UqDnvYQ/cATlhTn4b0WdRifW3FMEhT
 jmmUIC87Qf+UuJDEu8hz1HPdKHozMAYbGbhjpsoqf+wGb4GgFk772dJBp+9BR5br8so5/TqPcoM
 iIwQ35dwfzXTAHJep7G4jJ5RCZybrOawUv91gGFBnSWknd+yrwRh6iqiaFb90em/vMDYzs5nUS7
 iIqInFd5Kh1Ym2nw9GenDRDI8I7ohVf2WyhM81CCNBant03+0s6pKAv43p2Kx/dI79c98lQ/XL9
 UDrmO8eJL1+NIJId8euCBJ4kOjJ5BDNU5S4Qz4OeeadZWRX0CtGcUBq7LnSyoV1shPeUI1tU
X-Proofpoint-GUID: 0ja3-wd16Q8BCTyxRR84ZCeIiMCWXx8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110087

On 7/11/25 12:55 AM, Rob Herring wrote:
> On Thu, Jul 10, 2025 at 08:28:15PM +0800, Luo Jie wrote:
>> NSS clock controller provides the clocks and resets to the networking
>> blocks such as PPE (Packet Process Engine) and UNIPHY (PCS) on IPQ5424
>> devices.
>>
>> Add the compatible "qcom,ipq5424-nsscc" support based on the current
>> IPQ9574 NSS clock controller DT binding file. ICC clocks are always
>> provided by the NSS clock controller of IPQ9574 and IPQ5424, so add
>> interconnect-cells as required DT property.
>>
>> Also add master/slave ids for IPQ5424 networking interfaces, which is
>> used by nss-ipq5424 driver for providing interconnect services using
>> icc-clk framework.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---

[...]

>>    clocks:
>>      items:
>> @@ -57,6 +61,7 @@ required:
>>    - compatible
>>    - clocks
>>    - clock-names
>> +  - '#interconnect-cells'
> 
> You just made this required for everyone. Again, that's an ABI change.

In this case it's actually valid, but should be a separate fixup change

Konrad

