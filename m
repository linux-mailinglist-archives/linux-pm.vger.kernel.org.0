Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718AF7A019B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjINKYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjINKYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 06:24:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581961BE9
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 03:24:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-271914b8aa4so594130a91.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694687055; x=1695291855; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIn+fMQMbdE/Y7y38d0EeKzkdNXYRZ5DFI27IEmIgh4=;
        b=AVJnI9fxY/ic7HX3a9POEO6PSscRIaSDqd9Xss2Ds3ww5kIZakrx5824Ma83wXhrAR
         TnUshkkni8pPIJTcrFv8ICxkDxzzQgjAx/4tDwofO0sqIQkTIPiXtMqZycVVU5HoD+y4
         pGwteRz21itXN08jWzbIJ9ejOKi7KEckZCsnucHRj5O+Fw9s4REURVZ2chISnGQjHUAN
         k2M0Q/sb/GqfYU4/xyBDH4uUoq/fHMhpck01dDyuSSkFwiPWpaWNdKy8Nt3DBM3p7WML
         cMoeHV1jfT2EAxG9bAMzGWl0sG5P5KkRU1wf4VY4hBN+ALcLErD2mXjQ73O+AmUVt/mo
         h4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694687055; x=1695291855;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIn+fMQMbdE/Y7y38d0EeKzkdNXYRZ5DFI27IEmIgh4=;
        b=B6rRiscsMwCOvGXjY5xQ7bm3jzWTxuhue6tmZuKPHmshpD2F3Q9JvZR07ew60TYqzR
         z3gHWYmsfIt3M73yt+2SviE9G26bGZVyccAhY/1lUGg+shAxPg+2rt7Ht7EpW7M4ykFY
         RnE3XWPH3KeaqWMl668DBoxuvhDCEoMulpR1t0HWI7WcQjOq3fLpNtoLHy/SOt1a8zUq
         L80+ytM1G8i2dL78kMSRHTrvT8TpK+imyDo6NhBqdxhGYhwW2iM5UJt7diW/B8CCzxet
         Q47nQVmiHiaJBvqtu9Sqq9b0bCrbGifskpIxwgQ6YWXPATOwGy1XcSjhoRDQiVEKRziq
         ylhQ==
X-Gm-Message-State: AOJu0YxGYJmNGM2q3F9F7wM69xI9jfH5TZn4hAycpjLjpForeSYWZEst
        Omuu256KLlyaotg/kSbT107Vhd3vF2w=
X-Google-Smtp-Source: AGHT+IHEyPxVFBICRierUHR8PsjHOgLUEcB+n4vV/+a8YqFTEUQ/f/fAnWcHdyUxKa+nY7LruFJqHg==
X-Received: by 2002:a17:90a:c282:b0:26d:63fd:1329 with SMTP id f2-20020a17090ac28200b0026d63fd1329mr4465444pjt.42.1694687054730;
        Thu, 14 Sep 2023 03:24:14 -0700 (PDT)
Received: from localhost ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id iq15-20020a17090afb4f00b002636e5c224asm1029944pjb.56.2023.09.14.03.24.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Sep 2023 03:24:14 -0700 (PDT)
From:   Jiazi Li <jqqlijiazi@gmail.com>
X-Google-Original-From: Jiazi Li <jiazi.li@transsion.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Jiazi Li <jiazi.li@transsion.com>, linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Show trans_stat info via debugfs
Date:   Thu, 14 Sep 2023 18:23:17 +0800
Message-Id: <20230914102317.29302-1-jiazi.li@transsion.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For device with over PAGE_SIZE bytes trans_stat info, trans_stat
in sysfs just show a prompt information.
Create a trans_stat node in debugfs, show detailed information.

