Return-Path: <linux-pm+bounces-31981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD5B1BFC2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 07:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA76234BE
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 05:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388CF191F72;
	Wed,  6 Aug 2025 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7+wXG3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE681D7E31
	for <linux-pm@vger.kernel.org>; Wed,  6 Aug 2025 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456719; cv=none; b=NAwnLJB1xkKkajtYpXzUShMqrdygKZdEESeOW1RJNUiTDMfXeIbMX4O+6eBdVlkTW/pBRkfrJDUBbbY07pOpoVrtXruJA25r8qrrQynWB0Qzh1SrLhK/h6iGHi5fhmoujH94VLzwmFWllIQDl/ggJEr1E2K65KjBRjspFxg/7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456719; c=relaxed/simple;
	bh=PVqQ6wtrl5nEpndbCzGcHw0CEmGNEvKloJtWxKXQeEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cva7rZijpk9A9Q8CLtf6Mz3NsdOPWhIMP3pMT7q46VKyO/AxyGBPlStM1seS/p9WXVaYcaPWFdULw/4UiwRwzfEGYVUBbYX6KwTQEKYPNL0raY8iqb0PHD6FoqOh34sTwQ/7z04uy3TJGieP/utwJDZmmjjksMRRKzI8RQ30khE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N7+wXG3F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761erMJ008995
	for <linux-pm@vger.kernel.org>; Wed, 6 Aug 2025 05:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eJpmhwp2+qNhNACvd0DwKsKdUDtzWWHlSvICRJ6COMI=; b=N7+wXG3FLdjCgtOB
	Byi1fwQzkP2HjqFlMEH5ywgV1+OqEV5l3I8SHADlDzR2Ec9CM/4pKz2/v1bKunAH
	f9oMwDYCxJSgC4NnBJOB4qkr/V4w8dXEtkOtH2VRr4h5GWMXB/z/4eJK6neoTqjF
	e+rxdHZCEaOtHHWTh+XFLRZDIS6PIBK+WyaFPsbCWQX+MNo9avpZEDsi5/wAeDR2
	bM+VrI4gmP4oLy+elg4ope3+fjlJf2uoafDT13mqD27na3+BD2gwba9Wr9NpwPRM
	FpiF7WAbOCjH2OZ6ZSf7G2sEnLWxaHGswHqcGWfd/ehLLr+K3m3cb+7pxry3Wpb5
	5bTQNw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy89fpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 Aug 2025 05:05:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2425e41424cso47175025ad.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Aug 2025 22:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456716; x=1755061516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJpmhwp2+qNhNACvd0DwKsKdUDtzWWHlSvICRJ6COMI=;
        b=uYGe86drjwnL6PyCzhCFOecdKdwPpHVgXBMA7vt20mvNpM4EZM2rI4Jvf9g52LoBxk
         lUFVXscqIKChXjEfOG2Y5xvWK95ohl7mr0qhst7kqt/+3amThwxoGbLN7jZXGuokcSQU
         y4/TUUYWBK444qDuV3x+zA8f6F54If+FL/5OIP8kkZzUZXQXQdvtGd5RTZtVghT5Lht/
         bDwktH3BS03PeS7Sa69xStAi1yWDo+1PwoXh0ZyMAAD7XZsPg/CDdQRzkxjDrRHwFHwG
         0mNjSZErD5ZXMtZiRutIFGjMrg5kori8/Yg5L0uCimyLnpoIj5hmLV8X+p/FM4KI1746
         53Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUfloQOBzgJRawsiLHif4xE3BOGH/U0T5Jr4pZjUM2i4bWhUXmK3dPzIjrT8lsywy1BF2KH3s2UgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vu7Zd4tlkYz7QCpCop6eBBH0FfmCaH3zPi59F4iPO5qwB5tU
	ZyyD8aqxkJBajvctNyn+iXx/dMo/Trd8cRebxoF9O+zQAftRxr/DvCrBGSqptjoKiXqlP+WINJw
	+B4et6uY/7lqUcGv3BWyfDRbWVcyI3r7MfbTbxcUMiwjqgG/vc0WelWq+iL/aHaImGeZPzA==
