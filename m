Return-Path: <linux-pm+bounces-12517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA1957DF8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE84284153
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA5D16B389;
	Tue, 20 Aug 2024 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l3z+AbXr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874562A1B2;
	Tue, 20 Aug 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724134774; cv=none; b=sW5grpOeOYD7O386YxV5D8u28DkijXlii6iYy8LsuWk14EohHb+b5K7Vez5DLpQz3DOqYoGXOh/G40ukghqQhMIEzkr948kEwdlAhgYzyqpOw+rN50REPOlreLczcXn61nGJM1v+brZse2ly6hyEoz6TwQ8WnMXbTi2sPojw/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724134774; c=relaxed/simple;
	bh=qbLTJSAjd2i5MbXaaXESgl/A7y4ae0phkjCMfbjlFKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsuDRkZXb2yTt1wVQv8shhRxX2KsG+42tIIML9TeSEXQzGtYmtPYkMLjWtVqMjDOKO0x6RrYCaWyrzrPVcmtMKq6+1w9Yjd29SfUjHsOmwFH1v4xX2JYbQNYeZ4lNnD5PT/Ie2X+eP3NPuUxqWZ5rs6WGcyA7envlzpdiHuXLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l3z+AbXr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K026Cv015828;
	Tue, 20 Aug 2024 06:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qbLTJSAjd2i5MbXaaXESgl/A
	7y4ae0phkjCMfbjlFKI=; b=l3z+AbXrHLD9815V2NftGAMqv/B+veGAuF/ex7SD
	PPD+S37RO8tULO8kNH0EwbNsBgd3gP55Aub7I8u3DxniiKXAAyIh6q7vzrfvDsKH
	Hfpe1SegTfzCNUwcWFf9KEFX5KaeoUYtFoEE6yJZ2C0INYfPm1NZ2O1m+QiHXhmz
	IYjnOldISuGMJGfPwSR+mOzEJIdFahC5tj61Y3hoYmbXuCDtrvmuwCoh+Hz2Y1JV
	0Vvsr+rn/tD2nHQiO2jDk1AKCkjSgJ+e4JujRbbt1Rd5YVkYeRbIkntQFS3obBCB
	4KvFfYaLT5mLlSdTMiaC+uB1xWB9aNnbE4xWfWD1nARKqQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m876nvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:19:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47K6JE73027670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:19:14 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 23:19:07 -0700
Date: Tue, 20 Aug 2024 11:49:03 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <ilia.lin@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <danila@jiaxyga.com>, <neil.armstrong@linaro.org>,
        <otto.pflueger@abscue.de>, <abel.vesa@linaro.org>, <luca@z3ntu.xyz>,
        <geert+renesas@glider.be>, <stephan.gerhold@kernkonzept.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        Praveenkumar I
	<quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v6 5/9] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <ZsQ1V/qusOz6uctA@hu-varada-blr.qualcomm.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
 <20240710061102.1323550-6-quic_varada@quicinc.com>
 <d454e01f-3d6b-4a02-87cf-3d289bc6957c@linaro.org>
 <ZpeLYG6vegJYZ5Rs@hu-varada-blr.qualcomm.com>
 <ZqCD3xtkLHbw9BHN@hu-varada-blr.qualcomm.com>
 <iy3l3ybmvllqxtyqq7fifiokxaaedrs22davveel4ikjoqivdm@dinswoc52qpz>
 <CAPDyKFoSK4_gRtOY2_pZhT7AytZ4qpZpRTzg5cOrqJj7A22b6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoSK4_gRtOY2_pZhT7AytZ4qpZpRTzg5cOrqJj7A22b6A@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MweU2tGZChrAwiTpkRejd55buTB5loI-
X-Proofpoint-ORIG-GUID: MweU2tGZChrAwiTpkRejd55buTB5loI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=581 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200045

On Mon, Aug 05, 2024 at 12:32:34PM +0200, Ulf Hansson wrote:
> On Wed, 24 Jul 2024 at 19:26, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, Jul 24, 2024 at 10:02:31AM GMT, Varadarajan Narayanan wrote:
> > > On Wed, Jul 17, 2024 at 02:44:08PM +0530, Varadarajan Narayanan wrote:
> > > > On Tue, Jul 16, 2024 at 02:15:12PM +0200, Konrad Dybcio wrote:
> > > > > On 10.07.2024 8:10 AM, Varadarajan Narayanan wrote:
> > > > > > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > > > >
> > > > > > Add the APC power domain definitions used in IPQ9574.
> > > > > >
> > > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > ---
> > > > >
> > > > > Could you please confirm [1]?
> > > > >
> > > > > Konrad
> > > > >
> > > > > [1] https://lore.kernel.org/linux-arm-msm/57dadb35-5dde-4127-87aa-962613730336@linaro.org/
> > > >
> > > > The author is off for a few days. Will get back to you once he is in.
> > >
> > > Have responded to that query. Please see https://lore.kernel.org/linux-arm-msm/ZqCCpf1FwLWulSgr@hu-varada-blr.qualcomm.com/
> >
> > If it responds to voltage values, please model it as a regulator rather
> > than a power domain.
>
> Just wanted to give my brief opinion around this too.
>
> I agree that it seems to make sense to model it as a regulator, but
> that doesn't necessarily mean that we shouldn't model it as a
> power-domain too.
>
> If it is a power-domain it should be modelled like that - and then the
> power-domain provider should be assigned as the consumer of that
> regulator.

Have posted V7 (without modelling as power-domain).
Please review.

Thanks
Varada

