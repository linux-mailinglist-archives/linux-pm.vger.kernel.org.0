Return-Path: <linux-pm+bounces-25719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199CA93953
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5231B630F0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3779214818;
	Fri, 18 Apr 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cUzPHYaB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90320896E;
	Fri, 18 Apr 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989240; cv=none; b=pSoKTxIxVEg/tHSnBpniiy0DVxriu5dW0ErKRL17/CqIoUu29GB7xNxC9bEhSASHMxzPAcrvwycf0FpguYnBTx0H7uVwUuww8jQ/pa8F2SgKlnZhRgSX1j9Bq8ZQOffeODpuvGhC9RLPb+nW5eoegxCuskmIrWfxEMvXVL2Lj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989240; c=relaxed/simple;
	bh=rItygsDBCWMZXJyIMlcErM5nB2z/h3+qW6EIeW5nenI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMEJZS/8rAjFZ0U5mOVAG8R/PLe4WixKIhgidK29jC0xKIPlYimCFGnlh5RXrWGAkJMPHMhmIEveBQ17J9kbW2SNzEtD1mwlUtD7X0TpXhDi3xIGokxVPyEu+cbkFUSeb5wIdwyNXdYilrpFSWEq2Kw0B7zCn64LbQxmHztpt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cUzPHYaB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2juLH008131;
	Fri, 18 Apr 2025 15:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qw+R07Ks7TEdLrnPjXdjn0zy
	LsQKfldJqI+Cq336mS4=; b=cUzPHYaB29NmF6Ng/p4ELqpgQs5PahW3W2K/OwLY
	MToPk/Ia5FpUF88KZtg8Z7otJEr72DuTrP1G9TkU/o9d+Uud1uQ8IpG3jPK6OSc4
	eLI5r99ljbcIZUyb+P6q9ftEHu+PXcYM5tpnjIbWQLmMz4zrZoZ4FWVxk/t0xZns
	1LWXjPtlIIl3EnZGBbK3S6p74ryQscDMa6zBCBV5HQJv0Za+DLXZHwM7pBbMT7PW
	StIEGf1XaNbEX2uWRaLfwHI0Cr82weAe4nDmZjhwhuWTd9n9O3l3vyT7ZoDE6/8r
	/iBZKLe5YxcQN3fw8iXBAIISHI2H3esXWFUM3AoAfqfg3A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxka4nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IFDr4O021840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:53 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 08:13:46 -0700
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
Subject: [PATCH v2 7/9] serial: qcom-geni: move clock-rate logic to separate function
Date: Fri, 18 Apr 2025 20:42:33 +0530
Message-ID: <20250418151235.27787-8-quic_ptalari@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=68026c31 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=X08zvMDfRsL5Z2rP0xYA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5A4YgC4uY0PnbUAsFDc3dPb5JlJNLpLj
X-Proofpoint-ORIG-GUID: 5A4YgC4uY0PnbUAsFDc3dPb5JlJNLpLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180112

Facilitates future modifications within the new function,
leading to better readability and maintainability of the code.

Move the code that handles the actual logic of clock-rate
calculations to a separate function geni_serial_set_rate()
which enhances code readability.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
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


