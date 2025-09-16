Return-Path: <linux-pm+bounces-34707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7094B58FCB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D81F1882F50
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E7528469B;
	Tue, 16 Sep 2025 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZqfDEOl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD505284688
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009551; cv=none; b=nIxFaqbYSD2wet5Gpzn2Qjs3gtn9XmnBOH1svuXG0ikznxWHloRvZ8TBRKnTDD79Mpc4pMeHEZ6E5X7wM11VOfPdwuF4nCihd0iEd1USu//cFhhpsMXthAg7ovJrdq8KexLhFVOEO4J2diUwXCFT+aGyZvf+hutPMnTMJF5SjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009551; c=relaxed/simple;
	bh=luXA3BAxwfQykxsWgqlH1n5LzWlMt8n5hBlB3Owwr/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fco6q/xP3r6PbLIcBVzF9uCIbyBpw7inf3mYwyGBP5X6+x7JWoUuVf07bYzEUNqx8dY61/l7b5qNDyFoAVDvmolAT9n+6C54MpqyJL3jQheBrAn2KnAp29/t6+PUVoXCZxOxDuTpdjjzAtGoJkdigw+/xZ0wCKoPswN8J6PBK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aZqfDEOl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3plvr003735
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 07:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bl6XIkWkFljciR/SPXMo9xgXQdmc9fkaHnQt4AwcHd8=; b=aZqfDEOlATWoThDM
	ovnK8QdibZ7MoP6MD4xtyQjIMUXl5SGGabYbOV0MOFfRcCtNDw1M4lwluURmWhKm
	iRLViQFxuKsDeTUoEFgpX4h6P0Qc4V+g4S16QTRdV4bozcGIXbbcNt8bNR0iOQ/n
	KXurKArH5gI0jOf/XdBpKcVmvJV9dPPb3YChdbIrJBjRs9+rUT9Xre3Sjv7DQimj
	11KucwtHUmvuDfIiZlVI3rRoBs7AaqThTRrwHVk4rrW/daJfMGJ+7DTBmG8r37us
	yipYnAwNOOG+xRAvLiIFtQG3HWw3Ox/VKdnogaOKwe2ZLYuvm1do6iwXRFfuel2k
	VGCn2Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr872q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 07:59:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b600d0a59bso20569891cf.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 00:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009548; x=1758614348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl6XIkWkFljciR/SPXMo9xgXQdmc9fkaHnQt4AwcHd8=;
        b=Sz91CuGPv+OZhFBTDmQDSGSiJlW0f1uykqmv1ajUzB9OGZ+NKtdWWZp3gBy0JnB1/A
         WAwj8Nnb5dx6GymKw4iNujpdCE+GRf270ToNARWEg1ZJTKtVhMe6JT3o4WXAsudGVqce
         0iOCVdUNpjGhoIRflpdwbsyi/3izOuS7l/ulmTyN17bB3ajoF5JdpNW67OQ91Gn1aARm
         e6M6bf1ipGYWn51QgyXYhXXRAJlsi5kQ+dc2G+qJhBG+/vIGvvKPMpfZgAaj8W8nTY/U
         rwHneW17H0F1C3YzZnUGGAm69z10mjaWseyBTjVX30M39st8LQi3tCd28s1tdYz7WrY/
         OAWA==
X-Forwarded-Encrypted: i=1; AJvYcCVeceG2HkJ63CojtOt8qkYb/xjxsyvKxX9nZVCLvoDvQgDCX50XRX4GP5347qcaZKm5PpIgEwxzSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZAE4rKfFf0XFgdpx5x6wOEu8kvehGFoTZnlEnzexI9jxvSw5
	mFYXPt9znfvdaQkI2dTRJJf47kFTbkF99mUzKNxfsg9OtJlFiyyZFhc3IdH4TLItGe0PLYhUdkk
	GETpxoFlrMhVPH5TTI0SyXvacJu15TgRT/KWRgOeZPYSdr/VGMxXV+FmiJ/QIoA==
X-Gm-Gg: ASbGncu5Zo7axd/XIi3hsNqKIa6oloArE94oZz5TmbJ07WCxVZ9EWy2CFCEGG1yONrH
	fnEdbTslVY+NyixE2W5hOm1JtAnZoRsSbjtEw/UCIVBbQ9cER7xUu6cmddWscBhBezRAluqplUd
	KpD09diRr8yRu5ycTWfv/RvpAYf7pIw3J0l1LJBj57r+MRPO29cPr+ceU7isOATXRo8ZUMU0uP8
	e5WR+pT3ybqpVsGlvOzKffWrqhSCYBowi0QeKVRoNJsImGMaEtwRc1eR7/X0VhK3f0cf7kiQRFd
	EiS23g5125fUR0LfZ8YQMaZECxaaFYC9vSp/JOzBazv3Oqr/2+djoEZt0GkeSg6r6tYGB8P05rX
	L0jvINy11BJvpMUqWc1bAHw==
