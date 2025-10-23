Return-Path: <linux-pm+bounces-36728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D932C01B69
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 16:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2676E3B576D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279631E10F;
	Thu, 23 Oct 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WYt0E/IB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C752D73AD
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228635; cv=none; b=Ip4pC619eYRafNXm7YaCl2a+3R6x8FODlk6BiduM1mbK/xEOwpBySbwH9WvI5nPtHCTJ/tS40nSyCa8w0awqJsNgzpqIaM7TrM6ftustcRKVRqRkzn7MfJ5urSwxwefKwpPpw94EE0E5Ni7SpWJr2fOa5RoMsAt/m4WIkjqO5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228635; c=relaxed/simple;
	bh=E8DHiUHBc+Kx0BkbHinW3qjbtm95S9kjEJyXbNNuC9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq0flzD7ztAvxq1CUlS3TfjLUXuVPphT1QfDqDxwwH1H6fg8fxegrPM8ooLhKQXTn4EAe2iqFDFfjLevM1Mf3QZWbfQ864UHeZjIKWiXwHLYKdzCesJmWBdz9LdxhwAuB1Uxb1WI3CiyGOQWCiJQjKzuHcHQaHxZRoNS9YihlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WYt0E/IB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7JQSo009131
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3qgygDtk8UlAl4nQQF1ZdnPG
	AZqeQV2IEszwXskS6lQ=; b=WYt0E/IBt9ppMUHlSsxRFF3CxRwo7LvEHOvGHxg4
	mn8uS4aB4CpJ6L+1eeDeK413LF/ZIRiyjmVF+jXhXVNxEb9yOCijgfBlhSMi+/cW
	eT1JmaajhcDJzZSo6DVJ5O40zTPR7D3VlKVYZxQObsNvJcfvfqhau/E1kQgq0FP/
	ntZHLrHxY3tQ4Bx4blGWdsW1qxoSOy25rE1fSNK281affFKboVAy0Mt/auEH47sk
	qY/wiLG1LuLSRLZL5VkfJIFai9jAHMf4iwIrBBFFC6Xyfw8/aPXKmy9SJfIQqptU
	AUjQbcNd9DxIqexSpVX/DeKT7flEJ/9Wlsl8WbBIi4q1nA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j8k69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 14:10:32 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-556cd166749so1939171e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 07:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228632; x=1761833432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qgygDtk8UlAl4nQQF1ZdnPGAZqeQV2IEszwXskS6lQ=;
        b=VuDGkbqT0iFZ4qcSb8HgikGBYkH1U+B2PNBkAa5kNA3mO8GJK+Hfaa8qItH2oMs+Bw
         ZJnW2Ic2XXbwhwjrDa/ZrCWG6fXfNn4nQJ7qx/McuLA8vd3obvQkZUf2yVdYayaznM8H
         yFa/pIykbteHm2x9bDS8CxThJ46+iOHcxKFPA8zV+Sic/ZJ/6n83nL3n3XQ04zxHWIHM
         lpXfPAWdHUpDmqwkOeT/VU4k9ZCBhg4bCTUCek6HqeCUlwj2TO/CuggaOMGASTcCSTgb
         vOAggHIm6hae5h8L4eRkoilYbYjxT7vMUbSLyRG/Mu5H2/iApqwiH1Cs120kP7mz22kR
         JJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCXory/zr+0na+xBdvqMgLfdoIxesvOFCq+HCtraNPlIHqYDRQJ9j8pNZrbyb9zFFffhjqgm3i0AVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhl9mBPWTtcmdNwwxGl2QIbeLV9+MAW/5ekCQPgeaT34wHFvty
	Z0GYIOQreQMvxM8BnBOViGidsCjvKEwYpPz3MJITLgtSkJR62bkd924z5EvvhHePtKTvj/Fwdpp
	Vs8RkLE1romAl3QzcFO/Qi218smJbD7NGJoe9zxdEIsWHPSqNK4PTBJV4NYIYzA==
