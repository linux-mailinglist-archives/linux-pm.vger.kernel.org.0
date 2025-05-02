Return-Path: <linux-pm+bounces-26539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C773AA6932
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107293B67B3
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30911EB187;
	Fri,  2 May 2025 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p3jFZxGs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CB19D081;
	Fri,  2 May 2025 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155524; cv=none; b=n/+IwAGsITcO0kmclnBsTZqnekNeC0tg3Ikc+NzABYWNVCUudayp0o+AkR4OBCw5yVvXjWUR6DRU3spfMCQxaulqgMHfW7AiI3jBcEDefsRz/rKGBYc+mEjZq8WNt36goWS8XuYcI9lqhlSHWr/puAw5ZyHBYmMMT+1bumlBN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155524; c=relaxed/simple;
	bh=Z5eTJqLCVOCXLlGOSr10sW3KiaDMVKUAk3DOAZaomzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3juuBXqLEIBlCrXdlt/wKCWHz5VPsZzXmyp39hJy08GGcN14dVI2Ee5PDa0awudtP28xC6lMFLzrx7mMoWdzhRFltMjfIH6HCMcKBumywHXvNvSI00eLoFwjBuKbxM0RBYtN0NsfyTOKcJBw+wMSjLPuH0fbylo0nLwuSubn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p3jFZxGs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421MwQW010097;
	Fri, 2 May 2025 03:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xw9wcp2R9eJ8PgvgUrXdyJLc
	rYNOyl4SqtPIFH3MgPs=; b=p3jFZxGsBiOkAkAUYVt86DuFOwY2KlmcFHOrSeHW
	fsZ7lMyLotTVJ9UsR9axkdVTzX2STQxc2K8aKRLY5W9sTT13GzDS5UWwGadAiJIA
	SXMGuu02eilMvkXs434S3yNRmhtv9IErZuqPRT8WiV9xmF53XtGhWgIjtpJC4mGS
	rYYQ2n4GpfRzYg/IvNnOyIXa7ZKOM6FowKSOJoZGxxZQidZkWCzdLFv3HkiIKC+y
	yxmXuzlMqrAiE28hM8ao54qs9YvusuDmkEsYMEaQZt/hL3Iw5VE9t1OW6WGT52L8
	oMBvTozr5GaAPm/oFMDAnTTqD1vJLJaGBUQYAqegsHmReQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u9y0bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:11:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423BvqW007004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:11:57 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:11:50 -0700
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
Subject: [PATCH v3 9/9] serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms
Date: Fri, 2 May 2025 08:40:18 +0530
Message-ID: <20250502031018.1292-10-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: gZprPK_xlq42Gd23OZUc8uXwt8yIKPr8
X-Proofpoint-ORIG-GUID: gZprPK_xlq42Gd23OZUc8uXwt8yIKPr8
X-Authority-Analysis: v=2.4 cv=UZZRSLSN c=1 sm=1 tr=0 ts=681437fe cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=YJyStIVdxSjxqG8W5N4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfX4h3ceconJQiz 03qNmqblsC1m2qu4yCjf6B80zXDCV21NMarKPMVIUn1s+u59ChVRP027N6Gl9EeIcoeM8NmrNhG XFUHpBMPSkN7MuC5e+mr7Nu6Puex4/6OSR1QKD/LAF7+BGTSVvGFTupESYJ8aEhc2ANB2LkqZ3l
 zKP5ejFlAXnQjFcLFoGH/fF9goDsFf99BhIpFwTmZfRbHq5XGV0Sty5WznKKoA5eWuPTte9NRJK V6NwmdnWzNtuljey23+6Yd1z7GGvJqXxHrkQqBrDyByEUTGxa0Bg4WYY4xcNXThx3BlzTOBSETp BiH3trMEvlqArOlMvSGN8kGp29AWfBCXX42uqrCsga7be8w5JuVf9j8Sb9f3U9pNAFz0eunJzTK
 XGuFBzKVcEOtS4m98zh9O9A9UMObNIoECDuvdwoQ+6NnOnDoKUJKMx5sLmukPotEje7i1+Gi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages UART baud rates, with each baud
