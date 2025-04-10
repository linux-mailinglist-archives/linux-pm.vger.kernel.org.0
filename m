Return-Path: <linux-pm+bounces-25158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBCA84B45
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17EA1BA4543
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBB628F93B;
	Thu, 10 Apr 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hDqnMrCB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999162857F5;
	Thu, 10 Apr 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306844; cv=none; b=vBzKH57hzCRa9/36anigGH1D+TMPitnzA8Ep9qwCyywxTgf4C0tpWBVL1oNT9/ldgsQEXdhJFc9sI3GUWinrU1Ws8TxIQWjzQ7CxlMIVcFHz5/g1Bqv85XNxPI0nJha8tVMTVkuPW2gc+TcwOIN416V5Cx9/iPqP4Z0qTLUltu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306844; c=relaxed/simple;
	bh=OHM8nKMaNNaEAYYvaw5qp7GWJywfD89Is8dJwY/Fwrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOuHquiukz8wlOanFOlj0bv9wSDc+DcaM8Y7Q1wDVlMqMzEbzCUHBhU8UIIOw1r9vs6KJQDvO78jfi1q+UK4Bo7UdQDvuZF8MeLiPlhEhj7rlYdQ1Fxxk7TQETj991nMXUMYeZZQN8bP/GOCzvO+OYJfFyywuPcbZIa08J58IW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hDqnMrCB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGD0Mm032003;
	Thu, 10 Apr 2025 17:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=LUel9NEk6lIKaaqqOgR/dS3jnaA36/cTZIPGJsRvavY=; b=hD
	qnMrCBANk0oIuVydJ57xOeZCKPZou2u9/93tBbNdA5Vvekb6r4/ejo/tjW9kukus
	gZQ7bIFq/OGh09pIfyNY/mIKhgUuavOwWrYUBTzdhkMTrkdpZ0LylqTo+XbzTTXD
	Td0sZrZBM89x6RApKx24IUejgyJezhbj0ywAeVGmSUWNVzAM+31ABxFWWhi1M8rz
	559nr+SJzSINd6xOEwtOwfkghlwmKIoMx1HmfsrqswLAillU3jOqReo6VxTV6O+/
	iapwrptpF4iAjqKTvqAlaYz3spLB68ny4GUmzCSpamJHasMF2jjB5s7rTQFmf+3S
	0Ea2cQov27Vpn5K5Vjaw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmfsab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:40:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AHeZ61007132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:40:36 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 10:40:29 -0700
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
Subject: [PATCH v1 0/9] Enable QUPs and Serial on SA8255p Qualcomm platforms
Date: Thu, 10 Apr 2025 23:10:01 +0530
Message-ID: <20250410174010.31588-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: l-yVG0K-HDBeKpnBigH7BABoNXxFGyVK
X-Proofpoint-ORIG-GUID: l-yVG0K-HDBeKpnBigH7BABoNXxFGyVK
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f80294 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=pBcTSFWc41ZEPE-p5JgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100127

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
  serial: qcom-geni: move resource initialization to separate functions
  serial: qcom-geni: move resource control logic to separate functions
  serial: qcom-geni: move clock-rate logic to separate function
  serial: qcom-geni: Enable PM runtime for serial driver
  serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms

 .../serial/qcom,sa8255p-geni-uart.yaml        |  59 +++
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 100 +++++
 drivers/opp/core.c                            |  22 ++
 drivers/soc/qcom/qcom-geni-se.c               |  78 ++--
 drivers/tty/serial/qcom_geni_serial.c         | 345 ++++++++++++++----
 include/linux/pm_opp.h                        |   6 +
 6 files changed, 512 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml

-- 
2.17.1


