Return-Path: <linux-pm+bounces-41154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C1D3C0D9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 08:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FE56425114
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD43AE6FE;
	Tue, 20 Jan 2026 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+Ud4CAM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKNmZ8ia"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FB3ACF08
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895140; cv=none; b=VIQtemuGI/YDw4pbUCpGf9uqbfG5Vl3EV+wnmCcTNxPrznbIwMFkTYEO4SHSnK2xyRUoVo4BUDMeTVUCmXLqbr9k2Okxnoj6JJXQeqwv4nE2ki84kXWoA1E47Qk23PcXdOnMq0gnQVq8wynM9+ITCFqFcEyAQX2xOh0aFnAyJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895140; c=relaxed/simple;
	bh=+f9DFt1yAGP5lRU7/2hhzXsRmGUdxv+iemZ4bSy9+Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhSkIFewVmXUAwW9XxdfPeIlzSIX75bznB4ls+2cgI3cVNjoXPiv8YgfPVHrn7AA/DijoIVQX8vWMD9UDl34Fqqw64ExPOxyVt/W2b/wmdCCALQpi3JpryndVsUgvRuOKEO241QAVoWQI6kHDDX4ArOXuRS5Z+nYcZAlJhB8Pjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+Ud4CAM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LKNmZ8ia; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K61YWI3772477
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 07:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aGhGrX0dL/xdL01BQa1MYxZE
	1yg6gqsa3kDfPWyJ6Ps=; b=H+Ud4CAMP/JIVZR3UuwljCZbJWoijrdDIB0zRrRL
	jdRDb3RDzu6NdCmlUc44LvRpftFcCV0TXC5GB9W4x1x7aPyRfTYiE/t2IXc6L1K4
	bNdaWv67WPSi9Jurxc/gqwvRYt4WRNdUWZpCe3UsVtqbFasO/t9wJtV/2TaWHg+H
	xILVzp9kFX/xELi89ESFAbTaRBlIIPLbfT/oZ6XYX7EQUhvC29oRVKnl5YA5RjGz
	KcTcofljLMPtrAd1I/OOGQR8pJ7yzNgJguKtTbKkJlcR1jUFA0xzWrSAX1ErDoyL
	tYbC3zTjP+C8mHyZPjiAYVHKGbmoKUKxqu9LCS+BIVSk9g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt42wrab8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 07:45:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a5bc8c43so1096485285a.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 23:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768895136; x=1769499936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGhGrX0dL/xdL01BQa1MYxZE1yg6gqsa3kDfPWyJ6Ps=;
        b=LKNmZ8iaG46zQBhpqj7/TeaugcCqVOGDGFkoTr1aHrXS+TcLqhAyiORLeDrE+epYyv
         FPbp1IDTu3tXdlWBUQRJX0Hnn5/KP2MxCXOw8NikHEDKbv48oMGnDeWNStboWtXsdGnP
         yZLhIkrQ67QyV/gQrSOeUvLtKZ/enuI5nMFM27/aHyl3QcBoMw1UDQxVKZ+lDgzV+FJg
         v22GDJlrYk09XoHBsbUE2J0FsmGV8zU66wYDiyZGIJX/VHQaZH0EdFJ+Llu45J8Ckz6t
         5iqTFiCRzVjCB7Hr+rk9a+BApeSsqgvmCcef6oKAM2QxuMWbBCj5KKNFrauB55Wc056p
         L6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895136; x=1769499936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGhGrX0dL/xdL01BQa1MYxZE1yg6gqsa3kDfPWyJ6Ps=;
        b=nHAoCgeIExeYt8fkvZWeu6aB5SOQaf9r5xNe7SfiOy2hgtRe56d6DX7D5yQK1eoH0b
         57dlmqPrGBIJgtHfHxw0H63/hXnqrFX7GXqEUTclkfpVW4D43CK2ABaLeBqnmFDZ25W7
         zcYzJUDrBPzKR0lsHPQutJGNzZ2Q/16pmZifvNDK0NFgz+WYIgnzYI1IE5a8o7UPCtsx
         9PUt6lOxioidsv4DhQFujjt30sS7IR9e1+HImAd3I5lfF0x762Qs5YZpMBxS2ruq5I5Z
         T1erMZbykBpkzjPC5EdNUgu/bW70qENet61pjZNoWgG2YjPEM3t6z1tXlbSq1S8Mskpy
         PFSg==
X-Forwarded-Encrypted: i=1; AJvYcCWcdRQSgnjDjGi1QFgXzO/zdTqYr7jqTHxAKBP7ZUWvtenXRf4iI8riL59s5jL2oOoBI7Xmy/e3Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGx8o9iyOOL/i7jgzfP++7RaZFounMhbKqLvrgrNtyu36l9jUj
	qI7kiwgkfDKAx8UREIfFoQss5/BbC6JIrgq7L2eoIonHRaDHQ9P1hMv+5zgx7Af/wgtt4LTFdfV
	JDziNTbwk+mc1Od+/Ue6g1HtWBn3wSaFZ5WHyvvX81Tg7CgPjGlSOh0E3r+MIefeao9kXdK8Atz
	Q=
