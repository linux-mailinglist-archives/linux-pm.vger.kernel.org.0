Return-Path: <linux-pm+bounces-8791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2943900B59
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35301C21C71
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5C19AD49;
	Fri,  7 Jun 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q+6EE1we"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0681990C7;
	Fri,  7 Jun 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782020; cv=none; b=dk7wLFva+LkdJwxfm3IZxWUXy5VbfG2ZDVFNchc1CydKsb8NBRDhz/4byDJ5h/JMcbr3hFRtdFdIk4t1B22k3zizJfXQUYHVrjJEavEAfB/S1Ila2rSULt8W7UXmKeuTNcaFbJ29SWxPOhgMk0altuW2VKFqkJYF853ajGTTjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782020; c=relaxed/simple;
	bh=5ehjn2LZqwpSxZUdIEwtBAwcjwj0nCHl2AY28EQYwAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=akWCW5kLpvOTdB4EBiUXP9e4vT5HG1saMYYpccy0GhDKEZgdIoTwjRwIgH69KeQ3tkI5AgZ0e21Ja8YVrFfSe5fHn+bjPi4bCOxDkJyQBd6c1pUptV5yC9MsXDM9pMYwG7s7iutvDiv/u22QG7ESsEoyNet+vVB+IAY7ia7slLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q+6EE1we; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZUvr007842;
	Fri, 7 Jun 2024 17:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=5IKUAiqbsySEKKfuRunWhtwKGIhajIoajUUF2vUjRY0=; b=Q+
	6EE1weqSdNrtg4YwThDjWMx0jmFpP8pLA4vD2xyDZT8IFNm8NMieqKHuu+cV+DIC
	mr5xar3fdxvTgPwByEyRPP1Uwiyjug34oQOD37G3GkaRvSQ2mkCEYTfUSl2w3gFw
	ngNnJe0tap8Ia2X649/QAsKothL5QkGUZPdj/4/VCVxTj00X90CSp+L/PRJrQ1Kx
	SgfZPQZz4eiUShwQQCUPZobZ9i7XhAUfsS/n/9GQFTA/mFKOst0ddlrhL7T/uuWm
	3tl5dAGTCua7Iop0P+oPtA2Mrxjd+92QUv0+Kdk3ozDVrfRBKBhbl0+jvXSkpZ1+
	EDnkiHcXy0ljofywBgaQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yka7pc28y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 17:40:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457HeCF5020059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 17:40:12 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 10:40:07 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>, <quic_okukatla@quicinc.com>
Subject: [PATCH v5 0/4] Add support for QoS configuration
Date: Fri, 7 Jun 2024 23:09:23 +0530
Message-ID: <20240607173927.26321-1-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dx8Ucj6W1Rxdxh1gFd0TL2eZejeybnCd
X-Proofpoint-ORIG-GUID: Dx8Ucj6W1Rxdxh1gFd0TL2eZejeybnCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=875 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070130

This series adds QoS support for QNOC type device which can be found on
SC7280 platform. It adds support for programming priority,
priority forward disable and urgency forwarding. This helps in
priortizing the traffic originating from different interconnect masters
at NOC (Network On Chip).

Changes in v5:
 - Replaced platform_get_resource() and devm_ioremap_resource() with
   devm_platform_ioremap_resource() API.
 - Initialized the qosbox pointer in ICC node using compound literal.
 - Added conditional check for clock property in dt-bindings to the 
   providers which need clocks.

Odelu Kukatla (4):
  interconnect: qcom: icc-rpmh: Add QoS configuration support
  interconnect: qcom: sc7280: enable QoS configuration
  dt-bindings: interconnect: add clock property to enable QOS on SC7280
  arm64: dts: qcom: sc7280: Add clocks for QOS configuration

 .../interconnect/qcom,sc7280-rpmh.yaml        |  53 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   3 +
 drivers/interconnect/qcom/icc-rpmh.c          |  93 ++++++
 drivers/interconnect/qcom/icc-rpmh.h          |  35 +++
 drivers/interconnect/qcom/sc7280.c            | 274 ++++++++++++++++++
 5 files changed, 458 insertions(+)

-- 
2.17.1