Signed-off-by: Jiazi Li <jiazi.li@transsion.com>
---
 drivers/devfreq/devfreq.c | 79 ++++++++++++++++++++++++++++++++++++++-
 include/linux/devfreq.h   |  2 +
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e36cbb920ec8..08847734ecee 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -940,6 +940,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 	create_sysfs_files(devfreq, devfreq->governor);
+	devfreq->debugfs_dir =
+		debugfs_create_dir(dev_name(&(devfreq->dev)), devfreq_debugfs);
 
 	list_add(&devfreq->node, &devfreq_list);
 
@@ -978,6 +980,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
 
 	devfreq_cooling_unregister(devfreq->cdev);
 
+	debugfs_remove_recursive(devfreq->debugfs_dir);
 	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
@@ -1682,6 +1685,66 @@ static ssize_t available_frequencies_show(struct device *d,
 }
 static DEVICE_ATTR_RO(available_frequencies);
 
+/**
+ * devfreq_trans_stat_show() - show trans stat info through debugfs
+ * @s:		seq_file instance to show trans_stat info of devfreq devices
+ * @data:	not used
+ *
+ * Show detailed information for some device which has more than PAGE_SIZE
+ * bytes of trans stat info.
+ */
+static int devfreq_trans_stat_show(struct seq_file *s, void *unused)
+{
+	struct devfreq *df = s->private;
+	unsigned int max_state;
+	int i, j;
+
+	if (!df->profile)
+		return -EINVAL;
+	max_state = df->max_state;
+
+	if (max_state == 0) {
+		seq_puts(s, "Not Supported.\n");
+		return 0;
+	}
+
+	mutex_lock(&df->lock);
+	if (!df->stop_polling &&
+			devfreq_update_status(df, df->previous_freq)) {
+		mutex_unlock(&df->lock);
+		return 0;
+	}
+	mutex_unlock(&df->lock);
+
+	seq_puts(s, "     From  :   To\n");
+	seq_puts(s, "           :");
+	for (i = 0; i < max_state; i++)
+		seq_printf(s, "%10lu", df->freq_table[i]);
+
+	seq_puts(s, "   time(ms)\n");
+
+	for (i = 0; i < max_state; i++) {
+		if (df->freq_table[i] == df->previous_freq)
+			seq_puts(s, "*");
+		else
+			seq_puts(s, " ");
+
+		seq_printf(s, "%10lu:", df->freq_table[i]);
+
+		for (j = 0; j < max_state; j++)
+			seq_printf(s, "%10u",
+				df->stats.trans_table[(i * max_state) + j]);
+
+		seq_printf(s, "%10llu\n", (u64)
+			jiffies64_to_msecs(df->stats.time_in_state[i]));
+	}
+
+	seq_printf(s, "Total transition : %u\n", df->stats.total_trans);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(devfreq_trans_stat);
+
 static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -1694,8 +1757,22 @@ static ssize_t trans_stat_show(struct device *dev,
 		return -EINVAL;
 	max_state = df->max_state;
 
-	if (max_state == 0)
+	if (max_state == 0) {
 		return sprintf(buf, "Not Supported.\n");
+	} else if (max_state > 12) {
+		/*
+		 * In theory, 13 states will use more than PAGE_SIZE
+		 * bytes, show detail info through debugfs
+		 */
+		if (!df->trans_stat)
+			df->trans_stat = debugfs_create_file("trans_stat", 0444,
+					df->debugfs_dir, df,
+					&devfreq_trans_stat_fops);
+		return sprintf(buf,
+				"This device's data size exceeds the limit of sysfs.\n"
+				"Please use debugfs for detailed information:\n"
+				"/sys/kernel/debug/devfreq/.../trans_stat\n");
+	}
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d312ffbac4dd..7df3f9e51d28 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -209,6 +209,8 @@ struct devfreq {
 
 	/* information for device frequency transitions */
 	struct devfreq_stats stats;
+	struct dentry *debugfs_dir;
+	struct dentry *trans_stat;
 
 	struct srcu_notifier_head transition_notifier_list;
 
-- 
2.17.1

