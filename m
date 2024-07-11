Return-Path: <linux-pm+bounces-10954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B692DF3D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 06:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE38284435
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 04:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3147F7F;
	Thu, 11 Jul 2024 04:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d2r500OM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577A29CF0;
	Thu, 11 Jul 2024 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720673913; cv=none; b=eLBZF1Bjs5ikxH7Cc1nPm/fEm8AJ8ajSO7C9Fv4omwKs+NExUHtnL9KTg2JjToRdF/8fFN4rZSZ1FIN0o9SWKQiaji9XHrP01pUEbwNDrkGG33GxOau5Kg4415hQVvXS5NIVXcmiI5H1gxw0oLPz5+FgVxfz6ENq3D/rVCpc0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720673913; c=relaxed/simple;
	bh=d87vYux2oYnYK80Z/hqKA457vpsQNT+AIQcJKMK6NbQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YplIKy6F4Gw9awuPmyhp0fb4HTA5M1GNHPleermHPm15E0j3ZephWA/xIRpNVuryzQMPAOxkZWuTFJlkOMzz82N1fgWRNhcHIQVLzxKdswbWd+8D6X5Td0LJ2nqu4agijcUL23Knmxd26HSPawpvPm6bD8/OnO+oj+kqeltdbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d2r500OM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4mucc008113;
	Thu, 11 Jul 2024 04:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QfexAfiFTGJbsV6Jlp1wIh2D
	0ABmelrFAt2LL9NkLGc=; b=d2r500OM1kEgbdT7lgvsRYvg6u164GQXn1UeQe2s
	6r9L5GadhK0Zi56M8+9dMFbC4tg8yfgj8Z7HP0ldGd/ep6rEImhMSQCzdhsAiUiJ
	u4fcSxx9NVODKCxuD7gQ6dch9ZcaSSZsIzSVmV4gUvOB99CNLhw6SwvnM56AfBI8
	ZMQqS9NVVlyuqpGGVQAS2qO6saig6WEpam+yfTT3g/uAvzGWWTnMYQmnI43TdaLV
	k8SzwFObPJdtVyntsrKcBRsP/irW+PmfNr8fSIy7UpNQMtdnslhDsDigzBtGJVMD
	fKbIW7y+ikN3DrqZhBG6YnbklV4KzBLYls1umljOhjDt6g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg43gm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 04:58:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B4wCLD004693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 04:58:12 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 21:58:04 -0700
Date: Thu, 11 Jul 2024 10:28:00 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <danila@jiaxyga.com>,
        <neil.armstrong@linaro.org>, <otto.pflueger@abscue.de>,
        <abel.vesa@linaro.org>, <luca@z3ntu.xyz>, <geert+renesas@glider.be>,
        <stephan.gerhold@kernkonzept.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Praveenkumar I
	<quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v6 8/9] soc: qcom: cpr3: Add IPQ9574 definitions
Message-ID: <Zo9mWMUJiTJoj2b+@hu-varada-blr.qualcomm.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
 <20240710061102.1323550-9-quic_varada@quicinc.com>
 <4c3ada32-1476-4d98-89d7-7b2ffa0f9a65@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c3ada32-1476-4d98-89d7-7b2ffa0f9a65@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GILWLXyo901De_1Xy6p6ZkeSDHKiScW7
X-Proofpoint-GUID: GILWLXyo901De_1Xy6p6ZkeSDHKiScW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_02,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=995 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110031

On Wed, Jul 10, 2024 at 01:12:19PM +0200, Konrad Dybcio wrote:
> On 10.07.2024 8:11 AM, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > * Add thread, scaling factor, CPR descriptor defines to enable
> >   CPR on IPQ9574.
> >
> > * Skip 'acc' usage since IPQ9574 does not have acc
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> [...]
>
> >
> >  	/* CPRh disallows MEM-ACC access from the HLOS */
> > -	if (!(data->acc_desc || desc->cpr_type == CTRL_TYPE_CPRH))
> > +	if (!(data->acc_desc || desc->cpr_type == CTRL_TYPE_CPRH ||
> > +	      of_device_is_compatible(dev->of_node, "qcom,ipq9574-cpr4")))
> >  		return dev_err_probe(dev, -EINVAL, "Invalid ACC data\n");
>
> This is something I'd also like to fold into v16.. perhaps
>
> if (data->acc_desc && desc->cpr_type == CTRL_TYPE_CPRH)
>
> could work instead? this way we trust the programmer that
> acc_desc's presence/absence is intentional and only throw and
> error if it's present with type == CPRH

I tried this change and it works for ipq9574.

Thanks
Varada

