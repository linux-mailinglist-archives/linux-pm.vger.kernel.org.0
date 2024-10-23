Return-Path: <linux-pm+bounces-16290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739419AC7AF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F871C21D8B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763191A4B69;
	Wed, 23 Oct 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NhQFPsWi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACD1A3A94;
	Wed, 23 Oct 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678949; cv=none; b=VKgR4+nFUbAFtvG6uAaBp4UjHYfxfBlR6HIPNujdfN3Q+4+Ahg2zlqTwWDXuwuGYZEIC3XIhQ1VhIZSvxcLr6JktsPyYjisZ9P3JHuNsX2krlIKY1LNItETtKPhz8LL0Z8jHyyZRKSQ4RD7lag9jQ0SobN42/F7fkpQgBW/71oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678949; c=relaxed/simple;
	bh=5WG+UuLGKP+dHfzYJOmqmvsC7Ikg7gGaaxgZTlEcH70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1Rps6c6aPFBrWZSI2cnTKYcW84vXKpVwiA5nHkJw24xIAyR3rMNTXwC6y8Oz3ctfvaGTFdA5ED2Jsv5/pqIQLUcFqDjBWvGeXRV4KLa2UmWEbodUKwsQXj4Rp3KPRCth0O64dApyLcews+e2p1U/G3IM3LbuWFiFoUCxJkp65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NhQFPsWi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9nORF031140;
	Wed, 23 Oct 2024 10:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/4EI/BDXJEMcfZo0v6z430d9z4NHU6P6zcwIcR64qw=; b=NhQFPsWiuaYyJBUs
	ilhs+jqF7LimSnyzT4t/13HuXAAdt5uxyOxUBtUrMfJcfokDlBubwlfcNxhGP7Iy
	skQ9FSmvy3Xja3NDABpojSaqAmuoWXeMKAya7n5+kozb74MCjb4i8Qw7vdvaelj/
	L+oILLxB10LDVfbuixum+gwMj0Yv5ycvnlDIktpvinQJwgnc9EUQldKewtD4Iq11
	0Zk10+P8Sv0FXVBN2GZSzUE/lq00jfQclyAaLLI0mUkLbEw3mHIid6nSxN3v5C1P
	vJcsmVvvLRdoWlsIshsvRXlOH85YV/eOGaQ+h6X5reqTuLGrfdvEgzctJj+G8yON
	oern1w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3vsu7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:22:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NAMGxN018132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:22:16 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 03:22:11 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V4 2/4] firmware: arm_scmi: Skip opp duplicates
Date: Wed, 23 Oct 2024 15:51:46 +0530
Message-ID: <20241023102148.1698910-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023102148.1698910-1-quic_sibis@quicinc.com>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: IXow5cOgeQhJhFgJW5AvlV08O7-zGwti
X-Proofpoint-ORIG-GUID: IXow5cOgeQhJhFgJW5AvlV08O7-zGwti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230063

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

v3:
* Pick up R-b, T-b from the list.
* Pick up the updated patch from Cristian for skipping opps.

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


