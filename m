Return-Path: <linux-pm+bounces-23463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9769CA4F724
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 07:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B18188C0A9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F71CAA62;
	Wed,  5 Mar 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HJdg0bKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54C1C8623;
	Wed,  5 Mar 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156365; cv=none; b=m18RTqSAiGKx/s4weyk/kfUBhb69YorE2WkzIC95FRnpoxo4ew9Vp54ZKJU4sIPWuqdkzqCzlgihGTSKwZpzslAzXZfnhfBaziHDNt3KToRMBfkiB3znA2h2mtg0ukueyRL5yBSDpK5vWz1EkR3zEOoOVdgrupXnkh9BmdappX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156365; c=relaxed/simple;
	bh=cvzoZmF/vBEUTMkxhVqY1m27118/Iwth+47/mXm8xgY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXoRPqBfS+UxhPR3D9DSFHwk0rOOqres+uxrMGBk56LlVUezEx0entj2S2FDPaVw7X4NNTIa/boW0UM8rFvFWKcIXVaWk0AG8dqa9fBr6pDTVoAQs6RIKp4PoNTbdaz+YWF4R9G1kA7IKs/Q8X3xnCdXv/00V2+Tp1eVF9J+pW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HJdg0bKf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NA2ow013456;
	Wed, 5 Mar 2025 06:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vR5VynfP4MVglQhLx/xAmD1y
	EZynwRM3f/t52ykQK4Q=; b=HJdg0bKfDTybGFJpxIX6r+WogBtZej/grWeD35eH
	dviuxMM/9vRp2Q1VYo3EZoSLXWOhX2EknEcWzvOMhNfpa/unahbuVbYbEOgk6y5k
	S4THXrjrfgYcJIXOUeUbR/q4mWJ3A1sd4FqUtalRvinnxc5qHZ9Hs2QJpy8DFkLQ
	U5xwAiEc+T5dWNKwm6Enkg1b1x0Fxl9trwtiSSmdXG7D3RlVtUvNoB83PndBYN43
	7yrndd00vahDSd+niYOcPhpKzaPlymb3z6OSWYpNRXwey/29bhGHsIMHRL+jPGjU
	hYgV8IB7bKFp6dpLfla8SLo5xnJGt344bYzMKlc0Wt7FlQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6wmabu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 06:32:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5256W4sK023404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 06:32:04 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 22:32:01 -0800
Date: Wed, 5 Mar 2025 14:31:57 +0800
From: Yuanjie Yang <quic_yuanjiey@quicinc.com>
To: Jacky Bai <ping.bai@nxp.com>, <lpieralisi@kernel.org>,
        <sudeep.holla@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <james.morse@arm.com>, <d-gole@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
        <khilman@baylibre.com>, <quic_tingweiz@quicinc.com>,
        <quic_yuanjiey@quicinc.com>
Subject: Re: [PATCH v2] cpuidle: psci: Init cpuidle only for present CPUs
Message-ID: <Z8fv3X0Pivh8zbMg@cse-cd02-lnx.ap.qualcomm.com>
References: <20241120103749.1450017-1-ping.bai@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241120103749.1450017-1-ping.bai@nxp.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c7efe6 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=8AirrxEcAAAA:8 a=sozttTNsAAAA:8 a=COk6AnOGAAAA:8
 a=AUesVnU23U_Rn2rDAs0A:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6VvIHP9KaiVo-V4QU2O9xtOWpq3H0psq
X-Proofpoint-ORIG-GUID: 6VvIHP9KaiVo-V4QU2O9xtOWpq3H0psq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=939 suspectscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050050

On Wed, Nov 20, 2024 at 06:37:49PM +0800, Jacky Bai wrote:
> With 'nosmp' or 'maxcpus=0' boot command line parameters,
> the 'cpu_present_mask' may not be the same as 'cpu_possible_mask'.
> 
> In current psci cpuidle driver init, for_each_possible_cpu()
> is used to init the cpuidle for each possible CPU. but in
> drivers/base/cpu.c ->cpu_dev_register_generic(),
> for_each_present_cpu() is used to register cpu device for
> present CPUs.
> 
> When boot system with 'nosmp' or 'maxcpus=0', the cpuidle driver
> init failed due to no valid CPU device sysfs node for non-boot CPUs.
> 
> [ 0.182993] Failed to register cpuidle device for cpu1
> 
> Use for_each_present_cpu() to register cpuidle only for present
> CPUs.
> 
> Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1..00117e9b33e8 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -410,7 +410,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>  	struct cpuidle_driver *drv;
>  	struct cpuidle_device *dev;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		ret = psci_idle_init_cpu(&pdev->dev, cpu);
>  		if (ret)
>  			goto out_fail;
> -- 
> 2.34.1
> 

Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>

I meet the same problem, and I test your patch, it is good to me.

Thanks,
Yuanjie

