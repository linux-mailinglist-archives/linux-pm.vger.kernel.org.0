Return-Path: <linux-pm+bounces-40263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C642CF6E87
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 07:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1183012DC1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407A306D3D;
	Tue,  6 Jan 2026 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0QJ4LOz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FLJdTeiy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93582C08A8
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767681073; cv=none; b=TVIejOt9HGHzPfKylOMKms5cOLrB2WkRTMzklu7UIUdOAbPsGBWG+QpgVh0bYSUwhkpG2tr2m7yrsQuLEElfmGHv3CUe3exf+3WLDJdv+056N2UX0WNUfCaar3diUpF6L7z86TrF4iH3mdI2x/jojvvOT0VcTB5bUS97sASehz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767681073; c=relaxed/simple;
	bh=Wov/qB67vp8gz1l2fIooRnUAV2nxx01QDhoiDuwqOdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQ7lWIqXaLrYBgWBmpYXxTJMq2ZW/4tdl2Z6yYBNYYnNkcGgAd81LArU59FtbtPhfTDIvE4kUHippjS9X1+DUl083TdfCfjdKJixtqx2mK6R8k02JNlDzi4T4QALcKWJPdFSoxHyWPHOXTvU3J/idaqxHKF+oJAltsjFZ1ZtRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0QJ4LOz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FLJdTeiy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60649YTe2255188
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 06:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RDWKmfMAAIQKR/wtVg52c2k7p6H/btOMvPSVN3ySifc=; b=n0QJ4LOzR4aY0S7E
	CAsIkrc+bylTq/cjMlqCNsdZwO/wIphHWiSxSIGsv3xEsz+M9hBPHtzFwHSFwUH/
	1sDbZ5cgrjRlbpFDhPk9VpTCxrz5Vee+sOEq0z49NUkp0ke+heuvhwGoz+kHOH5Z
	0HTOo4P7KIjA1hgfw56bnWHDPfyHTBlE75eLmpRgtDOAsDmzlItTUy7nJ/Nbz+gZ
	XfPOeAQPm1vZTKXIEGHRuUZqETIgIBfUKiUOKc57b/lg7Is2rfjpvvE5alzk0L5J
	CcnYYrnjDrnKqg5KJyZTSm39U03bfrEkq/i1jwokIPk3/JRP+zB5Pn7uSqOSiP5P
	GPmNHg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu420b6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 06:31:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so1514865b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 22:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767681070; x=1768285870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDWKmfMAAIQKR/wtVg52c2k7p6H/btOMvPSVN3ySifc=;
        b=FLJdTeiyOO1ORDTxbTSgb0qJgWJooWLqZnI+w8bkBTrADfUwE6NykLlODPKQqFqadt
         WsaUCDTlOkS+DCqTEo9cneWFAjM/ekt8GG4N8zcjlrGbkfNVVvLtEpBvgl4/e4HGp72w
         o9i3ag/TyajMgVSLJH8GYbFrAW6drR2+T5qDGqZvq+SOe7baqJSrLJfLP+litlm9Yw6R
         etIKnV8jQurjx4NFxLjX3kutjPvpngmQQMz5iZR8yF4AbhMTJWIsF14NO0cIwJss47MV
         zhc0ow48/EQnJP2smjxPfTuXk6sSKnSmsonF9uY/9hFzgjEs2QjKzwciC32Ff9BtKuEL
         FSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767681070; x=1768285870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDWKmfMAAIQKR/wtVg52c2k7p6H/btOMvPSVN3ySifc=;
        b=OzNMb72xSrex8MicJLeO2t06AMwGbkPbKqLlej9XglA6U9VfvVujf6oC3WbdbZSDaL
         or786acWmRXNQLqyTJabRhb9iPocnUjKigSjPfjqYw0xp2nd1D8RwjKiD8CjaTy30443
         pcQlG6CyWYIKMYa51CqZ97FvJzSb5+HFMDHWhE3304ttqMecK6SZKD/agpziVe+cQ3F2
         JWbPFFTp3+xQO+CrQSm9s7hetaA1BOxYJ2/Qx/OcM7MqXSz1RkioyZ61BiDm9Jntu3hw
         Qg3eWcQlc3LT0nTQx0KjT0d4MklMxt1w8y3O3dvQ6p+0kK6vPtAdKR6C+K3dliLO5Dt5
         ffdg==
X-Forwarded-Encrypted: i=1; AJvYcCVlCPV0c7pchOSnwQTEyWip4RUi8uZAKtMxkJBkN/ydEDuXs4iQIhew1wonuZyUZCLdxRXkro12mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdZB/GkRQyHmfylKnaXUiY8+rmIdSA5eItkI+wx1dZwjFWdH9
	pUc1roNpG5PU15KILcv3w7/MHngOu6HNzVXsMwqcbPRmL8ft4rr2K/1qtqncrBEaoUIJ0QkKFfD
	WPbkOYxUEriB0hGtMigk34PLDpIpj8k4QHmGNxKqYxlVx2HLjZjqvhUc2xWPUhA==
