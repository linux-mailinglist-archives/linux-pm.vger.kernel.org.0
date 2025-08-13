Return-Path: <linux-pm+bounces-32271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B38B248CC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF65A2A4F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9B2FE576;
	Wed, 13 Aug 2025 11:47:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4C2F8BDF;
	Wed, 13 Aug 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085635; cv=none; b=cjAGUyWYaZPBUyUgrWTTRlTGjwOoBMv4IZY4fq/CXYk9/QcCNKUwz/h90n8NKxojiMijIxPkVVsCQMvWCl57SyRYwkA7pnihwtFTrLMxxnQLysY4COZdtpWPCI2Cdc8b59fuU+kEB2CAQhl5MiTpXhG+vyeFi/CnBsYgq1zCgTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085635; c=relaxed/simple;
	bh=n26lGeF+gNDVShvhPC7WgMbNieIXI1S8iqj425r7dj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuSGm3CtPQFF/L9NXP8bl5CnzCHnYKRcSZqzoix/kAUXem2HKWJTzwVN7BIB3ZM5I8bE31NcJDmFXKJE3ZCS5EB8bCF2AfHiOyRChA5ypzoWS2QSAEQu/36C37I69Xp09WhHv3SJyo2b/S8tS3mPnL9WnTm77Izz1nmYbdwUjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E582312FC;
	Wed, 13 Aug 2025 04:47:04 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D7963F738;
	Wed, 13 Aug 2025 04:47:10 -0700 (PDT)
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
Subject: [PATCH 7/8] include: trace: Add new parameter to trace_scmi_fc_call
Date: Wed, 13 Aug 2025 12:46:08 +0100
Message-ID: <20250813114609.1305571-8-cristian.marussi@arm.com>
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

Since SCMIv4.0 some of the supported Fastchannels can be configured using
an additional parameter like CPL_ID or Capability_ID.

Add equivalent support in the SCMI fastchannel traces to printout also such
parameter and fix all the existent call sites.

When such parameter is not used, it will simply show up as zero.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c     |  8 ++++----
 drivers/firmware/arm_scmi/powercap.c | 12 +++++++-----
 include/trace/events/scmi.h          | 10 ++++++----
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 99f2c5a510e0..3b7dca4854e4 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -563,7 +563,7 @@ static int __scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
 
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_SET,
-				   dom->id, min_perf, max_perf);
+				   dom->id, 0, min_perf, max_perf);
 		iowrite32(max_perf, fci->set_addr);
 		iowrite32(min_perf, fci->set_addr + 4);
 		ph->hops->fastchannel_db_ring(fci->set_db);
@@ -648,7 +648,7 @@ static int __scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 		*max_perf = ioread32(fci->get_addr);
 		*min_perf = ioread32(fci->get_addr + 4);
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_GET,
-				   dom->id, *min_perf, *max_perf);
+				   dom->id, 0, *min_perf, *max_perf);
 		return 0;
 	}
 
@@ -718,7 +718,7 @@ static int __scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
 
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_SET,
-				   dom->id, level, 0);
+				   dom->id, 0, level, 0);
 		iowrite32(level, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
@@ -781,7 +781,7 @@ static int __scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
 		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_GET,
-				   dom->id, *level, 0);
+				   dom->id, 0, *level, 0);
 		return 0;
 	}
 
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 350dd1f135ca..a8b442e9b818 100644
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
index 703b7bb68e44..8be1e3837386 100644
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
+	TP_printk("pt=%02X msg_id=%02X res_id:%u sub_id:%u vals=%u:%u",
 		__entry->protocol_id, __entry->msg_id,
-		__entry->res_id, __entry->val1, __entry->val2)
+		__entry->res_id, __entry->sub_id, __entry->val1, __entry->val2)
 );
 
 TRACE_EVENT(scmi_xfer_begin,
-- 
2.47.0


