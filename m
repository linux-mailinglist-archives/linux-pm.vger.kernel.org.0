Return-Path: <linux-pm+bounces-9480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C290D96C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108E0B25AAF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338D4D8AE;
	Tue, 18 Jun 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AQqP5DHm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2423756B8C;
	Tue, 18 Jun 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725421; cv=none; b=mX3/TAtMBp1Wl3MVkugid0tBpSutWtyyIyDKf2RrUK3shdVDnBA6NG8HTUM43DdBub7790iGefkgo/YpwEc9TebyV9jg8t9qBBLlzftG3b0pQ/d6JO+bNAIkMdt0XvIMQa1BULDpZAJEpCv7uU7yoyHym0V6MEC+hC790biFARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725421; c=relaxed/simple;
	bh=6RTZeDVv0eHMnrmBjMt51DIedEz2EHqw6On/OGFrlkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huLEPdCQa2VXRX8Q8AVykcD0zQU2n9eZKjoAOZx7tE40OxQJ+uAyOD0ZPaGFqBFe9utTV3THTik5ZRKkReitNphHWY7vdju5dKie6zKK4HkjYz73Q8vecqRQzV0Tu6cWVMSJVRUqN6CCw6kTim4UkRogpUqJnXwVnAQpA5SBdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AQqP5DHm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IBF1vV001087;
	Tue, 18 Jun 2024 15:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1iIuIoGRWHPASahuRJrgkolpFCNwfPL9/78oB3jD2X4=; b=AQqP5DHmjKksEuky
	/dUlrD6JcbpSAHD6aRgNChaLRdy0jCVDtiiQ7GKz4A9/faEqqN2HjqVhPSMV4HEN
	5nuMWuC03LZVS4KZy6FabWndiQrKt+KWdW4+jQrJjYlTE6MrHcz94g49zuvzNYkT
	tvsCx0XyjBH0NwyFBJWT1AJoRD0VrG2GdQ4AFllk25VCKqF7qmlqTva16piO0ODp
	5h+nedvv0OI9Hc3bGfO/6VKMtuLcH5Up7ryZ04ysYLrYSL6nTCzZBlfhpuMpvMOe
	Cgf8QkwaAW8e2ivwfjVz+JtSqj4KkHjvngHE2LGYfACkbY42EYo/AF8KSkaZqeME
	aUp/Gg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu1b0stwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IFhZEu016810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:35 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 08:43:30 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH V2 2/3] soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances
Date: Tue, 18 Jun 2024 21:13:05 +0530
Message-ID: <20240618154306.279637-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618154306.279637-1-quic_sibis@quicinc.com>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JP-_3fgJk74kaubT9kS2TiI-yw218GF9
X-Proofpoint-ORIG-GUID: JP-_3fgJk74kaubT9kS2TiI-yw218GF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180118

The multiple BWMONv4 instances available on the X1E80100 SoC use the
same interrupt number. Mark them are shared to allow for re-use across
instances. Handle the ensuing race introduced by relying on bwmon_disable
to disable the interrupt and coupled with explicit request/free irqs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Use explicit request/free irq and add comments regarding the race
  introduced when adding the IRQF_SHARED flag. [Krzysztof/Dmitry]

 drivers/soc/qcom/icc-bwmon.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index fb323b3364db..4a4e28b41509 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -781,9 +781,10 @@ static int bwmon_probe(struct platform_device *pdev)
 	bwmon->dev = dev;
 
 	bwmon_disable(bwmon);
-	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
-					bwmon_intr_thread,
-					IRQF_ONESHOT, dev_name(dev), bwmon);
+
+	/* SoCs with multiple cpu-bwmon instances can end up using a shared interrupt line */
+	ret = request_threaded_irq(bwmon->irq, bwmon_intr, bwmon_intr_thread,
+				   IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), bwmon);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request IRQ\n");
 
@@ -798,6 +799,13 @@ static void bwmon_remove(struct platform_device *pdev)
 	struct icc_bwmon *bwmon = platform_get_drvdata(pdev);
 
 	bwmon_disable(bwmon);
+
+	/*
+	 * Handle the race introduced, when dealing with multiple bwmon instances
+	 * using a shared interrupt line, by relying on bwmon_disable to disable
+	 * the interrupt and followed by an explicit free.
+	 */
+	free_irq(bwmon->irq, bwmon);
 }
 
 static const struct icc_bwmon_data msm8998_bwmon_data = {
-- 
2.34.1


