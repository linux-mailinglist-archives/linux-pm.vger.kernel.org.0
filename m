Return-Path: <linux-pm+bounces-25166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564ADA84B88
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42C99C4A5D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0EB28C5C8;
	Thu, 10 Apr 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GjUT1Qlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BD284B22;
	Thu, 10 Apr 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306908; cv=none; b=jJyLRrsySLIwrra6r1rcS3DM9DTEJWWg+smPwjUaV58PVpMmlUTg0kcfV3xIell4wl1c5n4Y/vJVq4cLF4ERi2Anjsz78CHr2orUHoJhXweC+hRVW/v86NtNUoaX79/2pm+Zh+CF0jmqtx7CZ/ZC8E1UTzeN9Jz3FkAtkjH8egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306908; c=relaxed/simple;
	bh=aGFyarUypsBQZwMFKDsaf4eTtMerXBXQd6t0bW60SHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bThnznPUZUYOy6DE33UuGrlnbJuxIYjbNGTXHMiulMK/Q09C2kRmCzoCHFZ2fk2Wq7j8jA6kF2aj7ScP5jsQ2jFIw9b8Uzqtj5oR78SLqzHS3xQDowR+OelJ35Y+lhBqKZpNBd2b3ndEdveLtHjPfGircPqaJn9wodznjlOL9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GjUT1Qlh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFpHWt019725;
	Thu, 10 Apr 2025 17:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eXJ9nRVsSGvbv7Ju021nR+RM
	Ck/XZ+e6O2LB558fddY=; b=GjUT1Qlhf1KMYwxyTEq8s2N4DV8Bbld/aodt6Jxq
	x+7ilYjqWWVLtcGlSQxs9aixKvem86QKr0cs3HJD8Sen4XZej6CyXH1QyqAV2yfg
	IPDUvsTfrI7ys076AXC7HHX+ALkrDRMInmO4Dj/5H+tBXgLOBelRE9oXvrWy2zuv
	MYxpbs7ZEk1ujkqU+u5V5caVGIDcSqdcsaOaPUCZFD9oixZWmr0qff/2m1gNqfXt
	2VM3foaAUcupepy9LiEK7HM1459amzzZMr/tO9J3lJ7sljBejFjt2AomB0+zKUjG
	bAqU5HPzbboL4bLH4L4k9hxYQjfthx1cXim00LPAGaxW6Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrr1hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:41:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AHfcV2011720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:41:38 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 10:41:31 -0700
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
Subject: [PATCH v1 8/9] serial: qcom-geni: Enable PM runtime for serial driver
Date: Thu, 10 Apr 2025 23:10:09 +0530
Message-ID: <20250410174010.31588-9-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250410174010.31588-1-quic_ptalari@quicinc.com>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SgJX610SjsQI99skK9Do0JskZVxvT7iS
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f802d3 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=NvXbtCnAfBVqmBDmsI8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SgJX610SjsQI99skK9Do0JskZVxvT7iS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100127

Add Power Management (PM) runtime support to Qualcomm GENI
serial driver.

Introduce necessary callbacks and updates to ensure seamless
transitions between power states, enhancing overall power efficiency.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 35 ++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 25d16ac3f406..9649297d4a9e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1663,17 +1663,15 @@ static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
 		old_state = UART_PM_STATE_OFF;
 
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
-		geni_serial_resources_on(uport);
+		pm_runtime_resume_and_get(uport->dev);
 	else if (new_state == UART_PM_STATE_OFF &&
 			old_state == UART_PM_STATE_ON)
-		geni_serial_resources_off(uport);
+		pm_runtime_put_sync(uport->dev);
 
 }
 
@@ -1811,9 +1809,11 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(port->se.dev);
+
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
-		return ret;
+		goto error;
 
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
@@ -1822,11 +1822,15 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
 			uart_remove_one_port(drv, uport);
-			return ret;
+			goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	pm_runtime_disable(port->se.dev);
+	return ret;
 }
 
 static void qcom_geni_serial_remove(struct platform_device *pdev)
@@ -1836,9 +1840,26 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
+	pm_runtime_disable(port->se.dev);
 	uart_remove_one_port(drv, &port->uport);
 }
 
+static int qcom_geni_serial_runtime_suspend(struct device *dev)
+{
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
+	struct uart_port *uport = &port->uport;
+
+	return geni_serial_resources_off(uport);
+};
+
+static int qcom_geni_serial_runtime_resume(struct device *dev)
+{
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
+	struct uart_port *uport = &port->uport;
+
+	return geni_serial_resources_on(uport);
+};
+
 static int qcom_geni_serial_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
@@ -1882,6 +1903,8 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
+	SET_RUNTIME_PM_OPS(qcom_geni_serial_runtime_suspend,
+			   qcom_geni_serial_runtime_resume, NULL)
 	SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_suspend, qcom_geni_serial_resume)
 };
 
-- 
2.17.1