rate represented by a performance level. The driver uses the
dev_pm_opp_set_level() API to request the desired baud rate by
specifying the performance level.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 150 +++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9d698c354510..51036d5c8ea1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -99,10 +100,16 @@
 #define DMA_RX_BUF_SIZE		2048
 
 static DEFINE_IDA(port_ida);
+#define DOMAIN_IDX_POWER	0
+#define DOMAIN_IDX_PERF		1
 
 struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
+	struct dev_pm_domain_attach_data pd_data;
+	int (*geni_serial_pwr_rsc_init)(struct uart_port *uport);
+	int (*geni_serial_set_rate)(struct uart_port *uport, unsigned long clk_freq);
+	int (*geni_serial_switch_power_state)(struct uart_port *uport, bool state);
 };
 
 struct qcom_geni_private_data {
@@ -140,6 +147,7 @@ struct qcom_geni_serial_port {
 
 	struct qcom_geni_private_data private_data;
 	const struct qcom_geni_device_data *dev_data;
+	struct dev_pm_domain_list *pd_list;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -1331,6 +1339,42 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned long baud)
 	return 0;
 }
 
+static int geni_serial_set_level(struct uart_port *uport, unsigned long baud)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct device *perf_dev = port->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	/*
+	 * The performance protocol sets UART communication
+	 * speeds by selecting different performance levels
+	 * through the OPP framework.
+	 *
+	 * Supported perf levels for baudrates in firmware are below
+	 * +---------------------+--------------------+
+	 * |  Perf level value   |  Baudrate values   |
+	 * +---------------------+--------------------+
+	 * |      300            |      300           |
+	 * |      1200           |      1200          |
+	 * |      2400           |      2400          |
+	 * |      4800           |      4800          |
+	 * |      9600           |      9600          |
+	 * |      19200          |      19200         |
+	 * |      38400          |      38400         |
+	 * |      57600          |      57600         |
+	 * |      115200         |      115200        |
+	 * |      230400         |      230400        |
+	 * |      460800         |      460800        |
+	 * |      921600         |      921600        |
+	 * |      2000000        |      2000000       |
+	 * |      3000000        |      3000000       |
+	 * |      3200000        |      3200000       |
+	 * |      4000000        |      4000000       |
+	 * +---------------------+--------------------+
+	 */
+
+	return dev_pm_opp_set_level(perf_dev, baud);
+}
+
 static void qcom_geni_serial_set_termios(struct uart_port *uport,
 					 struct ktermios *termios,
 					 const struct ktermios *old)
@@ -1349,7 +1393,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
 
-	ret = geni_serial_set_rate(uport, baud);
+	ret = port->dev_data->geni_serial_set_rate(uport, baud);
 	if (ret) {
 		dev_err(port->se.dev,
 			"%s: Failed to set baud:%u ret:%d\n",
@@ -1640,8 +1684,27 @@ static int geni_serial_resources_on(struct uart_port *uport)
 	return 0;
 }
 
-static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
+static int geni_serial_resource_state(struct uart_port *uport, bool power_on)
 {
+	return power_on ? geni_serial_resources_on(uport) : geni_serial_resources_off(uport);
+}
+
+static int geni_serial_pwr_init(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	int ret;
+
+	ret = dev_pm_domain_attach_list(port->se.dev,
+					&port->dev_data->pd_data, &port->pd_list);
+	if (ret <= 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int geni_serial_resource_init(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	int ret;
 
 	port->se.clk = devm_clk_get(port->se.dev, "se");
@@ -1680,7 +1743,6 @@ static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
-
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
 		old_state = UART_PM_STATE_OFF;
@@ -1774,13 +1836,16 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
 
-	ret = geni_serial_resource_init(port);
+	ret = port->dev_data->geni_serial_pwr_rsc_init(uport);
 	if (ret)
 		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	if (!res) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	uport->mapbase = res->start;
 
 	port->tx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
@@ -1790,19 +1855,26 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (!data->console) {
 		port->rx_buf = devm_kzalloc(uport->dev,
 					    DMA_RX_BUF_SIZE, GFP_KERNEL);
-		if (!port->rx_buf)
-			return -ENOMEM;
+		if (!port->rx_buf) {
+			ret = -ENOMEM;
+			goto error;
+		}
 	}
 
 	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
 			"qcom_geni_serial_%s%d",
 			uart_console(uport) ? "console" : "uart", uport->line);
-	if (!port->name)
-		return -ENOMEM;
+	if (!port->name) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto error;
+	}
+
 	uport->irq = irq;
 	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
 
@@ -1824,7 +1896,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		return ret;
+		goto error;
 	}
 
 	pm_runtime_enable(port->se.dev);
@@ -1849,6 +1921,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 error:
 	pm_runtime_disable(port->se.dev);
+	dev_pm_domain_detach_list(port->pd_list);
 	return ret;
 }
 
