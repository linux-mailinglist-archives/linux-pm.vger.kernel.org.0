Return-Path: <linux-pm+bounces-17362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB49C4AFF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 01:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50D6B2F742
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFABC1FBF7F;
	Tue, 12 Nov 2024 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pa7TRIPo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A01FBF5E;
	Tue, 12 Nov 2024 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371538; cv=none; b=rckgHcvZBKyOaSyDgGYsg19roAxEENSbMY3MclWVGWVCDnl3CY0OA/zQ89twEIeO34JJ9XKjuvKG9fQkAEUoCV+dL8wttALoz7MfQfUbipkoANpN/DmoAoKxCk17ocOLG8BzV6POYkcH7O1rpXywrCpJOn1Qs5dIu7KgO4+9ZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371538; c=relaxed/simple;
	bh=608tm2R7Oc/eF9PLqP0r6nJQxjsfMHcOlJ1z6oI6Ibk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LhQRTE0IN29wmlUfRAj8h4IwwC1WPGdy6l1f3ZzcBkJTgH4CrXjxP5UGvQfJrpsHQO8lUi1q3z7K+MHIqNS0wOcHI/rdOODScUIz8qQC7dKHM9oyuq7BcTFFQHP0rh9m5omGj5F45NT7TYY1Fcp+KW2fSiC+z4/ofxvtl3mOm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pa7TRIPo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCPWrr028389;
	Tue, 12 Nov 2024 00:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gPpfOxhXkE/A6VBxpiNoly
	P5/EmzyjJBIUhUxlbnVmI=; b=pa7TRIPoPNMWqJtmv2mp5mo2jjR8XgtKmCJOt0
	D2JMm2v21AF3ahK9KFvF5qfHKv6O6oSIUmI7ukTUlpFlrmnKPp0ZQtPQmBmgYvhz
	WeMe1wa3VTGb5i6AE0BDbTLkCPGPjAwtGXo2SOcUSJMdQbuJM08fBNgQ9KYz1r7z
	tqX29B7t8HeuTzE7e8mdThjp5sft4vlIvLJaqm2ILqbOIh0JIavmeDwJfj+BWBrY
	zakobt3UL6kCltSmT3hWE2aPbIT1Nozl1Lqy+766W3926BKLsJXnaBtS9n9ZxXSw
	sAY4c49b+wLidjMHvnR7Sve4isnQ+gRS+5pQRK0vTelrlurg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0wjwg0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:32:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AC0W7dJ010079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:32:07 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 16:32:06 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Raviteja Laggyshetty
	<quic_rlaggysh@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        "Abel
 Vesa" <abel.vesa@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya
 Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] interconnect: qcom: Introduce interconnects for SM8750
Date: Mon, 11 Nov 2024 16:30:15 -0800
Message-ID: <20241112003017.2805670-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3sjZchpe_eywrDHufnK3KJ2okMYvh17z
X-Proofpoint-ORIG-GUID: 3sjZchpe_eywrDHufnK3KJ2okMYvh17z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=806 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120003

Add interconnect support for SM8750 SoC.

The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
consumer mobile device SoCs. See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf

Changes in V2:
- updating style to be consistent with other interconnect drivers
- removed dead code

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: add interconnect bindings for SM8750
  interconnect: qcom: Add interconnect provider driver for SM8750

 .../interconnect/qcom,sm8750-rpmh.yaml        |  136 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm8750.c            | 1585 +++++++++++++++++
 drivers/interconnect/qcom/sm8750.h            |  132 ++
 .../interconnect/qcom,sm8750-rpmh.h           |  143 ++
 6 files changed, 2007 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm8750.c
 create mode 100644 drivers/interconnect/qcom/sm8750.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8750-rpmh.h


base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
-- 
2.46.1


