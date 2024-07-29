Return-Path: <linux-pm+bounces-11611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AA9401A0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C91F23155
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7318FDD2;
	Mon, 29 Jul 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BvBu26FM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBD18FC7D;
	Mon, 29 Jul 2024 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294850; cv=none; b=joHP27yjmWiNl0PZRBz3syXJUDAb0XvHth8uR1Ya0hfZrE5efCMO3UYFmHwGfAI/9l5UwJMOmvL/wmNUYeL2wNbXmrY0uaOa03gsPvoo3OZblzdZNrD4qfblNKJNbfLu9J8nSKSdwwIS4609ruTSHkV7KDYQysb3F27f8R5U+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294850; c=relaxed/simple;
	bh=EEYPIJlox5X3reF5E6wHd/OxgAx0gL8CasJ9+oh9Tn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o00Wh7/vlWw3JTmmeaSXGq/um2gFKTnrhbsh70KTcpOUYwwZtvjhAhnXxmTPY5X54V3o8CD4ezzqnM5zVaAkpMJ5VbPdAc4NBfIBKnuX+8VYnue2qsseBnnpNyaEAKYP8npE+f8ZggixLtTrCclJNNB93gig10Pf4/rf91QBuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BvBu26FM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAojIO011082;
	Mon, 29 Jul 2024 23:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GwqvFPodPkROMymiwKIP9m
	NCnn73iUGSFRT5hIbTuSk=; b=BvBu26FMn4tQVlIVCkXTmNQG9+8NhGpg5v6nyv
	qVmufmlMe5GrKg1lPxuFz2yhTLVNYqPEaGi9Dj2JprCZWcGInwQXfH3RP+xqlt7/
	1+WXZFwGlutiUxxyNBMGAKL943crCDnDGfLLyF7+0UOPlHhH+pPyw3I/WQZHqHk6
	aAWO28hQr49dD7paQX2tOS2//AXaa3CqsjUOoTlpIb+AxW3yGM+V96iMvZFBPel7
	rteWGaPea4hRTomhpQLsRC5gHy9cbE8d5ZL8ZkOjXHJtIgnOTzlX8ZUmGlQhsKGM
	HC/8s8PNNgAhUiDthj/LgSakht3DU0FYbk7cOi7xrIicEzSQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqurnkub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TNDcsc032462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:38 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 16:13:38 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>, <andersson@kernel.org>
CC: <quic_collinsd@quicinc.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 0/5] thermal: qcom-spmi-temp-alarm: add support for new TEMP_ALARM subtypes
Date: Mon, 29 Jul 2024 16:12:54 -0700
Message-ID: <20240729231259.2122976-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TCcHzBEoVo6yBJUc5lOPVn85bsQsCLn9
X-Proofpoint-ORIG-GUID: TCcHzBEoVo6yBJUc5lOPVn85bsQsCLn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_20,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290159

Add support in the qcom-spmi-temp-alarm driver for the new PMIC
TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE.  The GEN2 rev 2
subtype provides greater flexibility in temperature threshold
specification by using an independent register value to configure
each of the three thresholds.  The LITE subtype utilizes a simplified
set of control registers to configure two thresholds: warning and
shutdown.

Also add support to avoid a potential issue on certain versions of
the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
is disabled.

This patch series is a continuation of the original series from 1/2023:
https://lore.kernel.org/lkml/cover.1674602698.git.quic_collinsd@quicinc.com/

Anjelique Melendez (4):
  dt-bindings: qcom,spmi-temp-alarm: Add compatible for GEN2 rev2 temp
    alarm
  dt-bindings: qcom,spmi-temp-alarm: Add compatible for lite temp alarm
  thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
    peripherals
  thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals

David Collins (1):
  thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required

 .../thermal/qcom,spmi-temp-alarm.yaml         |  50 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   | 433 +++++++++++++++++-
 2 files changed, 463 insertions(+), 20 deletions(-)

-- 
2.34.1


