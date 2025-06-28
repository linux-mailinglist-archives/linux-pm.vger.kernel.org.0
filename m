Return-Path: <linux-pm+bounces-29726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AABBDAEC3F5
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 03:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BF91BC5556
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E691DF75B;
	Sat, 28 Jun 2025 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2HEW8b7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7981CAA62
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075867; cv=none; b=fGUa6JIaC0ZESF/HGzjuqhoJMXOp8fmY6xi/t9pVyJ5fCG8NNvRB31bsO256FmYLTfksDJIhafHYoz1dDElk8km7XoRZMhYfVOq418h40J8+fYR+QkND3qDVzYi3ZVXCvRH98PbBu25ug8cXil64oJgBUUHU77fDrlIi7hqKrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075867; c=relaxed/simple;
	bh=eB2h+WWGUWxTIdXYzQWwwYrg0DgFAVeaboMVJ48OFSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmFH++LpGoQ5emDaSVIJL7/HG8MJF87DUA4WTRTsTG4lJfN4/gp8P4+hqY+a2aKn8qpdOLbH68w3NwP4q2QNZaViZpSHqFvDEFimnVAt+AfgPaC8P4AtZFTxzEg9BlFlSQT2UrJDA5CyOdG6xsFpy5bR5+7xaeo/ihpusQi4SBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2HEW8b7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55S0DbeU009934
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C1cLAjsBclJ0QBWDw60ZW2kU
	AMy0clXSWHYg54xP/7I=; b=a2HEW8b7NwtvWqvduqwrtvZYP2KmDBQihQJw9qF+
	t6OrJ5fyQpJpC+49AyB0QMlth9sZoUNjNPz5hDM894auBz0LGAC91rYKbzOOUM3n
	+zeqEtjULScwi6lMxT4rHy6Y6qFuSfafVD+5j4gydEvOis/VRxO3nPqQ5ExEDsLT
	heF6ksAC/Iul0c8CjaH/XEI2hidAVHG03MTKIom7Gtc9aoaeYnQG0Z7ohTABPlmM
	U3OPmV0y5lP1lsfPV1Cukb94IX6NBlhnqKrldPf5aPCqnhxkDgSPiJpUdgFKpTD3
	nDYmnqjb7TokykvNX3obqz2wS5L9Hl52tlfBvrIWojgn9Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcn26eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:57:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a42d650185so5368341cf.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 18:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751075864; x=1751680664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1cLAjsBclJ0QBWDw60ZW2kUAMy0clXSWHYg54xP/7I=;
        b=IE0mTl8DCrvBqk58G3q9RbVr2b1w8paFWiruQjNIznTuE1OICrbADVts/scztMhcEW
         QDGlJryjrYdIy9z6rTiPRHZ/gmvA9OH2I7zuhfBaFBQDOFirlKZhDWSWzwkGyHI+2uHQ
         dAxqSNla7p3rd70t7xaX8qpHOHjRPtO8U2QZdUndIwB0Noc6xVANcxbVVGs3A0+g9XKQ
         431zn41ghfBnL4ihcfa6Oq7Vds9vIoBkVtOIYdd9ff6kH5pZ6qbpBQR0mav4GETftbay
         Y/nykIenTrskZ3rQJh1r4x/YYp0vLZgQW5W4BW3iTVuTjGiduCnxYAAezaKRxDNSuq/I
         0GNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCWQHvALPMYOj4kF9deGCI78V6x+7jaKlx2h4XpBU96lhCZMIzh14Wlec5SmKH3CFFqqw2IfGtlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTYu0NjgIawZvrISp+/8sxiARmIbJ1m99TCtIt5cicCiYw1sk
	A7DebiH2yVe3GKuubyfjns2P5tQliJ2aJC4t1D3w9IF2XQVMaBlysyKcU1ch51vUIjxP3S2nemF
	3E8LRJBC8y6PgE5PUux6HJz8gvwTgZBRgo/1Z9k51OjnkMu4XclH376FsWLr2BQ==
