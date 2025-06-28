Return-Path: <linux-pm+bounces-29725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE9AEC3EF
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 03:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C96A177947
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6311E520F;
	Sat, 28 Jun 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BixOOQ14"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EE1CAA62
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075741; cv=none; b=dp3anfEdN979bPLstBE/v+FgSJl7zBPoiG3CrUfGPBO3ASaoy5GCUhIdII7C1bC0ExQCiUPfUd4NzPXRdNzl+RgFnO/7U0WAT/4pLRqVpVbZ61fqqNOjjDtf84azPDPNM5yAM9yjBdS+ttvwU9g/Hs7rMT8h6y8oXn4GuUv1wJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075741; c=relaxed/simple;
	bh=Yj4HqbTO+hsJVkoO5tBN3KU0UwRywL0zRbgyWn3HDWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/YOdNVByQtpEFlvB0ICxf1drmQa+23gB9okjPxrJitJpl1xIN3kTobipyD/PT29ZY04StkuQZcm834MAZG+jO4W9Q2FF0vrFMUP4EPx2v3YM/FX1hCyeJCIsenbWdhqh+TVUHlHyo6TS7n1XlwaI1vG8Jo8UQyYmpZAgsI1cuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BixOOQ14; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55S0DJ4B009171
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=It1FpRXOceRECWa3Bwdhslvh
	PP0irZBQMnIJ9MHFFPo=; b=BixOOQ14Zw1BRrBwZSFhHjchS17b3drzrnaKuJh+
	jL+74BS+dkHcuuZ4i7GvJ0oIGav0dCPs4gqEE9tlYHuKCn/gCEO05GqGdUFpMM05
	OyELt0kTpE4DUa2FKGpaX2UxD7OnLKT8RbkPpXEA4zFfdjxmjiuGbK0ETQwbQLKU
	JYUBbXJCSU9DRUgoFaxxZnEB/eMk0F1TvlX7PGyW2+bKMfJz5vsgRzzFt+5RMh7z
	KdlezfBon0JeFO31AR55GFDm0y6FAr/ai4d1JI67WQ4k2Jzgv1ihxmpNgIZDOseL
	6gbHTebLZ4067njGpjd69rM0iu+WvhHlnHWNGbft0jIZsA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcn26c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:55:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d40185a630so82702985a.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 18:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751075738; x=1751680538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It1FpRXOceRECWa3BwdhslvhPP0irZBQMnIJ9MHFFPo=;
        b=ga/HJ9egSFzlkSyRtJ3De99gFeMso0AzW9i0jKV2gwrJcpKko9xWdEpwdK0L5VNX6j
         ELeJi0mrW4VGNkbLZ+gm4fnwb8SJ3nRoLCtkUUl4CeiRNsdM3P0S8NOzmU/5W/H6erRP
         NFzgm6d5Pb5dC0uPWO+APUs9sXBswjbFQhH8MJy8pww9ucAJ2tfzOK0riPstSyTcW7GR
         3UfAWiBIizabgLxAFJCn8a9+xfNnD9lSkVJmYvnNKYC8x4YPw3y7Oupy2+hSR+nfIX7n
         hoLsCc5kqHCg6vqKQMiSeCt2Hahw2YH4bZckh+tRM16gs4kbhZtiHHWJae/SGCP2Ig4Z
         1eiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrZaYmgtU9121+TKEb/AbHl4vkw4z1UvUNQ2T/uvW59w2HI4ZpPJRcav1GQC12q8xdaaGNERi5ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyblZ+xgf+eCLTqCKmuoFlfonsYIgrCc/dQHVjzMCjAIHZsdkVD
	7S4f3DkQ/f8gws9U4h1pR9/vLIQa+UpMmMIKjzF+AxhRYU787x0poEydRvlP0v2pZDtbryN2W07
	n5CK9z7NAlJ/RPnQu/wAEPK92zmqc/nZts4a+0VnwdphyqMcor4dlpSHbzor2Xg==