X-Received: by 2002:a05:622a:1819:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4b79ae7518amr65238501cf.8.1758009547469;
        Tue, 16 Sep 2025 00:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmODftrEEwDnmk4gqtDucReWHiHbxT+KlMqX2icp9tsQ6afSGP7fT1h5VI8YPit50d0g7z1w==
X-Received: by 2002:a05:622a:1819:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4b79ae7518amr65238401cf.8.1758009546833;
        Tue, 16 Sep 2025 00:59:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f416db508sm3528606a12.32.2025.09.16.00.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:59:06 -0700 (PDT)
Message-ID: <5736df73-c90e-4f11-b461-c38da4e811e1@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 09:59:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-3-6f6464a41afe@oss.qualcomm.com>
 <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
 <0cf4b0fd-e468-4aab-9ec2-38da93435557@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0cf4b0fd-e468-4aab-9ec2-38da93435557@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dfCZk6RjyKXyfs1n04DLmUtoj0NCkIsN
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c918cc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=mNYpJT6RAAAA:8 a=BliEHdnzWw9z4Hsov9QA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22 a=eybOJ6GWDyyBfQoUqdmp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfX4caV38OaD4Mq
 eHCt4Qvbz98RXXu8Cu6GV9AwiSB0AyIt5orAul0nfUiDLdC88eLnwbbUbyAEfero6ZAe7dNU9kK
 t9azJhOneMmb29BJD5dsVDLUUiQ/YrEs7Im8xNcSfU+z8P00ehsRMKckWPvCL/0iieyA7DT+FW4
 XTf/I3ObokO+Lom1OVJw8M/AaGU5/+tuhZhO7huhjTnlkrchnrhSyJPvyZ3QfErMjodixdCAFTr
 bnLcdQhXdaaVAVQfpAgBRKGhdQiQewNF5+lx9fmPoROPHTCtrpziNJJ9vDR9HnmKwVJ2MNy1+VM
 3e/IM9KBCBv1bLUBXi+oYTq7FIHJNs+ibte+/P1vyWHYceUhXPnfArhzg9LlamWcACislVDPJLU
 NHiI7QuI
X-Proofpoint-GUID: dfCZk6RjyKXyfs1n04DLmUtoj0NCkIsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On 9/16/25 4:31 AM, Fenglin Wu wrote:
> 
> On 9/15/2025 6:18 PM, Dmitry Baryshkov wrote:
>> On Mon, Sep 15, 2025 at 04:49:55PM +0800, Fenglin Wu via B4 Relay wrote:
>>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>
>>> Add power supply property to get battery internal resistance from
>>> the battery management firmware.
>>>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
>> T14S is X1E80100, which uses SC8280XP-specific sets of properties. This
>> patch changes only SM8350-related data. How was it tested?
> 
> I assumed that Neil has picked the series of the changes and tested the charge control limit functionality on his T14S device.
> 
> When I run "b4 trailers -u", the tag was added on all patches. I will remove the "Tested-by" trailer for the patches with functionality not applicable for X1E80100 platform.

+ Konstantin

It's quite common to see someone leaving a T-b on the cover letter,
trying to say "I gave this series a spin" and then seeing the tag
appear on unrelated commits within the series (e.g. bindings or some
cosmetic fixes". Maybe some sort of an interactive (opt-in is fine)
dialog for "which patches to apply t-b/tags to" could be worth the
effort?

I was imagining two options:

$ b4 trailers -u --lalala
> Grabbing tags..
> Found:
> [Patch 0/n] Very Nice Changeset
>   Tested-by: Foo Bar <foo@bar.com>
>
> Which patches do you want the Tested-by tags to apply to? [all]: 2-5

or:

$ b4 trailers -u --lalala2
> Grabbing tagsd..
> Found:
> [Patch 0/n] Very Nice Changeset
>   Apply to Patch 1 ("soc: qcom: Fix all bugs")? [Y/n/a] y
>   Apply to Patch 2 ("dt-bindings: foobarbaz")? [Y/n/a] n
>   Apply to Patch 3 ("clk: qcom: Fix ABCD")? [Y/n/a] a
>   Applying to Patch 4 ("clk: qcom: Fix DEFG")
>   . . .
>   Applying to Patch n ("clk: qcom: Fix XYZ")
> Tags applied!

As I'm writing this, I'm thinking option 2 offers much more
fine-grained control, which is always nice to see..

Konrad