X-Gm-Gg: ASbGncvkJFmV7GrW8NcjSsRUp4ILNlKMK6AEVLb+O5CPYpyqrMWkWtQwou+J82GXJxE
	fI+My4aXavOI+zm05QysH+79EAsiNBlYOITN9HJZIzLMns/BU73kIVWY/tl3GjKziM3MWRaMERJ
	yZzQRFiaQeU1JXCv1+GOLAOl2XY+Iuyp/PvXIOsrFbXSYNi1TvQFJsEeGF0NCegStVCFQwT2AMl
	FQ2/OF7YYRm5YizicktuRBtk++6ljosmw7wQyZ4YAtOGRE+ASlUhLgcA/wel/zPDPfVgg270smD
	w4luOJ/bp4zXVdzn6mRGWbGX9s+V6xxEIDsHeZTJ0ekOLpaOBdKO4Q2OU1uAxlL7K/1fLZkQgbm
	CAcTEhLwGzi+DtfvkmxM539bSQPPjkbuuVsQ=
X-Received: by 2002:a05:620a:aa19:b0:7d4:4b0e:eb1b with SMTP id af79cd13be357-7d44b0eec28mr241536285a.45.1751075863738;
        Fri, 27 Jun 2025 18:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Hltdir3SyFuBpeLJoJ4afHk65Pi5pMb3NzWsxG3FHxbeZRywpOH7wvixrcleSdr649yHIQ==
X-Received: by 2002:a05:620a:aa19:b0:7d4:4b0e:eb1b with SMTP id af79cd13be357-7d44b0eec28mr241535185a.45.1751075863298;
        Fri, 27 Jun 2025 18:57:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2f01ac0sm6638601fa.101.2025.06.27.18.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 18:57:41 -0700 (PDT)
Date: Sat, 28 Jun 2025 04:57:39 +0300
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
Subject: Re: [PATCH 2/4] interconnect: qcom: qcs615: Drop IP0 interconnects
Message-ID: <3edj53e2tlwqg265udg7gjk5lfmlwz6higfm6roq6z65qye3o3@wjbjsjq77wjh>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
 <20250627-topic-qcs615_icc_ipa-v1-2-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-2-dc47596cde69@oss.qualcomm.com>
X-Proofpoint-GUID: uaqQlqlm4tJkixTnD3Ml_ztv_Dnu6TCA
X-Proofpoint-ORIG-GUID: uaqQlqlm4tJkixTnD3Ml_ztv_Dnu6TCA
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685f4c19 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=wxkdqnHnqkY9PcZr0RYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDAxMyBTYWx0ZWRfXyBi8B4sm8Rin
 3Pm50hRv1PhaPxsOdpSzO50GhZLsS5+AQyzTIAgYB1y0rQe5zgBPvsnv9G40nwM/r5ATJS3qLEu
 igrTd48stbm9mZryse3ln0SewHRi3ZRW5uFcbTIRR06F3V+qC0YipmAayafoEe47id1D5moWGuF
 DGfI0i+86m+e5uNxvMz4y1x1SYo3qN7WUnRduwlmFdqBHcj+DohTd9xXghOnEvCXTBH4cDaXruB
 4LAzt0jKpG1YsL9oarnnKCwFm67sZl5+7z2IQdBM9Y3UEd8o4GpPEuzZSqJyw1lSnx/UcYU9WzW
 zh+Jr+WCp4qQaVPc/nwX6z0kZmk/6ELBTNOTexq500j3YsanoIaVU1hUmZnG/BCv+dGYf5c7nBZ
 n/SeagTYfYHmc0hr4XSMjzrpD6n5vvEf1BvztDL5yrZBcc+LJVQK70P7NcVLmvOlTL+jYkiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=856 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506280013

On Fri, Jun 27, 2025 at 09:37:56PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> In the same spirit as e.g. Commit b136d257ee0b ("interconnect: qcom:
> sc8280xp: Drop IP0 interconnects"), drop the resources that should be
> taken care of through the clk-rpmh driver.
> 
> Fixes: 77d79677b04b ("interconnect: qcom: add QCS615 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/qcs615.c | 42 --------------------------------------
>  1 file changed, 42 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

