Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A603AE671
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUJte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFUJtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BAC06175F
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:47:00 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRI+u2KwASU3l5AgcyLubX/WX6yr/SJ6Hn+ChyL4cxM=;
        b=0biGTPgF70q7sSSDzJaQphLP3rSziFoYg8MaVH2gBVFTYswirsvwTX6vRNVEN3bKsnHHQA
        XJ++RIa0tYyNTrnjXpJtifddEFX9nIfuyHevTdAfP5FDMs0gJb8yPWsKwmthAMUdTPDdIn
        a3zvrdL8FDtFtwpH+NHbrUfn1fMfE0E3k2e6y0fUb3SssUNLeHPP5A7ULp+lisRIxMsTSA
        wxT71Lg+4s0h7nST8i4xW8Zhf43YlS90DCWbyr3FOh1qFMW64Em9IDGFXax4Kf4Kjn6LuM
        cpumnkd2CKCFNNUfsrFV8QVgpoj/zYjmZQzZUj/+20Zn3qdxN57+JDEQ2tGRGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRI+u2KwASU3l5AgcyLubX/WX6yr/SJ6Hn+ChyL4cxM=;
        b=RAg8RC5vcBKpmHVJrzyd+YARcaiN+tblhfxzHhe1And4ERbamvDJduFUyJd6qlp0egnI9F
        lq9MHTaId4K/uLAg==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/int340x: processor_thermal:
 Export additional attributes
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210517061441.1921901-3-srinivas.pandruvada@linux.intel.com>
References: <20210517061441.1921901-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162426880917.395.18441265814054814985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     5d6fbc96bd36cfec7bbc0578ad3986affdeb70de
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5d6fbc96bd36cfec7bbc0578ad3986affdeb70de
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Sun, 16 May 2021 23:14:41 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Jun 2021 11:55:47 +02:00

thermal/drivers/int340x: processor_thermal: Export additional attributes

Export additional attributes:

ddr_data_rate (RO) : Show current DDR (Double Data Rate) data rate.
rfi_restriction (RW) : Show or set current state for RFI (Radio
			Frequency Interference) protection.

These attributes use mailbox commands to get/set information. Here
command codes are:
0x0007: Read RFI restriction
0x0107: Read DDR data rate
0x0008: Write RFI restriction

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210517061441.1921901-3-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c | 55 +++++++-
 1 file changed, 55 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index aef993a..2b8a323 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -190,6 +190,59 @@ static DEVICE_ATTR_RO(ddr_data_rate_point_2);
 static DEVICE_ATTR_RO(ddr_data_rate_point_3);
 static DEVICE_ATTR_RW(rfi_disable);
 
+static ssize_t rfi_restriction_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	u16 cmd_id = 0x0008;
+	u32 cmd_resp;
+	u32 input;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, input, &cmd_resp);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t rfi_restriction_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	u16 cmd_id = 0x0007;
+	u32 cmd_resp;
+	int ret;
+
+	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", cmd_resp);
+}
+
+static ssize_t ddr_data_rate_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	u16 cmd_id = 0x0107;
+	u32 cmd_resp;
+	int ret;
+
+	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", cmd_resp);
+}
+
+static DEVICE_ATTR_RW(rfi_restriction);
+static DEVICE_ATTR_RO(ddr_data_rate);
+
 static struct attribute *dvfs_attrs[] = {
 	&dev_attr_rfi_restriction_run_busy.attr,
 	&dev_attr_rfi_restriction_err_code.attr,
@@ -199,6 +252,8 @@ static struct attribute *dvfs_attrs[] = {
 	&dev_attr_ddr_data_rate_point_2.attr,
 	&dev_attr_ddr_data_rate_point_3.attr,
 	&dev_attr_rfi_disable.attr,
+	&dev_attr_ddr_data_rate.attr,
+	&dev_attr_rfi_restriction.attr,
 	NULL
 };
 
