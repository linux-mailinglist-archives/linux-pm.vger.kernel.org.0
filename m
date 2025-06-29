Return-Path: <linux-pm+bounces-29811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706BAED1C9
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 01:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D918920D0
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597A241666;
	Sun, 29 Jun 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCgiDsJT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118331EE035
	for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751239835; cv=none; b=cRdVl2D/psDdYXegoMX3t3xSbWMmBmUAahyKgtdQlsAeAFT4OxVP2wAYVD8JrNyNHRRM5OuM4/9uofhk4sK1BZdHJN4d57ew0gZKTi8LlArU2ix7Dufuudqbzza5FdumHqrq2vcIz/BnYqCwN8eYUboZvNlkRyQ35Iq6bweiJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751239835; c=relaxed/simple;
	bh=3AFvXCR+bLX+Z8GgWNplffmabN7kiO9ZobmutwiK+bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEKdJpfGhoeuresDe1mr1vBdLZAzswUYXp3/priBl63sa4r9mS93alPsIb5019tVWL2o+t7/4/OjYbjGOswLEKY/+zP5edAM/3dZpaqetQpqDsgv6noFwHhk22h91f7Yjf8EeW3uLHzZ9tFKs5Cyl0KpYkJNjVwxDo9mYWzocCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCgiDsJT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TKh7CR015768
	for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 23:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S2DTLYpxIRhT/nA6PB8/tp+3
	viSuwHeW5OhO23oo2lE=; b=eCgiDsJTEoNxBfqEo08mj8Z3xu+cN5h7tBDr2b7N
	GAfLLdTEIrwoWEOKSVxRyKmaPPg6Bg5wYMdLdMBnLqwlCNdUylL4WXTclVvRASzT
	HBT2ej0w30v3OjB7K5ETY4cdib2qw25vC4doGeC27MTV6rVRS5EZX7VDyM1XySHY
	Y1TDFEtG3Eob/cTpW9A5XE77tVf2RlxZQuW88rT7GWS+ewc6JUltl2quo4vDayea
	HM5bd/VegdC64DyKAtuAVZ2h9HnluhKHULQ2e1GxfcgxAlAHIKS9xvwcQ4koxuE1
	q7bFkZwk0u/0V0peYimRBLpjOH9nC/82j640OWh6Zhxc/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k30vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 23:30:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7ceb5b5140eso561519885a.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 16:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751239831; x=1751844631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2DTLYpxIRhT/nA6PB8/tp+3viSuwHeW5OhO23oo2lE=;
        b=DHkTFM15NkoHRaV/+udJBhD+cVUDxn5IQW2hYOnp2fi8x+YxcrCCdjLpfWYEmiy/fM
         o7uVGejERPrQRnFepeRoEnXw62DkKuXrH7rXvo4eddQVbYHfarOilPhnBa0gTwVUn5Iz
         3n3hZ0V1JmLQhWa21bm8pUuEN2I45SPnpkWTfx//u0eCwdhMExub2ZPmPBmFWF3IFO8v
         7D9q8LMQ6SWbc9EBKqj4o9+GE9sb3aQN5ScRKibIeXz8N+cjLUFIiYrMzc1SXGmgGz8M
         bLv98eDZmUIrZvWHekm5dKkQ+AUuziaI0tFquD9Ysiv1ZIUUqlLI521xgAFtAC+6Gh0O
         mOsA==
X-Forwarded-Encrypted: i=1; AJvYcCVVnwEWlN6j2MJRZfynra0lvroo+6Fhl5DfjckZzzrFFa0hc4RhWEbllR84t7F/doVVKtwfU7uIxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Yva/PDZo/OlQdLAP+auQ5D5BrsXz+zRAHHI5JfHsX8ow4gKU
	mTDLux7uoNV0ZC0Wm0QyaAEDUNrjaW5Pkzqxf/ypDF5AbLWwZ/xHy1mUduhO5cj7CM6C5/7IrAj
	deh24O82zkM2D10CncN3LvHpK7eu0L9r/G4V/99cGpXI7xrg3lw8k+7PpJ2+8qQ==
