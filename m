Return-Path: <linux-pm+bounces-27512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BA0AC0BD7
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F551BA5D75
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D2A22EE5;
	Thu, 22 May 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCpmfFnw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B41922FDE2
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917965; cv=none; b=ekjq6dB0JwsmTqCI3vZ7SxPtOZOFuctymQp7gr6SxGlwpx1GrFu533qaFUbSvcJnk2HdyyjKMlJMGA1+m2QBHDO3RYR5ukWj5fIZ+C4Ijarg1rvZyANHfCl46wNR0g/Rc9Ef6hPUtPtDR05KTC/Ws8pUtKCSCdphLZIUJY4kEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917965; c=relaxed/simple;
	bh=G6qoqkoT+pTNDGZdq6ve/6OJVbQnJuz85yGz+aLGcFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVGsZIdHAdI1BdoEwxN4uHoUs9osWbj5I+JooOxNxlgdFlVbMVhiY0zPzglRifVOj5QWYsI8JYy1rm/mxUYkLw9fZvF2/6IezUDbkNglhzCg553GJXAEsovTT6MC+mG9gfxiwt2IctEWCzb0ouUw4gw3FzLpz6mtYLea2e6sa7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCpmfFnw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8J2SX011346
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 12:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hxb24Tzeo0KMUYFizXcVNuIL
	xkcDwZQp4t3EVpGJMhg=; b=VCpmfFnwhjd9rUh4BnrHyCP68FqHSMZOivsYYQmv
	EYV573MRARqhTEWXxTwOJMqnU7q68nJ7twCjev7dJxAq36D7UYhzb+LUCpOWShwJ
	aM/YXM1EvY7ODlC9BjPhNChyYpKgPBT++FeenKNPBUL/nGaPlEnUfVTiYRBYtAvQ
	ri/s9BGRsSKNUdfRNPL3eKW14zuOr5Ii5IHXPjTcxtaqg0n1CvwvjkQyoAN0HZPT
	bp6TXAwPRi4gIETAZqC68i/vvJwFI2wGPkG7jtjCRYRZMAJSe96oV2qLK4lrIKCC
	sO90xx27fdv2wjB4tuB6wDZnLOUREKtW10xV5vYDRRG2rA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfb682w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 12:46:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f8d47383f3so81827116d6.1
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 05:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747917962; x=1748522762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxb24Tzeo0KMUYFizXcVNuILxkcDwZQp4t3EVpGJMhg=;
        b=N/BMZGEc0+rdxr305HW0nylQV/Edx/3pfr0UXgOmALH42V7BsbbEj8w+YQq/Ym4bIZ
         b/gi/3xUtRpx4uZvgAM8rf85Ir1L0s4NJvGMhjctodVv1eEGJxT+6p2lixO31jykid7T
         ZM3ms91d2cMIcwxnpkvb44xcin3KPdbNwDiN5UU0JtRyYx8GLemCI/NhXTacJzhcXgcy
         ELH2azVINHZjyCHJJOPpZxOO3W+7N54BdGKfdY+F7cFqE6a1AexoczUYUXZn7/mvAYKv
         +hO0n1kcJvTGZyX19lhbiLNYpU6BHMfYvCl1cXv4oEtpNnXMlSEyQp3WQYBPYDatPemi
         p6/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSnKBE/R4e5DltLPj3/egRyfOI/xV3Wr/xC+FrXJuk6Si/x/HPyTdcxk7hgo4osAT8cgsogN2oUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCPSEWEmUEpcJSssZF+pSvQdPiVuZiNJD6uQauR6p3/vor+rf
	dSZYUZXGt0RXRwdcRK7RRrTLWq+MLhXi30GNjiFlwu38JvE6hOImtDMKmtBM7l0C0EEtv6/XTlG
	jK4iUPzaaAYzqKYhLZzVi+XASNqE3VaxtHQOgoYICneIB3KmjYwzsX9gxl6Shmw==
