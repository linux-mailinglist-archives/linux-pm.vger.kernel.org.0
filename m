Return-Path: <linux-pm+bounces-26033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38BA98AFB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C116568C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723071684AE;
	Wed, 23 Apr 2025 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8A/Sy+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3614155322
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414928; cv=none; b=UEDc2WT6CL4npVTA56WvDR4SgZZQJ1uNcdJvjpxD11lD1tcdk6FtXCSEj4kjpRfqQ0Qyz/Ur/4zV0sfv61FlT0620Z0FhTcvG4PYIMWGqge7tZMTVh4kdGEwKGFvxeiGScNo3DYa9ZJ3cA+BS6Rm5cBaQsu+Sq1OECt3JMOKuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414928; c=relaxed/simple;
	bh=U9OtDZeDCzanLJBDLtmfBqU2PmEPFD3p7Lovsa9a7nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvSQZGwKp8I7F8Ici9oSlzZIAQ0mQMGKh2RXDGkvlUC41PvB+ss4yM8qKuu695rX9uudxgBolsZTcMZSRe81PJZt7b2eQthTE7NHrxy7IduN7Jug+dIFGKxneL+0KMqkk9hHd0ubgFuc/l2A9eEk+ExC6uQsRCRS6MvQtIqkZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8A/Sy+J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAkGMA014763
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 13:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PB3zeJwysZUF/ByBSq+dhGKR
	vdPDfw2nxYgcYIOLE7k=; b=o8A/Sy+JMV06jqoMqAEv5+g+6FDVaLsmlIWxloNE
	eyZ/EllNAnyYMZUJHD7/qcGvvCxNbY1ME4C9kk6kfMRheml5qkIeDP3rVubG4PAA
	UziHFc8yy16AMPfamL5IOvke+Fk+GhleIfMLJBVwlcwZHzXdSsfhfoWXPaFy5HEQ
	pyuys0GQ73qgTa1J3xXaPu9/TPENp+Mfpy7RQyZJOYaSj3pqzGmqJzXeGFGuMxHA
	dsyUxzDaHCrDmKuKy5i8O2VeZX/H/BE7JXFfoFEarVwBhw7chpY7vglyw+ByK0OZ
	Jz7r2tgbdUcT7JMPxrJqh/7p8DaKWSpx7E0BjYzm3AdHLA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0j86s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 13:28:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c54e9f6e00so150836285a.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 06:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745414925; x=1746019725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB3zeJwysZUF/ByBSq+dhGKRvdPDfw2nxYgcYIOLE7k=;
        b=dRt7tzHkAA9ffnSjZk6GoyepZYGIjI7xtbw7ZmBOJ7em/OwGKe2bAQFMNnitXDMul5
         Ot4pcv7CV+4DzIgsQ7NjlYVOogl3sukQRQisNzl0j77JbSHw9Vpux7kd5WdfZcGe+Wpn
         /vh41b3ummXhalzCB3qDcyIN1n/J7PfsXcrSthlIVwYPHPI2Ke/fDQ+sC273Go18UyTs
         joboBakmoUkwE7LfqKnJFd8Jc6vCImaLJzvcQSly+RcuxgfJZNZ3JLz5j+yo4iMeDeYt
         PJ3kBz0B3/oHaqfX9vxc3tlMKAeZq7EG45OjrQ3NjAQqY89VFL5R/N8KIM/clFtZUgWF
         +Vgw==
X-Forwarded-Encrypted: i=1; AJvYcCVghUZ/hOl1LpGWKG6HQOSU80sw6SXreQ+HBHjUJncRXfl8f0K7GOg6pUwxMEYELvkEy/bH/vasoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4PfyR3IfninrZWzglXOLGhUrzMgvnS2wb6+MC2i9U/bwyg4X
	xRkjc6HuX7CkeSrB0ANpvdsNopbSioYj6Bu6h6rjeNVjvm3ZAcE5SMbl/sX5JlcWDoGEIsn4984
	P51CblE183jLY07r893Yar7KekVlkT1WKzHE5mUOBjbro78z2NQjSkNjqHA==
