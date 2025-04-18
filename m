Return-Path: <linux-pm+bounces-25717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A1A9394C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281601785C6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60BE211479;
	Fri, 18 Apr 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lb1hKNGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35620DD48;
	Fri, 18 Apr 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989228; cv=none; b=fSGYyt4isA6qLJZaoBEoI6fIruYA0R+OFxoWOWEJeSeYnadbkEZZQP6wGFrEb0UNCEpCygFWcA8vtrJoJnbf4+9ZTGr/DY4PL6gskcB6PmrHlRlXw/2BwTtzw9j8qGQ0RDLasiiQOleb3ashGX4ZLS4Ix3X09zB3PnJnHcQ9+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989228; c=relaxed/simple;
	bh=H/bszgL1OZ2wtrgZtsbrOdz6gn6t/Azsvf/9H2FjXrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohV2d1MpHj66hpYQhm1vEqWFapmnV2hLo7rUuoLfiCVXiazOtATX9eRZ228OUOgCj0xQ3n/b1En0mR7Jy23pLHyhokIxfAizF3/lxT60dL/IwubdhYfDqdNAcXj1dbg1d2ksUIASzt8kZOzQLq0ZmtyjlZ1zFBzCbFvnz0RnFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lb1hKNGK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IEPmwr013255;
	Fri, 18 Apr 2025 15:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2BbK7/gkNmHXiZtgnGtEEdjM
	5vf+pI/poxfU+cpTB7o=; b=Lb1hKNGK+WfbYVtH2/rWj4WBCLVk7oszMwBIOUYv
	86PqjvY0bcVjtXj5L65h7aASbvszyes51EKF1K5pDmvw3NICyyvLxX4rZ2YcCC/+
	UcEX/JhS9f397PgxCedKrpqmwbivNQM5fvSRe4r689GzOcXrO96N9ipV1b4VaKP2
	aaAcV5e8w08g+tlxlixZJhBfC8dY/NWHenOYG9BoVLdXmJTGgy6DQbOaUbCy55N2
	1p/egDkxJTdIiuFt6ci7Ii6jQucyySQh5ZV5lQdXrpcAmqhNabyoOsbTwAQ2N6Q8
	rFPkhKFsfV5QTWw9jNTIx2eSbPd75ytjLhIQInCN9gVicw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvfkay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:38 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IFDcce021589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:38 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 08:13:31 -0700
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
Subject: [PATCH v2 5/9] serial: qcom-geni: move resource initialization to separate function
Date: Fri, 18 Apr 2025 20:42:31 +0530
Message-ID: <20250418151235.27787-6-quic_ptalari@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fDAY_6m05kXCzrR7nRL3Kx7RQpWLbj_V
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=68026c22 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=0DDkC8yEFXPSaA7UoRYA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fDAY_6m05kXCzrR7nRL3Kx7RQpWLbj_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180112

Enhances code readability and future modifications within the new API.

Move the code that handles the actual initialization of resources
like clock and ICC paths to a separate function, making the
probe function cleaner.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
v1 -> v2
- updated subject description.
- added a new line after function end
---
 drivers/tty/serial/qcom_geni_serial.c | 66 ++++++++++++++++-----------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0293b6210aa6..6ad759146f71 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1588,6 +1588,43 @@ static struct uart_driver qcom_geni_uart_driver = {
 	.nr =  GENI_UART_PORTS,
 };
 
+static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
+{
+	int ret;
+
+	port->se.clk = devm_clk_get(port->se.dev, "se");
+	if (IS_ERR(port->se.clk)) {
+		ret = PTR_ERR(port->se.clk);
+		dev_err(port->se.dev, "Err getting SE Core clk %d\n", ret);
+		return ret;
+	}
+
+	ret = geni_icc_get(&port->se, NULL);
+	if (ret)
+		return ret;
+
+	port->se.icc_paths[GENI_TO_CORE].avg_bw = GENI_DEFAULT_BW;
+	port->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
+
+	/* Set BW for register access */
+	ret = geni_icc_set_bw(&port->se);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_set_clkname(port->se.dev, "se");
+	if (ret)
+		return ret;
+
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(port->se.dev);
+	if (ret && ret != -ENODEV) {
+		dev_err(port->se.dev, "invalid OPP table in device tree\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
@@ -1690,12 +1727,10 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->dev_data = data;
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
-	port->se.clk = devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(port->se.clk)) {
-		ret = PTR_ERR(port->se.clk);
-		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
+
+	ret = geni_serial_resource_init(port);
+	if (ret)
 		return ret;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -1713,17 +1748,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	ret = geni_icc_get(&port->se, NULL);
-	if (ret)
-		return ret;
-	port->se.icc_paths[GENI_TO_CORE].avg_bw = GENI_DEFAULT_BW;
-	port->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-
-	/* Set BW for register access */
-	ret = geni_icc_set_bw(&port->se);
-	if (ret)
-		return ret;
-
 	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
 			"qcom_geni_serial_%s%d",
 			uart_console(uport) ? "console" : "uart", uport->line);
@@ -1745,16 +1769,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
 		port->cts_rts_swap = true;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
-	if (ret)
-		return ret;
-	/* OPP table is optional */
-	ret = devm_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		return ret;
-	}
-
 	port->private_data.drv = drv;
 	uport->private_data = &port->private_data;
 	platform_set_drvdata(pdev, port);
-- 
2.17.1


