Return-Path: <linux-pm+bounces-25718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B5A93955
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949958E4387
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B482144C9;
	Fri, 18 Apr 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p3qMVWIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F320DD48;
	Fri, 18 Apr 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989234; cv=none; b=BsOKIfzBbCj1OEMnjegRFmzxJOESYn4Tu6dus/5lCAq7NWqajwVndIWsLY/mHP8FuD00OE6XbQPr1nBzUA4wmu/4jbB/DaKx+HWa5u2cj7IdHAx7QoIHFO8NTw9AwilR80yXLA11QR+4eLbvUiBwFfFi6OAU/vIhrNhO1NM1f0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989234; c=relaxed/simple;
	bh=6bAqz+heXOe0x/hMrtS6J+RGEMHewk97TnYi7Afye64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJd0FB0QoJ/Bb8qUHtR5qsoEEz32Nalr0QMmEYXWOqh2V0eWTRJSTRr3WZQr368heZpYz2UHNFQXjr8dn/YBPsp2Aa82ETvJ3DW3hpH7ZLGoX3Lm0floTNAUAmA1DeJ7vwMVQph6HDqkB7qKbw8s8NjG5vj6+nlLs8PGybTqRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p3qMVWIA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2YUUt014357;
	Fri, 18 Apr 2025 15:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QRCtH+l3PPlGS67qJaXVGQuo
	xDMS8hVHQ0rXbZyP12Y=; b=p3qMVWIAjmfwbxmoeo79VDvOMd+tykqpQYOZiuiU
	cPqpEzKzNNcA9umXUomASpU07hBglILNR1hVDTJrAPJSVw3RM3TZUKqJSp5MOz7B
	o8jIcCGUtNEQ08jKQIsV3jIC8Ra+oEHqyFO8PIerBoJaiXcA2XQ2i86ZHXFkLvWi
	u7T0SRDUhSNhmOY4pv0prOPacS0gMhIVke3wOabEuk6SYUe0bFpZ1PUPh3aSXUP2
	OGz7bT/UIoLYRgfsfRjxDUy0c6IOts07GUowU9Ab9MJ1MqtQkUxtShUEsWqwEFvk
	fW2lfgKj+pWaBoQ1a8QUduC8d5LjT3wNOdX/Eh+9U2w4dg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1j4fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IFDjeG003754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:45 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 08:13:39 -0700
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
Subject: [PATCH v2 6/9] serial: qcom-geni: move resource control logic to separate functions
Date: Fri, 18 Apr 2025 20:42:32 +0530
Message-ID: <20250418151235.27787-7-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250418151235.27787-1-quic_ptalari@quicinc.com>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=68026c2a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=HYIVWE9JnHk2aDURxZAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: nKHY-7G2Xf5plegqzBu7YzjObhUmPfAD
X-Proofpoint-ORIG-GUID: nKHY-7G2Xf5plegqzBu7YzjObhUmPfAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180112

Supports use in PM system/runtime frameworks, helping to
distinguish new resource control mechanisms and facilitate
future modifications within the new API.

The code that handles the actual enable or disable of resources
like clock and ICC paths to a separate function
(geni_serial_resources_on() and geni_serial_resources_off()) which
enhances code readability.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
v1 -> v2
- returned 0 instead of ret variable
---
 drivers/tty/serial/qcom_geni_serial.c | 54 +++++++++++++++++++++------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6ad759146f71..2cd2085473f3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1588,6 +1588,42 @@ static struct uart_driver qcom_geni_uart_driver = {
 	.nr =  GENI_UART_PORTS,
 };
 
+static int geni_serial_resources_off(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	int ret;
+
+	dev_pm_opp_set_rate(uport->dev, 0);
+	ret = geni_se_resources_off(&port->se);
+	if (ret)
+		return ret;
+
+	geni_icc_disable(&port->se);
+
+	return 0;
+}
+
+static int geni_serial_resources_on(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	int ret;
+
+	ret = geni_icc_enable(&port->se);
+	if (ret)
+		return ret;
+
+	ret = geni_se_resources_on(&port->se);
+	if (ret) {
+		geni_icc_disable(&port->se);
+		return ret;
+	}
+
+	if (port->clk_rate)
+		dev_pm_opp_set_rate(uport->dev, port->clk_rate);
+
+	return 0;
+}
+
 static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
 {
 	int ret;
@@ -1628,23 +1664,17 @@ static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
 		old_state = UART_PM_STATE_OFF;
 
-	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
-		geni_icc_enable(&port->se);
-		if (port->clk_rate)
-			dev_pm_opp_set_rate(uport->dev, port->clk_rate);
-		geni_se_resources_on(&port->se);
-	} else if (new_state == UART_PM_STATE_OFF &&
-			old_state == UART_PM_STATE_ON) {
-		geni_se_resources_off(&port->se);
-		dev_pm_opp_set_rate(uport->dev, 0);
-		geni_icc_disable(&port->se);
-	}
+	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
+		geni_serial_resources_on(uport);
+	else if (new_state == UART_PM_STATE_OFF &&
+			old_state == UART_PM_STATE_ON)
+		geni_serial_resources_off(uport);
+
 }
 
 static const struct uart_ops qcom_geni_console_pops = {
-- 
2.17.1


