Return-Path: <linux-pm+bounces-15240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6014992422
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C091C22341
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4451531C4;
	Mon,  7 Oct 2024 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W4gX/r4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A774C08;
	Mon,  7 Oct 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281266; cv=none; b=Y5VCy+oVon7D27MyH2StQG9WF7bHmwu59ZwG3mAcsr/JdIlHrF2aia0EesPUzfw9akVj/bpmBpT5d01Br744UZFOWUSrLEerZeL272VZvioARWjWNSYXRwgNX3rSQHlbdMkaJM91HdpRD3/ffoSkrM15gGegGU5RDJxVL/ADbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281266; c=relaxed/simple;
	bh=972xAZIjSock1dKzeD2w9Ee1WIBKi3bz+G2MFBf12sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ua42s5Mk2CHljwn0W2hkqj5/l8jKTc/o9vmC21nowwGLy2I5rcvfc/wuJgNL+r86+yI4xRXnGpF+ez5CvlZOtpK7SZeVkAs6x+YXxSeYmN/A4CXQjCRGsPkSR5Kkv1RRW0zSvRkQZNsLCzJUz/+wU+CugX0Zm8YWEAfAZRoqU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W4gX/r4u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974TeO9015709;
	Mon, 7 Oct 2024 06:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TWZ01IZjv9Y8YK5bldQPHn/h7ZKaLj8sn4hpDo+Julg=; b=W4gX/r4uy85QTtQ2
	F3l6GKotNMPDKG5auaRbYc55QqJEg6i73PodVyrh7Sh4btC2tE5qsbj+d9JrZpyI
	P/W6Li/tRtW5KppN+f465A7UMaiojlh+33AqYl1LPgdTSbAGVoDCaaxdHYWe7Z5E
	LqHiWdxYrnFlX+c6GOyzfjdOsIiV4pGs7IN4WGyYkPiXLtUXWgvmvL4IL/T4ajCm
	XJnBZyPhaFLNAOr+cPm9zgk6SAtgXsQH3wg8f2lbDDSQxKybeLJ2cKvfKEDTaTOo
	aPzYvUhRIXDS8fVNfGS9TR2epbQ0VLJ9lhyHN7ZTh18gyoWwZmG0TjE9S7LPDJfO
	WE+MZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs735be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:07:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49767Ues025092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 06:07:30 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 6 Oct 2024 23:07:25 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V3 2/4] firmware: arm_scmi: Skip adding bad duplicates
Date: Mon, 7 Oct 2024 11:36:40 +0530
Message-ID: <20241007060642.1978049-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007060642.1978049-1-quic_sibis@quicinc.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XB2lBeFDyMM-CTx6GtZB-PZ2pNxXn43C
X-Proofpoint-GUID: XB2lBeFDyMM-CTx6GtZB-PZ2pNxXn43C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070041

From: Cristian Marussi <cristian.marussi@arm.com>

Ensure that the bad duplicates reported by the platform firmware
doesn't get added to the opp-tables.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 37 ++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 2d77b5f40ca7..38893cc44423 100644
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
@@ -404,10 +408,13 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 		le16_to_cpu(r->opp[loop_idx].transition_latency_us);
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
 			 opp->perf, dom->info.name, ret);
 
+		return ret;
+	}
+
 	/* Note that PERF v4 reports always five 32-bit words */
 	opp->indicative_freq = le32_to_cpu(r->opp[loop_idx].indicative_freq);
 	if (dom->level_indexing_mode) {
@@ -415,13 +422,21 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 
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
@@ -429,16 +444,20 @@ iter_perf_levels_process_response(const struct scmi_protocol_handle *ph,
 				  const void *response,
 				  struct scmi_iterator_state *st, void *priv)
 {
+	int ret;
 	struct scmi_opp *opp;
 	struct scmi_perf_ipriv *p = priv;
 
 	opp = &p->perf_dom->opp[st->desc_index + st->loop_idx];
 	if (PROTOCOL_REV_MAJOR(p->version) <= 0x3)
-		process_response_opp(ph->dev, p->perf_dom, opp, st->loop_idx,
-				     response);
+		ret = process_response_opp(ph->dev, p->perf_dom, opp, st->loop_idx, response);
 	else
-		process_response_opp_v4(ph->dev, p->perf_dom, opp, st->loop_idx,
-					response);
+		ret = process_response_opp_v4(ph->dev, p->perf_dom, opp, st->loop_idx, response);
+
+	/* Skip BAD duplicates received from firmware */
+	if (ret)
+		return ret == -EBUSY ? 0 : ret;
+
 	p->perf_dom->opp_count++;
 
 	dev_dbg(ph->dev, "Level %d Power %d Latency %dus Ifreq %d Index %d\n",
-- 
2.34.1


