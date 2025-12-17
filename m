Return-Path: <linux-pm+bounces-39647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7ACC74DB
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 12:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03CC630036EC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398F2BDC26;
	Wed, 17 Dec 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPATTgNr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gaQoXdUF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA071261388
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970402; cv=none; b=NnMdsiRQ0GDRNN4YERXFNMim7COq09rQyxAxO5aKPmqbpD10WEyABwmRDFua1T0MCSdwXSU2l6ENmA5+ZY8+6voNrEAPU8qqC0JlnQqWtX9zvf9tG9qYvt97NcVeU1+RV0gI26ErH8OPjPKJejU1GhUDm25HX7J7mt7Xr9IyfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970402; c=relaxed/simple;
	bh=EqPoMDbyqQevPFFWEYcU+ic6ViXZu/vhtuQUgrtP8s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF2DPVqr4worlU8Xhh2SrOfasf+vVFszkmf8sjK9mhoXZb4wQ2VmwISgidAj0+SObVwll2ujLCdfgShXz2h45b6xWyx2kVJldxkHRzmEsEQrgjQiTkPX7kIWPZISMfoAIZZ3/KRWkhamAalEIUwzMrFSgcZK/xRz3lHfelq2uYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPATTgNr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gaQoXdUF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHASj9G1591239
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 11:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nBDtvdhlEDZhHvSsqtGF/U9j4heSI31S4RRQPhJZkh0=; b=IPATTgNrBZdajOpv
	9priV8pH95usfH633zQ/XqF2n4/GahiYQrw7lpDsc6ySJckcfyN29zJ72cGOGNie
	heqfgx3lO7t1Z4uuIuOuOL/irPNQADVRk/AjSl1fW6s+dXBBjCraIlbK/2+wtF9n
	PcQlJjbfzWewaYULUqczmd/1/8/N78H6+AXUUoiQ6wpNFwlK407iqmzWSo6ddxEI
	OmSSKS1ynrP9+iOOoL95fQQCwyCqJO9dYlGAb7gUZ4bOssRajL0jgfBkqvboyOh8
	KG2/zP3r3+2ZAa7NKEta9QvBFHqvCxJVwCjh2k393mYBFnmKhrIYTlC2sScqUbVj
	de/u7Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fefj6hk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 11:19:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b9fb4c55f0so104823785a.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 03:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765970398; x=1766575198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBDtvdhlEDZhHvSsqtGF/U9j4heSI31S4RRQPhJZkh0=;
        b=gaQoXdUFRZDWuWmqKo25w4cqXqjUXFXuYpaqoF3LYefvusHqD0Dx0OpX6SL5z2L4xC
         5p54xW/WnHfRpfuQeygJK/dS8HCaIvApVDVB7sp+udi9otbpqkKsMmldNjAadofP2FvZ
         ilpgLiizGeeEpvm3PqUf0I3a6/g/mcJ2v9OI7OPeTYvqfH80glfwjn8TSoGBlzLwf8D1
         DGpuIEW1W83YD/idsLZITOQx5I7gEU+22AG57bRUO6/ysyeQSEtVKyS0MmvvSWZVx0c2
         m4Cl/xT+9qGhhy461Nw5VCi5Fx22JYK5mMH1kWhHNNU5Iu66n7kTcOyiU3hIxz4ofIYA
         7oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970398; x=1766575198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBDtvdhlEDZhHvSsqtGF/U9j4heSI31S4RRQPhJZkh0=;
        b=Pgtte41fLXEDo1L368mCnAa9imyZ1toAZp8yVj98QQxARG7zsE9f8Wk3X9lDTAUkQM
         cJRrePLAvu+or3Vm431ORGIiGsXld4c8AFiYqYkHNm+74IRWEHNrhfGV9ykn5dAqSL3Y
         XZefQmJNUIjsuKpkLOjOGWjK1Xr1gxkkRq/yACEXrPHxdFlfQs669umn4XXGsq2HuZ+d
         FezxNcAi2PiyWvWKUk4idjvEs/sdv/gnUXfLP0NVJdob67IQ96xQ9pw4Ai5Z52Y3zZLd
         P6TDFWjVKHpVWh7OFxPl328eS6YM6fUsPcdaVfWLL3s7Y2KKqhyM6bI2V/NaoJnmG9yu
         LzhA==
