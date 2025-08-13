Return-Path: <linux-pm+bounces-32269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00BFB248C6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9372E1B687D0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B3B2FAC08;
	Wed, 13 Aug 2025 11:47:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E31E2FA0F7;
	Wed, 13 Aug 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085629; cv=none; b=cw6wEzraRm6d+Q/qt8gC4oa3nnncK2Jq2u/tzJudQ4LhsrOJOlDAOoZpPwOEjboJKydBmNS2xYK9AibAibxciAgwqUDf0sCsluXcvqM0VbsFPXaU5w2LR9N1RmZ40TiVHGIB4vsNnzgPXXESQXcB1beV1rRDJd7MVAihpyFqU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085629; c=relaxed/simple;
	bh=bvnKDNbjHzm0RAm4aMYbZJw7ZMebP6ih6X8Xm65vBt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aigHTmvF4XVPbXhYpsE8qH2ItNeXiJDwALTnJPXZZbOv3Fm8TPt9q6yzGJXdAFbomaGjvR8Vi7a0YlARx+nvrwMu7wHl7NHXJvnncbvUyS/whmaQSqdZqre06QkmQBc7alOWcXR7VSCvmh8rAsE4dEq/bL4luo51xxWJ77QvgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F81312FC;
	Wed, 13 Aug 2025 04:46:58 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FC343F738;
	Wed, 13 Aug 2025 04:47:03 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 5/8] firmware: arm_scmi: Add SCMIv4.0 Powercap FCs support
