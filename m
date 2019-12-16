Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7611FE5E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 07:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfLPGEU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 01:04:20 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:35130 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfLPGET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 01:04:19 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 01:04:05 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576476258; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=SnPYJL2+j5iU5W45sNyuES2ko4Aqxax6J62193hlbFU=; b=nb9zF1wMio1w2S4uExd6HRm2CHWsDWHCllyLONLiXDmKErKel3wSZFIc8nqn/IE1CrE9QYO6
 j5t0YhD62v7U5jEh7/2YZFuVPeHXIV2vpiW+lPJk2i89AjlpDW/Sekoc7qymxqrFWG/E84/z
 AhVvp0hHuCBuIxEaoHWLwiV+eno=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df71d2b.7f511c7dbf10-smtp-out-n03;
 Mon, 16 Dec 2019 05:59:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98FF9C4479F; Mon, 16 Dec 2019 05:59:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D45CC433CB;
        Mon, 16 Dec 2019 05:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D45CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 2/4] interconnect: qcom: Consolidate interconnect RPMh support
Date:   Sun, 15 Dec 2019 21:58:43 -0800
Message-Id: <1576475925-20601-3-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
References: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bcm voter driver and add support for RPMh specific interconnect providers
which implements the set and aggregate functionalities that translates
bandwidth requests into RPMh messages. These modules provide a common set of
functionalities for all Qualcomm RPMh based interconnect providers and
should help reduce code duplication when adding new providers.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/Kconfig     |   8 +
 drivers/interconnect/qcom/Makefile    |   6 +
 drivers/interconnect/qcom/bcm-voter.c | 356 ++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/bcm-voter.h |  28 +++
 drivers/interconnect/qcom/icc-rpmh.c  | 158 +++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h  | 150 ++++++++++++++
 6 files changed, 706 insertions(+)
 create mode 100644 drivers/interconnect/qcom/bcm-voter.c
 create mode 100644 drivers/interconnect/qcom/bcm-voter.h
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.c
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 2f9304d..e5af199 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -27,9 +27,17 @@ config INTERCONNECT_QCOM_SDM845
 	tristate "Qualcomm SDM845 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
 	  platforms.
 
+config INTERCONNECT_QCOM_BCM_VOTER
+	tristate
+
+config INTERCONNECT_QCOM_RPMH
+	tristate
+
 config INTERCONNECT_QCOM_SMD_RPM
 	tristate
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 9adf9e3..e921b13 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,8 +4,14 @@ qnoc-msm8974-objs			:= msm8974.o
 qnoc-qcs404-objs			:= qcs404.o
 qnoc-sdm845-objs			:= sdm845.o
 icc-smd-rpm-objs			:= smd-rpm.o
+icc-bcm-voter-objs			:= bcm-voter.o
+icc-rpmh-obj				:= icc-rpmh.o
+icc-smd-rpm-objs			:= smd-rpm.o
 
+obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
+obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
new file mode 100644
index 0000000..7a8764e
--- /dev/null
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ *
+ */
+#include <linux/interconnect-provider.h>
+#include <linux/list_sort.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <soc/qcom/rpmh.h>
+#include <soc/qcom/tcs.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+
+static LIST_HEAD(bcm_voters);
+
+/**
+ * struct bcm_voter - Bus Clock Manager voter
+ * @dev: reference to the device that communicates with the BCM
+ * @np: reference to the device node to match bcm voters
+ * @lock: mutex to protect commit and wake/sleep lists in the voter
+ * @commit_list: list containing bcms to be committed to hardware
+ * @ws_list: list containing bcms that have different wake/sleep votes
+ * @voter_node: list of bcm voters
+ */
+struct bcm_voter {
+	struct device *dev;
+	struct device_node *np;
+	struct mutex lock;
+	struct list_head commit_list;
+	struct list_head ws_list;
+	struct list_head voter_node;
+};
+
+static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
+{
+	const struct qcom_icc_bcm *bcm_a =
+			list_entry(a, struct qcom_icc_bcm, list);
+	const struct qcom_icc_bcm *bcm_b =
+			list_entry(b, struct qcom_icc_bcm, list);
+
+	if (bcm_a->aux_data.vcd < bcm_b->aux_data.vcd)
+		return -1;
+	else if (bcm_a->aux_data.vcd == bcm_b->aux_data.vcd)
+		return 0;
+	else
+		return 1;
+}
+
+static void bcm_aggregate(struct qcom_icc_bcm *bcm)
+{
+	size_t i, bucket;
+	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
+	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
+	u64 temp;
+
+	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
+		for (i = 0; i < bcm->num_nodes; i++) {
+			temp = bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			agg_avg[bucket] = max(agg_avg[bucket], temp);
+
+			temp = bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth);
+			agg_peak[bucket] = max(agg_peak[bucket], temp);
+		}
+
+		temp = agg_avg[bucket] * 1000ULL;
+		do_div(temp, bcm->aux_data.unit);
+		bcm->vote_x[bucket] = temp;
+
+		temp = agg_peak[bucket] * 1000ULL;
+		do_div(temp, bcm->aux_data.unit);
+		bcm->vote_y[bucket] = temp;
+	}
+
+	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
+	    bcm->vote_y[QCOM_ICC_BUCKET_AMC] == 0) {
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
+	}
+}
+
+static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
+			u32 addr, bool commit)
+{
+	bool valid = true;
+
+	if (!cmd)
+		return;
+
+	if (vote_x == 0 && vote_y == 0)
+		valid = false;
+
+	if (vote_x > BCM_TCS_CMD_VOTE_MASK)
+		vote_x = BCM_TCS_CMD_VOTE_MASK;
+
+	if (vote_y > BCM_TCS_CMD_VOTE_MASK)
+		vote_y = BCM_TCS_CMD_VOTE_MASK;
+
+	cmd->addr = addr;
+	cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
+
+	/*
+	 * Set the wait for completion flag on command that need to be completed
+	 * before the next command.
+	 */
+	if (commit)
+		cmd->wait = true;
+}
+
+static void tcs_list_gen(struct list_head *bcm_list, int bucket,
+			 struct tcs_cmd tcs_list[MAX_VCD],
+			 int n[MAX_VCD])
+{
+	struct qcom_icc_bcm *bcm;
+	bool commit;
+	size_t idx = 0, batch = 0, cur_vcd_size = 0;
+
+	memset(n, 0, sizeof(int) * MAX_VCD);
+
+	list_for_each_entry(bcm, bcm_list, list) {
+		commit = false;
+		cur_vcd_size++;
+		if ((list_is_last(&bcm->list, bcm_list)) ||
+		    bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
+			commit = true;
+			cur_vcd_size = 0;
+		}
+		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
+			    bcm->vote_y[bucket], bcm->addr, commit);
+		idx++;
+		n[batch]++;
+		/*
+		 * Batch the BCMs in such a way that we do not split them in
+		 * multiple payloads when they are under the same VCD. This is
+		 * to ensure that every BCM is committed since we only set the
+		 * commit bit on the last BCM request of every VCD.
+		 */
+		if (n[batch] >= MAX_RPMH_PAYLOAD) {
+			if (!commit) {
+				n[batch] = cur_vcd_size;
+				n[batch + 1] = cur_vcd_size;
+			}
+			batch++;
+		}
+	}
+}
+
+/**
+ * of_bcm_voter_get - gets a bcm voter handle from DT node
+ * @dev: device pointer for the consumer device
+ * @name: name for the bcm voter device
+ *
+ * This function will match a device_node pointer for the phandle
+ * specified in the device DT and return a bcm_voter handle on success.
+ *
+ * Returns bcm_voter pointer or ERR_PTR() on error. EPROBE_DEFER is returned
+ * when matching bcm voter is yet to be found.
+ */
+struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name)
+{
+	struct bcm_voter *voter = ERR_PTR(-EPROBE_DEFER);
+	struct bcm_voter *temp;
+	struct device_node *np, *node;
+	int idx = 0;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	np = dev->of_node;
+
+	if (name) {
+		idx = of_property_match_string(np, "qcom,bcm-voter-names", name);
+		if (idx < 0)
+			return ERR_PTR(idx);
+	}
+
+	node = of_parse_phandle(np, "qcom,bcm-voters", idx);
+
+	list_for_each_entry(temp, &bcm_voters, voter_node) {
+		if (temp->np == node) {
+			voter = temp;
+			break;
+		}
+	}
+
+	return voter;
+}
+EXPORT_SYMBOL_GPL(of_bcm_voter_get);
+
+/**
+ * qcom_icc_bcm_voter_add - queues up the bcm nodes that require updates
+ * @voter: voter that the bcms are being added to
+ * @bcm: bcm to add to the commit and wake sleep list
+ */
+void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm)
+{
+	if (!voter)
+		return;
+
+	mutex_lock(&voter->lock);
+	list_add_tail(&bcm->list, &voter->commit_list);
+
+	if (list_empty(&bcm->ws_list))
+		list_add_tail(&bcm->ws_list, &voter->ws_list);
+
+	mutex_unlock(&voter->lock);
+}
+EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_add);
+
+/**
+ * qcom_icc_bcm_voter_commit - generates and commits tcs cmds based on bcms
+ * @voter: voter that needs flushing
+ *
+ * This function generates a set of AMC commands and flushes to the BCM device
+ * associated with the voter. It conditionally generate WAKE and SLEEP commands
+ * based on deltas between WAKE/SLEEP requirements. The ws_list persists
+ * through multiple commit requests and bcm nodes are removed only when the
+ * requirements for WAKE matches SLEEP.
+ *
+ * Returns 0 on success, or an appropriate error code otherwise.
+ */
+int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
+{
+	struct qcom_icc_bcm *bcm;
+	struct qcom_icc_bcm *bcm_tmp;
+	int commit_idx[MAX_VCD];
+	struct tcs_cmd cmds[MAX_BCMS];
+	int ret = 0;
+
+	if (!voter)
+		return 0;
+
+	mutex_lock(&voter->lock);
+	list_for_each_entry(bcm, &voter->commit_list, list)
+		bcm_aggregate(bcm);
+
+	/*
+	 * Pre sort the BCMs based on VCD for ease of generating a command list
+	 * that groups the BCMs with the same VCD together. VCDs are numbered
+	 * with lowest being the most expensive time wise, ensuring that
+	 * those commands are being sent the earliest in the queue. This needs
+	 * to be sorted every commit since we can't guarantee the order in which
+	 * the BCMs are added to the list.
+	 */
+	list_sort(NULL, &voter->commit_list, cmp_vcd);
+
+	/*
+	 * Construct the command list based on a pre ordered list of BCMs
+	 * based on VCD.
+	 */
+	tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
+
+	if (!commit_idx[0])
+		goto out;
+
+	ret = rpmh_invalidate(voter->dev);
+	if (ret) {
+		pr_err("Error invalidating RPMH client (%d)\n", ret);
+		goto out;
+	}
+
+	ret = rpmh_write_batch(voter->dev, RPMH_ACTIVE_ONLY_STATE,
+			       cmds, commit_idx);
+	if (ret) {
+		pr_err("Error sending AMC RPMH requests (%d)\n", ret);
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&voter->commit_list);
+
+	list_for_each_entry_safe(bcm, bcm_tmp, &voter->ws_list, ws_list) {
+		/*
+		 * Only generate WAKE and SLEEP commands if a resource's
+		 * requirements change as the execution environment transitions
+		 * between different power states.
+		 */
+		if (bcm->vote_x[QCOM_ICC_BUCKET_WAKE] !=
+		    bcm->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
+		    bcm->vote_y[QCOM_ICC_BUCKET_WAKE] !=
+		    bcm->vote_y[QCOM_ICC_BUCKET_SLEEP])
+			list_add_tail(&bcm->list, &voter->commit_list);
+		else
+			list_del_init(&bcm->ws_list);
+	}
+
+	if (list_empty(&voter->commit_list))
+		goto out;
+
+	list_sort(NULL, &voter->commit_list, cmp_vcd);
+
+	tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
+
+	ret = rpmh_write_batch(voter->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
+	if (ret) {
+		pr_err("Error sending WAKE RPMH requests (%d)\n", ret);
+		goto out;
+	}
+
+	tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
+
+	ret = rpmh_write_batch(voter->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
+	if (ret) {
+		pr_err("Error sending SLEEP RPMH requests (%d)\n", ret);
+		goto out;
+	}
+
+out:
+	INIT_LIST_HEAD(&voter->commit_list);
+	mutex_unlock(&voter->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_commit);
+
+static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
+{
+	struct bcm_voter *voter;
+
+	voter = devm_kzalloc(&pdev->dev, sizeof(*voter), GFP_KERNEL);
+	if (!voter)
+		return -ENOMEM;
+
+	voter->dev = &pdev->dev;
+	voter->np = pdev->dev.of_node;
+	mutex_init(&voter->lock);
+	INIT_LIST_HEAD(&voter->commit_list);
+	INIT_LIST_HEAD(&voter->ws_list);
+	list_add_tail(&voter->voter_node, &bcm_voters);
+
+	return 0;
+}
+
+static const struct of_device_id bcm_voter_of_match[] = {
+	{ .compatible = "qcom,sdm845-bcm-voter" },
+	{ },
+};
+
+static struct platform_driver qcom_icc_bcm_voter_driver = {
+	.probe = qcom_icc_bcm_voter_probe,
+	.driver = {
+		.name		= "sdm845_bcm_voter",
+		.of_match_table = bcm_voter_of_match,
+	},
+};
+module_platform_driver(qcom_icc_bcm_voter_driver);
+MODULE_AUTHOR("David Dai <daidavid1@codeaurora.org>");
+MODULE_DESCRIPTION("Qualcomm BCM Voter interconnect driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
new file mode 100644
index 0000000..bb687b7
--- /dev/null
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_BCM_VOTER_H__
+#define __DRIVERS_INTERCONNECT_QCOM_ICC_BCM_VOTER_H__
+
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+#include <soc/qcom/tcs.h>
+
+#include "icc-rpmh.h"
+
+#define DEFINE_QBCM(_name, _bcmname, _keepalive, _numnodes, ...)	\
+		static struct qcom_icc_bcm _name = {			\
+		.name = _bcmname,					\
+		.keepalive = _keepalive,				\
+		.num_nodes = _numnodes,					\
+		.nodes = { __VA_ARGS__ },				\
+	}
+
+struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
+void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
+int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
+
+#endif
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
new file mode 100644
index 0000000..0041deb
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <asm/div64.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+
+#include "icc-rpmh.h"
+#include "bcm-voter.h"
+
+/**
+ * qcom_icc_pre_aggregate - cleans up stale values from prior icc_set
+ * @node: icc node to operate on
+ */
+void qcom_icc_pre_aggregate(struct icc_node *node)
+{
+	size_t i;
+	struct qcom_icc_node *qn;
+
+	qn = node->data;
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		qn->sum_avg[i] = 0;
+		qn->max_peak[i] = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
+
+/**
+ * qcom_icc_aggregate - aggregate bw for buckets indicated by tag
+ * @node: node to aggregate
+ * @tag: tag to indicate which buckets to aggregate
+ * @avg_bw: new bw to sum aggregate
+ * @peak_bw: new bw to max aggregate
+ * @agg_avg: existing aggregate avg bw val
+ * @agg_peak: existing aggregate peak bw val
+ */
+int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	size_t i;
+	struct qcom_icc_node *qn;
+	struct qcom_icc_provider *qp;
+
+	qn = node->data;
+	qp = to_qcom_provider(node->provider);
+
+	if (!tag)
+		tag = QCOM_ICC_TAG_ALWAYS;
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		if (tag & BIT(i)) {
+			qn->sum_avg[i] += avg_bw;
+			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
+		}
+	}
+
+	*agg_avg += avg_bw;
+	*agg_peak = max_t(u32, *agg_peak, peak_bw);
+
+	for (i = 0; i < qn->num_bcms; i++)
+		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
+
+/**
+ * qcom_icc_set - set the constraints based on path
+ * @src: source node for the path to set constraints on
+ * @dst: destination node for the path to set constraints on
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+	int ret = 0;
+
+	if (!src)
+		node = dst;
+	else
+		node = src;
+
+	qp = to_qcom_provider(node->provider);
+
+	qcom_icc_bcm_voter_commit(qp->voter);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_set);
+
+/**
+ * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
+ * @bcm: bcm to be initialized
+ * @dev: associated provider device
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
+{
+	struct qcom_icc_node *qn;
+	const struct bcm_db *data;
+	size_t data_count;
+	int i;
+
+	bcm->addr = cmd_db_read_addr(bcm->name);
+	if (!bcm->addr) {
+		dev_err(dev, "%s could not find RPMh address\n",
+			bcm->name);
+		return -EINVAL;
+	}
+
+	data = cmd_db_read_aux_data(bcm->name, &data_count);
+	if (IS_ERR(data)) {
+		dev_err(dev, "%s command db read error (%ld)\n",
+			bcm->name, PTR_ERR(data));
+		return PTR_ERR(data);
+	}
+	if (!data_count) {
+		dev_err(dev, "%s command db missing or partial aux data\n",
+			bcm->name);
+		return -EINVAL;
+	}
+
+	bcm->aux_data.unit = le32_to_cpu(data->unit);
+	bcm->aux_data.width = le16_to_cpu(data->width);
+	bcm->aux_data.vcd = data->vcd;
+	bcm->aux_data.reserved = data->reserved;
+	INIT_LIST_HEAD(&bcm->list);
+	INIT_LIST_HEAD(&bcm->ws_list);
+
+	/*
+	 * Link Qnodes to their respective BCMs
+	 */
+	for (i = 0; i < bcm->num_nodes; i++) {
+		qn = bcm->nodes[i];
+		qn->bcms[qn->num_bcms] = bcm;
+		qn->num_bcms++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);
+
+static struct platform_driver qcom_icc_rpmh_driver = {
+	.driver = {
+		.name		= "icc_rpmh",
+	},
+};
+module_platform_driver(qcom_icc_rpmh_driver);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
new file mode 100644
index 0000000..b32c7e3
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
+#define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
+
+#define to_qcom_provider(_provider) \
+	container_of(_provider, struct qcom_icc_provider, provider)
+
+/**
+ * struct qcom_icc_provider - Qualcomm specific interconnect provider
+ * @dev: reference to the NoC device
+ * @bcms: list of bcms that maps to the provider
+ * @num_bcms: number of @bcms
+ * @voter: bcm voter targeted by this provider
+ */
+struct qcom_icc_provider {
+	struct icc_provider provider;
+	struct device *dev;
+	struct qcom_icc_bcm **bcms;
+	size_t num_bcms;
+	struct bcm_voter *voter;
+};
+
+/**
+ * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
+ * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
+ * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
+ * @vcd: virtual clock domain that this bcm belongs to
+ * @reserved: reserved field
+ */
+struct bcm_db {
+	__le32 unit;
+	__le16 width;
+	u8 vcd;
+	u8 reserved;
+};
+
+#define MAX_LINKS		128
+#define MAX_BCMS		64
+#define MAX_BCM_PER_NODE	3
+#define MAX_VCD			10
+
+/*
+ * The AMC bucket denotes constraints that are applied to hardware when
+ * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
+ * when the execution environment transitions between active and low power mode.
+ */
+#define QCOM_ICC_BUCKET_AMC		0
+#define QCOM_ICC_BUCKET_WAKE		1
+#define QCOM_ICC_BUCKET_SLEEP		2
+#define QCOM_ICC_NUM_BUCKETS		3
+#define QCOM_ICC_TAG_AMC		BIT(QCOM_ICC_BUCKET_AMC)
+#define QCOM_ICC_TAG_WAKE		BIT(QCOM_ICC_BUCKET_WAKE)
+#define QCOM_ICC_TAG_SLEEP		BIT(QCOM_ICC_BUCKET_SLEEP)
+#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
+#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
+					 QCOM_ICC_TAG_SLEEP)
+
+/**
+ * struct qcom_icc_node - Qualcomm specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @links: an array of nodes where we can go next while traversing
+ * @id: a unique node identifier
+ * @num_links: the total number of @links
+ * @channels: num of channels at this node
+ * @buswidth: width of the interconnect between a node and the bus
+ * @sum_avg: current sum aggregate value of all avg bw requests
+ * @max_peak: current max aggregate value of all peak bw requests
+ * @bcms: list of bcms associated with this logical node
+ * @num_bcms: num of @bcms
+ */
+struct qcom_icc_node {
+	const char *name;
+	u16 links[MAX_LINKS];
+	u16 id;
+	u16 num_links;
+	u16 channels;
+	u16 buswidth;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
+	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
+	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
+	size_t num_bcms;
+};
+
+/**
+ * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
+ * known as Bus Clock Manager (BCM)
+ * @name: the bcm node name used to fetch BCM data from command db
+ * @type: latency or bandwidth bcm
+ * @addr: address offsets used when voting to RPMH
+ * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
+ * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
+ * @dirty: flag used to indicate whether the bcm needs to be committed
+ * @keepalive: flag used to indicate whether a keepalive is required
+ * @aux_data: auxiliary data used when calculating threshold values and
+ * communicating with RPMh
+ * @list: used to link to other bcms when compiling lists for commit
+ * @ws_list: used to keep track of bcms that may transition between wake/sleep
+ * @num_nodes: total number of @num_nodes
+ * @nodes: list of qcom_icc_nodes that this BCM encapsulates
+ */
+struct qcom_icc_bcm {
+	const char *name;
+	u32 type;
+	u32 addr;
+	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
+	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
+	bool dirty;
+	bool keepalive;
+	struct bcm_db aux_data;
+	struct list_head list;
+	struct list_head ws_list;
+	size_t num_nodes;
+	struct qcom_icc_node *nodes[];
+};
+
+struct qcom_icc_fabric {
+	struct qcom_icc_node **nodes;
+	size_t num_nodes;
+};
+
+struct qcom_icc_desc {
+	struct qcom_icc_node **nodes;
+	size_t num_nodes;
+	struct qcom_icc_bcm **bcms;
+	size_t num_bcms;
+};
+
+#define DEFINE_QNODE(_name, _id, _channels, _buswidth,			\
+			_numlinks, ...)					\
+		static struct qcom_icc_node _name = {			\
+		.id = _id,						\
+		.name = #_name,						\
+		.channels = _channels,					\
+		.buswidth = _buswidth,					\
+		.num_links = _numlinks,					\
+		.links = { __VA_ARGS__ },				\
+	}
+
+int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
+int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
+void qcom_icc_pre_aggregate(struct icc_node *node);
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
