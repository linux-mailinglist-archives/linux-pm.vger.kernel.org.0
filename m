Return-Path: <linux-pm+bounces-19940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEC6A0095B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 13:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4C9163E8E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B92A1F9EAB;
	Fri,  3 Jan 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJ6t4GHI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8819E968
	for <linux-pm@vger.kernel.org>; Fri,  3 Jan 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735907983; cv=none; b=HShdh8EYrYngjHBzYCDy5srxQ15SoCpDvLdjAWU6jfOZE0mKxd3p8Zo/ttNiUcdHVOc0mUkQr8sKPT8gc9aH2ih481Z52V6pLj+jFHDnwzeOsbmroxvSK8Y2Qpkv3L0nUuTwjK/hw/wLs51fpKsDGOVhiDayUdobjYFivNCfDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735907983; c=relaxed/simple;
	bh=+D/2I74qUnLCXLMzPRoFaIC/hGxKY9/KK+LLg+RYVUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEWTi9dVCZ+1fMKdkW0gDaSx8+0HV0ku2w9xr/fmbzayV18Kbzo9H+9OVeA0xnq4ShMK/RUYAmLYHA4un+rq5XC8hhY0AkSOnsbtkXf+h1edthcMf9Ls3G0o17AKtUSifVpa5/hbY3Inf91OCDBKB8T3TM3tve8wKeVJtU4bSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJ6t4GHI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503C4DFk027109
	for <linux-pm@vger.kernel.org>; Fri, 3 Jan 2025 12:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lZwRh4PseLrHdLpqPBaflijRPt0Pr7IOxsOt0iWXhpA=; b=cJ6t4GHI6o5SsFAB
	OBjd647yfxLWmY4GJSY2O2f8qhUwSfZbY3ruB4AVdGlNPvsoBhppAywvPQpDZaSI
	CqSpjYTJScad1Sp7Mz5iXOfFgvgRPj4sEm0xfwu0wsXshr9xkLSgg64Zw1KK64Lj
	11ALx/y/01RtDaO7cDYBr9+Iz9SGdjcryeLbbc6zrgatqQuQsuacbT2MN3Aextji
	W4YRs1WWNYaZkA0QEvkAL3rRLiLCgE1N6sYY6q/uJh6LudBuRSsWqZCujNggP7NB
	VFzRNcOfBSj3c7quArXxaKT0Bp5zX5ISVCyxtobAyZWqkz2IpftwlxnttwteFRjr
	CJlqUg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43xfjk820q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2025 12:39:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b700506e64so27632285a.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2025 04:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735907980; x=1736512780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZwRh4PseLrHdLpqPBaflijRPt0Pr7IOxsOt0iWXhpA=;
        b=FdENQkvca1my9/8jfNO9Mhwmq4TXiB9aUNjLOmV5M8d1DdwQFYYztPi9ST+u4pS0iP
         ND183b3nmT5pERV7OfivZYlN77cR9HHDHYIxKFHZ+MWs06+dWyoMuVLJT+DkgwalEhYe
         CY+tUxIVVfP6hyBlXYDShLO8hJZe9u/pcNUNJNvjv04LsTpYsE+pvvGDamNYN7SKEN9l
         ADM6MtzkwVg9uyWsq0Sd0ShfiHMaR93+Yg5p26EbCjklMKd1MGJjpnmKOfjwTtDxq0BU
         XxiMbNykBhTjo4M4Hm2sIxeL2Y7D4u4lXJCvmziityidN7mLlfPI28CN/KIo/hurQ0hD
         /drw==
X-Forwarded-Encrypted: i=1; AJvYcCVrdSn6KZc87euz+11d38NwkBF5sU9O+inT4bEN8zmqmoGe6cXvIS9MOTKkxC9CPzrwFOWWrzDO1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLjBU/RnIqiCYjOTW1J9/emPumsOeeKZ9qhloPj1CDUB1XEMc
	F765y8yZitwspl43O9pDFejWjofvk0Aoxbckq5nXfYtNZD95pV5igyTIAA9JCnnm6pwS+8Z8QH9
	gD2pGH3tbioGLB90soap2wZuUKGtBGto7qheuL6YnRfn7sfNf0x/L75HWtA==
X-Gm-Gg: ASbGncuHKBMmklYZP/fTUFB8wVSY/OBx/9LkhZ/CpGTEtrQ7nqbohfAw/1FZMy3PYob
	aRoA4YlxW4g+c12/leNPnywn+FwSowbTiGpbrvxHgsZy2fmy2mKci4q/8nx89vZpx4qdo8ZmjOX
	Q+LmtvYrA8ywA1jZhiI1gfnwVdAQu3JpgNkwTksOyiW/NmVb0fVksYDWnhM4S5SJgJ3wOp3zMxb
	eRRt2bZMC2ECZsN9eOMIzJjKE5l3flRohFuaFrsx7ry7urTeMbsJzVrkh8zkAuTNfS6DOerluCr
	3zQ6GcOSqew0X6UZ65SsVX26canteV3tpEg=
X-Received: by 2002:ac8:7fc1:0:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-46a4a9b7558mr309385241cf.14.1735907979724;
        Fri, 03 Jan 2025 04:39:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9T35sLA9E07WaPbgvB2yIVdP5SW11rIxHrqYYRBRo/hP/Iuy8WbY9t+3R/LoFsXxymado1w==
X-Received: by 2002:ac8:7fc1:0:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-46a4a9b7558mr309385091cf.14.1735907979439;
        Fri, 03 Jan 2025 04:39:39 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe41a6sm1914071966b.102.2025.01.03.04.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 04:39:39 -0800 (PST)
Message-ID: <da74c183-9f4a-4b11-b747-35fc21252a4d@oss.qualcomm.com>
Date: Fri, 3 Jan 2025 13:39:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] drm/msm: a6x: Rework qmp_get() error handling
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <20241231-gpu-acd-v3-2-3ba73660e9ca@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241231-gpu-acd-v3-2-3ba73660e9ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q_9BKWy4nBUZEJdp7RtvErNVZYbDWC5n
X-Proofpoint-GUID: Q_9BKWy4nBUZEJdp7RtvErNVZYbDWC5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=886 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030111

On 30.12.2024 10:11 PM, Akhil P Oommen wrote:
> Fix the following for qmp_get() errors:
> 
> 1. Correctly handle probe defer for A6x GPUs
> 2. Ignore other errors because those are okay when GPU ACD is
> not required. They are checked again during gpu acd probe.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

I think this looks right

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