@@ -1863,22 +1936,31 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 	ida_free(&port_ida, uport->line);
 	pm_runtime_disable(port->se.dev);
 	uart_remove_one_port(drv, &port->uport);
+	dev_pm_domain_detach_list(port->pd_list);
 }
 
 static int qcom_geni_serial_runtime_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
+	int ret = 0;
 
-	return geni_serial_resources_off(uport);
+	if (port->dev_data->geni_serial_switch_power_state)
+		ret = port->dev_data->geni_serial_switch_power_state(uport, false);
+
+	return ret;
 };
 
 static int qcom_geni_serial_runtime_resume(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
+	int ret = 0;
+
+	if (port->dev_data->geni_serial_switch_power_state)
+		ret = port->dev_data->geni_serial_switch_power_state(uport, true);
 
-	return geni_serial_resources_on(uport);
+	return ret;
 };
 
 static int qcom_geni_serial_suspend(struct device *dev)
@@ -1916,11 +1998,41 @@ static int qcom_geni_serial_resume(struct device *dev)
 static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
+	.geni_serial_pwr_rsc_init = geni_serial_resource_init,
+	.geni_serial_set_rate = geni_serial_set_rate,
+	.geni_serial_switch_power_state = geni_serial_resource_state,
 };
 
 static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
+	.geni_serial_pwr_rsc_init = geni_serial_resource_init,
+	.geni_serial_set_rate = geni_serial_set_rate,
+	.geni_serial_switch_power_state = geni_serial_resource_state,
+};
+
+static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
+	.console = true,
+	.mode = GENI_SE_FIFO,
+	.pd_data = {
+		.pd_flags = PD_FLAG_DEV_LINK_ON,
+		.pd_names = (const char*[]) { "power", "perf" },
+		.num_pd_names = 2,
+	},
+	.geni_serial_pwr_rsc_init = geni_serial_pwr_init,
+	.geni_serial_set_rate = geni_serial_set_level,
+};
+
+static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
+	.console = false,
+	.mode = GENI_SE_DMA,
+	.pd_data = {
+		.pd_flags = PD_FLAG_DEV_LINK_ON,
+		.pd_names = (const char*[]) { "power", "perf" },
+		.num_pd_names = 2,
+	},
+	.geni_serial_pwr_rsc_init = geni_serial_pwr_init,
+	.geni_serial_set_rate = geni_serial_set_level,
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
@@ -1934,10 +2046,18 @@ static const struct of_device_id qcom_geni_serial_match_table[] = {
 		.compatible = "qcom,geni-debug-uart",
 		.data = &qcom_geni_console_data,
 	},
+	{
+		.compatible = "qcom,sa8255p-geni-debug-uart",
+		.data = &sa8255p_qcom_geni_console_data,
+	},
 	{
 		.compatible = "qcom,geni-uart",
 		.data = &qcom_geni_uart_data,
 	},
+	{
+		.compatible = "qcom,sa8255p-geni-uart",
+		.data = &sa8255p_qcom_geni_uart_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_geni_serial_match_table);
-- 
2.17.1


