Return-Path: <linux-pm+bounces-19241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851429F213D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1718878F5
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 22:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF821B2192;
	Sat, 14 Dec 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lxq3Bxan"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7011B0F19
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734215191; cv=none; b=GJHGTdBCBxgVgVcnbVUiVwtOMEscczizLXMZcDAEH3c1cZss/ZI39zG0WVrtrN7d9WPUbtpjSwjhgwmHM83wDBUxZlf1sPkepDii1n8MD1067pNuuY6OkwbMm8uPgj6fka3u4CqhPTk6YeomrGwKf+9XRf3e+hQVykcOJPE3ZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734215191; c=relaxed/simple;
	bh=ZrDNWfmtdISpMYkUeSLoudxH2n1f4p59UXdWu7P8JPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB/RKYaZJO86Gq1csgKMb1BJ0jynsMlh3tfTqnc0gYYr6b+6xRt6ZFNnJvre0zPB1OeDg1u3mxPOBmPEyHbAtvaEpbuVryMPT0mx0s6S716HEF2Jg1+rB6ynHC8M34PMwMUPqPUohr/mlg4I6a/GMhBLWMhKTPhDMHheHQ00Ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lxq3Bxan; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEM8UM7030764
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 22:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s4QqG3p2KHd1ypOB7S0ihhuqmQZvhM442cAt1pqnT+Y=; b=Lxq3Bxancb7SACUk
	clsR9K1LXjuBbocbljgCiNPZPmfeMPSCi7woxM4AQEH4Uv39kos8I81ayn3y0qtl
	KYQ5AFs4sZVqv5LufmzZbklvhTrBvNhi59lD6z+9xTMt05rXLqCaXmXl8f4Jvix2
	px1qjuFECFUiTBkTw8i500HmOHaRUZCuKkMzH5cN0OisWt7ccBN7zlbgo2uKZij2
	J05CVpIHjrv/OguIEO/ZHhvlFiMDddl7EtzBmWG3A5djpcuKPvA2vd0GrUsVi/qA
	4kavjt9e0d7Mi5GHwSLsm8KDBg5WGdUaZBwoflQAKKTgoYecj5CuVaJPmI2FojDi
	1xQiUA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43h30ks3g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 22:26:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-467975f1b53so8171311cf.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 14:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734215188; x=1734819988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4QqG3p2KHd1ypOB7S0ihhuqmQZvhM442cAt1pqnT+Y=;
        b=jH01dNRW2EnFzcXj2BU9zBZ4oquHzyeRzR6b2I092zDi11dZPMbg961q7NGEs+McJM
         ONU9P2U5EShOMX31lei98AxA9LOiaYomtuSHPnNjmX1GFP7qW+5Oq6/vCS6HULGKB9f2
         mOz95YQJPtgm5cIF0Mkqd7UAp88JdO1tronj+leVZJENPrP5wGKkVKDMBuYYJCs/DF7L
         qOnxw6FurU+jWhlD9wZ5k2olJk190/NN8mNB7Umy568y2cySsq255W9V8awbtRdhObaC
         /T8eeYS1rZMghsuU/zVbbiC7xF+hIz4CCiihRGAj/RF+1Zgf873yNrVaTubcKC/K32qZ
         /sSw==
X-Forwarded-Encrypted: i=1; AJvYcCWIGN85WqKUCkyZ8K2D43Zp3NSVewgQSnUdDEwMap106Jv0hLbKEI8QesY/T8lKeegFo9LOHNC8zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Xedhw9HH1yaloQbgGlMDaKc6rzfo2DwWzEXNOLOwetx8esV2
	BNaU2b8ZavMs+4L2vCrflg52sI7cosLwNyjCxy4vDLmYUqhHvT0If+GSY21dD2xqbzXtYPbjEM7
	Yvix9E64sueUHe9vbjjSPuABSHDAnhCgvxNohbfk/RfTgF0eae/waZdkl+Q==
X-Gm-Gg: ASbGnct1NkwbG8UZqo72EJPN4nRH32xnN2NCYkj5NcG3g0Hu8vHvzXXXjMmnM7taZma
	Ak0So8rX54p7Wrd1TOHSgWd6zxW60e/jRBR6+zxRVeEIuJ1DXWUGuBAYnu+Y4zZdcTZfQjj7qus
	iJIWn4wOuAhWOQsfVzJbD896STZguVMoNr9/T8ZZZK4rKz6MPmJGMUVGstG5R1sS/4Cifld3xCd
	/49kM0OfZ7B9VG5IAEaBjKJTC21de91cohJMGV8qrVgbB+7Ix4Y883WnTLpNVaJagojm3+E8SuF
	qDcir7toeYlsqIvj2AX6ciHWYaypBR9R17g=
X-Received: by 2002:a05:620a:192a:b0:7b6:d252:b4e8 with SMTP id af79cd13be357-7b6fbf088c3mr401378485a.7.1734215188047;
        Sat, 14 Dec 2024 14:26:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHasR3K6p493DFjUDFsgFM7Uolbcjk/4yrc72sMuH+zSyIX6k46ZL84uYVCjvNS7JZ/TSFgJA==
X-Received: by 2002:a05:620a:192a:b0:7b6:d252:b4e8 with SMTP id af79cd13be357-7b6fbf088c3mr401375485a.7.1734215187709;
        Sat, 14 Dec 2024 14:26:27 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006b29sm140887466b.28.2024.12.14.14.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 14:26:27 -0800 (PST)
Message-ID: <5e33ecd6-1307-47c6-9f57-2f7c98ed1272@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 23:26:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] arm64: dts: qcom: Add Xiaomi Redmi 5A
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev
References: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
 <20241211-msm8917-v8-8-197acc042036@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-msm8917-v8-8-197acc042036@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XiCRubZ-jjfCNqF2jdXzqpCMmCgVjri_
X-Proofpoint-ORIG-GUID: XiCRubZ-jjfCNqF2jdXzqpCMmCgVjri_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=820
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412140185

On 11.12.2024 6:59 PM, Barnabás Czémán wrote:
> Add initial support for Xiaomi Redmi 5A (riva).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

