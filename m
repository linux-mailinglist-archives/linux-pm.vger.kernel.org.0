Return-Path: <linux-pm+bounces-11624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ADB9407D4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE581C2232F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 05:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA1918FC7F;
	Tue, 30 Jul 2024 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YvQuf67y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CE16B3B7;
	Tue, 30 Jul 2024 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318540; cv=none; b=kyMHZJpHJG5wQ+N3sCl6ZBcYyIjNDuNSi58KDXoA9hIqi+wfYRe8zXvOxX+p4iosc6rA3cQ/uDSjzfmTtSrklJPRv+ZLViRldQeBk4lTpyD/bXJL0STat7v5YXtQbk1ItX7j31/qSln2KRUfsS1KCM5TJ0i9he2YlM7Ei4orBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318540; c=relaxed/simple;
	bh=p8Sk4FKBBnyJmxr1GaMxe/l0Q+UdaX8rXld+1o6On0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvhWZkc3zwETtybZz20VP5BuYygPnvlRL1XvlBmDKzsCC6GjdgUP2yn+D24SB8exkJLR6UyTcq5m//skLaLNfQ23w7GA0BF2uOBPBg3W9aVZr3CL3Nf1BxyVNtcKDWcL5gAW8YmIv9IUuQfLu0aUR8U8c70RjrEETIxK6jrk91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YvQuf67y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TNGE9j030108;
	Tue, 30 Jul 2024 05:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/AlIFpe7hmeVTaurYUXsanjT0Y59TPOb/2pqC05RTI=; b=YvQuf67yiNIBhIsG
	LA3mEww7oTqlxKNiT/jfbS/uCwW4f0S+1E8ebReoh0zRn6D1gP5LgvqGxHFc1u/n
	ikbAq5QjLXaoRybHoB0+cBsQ3hyLy2WRbQR7frQbM1BVm2QMFrFa3/RRqRlNUXRn
	3BOBKaTfofkJNTvd4/SEOd+j1T/FDUxpCvOKXARo4pnrurde9BuvdL7FnmxvhEFR
	8HKsnpKQkf66j40O1eOUtGNRlOW8p3s3sZkOd3IvRQs9mPP2yndjAE/n6mm7FQC9
	e8yrn8og0QAU/30h02H17+rRPd8Yuu177LqoN1H67n/itDdIhYUAp6e4CdfpAvnn
	DiCzmA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mr7gpb4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U5mqJm010973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 22:48:46 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 3/5] clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src
Date: Tue, 30 Jul 2024 11:18:15 +0530
Message-ID: <20240730054817.1915652-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730054817.1915652-1-quic_varada@quicinc.com>
References: <20240730054817.1915652-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UgjkrmvFzIJeEKPdVWQ7noW7J4_CjxJf
X-Proofpoint-GUID: UgjkrmvFzIJeEKPdVWQ7noW7J4_CjxJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_05,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407300042

gcc_qdss_tsctr_clk_src (enabled in the boot loaders and dependent
on gpll4_main) was not registered as one of the ipq5332 clocks.
Hence clk_disable_unused() disabled 'gpll4_main' assuming there
were no consumers for 'gpll4_main' resulting in system freeze or
reboots.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

---
v5: Add 'Reviewed-by: Dmitry Baryshkov'
v4: Move gpll4_main change that removes CLK_IGNORE_UNUSED to next patch
    Add 'Fixes' tag to commit message
---
 drivers/clk/qcom/gcc-ipq5332.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index f98591148a97..6a4877d88829 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -3388,6 +3388,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_QDSS_DAP_DIV_CLK_SRC] = &gcc_qdss_dap_div_clk_src.clkr,
 	[GCC_QDSS_ETR_USB_CLK] = &gcc_qdss_etr_usb_clk.clkr,
 	[GCC_QDSS_EUD_AT_CLK] = &gcc_qdss_eud_at_clk.clkr,
+	[GCC_QDSS_TSCTR_CLK_SRC] = &gcc_qdss_tsctr_clk_src.clkr,
 	[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
 	[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
 	[GCC_QPIC_IO_MACRO_CLK] = &gcc_qpic_io_macro_clk.clkr,
-- 
2.34.1


