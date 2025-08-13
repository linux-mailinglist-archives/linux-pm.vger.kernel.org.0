Return-Path: <linux-pm+bounces-32266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA529B248C0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AC41B688A0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246472F83DC;
	Wed, 13 Aug 2025 11:46:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994A2F8BF1;
	Wed, 13 Aug 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085618; cv=none; b=rpi/vU9Ors0ojSyI65mQQi9ySjPXsjueAz9lLNURV+FD4eU+D5nVKsipH1BGDVp2NqGqtMIj3PmN6BPu2pSNO0xgrWw8KHugN2dkWaR7LfvlSpMBM+wNqBjr4OXQ3rLzy1tbhQQY1RiXCk9ir8sAM80n9nlcvOabGMlT8deDFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085618; c=relaxed/simple;
	bh=rSDhbPCYCQieQ0JuN/q1+tteGDZ/6WTrLwR6S4W/iCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm0WpWWaGyhMWROH73fUnstNkf4hIs1U1cyAckgvOTVC8rSQuwa77gf5ztwCfio4udWjlbKhtDKuvccWroJ15SLRuPCYmAgpF4VhyUFiA5cEPOXMO2oMdxwY8xg6/MpEJYgzAIAIebVEFPT7W8QoH6TAhoCaGKmEL0uBpvJC/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF4AC12FC;
	Wed, 13 Aug 2025 04:46:47 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1333F738;
	Wed, 13 Aug 2025 04:46:52 -0700 (PDT)
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
Subject: [PATCH 2/8] firmware: arm_scmi: Add bound iterators support
Date: Wed, 13 Aug 2025 12:46:03 +0100
Message-ID: <20250813114609.1305571-3-cristian.marussi@arm.com>
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

SCMI core stack provides some common helpers to handle in a unified way
multipart message replies: such iterator-helpers, when run, currently
process by default the whole set of available resources.

Introduce an alternative way to run the initialized iterator on a limited
range of resources.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 21 +++++++++++++++++++--
 drivers/firmware/arm_scmi/protocols.h |  6 ++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 65bd545c0cb1..62f9cdd508c3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1832,7 +1832,8 @@ static void *scmi_iterator_init(const struct scmi_protocol_handle *ph,
 	return i;
 }
 
-static int scmi_iterator_run(void *iter)
+static int __scmi_iterator_run(void *iter, unsigned int *start,
+			       unsigned int *end)
 {
 	int ret = -EINVAL;
 	struct scmi_iterator_ops *iops;
@@ -1847,6 +1848,9 @@ static int scmi_iterator_run(void *iter)
 	ph = i->ph;
 	st = &i->state;
 
+	if (start)
+		st->desc_index = *start;
+
 	do {
 		iops->prepare_message(i->msg, st->desc_index, i->priv);
 		ret = ph->xops->do_xfer(ph, i->t);
@@ -1879,7 +1883,8 @@ static int scmi_iterator_run(void *iter)
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
 		 */
-	} while (st->num_returned && st->num_remaining);
+	} while (st->num_returned && st->num_remaining &&
+		 (!end || (st->desc_index <= min(*end, st->max_resources - 1))));
 
 out:
 	/* Finalize and destroy iterator */
@@ -1889,6 +1894,17 @@ static int scmi_iterator_run(void *iter)
 	return ret;
 }
 
+static int scmi_iterator_run(void *iter)
+{
+	return __scmi_iterator_run(iter, NULL, NULL);
+}
+
+static int scmi_iterator_run_bound(void *iter, unsigned int *start,
+				   unsigned int *end)
+{
+	return __scmi_iterator_run(iter, start, end);
+}
+
 struct scmi_msg_get_fc_info {
 	__le32 domain;
 	__le32 message_id;
@@ -2075,6 +2091,7 @@ static const struct scmi_proto_helpers_ops helpers_ops = {
 	.get_max_msg_size = scmi_common_get_max_msg_size,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
+	.iter_response_run_bound = scmi_iterator_run_bound,
 	.protocol_msg_check = scmi_protocol_msg_check,
 	.fastchannel_init = scmi_common_fastchannel_init,
 	.fastchannel_db_ring = scmi_common_fastchannel_db_ring,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 8a96b78331f2..a48e212ac0e1 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -257,6 +257,10 @@ struct scmi_fc_info {
  *			provided in @ops.
  * @iter_response_run: A common helper to trigger the run of a previously
  *		       initialized iterator.
+ * @iter_response_run_bound: A common helper to trigger the run of a previously
+ *			     initialized iterator, but only within the
+ *			     specified, optional, @start and @end resource
+ *			     indexes.
  * @protocol_msg_check: A common helper to check is a specific protocol message
  *			is supported.
  * @fastchannel_init: A common helper used to initialize FC descriptors by
@@ -273,6 +277,8 @@ struct scmi_proto_helpers_ops {
 				    unsigned int max_resources, u8 msg_id,
 				    size_t tx_size, void *priv);
 	int (*iter_response_run)(void *iter);
+	int (*iter_response_run_bound)(void *iter,
+				       unsigned int *start, unsigned int *end);
 	int (*protocol_msg_check)(const struct scmi_protocol_handle *ph,
 				  u32 message_id, u32 *attributes);
 	void (*fastchannel_init)(const struct scmi_protocol_handle *ph,
-- 
2.47.0


