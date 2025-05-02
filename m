Return-Path: <linux-pm+bounces-26536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A404AA6923
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE1D9A0BE2
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED8F1C8629;
	Fri,  2 May 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D5SUgeUf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E419E806;
	Fri,  2 May 2025 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155499; cv=none; b=r4rVJ3oPVTxAeKumfleP/w7V6WdKVuxoNjkmqgb9qKq+rdVXr2fsMSLM9Gv4Bb2AAKbnX9XoJaSyWxIgXL/Otsw8Sl94uVbbptZjBh/AQKuqrk8Tijiui4fU2IuWZQY5EP0nLh+sBHVb0yHQNXVNd/0aNm6S0K5xjWFyTkrV1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155499; c=relaxed/simple;
	bh=usYZPjq0hNQw1kKDQ6oot2oJ0BdufAj8NZXFLcL70L8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/zyGlibf//xOobtnFQmS+4eyk3by2rhkJHe510TKeZtqdxORU7NXGzklEsntODv5Phh1X0MqekdxwoT8J/MFq8ocNMmU3ZNScHJQFY+SyFwRyI7ck6EIgzizvi9KN8/Opinfq3I9xCh2TpUITrdCkwjlH6ne3wXFB+DSIncfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D5SUgeUf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421MuhS015007;
	Fri, 2 May 2025 03:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w2aaF/Cso8fKokDGiONWxbou
	8kmAEKBVzYd5xiLj2xI=; b=D5SUgeUfbgHUI/0aQDrNcfPJNuKjC5p5MJ7JuH6+
	qoQAcIB9dVLxurTtYzaTh+duJ8Eobe72BqVzOl5BJvED1LaTTEd4fI0U5JADAgdV
	LimTbjwJjfnEr21vuTGetpKUucdkKZHDRtmcOAl6m6wqqQzqVc0DmKhpTsM/cio6
	CYC7TbRKopyw7a1kB9Dq7RgZf/kuoZFqAtdrQxuzq/RnFwp4vhukDRwFy6tm0N6W
	MT8HFKiyF9+stecME9iVt3EWEpGpeBEAOfZLNW8HFMg97vi1SlfmcJ6rIRUzbu6C
	xLVpYqLEMSAqOZdGLHm19KZ3kxX3vizpg2D+UZBmJySdSw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6uay140-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:11:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423BXne014052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:11:33 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:11:26 -0700
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
Subject: [PATCH v3 6/9] serial: qcom-geni: move resource control logic to separate functions
Date: Fri, 2 May 2025 08:40:15 +0530
Message-ID: <20250502031018.1292-7-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250502031018.1292-1-quic_ptalari@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: thKxI7YUZl82a0gbshDQSokxjw9maEBE
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=681437e6 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=HYIVWE9JnHk2aDURxZAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: thKxI7YUZl82a0gbshDQSokxjw9maEBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfX0xqSING3WFbN s+DcXICa5smJl7D+JXCGBGInCBFVH9sPY2uWooifz30O1dg+4y+XOX1rUgtRXId7gpAPnOZ7BFu YUaejTjB6gg1pMtqBEpFbPRNrJv8vOXhM42Hu0jch4cAtFxYmhpaguHkWTrklSHgvIvAjFv2/iY
 vLBV5R4R1zWYNlxSGg79BBKPWUxKRL/FmaHJp6uEmF+j3pmZ1g1T1znm6R5h4LqUQoqe19Wtw7O G1CCnrWtGPiE2S6oYlz2pWtrLHLUv75qWeF3TN1H3MpPsZLJAcYNQiOFxvAU3zye3UN2pI7TJO1 ri1zZWIzxvia40VhGjhTXL7cQsEtzyoRUs2RPcNL2bizBr1xvbIvDPTaCjxalBDriTq8YbxMV8J
 AR1Aar7F5pJkh/KXB/C4KKPIwyiL2VfveodDB16KY30lh+wOIbDeRAZtaOZRyFyq+gJquezE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

Supports use in PM system/runtime frameworks, helping to
distinguish new resource control mechanisms and facilitate
future modifications within the new API.

The code that handles the actual enable or disable of resources
like clock and ICC paths to a separate function
(geni_serial_resources_on() and geni_serial_resources_off()) which
enhances code readability.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

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