Date: Wed, 13 Aug 2025 12:46:06 +0100
Message-ID: <20250813114609.1305571-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250813114609.1305571-1-cristian.marussi@arm.com>
References: <20250813114609.1305571-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for new SCMIv4.0 Powercap Fastchannels.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 327 ++++++++++++++++++---------
 1 file changed, 224 insertions(+), 103 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 37fe3bd0c099..1c4b79249c40 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -27,19 +27,25 @@ enum scmi_powercap_protocol_cmd {
 	POWERCAP_CAP_GET = 0x4,
 	POWERCAP_CAP_SET = 0x5,
 	POWERCAP_PAI_GET = 0x6,
+	POWERCAP_MAI_GET = POWERCAP_PAI_GET,
 	POWERCAP_PAI_SET = 0x7,
+	POWERCAP_MAI_SET = POWERCAP_PAI_SET,
 	POWERCAP_DOMAIN_NAME_GET = 0x8,
 	POWERCAP_MEASUREMENTS_GET = 0x9,
 	POWERCAP_CAP_NOTIFY = 0xa,
 	POWERCAP_MEASUREMENTS_NOTIFY = 0xb,
 	POWERCAP_DESCRIBE_FASTCHANNEL = 0xc,
 	POWERCAP_CPC_ATTRIBUTES = 0xd,
+	POWERCAP_CAI_GET = 0xe,
+	POWERCAP_CAI_SET = 0xf,
 };
 
 enum {
 	POWERCAP_FC_CAP,
-	POWERCAP_FC_PAI,
-	POWERCAP_FC_MAX,
+	POWERCAP_FC_XAI,
+	POWERCAP_FC_MAI,
+	POWERCAP_FC_MEASUREMENT,
+	POWERCAP_FC_MAX
 };
 
 struct scmi_msg_resp_powercap_domain_attributes {
@@ -91,12 +97,12 @@ struct scmi_msg_resp_powercap_domain_attributes_v3 {
 	__le32 cai_step;
 };
 
-struct scmi_msg_powercap_get_v3 {
+struct scmi_msg_powercap_cap_or_cai_get_v3 {
 	__le32 domain_id;
 	__le32 cpli;
 };
 
-struct scmi_msg_powercap_set_cap_or_pai {
+struct scmi_msg_powercap_cap_or_pai_set {
 	__le32 domain_id;
 	__le32 flags;
 #define CAP_SET_ASYNC		BIT(1)
@@ -104,13 +110,20 @@ struct scmi_msg_powercap_set_cap_or_pai {
 	__le32 value;
 };
 
-struct scmi_msg_powercap_set_cap_v3 {
+struct scmi_msg_powercap_cap_set_v3 {
 	__le32 domain_id;
 	__le32 cpli;
 	__le32 flags;
 	__le32 power_cap;
 };
 
+struct scmi_msg_powercap_cai_set {
+	__le32 domain_id;
+	__le32 flags;
+	__le32 cai;
+	__le32 cpli;
+};
+
 struct scmi_msg_resp_powercap_cap_set_complete {
 	__le32 domain_id;
 	__le32 power_cap;
@@ -202,6 +215,10 @@ struct powercap_info {
 	int (*xfer_cap_set)(const struct scmi_protocol_handle *ph,
 			    const struct scmi_powercap_info *pc,
 			    u32 cpl_id, u32 power_cap, bool ignore_dresp);
+	int (*xfer_avg_ivl_get)(const struct scmi_protocol_handle *ph,
+				u32 domain_id, u32 cpl_id, u32 *ivl);
+	int (*xfer_avg_ivl_set)(const struct scmi_protocol_handle *ph,
+				u32 domain_id, u32 cpl_id, u32 ivl);
 };
 
 static enum scmi_powercap_protocol_cmd evt_2_cmd[] = {
@@ -503,17 +520,6 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int
-scmi_powercap_domain_initialize(const struct scmi_protocol_handle *ph,
-				struct powercap_info *pinfo, u32 domain)
-{
-	struct scmi_powercap_info *dom_info = pinfo->powercaps + domain;
-
-	dom_info->id = domain;
-
-	return scmi_powercap_domain_attributes_get(ph, pinfo, dom_info);
-}
-
 static int scmi_powercap_num_domains_get(const struct scmi_protocol_handle *ph)
 {
 	struct powercap_info *pi = ph->get_priv(ph);
@@ -560,7 +566,7 @@ static int scmi_powercap_xfer_cap_get_v3(const struct scmi_protocol_handle *ph,
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct scmi_msg_powercap_get_v3 *msg;
+	struct scmi_msg_powercap_cap_or_cai_get_v3 *msg;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_GET, sizeof(*msg),
 				      sizeof(u32), &t);
@@ -619,7 +625,7 @@ static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct scmi_msg_powercap_set_cap_or_pai *msg;
+	struct scmi_msg_powercap_cap_or_pai_set *msg;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_SET,
 				      sizeof(*msg), 0, &t);
@@ -662,7 +668,7 @@ static int scmi_powercap_xfer_cap_set_v3(const struct scmi_protocol_handle *ph,
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct scmi_msg_powercap_set_cap_v3 *msg;
+	struct scmi_msg_powercap_cap_set_v3 *msg;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_SET,
 				      sizeof(*msg), 0, &t);
@@ -761,8 +767,9 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 				       power_cap, ignore_dresp);
 }
 
-static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
-				      u32 domain_id, u32 *pai)
+static int
+scmi_powercap_xfer_avg_interval_get(const struct scmi_protocol_handle *ph,
+				    u32 domain_id, u32 cpl_id, u32 *ivl)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -775,58 +782,105 @@ static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
 	put_unaligned_le32(domain_id, t->tx.buf);
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
-		*pai = get_unaligned_le32(t->rx.buf);
+		*ivl = get_unaligned_le32(t->rx.buf);
 
 	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
 
-static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 cpl_id, u32 *pai)
+static int
+scmi_powercap_xfer_avg_interval_get_v3(const struct scmi_protocol_handle *ph,
+				       u32 domain_id, u32 cpl_id, u32 *ivl)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_powercap_cap_or_cai_get_v3 *msg;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAI_GET, sizeof(*msg),
+				      sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->domain_id = cpu_to_le32(domain_id);
+	msg->cpli = cpu_to_le32(cpl_id);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*ivl = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_powercap_avg_interval_get(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 cpl_id, u32 *val)
 {
 	struct scmi_powercap_info *dom;
 	struct powercap_info *pi = ph->get_priv(ph);
 
-	if (!pai || domain_id >= pi->num_domains)
+	if (!val || domain_id >= pi->num_domains)
 		return -EINVAL;
 
 	dom = pi->powercaps + domain_id;
-	if (cpl_id > dom->num_cpli)
+	if (cpl_id >= dom->num_cpli)
 		return -EINVAL;
 
-	if (dom->cpli[cpl_id].fc_info && dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr) {
-		*pai = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr);
-		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_GET,
-				   domain_id, *pai, 0);
+	if (dom->cpli[cpl_id].fc_info &&
+	    dom->cpli[cpl_id].fc_info[POWERCAP_FC_XAI].get_addr) {
+		int trace_cmd = (PROTOCOL_REV_MAJOR(pi->version) < 0x3) ?
+			POWERCAP_PAI_GET : POWERCAP_CAI_GET;
+
+		*val = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_XAI].get_addr);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id, *val, 0);
 		return 0;
 	}
 
