Return-Path: <linux-pm+bounces-18533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A39E3B02
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7057A282144
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F281BD014;
	Wed,  4 Dec 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BfDeEpBP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0F1714B3;
	Wed,  4 Dec 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318258; cv=none; b=tSgt+fvZTh2Jikjm4bs7RzcFb+JISI9wDXibm2XLTeBG7MXbtYX6vzdbLgy/bv28K0U/C5twhIois0ftNk4EJjLlmKyOLBY3t/ryCAmkmPpDbFAhE+p90DWfRW2TF/Nqfx+tJgoXlW5ReeL0muMFLG7kGTrVsAyO3589uqlRpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318258; c=relaxed/simple;
	bh=t5F97VFmF8zyFkQKD0vWH58yCQmKA1NuBLL5guq/ubI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZzLWUhj7Rsmp2zTcZc4AqfxJ16rZRpTzPQwdP5JUg9y+RQqtVFnb3FIK+NM6yORIhiBSrheQc+ogjXOlxcz4BSmlhJU67GxLU12OWrvJGJitSnUWYY6kGrrPMHwWUs5PEoY+RmDMpeau4QDOPn0jBHsrJat9R30TGJq7f/xATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BfDeEpBP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4736hq005920;
	Wed, 4 Dec 2024 13:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/1Vf+utvjq/tYYUU/+P1f1
	B9AGXc7QPnOlMiNpeWPf0=; b=BfDeEpBPx6dpvO4wi5dhp7F8VeCk5zrD4PC0Jk
	zBYa+NBn5H17dK5jODaP1pbCzNed3LnLAyuGBFw4DXfSsp0bK17OzniLhiAK8at7
	ssusrR1XlQNi09+Q/HfaslMfbEChODjisTV6kJwiS7nlsNsFygtDXSkyF2QHRtBb
	jhBX3KYhYZ+YwOdwyGXhb4gBmVXYJbidqDkEuAgJVsKuVLNdEOixV+6PPho2mRUP
	Yr4zuBbZJ2OlBIg6w9b5+6H7O6dMPZ57qZY+gen4owLQ7o78Z23HTMWLpS1eXHAQ
	HJI5KD+/MBIHmQlIrdwkD23ykJrZsVsMtlX29eJP6cHOLU0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w3ema8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 13:17:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4DHRYk004241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 13:17:27 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 05:17:22 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v4 0/4] Enable Bluetooth on qcs6490-rb3gen2 board
Date: Wed, 4 Dec 2024 18:47:02 +0530
Message-ID: <20241204131706.20791-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m5IPExlosNicp98XAt3cAMycDvOMJHeY
X-Proofpoint-ORIG-GUID: m5IPExlosNicp98XAt3cAMycDvOMJHeY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040102

- Patch 1/4 Add description of the PMU of the WCN6750 module.
- Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
- Patch 3/4 use the power sequencer for wcn6750.
- Patch 4/4 add support for the WCN6750 PMU.

----
Changes from v3:
* Defined the PMU node and used the its output to power up BT
* Used power sequencer for wcn wcn6750 module
* Split the patch to multiple as per subtree
* Add description of the PMU of the WCN6750 module
* Include separate UART state node for sleep pin configuarion
* Link to v3: https://lore.kernel.org/linux-arm-msm/20241022104600.3228-1-quic_janathot@quicinc.com/
Changes from v2:
* Sorted nodes alphabetically
* Link to v2: https://lore.kernel.org/linux-arm-msm/20241010105107.30118-1-quic_janathot@quicinc.com/
Changes from v1:
* Corrected the board name in subject
* Link to v1: https://lore.kernel.org/linux-arm-msm/20241009111436.23473-1-quic_janathot@quicinc.com/
Janaki Ramaiah Thota (4):
  regulator:·dt-bindings:·qcom,qca6390-pmu:·document wcn6750-pmu
  arm64: dts: qcom: qcs6490-rb3gen: add and enable BT node
  Bluetooth: hci_qca: use the power sequencer for wcn6750
  power: sequencing: qcom-wcn: add support for the WCN6750 PMU

 .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 165 +++++++++++++++++-
 drivers/bluetooth/hci_qca.c                   |   2 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
 4 files changed, 214 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