X-Gm-Gg: ASbGncvyGkeP95aGZWwPTyyR4Xqn0fbbmxaISC6UwrpPJsjwV/YP1KG6jmjdP55Et86
	Df8NltjajO1EFbTxNLPlw3NkTjcJxKO1yQs4HIcnmrPjoq3uFruGm6y+T5TfOqGd+m+gUJEr3eM
	1rystzVA/ZL7/5YcBBWlB+h12PBAKty4Gj96pXBzQBwcN/FX32Nf1iFTvg0jvljt8bhc2UvmMhD
	HOeHUfhfVrzYXBEYBen2I8bvRk5ytgWJKpyOnQsiLCURXhv+1HcWgbOQNCOTbCDwVL0LW45+XSV
	uQuAfr3UT1osJmF7l36SptPFmu59/lLVmnc+yZ8OvTgkXN6TDrxckHuNUSGWcxJ7+Zu0Asag4i4
	=
X-Received: by 2002:a05:6214:e85:b0:6ed:15ce:e33e with SMTP id 6a1803df08f44-6f8b082e9a0mr430704066d6.27.1747917962217;
        Thu, 22 May 2025 05:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFssdC80K92sx7xKrUev631XuatncvYaG62tDTkTyyXHOExAcKuWZ2mBRfrr9QTOcb/tyTgQ==
X-Received: by 2002:a05:6214:e85:b0:6ed:15ce:e33e with SMTP id 6a1803df08f44-6f8b082e9a0mr430703446d6.27.1747917961725;
        Thu, 22 May 2025 05:46:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f1622asm3384812e87.25.2025.05.22.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 05:46:00 -0700 (PDT)
Date: Thu, 22 May 2025 15:45:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] thermal: qcom: ipq5018: make ops_ipq5018 struct static
Message-ID: <h7eddsjh27vvv53gbexo42pizjrma47463nhiytqhk5nyzmanh@bdnjxzc4hzro>
References: <20250522-ipq5018-tsens-sparse-v1-1-97edaaaef27c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-ipq5018-tsens-sparse-v1-1-97edaaaef27c@outlook.com>
X-Proofpoint-ORIG-GUID: ai_t8K-JI1eKen0HjrW4PDgGaauIFRAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEyOSBTYWx0ZWRfX/MifC+zz6RaA
 NpwAbxLSpGA3pmbS8aKHYcs56lhKKyeuKlXdZrpoCdvrdrhU6CZMaCGDgKCKAU3ql3282GXA92Z
 0qVdIKTChyitgIt+Tz9qcwsrxtPhKM5m2S7JWzJBQ6VCrp9WjZ/P5wVhEvvZZRV6dF1X06zD3/I
 yjUBMpPu4ONYTLfnoaouCv+4FTKDsBb21suJWC5BSurCuNSDFT1N+GEqt69LwaaztKSYys9t+w2
 0GZ2yzXnsWHVv+G/1zU/RYrqEQ8zsJrSb+Ibi8mYYNOEJ6eHEnE5Pgh3MJNpW26DljlfWz7TsEq
 SzfBWNLMwUu4YKVOqT9BTBfbxaq97Lxpe/bdnk0Z8HzYgHMzYV6M3yu3OHdEDLebsj5vEhfRjVB
 qmNlSD98RFXvFAgQFdvDF9TX3mw4AtR6LDTDddzdPqaJw9lpN8cVboDTbqQ/g6R5TbmtIzH1
X-Proofpoint-GUID: ai_t8K-JI1eKen0HjrW4PDgGaauIFRAh
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=682f1c8b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=ONbtDiuOtXKcKyDzJgsA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=983 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220129

On Thu, May 22, 2025 at 09:48:51AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Fix a sparse warning by making the ops_ipq5018 struct static.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505202356.S21Sc7bk-lkp@intel.com/
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> Fix below sparse warning by making the ops_ipq5018 struct static.
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/thermal/qcom/tsens-v1.c:246:24: sparse: sparse: symbol 'ops_ipq5018' was not declared. Should it be static?
> 
> vim +/ops_ipq5018 +246 drivers/thermal/qcom/tsens-v1.c
> 
>    245	
>  > 246	const struct tsens_ops ops_ipq5018 = {
>    247		.init		= init_tsens_v1_no_rpm,
>    248		.calibrate	= tsens_calibrate_common,
>    249		.get_temp	= get_temp_tsens_valid,
>    250	};
>    251	
> ---
>  drivers/thermal/qcom/tsens-v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 04b31cc53fe0 ("thermal/drivers/qcom/tsens: Add support for IPQ5018 tsens")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

