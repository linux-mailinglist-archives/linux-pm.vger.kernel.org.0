Return-Path: <linux-pm+bounces-18146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E29DA72B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 12:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0803B163BB7
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E641F9EB3;
	Wed, 27 Nov 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V+qssyRp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604601F7564;
	Wed, 27 Nov 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708304; cv=none; b=GbKUorUvnqPWWk0Hu7E7X0p0n6STUVPaI8YsqwoDZGgLKcAoEyTqlR19Udnn0WTSa65gath+2nJwvzV5zWvdMDI5R3dcBYKdrj6djEBDq/a2blwNvsaPLBGPs3ncoITMV034JDjIZqkdaJPN4c2md75eiC6OwPdZRLPO0pDisJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708304; c=relaxed/simple;
	bh=0f014ApAViv3z9tsBLhOmTsocxLXqn7R8QCbMwZKhXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S07ZxL18XskWwhzbFt7cqFOrr7/k0F+DcjV4LphrwuFv1ZI/IOXL6refJPFOoCGM0/rNkfbyk/Yzd0BC4abkS9QeTOBNTmZEQZnhrq2c/tXOYTEC+97e+M5C2eqFocmM7NJPsfrwskLBJ1Z7iZs9SfQIffnYV7sJFXa0t8l2ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V+qssyRp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR8qfxN007068;
	Wed, 27 Nov 2024 11:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=pni2R4i8a1tOw4Va8dFHmoPC/J3QfZlX70nM6ULHbtc=; b=V+
	qssyRpsiHhZMaNHcJmPzpBYeDgaPxlLUABdC4ZaJO79+3Wp+SIG/EvnZdTWpmPJp
	RsMKGTsea5lOx5NmQBp5lNkyuKdqJUdbm0lpm/5j5MFVVEcmiR7V3SjTtURAaZo7
	Nbxe4DHQsO9kq48MhtFRBTXOl79YmNYfLHh5FWPVKsCTp54xExvVRa7XOeL7Cjro
	xvSfEkWMI874CpSSx29W4eMgxaK27EoKtSSvCVBMue/6R181ewT67BQj80uqwi+V
	0gDeGzd/Pj4fxWzYrEz0wWc3tHg47L9lXpX1uDMB55YMLZ2DVPgwKC18rBuK37Sn
	cq1M/pLi14BVL8VANVeA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434sw9emh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 11:51:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARBpRSW004855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 11:51:27 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 27 Nov 2024 03:51:21 -0800
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
Subject: [PATCH v4 0/2] Enable Bluetooth on qcs6490-rb3gen2 board
Date: Wed, 27 Nov 2024 17:21:05 +0530
Message-ID: <20241127115107.11549-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q794T_NnMMw7mVT2VltQ9_KcZwowxY5a
X-Proofpoint-ORIG-GUID: q794T_NnMMw7mVT2VltQ9_KcZwowxY5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=851 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270097

- Patch 1/2 enable WCN6750 Bluetooth node for qcs6490-rb3gen2 board 
  along with onchip PMU.
- Patch 2/2 add qcom,wcn6750-pmu bindings.

Janaki Ramaiah Thota (2):
  arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
  regulator: dt-bindings: qcom,qca6390-pmu: document WCN6750

 .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 174 +++++++++++++++++-
 drivers/bluetooth/hci_qca.c                   |   2 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
 4 files changed, 223 insertions(+), 2 deletions(-)

-- 