X-Gm-Gg: ASbGncseVneLQ6/JDtnxGZ8EtlMOOGFuVsO09sBAUGi8hPxQ/AmixR/WCRpnG61Gjs2
	/MEBb1DzUHSIWTV23x5wCdkzrV/iC2KPZrOS2emN7DYndq6zWWuclG2LmpmMP59eeVm3K2Gcw9o
	fNlcuJp4jErFWhnPDQFxvroz26wWC8wER5OMFRWwdgM3nAVHgUxJVIPfPcCudk0Faj/mbnMHze9
	+sBkCKQR8H+Gs762zjnWtkp5/xByEO/YSbnbBlDgySYe9l/b/536+kcUyMTamBJTzbeItKWp+Hi
	eo6jk1I3jvfF+0b5huTy386C6UPSiFO/RiuUwGTGZRfoapsDIjNbQdW5VhKEIVM6oBkAlHDPh5y
	nq8lSrWWb7IIBwWo7b71XE9XEAFdmBrhZB/Q=
X-Received: by 2002:a05:620a:1d04:b0:7d3:c501:63da with SMTP id af79cd13be357-7d443985d4dmr1744006885a.48.1751239830844;
        Sun, 29 Jun 2025 16:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsLLpB2ln2NTNuxE8oAZN1AOX2vanByzGZqG9Al2zbL1LihsHxYQPgaiL9CfBNyLjW9EH3XA==
X-Received: by 2002:a05:620a:1d04:b0:7d3:c501:63da with SMTP id af79cd13be357-7d443985d4dmr1744003285a.48.1751239830424;
        Sun, 29 Jun 2025 16:30:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2407b4sm1245026e87.23.2025.06.29.16.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 16:30:29 -0700 (PDT)
Date: Mon, 30 Jun 2025 02:30:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add SM7635 power domains
Message-ID: <strdf7m7tjnktyzwcm3iq4bkhabzibxopeal77cnetga2yp5wy@amwkv63uoogv>
References: <20250625-sm7635-rpmhpd-v1-0-92d3cb32dd7e@fairphone.com>
 <20250625-sm7635-rpmhpd-v1-2-92d3cb32dd7e@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-sm7635-rpmhpd-v1-2-92d3cb32dd7e@fairphone.com>
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=6861cc98 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=3owI59sVmJdHpXqbcb4A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDE5OSBTYWx0ZWRfX1T8uwldIdIyq
 bQB+ePn/m+yeJzPegcB7eMFGH9GagrmQDRwaihpaYkZz14nz5PYlicT6DIPQ5/qibkp1iapiHod
 2Dy/LLfqnIaKOWmKDTlIwd36BRewu7UupS5bQbmo1Bk3wghsETvWWEbknz9RadLOvpv23SmBKLc
 lpnZOmxUaR11Q+cWFzv58Mj8xd+rGBUiN+7y7IVUjOGvrg3bc44scQxYkdoS9DGBnzkRgyv9VHr
 c33XU2yLT1bBTQgPT37dsvQ4QkAx66uoV3JcLvFkUtcWv31nKPharSYwx8oA0V3eaby2vixWSp/
 81A5nhzvFxAUSw9ivOXwEbvYkBMfpNmEDczOjQHtr8MUgM7+NO3TTDNfBJUPo6cmwFZ4XO3NJoV
 0KnIMm6SDTDsLk7Jx5X8YG+1fmc708HkDSIZcGGjquu2xYsxPtlW0Q8VxLa0268LtyKyiT/z
X-Proofpoint-ORIG-GUID: 4oK1oa1hPnRn6kjwNqHlVUqC_rqcZ9JL
X-Proofpoint-GUID: 4oK1oa1hPnRn6kjwNqHlVUqC_rqcZ9JL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=993 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506290199

On Wed, Jun 25, 2025 at 11:13:24AM +0200, Luca Weiss wrote:
> Add the power domains exposed by RPMH in the Qualcomm SM7635 platform.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
If there are no renamings involved:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

