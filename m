Return-Path: <linux-pm+bounces-9887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5991464C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E01F21CC1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D8136995;
	Mon, 24 Jun 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fB1TAbm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E31304B1;
	Mon, 24 Jun 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220990; cv=none; b=Q/PpkjI7J6oUciyffsqeLMiNLFWdikXVfIy6h+s2r1E23+bmcJEhp1S374ouiBaZl+O1WgnoNnZiVP86V+vX12atWtfwKwJGpTRFSTIU9YInJZTQQankTxKEYfyEEhwWXHeSGI4As8l/oa88hY9MRx1BsMLkzX8g2eKBo8a/xDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220990; c=relaxed/simple;
	bh=VSdyIqcXKIeXywG64FX9bSiDwrUvzE9Hv8UawMJCHow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGKfTRXWlqQE+KVuWfsGq5H1+YUm0luS4hkxBFhSlTo9BbrLRF+XoT2Uq4jh/VdU+jmad9yOP/S8avVkZ/0eI7KTh8UGLda273gItm2jrCABb41TZ3wqioXexwEkY7eD7EDQuYaC1AHwfLnckhdwu2YvBIiEdRqpAK1yb3mXXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fB1TAbm2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8Yw49023757;
	Mon, 24 Jun 2024 09:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5IyIy2raQyI/j8Y4tp3EjbrHtT/L8h4cYoQYDRAXN/I=; b=fB1TAbm2zsfQ3n1q
	2GO+TCbkjGNeiukzbxHg/lPneBf5tyiuYbrxr03CapOLtZf/gK1msEqjg6KfNyT5
	9rY2RiXCj2ms25oe+AQonqGfiL2bzVLaFp+YHlGExHkYgcr+tpVUfYwrtCBQVfGw
	Pwt/3UPF3ots51EXpXacKwul1zLWObHdLWm7qiNPwxMXJ18a7mkEKsDH2ZAEnqNY
	EdlzWJqItSyyF9w69lzwLhoBgFjL9J6GztZA1bWaC+fTVGnZipk77HQ404Gtvdon
	r/dcL4lYti0C8basiJCcRH4+nFDx7SNIpTnYdlcq0UEHsVJMtOMZqGT/SXyKcA+W
	rQCG+A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshk56q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:23:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O9N42I023535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:23:04 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 02:22:59 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <abel.vesa@linaro.org>
Subject: [PATCH V3 3/4] soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances
Date: Mon, 24 Jun 2024 14:52:13 +0530
Message-ID: <20240624092214.146935-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624092214.146935-1-quic_sibis@quicinc.com>
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LjVomsMhcbDicQrk_2pM4_klvla9gWVm
X-Proofpoint-GUID: LjVomsMhcbDicQrk_2pM4_klvla9gWVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240075

The multiple BWMONv4 instances available on the X1E80100 SoC use the
same interrupt number. Mark them are shared to allow for re-use across
instances.

Using IRQF_SHARED coupled with devm_request_threaded_irq implies that
the irq can still trigger during/after bwmon_remove due to other active
bwmon instances. Handle this race by relying on bwmon_disable to disable
the interrupt and coupled with explicit request/free irqs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
* Update commit message describing the race condition. [Bjorn]
* Update comment in the bwmon driver. [Dmitry]

 drivers/soc/qcom/icc-bwmon.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index ecddb60bd665..e7851974084b 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -783,9 +783,14 @@ static int bwmon_probe(struct platform_device *pdev)
 	bwmon->dev = dev;
 
 	bwmon_disable(bwmon);
-	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
-					bwmon_intr_thread,
-					IRQF_ONESHOT, dev_name(dev), bwmon);
+
+	/*
+	 * SoCs with multiple cpu-bwmon instances can end up using a shared interrupt
+	 * line. Using the devm_ variant might result in the IRQ handler being executed
+	 * after bwmon_disable in bwmon_remove()
+	 */
+	ret = request_threaded_irq(bwmon->irq, bwmon_intr, bwmon_intr_thread,
+				   IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), bwmon);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request IRQ\n");
 
@@ -800,6 +805,7 @@ static void bwmon_remove(struct platform_device *pdev)
 	struct icc_bwmon *bwmon = platform_get_drvdata(pdev);
 
 	bwmon_disable(bwmon);
+	free_irq(bwmon->irq, bwmon);
 }
 
 static const struct icc_bwmon_data msm8998_bwmon_data = {
-- 
2.34.1