-	return scmi_powercap_xfer_pai_get(ph, domain_id, pai);
+	return pi->xfer_avg_ivl_get(ph, domain_id, cpl_id, val);
 }
 
-static int scmi_powercap_avg_interval_get(const struct scmi_protocol_handle *ph,
-					  u32 domain_id, u32 cpl_id, u32 *val)
+static int
+scmi_powercap_xfer_avg_interval_set(const struct scmi_protocol_handle *ph,
+				    u32 domain_id, u32 cpl_id, u32 ivl)
 {
-	return scmi_powercap_pai_get(ph, domain_id, cpl_id, val);
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_powercap_cap_or_pai_set *msg;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_PAI_SET, sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->domain_id = cpu_to_le32(domain_id);
+	msg->flags = cpu_to_le32(0);
+	msg->value = cpu_to_le32(ivl);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
 }
 
-static int scmi_powercap_xfer_pai_set(const struct scmi_protocol_handle *ph,
-				      u32 domain_id, u32 pai)
+static int
+scmi_powercap_xfer_avg_interval_set_v3(const struct scmi_protocol_handle *ph,
+				       u32 domain_id, u32 cpl_id, u32 ivl)
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct scmi_msg_powercap_set_cap_or_pai *msg;
+	struct scmi_msg_powercap_cai_set *msg;
 
-	ret = ph->xops->xfer_get_init(ph, POWERCAP_PAI_SET,
-				      sizeof(*msg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAI_SET, sizeof(*msg), 0, &t);
 	if (ret)
 		return ret;
 
 	msg = t->tx.buf;
 	msg->domain_id = cpu_to_le32(domain_id);
 	msg->flags = cpu_to_le32(0);
-	msg->value = cpu_to_le32(pai);
+	msg->cai = cpu_to_le32(ivl);
+	msg->cpli = cpu_to_le32(cpl_id);
 
 	ret = ph->xops->do_xfer(ph, t);
 
@@ -834,48 +888,42 @@ static int scmi_powercap_xfer_pai_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 cpl_id, u32 pai)
+static int scmi_powercap_avg_interval_set(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 cpl_id, u32 ivl)
 {
 	const struct scmi_powercap_info *pc;
+	struct powercap_info *pi = ph->get_priv(ph);
 
 	pc = scmi_powercap_dom_info_get(ph, domain_id);
 	if (!pc || cpl_id >= pc->num_cpli || !pc->cpli[cpl_id].avg_ivl_config ||
-	    !pai || pai < pc->cpli[cpl_id].min_avg_ivl ||
-	    pai > pc->cpli[cpl_id].max_avg_ivl)
+	    !ivl || ivl < pc->cpli[cpl_id].min_avg_ivl ||
+	    ivl > pc->cpli[cpl_id].max_avg_ivl)
 		return -EINVAL;
 
-	if (pc->cpli[cpl_id].fc_info && pc->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].set_addr) {
-		struct scmi_fc_info *fci = &pc->cpli[cpl_id].fc_info[POWERCAP_FC_PAI];
+	/* Note that fc_info descriptors for any unsupported FC will be NULL */
+	if (pc->cpli[cpl_id].fc_info &&
+	    pc->cpli[cpl_id].fc_info[POWERCAP_FC_XAI].set_addr) {
+		int trace_cmd = (PROTOCOL_REV_MAJOR(pi->version) < 0x3) ?
+			POWERCAP_PAI_SET : POWERCAP_CAI_SET;
+		struct scmi_fc_info *fci = &pc->cpli[cpl_id].fc_info[POWERCAP_FC_XAI];
 
-		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_SET,
-				   domain_id, pai, 0);
-		iowrite32(pai, fci->set_addr);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id, ivl, 0);
+		iowrite32(ivl, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
 	}
 
-	return scmi_powercap_xfer_pai_set(ph, domain_id, pai);
+	return pi->xfer_avg_ivl_set(ph, domain_id, cpl_id, ivl);
 }
 
-static int scmi_powercap_avg_interval_set(const struct scmi_protocol_handle *ph,
-					  u32 domain_id, u32 cpl_id, u32 val)
-{
-	return scmi_powercap_pai_set(ph, domain_id, cpl_id, val);
-}
-
-static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
-					  u32 domain_id, u32 *average_power,
-					  u32 *pai)
+static int
+scmi_powercap_xfer_measurements_get(const struct scmi_protocol_handle *ph,
+				    const struct scmi_powercap_info *pc,
+				    u32 *avg_power, u32 *avg_ivl)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_powercap_meas_get *resp;
-	const struct scmi_powercap_info *pc;
-
-	pc = scmi_powercap_dom_info_get(ph, domain_id);
-	if (!pc || !pc->powercap_monitoring || !pai || !average_power)
-		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_MEASUREMENTS_GET,
 				      sizeof(u32), sizeof(*resp), &t);
