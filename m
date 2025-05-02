Return-Path: <linux-pm+bounces-26537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1356FAA6927
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CB41BC5B9A
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693F1A23A5;
	Fri,  2 May 2025 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LmXLjGSy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481C19D081;
	Fri,  2 May 2025 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155509; cv=none; b=nyQEJfgbIdJR9Pi4O9tvPsu3YW5ihnOM7k05rQu1sJQdqF6kSL+oFj5zlC7fqq7k00Us4W1iki2dB/tvA1nlhqsRjgqJzoy+QSYUxiFHc5Yza6lggMgNeEtht1ppZZ+bikzH8Vn/DqznKnU+LDEd9QrrATiwm8tvkCk4gxuxn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155509; c=relaxed/simple;
	bh=VoQ7nFV1g+/rGJpVuCPbhXVgcXZz5bjjW8X/xsvZmqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fm8kUbzpn77RTQTUEJdVQ+MPXB7HlV1b3Fq59TS5s15hBh3ydYyeKbDHd7GWlzTaOlMyONdcrrDMPHFnlxDI7iA66thLGFE8K8x6lZUiek53Si9YOSLKeZ2lLbIxzGew07j/Z6us1vl0lqZWmIBT/3X8ZOjFoFP+PpLQHXftiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LmXLjGSy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421NTb4002861;
	Fri, 2 May 2025 03:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kkK4rOzI+Q0t78xBg+S8kd/V
	DrKoyDZLYyx1ia+4HSY=; b=LmXLjGSyghBJs8Yikx0owHW8cO4kCfvc0YDfL73L
	+FgQQRKfdzQ103Agx29J4jEu2/Yblx5j1o2c613zop3sxGFVv9cWp/8lh/Omyqu+
	pk+AKhoGnJbaLtS/hPVVsTp1ESOkjVCPHQMZyP8A6nvSfIWsPcu+mtZI/iA5EsNy
	O0chOEMw5y5fCczUVP3PldMVxzW0MG6TyJjotKX+5Uj+Fe1BC6KXHSUyDtZt43Oc
	WtItpED3LiIxwqer7NZZ1UCsvnzfKtTjo4JMFz9ssJ5qNYYnNod3Aw9muYDiQm1j
	3YnHOo+tsUTa/TBl8KFW0cKOMiVAn5WC81kC+nD3c4pRiw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u774qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:11:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423Bfis007397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:11:41 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:11:34 -0700
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
Subject: [PATCH v3 7/9] serial: qcom-geni: move clock-rate logic to separate function
Date: Fri, 2 May 2025 08:40:16 +0530
Message-ID: <20250502031018.1292-8-quic_ptalari@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfX1PWtMNfW8Hui 8BJOp9K8BpcHB7kMT4XpYYPk28mMKxd3iPED1F1ZFGsl2VMVj7pmp7S1cumJIhJF9PHkBnQYx6f jGo58+QOk/jyOfmPQW+qPFcOUzMOJlNY0nmwPaAUb75xCAjAbLY3k/NhtAKg+4P9uxpmmof26yV
 dtKfV5A3q59hmbro+AkIB9aeigQiCdWg/ROyyYhQ7nd84TQwWcEkDWMyfknrjXj2LipWC+trD2/ D+PULLLSEN68gih6YBlRyh3zsc5Gj3Zd4a/hyIeL7r2CFHzmMm1t2c4HR+tdT6dbaYsndSy4NXn bPAYoiyFv8IxDKJmIH5IoGCCk3FmoeSphpRlYabI9kpZw4oBEheTxeIs14YT2r+OrHsyKezt0bR
 Xp4O+/o/5Kxh6VAW8GIvkDL7TqulQXWEXCLgEPAbhcftY5K6lIu2fHS8bdeM7nD2X4gyinFQ
X-Proofpoint-GUID: _KMxyBX1vE8KX_Q4haZ94T0rkn7ua5Wp
X-Authority-Analysis: v=2.4 cv=W404VQWk c=1 sm=1 tr=0 ts=681437ed cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=X08zvMDfRsL5Z2rP0xYA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _KMxyBX1vE8KX_Q4haZ94T0rkn7ua5Wp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

Facilitates future modifications within the new function,
leading to better readability and maintainability of the code.

Move the code that handles the actual logic of clock-rate
calculations to a separate function geni_serial_set_rate()
which enhances code readability.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

v1 -> v2
- resolved build warnings for datatype format specifiers
- removed double spaces in log
---
 drivers/tty/serial/qcom_geni_serial.c | 62 +++++++++++++++++----------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2cd2085473f3..60afee3884a6 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1283,27 +1283,14 @@ static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
 	return ser_clk;
 }
 
-static void qcom_geni_serial_set_termios(struct uart_port *uport,
-					 struct ktermios *termios,
-					 const struct ktermios *old)
+static int geni_serial_set_rate(struct uart_port *uport, unsigned long baud)
 {
-	unsigned int baud;
-	u32 bits_per_char;
-	u32 tx_trans_cfg;
-	u32 tx_parity_cfg;
-	u32 rx_trans_cfg;
-	u32 rx_parity_cfg;
-	u32 stop_bit_len;
-	unsigned int clk_div;
-	u32 ser_clk_cfg;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned long clk_rate;
-	u32 ver, sampling_rate;
 	unsigned int avg_bw_core;
-	unsigned long timeout;
-
-	/* baud rate */
-	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
+	unsigned int clk_div;
+	u32 ver, sampling_rate;
+	u32 ser_clk_cfg;
 
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
@@ -1315,13 +1302,13 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		sampling_rate, &clk_div);
 	if (!clk_rate) {
 		dev_err(port->se.dev,
-			"Couldn't find suitable clock rate for %u\n",
+			"Couldn't find suitable clock rate for %lu\n",
 			baud * sampling_rate);
-		return;
+		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
-			baud * sampling_rate, clk_rate, clk_div);
+	dev_dbg(port->se.dev, "desired_rate = %lu, clk_rate = %lu, clk_div = %u\n",
+		baud * sampling_rate, clk_rate, clk_div);
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
@@ -1339,6 +1326,37 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	port->se.icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(baud);
 	geni_icc_set_bw(&port->se);
 
+	writel(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
+	writel(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
+	return 0;
+}
+
+static void qcom_geni_serial_set_termios(struct uart_port *uport,
+					 struct ktermios *termios,
+					 const struct ktermios *old)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	unsigned int baud;
+	unsigned long timeout;
+	u32 bits_per_char;
+	u32 tx_trans_cfg;
+	u32 tx_parity_cfg;
+	u32 rx_trans_cfg;
+	u32 rx_parity_cfg;
+	u32 stop_bit_len;
+	int ret = 0;
+
+	/* baud rate */
+	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
+
+	ret = geni_serial_set_rate(uport, baud);
+	if (ret) {
+		dev_err(port->se.dev,
+			"%s: Failed to set baud:%u ret:%d\n",
+			__func__, baud, ret);
+		return;
+	}
+
 	/* parity */
 	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
 	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
@@ -1406,8 +1424,6 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
 	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
 	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
-	writel(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
-	writel(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
 }
 
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
-- 
2.17.1