X-Gm-Gg: ASbGncsCJz/L2AGGrpLSc9nX8LG7uh1fBPvnWa0tSnSzSOjzMvbyOtwJkTFAHzn7Skb
	rllpQsfC/oBVkOJoKllQmu77p1QlZq1b7SKgZROb3PqTKLuTam4LPON5uQ8rM9kObZeGqHFEe7U
	PliqmTik3Ai/elNFeCj6j0+Wor4QpYIq7l3U/dUEkszGDQ7ddznKWiyhMs4mZsmtqkxEFCuOp+N
	WQRXUMyfKIEDm3MdI+8LKoEYATxeUpFIiBO/pwyBBQ9I24+giAp4lT7cZPTK7unxFNB9n0MM2+C
	v6geDL5acMqbEdC8GMOZY0LhV+8ABYtBXXLcB/VRvu0Cr1bfGfOsxfmTNZUR3183LbgVVe7HjAg
	EEMIlKGgZOfy76X7Cso5RfheBuY5eUk8uUiLUIKCR+ubobrsGEsGXXAMwnZO6bi/9vt7ei9xuOu
	t9ZeMHuH25LH4O
X-Received: by 2002:a05:6122:3183:b0:54b:bc2a:f58d with SMTP id 71dfb90a1353d-5564ee320c0mr8061747e0c.3.1761228631734;
        Thu, 23 Oct 2025 07:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9z2egEYQC6wwFdktlSuOrxdZPE4UHlcQ1aU42vJECIx4nLyzy1YbsX5qcp845m7FqT76pbg==
X-Received: by 2002:a05:6122:3183:b0:54b:bc2a:f58d with SMTP id 71dfb90a1353d-5564ee320c0mr8061712e0c.3.1761228631186;
        Thu, 23 Oct 2025 07:10:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4aded7esm778459e87.6.2025.10.23.07.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:10:28 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:10:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: add Kaanapali interconnect
 provider driver
Message-ID: <2dbbwcrfqvnd5efrmqku4x3rtsjalk2mjezdufef3hdnjclqpj@bcauquyryh7v>
References: <20251023-knp-interconnect-v1-0-df13182aceac@oss.qualcomm.com>
 <20251023-knp-interconnect-v1-2-df13182aceac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-knp-interconnect-v1-2-df13182aceac@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX9p07BmPTF44b
 6zHXK9mPUhFOk2wMphgu11PBwO7Tjr5dJq/mDM3qMYiXEQlcB9SY3JA9z3QzsZ8ah+4WK7ZVzVK
 MnQjpQCMivA/3Ta/8XeSpeVAcHKUirIzGX5UI+6EIoMpCgIGIU0rmJL9dzlJYcM8PBbvUcAzAOc
 HySX6u3qBbr0EreYePIhFEs2izewtxWfpqE9eky1huEo0enNReNTkHg2AGaOOhqzL4xpPr8dZds
 597rktvI1YklA2fHBR94BcMwjUila1RXVT4LoposWcKLjYsnndtPmQHYZV6lda49O9s6eqX1yts
 zHmV3ipTbwWiOi/f8harxguavVG8fXJqbh2dTIx8wuia8bDEKFNyWo91Mgu635/13E25wFUwMP1
 ieAAhWqF3r9JBtk5iV85oh1bHqWqVg==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fa3758 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=9fVyOH5KxkoKYaOAqNYA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: ZPf0Nwd21ShlPoaYBLk9vMhJsEPpzhDJ
X-Proofpoint-ORIG-GUID: ZPf0Nwd21ShlPoaYBLk9vMhJsEPpzhDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Thu, Oct 23, 2025 at 04:39:33AM +0000, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in Kaanapali
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig     |    9 +
>  drivers/interconnect/qcom/Makefile    |    2 +
>  drivers/interconnect/qcom/kaanapali.c | 1868 +++++++++++++++++++++++++++++++++
>  3 files changed, 1879 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

