Return-Path: <linux-pm+bounces-16728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC929B637F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3921F224AC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0A1EF0BE;
	Wed, 30 Oct 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nj4XWcwH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601981EF936;
	Wed, 30 Oct 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292957; cv=none; b=LocD5uam9k24yZNp0Rlq0F3rd4i6FE7QcUvOnDRBEf9jXl8YRjdQ8iLYt5Wv7tjsCePsRQUSYNwzCkzeNto+CxlQZEhCNzH2PeAkaM4CViVcMfAzeh9S3cHmyXk3Kp2geURuc8IgJCoh6V4kys6z8ixJwroszp08CgyHoaSdkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292957; c=relaxed/simple;
	bh=XYAN12nlFaI3UNRe0CFzg4pxnAKOGScleRB5KexJd2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYnNS+9JX/FsidlXdpsYNG4Iek2hseY9SyRgBC1qpb1o4qqx/srSu1yohR3TYrUsPgeKP9cGjjYEn7o+4pVy/Bx69XTVXOBJR2BMHOTQNsDCsNg9f1ykVpfe9hZLSvQaYBQgSTyrL6Je0ZRLJ67uhGVptFMNl6lcjxuRI1Rc3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nj4XWcwH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U9x3s6000705;
	Wed, 30 Oct 2024 12:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cq6J9C5Gasf4X5brWYjA6NSd8m9FjxEIcJtzv2DJjIE=; b=nj4XWcwH7tp/hoin
	pDUTUjfGW0PNBUFz4++PTxcG5GDM+GuUWI5pcvOb5eB9Zz87/IlXMyHqv69y2kCW
	hgPydeWUNoT2hH60LdBl4QentMAEHnsjc49AR2UnpH2mmXzFbOMsWuOJDm6BQXVB
	8z3CAcIIrRXpUFqd3BHPoXGxLV8NMBCRWfCSrlXJ+GOK+1lFXovtlnPmL/0SpCxt
	tVYZPRf0SMduXpyely6/VIWOayvGxVQ7HyBWGmPonmMRpWVpUMzchmkyDAyOBdPV
	ghpqbW/6ukwxtmEWUmAJXlFRHrTqdfJ34sEdYO+dH4n70DfnEKWMeYOavrjTgPPY
	Qr7NQQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt73xsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCtg3f005780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:42 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 05:55:37 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <johan@kernel.org>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <konradybcio@kernel.org>, <linux-pm@vger.kernel.org>,
        <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V5 2/6] firmware: arm_scmi: Skip opp duplicates
Date: Wed, 30 Oct 2024 18:25:08 +0530
Message-ID: <20241030125512.2884761-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030125512.2884761-1-quic_sibis@quicinc.com>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: DVQDiWghawQyBmNpLnzbIXqGcqhNo7n0
X-Proofpoint-GUID: DVQDiWghawQyBmNpLnzbIXqGcqhNo7n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300099

From: Cristian Marussi <cristian.marussi@arm.com>

Buggy firmware can reply with duplicated PERF opps descriptors.

Ensure that the bad duplicates reported by the platform firmware doesn't
get added to the opp-tables.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 40 ++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 2d77b5f40ca7..32f9a9acd3e9 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -373,7 +373,7 @@ static int iter_perf_levels_update_state(struct scmi_iterator_state *st,
 	return 0;
 }
 
-static inline void
+static inline int
 process_response_opp(struct device *dev, struct perf_dom_info *dom,
 		     struct scmi_opp *opp, unsigned int loop_idx,
 		     const struct scmi_msg_resp_perf_describe_levels *r)
@@ -386,12 +386,16 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
 		le16_to_cpu(r->opp[loop_idx].transition_latency_us);
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
 			 opp->perf, dom->info.name, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
-static inline void
+static inline int
 process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 			struct scmi_opp *opp, unsigned int loop_idx,
 			const struct scmi_msg_resp_perf_describe_levels_v4 *r)
@@ -404,9 +408,11 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 		le16_to_cpu(r->opp[loop_idx].transition_latency_us);
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
 			 opp->perf, dom->info.name, ret);
+		return ret;
+	}
 
 	/* Note that PERF v4 reports always five 32-bit words */
 	opp->indicative_freq = le32_to_cpu(r->opp[loop_idx].indicative_freq);
@@ -415,13 +421,21 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 
 		ret = xa_insert(&dom->opps_by_idx, opp->level_index, opp,
 				GFP_KERNEL);
-		if (ret)
+		if (ret) {
 			dev_warn(dev,
 				 "Failed to add opps_by_idx at %d for %s - ret:%d\n",
 				 opp->level_index, dom->info.name, ret);
 
+			/* Cleanup by_lvl too */
+			xa_erase(&dom->opps_by_lvl, opp->perf);
+
+			return ret;
+		}
+
 		hash_add(dom->opps_by_freq, &opp->hash, opp->indicative_freq);
 	}
+
+	return 0;
 }
 
 static int
@@ -429,16 +443,22 @@ iter_perf_levels_process_response(const struct scmi_protocol_handle *ph,
 				  const void *response,
 				  struct scmi_iterator_state *st, void *priv)
 {
+	int ret;
 	struct scmi_opp *opp;
 	struct scmi_perf_ipriv *p = priv;
 
-	opp = &p->perf_dom->opp[st->desc_index + st->loop_idx];
+	opp = &p->perf_dom->opp[p->perf_dom->opp_count];
 	if (PROTOCOL_REV_MAJOR(p->version) <= 0x3)
-		process_response_opp(ph->dev, p->perf_dom, opp, st->loop_idx,
-				     response);
+		ret = process_response_opp(ph->dev, p->perf_dom, opp,
+					   st->loop_idx, response);
 	else
-		process_response_opp_v4(ph->dev, p->perf_dom, opp, st->loop_idx,
-					response);
+		ret = process_response_opp_v4(ph->dev, p->perf_dom, opp,
+					      st->loop_idx, response);
+
+	/* Skip BAD duplicates received from firmware */
+	if (ret)
+		return ret == -EBUSY ? 0 : ret;
+
 	p->perf_dom->opp_count++;
 
 	dev_dbg(ph->dev, "Level %d Power %d Latency %dus Ifreq %d Index %d\n",
-- 
2.34.1