X-Gm-Gg: ASbGncv8/XA9M+/7QzXmlYSHycai1JmPZxZmnYJPQz8ippcILqRNfxs/G5uPzHSe6ai
	dXWrPCBLics/3tdMUCjdU46ff6aKqlohYdxFMbX2r7ED/wIJvkM83mBzMvXb6mCPPZ3tkpU7lBc
	hv0rBRsClLYdA/TFXLRkeJmZENoo3jTpHLFK9sKJk5mkFIxp3pOV13t0OtOHzIEPz6JA0q/OLtg
	uEdtTz6QSD26YO9oUjCGXo7s9Pv30m1ObWs9B6nsRRglengyIfQ3sr/JyBMBFeh9pZocTUwATOU
	5FGauvTpHyeL904+05XilI6eqFxbYyW2jYM8ymBlHKYFTnGXeTWx1KKca3hWWAN/QS0wSqxqzw=
	=
X-Received: by 2002:a17:902:e742:b0:242:3855:c77a with SMTP id d9443c01a7336-2429f42cd9fmr25385575ad.34.1754456715139;
        Tue, 05 Aug 2025 22:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO4P/gghaw5vcTbD4LFu6tD+0oWLmkEJgxeJd+4qKXvJVceZgq/qMoTJ7ZbXwzENC0yZlQ1g==
X-Received: by 2002:a17:902:e742:b0:242:3855:c77a with SMTP id d9443c01a7336-2429f42cd9fmr25384945ad.34.1754456714518;
        Tue, 05 Aug 2025 22:05:14 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaa829sm146510685ad.149.2025.08.05.22.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 22:05:13 -0700 (PDT)
Message-ID: <6035a961-7c5a-4fde-b4ea-e9ea9d88e6c1@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 10:35:05 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
 <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iiv_CZydinDB0dX4MGeh_MHeUGSe0vz2
X-Proofpoint-ORIG-GUID: iiv_CZydinDB0dX4MGeh_MHeUGSe0vz2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX8ymT8WNruT6m
 Q8POemrlqAhVrFBna6V3nSr5J4kDojLgX0B/2VMERIDt5oFc1H9Rdslvw0BuQMRxj++UID8XNZe
 cSpQGKpsdOuD0vBZyqk0elhGN5hkyFLG4U1ocuSkmXZu9RhnlfDUNj8lTjfa6mRZZ0j5hfKwqul
 1K5hZ7xqQL0FSDl5TrGAjRiaOcnWS4qd/2hzkgsCZOzFZxKujYkacU2ltLFERrXQBFeMOiWQWyt
 Fv7RFmrZd3adad7pCQYUEZYgy5XjsKznN4sxkYH3TxKga2MtdEcbaxAFznDWzd3l40joXCVXCsZ
 kDFoRzodp7Fvi/TsbTx4rhgcCDsD90ciy/1ywWcDPvDfru5rwX8eYHbdbXc4cQtO3gKY/w3yXJU
 Yfxl8LBm
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=6892e28d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GvZj0uSKTECx7ubp4XUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/4/2025 4:43 PM, Viresh Kumar wrote:
> On 01-08-25, 15:05, Krishna Chaitanya Chundru wrote:
>> Currently we are fetching the OPP based on the frequency and setting
>> that OPP using dev_pm_opp_set_opp().
>>
>> As you are suggesting to use dev_pm_opp_set_prop_name() here.
>> This what I understood
>>
>> First set prop name using dev_pm_opp_set_prop_name then
>> set opp dev_pm_opp_set_opp()
>>
>> if you want to change above one we need to first clear using
>> dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
>> & dev_pm_opp_set_opp()
> 
> dev_pm_opp_set_prop_name() should be called only once at boot time and not
> again later on. It is there to configure one of the named properties before the
> OPP table initializes for a device. Basically it is there to select one of the
> available properties for an OPP, like selecting a voltage applicable for an OPP
> for a device.
Then we can't use this dev_pm_opp_set_prop_name(), there is possibility
link width x1, x2, x4 etc can also change at runtime.

- Krishna Chaitanya.
> 