X-Gm-Gg: AY/fxX5svRrC+47xXEkO9CIf8XMQXjeN6Ipyr9L4oGK6OiQiEqeMLGMTbepNP1liT5A
	Z1DSCw9F55vNBp2R0vQmni6+WGvJpHYsV1OOgMlOS+LyqDMbHhj8iz6DW4VdX6FFP3s2FMsc14b
	NzsIWwQltovQPRl4gZXuZlyeUYKmr4qviF/D5WMjXu2skCSBHZ9wOeqBsgQil2COcmv/h6OgQtA
	DLAUaKvpMwPZj+i3gKnOkT66B28icdzG+KYbaWubgQfs9fRIMUiSJBMxTyAMeTJAVcD9Fyr1f18
	ewjkQAT9tCYHB6vNo456mHa2ELS91xE7TlvXleyk2PIbqP1eTM4hGFa79dk9ElpcVStmijoktTe
	j4dCs2gv3xMsl0n3uKAYLXWLXuY9V2z1b5a2XwBoIQced
X-Received: by 2002:a05:6a00:44cc:b0:7ff:b07d:d4fa with SMTP id d2e1a72fcca58-81882be1209mr1870839b3a.56.1767681069753;
        Mon, 05 Jan 2026 22:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/vpXsfwuFIlKNlWeDvpXegR4zTXn7c2rAirDsOY7syntOF57m7Ik/8zN1pNoMFJhmyuAbiQ==
X-Received: by 2002:a05:6a00:44cc:b0:7ff:b07d:d4fa with SMTP id d2e1a72fcca58-81882be1209mr1870798b3a.56.1767681069241;
        Mon, 05 Jan 2026 22:31:09 -0800 (PST)
Received: from [10.219.56.177] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e755bsm992670b3a.48.2026.01.05.22.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 22:31:08 -0800 (PST)
Message-ID: <e4b01dc7-02dc-060e-d1a6-abd2c801a78a@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 12:01:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v19 01/10] power: reset: reboot-mode: Remove devres based
 allocations
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
 <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com>
 <acbb37a1-3189-4d4e-5c05-55b13cd40a7f@oss.qualcomm.com>
 <cvmtn335gwnl6rvmlm4vgyablsj735rknga4ffv53gpk4k7d6g@tt7ebuyusocu>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <cvmtn335gwnl6rvmlm4vgyablsj735rknga4ffv53gpk4k7d6g@tt7ebuyusocu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695cac2e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KAb_rDcQEDUYZVoDp1sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: sgkzi8-15CPU2LNyHg3q4LKtDwbFPDZZ
X-Proofpoint-ORIG-GUID: sgkzi8-15CPU2LNyHg3q4LKtDwbFPDZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA1NCBTYWx0ZWRfXxfhbWyzxZ4dW
 uIVrQljixbApAKOb94q0J8Py0fmIjTyIxYSCuxxGr71IHU998+swcMaW2tAEBDaVFagyxvdagMM
 8SyvRaQFXAP8rismK3Q9A3Jl60+KZWXRsFgzJCComoFLCxumnTl59PaAmtxgsfKnC6D2tGOidqE
 TtmwjVtdO7jEAjEzQbhEd/CugM62z58eiMs4dKOYz05RQ+Ff+xyceOPOsIJBbabbT7nXxWf8bUB
 nrWIRdmfSSbWlJTLzIZ5QX+Wi2ECG9S72PdXtxpnMf2epoA0SCc8yqzPmwMPMdAGEsPzc3QWbJX
 LXCk4K0E8iAer38gM+oHEwHYUL/TDwqx8Srx51vFUQqBTcWLzDxswgVasCaDuiTiX7BKgfBrMaK
 h+gLemHiU7zH0zONUrdKRPXzi30zRVN8xvM7vntv7RNARn54vQnDn7Wc9V3NabNUrwCxEJrnqF4
 JlcBiUQ4Nvlu+iNCRXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060054



On 1/6/2026 3:01 AM, Dmitry Baryshkov wrote:
> On Mon, Jan 05, 2026 at 11:46:40PM +0530, Shivendra Pratap wrote:
>>
>>
>> On 1/2/2026 3:35 PM, Bartosz Golaszewski wrote:
>>> On Sun, Dec 28, 2025 at 6:20 PM Shivendra Pratap
>>> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> [snip]
>>
>>>
>>>> +                       pr_err("reboot mode %s without magic number\n", prop->name);
>>>
>>> If this is an error, shouldn't we bail out?
>>>
>>>> +                       continue;
>>
>> This is not an error as per original design of reboot-mode framework.
>> The code as of now says, if the reboot-mode node has an entry without
>> proper magic value, ignore it, and, process the next.
> 
> Then why are you using error level for the message printout?

I have changed from dev_err to pr_err. Can make it pr_info. Will
that change need a mention in commit text?

thanks,
Shivendra

