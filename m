Return-Path: <linux-pm+bounces-11363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD11993B084
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 13:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7880D1F22376
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D2158218;
	Wed, 24 Jul 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D833HqNt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E47157491;
	Wed, 24 Jul 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821302; cv=none; b=ZvD9blLyoSfIxoJr9t991mfgQi5WWm26PxEhpoWYEGCw7vrP8Non0vvlSSGspw3JNLlISTAeX9yNtpM+HIEu6ep73k4i68xADWo5gUIBvJSI81AnAitertdiHvy9lth9gyvlj3j+AalI1VMVJJXcFLvXZgeyx9CpLYAL6KDs3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821302; c=relaxed/simple;
	bh=d1Ns+5LkQvsZe/siQ7yuoNSB6lvRMz+MwI0I58Jn1vo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZVV9JXq0N2XDDdPuq82tSn+n9ESUytHnWn/S9cOqllFRFvdvQikzySfohuP3BFrztVsMZOwQs/v6T4w444Wq4XG/vvTfluqjqrTf4+MekmkcxGYhHCCAH3T5wFeykSfcQ+c/lBtxrM7AaMpkL4HQe+Zp8he/4Kugk+fBCyLsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D833HqNt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OA1BKX024464;
	Wed, 24 Jul 2024 11:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KhQqIkeiBaXXkN34/9Ic5EkX
	2Yz+Ln/4BmYXrH6NppU=; b=D833HqNtNGPwsoFyoBj0m19fSmo3b+ZxEvCIBLxf
	4qrHalXv5azR/QiVHfRQbN9CMFPLEfYGZXGElJKYmbrY1bx4PlPJJ0igvJVWiqqx
	JOCUBistfbf6QGiPCDGb43pSKzzE4J+0xcmMZlmFg5iLmVEW7Itj7hPqiA3dpXEX
	BHsXq319bcYkkjEu0yXDf1tEjlh7upTrN5uBAmdDuMfd5RshYD/ihPdpA9dFWQ/+
	bCGf4EWZ8BYMqFF/g7M8D2SJRVn9cU+L88AEGdF9r/JhaMKs9pdq4IRgCzJCg7Il
	VrY8EVCKuSuuqOHGMjcnTpu5zmQ7Ro7NLWYTMkSD6vV4xg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487hw3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:41:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OBfRHV005665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:41:27 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Jul 2024 04:41:22 -0700
Date: Wed, 24 Jul 2024 17:11:18 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: usb: qcom,dwc3: Update ipq5332 clock
 details
Message-ID: <ZqDoXu9+Y4+O8M7W@hu-varada-blr.qualcomm.com>
References: <20240723090304.336428-1-quic_varada@quicinc.com>
 <20240723090304.336428-3-quic_varada@quicinc.com>
 <ac34c454-4800-4057-9a50-e0c5db1d3806@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac34c454-4800-4057-9a50-e0c5db1d3806@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AJVnSnLziNAnVkth4RS54Zj9prH9RW5_
X-Proofpoint-GUID: AJVnSnLziNAnVkth4RS54Zj9prH9RW5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407240086

On Wed, Jul 24, 2024 at 08:27:03AM +0200, Krzysztof Kozlowski wrote:
> On 23/07/2024 11:03, Varadarajan Narayanan wrote:
> > USB uses icc-clk framework to enable the NoC interface clock.
> > Hence the 'iface' clock is removed from the list of clocks.
> > Update the clock-names list accordingly.
>
> But the clock is still there and is still used by this block. This looks
> like adjusting hardware per Linux implementation.
>
> Why suddenly this clock was removed from this hardware?

This clock per se is not used by the USB block. It is needed to
enable the path for CPU to reach the USB block (and vice versa).
Hence, we were adviced to use the ICC framework to enable this
clock and not the clocks/clock-names DT entries.

Please refer to [1] where similar clocks for IPQ9574 were NAK'ed.

[1] https://lore.kernel.org/linux-arm-msm/CAA8EJppabK8j9T40waMv=t-1aksXfqJibWuS41GhruzLhpatrg@mail.gmail.com/

> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  .../devicetree/bindings/usb/qcom,dwc3.yaml      | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > index efde47a5b145..6c5f962bbcf9 100644
> > --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > @@ -220,6 +220,22 @@ allOf:
> >              - const: sleep
> >              - const: mock_utmi
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,ipq5332-dwc3
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: core
> > +            - const: sleep
> > +            - const: mock_utmi
>
> So this is the same as first case. Just put it there. It's your task to
> check if you are duplicating a case, not reviewer's...

Will fix that.

Thanks
Varada

