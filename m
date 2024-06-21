Return-Path: <linux-pm+bounces-9740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874E911CD4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 09:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5917B240EF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43616B75D;
	Fri, 21 Jun 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PdfMISyd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7C16B74F;
	Fri, 21 Jun 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955057; cv=none; b=P9gzuFOs6V9JDq5YPtP7Jlm54W2hig24ZsSXxsMNLhCfLC1zZ4fB/g9GVWEzaFmYHGpiY2GIwovVP7dUljPlu7+Q9XAowf0RrUY4C2BGsDR92+WGOJwBOkDoyVo8Yj7EOzJ/ge8EZaDkJSNSmjVUAMbX6pPPKO/As47DIrEO5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955057; c=relaxed/simple;
	bh=ko8J2UaKlSl/BDPlAtHFYwIIw4yfwjeKtWhC1B1E6dI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfhVGj8VTXUysLGlCDz/3Lf81KQQ+LFWAGnIpVI4CaJBd7h8qE4/hXX4OfhsY2rRhS74ZAS0U8mP/yOWGBng58V/r1v1F644hPuzvFrBuP8+1XOZSQMEGZ62gApCNIrzy7cXkyt0O4SDhaQHJpUwuzFLL0eaEm4JWvGgHQyvSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PdfMISyd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L5tdhw023962;
	Fri, 21 Jun 2024 07:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ko8J2UaKlSl/BDPlAtHFYwII
	w4yfwjeKtWhC1B1E6dI=; b=PdfMISyd+3hSBZ1Ke013xq1J2zysYifRDPjAQ8mf
	63t0Oq8F+STq05ZXQDoltyCI+30YcLArzi+iIctkeBOJZEhAkNojqvG1/6sabk3N
	gjdxWdf1ouecy/Es5gE5yQILuoXPrxCBIh88yD8mSeRTQ57aftuX/REz4aS6lnbe
	lYz/VkRlnSKTNFJt2ybQ4Wr0Y/8VL/3WlkoUvRwJFFSySJLP91unkez7r5U+z0Xw
	48QB6N5Tn1EZrr4Z+xVsjyGIm8h62N7wKW2nsJopX+2GDCqChRHV+M/tffvdW5+D
	92c9QlT1FI6zTDWRuDvKnzet+mRAfbPYGR92vz7nuCbVJA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrksswd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 07:30:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L7Ugpb026188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 07:30:42 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Jun 2024 00:30:36 -0700
Date: Fri, 21 Jun 2024 13:00:31 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <quic_rohiagar@quicinc.com>, <danila@jiaxyga.com>,
        <otto.pflueger@abscue.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v1 3/7] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <ZnUsFwQyc7JRTXl/@hu-varada-blr.qualcomm.com>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
 <20240620081427.2860066-4-quic_varada@quicinc.com>
 <jfh2xygjdoapkno2jrt6w7thlylgyp2tk7oaczundhxvi26qel@ahtskgn4v6sp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <jfh2xygjdoapkno2jrt6w7thlylgyp2tk7oaczundhxvi26qel@ahtskgn4v6sp>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3EDCezE50oxWbJ3qrC5dswBy0blzoSZi
X-Proofpoint-GUID: 3EDCezE50oxWbJ3qrC5dswBy0blzoSZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_02,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=628 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210055

On Thu, Jun 20, 2024 at 06:09:51PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 20, 2024 at 01:44:23PM GMT, Varadarajan Narayanan wrote:
> > Add the APC power domain definitions used in IPQ9574.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>
> The order of the S-o-B's is wrong. Who is the actual author of the
> patch?

Praveenkumar I <quic_ipkumar@quicinc.com> is the actual author.

Thanks
Varada