@@ -883,17 +931,42 @@ static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
 		return ret;
 
 	resp = t->rx.buf;
-	put_unaligned_le32(domain_id, t->tx.buf);
+	put_unaligned_le32(pc->id, t->tx.buf);
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		*average_power = le32_to_cpu(resp->power);
-		*pai = le32_to_cpu(resp->pai);
+		*avg_power = le32_to_cpu(resp->power);
+		*avg_ivl = le32_to_cpu(resp->pai);
 	}
 
 	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
+static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 *avg_power,
+					  u32 *avg_ivl)
+{
+	const struct scmi_powercap_info *pc;
+	struct scmi_fc_info *fci;
+
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc || !pc->powercap_monitoring || !avg_ivl || !avg_power)
+		return -EINVAL;
+
+	/* Note that fc_info descriptors for any unsupported FC will be NULL */
+	fci = pc->cpli[CPL0].fc_info;
+	if (fci && fci[POWERCAP_FC_MEASUREMENT].get_addr) {
+		*avg_power = ioread32(fci[POWERCAP_FC_MEASUREMENT].get_addr);
+		/* See SCMIv4.0 3.10.2 - Payload is 32bit ONLY avg_power */
+		*avg_ivl = 0;
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_MEASUREMENTS_GET,
+				   pc->id, *avg_power, *avg_ivl);
+		return 0;
+	}
+
+	return scmi_powercap_xfer_measurements_get(ph, pc, avg_power, avg_ivl);
+}
+
 static int
 scmi_powercap_measurements_threshold_get(const struct scmi_protocol_handle *ph,
 					 u32 domain_id, u32 *power_thresh_low,
@@ -1021,37 +1094,79 @@ static const struct scmi_powercap_proto_ops powercap_proto_ops = {
 };
 
 static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
-					 u32 domain, struct scmi_fc_info **p_fc)
+					 struct scmi_powercap_info *dom_info)
 {
-	struct scmi_fc_info *fc;
-
-	fc = devm_kcalloc(ph->dev, POWERCAP_FC_MAX, sizeof(*fc), GFP_KERNEL);
-	if (!fc)
-		return;
-
-	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_CAP_SET, 4, domain, NULL,
-				   &fc[POWERCAP_FC_CAP].set_addr,
-				   &fc[POWERCAP_FC_CAP].set_db,
-				   &fc[POWERCAP_FC_CAP].rate_limit);
-
-	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_CAP_GET, 4, domain, NULL,
-				   &fc[POWERCAP_FC_CAP].get_addr, NULL,
-				   &fc[POWERCAP_FC_CAP].rate_limit);
-
-	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_PAI_SET, 4, domain, NULL,
-				   &fc[POWERCAP_FC_PAI].set_addr,
-				   &fc[POWERCAP_FC_PAI].set_db,
-				   &fc[POWERCAP_FC_PAI].rate_limit);
-
-	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_PAI_GET, 4, domain, NULL,
-				   &fc[POWERCAP_FC_PAI].get_addr, NULL,
-				   &fc[POWERCAP_FC_PAI].rate_limit);
-
-	*p_fc = fc;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	for (int id = 0; id < dom_info->num_cpli; id++) {
+		struct scmi_fc_info *fc;
+		u32 *cpl_id, zero_cpl_id = 0;
+
+		fc = devm_kcalloc(ph->dev, POWERCAP_FC_MAX, sizeof(*fc), GFP_KERNEL);
+		if (!fc)
+			return;
+
+		/* NOTE THAT when num_cpli == 1 the arg *cpl_id is 0 */
+		cpl_id = (PROTOCOL_REV_MAJOR(pi->version) >= 0x3) ? &id : NULL;
+
+		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+					   POWERCAP_CAP_SET, 4, dom_info->id,
+					   cpl_id,
+					   &fc[POWERCAP_FC_CAP].set_addr,
+					   &fc[POWERCAP_FC_CAP].set_db,
+					   &fc[POWERCAP_FC_CAP].rate_limit);
+
+		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+					   POWERCAP_CAP_GET, 4, dom_info->id,
+					   cpl_id,
+					   &fc[POWERCAP_FC_CAP].get_addr, NULL,
+					   &fc[POWERCAP_FC_CAP].rate_limit);
+
+		if (PROTOCOL_REV_MAJOR(pi->version) < 0x3) {
+			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+						   POWERCAP_PAI_SET, 4,
+						   dom_info->id, NULL,
+						   &fc[POWERCAP_FC_XAI].set_addr,
+						   &fc[POWERCAP_FC_XAI].set_db,
+						   &fc[POWERCAP_FC_XAI].rate_limit);
+
+			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+						   POWERCAP_PAI_GET, 4,
+						   dom_info->id, NULL,
+						   &fc[POWERCAP_FC_XAI].get_addr, NULL,
+						   &fc[POWERCAP_FC_XAI].rate_limit);
+		} else {
+			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+						   POWERCAP_CAI_SET, 4,
+						   dom_info->id, &id,
+						   &fc[POWERCAP_FC_XAI].set_addr,
+						   &fc[POWERCAP_FC_XAI].set_db,
+						   &fc[POWERCAP_FC_XAI].rate_limit);
+			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+						   POWERCAP_CAI_GET, 4,
+						   dom_info->id, &id,
+						   &fc[POWERCAP_FC_XAI].get_addr, NULL,
+						   &fc[POWERCAP_FC_XAI].rate_limit);
+			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+						   POWERCAP_MAI_SET, 4,
+						   dom_info->id, &zero_cpl_id,
+						   &fc[POWERCAP_FC_MAI].set_addr,
+						   &fc[POWERCAP_FC_MAI].set_db,
+						   &fc[POWERCAP_FC_MAI].rate_limit);
+			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+						   POWERCAP_MAI_GET, 4,
+						   dom_info->id, &zero_cpl_id,
+						   &fc[POWERCAP_FC_MAI].get_addr, NULL,
+						   &fc[POWERCAP_FC_MAI].rate_limit);
+			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+						   POWERCAP_MEASUREMENTS_GET, 4,
+						   dom_info->id, &zero_cpl_id,
+						   &fc[POWERCAP_FC_MEASUREMENT].get_addr, NULL,
+						   &fc[POWERCAP_FC_MEASUREMENT].rate_limit);
+		}
+
+		dom_info->cpli[id].fc_info = fc;
+	}
 }
 
 static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