X-Gm-Gg: AY/fxX7rK0WOx/BA7IsY+CAnM2WaUp4ZECWGV8f/scjE21GnqIlTH/hQ1nnO1QJyPhC
	uWAuR/35ccXtgy32CrNvjSBZqmIQdfHGCH+l8aFFBKXEhrdRkH2WSggYDxWEWcEBmlxFE/OW4K1
	Wz9aY9YhiYFnqVBLTtcjP6Vfv0pcbvXpp7AU7ZLuHdVbyjqKCHj6Ziwbsh88IDzrjwK5Y35o4N5
	EoQkWjNT3iLXVQ1ax1u+LVxnwLZ8hZAy0wenP+VRElAAUjT8/sJ85ClH6+crcRBdRB06QUKJ4xz
	NZNcKGbXw9y3Sufjl+j01Dhx2OUZZacy8fSW51Nd58+wrVhP20cOEp1YWuWgJMZyW5UICurHrfP
	NEPUIajmHhCb9OgQsuClGtUlpeE/JXIL5sFvfRLk4znkzzftuxc4tIjsziXYHhiEo5AizCzuM5y
	qHSX2jIIr9RS/1zxwbLDnEhaQ=
X-Received: by 2002:a05:620a:3181:b0:8c5:22b2:8b4a with SMTP id af79cd13be357-8c6a66d69abmr1919990085a.16.1768895136032;
        Mon, 19 Jan 2026 23:45:36 -0800 (PST)
X-Received: by 2002:a05:620a:3181:b0:8c5:22b2:8b4a with SMTP id af79cd13be357-8c6a66d69abmr1919987985a.16.1768895135554;
        Mon, 19 Jan 2026 23:45:35 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384d3fe0fsm41188791fa.3.2026.01.19.23.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:45:34 -0800 (PST)
Date: Tue, 20 Jan 2026 09:45:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: qcom: qcs8300: fix the num_links for
 nsp icc node
Message-ID: <rsxdnmh4ezutvsblmcvjcwtwyuyrlrndxcyec3kth6ccqyxeac@yzcp2g6bqota>
References: <20260120-monaco_num_links_fix_nsp_ebi_path-v2-1-2933c1b35147@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-monaco_num_links_fix_nsp_ebi_path-v2-1-2933c1b35147@oss.qualcomm.com>
X-Proofpoint-GUID: glIycqigiz8TOG6A4HLRYG9bvqcDTqOF
X-Authority-Analysis: v=2.4 cv=eJMeTXp1 c=1 sm=1 tr=0 ts=696f32a1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DMoFkxY2krY643WBwVkA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: glIycqigiz8TOG6A4HLRYG9bvqcDTqOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NCBTYWx0ZWRfX5r5QPAsFcILm
 w4Eb2FTN/LdCcLRsgOpBhHVV1hawJPH+7S2SRYaKbNutW6vbvW1HOBHBZ+qnOgV6crk5bK6alNv
 GoFWJApxjLXd5ILoB9hxr1sOji/qHEVKHzciH/kEeoZN3VrC9afN1VytXL8syL3cVCVbQuH75LT
 yIAKdCmpfoWHfXz/t6ydz9TJZuWD5ROEUQvqGDsim7a9uH6s6qUQ5pI2MPucpxt5V3rkCunyRn2
 kf5Tpb3zQFlk1HIqgnzxInjuHBnIQOXbs45XONR9d35EK1G2+hsdo2TZEbZo0YjBKxVt6H2H3bk
 Yawgc1uex/xDxD9HOlcIpHHXAB6QmnGKDLQqx/zrjQv/1uZ10BcNT1W0hZIlDiInQRsA9PR3dLl
 PXcyw2yEOaJPRREL1L7JnZZG00lBsBIeRQaQFDwfSHaV17C8V5OTJJY/pi3w3yOfqklcksesOpu
 iIK5K0FUdZIO+YBWtdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200064

On Tue, Jan 20, 2026 at 06:57:14AM +0000, Raviteja Laggyshetty wrote:
> Update the num_links to 2 for qxm_nsp node, this will help the clients
> to get the required path handle to vote on qxm_nsp->ebi path.

- Please describe the issue
- Please describe how it should be solved.

Having the link doesn't "help the clients". It allows them to cast votes
on certain BW paths.

> 
> Fixes: 874be3339c85 ("interconnect: qcom: qcs8300: convert to dynamic IDs")
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
> Changes in v2:
> - Corrected the commit ID mentioned in Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20260120-monaco_num_links_fix_nsp_ebi_path-v1-1-4aa2662637a3@oss.qualcomm.com
> ---
>  drivers/interconnect/qcom/qcs8300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
> index 70a377bbcf2930a4bdddcf6c3d98e95e4ad92561..bc403a9bf68c65c5e5b312505933f58c5bbeaaf7 100644
> --- a/drivers/interconnect/qcom/qcs8300.c
> +++ b/drivers/interconnect/qcom/qcs8300.c
> @@ -629,7 +629,7 @@ static struct qcom_icc_node qxm_nsp = {
>  	.name = "qxm_nsp",
>  	.channels = 2,
>  	.buswidth = 32,
> -	.num_links = 1,
> +	.num_links = 2,
>  	.link_nodes = { &qns_hcp, &qns_nsp_gemnoc },
>  };
>  
> 
> ---
> base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
> change-id: 20260119-monaco_num_links_fix_nsp_ebi_path-a658f8fc100f
> 
> Best regards,
> -- 
> Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

