Return-Path: <linux-pm+bounces-26530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DDDAA6904
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC353A9DFE
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34051922ED;
	Fri,  2 May 2025 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EWdeWvjm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FC1714B4;
	Fri,  2 May 2025 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155453; cv=none; b=spwGkbWVVw5qMdJuAacFu3lF8W14Uhf+CJxZdX8alCxn+4w7QvtVp6L9WFfT4gkVG3l9564gZGfZTQKAg/Fa6ENnSRS6dF1Q1EYVvTcnOHgg9LlAlAY0ELEXZGErGd0FDdjJLTxMhhGgfC5q7SfsnUG13nqVYOr3KpibQxtPUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155453; c=relaxed/simple;
	bh=bl5qynhdWxFK/RpAjgZJYwfWPOV3G7lJsrmkECNavss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SAN2fRJAkEm54fM/ldaRDzM0A7+lLrISsRUsmr+2fRMHyv6HaoYo3iKPOXeaUvfuPrQA7Qd5ZHALLY1tevzgbdRjNk8mrvWKpj9sa970xyYsPhTVwsIN2IZG4xCAVIrYTBHNikUDFzR10Cd9Jr/7vh3zEvthoGwO7/YGI9RkMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EWdeWvjm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421MsoC009017;
	Fri, 2 May 2025 03:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Me/glNDe9Ztvj4qCJZinvmABv/1xv6EjGZ1uqRhDnYA=; b=EW
	deWvjmwdxFUQRNRciZH3w6HqwXUrlC40FIzeizNlNWeibdwJXxs5gHLc6Cs84mDM
	vZZvisjCjh009GYaq2hoRFNL08Il/Pb3Kx0kePtlx6y+Tz/7UAgQ9aOU1MYAOuEg
	IRatYFHkAoEwbgLgIxplosqbiE98Jn/F4XNj/PLcMkROAf7L5APi1bTf1Ycdmt4O
	H2n/GUPfpFYCQkrDV2gW3qcg/toYJdx6jYZRSLKI6+mquBAthlf5+bByQwkYqMWP
	zH/7A/1E8uunJV3BHClfCwRWSfLiU5WNAf0q2naBNYScWV3Pgj4nkH/JX1/pe/o3
	X0tObQT9nipm7P3L1CkQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6ubq4js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:10:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423AhYu004645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:10:43 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:10:37 -0700
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
Subject: [PATCH v3 0/9] Enable QUPs and Serial on SA8255p Qualcomm platforms
Date: Fri, 2 May 2025 08:40:09 +0530
Message-ID: <20250502031018.1292-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: _-lmHo7leyDMkGL3pyu_tMaG4Kn1Grv4
X-Authority-Analysis: v=2.4 cv=bsxMBFai c=1 sm=1 tr=0 ts=681437b4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=PJPe4VJEnk0T-WqaMxcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfX6Wbx/MeLSsl4 u9qeG5HRK2yP1giXxLCxSarkzmKJJrL1lbqLJg1Ft/h5/PuPAwwwEuDHJzrZ9S5EW2DvDsDnPJZ s3d1ijfJfogRM59rCMWk+4AvlIuHoc4dJQmpFQIvw4+nESYzrqN7aRfyLmOUhgZlbfOUDgqFcXk
 1AKQOXwiHgXTSegdGEYalVOq0fuxZMad4LS3B6rPZpwR9nygYFX7eJ3tc5dbR46H2ll5wYEHz0O 87QqvrsnYYSrDJ3yPWrYm1WH+losfHxbBKldnzZkG5E7m6EBuwM+G19eAVMCpclN9nNYSc/ihzv ONLSxWrAA+Dl5DQI9wb6hEwI6lkq+Knxz4aQta+nzEVgXppC+YuD5ryjQMHEAxZKBAIu7wvUIwx
 AphP7ElW9pcgpJOzExY23nYcyaaIgdMQniX+gbLgcNhgWYOYcPLB61KSucqdYt92oEIDuzN3
X-Proofpoint-ORIG-GUID: _-lmHo7leyDMkGL3pyu_tMaG4Kn1Grv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=990
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

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

Nikunj Kela (2):
  dt-bindings: serial: describe SA8255p
  dt-bindings: qcom: geni-se: describe SA8255p

Praveen Talari (7):
  opp: add new helper API dev_pm_opp_set_level()
  soc: qcom: geni-se: Enable QUPs on SA8255p Qualcomm platforms
  serial: qcom-geni: move resource initialization to separate function
  serial: qcom-geni: move resource control logic to separate functions
  serial: qcom-geni: move clock-rate logic to separate function
  serial: qcom-geni: Enable PM runtime for serial driver
  serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms

 .../serial/qcom,sa8255p-geni-uart.yaml        |  64 ++++
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 107 ++++++
 drivers/soc/qcom/qcom-geni-se.c               |  77 ++--
 drivers/tty/serial/qcom_geni_serial.c         | 351 ++++++++++++++----
 include/linux/pm_opp.h                        |  27 ++
 5 files changed, 525 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml


base-commit: 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
-- 
2.17.1