X-Gm-Gg: ASbGncs2MCbMPeH74hsVtq/kUc2d4GP23pr2TX6izcExo7hG5gZy4qqiWTNJsnplpng
	R3dz4agIszl3jfNdgm67PNEzmlXd3VUm5WOPLR2yU+YF4frWz+Xwa7/Zy+kTn0bsKJxLgqmiP8N
	/PZIfOwCQeVqJI0wGn+MXaBGQiJ9Y/ekY2IYEV0pTz/Y6AKJl0G9uULt/+RFmtzAof021bxu96/
	ZjJx0VrhiYrLZVOAYuz2o/Cdj/cn5zZqv0STX1NVGxbbRFBSSi2+51hfCn4U0CFD3BoOT/XLBbv
	/e6qeYtotKeudet6rcYsQmEbNTgkusSYbv8dEri7EwJscnq0Dupr0P3Vh8TEj+9WrsD9W059y8M
	=
X-Received: by 2002:a05:620a:424e:b0:7c0:b350:820 with SMTP id af79cd13be357-7c94d80df6bmr443623685a.5.1745414924633;
        Wed, 23 Apr 2025 06:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk636fFRRkvuLyPaBe/JMMbB0DmZRi+A72gsKa2vsyQGLytxQjLxNTJxnnRLMfxvaeNdGcxQ==
X-Received: by 2002:a05:620a:424e:b0:7c0:b350:820 with SMTP id af79cd13be357-7c94d80df6bmr443619285a.5.1745414924226;
        Wed, 23 Apr 2025 06:28:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5423a2sm1534611e87.101.2025.04.23.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:28:43 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:28:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Anthony Ruhier <aruhier@mailbox.org>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/7] drm/msm: a6x: Rework qmp_get() error handling
Message-ID: <skrb5hkl66gt6vr6c42tx2ipfn62uuouztd2g37xlhreeq7nqj@r6ohzexpwmy7>
References: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
 <20250419-gpu-acd-v5-3-8dbab23569e0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419-gpu-acd-v5-3-8dbab23569e0@quicinc.com>
X-Proofpoint-ORIG-GUID: DexE4MXKnSRD6n6EhCDfAI1_SyXbzkoR
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=6808eb0d cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=b3CbU_ItAAAA:8 a=3mVCJS2yw26y67mb1AsA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-GUID: DexE4MXKnSRD6n6EhCDfAI1_SyXbzkoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5NCBTYWx0ZWRfXw85iOxcX1ItA E6ZSp0HCscZaaZDOehKjeLS5+EJq0htMWah4/X0PmJSqIJBKJFfunfIXv18Bhw1hn/ZhQxd36FA 6FRCX4hz3gM42y6erAxdElKdKzpExigp6kg+ko/qhYkW2V++6NFEuOv4WwrR28cMZqngBITTTI6
 3Npjq6k15BbfjuS4VKRp+s8GTsdGXU3UvGEmVPlxQZweiHO5EboHy9SaQjKcP9q451qoe180HZg GQkLRdKggGWpKVv+SmRxQCcbVzfwq7vJ07b4qBFpRA6tdGnhpBINrBLztIeXUtvjWRG+SG08Uxp mhVxBIq4qGc5DCKQwhFnn498oHLUVPJDH/kCVLHJ1xKXNiL3J5/sWbY3JE1RGdPGz5ha7pvAzoo
 D1dogQGpncTlEQf+fZFcGxX18in0jEiVUFMrzwQPcSBl+IV3/3K39NjxA2tN33yu+HiQZUPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230094

On Sat, Apr 19, 2025 at 08:21:32PM +0530, Akhil P Oommen wrote:
> Fix the following for qmp_get() errors:
> 
> 1. Correctly handle probe defer for A6x GPUs
> 2. Ignore other errors because those are okay when GPU ACD is
> not required. They are checked again during gpu acd probe.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Tested-by: Anthony Ruhier <aruhier@mailbox.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

If this a fix for the existing commit, it should come first and have a
proper Fixes: tag. If not, please squash it into the first patch.

> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 6bd6d7c67f98b38cb1d23f926b5e6ccbd7f2ec53..48b4ca8894ba38176481b62b7fd1406472369df1 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2043,9 +2043,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  		goto detach_cxpd;
>  	}
>  
> +	/* Other errors are handled during GPU ACD probe */
>  	gmu->qmp = qmp_get(gmu->dev);
> -	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu)) {
> -		ret = PTR_ERR(gmu->qmp);
> +	if (PTR_ERR_OR_ZERO(gmu->qmp) == -EPROBE_DEFER) {
> +		ret = -EPROBE_DEFER;
>  		goto detach_gxpd;
>  	}
>  
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

