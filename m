Return-Path: <linux-pm+bounces-35324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D62B9D37B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 04:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4642F1738E0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 02:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB652E54BF;
	Thu, 25 Sep 2025 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSnJ43HS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6A2853EE
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768110; cv=none; b=dtxOpiG1CiHRoUWX5Z2VxWL0R9L7KsZrkHz6l48LC/AFCCSWQHQIKhxYr6zwf6cJWq4NSrkhoVAMRjsSxSW6LbBK83qvitprJk1HRnKmUMgxKbtVLV+/B3Dk5COgHfcTmABpwwmfdOvxd7a7Sw4tb3acCbYLkR9lExwQZgUrx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768110; c=relaxed/simple;
	bh=7ciLY+0WA0WdD0zQWgT/kOVB7yzTSooA9pRCRJa2KjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZiZ2/9JEt9zCPgy462m8m1xfJOoiHRdnNQF194zbjdlvBGBqSF9YwOilJOgFNn/2+J+on+U3evveXJOw9jByp49wOQIGYIwoyB+XFYpjLW9dvPJbHSY18QoBFDeL08828Xg8RZCZMIgRJpl843zgUBKvb6vrHH+iekQP/+jjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSnJ43HS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0rTvU025119
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 02:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=l6roaFaJv6NtbeRVgfZ0Cnfu
	GdOUptJbjLE7JsJv3w8=; b=SSnJ43HSGLwhj3vESbnNlRYDklAMDge9yoR2l7zA
	OtvGAD6SR/fR8ubEgCByKraNYx1yzfG7UkX6hg6+B8LCuTYmfHb/kNOvmRYVyz+Z
	oxytUB0OEwEUUXnSQmW9QpxVkDE53X21B+uDSNfLV+nALUbOz6IZACwN5Xz1785U
	LHqdAX6PvtQlIS5GQppRQYBgI1BBxdgr4ioO9OmLbd4CHH44UWL479Q5vzLTDTDO
	X074lI+OZ5wBBnrs6Lu+E1vDJ9LhtNiyxKkRb6UrviRfZCV3f050LiA1vJ5J/e6L
	fVKR+et/FSVFgne+ABNUgDY/fVw+Fy70ABjPiaXYgE5MlQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv16ged-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 02:41:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b633847b94so12069221cf.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 19:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758768107; x=1759372907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6roaFaJv6NtbeRVgfZ0CnfuGdOUptJbjLE7JsJv3w8=;
        b=bMZTNQgAwXIGgCMw3sbTgRhCTHMF1eo1hApSoGGY5hwRijhcS60wRYcuZ585JoU8iG
         /GHo2uPetmvS0+XPpmFYnurKHK0V5rb/ltZTrT4HErW4k2uKSJGxMsJrzH8RxuOZOLg8
         mN5g50/IJNTps455ZGhUoy38/j82F72QHccvXPG0a9oGD8uzR5Bzqwe+LwBsbKkr0QYC
         8U+Q+QimGq22mu4tgiu3ZtEOLszuAAXxO4Fc6QaKE62FlJ5Qiaa/MgHK6pszjCecl0Nr
         jDJ8k8EhX3xNTfAHEMBRUKCiCmgSmBwPJvf/7j4p8hpwg1nia+Bu+ts98ueTGCA06kUP
         yQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWYRu83AilibBFqN5485cvxktRnAbC8ec59DtE6IUOVO70VZTSnDgHchfQBh/k0eJwxfvE9LATzjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWNLyci70fG1cYW/WWH7zRHvlrRoR2sUFPqV9UNQOgXlO9Vui
	Om5JakBOxYZit5R76Wc8sAZYmc0AGhIDxM8UywmO2L/ArRB1/Jy5sNNgfNxVvf+qakphffZjmf0
	mBa5tGgAmoH2vruRxiQmpjLzleA5iPrJ5ehDwf+oyfJ/eIE2usdwsfZuRW1Uhiw==
X-Gm-Gg: ASbGncuAuQI8X3s3kQpQNAa7sn9ZP9pM9SjqCfB40E09BUdW32BYD8VZz6AOPKeKTY9
	VI2zX6OfA8x2QwopztAO/r4DXB/0qviTGlxEmFz/PEs+K1/83zcY1LkijEfEEoCAMqA261EN7iH
	6vkTGdyomz8GpKCbjT0UcucPO/Es6lpRzzP66Hbw/grTnrkK6IAi+vu/rODm9qHOYfeclNimXvA
	SmTSUmyU/WBSQCmGYqnQMoA50btBiko8MpRoTy5wcJgjzFI5ZYm1LkqqmRas5z7Oyy9yE9ojL0W
	/Sm9Lg9JdpvaxNz0ylZeHpSuQNAGOU7GqAWQ739kZ9gAZX/pfCRo3OdwU4nF/8zjZ+yCgXtMfu2
	cQn+J92JXFIWBWM0/pghqQehjTjVXhX9H9mX3zS9IxT2qfCsbrmaw
X-Received: by 2002:a05:622a:1886:b0:4cc:48c0:adfb with SMTP id d75a77b69052e-4da4782a6c3mr25545281cf.9.1758768106563;
        Wed, 24 Sep 2025 19:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKT8RyctbGQ3mP7DDb/CtYIWh4SsjSRD24MobA41ee3lV6NyrPEs1SAryjLLGpuLO2wIFF+Q==
X-Received: by 2002:a05:622a:1886:b0:4cc:48c0:adfb with SMTP id d75a77b69052e-4da4782a6c3mr25545051cf.9.1758768106092;
        Wed, 24 Sep 2025 19:41:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7fe8750sm2191921fa.66.2025.09.24.19.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:41:44 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:41:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add RPMh power domain
 support for Kaanapali
Message-ID: <fd234vzjys553445l5a2hgdkwoe3gub3ubjzhbmtuljjz3ukvi@y6irjcva5de5>
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
 <20250924-knp-pd-v1-3-b78444125c91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pd-v1-3-b78444125c91@oss.qualcomm.com>
X-Proofpoint-GUID: usHTcbx0vTSEFlvryKt-ChRU7uZ-RxwD
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d4abeb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hka-zFMH_fk-WL56CYAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX6ytVAgFrAWpD
 sYSH0B7qr27e/gHTfx1wOt+XRjQj2IjnIVJ+BAmAReoTkCSP4a2mfpkHGzqsY/Lesty21iR9/7x
 4mY7QPUHIsRAJjKJtvGOmPV6C1awM9W8SotXo31QNWM9Mi+uxrC8ZayTQdbqwRsH+HK/Wk0004/
 YvcsncwLHA+Bp23A58KgobQusLnE4peWxdTm8jQ5ED12HL9oqTlkoMhlWVVnmPNEnGxpkzEO6VZ
 GVSVKI6KFaeep1RmL5BDslWrKzyrO8JotQ9Jx7kTkqY+g33itCqPfmZWuRZvsEZZmXUWbbtlpnw
 xR4aq36EitQgWmrYffhFhZVdSCUncOwGieY3c0ZVeKIQTTzv23/fQsj6r6k3TEQPu/UhqBk0UNz
 KOVY0rKj
X-Proofpoint-ORIG-GUID: usHTcbx0vTSEFlvryKt-ChRU7uZ-RxwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Wed, Sep 24, 2025 at 04:17:08PM -0700, Jingyi Wang wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Add the RPMh power domains present in Kaanapali SoCs. Also increase the
> maximum allowed number of levels for ARC resources from 16 to 32, as
> needed starting on the Kaanapali SoC where the ARC vote registers have been
> expanded from 4 to 5 bits.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