X-Forwarded-Encrypted: i=1; AJvYcCVijK1ak4cyHdweqFnShd9ljFuWgmyCO+t8IgWprquOvAllHXyxZjsablorExECIsXKIcgv18rfLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLVVt+XRF2MBhoWzv7/80pz9AawigIDVi5vIN/OFp156zfRfm
	0jTKKYMbnrMwJkBUEUV4MTEVgyeHE47Kxu/DDdEqRT94yuIMApyIjH/caqpRiX0K6/xu7WTnMZi
	MolDOfL4YXiY7Oo8SQ+gAXRQdPes+82CHjGPoML4mCwzokaOAVo7aYZ7y22QY8w==
X-Gm-Gg: AY/fxX6PGaNMIaivGievoX/iHYwi9KXPepauQHtS4QcLoT086JcjSFuLB1rp0KtwNHj
	63T9wUDiD934vIN4hmOUQxfc+/A1d7eLKwYbk/mnSQs602lRCfIRp43lHGdGQh/FgQbZEgm0RZX
	Z0w4mCe14yRus5sHAjGnuA2uUycqJ3V1w6Ap4ONvQsX+N/vi1ZEhX/ZZjI2mINPmri/fG+u7pxL
	cnQc8vzRGTUfNaEhb37VyhwUfpctYQegr68ZXzHVCdk/roDWRp1KH2OJ8xvvZvUDbkeGl6uLmPQ
	pd70jjaRz+BcNo64LTC73b4apl9OKJcnQw69fAFzfnCMDqz3K4a53wAn2hmyKhdfqgLgGNwUGAr
	MBlGsUK3bUemQWz1D3OECJ0sruVP6WgBKACMBDGKeW4kjZf3mj3v7oNacPvqOM+sR9g==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1806461585a.3.1765970398198;
        Wed, 17 Dec 2025 03:19:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFge+Ot8Zw7yp2wIqzS91rOTZFN/TvXmom7/Y/B5sLTWmVdGPc4FvYUkUgJ7xdMdTAk7wWBEw==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1806459885a.3.1765970397782;
        Wed, 17 Dec 2025 03:19:57 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f56b000sm2161167a12.26.2025.12.17.03.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 03:19:57 -0800 (PST)
Message-ID: <b7ed0713-ed06-424e-9ce2-1109005dd1e3@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 12:19:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: dts: switch to RPMPD_* indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
 <20251211-rework-rpmhpd-rpmpd-v2-1-a5ec4028129f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-1-a5ec4028129f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4OSBTYWx0ZWRfX1Xr6GFgs6H0b
 4IohNfI8JMmGnUOxUkes+/pHQeKf+0n4Wt/FG4Pt9HkaTPm8EYrftZWWIEkgM/1AvssdH41Vq3p
 Xsq4gjgb2tyQaTetDp8FIb2IlKUL/rU9L9Oxv4l2MJC5c1ghnARPuCiM7V/k/yd5aYEGopGECK+
 MqJVHELsXsSh130hZ2B7HBOHcN1dL83VTOZNJxfmtFs/4C0iwCgM41CQ406l0aoxnWEjAU+WYRR
 lajAjX5xN3NFAunorSzR26NnioYcsMTpEb+Snz08AHrfomGUvBjH32/dg1feXlfUoMX3rWazM9S
 MaDf29v84AINd0Djw7nVc6Z7xdZxRs2zaLn0XZFe9GnLxgtpPlCUaDqrP+UAaxIYn1xqcEZJf4n
 ilUGeqg/mZcbeyiVU9mBvSCIpv0FYQ==
X-Proofpoint-ORIG-GUID: nO0XUk6FQc-S3oy14prBrXmnE8xhxDMm
X-Proofpoint-GUID: nO0XUk6FQc-S3oy14prBrXmnE8xhxDMm
X-Authority-Analysis: v=2.4 cv=R48O2NRX c=1 sm=1 tr=0 ts=694291de cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=u_qTJo_YbU8fZNC4VkAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170089

On 12/11/25 2:52 AM, Dmitry Baryshkov wrote:
> Use generic RPMPD_* defines for power domain instead of using
> platform-specific defines.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

