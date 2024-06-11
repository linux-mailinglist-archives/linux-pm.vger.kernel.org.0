Return-Path: <linux-pm+bounces-8983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4B9047A3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 01:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A641C2378F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337B155CB8;
	Tue, 11 Jun 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T2FlKVu/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB615383E;
	Tue, 11 Jun 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148200; cv=none; b=HKXdRx8YvUao3nnOUTRxz4g5ge3pZYHwgCybUKuTwRBQ9f95FnThPgAAMuV2BdXayl3M27waO73pVlgcweujWV/fhv9BxPBU5F512VVfldk6FrYTqKaoA5mLgb/cRVWgXkqDIziuweTwr8YBZOHdvK9jLMnhfuX5IVlD86VBY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148200; c=relaxed/simple;
	bh=YopLwf8pAChenbbtlUjXOJkMg8EoT8uk4YE7aHt3PZk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXO5PpVQexENY2QOzlJwyhOOoiINVlUPbfdiNMYCBFobDimwFrvuHYCv5Pqprr14yvaXYni21/BUEJ7RaDgbrIpeVOpRiUHFYYdpyvrN84OwiSmOFoRUWXyL4QaVIWH301w1dkWqKvONFOiKe6r68rQqJd3A18Q72wmlDHIbxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T2FlKVu/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BKi3Mj018553;
	Tue, 11 Jun 2024 23:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6CCprVtu51dZoYd4pj0Vb+xU
	0u9s6Y1VE85sCXVJ3/M=; b=T2FlKVu/ivV50BwYv8L3u+dR1aB2GwpSNMg5UTW7
	Cqpz8TqKmenQz+M/AAhcB5qGhPVHhbQ9fp/cQwE+Ghou7wNnAfJ95dMhVxWeU0vm
	rZitilUMtK976FfD/SeSANsV21bCQYowoZIYd+EF3E9S/2Nxl6cvTySG8NkNsFQK
	NNQ4OoeYoVWdnE/KynEmcjh+VRsWpPiC10WVanFgbQL2QjsNKJa4RXQbxdE1SSQX
	atnYLq0IPfHrb2vt2CkxcAYCxxgpDOphIt4khiVftcrX9sRLirV4Z0c1ofa07/jn
	YF7sqveeQrnoNS29lBxGIQHc0bOLKLzzexG91AZoukf6FA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypm6b9v8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 23:23:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BNN0FN018794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 23:23:00 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 16:23:00 -0700
Date: Tue, 11 Jun 2024 16:23:00 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Rob Herring <robh@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Message-ID: <20240611160619020-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com>
 <20240611-arm-psci-system_reset2-vendor-reboots-v4-1-98f55aa74ae8@quicinc.com>
 <20240611204001.GA3026541-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611204001.GA3026541-robh@kernel.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nJ_9VLNi8KTGk3bVqfIgDuMlmBQ2EDRl
X-Proofpoint-GUID: nJ_9VLNi8KTGk3bVqfIgDuMlmBQ2EDRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_11,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110158

On Tue, Jun 11, 2024 at 02:40:01PM -0600, Rob Herring wrote:
> On Tue, Jun 11, 2024 at 08:35:13AM -0700, Elliot Berman wrote:
> > PSCI reboot mode will map a mode name to multiple magic values instead
> > of just one. Convert the mode-.* property to an array. Users of the
> > reboot-mode schema will need to specify the maxItems of the mode-.*
> > properties. Existing users will all be 1.
> > 
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> >  .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml        | 5 +++++
> >  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml       | 8 ++++++++
> >  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml    | 4 ++--
> >  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 5 +++++
> >  4 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> > index 627f8a6078c2..9b9bbc0f29e7 100644
> > --- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> > @@ -31,6 +31,11 @@ properties:
> >  allOf:
> >    - $ref: reboot-mode.yaml#
> >  
> > +patternProperties:
> > +  "^mode-.*$":
> > +    items:
> > +      maxItems: 1
> 
> Drop 'items'. Otherwise, you are defining constraints of a matrix.
> 

If I do this, I also have to add $ref: .../uint32-array as well so
the property can be picked up as an array type. Let me know if this isn't
right, otherwise I'll send out a fixed version in a few days.

Thanks,
Elliot


