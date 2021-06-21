Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D233AE66C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFUJt2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFUJtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:14 -0400
Date:   Mon, 21 Jun 2021 09:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdSqeHx3+t0ZHuWT+DX1GyjXxvyzQNXIUWZvLX/M+Ms=;
        b=QnTlEd9X2wl/fTMhi0K5owfiSuccgPiCaie10SnsF5FmbYA/4AaDBPMaUe3n8grhM4UDE3
        Q5KIFZkaZ+B5c3GqeuFYQlOIEjZ0LRZks8fwvPn8PcxBb9GOrQg8EOWo7d+6stqSSNwohH
        6UMhOwYhE37VcEc5HnOxdHo2gBRD8KMarG1zUU+uQPBrYC5J6c46cbEqb5e9KMWfgfKqw1
        rAyrFPkE8YLUNO/hGemvAgIpXAYyc1WasA0tfKbnmyx1meGe5bHW1x44Q2qRj4SRDSSCUg
        /BrVaHhfJCIze4VudsSqQ7hLOKKcQirIxdEWlBr/fbrPrssouLDhpGlJ6o05+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdSqeHx3+t0ZHuWT+DX1GyjXxvyzQNXIUWZvLX/M+Ms=;
        b=AYZoMKyRVZMk8XdXm/YI7YRjfh7Ugj6STYAWH7LYcQK7Z+2wJTTieC4+ZdK9mfE6Zcw0PV
        TYGRF5qM4VmZZ5Bw==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/int340x: processor_thermal:
 Export mailbox interface
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210517061441.1921901-2-srinivas.pandruvada@linux.intel.com>
References: <20210517061441.1921901-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162426880974.395.14937604947121038365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fb5a6ec80367bcccb659a421850d757a5a81767a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fb5a6ec80367bcccb659a421850d757a5a81767a
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Sun, 16 May 2021 23:14:40 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Jun 2021 11:54:42 +02:00

thermal/drivers/int340x: processor_thermal: Export mailbox interface

Export the mailbox interface to be used by other modules. Also change
command id and response from u8 to u32 data type.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210517061441.1921901-2-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h |  2 ++
 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c   | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index b9ed645..3161607 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -79,4 +79,6 @@ void proc_thermal_rfim_remove(struct pci_dev *pdev);
 int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_mbox_remove(struct pci_dev *pdev);
 
+int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp);
+
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index 990f51f..59e93b0 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -23,7 +23,7 @@
 
 static DEFINE_MUTEX(mbox_lock);
 
-static int send_mbox_cmd(struct pci_dev *pdev, u8 cmd_id, u32 cmd_data, u8 *cmd_resp)
+static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
 {
 	struct proc_thermal_device *proc_priv;
 	u32 retries, data;
@@ -82,6 +82,12 @@ unlock_mbox:
 	return ret;
 }
 
+int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
+{
+	return send_mbox_cmd(pdev, cmd_id, cmd_data, cmd_resp);
+}
+EXPORT_SYMBOL_GPL(processor_thermal_send_mbox_cmd);
+
 /* List of workload types */
 static const char * const workload_types[] = {
 	"none",
@@ -147,7 +153,7 @@ static ssize_t workload_type_show(struct device *dev,
 				   char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	u8 cmd_resp;
+	u32 cmd_resp;
 	int ret;
 
 	ret = send_mbox_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, 0, &cmd_resp);
@@ -181,7 +187,7 @@ static bool workload_req_created;
 
 int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
-	u8 cmd_resp;
+	u32 cmd_resp;
 	int ret;
 
 	/* Check if there is a mailbox support, if fails return success */
