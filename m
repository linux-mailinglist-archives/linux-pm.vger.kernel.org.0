Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEDFE254D1
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfEUQEk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 12:04:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38796 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQEj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 12:04:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so8642516plb.5
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2019 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wQFG8hw3y3EIs2QpnKA67CdoA7uCJM+M7ssUQOFNLw8=;
        b=i0+RdiALkQzzsbo6liTzoG7avWVdVxZzLhgx3Zh6KUZDrdLDq8+3A21zLJcalT5tAe
         RtBw9250vMHrbAsxL68KHF4YobIsqlUsph8BK82pfPYM165MrcgfAhmNo1ThTVQgPSnZ
         sEDY8iTGzThjHdCBvxYM5iAhHTHPNr1NsqoluLGdZuzo5K1TPcVgPqOCSy+kkJY3AOxn
         x07aziY7s8sFxXmf6AnCCk377ssvAfySPCBegJhBZKHSjYRkoCTIM54J6jJM4xsD6KqU
         khQ3UvV/a3ZEKAU/m15hT6Eogk8OI9A23eQjHh3zXALyCME1neq8WZi8bDRT1EivmfVA
         UNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wQFG8hw3y3EIs2QpnKA67CdoA7uCJM+M7ssUQOFNLw8=;
        b=pCGd7sVvppxrfud4nFjWPZAzZYKQ8x1rhL4z2JDaQZXclG2EvNByAworwQaIDRSEvF
         0srRsabxDjVZy0T0jRvyz2NbyGn+RZBaqrUn5UKnaodylk5onVBMBTEXvBce33/54TKE
         59U3fXsKc1tvW+FxMGxkK/dbNk/0wMBqlAGVFvyvUvRGcj9n383Zv50OausYLEFeGsQD
         zyGXR5HpMkuNM3I78arEnmXanSyhgt6ZX/wte9hyCWocXtUb0+ibD9iL82YXgvwAu9lw
         D3BCGM+/7yobtb88uZDXYdpqrGggLCfW2JAQHGk+Kzli9xP2F4OzbYWirL+wLM8j/689
         5bng==
X-Gm-Message-State: APjAAAUT0dYPS0J2pybIKEQw9zlYwtfy6QJbin4Cx72IlmJJaxq9QHTR
        GpgNzuKCjAjyJ3W+ACCRE4o=
X-Google-Smtp-Source: APXvYqwvWcDIl+aU/XA5TANKkfW/YI2ev5NCjho/Az9gHQL6o/RAfqGH1SFq1Bdb3sFt20t5XqDvIA==
X-Received: by 2002:a17:902:e9:: with SMTP id a96mr57111148pla.37.1558454679338;
        Tue, 21 May 2019 09:04:39 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:9cd0:73e8:b74a:624e])
        by smtp.gmail.com with ESMTPSA id j5sm28954786pfa.15.2019.05.21.09.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 09:04:38 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2 3/4] nvme: notify thermal framework when temperature threshold events occur
Date:   Wed, 22 May 2019 01:04:08 +0900
Message-Id: <1558454649-28783-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables the reporting of asynchronous events from the controller when
the temperature reached or exceeded a temperature threshold.

In the case of the temperature threshold conditions, this notifies the
thermal framework.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- New patch since v2
- Extracted from 'add thermal zone infrastructure' patch

 drivers/nvme/host/core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/nvme.h     |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0ec303c..a86f9f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1184,6 +1184,9 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
 	int status;
 
+	if (IS_ENABLED(CONFIG_THERMAL))
+		supported_aens |= NVME_SMART_CRIT_TEMPERATURE;
+
 	if (!supported_aens)
 		return;
 
@@ -2442,6 +2445,22 @@ void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_thermal_zones_unregister);
 
+static void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
+		if (ctrl->tzdev[i])
+			thermal_notify_framework(ctrl->tzdev[i], 0);
+	}
+}
+
+#else
+
+static void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)
+{
+}
+
 #endif /* CONFIG_THERMAL */
 
 struct nvme_core_quirk_entry {
@@ -3857,6 +3876,16 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
+static void nvme_handle_aen_smart(struct nvme_ctrl *ctrl, u32 result)
+{
+	u32 aer_type = result & NVME_AER_TYPE_MASK;
+	u32 aer_info = (result >> NVME_AER_INFO_SHIFT) & NVME_AER_INFO_MASK;
+
+	if (aer_type == NVME_AER_SMART &&
+	    aer_info == NVME_AER_SMART_TEMP_THRESH)
+		nvme_thermal_notify_framework(ctrl);
+}
+
 static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 {
 	char *envp[2] = { NULL, NULL };
@@ -3878,6 +3907,7 @@ static void nvme_async_event_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, async_event_work);
 
+	nvme_handle_aen_smart(ctrl, ctrl->aen_result);
 	nvme_aen_uevent(ctrl);
 	ctrl->ops->submit_async_event(ctrl);
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 54f0a13..8e7d599 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -507,6 +507,7 @@ enum {
 };
 
 enum {
+	NVME_AER_TYPE_MASK		= 0x7,
 	NVME_AER_ERROR			= 0,
 	NVME_AER_SMART			= 1,
 	NVME_AER_NOTICE			= 2,
@@ -515,6 +516,12 @@ enum {
 };
 
 enum {
+	NVME_AER_INFO_SHIFT		= 8,
+	NVME_AER_INFO_MASK		= 0xff,
+	NVME_AER_SMART_TEMP_THRESH	= 0x01,
+};
+
+enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 	NVME_AER_NOTICE_ANA		= 0x03,
-- 
2.7.4

