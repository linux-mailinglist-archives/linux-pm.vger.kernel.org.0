Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1842CF490
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgLDTLE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 14:11:04 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:31403 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgLDTLE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 14:11:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607109046; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UMsjcuAWdu22fCFAdUNp3aiqXyrJYaP8lEGrfsmhYng=; b=qIichflKZHu2IC0NGTjUoj0/GrdgmDEsyXXE7kdRQpegHOyiUgH5TFvCSycYzy161O/6VzVq
 MgO2cR5Bq5wwINFkoa1hqx8p0Mpx6OzGAfLrZUUgT3ZFlArNsxz72Tfk5PXQXQx0v9IYNnkB
 JvrkfSH9LvoJRxWR5dcWXehcCPc=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fca898f9c3ccbec63b561bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 04 Dec 2020 19:10:07
 GMT
Sender: manafm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0EEB9C43463; Fri,  4 Dec 2020 19:10:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96357C433CA;
        Fri,  4 Dec 2020 19:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96357C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=manafm@codeaurora.org
From:   Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Subject: [PATCH] drivers: thermal: Add NULL pointer check before using cooling device stats
Date:   Sat,  5 Dec 2020 00:39:51 +0530
Message-Id: <1607108991-31948-1-git-send-email-manafm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a possible chance that some cooling device stats buffer
allocation fails due to very high cooling device max state value.
Later cooling device update or cooling stats sysfs will try to
access stats data for the same cooling device. It will lead to
NULL pointer dereference issue.

Add a NULL pointer check before accessing thermal cooling device
stats data. It fixes the following bug

[ 26.812833] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
[ 27.122960] Call trace:
[ 27.122963] do_raw_spin_lock+0x18/0xe8
[ 27.122966] _raw_spin_lock+0x24/0x30
[ 27.128157] thermal_cooling_device_stats_update+0x24/0x98
[ 27.128162] cur_state_store+0x88/0xb8
[ 27.128166] dev_attr_store+0x40/0x58
[ 27.128169] sysfs_kf_write+0x50/0x68
[ 27.133358] kernfs_fop_write+0x12c/0x1c8
[ 27.133362] __vfs_write+0x54/0x160
[ 27.152297] vfs_write+0xcc/0x188
[ 27.157132] ksys_write+0x78/0x108
[ 27.162050] ksys_write+0xf8/0x108
[ 27.166968] __arm_smccc_hvc+0x158/0x4b0
[ 27.166973] __arm_smccc_hvc+0x9c/0x4b0
[ 27.186005] el0_svc+0x8/0xc

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
---
 drivers/thermal/thermal_sysfs.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 473449b..a5e4855 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -827,6 +827,9 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 {
 	struct cooling_dev_stats *stats = cdev->stats;
 
+	if (!stats)
+		return;
+
 	spin_lock(&stats->lock);
 
 	if (stats->state == new_state)
@@ -848,6 +851,9 @@ static ssize_t total_trans_show(struct device *dev,
 	struct cooling_dev_stats *stats = cdev->stats;
 	int ret;
 
+	if (!stats)
+		return -ENODEV;
+
 	spin_lock(&stats->lock);
 	ret = sprintf(buf, "%u\n", stats->total_trans);
 	spin_unlock(&stats->lock);
@@ -864,6 +870,9 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
 	ssize_t len = 0;
 	int i;
 
+	if (!stats)
+		return -ENODEV;
+
 	spin_lock(&stats->lock);
 	update_time_in_state(stats);
 
@@ -882,8 +891,12 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 	struct cooling_dev_stats *stats = cdev->stats;
-	int i, states = stats->max_states;
+	int i, states;
+
+	if (!stats)
+		return -ENODEV;
 
+	states = stats->max_states;
 	spin_lock(&stats->lock);
 
 	stats->total_trans = 0;
@@ -907,6 +920,9 @@ static ssize_t trans_table_show(struct device *dev,
 	ssize_t len = 0;
 	int i, j;
 
+	if (!stats)
+		return -ENODEV;
+
 	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
 	for (i = 0; i < stats->max_states; i++) {
-- 
2.7.4

