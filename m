Return-Path: <linux-pm+bounces-16168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4C9A93FD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 01:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57371C21FBA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F81FF5E8;
	Mon, 21 Oct 2024 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U/Ko2KHN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717171E260C;
	Mon, 21 Oct 2024 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552730; cv=none; b=k3z9VOeBOPOHCWTduKzCZy3EjMJh6QJNhu7+CdUiusmdsgHp1jTweZBbDtceH93qzTflV1ILzWad06IYhzZe9MpthyLH/rIclNpwR2aR9R0CzSwdsF0oBB7vR6iM94JuFpe6/1Vc/D61EiVebjcCIWVLVol+KOKNyJ2oL+pXt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552730; c=relaxed/simple;
	bh=PbkltP23qfqfIUT7bDRqIJ/qw7ieioxvSwYjJ8+NX+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k18vk6MjU9k8CREnKLKEH7u+8LKOYhs7SGGYGq8PkZAX2OEn4yz/CuVtk+qCpH72cKMQ9DRl7GdUN1OVqebvJD6tLyy+1nmjS95xH66AhxsFlKrlKRk/xVi2qyDoBmKfO+ZdabkilsBcx/jkiRW2P3OtePXlAbY627zAL/sHEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U/Ko2KHN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGiJOg014452;
	Mon, 21 Oct 2024 23:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SUfYIgcJMF09jE2rwpKqRc
	rKrOmCqdpPZiNh+7L4B0E=; b=U/Ko2KHN8NsWpUidiYcUfmVruTd3y1l2GknwWe
	jpzwMcnZ+fSKfXVPg5UIq7ku2aQ3sO/8GGhCPi5tlbZPZ0YNmtX83MpSrlP21GKq
	rJPFSs8WvLKCPogaTZD9FWFLeWfDgjb7wVZj9kqB5W/6x1GkpMQjUxZbj8QY/l+k
	WPkE14VRqF33IOTyKQhrO/H7OHaZ5lLr5ZjdKpTUdsXBfFL6I/Ws9j7DBcD6tizQ
	y/AyWrnrAmGYqL5bNe9jPU3KrSrGYshDujvS3HIHlUtplq5RPESbHLcZfFCPDucm
	Ub/yUXAJUog42gFD+rw9S+e5bTXYFQ642mVg6nNsdbkrn4xA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd2ehq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:18:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LNIbK4014234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:18:37 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:18:36 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?=
	<barnabas.czeman@mainlining.org>,
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
Subject: [PATCH 0/2] interconnect: qcom: Introduce interconnects for SM8750
Date: Mon, 21 Oct 2024 16:18:20 -0700
Message-ID: <20241021231823.2635534-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K54T6-53IRaoEgdANhRa571KOKFFrNKK
X-Proofpoint-GUID: K54T6-53IRaoEgdANhRa571KOKFFrNKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=800
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210164

Add interconnect support for SM8750 SoC.

The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
consumer mobile device SoCs. See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: add interconnect bindings for SM8750
  interconnect: qcom: Add interconnect provider driver for SM8750

 .../interconnect/qcom,sm8750-rpmh.yaml        |  136 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm8750.c            | 1610 +++++++++++++++++
 drivers/interconnect/qcom/sm8750.h            |  132 ++
 .../interconnect/qcom,sm8750-rpmh.h           |  143 ++
 6 files changed, 2032 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm8750.c
 create mode 100644 drivers/interconnect/qcom/sm8750.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8750-rpmh.h


base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
-- 
2.46.1


