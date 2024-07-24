Return-Path: <linux-pm+bounces-11357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4AD93ABEC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 06:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A25283077
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 04:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C2122EE4;
	Wed, 24 Jul 2024 04:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tp0CBPst"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DF1C6A7;
	Wed, 24 Jul 2024 04:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721795273; cv=none; b=pMi4LZhoGWNE9NpnsJHovaoG+pGZDi++OZCwAZ9EbJVP9UB6ybySAli9SehPsMXXNHWiMUyykl30+fQNNFEcYS077TLGhwTbnwG4nwfyk0KLA76CfHvmoHhjYpEs27w/GKTg4z2mF3FOaHiMHcYfFas8Pd4alh8zPDq4+F9L+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721795273; c=relaxed/simple;
	bh=TWZVcAEZiMIDf2h+QNy+AMqFAKDMH7yPY7ohksFILco=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxnX0K+KHB10JiF6xngnhdW11S7O7pHlAm/BcNFXvpObOlAXn0AGfsWJ8wJgrTTD+85N/n0IulbZXcSVEZRafAD/AI474XDGqcTLVi1GYEdvd1AIMgugdNpNu7AFqNooDvVkpu3vigwyZa/XKwbm965M2f5nocU16+MuhMHBGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tp0CBPst; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NJJJgP014210;
	Wed, 24 Jul 2024 04:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QOlnl4omqsg3tyOpodtpohkw
	0Op2/eozE1FQDHxFY8I=; b=Tp0CBPstI97Ht6ti1w3Ep+Zs8ZO+GXvSe/M73ioJ
	/mM5BfkO1lQZDheipxZ51TGlHmimRr+xD6y3qohhGf9ZcLlCmVTKNPEtoRI47Cp+
	bS7UwBEEk+XkIwNGAsOToML6L5usS9g36JzZpsY7qAJeeccdYlx8et46LAT8j7uU
	Rcwm75AdH2uVS6xnwIvfiYDnByU2Tz3I2ZnFLeJ2YVcc2Xc09bwBX3UGV2ZJn+me
	f29VGGwisFIvk6vXhjonJkjfS5KM5RsqaUgdPoT1jJxLHlE2kNXXDvly8NrimURH
	lQuyJMGrT5mXv3SRUURhxRcyvvi5iMOV2AMrsK+ZSoNhFw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5f2guxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 04:27:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46O4RSnT004404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 04:27:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Jul 2024 21:27:20 -0700
Date: Wed, 24 Jul 2024 09:57:17 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <danila@jiaxyga.com>, <quic_ipkumar@quicinc.com>, <luca@z3ntu.xyz>,
        <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 05/10] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <ZqCCpf1FwLWulSgr@hu-varada-blr.qualcomm.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-6-quic_varada@quicinc.com>
 <57dadb35-5dde-4127-87aa-962613730336@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57dadb35-5dde-4127-87aa-962613730336@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S0Bqv5CtTb5jOakT3ySrFZ5x59sVL5Me
X-Proofpoint-ORIG-GUID: S0Bqv5CtTb5jOakT3ySrFZ5x59sVL5Me
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_02,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240032

On Tue, Jul 09, 2024 at 11:52:19AM +0200, Konrad Dybcio wrote:
> On 3.07.2024 11:16 AM, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > Add the APC power domain definitions used in IPQ9574.
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v4: Add Reviewed-by: Dmitry Baryshkov
> > v3: Fix patch author
> > v2: Fix Signed-off-by order
> > ---
> >  drivers/pmdomain/qcom/rpmpd.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
> > index 5e6280b4cf70..947d6a9c3897 100644
> > --- a/drivers/pmdomain/qcom/rpmpd.c
> > +++ b/drivers/pmdomain/qcom/rpmpd.c
> > @@ -38,6 +38,7 @@ static struct qcom_smd_rpm *rpmpd_smd_rpm;
> >  #define KEY_FLOOR_CORNER	0x636676   /* vfc */
> >  #define KEY_FLOOR_LEVEL		0x6c6676   /* vfl */
> >  #define KEY_LEVEL		0x6c766c76 /* vlvl */
> > +#define RPM_KEY_UV		0x00007675 /* "uv" */
>
> The "uv" key is handled in qcom_smd-regulator.c.. I'm assuming on this
> platform, it accepts level idx instead of the regulator properties
> and this is intentional?

IPQ9574 RPM accepts regulator properties (uv) and not the level idx.
Hence added the "uv" key in the rpmpd.c

Thanks
Praveen/Varada

