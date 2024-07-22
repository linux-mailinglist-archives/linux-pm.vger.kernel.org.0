Return-Path: <linux-pm+bounces-11283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF693889D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 07:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF842815CA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B7224D7;
	Mon, 22 Jul 2024 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z0/i+o+8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685E21340;
	Mon, 22 Jul 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627780; cv=none; b=hiRZIwaUGowsQHiVO3rYRs5aT9J0TD6SqITDZiFObI9nZxtXvkhf4CA630WP2uKFX4C0sfVvfnwV5KIIktfdwym93Y11ZmbbXUY8tefp5dnEhH8eC5JuyJI43hMbP+DQmJ0fRchRYyuNW57voCKXZFNoi306nN0X+9yUYu4H+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627780; c=relaxed/simple;
	bh=nvIhnujJdDFYs0cqFOPcRYQgZ3GESSy33w7przTip0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hp9WoJl0vCXrkyyXJwAILsZCPnRz6leDv4DC1T50G/s2K75J6Dt/xamlLfV2zbmJQPTNB8ZVNx8OHJphmtdYEHef6T/ChocZTA4IQrhNk4dTIoSNZpXec52VYlPkb+FfWw04SlzQ82JkvUydy5f1rEBSmvmolGFglg0metDnaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z0/i+o+8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46LN8VfU010739;
	Mon, 22 Jul 2024 05:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AhcER5tqEZZfjaRRpHR7WysIB8EpJ8Fh2NOvuEuasD8=; b=Z0/i+o+8L5zqW9vD
	u+MrMBbJX7gul6TH9tPKOzR0rBuLP50QlykhbDQHRdt/7kB5M5Hb8+AZvDySCw64
	uxeBJpnWqPg+44aR0zOoUewPgWB0HolXorI7Yc3FYWOH1MkZEfMN9hDxKJfBXFEp
	zAdstAp6rhCiUA1n/yKXxgjXjBCw5raXN5Zak8h65J4criWJjTOcJ0P3+C3KfSB4
	3oBmpwl6DF1uOsGMOL7UajrQicThxb0GpA7Hb/o3lcDM/iRvIOZnUe6yuXSoay85
	f+Q0wclPeYQAds7b8Rl2d8XbDv1f6durBnAr1rbi5pECxVP/gulkloI5EMbtvOTE
	2gpjzA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jgtrbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:56:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46M5uCIJ017857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:56:12 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Jul 2024 22:56:07 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 3/5] clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src
Date: Mon, 22 Jul 2024 11:25:37 +0530
Message-ID: <20240722055539.2594434-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722055539.2594434-1-quic_varada@quicinc.com>
References: <20240722055539.2594434-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6ZVWT1NmYWNBOTSfT8S7PIbf1HdZdr_z
X-Proofpoint-GUID: 6ZVWT1NmYWNBOTSfT8S7PIbf1HdZdr_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_02,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220044

gcc_qdss_tsctr_clk_src (enabled in the boot loaders and dependent
on gpll4_main) was not registered as one of the ipq5332 clocks.
Hence clk_disable_unused() disabled 'gpll4_main' assuming there
were no consumers for 'gpll4_main' resulting in system freeze or
reboots.

After registering gcc_qdss_tsctr_clk_src, CLK_IGNORE_UNUSED can
be removed from gpll4_main.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index f98591148a97..237b6a766179 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -126,17 +126,6 @@ static struct clk_alpha_pll gpll4_main = {
 			.parent_data = &gcc_parent_data_xo,
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_stromer_ops,
-			/*
-			 * There are no consumers for this GPLL in kernel yet,
-			 * (will be added soon), so the clock framework
-			 * disables this source. But some of the clocks
-			 * initialized by boot loaders uses this source. So we
-			 * need to keep this clock ON. Add the
-			 * CLK_IGNORE_UNUSED flag so the clock will not be
-			 * disabled. Once the consumer in kernel is added, we
-			 * can get rid of this flag.
-			 */
-			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -3388,6 +3377,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_QDSS_DAP_DIV_CLK_SRC] = &gcc_qdss_dap_div_clk_src.clkr,
 	[GCC_QDSS_ETR_USB_CLK] = &gcc_qdss_etr_usb_clk.clkr,
 	[GCC_QDSS_EUD_AT_CLK] = &gcc_qdss_eud_at_clk.clkr,
+	[GCC_QDSS_TSCTR_CLK_SRC] = &gcc_qdss_tsctr_clk_src.clkr,
 	[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
 	[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
 	[GCC_QPIC_IO_MACRO_CLK] = &gcc_qpic_io_macro_clk.clkr,
-- 
2.34.1


