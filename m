Return-Path: <linux-pm+bounces-25712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBCA93931
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E18467F24
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965D2063D8;
	Fri, 18 Apr 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YWI/6uHd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D63204C0D;
	Fri, 18 Apr 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989187; cv=none; b=BqQqAun2j2Twl9nVxDwtb/R29cQjirSXBUDIY8a/7jQrUAYAk1FVJujYe1D0FuNecfGHMhCtrJT7n4uquPvJrUUgAhFNPAaz2xr4J4bnfFZNqhLMCawX3vp9pZskfSEbMKbWmucXOJ+w1nuk0lmUMhXHIqUBl8REPT9xhXu5gvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989187; c=relaxed/simple;
	bh=DtzQa2FF3IkJjY5BafM5HlLvS78dAEZcOmm3QdfMhIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7Wi/Ow690Qraou0EiyO3kuWew8Cl76lAbs9TyzzoHlBIuhM/0SUBAYOqH/QY4Dxu7XQMHELhVSuNHsFEWZI4JMiYkGLAdhlhxAxOsQIUB4DJn0cPJOdzL2Wbu0Dcp4bfGtpr8KjO95TC/c/4Ha3hHiWCbRQwCR6P72W4DSbB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YWI/6uHd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2YKIT008910;
	Fri, 18 Apr 2025 15:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=fJ4KDPoKj144akACD6TLjIr3lNVWgUHLKUB+wATNDio=; b=YW
	I/6uHdxhMz1aU1YQ0fUnznz5YW5ZSzhwdEcwUWZDcwQHXRkYTSWGQksIPO0DdKt0
	deDB4VCWJ4y0rDjtxN7iKUN89houK+1N0/TtwqNqmoQs8vV83QX8gcYcLL/Qpszf
	1JCi3m81rvmH7SEDCnDw8rj1AFIUCAKGtmvf6N94/KCNQslybGPpOjtdimiMzxTf
	kXgC+YzEXRAZ1HXGJWwuyQk260U2J/r4wjt1YAsnrCuYjk3lNX4gKHYZXKR9pnrq
	5fRBBjUqIfUKusXvUiDRkLcQAGa3jUDYVIDh7bsnsbgEk8t+F9ZqvlpZc9aNOtw3
	3iQ3HCYiep/j1kpV1wxw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxka4m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:12:59 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IFCwKN002978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:12:58 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 08:12:52 -0700
From: Praveen Talari <quic_ptalari@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Praveen Talari
	<quic_ptalari@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
Subject: [PATCH v2 0/9] Enable QUPs and Serial on SA8255p Qualcomm platforms
Date: Fri, 18 Apr 2025 20:42:26 +0530
Message-ID: <20250418151235.27787-1-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=68026bfb cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=pBcTSFWc41ZEPE-p5JgA:9
X-Proofpoint-GUID: Jz6o3VzZ_b7_LqVT6Dtw8LoZ91axa4RK
X-Proofpoint-ORIG-GUID: Jz6o3VzZ_b7_LqVT6Dtw8LoZ91axa4RK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180112

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM. The device
drivers request resources operations over SCMI using power and
performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages UART baud rates, with each baud
rate represented by a performance level. Drivers use the
dev_pm_opp_set_level() API to request the desired baud rate by
specifying the performance level.

The QUP drivers are SCMI clients, with clocks, interconnects, pinctrl
and power-domains abstracted by a SCMI server.

Nikunj Kela (3):
  opp: add new helper API dev_pm_opp_set_level()
  dt-bindings: serial: describe SA8255p
  dt-bindings: qcom: geni-se: describe SA8255p

Praveen Talari (6):
  soc: qcom: geni-se: Enable QUPs on SA8255p Qualcomm platforms
  serial: qcom-geni: move resource initialization to separate function
  serial: qcom-geni: move resource control logic to separate functions
  serial: qcom-geni: move clock-rate logic to separate function
  serial: qcom-geni: Enable PM runtime for serial driver
  serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms

 .../serial/qcom,sa8255p-geni-uart.yaml        |  66 ++++
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 107 ++++++
 drivers/opp/core.c                            |  22 ++
 drivers/soc/qcom/qcom-geni-se.c               |  77 ++--
 drivers/tty/serial/qcom_geni_serial.c         | 351 ++++++++++++++----
 include/linux/pm_opp.h                        |   6 +
 6 files changed, 528 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml


base-commit: bc8aa6cdadcc00862f2b5720e5de2e17f696a081
-- 
2.17.1