@@ -1294,9 +1409,14 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 	if (PROTOCOL_REV_MAJOR(version) < 0x3) {
 		pinfo->xfer_cap_get = scmi_powercap_xfer_cap_get;
 		pinfo->xfer_cap_set = scmi_powercap_xfer_cap_set;
+		pinfo->xfer_avg_ivl_get = scmi_powercap_xfer_avg_interval_get;
+		pinfo->xfer_avg_ivl_set = scmi_powercap_xfer_avg_interval_set;
+
 	} else {
 		pinfo->xfer_cap_get = scmi_powercap_xfer_cap_get_v3;
 		pinfo->xfer_cap_set = scmi_powercap_xfer_cap_set_v3;
+		pinfo->xfer_avg_ivl_get = scmi_powercap_xfer_avg_interval_get_v3;
+		pinfo->xfer_avg_ivl_set = scmi_powercap_xfer_avg_interval_set_v3;
 	}
 
 	ret = scmi_powercap_attributes_get(ph, pinfo);
@@ -1321,18 +1441,19 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 	 * formed and correlated by sane parent-child relationship (if any).
 	 */
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
-		ret = scmi_powercap_domain_initialize(ph, pinfo, domain);
+		struct scmi_powercap_info *dom_info = pinfo->powercaps + domain;
+
+		dom_info->id = domain;
+		ret = scmi_powercap_domain_attributes_get(ph, pinfo, dom_info);
 		if (ret)
 			return ret;
 
-		if (pinfo->powercaps[domain].fastchannels)
-			scmi_powercap_domain_init_fc(ph, domain,
-						     &pinfo->powercaps[domain].cpli[CPL0].fc_info);
+		if (dom_info->fastchannels)
+			scmi_powercap_domain_init_fc(ph, dom_info);
 
 		/* Grab initial state when disable is supported. */
 		if (PROTOCOL_REV_MAJOR(version) >= 0x2) {
-			ret = __scmi_powercap_cap_get(ph,
-						      &pinfo->powercaps[domain], CPL0,
+			ret = __scmi_powercap_cap_get(ph, dom_info, CPL0,
 						      &pinfo->states[domain].last_pcap);
 			if (ret)
 				return ret;
-- 
2.47.0


