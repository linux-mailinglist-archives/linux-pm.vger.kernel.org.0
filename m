Return-Path: <linux-pm+bounces-11532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAED93F29A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 12:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91401B2424F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9BB144312;
	Mon, 29 Jul 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oqnwLOpa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8392143C57;
	Mon, 29 Jul 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248710; cv=none; b=jh1GJ1S8cLYYUrlLTMpjSsoKMfXsMfmyfK3iEI0RHjIetgXl2SDB+ZWhtHWAE4P9Mxc7nj/6Vjbwz9QASutPmxdJotI3vMNF60M+t9P+koIAXD+Osh6uc6FKUB2i4648P1yUqWlgad/KeK+lDb6bS4mXnHTXhwH3hkfYXpbXVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248710; c=relaxed/simple;
	bh=NAU2+kPwSp7VisaKlcpBOQvUyXRXIRl9dvqiz8c6Wwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IB8W/xvTme7lzHCS2tnFPd1W9N2y5abLbXRc1lRmczcHkjW/orcQLc+I5jYRhwreaNMTYaP+Pqu30AAGAsPmU0bklfbzCVgKYeAnU/EvoTUUle/Whms3T5aYPJlc1YaJ3D/obgv7hRvkQpLG+V4WIw1N8ZOzIDxsVIuCwdLYmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oqnwLOpa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAEjiY014358;
	Mon, 29 Jul 2024 10:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HxGMgH3Q2VpLGeX9+jF+TBhxX9u++alw8ZGpmFKKCs=; b=oqnwLOpatogt8NkD
	PzDpX5Lq1c6ENftJHajrlDE8dIKdGG9puMu+PJsIiP3NucODMyl0/aFBcxtnpTOv
	VpfeYyALL2ZQX4BsBHqQLAT5qJiyDiUD6rUHtbAxYwpquv+CS5xtwjquPBfVZ1il
	FxRNKJ4yZerlOkoTiNuUff4xLOWZOLbZS5fDci9LFFsAq6LkZ/PRNzzvWx/exS+l
	9cHQZk6yIoOrbf96ppLAOEEG+iL1Hj69QpAZFqyxi7nyTXXfaR6eYVVKTfo+9YGm
	XLqzw+IwMkyIm4pLaooFsl3JqFKNT6bRCptKo2Sxa3Ys61g4nEEBN55lp1PdPS3U
	FpDpWw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrfxkyfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:24:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TAOuFf013496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:24:56 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 03:24:51 -0700
Message-ID: <ff7a65d3-7faa-4ebe-94e6-cf2ce593bbc5@quicinc.com>
Date: Mon, 29 Jul 2024 18:24:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: thermal: qcom-tsens: document the QCS9100
 Temperature Sensor
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel
 Lezcano" <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240709-document_qcs9100_tsens_compatible-v2-1-f09a143161c1@quicinc.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20240709-document_qcs9100_tsens_compatible-v2-1-f09a143161c1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yHRwUkilHKku53kBCO-OGrDanUJHf0a_
X-Proofpoint-ORIG-GUID: yHRwUkilHKku53kBCO-OGrDanUJHf0a_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 clxscore=1011 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290070



On 7/9/2024 9:28 PM, Tengfei Fan wrote:
> Document the Temperature Sensor (TSENS) on the QCS9100 Platform.
> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,qcs9100-tsens" to describe non-SCMI
> based tsens.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
> Introduce support for the QCS9100 SoC device tree (DTSI) and the
> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
> While the QCS9100 platform is still in the early design stage, the
> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
> mounts the QCS9100 SoC instead of the SA8775p SoC.
> 
> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
> all the compatible strings will be updated from "SA8775p" to "QCS9100".
> The QCS9100 device tree patches will be pushed after all the device tree
> bindings and device driver patches are reviewed.
> 
> The final dtsi will like:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
> 
> The detailed cover letter reference:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> ---
> Changes in v2:
>    - Split huge patch series into different patch series according to
>      subsytems
>    - Update patch commit message
> 
> prevous disscussion here:
> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> ---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 99d9c526c0b6..ace2cf1975c4 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -51,6 +51,7 @@ properties:
>                 - qcom,msm8996-tsens
>                 - qcom,msm8998-tsens
>                 - qcom,qcm2290-tsens
> +              - qcom,qcs9100-tsens
>                 - qcom,sa8775p-tsens
>                 - qcom,sc7180-tsens
>                 - qcom,sc7280-tsens
> 
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240709-document_qcs9100_tsens_compatible-b07b57d9b4dc
> 
> Best regards,

After considering the feedback provided on the subject, We have decided
to keep current SA8775p compatible and ABI compatibility in drivers.
Let's close this session and ignore the current patche here.
Thank you for your input.

-- 
Thx and BRs,
Tengfei Fan

