Return-Path: <linux-pm+bounces-25188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137BAA84EFC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 23:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF162461A2D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB3E29344E;
	Thu, 10 Apr 2025 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1kqduj5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F471C5D63
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319084; cv=none; b=Y5YRpPQSa5KDKszOhWv1VzgDGxfcTaNCG/GsTRtxElMfxLaJVqg/QItvuBd5YL1Xrn63Zc4xmwRQy4UEFQx/fzyQ/OkbRgMIL2Y7+fZ3kDhm6Gz53gw9rAJotwnx80EIj7LrjlxlLMceWju1p9IQK/rLYtTAwkZFLJCb1nJoxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319084; c=relaxed/simple;
	bh=s2PXDXHfp+4YvEv/H4AL/Xhk+Ols5TiAix6NnWN1N3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk0RnNmM5TqtIZKR7Uv5CKg0BwwBEE/s1F6dc7ljYk9CHK6hN1ysBnv55XW2OJJBdu4GoyT+qYxhh++OkOjx201RbVC6aL34pIIh5LtSmaK51l5OWreo8rYft6unkboIRGaGjyc+bnaDM/d9xEVPAnDyhDf6CmjG4NMA69swKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b1kqduj5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGJ9KY018271
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ayYaEZ2RWgExBpMHxpWrMYGv
	nLNQvuaR1/Qt3ksg5Gk=; b=b1kqduj5/8pqkVSKKfNoMKJQAbRHEPDNjU0Dhl28
	DHJYeFu/D4uLq4zTZ38brFe5/bLMT4SlqIrJCrIZUuEqJd0HWizgocJ351Lnexwe
	48lu85LQ6GhRumygAPuO1AdSQmkfGATsMeTOXnZgKb9xlzu8SItaUemcqsHMuSrX
	hmHOiisNbzQoEMKkKn9XRASu7uLx/GAfPu4zcaHPN49n5dZTTrO0MQV7t/EWGR/I
	STkvISA0XvEP7j+Qo1P9n5SurGqIjI3eDjmk+8G1WOo3i76UoATPVLe7EB0d28uX
	G9U4Uk7RA86MavsbARxOyTham0ilrotqkZaboP8OnGjvUA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb8epn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 21:04:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5c9abdbd3so133617185a.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 14:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744319080; x=1744923880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayYaEZ2RWgExBpMHxpWrMYGvnLNQvuaR1/Qt3ksg5Gk=;
        b=ghpLaCF3CwMngdJysAOv/eakMsmwIT1XsXdr6qu2ICYMq8barFapUOuAahWtEVrcGx
         T213i5MJ6ZSxCTpgvbfWja93GdCFnKjiDoNnmZouIbCAp+27aVbAMWz/bptEk4bPbGiV
         Qb4hun1tj00X7+HBjDmd8bUw7gn0fC8LT3wfaje1f/Ternbm6IqUhl/zj2iO1LtAXj8R
         A9rU2o/vgFnHcyXSr98Y9PYr6Y2Ovs2bi7iz1fLX61F9gYGkeBwby8ftjDlVN4CcoLHj
         39Wx+gK4d8Z+t1Hd4XF9tgKwKHfLsweFQVuQUkLMDn+2+iBbJISQ5jymJwMtlMVi1jyi
         as1A==
X-Forwarded-Encrypted: i=1; AJvYcCX6adkooKxIkFMsaCQsi7SjU9rzhUp+FSn6BmKGzVYiyWfh/y0mWk0AXBsOr6iTIVSE0gKXRp4rAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YztNHFG0Ns00KrQwpfgC2oI3nh3zDjErW/K4rRM/Cp5XgsM0Usi
	mrHKC6GXLwnmpQpM6J1tInW3LsHjYPpqbYyytiIpSO+uCUckiYFqvzeRNtThtO/XwDLYyIAP87s
	m4/ImkGWMOGXUgmpFQr2el5vpOEHgVG4d0Z74fUnRpBov6SEaC0BqZxWPBQ==
X-Gm-Gg: ASbGncuxfzf1kRTTwJpMbtHloMgdb4iEgm93q2tI2h0RpVvQgewzA1ORKlF0DasZuS4
	PDLe65+WaPrPouMFdiP+78x8VnvgcfDIci0pI2LgWscywXmkH+shRE2mD9tEXrLWDvYeeZXcPGP
	avvpux6VU9+cWbcvq5/Wyhx9gfh1x+G6GIFM/Gu+5ce5Glu1zCHxkNmCbY1QaMlCRV2J91iAPMT
	D1e12tdlJsJomCiLzLMFWV7XiXZY+OBUf6RELP1e4lHX50yqGECtdhQYTqGpOsxkSQJZ+mcExeE
	qZ2+WZc8GUZg+gv0bGRyWG+v9gMCg/2DyiQNHSSLIrERALa23GzVa5tfl4JYRpYq1g1EiiivRS0
	=
X-Received: by 2002:a05:620a:4146:b0:7c5:9b93:8f64 with SMTP id af79cd13be357-7c7af112747mr80866385a.37.1744319079771;
        Thu, 10 Apr 2025 14:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBOyjBBQO+ERP0/gAUgi7hej+nLhxyLLWNbmDsntOUVhHkcTUjblRZyEYWnk1SceQw4tQDlQ==
X-Received: by 2002:a05:620a:4146:b0:7c5:9b93:8f64 with SMTP id af79cd13be357-7c7af112747mr80862185a.37.1744319079366;
        Thu, 10 Apr 2025 14:04:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d521931sm243180e87.257.2025.04.10.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:04:38 -0700 (PDT)
Date: Fri, 11 Apr 2025 00:04:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 5/5 RESEND] thermal: qcom-spmi-temp-alarm: add support
 for LITE PMIC peripherals
Message-ID: <dspnug2uuft5st3ysrlcpbitir2ilcjpxglvqqfjoqx4w5xhct@r2xauwjshnoa>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-6-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320202408.3940777-6-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-GUID: gq4yg3HkwdVqH69LA2KPTqkEYMvljTAK
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f83269 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=C_YEPuUXS4kB9x-TF1IA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: gq4yg3HkwdVqH69LA2KPTqkEYMvljTAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100152

On Thu, Mar 20, 2025 at 01:24:08PM -0700, Anjelique Melendez wrote:
> Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
> utilizes a pair of registers to configure a warning interrupt
> threshold temperature and an automatic hardware shutdown
> threshold temperature.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 204 +++++++++++++++++++-
>  1 file changed, 203 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

