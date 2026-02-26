Return-Path: <linux-pm+bounces-43264-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BOCAZ9XoGkNigQAu9opvQ
	(envelope-from <linux-pm+bounces-43264-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 15:24:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D521A776E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3983310506D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EA3B95F1;
	Thu, 26 Feb 2026 14:19:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27AD3D522A;
	Thu, 26 Feb 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115544; cv=none; b=adFFdVn14R7D9jGtD0dT2eGryEvmOpfrc4yejRtg7QsbVgnJhUk9/0+4j3/wjf/AQiR4M9YS4ZiUWjHzh902skxJ7tETDr/coKxmyrJRS4FTc/1XiF8qPH01/b6LcDy2Iw90uElxHMmxtiQ3umB/5v0OOW+8wLqCqS2Mmj6a2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115544; c=relaxed/simple;
	bh=+XGXQsESB+GlAd9bKgx9d2lbyi/pfENvsagBBgEdo8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KogbVCiPNEp5CKVtpehO7aGJo2Pvf1EtX7454d4FJwEx04q2YDH/nPxtde0gjDQsRQnwG7sDM1KrK7Ivn5MD45234LRhxqRhId1aZNRls+UG0rYLNNgoF9xlJ5ofWdG5SxLxJE/z4TfvkpjcUScG7nrXcp9tdi3SOqRx07dIA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2647415A1;
	Thu, 26 Feb 2026 06:18:56 -0800 (PST)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2973F73B;
	Thu, 26 Feb 2026 06:18:59 -0800 (PST)
From: Philip Radford <philip.radford@arm.com>
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
	Cristian Marussi <cristian.marussi@arm.com>,
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v3 7/9] include: trace: Add new parameter to trace_scmi_fc_call
Date: Thu, 26 Feb 2026 14:18:28 +0000
Message-ID: <20260226141830.3400924-8-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226141830.3400924-1-philip.radford@arm.com>
References: <20260226141830.3400924-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43264-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[arm.com,broadcom.com,gmail.com,linaro.org,st.com,oss.nxp.com,amd.com,quicinc.com,ti.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.914];
	FROM_NEQ_ENVFROM(0.00)[philip.radford@arm.com,linux-pm@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 93D521A776E
X-Rspamd-Action: no action

From: Cristian Marussi <cristian.marussi@arm.com>

Since SCMIv4.0 some of the supported Fastchannels can be configured using
an additional parameter like CPL_ID or Capability_ID.

Add equivalent support in the SCMI fastchannel traces to printout also such
parameter and fix all the existent call sites.

When such parameter is not used, it will simply show up as zero.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/firmware/arm_scmi/perf.c     |  8 ++++----
 drivers/firmware/arm_scmi/powercap.c | 12 +++++++-----
 include/trace/events/scmi.h          | 12 +++++++-----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 7f283f457e02..88d614e3184b 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -552,7 +552,7 @@ static int __scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
 
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_SET,
-				   dom->id, min_perf, max_perf);
+				   dom->id, 0, min_perf, max_perf);
 		iowrite32(max_perf, fci->set_addr);
 		iowrite32(min_perf, fci->set_addr + 4);
 		ph->hops->fastchannel_db_ring(fci->set_db);
@@ -636,7 +636,7 @@ static int __scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 		*max_perf = ioread32(fci->get_addr);
 		*min_perf = ioread32(fci->get_addr + 4);
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_GET,
-				   dom->id, *min_perf, *max_perf);
+				   dom->id, 0, *min_perf, *max_perf);
 		return 0;
 	}
 
@@ -706,7 +706,7 @@ static int __scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
 
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_SET,
-				   dom->id, level, 0);
+				   dom->id, 0, level, 0);
 		iowrite32(level, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
@@ -769,7 +769,7 @@ static int __scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
 		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_GET,
-				   dom->id, *level, 0);
+				   dom->id, 0, *level, 0);
 		return 0;
 	}
 
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index daa7c6d5d485..1087d59ac873 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -597,7 +597,7 @@ static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 	    dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr) {
 		*power_cap = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_GET,
-				   dom->id, *power_cap, 0);
+				   dom->id, cpl_id, *power_cap, 0);
 		return 0;
 	}
 
@@ -730,7 +730,7 @@ static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 		iowrite32(power_cap, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_SET,
-				   domain_id, power_cap, 0);
+				   domain_id, cpl_id, power_cap, 0);
 		ret = 0;
 	} else {
 		ret = pi->xfer_cap_set(ph, pc, cpl_id, power_cap, ignore_dresp);
@@ -835,7 +835,8 @@ static int scmi_powercap_avg_interval_get(const struct scmi_protocol_handle *ph,
 			POWERCAP_PAI_GET : POWERCAP_CAI_GET;
 
 		*val = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_XAI].get_addr);
-		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id, *val, 0);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id,
+				   cpl_id, *val, 0);
 		return 0;
 	}
 
@@ -908,7 +909,8 @@ static int scmi_powercap_avg_interval_set(const struct scmi_protocol_handle *ph,
 			POWERCAP_PAI_SET : POWERCAP_CAI_SET;
 		struct scmi_fc_info *fci = &pc->cpli[cpl_id].fc_info[POWERCAP_FC_XAI];
 
-		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id, ivl, 0);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id,
+				   cpl_id, ivl, 0);
 		iowrite32(ivl, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
@@ -961,7 +963,7 @@ static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
 		/* See SCMIv4.0 3.10.2 - Payload is 32bit ONLY avg_power */
 		*avg_ivl = 0;
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_MEASUREMENTS_GET,
-				   pc->id, *avg_power, *avg_ivl);
+				   pc->id, 0, *avg_power, *avg_ivl);
 		return 0;
 	}
 
diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index 703b7bb68e44..b03da7323d04 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -10,13 +10,14 @@
 #define TRACE_SCMI_MAX_TAG_LEN	6
 
 TRACE_EVENT(scmi_fc_call,
-	TP_PROTO(u8 protocol_id, u8 msg_id, u32 res_id, u32 val1, u32 val2),
-	TP_ARGS(protocol_id, msg_id, res_id, val1, val2),
+	TP_PROTO(u8 protocol_id, u8 msg_id, u32 res_id, u32 sub_id, u32 val1, u32 val2),
+	TP_ARGS(protocol_id, msg_id, res_id, sub_id, val1, val2),
 
 	TP_STRUCT__entry(
 		__field(u8, protocol_id)
 		__field(u8, msg_id)
 		__field(u32, res_id)
+		__field(u32, sub_id)
 		__field(u32, val1)
 		__field(u32, val2)
 	),
@@ -25,13 +26,14 @@ TRACE_EVENT(scmi_fc_call,
 		__entry->protocol_id = protocol_id;
 		__entry->msg_id = msg_id;
 		__entry->res_id = res_id;
+		__entry->sub_id = sub_id;
 		__entry->val1 = val1;
 		__entry->val2 = val2;
 	),
 
-	TP_printk("pt=%02X msg_id=%02X res_id:%u vals=%u:%u",
-		__entry->protocol_id, __entry->msg_id,
-		__entry->res_id, __entry->val1, __entry->val2)
+	TP_printk("pt=%02X msg_id=%02X res_id:%u sub_id:%u vals=%u:%u",
+		  __entry->protocol_id, __entry->msg_id,
+		  __entry->res_id, __entry->sub_id, __entry->val1, __entry->val2)
 );
 
 TRACE_EVENT(scmi_xfer_begin,
-- 
2.47.3