X-Gm-Gg: ASbGncvsbFB+mW97Pc4W8eqC4EJgk1L38ScEAO+dNHJ9Lq8DEO/jzekDrZiidFGXNLP
	fcdLcYAvSLpraOKcHXR/fbe/bbYGbZTAb1uH3zPD++Jnq3P7vXAFgFNPXZdGYyf5T1gMPTo9XUp
	+vqezkBYXeixVmuWvZf9x/qJe1nvE00X8fH6XJyiDtPI3D/qVcgcM66e3HKbub1q+4QERw7cFFp
	0+faaCL0z34vVAE3w+sQiQiP0P+okVRcDu/y+KT+BZtWrC0EIMN6hRkByzvgGfRhl9bPqNdEEn9
	wkDJpRwAcXtA5WvyIn1gjd837yPlfgWDG4T+c365cgDEVsY+k8IppYV/Pfy3TISG6FHFVYSF6ui
	3km0=
X-Received: by 2002:a05:620a:46a0:b0:7d3:9012:75d7 with SMTP id af79cd13be357-7d443976abfmr871097985a.43.1751075735699;
        Fri, 27 Jun 2025 18:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtab+OtC4EBlk9U3wu7wzT8L0Rv1HTjySotQtNdoIMLlCUeXq6oWJfdAb/GbiKRGr/Dg4hNQ==
X-Received: by 2002:a05:620a:46a0:b0:7d3:9012:75d7 with SMTP id af79cd13be357-7d443976abfmr871095685a.43.1751075735347;
        Fri, 27 Jun 2025 18:55:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2f007f7sm6835311fa.94.2025.06.27.18.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 18:55:33 -0700 (PDT)
Date: Sat, 28 Jun 2025 04:55:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: qcs615: Drop IPA interconnects
Message-ID: <b2fpasn6ki63yxgtjuxpalpmdlqjaym4fjmzw5mupeifmxzrnk@bdfdnxfaqj5g>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
 <20250627-topic-qcs615_icc_ipa-v1-1-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-1-dc47596cde69@oss.qualcomm.com>
X-Proofpoint-GUID: s_9-XktS7M2lb-iQAvh-eDEiEuNT9n0X
X-Proofpoint-ORIG-GUID: s_9-XktS7M2lb-iQAvh-eDEiEuNT9n0X
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685f4b9b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=phXncWpSF8SbJm8Som4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDAxMyBTYWx0ZWRfX3OjyFFBKRIIx
 nvQL0M1kidFLNOyF5AEuxq6W9IaRcZexPkOCC68hdQS5g+rGCejFcz1B/Rav8OLHCEXsxh+1oYd
 bTh0gSDFunKjKq+buOi1ep0LIZO9XxMdtSdEL8XIg3B7yBsy4R3rLZhwRhwxnLHbp25GqsHSbwh
 cLtZfOnfaknXFXSdImwFAxBaqR8uZLfTVfbHH49BtD2UeLqVuD45KYauCYEUDk5/90f25drCBTv
 aFoh3rPAtojkwLGlY5KXfcfLUkrhnApzJhOfGwo6CQS5cuCbSSTT0u/fW654nriYq21psXY+KVq
 4VcgACTJgz14Yd0RndAU0X/oWvjjzyMIWEbTJFiqmUZdOInnLAJVlT14icJ/fOYEQ381F5Jl0cO
 sXje/c72Kf9vqnwgzsJifAKZjiw6w/Ha7NOlmybv1hiJByPp2IRVhl9QVBbIblCEI0xmrcO+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=791 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506280013

On Fri, Jun 27, 2025 at 09:37:55PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> In the same spirit as e.g. Commit 6314184be391 ("arm64: dts: qcom:
> sc8180x: Drop ipa-virt interconnect") drop the resources that should
> be taken care of through the clk-rpmh driver.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

