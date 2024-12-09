Return-Path: <linux-pm+bounces-18803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B149E9066
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A07283529
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB67219EBD;
	Mon,  9 Dec 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n7xPbqvo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA9217722;
	Mon,  9 Dec 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740529; cv=none; b=KKc6uJ8Kl4sEDDRdO2x5VDmQV3fqDLb6E49RdF4cW+7z/Bi+NOlMn/Bvl4PqZSDCDK30H8S/pZabHTvBkmTK1lh1904rL1zme7nUqvP+6mWQoZXppfQMs61vhcSFMXYZyZiBX/kupPvf6md4XndCbuGdvcG/XK0g2+1d7So95Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740529; c=relaxed/simple;
	bh=Z1sCkDdALyoYtaZ60KqBvmpJQQWFOf8UqjcdOXUzh/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5Ahj+skhI+GU9U+bl/PRcZpyWMuZpKZNDMcfuu/BwP9Vn49HPkGKgH46C4y0Fi3dN5JGNco3bMqU4JHSiNUjs7fk4m26v4VBgB9xz7wksLo1UBhjosxwYTVGSHsNmJCNVp30iyGvfhISyL4mC5jEskvk5LM7rVGnLDExS1r4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n7xPbqvo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AHxFF004758;
	Mon, 9 Dec 2024 10:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vPmslVTlyG4/imQzJq/OnI
	aWHOfv6hepG+iVPXr2rIw=; b=n7xPbqvo7AeaU3loXDRrJrMBINbpR67RvooQKf
	2Iyb1Rb/G3FCLMvimYNmrrfkxu48r8b7EhMmWj2ziLcdsuxOJGc6Z61C1uNEMhtX
	fI/kQKI0PCEYT3SdrIir6+6+S2QlBCY0iFZ7aWMRPqpkuyk3fgYlOJ0P7Psphcx5
	UmqmYFYHpnVOuYmY5wIVXVAtBchUqVOF6ePcPyQn33KLmAXby33TOrhK6+YmR+IV
	dLHpIsUTz5ARIGGZJyZhhgKxIaVPBbRE6kqkl8sLr2aRWznZfhAlVrK8zHiq6CR4
	ZH/Wh8QTOL3DyR/MEx15VIs8fV7H3uJoxBAQG2FXTyf0OIPA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cek1v8y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:35:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9AZInn009133
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 10:35:18 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 02:35:12 -0800
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
Subject: [PATCH v5 0/4] Enable Bluetooth on qcs6490-rb3gen2 board
Date: Mon, 9 Dec 2024 16:04:51 +0530
Message-ID: <20241209103455.9675-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4qDlE6bNxjsjQ2P-WidDJ7txcN4DYQHo
X-Proofpoint-ORIG-GUID: 4qDlE6bNxjsjQ2P-WidDJ7txcN4DYQHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090082

- Patch 1/4 Add description of the PMU of the WCN6750 module.
- Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
- Patch 3/4 use the power sequencer for wcn6750.
- Patch 4/4 add support for the WCN6750 PMU.

----
Changes from v4:
* Added reviewed tag by Krzysztof in p1
* Updated the p2 commit message with sw_ctrl and wifi-enable are
  handled in wifi FW.
* Added blank line between the nodes in p2
* Placed the structures in proper order in p4
* Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/

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
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 168 +++++++++++++++++-
 drivers/bluetooth/hci_qca.c                   |   2 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
 4 files changed, 217 insertions(+), 2 deletions(-)

-- 



