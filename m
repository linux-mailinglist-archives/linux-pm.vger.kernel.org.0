Return-Path: <linux-pm+bounces-14506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61797D075
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 06:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC6F1F251DA
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 04:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A036429CFB;
	Fri, 20 Sep 2024 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LDRd7TGk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682A29422;
	Fri, 20 Sep 2024 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726805398; cv=none; b=RJ4ODbIwhZdVonJOP6NLRu6bR5mIHPw8f5jUIy0KiVEps2iF04xPAzO/h0Z/j3R7wydwO44SPjq2FxHjaHh9l0ugadoA7N1FV//Adu+iPshtKaXY7BFpS/z5UqI2ktKQX8yXuKK4gNzBHvBBkIf3C/13uVoh67roLngsSTgb/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726805398; c=relaxed/simple;
	bh=rhnw39cVR6UKLf+U5BoCFMmMNEbONgzSSLqbdq6phGE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gzYUgeJhcTt7zAcL1VVHbkW90SXhXQLSWc08q4TCM8IHL+Z64ngYGJKBMIP76mDLKU1OsE3/HBvN89vvYSj36I5+wFJ+izfTGeNHZDgdahKN3Pukxc7JM9tnwhRcGG7h0EiRfGPqV2Vzer/8FAaPRIPCMOiZQ+qL+mTHy2YXYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LDRd7TGk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ3rPG004269;
	Fri, 20 Sep 2024 04:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UJHUcFExo0sVoottPf80QO
	NNbId0HaZQl4QLR7JDkos=; b=LDRd7TGktdIGJY1L0KZogoYjIj0sCwqrmIGSRB
	k8pza2qXDgvEtHijuERx4h9XtFgz2d1ktOTZIbSOJaibnQbBhzVr5MHIZZ0J7iuG
	D7KTveat+XSuPBBQ1mIMYzzvW05inS07mQfQ0Wg15jGa4VZ06IIBTMd1m+F2/xqL
	RwoC/uMDl/QiPwZKpW0lVImfWL3Ilftz+q9It3y/faHGXTDZKE0BU3MjsUKhTn1j
	DRCHc1M0rrnBYLD8u8XKNrRRiNJZXs8IEjRcsAgVQve3t9izfZSwFkWhECUiuPUY
	KnfK23UP1mzqQw1T28ACdDUcfC9VaHrvoWOAn+FThtfGfAAw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdyqgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:09:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K49rGH027655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:09:53 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 21:09:47 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Subject: [PATCH 0/2] Add rpmhpd power domains driver support for QCS615
Date: Fri, 20 Sep 2024 12:08:41 +0800
Message-ID: <20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEr17GYC/x3NQQrCMBBA0auUWRtIY1OoVxEJaWaqszCJM7UKp
 Xc3uHyb/3dQEiaFS7eD0MbKJTf0pw7SI+Y7GcZmcNYNdnLWRMTwSjr2PtTyIcHyjJw1oPBGEvR
 da5HVpOk8zOSTH5cZWqwKLfz9j6634/gBzIYi8HgAAAA=
X-Change-ID: 20240920-add_qcs615_powerdomains_driver_support-c934be5c56fb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>, Tingguo Cheng <quic_tingguoc@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726805386; l=695;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=rhnw39cVR6UKLf+U5BoCFMmMNEbONgzSSLqbdq6phGE=;
 b=SUy8pKSFSr4SgAjxemcweQfJIpkzRO+JX0wftPQwVS6XkuJD5AGVpiy53RTpglcHno4TSulC2
 AhNcnoFqKhwBaHrNAgMgTjDNIuyNaaUuGGE5GcjIpU6ArZSXL7anUkY
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mE6iS4F-1EDTxGkJy0F2h2H8SX0z06Wv
X-Proofpoint-GUID: mE6iS4F-1EDTxGkJy0F2h2H8SX0z06Wv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=810 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200026

Document the qcom,qcs615-rpmhpd compatible and add power domains in
rpmhpd driver to support QCS615.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
Tingguo Cheng (2):
      dt-bindings: power: qcom,rpmpd: document qcs615 RPMh power domains
      pmdomain: qcom: rpmhpd: Add qcs615 power domains

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                          | 12 ++++++++++++
 2 files changed, 13 insertions(+)
---
base-commit: 4f3e012d4cfd1d9bf837870c961f462ca9f23ebe
change-id: 20240920-add_qcs615_powerdomains_driver_support-c934be5c56fb

Best regards,
-- 
Tingguo Cheng <quic_tingguoc@quicinc.com>


