Return-Path: <linux-pm+bounces-9544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42090E40D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D5C285EB0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E474C08;
	Wed, 19 Jun 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KiuYjfU7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D86139;
	Wed, 19 Jun 2024 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781012; cv=none; b=UVDwrvW1jblPpgTgjWh+yLf+pXV5ss48LWUKZ9KHAEzyniZ1+Dv/ncSMx5R6VcGktippxbauten11MywGx9T0C6vgcodYarlBc+YDwhLlVlwV+1lBO4eWVaEBUL7adYs/VDLPNwf6Oq+YxKosJDYnaQtsDPEKuCuPnO8Fqhuyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781012; c=relaxed/simple;
	bh=M1GIqjd/Va7JmJ6t/tSwtO2lOn9qIFlIljq6R10ThiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jegwn1bFb9BMVkr1EEkYrY00LsoGp+ZFthttWOMyeh3Key5kKEkdxy/a3im5Icr5EmqBMks9U+21LQFSVkldZugH6bTbfhmR5rnurBDYCoEx5yQ36dd7MMh5xc5hm7ehDqwWBCdRYeKn4spzmXa74LEXkJ8ipuukuMqyG4ebkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KiuYjfU7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILb5pq000495;
	Wed, 19 Jun 2024 07:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M1GIqjd/Va7JmJ6t/tSwtO2l
	On9qIFlIljq6R10ThiA=; b=KiuYjfU7YS/uT5L5ZzYH7c/ZjB8G/HI/rpwBdSVW
	HFK0OtzGDuWMh01m7waf2eDDVNvAA/mqc+J+ZlW1iFSd2DOFp7kKJz1se6imykFc
	TOfVX4+UWrJqXghzP6JU0uOBH5KiLUiM29WihsQvH4F1kmmUc9NtK/RwhV+aBJgR
	3vtx/8n7UADAHzT0xxgfSV0/luTyOpEw+wTkKOTeAiPzBL4FDPNL764fYD5LGi19
	wqgV2QM4niW7Yjom8rIxyN6aXz2jGLSL0fbJHo2LA1P/NbDZN+8ypq3+X/da+18t
	nMukR51JxSqy5I7pWRlkbES6N7EfmEwxHx3ysJ67RXK9fA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujag0wtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:09:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J79sr8029269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:09:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 00:09:47 -0700
Date: Wed, 19 Jun 2024 12:39:43 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Niklas Cassel
	<nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Jeffrey Hugo
	<quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v14 0/9] Add support for Core Power Reduction v3, v4 and
 Hardened
Message-ID: <ZnKEN6vWBPwvILlB@hu-varada-blr.qualcomm.com>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <ZmlUElvlOPBdfn61@hu-varada-blr.qualcomm.com>
 <106cd2a2-42de-41ec-8d2b-f4cd6ff9165c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <106cd2a2-42de-41ec-8d2b-f4cd6ff9165c@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vtQoxNXYwPn6KnFa5Zxf4IXT8qZvW0TK
X-Proofpoint-ORIG-GUID: vtQoxNXYwPn6KnFa5Zxf4IXT8qZvW0TK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190051

On Wed, Jun 19, 2024 at 01:58:04AM +0200, Konrad Dybcio wrote:
>
>
> On 6/12/24 09:53, Varadarajan Narayanan wrote:
> > Konrad,
> >
> > > Changes in v14:
> > > - Rebase
> > > - Drop cpufreq probing block (merged)
> > > - Pick up tags
> > > - Drop quotes from CPR3 bindings $id:
> > > - Drop useless description: under compatible:
> > > - Link to v13: https://lore.kernel.org/r/20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org
> >
> > This patch series is needed for IPQ9574 CPR support. Do you plan
> > to post a new version or can I try to address the comments and
> > post a new version?
>
> I'll resubmit it soon

Thanks very much.

Can you please refer to [1] for some minor changes that
I have done on top of V9 to rebase to latest linux tree
and CPR4 compliance.

[1] https://github.com/quic-varada/cpr/commits/konrad/

-Varada

