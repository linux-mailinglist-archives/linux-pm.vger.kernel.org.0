Return-Path: <linux-pm+bounces-14615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 736629847D1
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9351F2174F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8321AAE08;
	Tue, 24 Sep 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SkH2o1U6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421681A4F1A;
	Tue, 24 Sep 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188838; cv=none; b=Qv1Aswfr53sxL7rsNq68R4rmdTtm9Hb5gwTxkswmWS6MauKAKiWDV/8rT9JpCuqO4SLr0cqbvHNeGBAtVjuROMX/DiOkWywXjN0sGisKGi84ynWax8DmtePdppoAmp9vePeCh5+jJeOi2P6QNy+yX5nK6FIPcG3KFiRXcpb4c4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188838; c=relaxed/simple;
	bh=KjSaSCKnPUx/qabYBONGr30abPedeP3Zg8gsWKm71q4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oWMMyfMJ3hJ8qquSqZP2ae2u67QnvqPQnp2ORO533ViSc6uKf+aKRQriTWI8F2xJz8MRx+c2RrppOHFpdCoXr/hlOhmcPo7EFP58eC6ZTfW4uAsJpJOKCZNIZ7KIXJaKl/XfIIzC034c+z//Ncun66W8p68zuIHIeGhrZGMM1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SkH2o1U6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O91luZ006521;
	Tue, 24 Sep 2024 14:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZcNgnhYj7j2S9LTIwOI1cz
	YdFt8zsm8sebb7RfgcRrM=; b=SkH2o1U6QPzEgfXbWnrdU2nzdSn1Gewl5NVkKa
	fj1v2fb4futS+VnefejnEMp76CMoYUBaVTykwa1k64J3ZZmUdyUajAuVcI7X0o+5
	Eu0Hgl3u/g8HgnGIF93yDBs/3qwBf5LTE5bDX9PKMkfzHjI3N8iWFvZuYv2sxpfy
	1z9+mkjDaL8ZiwXKs+9OS9upEFXqpnUjvZthgHJsTlCLFIUVVB00u0W0Xbn1s/Ft
	gtjRf/13J0tiPumLwSAxopPrw+I6vUN5HeTJ+lCUMWn0tWmdOx5UD7mIlj6WpQeK
	ei0AtfmBmTxdCNIyRkiu/M5oZU81+HFAEHI6s0+3sRpFkDIQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqakghcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 14:40:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OEeIKl022463
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 14:40:19 GMT
Received: from e20994d1867b.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 07:40:14 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Adam Skladowski
	<a39.skl@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add interconnect support for QCS615 SoC
Date: Tue, 24 Sep 2024 14:39:56 +0000
Message-ID: <20240924143958.25-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: emt9xMxXpw1Lsp4PgXdKc0fbvxjSfXRD
X-Proofpoint-GUID: emt9xMxXpw1Lsp4PgXdKc0fbvxjSfXRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxlogscore=957
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240104

Add interconnect dtbindings and driver support for Qualcomm QCS615 SoC.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: document the RPMh Network-On-Chip
    interconnect in QCS615 SoC
  interconnect: qcom: add QCS615 interconnect provider driver

 .../interconnect/qcom,qcs615-rpmh.yaml        |   73 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/qcs615.c            | 1563 +++++++++++++++++
 drivers/interconnect/qcom/qcs615.h            |  128 ++
 .../interconnect/qcom,qcs615-rpmh.h           |  136 ++
 6 files changed, 1911 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/qcs615.c
 create mode 100644 drivers/interconnect/qcom/qcs615.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs615-rpmh.h

-- 
2.39.2


