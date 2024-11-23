Return-Path: <linux-pm+bounces-17983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45779D6B38
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 20:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF4B2244A
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02231991D9;
	Sat, 23 Nov 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZfwFLNaZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FED225D7;
	Sat, 23 Nov 2024 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391021; cv=none; b=Led9rabl7vWuCDAzEwcsOwJVX63FXLWv66ygPYAiitjbZCdHGmVdZ/R5b7+KRKaBhSsFJKa+ksgx3KYU7xyD/oXk1pI5A5UGLkogsxYAgLzUECA9haCVrl8ujqCuw777VWvD447E+ZNN7TN7wp1tcfFhPEYgS7SXiroMENdWq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391021; c=relaxed/simple;
	bh=tGPOgclemoMu7/cMWJ8L6U5QW//GoJwlV7nmam601mM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9kAAy//Qv7Cvm0M2a9OBw7ta5seLReNujvfUJdggNZYVkT42bmIQo9DR3X+qQppWPYzY/WcGJV8GrMhPr1UtGg6z0m5WBKwfu1ca00rMahh3RY+xks2dsETHRF6clfw6MKIENG0nwhzOOg8FAeIBaVQtHwfeiRkJ2zuzDU6Wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZfwFLNaZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANJ2ZDL021590;
	Sat, 23 Nov 2024 19:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rTIOLT43gtxqh17Vq7x24Lsb
	prvLiFCTG8dAMH1h/xg=; b=ZfwFLNaZIiMB+elaiYXtRH7SsQtiD3CJfEbv5/sq
	ZLKJQufPK5OUYCPjcIdFxLfXOAC6ZTSgqRgQKwv09P1TIWZ2W6GGzQJtYPTYiLsN
	C1xy6Jr9KV+zcMLuyzAQXZlLk3XgQv7r5jEobBalsSwigCjHWw9ghlXfouSRjWiN
	BJ2/I0K/dU+SIGMT94AMMs+oXdKwWYpQbMyKknVv6Dk3pmh7ec8fQN/k5HtADLDf
	t/aj/9ACnH+PQeRPgbLsOHpr/Q0gi7D5TVCT8Z9ekcQPTWr9zZuZj0xR+I4nSeA0
	KGWggdO2zIZ0Z4pgnUadBhvT3/dVx87o9+PV4AyXBfZeFg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4338b894c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 19:43:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ANJhQJ0011605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 19:43:26 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 23 Nov 2024 11:43:19 -0800
Date: Sun, 24 Nov 2024 01:13:16 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
Message-ID: <20241123194316.yqvovktcptfep4dr@hu-akhilpo-hyd.qualcomm.com>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ryrIuRNVzSxZaJQeCU3vSDCY0aamOJEC
X-Proofpoint-GUID: ryrIuRNVzSxZaJQeCU3vSDCY0aamOJEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411230162

On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
> along the Frequency and Power Domain level, but by default we leave the
> OPP core vote for the interconnect ddr path.
> 
> While scaling via the interconnect path was sufficient, newer GPUs
> like the A750 requires specific vote paremeters and bandwidth to
> achieve full functionality.
> 
> While the feature will require some data in a6xx_info, it's safer
> to only enable tested platforms with this flag first.
> 
> Add a new feature enabling DDR Bandwidth vote via GMU.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b562bedb96cd391dd 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -58,6 +58,7 @@ enum adreno_family {
>  #define ADRENO_FEAT_HAS_HW_APRIV		BIT(0)
>  #define ADRENO_FEAT_HAS_CACHED_COHERENT		BIT(1)
>  #define ADRENO_FEAT_PREEMPTION			BIT(2)
> +#define ADRENO_FEAT_GMU_BW_VOTE			BIT(3)

Do we really need a feature flag for this? We have to carry this for every
GPU going forward. IB voting is supported on all GMUs from A6xx GEN2 and
newer. So we can just check that along with whether the bw table is
dynamically generated or not.

-Akhil

>  
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
> 
> -- 
> 2.34.1
> 

