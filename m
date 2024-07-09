Return-Path: <linux-pm+bounces-10815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF092B0BD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64DBB2137A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 07:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F541422C7;
	Tue,  9 Jul 2024 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xg0BRq4p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946CC148;
	Tue,  9 Jul 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508505; cv=none; b=QlEpyGBoPWMol0Vn9pNhng5QwCEOSReTbqdX9cPaXp2Bm7xdkIuFdzJylc0ZNdsv5NY8t2iNq0/z+O82lflVuNXpdawcNo+6K10thavcVtTqiSWvTKxO7A7E1o8Mi1RbX/a2agjGNeJtEMFnjTE0jUfLQ/x15CaVDco8hftS39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508505; c=relaxed/simple;
	bh=tkxHSt+B95UwmZobLotNEd2km4xRfzDRpmtKe5OC7N4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTbalzGQESx7F1UrUQ9vmtqhTzT25ACioYgtGF1cYfzz77Vb7+pRi/qThnPJvs5fB4UZaxNhybx+vB2iBbniBPsD7n2F6fZ5PM5trpBCmoXg6bciz6cOYBjnbEeShJwJo3+5l9O9oYrAl0u8ugEMSAMp4SO+p8MAmCM+Sv/1ZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xg0BRq4p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468LeTLr003367;
	Tue, 9 Jul 2024 07:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xr+9HQV02Fcj9GHm1nozqD3P
	M0XQKi6JALqEWo018nU=; b=Xg0BRq4ptQzGsR92sTgnq6qpKyHDN1ZMT1bqi85i
	4cuXKoaCrcnXFxntJ1CFZD6TgMuIBHOg4x1R1uxfny7dS3QhC9PVSqrph299yKaJ
	gOacg4cthVLy28yJrMjA/Ps6x2L4V00sqme0FT9A7whEdOj7zVArfsywCLxiA5bz
	d3cdBOhY8lvYL/qfylPsxdk9ChtquY0LrZCiv3kjZ4lyNep8JbC/106MFaWoXrjU
	SqT4yn9iSHaWzBuEIk3NEYZRhOjzGDEUJ4c8wKMl4eJ6px3feMC725WIM3yojk9I
	kfDqRJvKto/RLgXg/joOrykyL4HmGTeXoENvEWiT44HNqQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wjn5tj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:01:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46971KaQ025688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 07:01:20 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 00:01:11 -0700
Date: Tue, 9 Jul 2024 12:31:08 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <konrad.dybcio@linaro.org>
CC: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_rohiagar@quicinc.com>, <abel.vesa@linaro.org>,
        <otto.pflueger@abscue.de>, <danila@jiaxyga.com>,
        <quic_ipkumar@quicinc.com>, <luca@z3ntu.xyz>,
        <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] dt-bindings: opp: v2-qcom-level: Update
 minItems for oloop-vadj & cloop-vadj
Message-ID: <ZozgNAYKAvhPr0qk@hu-varada-blr.qualcomm.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-10-quic_varada@quicinc.com>
 <20240708155529.GA3244015-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708155529.GA3244015-robh@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ykjOmWRJUdJvIsIxFljEaW9CMVfJaX3Q
X-Proofpoint-GUID: ykjOmWRJUdJvIsIxFljEaW9CMVfJaX3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090046

On Mon, Jul 08, 2024 at 09:55:29AM -0600, Rob Herring wrote:
> On Wed, Jul 03, 2024 at 02:46:50PM +0530, Varadarajan Narayanan wrote:
> > Since IPQ9574 has only one CPR thread it will specify
> > only one voltage adjustment value. Hence update min items
> > accordingly for oloop-vadj and cloop-vadj. Without
> > constraining min items, dt_binding_check gives errors
> >
> > 	opp-table-cpr4:opp-0:qcom,opp-cloop-vadj:0: [0] is too short
> > 	opp-table-cpr4:opp-0:qcom,opp-oloop-vadj:0: [0] is too short
> >
> > 	Failed validating 'minItems' in schema . . .
> > 		{'maxItems': 2, 'minItems': 2}
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v4: Fix dt_bindings_check error
> > ---
> >  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
>
> This is going to need to be rolled into your dependency because it needs
> the same fix.

Konrad,

Can you please squash this into https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-2-9fd23241493d@linaro.org/

Thanks
Varada

> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> > index b203ea01b17a..1c1a9e12d57a 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> > @@ -39,6 +39,7 @@ patternProperties:
> >            An array of per-thread values representing the closed-loop
> >            voltage adjustment value associated with this OPP node.
> >          $ref: /schemas/types.yaml#/definitions/int32-array
> > +        minItems: 1
> >          maxItems: 2
> >
> >        qcom,opp-oloop-vadj:
> > @@ -46,6 +47,7 @@ patternProperties:
> >            An array of per-thread values representing the open-loop
> >            voltage adjustment value associated with this OPP node.
> >          $ref: /schemas/types.yaml#/definitions/int32-array
> > +        minItems: 1
> >          maxItems: 2
> >
> >      required:
> > --
> > 2.34.1
> >

