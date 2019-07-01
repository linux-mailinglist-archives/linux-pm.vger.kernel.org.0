Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09175BDC9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfGAONQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 10:13:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37934 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAONQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 10:13:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so6131491pgz.5;
        Mon, 01 Jul 2019 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=scZ5GnTV8I7bOvJ6lzl+PSHZYfBr3KBNNf2b3zoQP2M=;
        b=IEW5Alr41ArZ5PfR+ZqGq0LtqjgRi1vEzrncCFpZ2J2dKJ8NTr8sdMEgJt0IO7HSYM
         4nEtEY8karNOZGxFWHFngFBMgxNTzEkzn9ZZkIC78JCn98lI+WHi1lBYNpMKFd5lvLgE
         6NvF06MwOlVup0WmvGqPcbV434RTmQtkILrHGbX6NYvZSINpIAlnBRLuSJhEty/5G5TH
         DQWzLZZh5yuYPOIYedNXa+PwfksTl0OJpbYVRh87WS5sheBfiDo5B2G4nLiz8rZ+VX0m
         kVssbS4cP845QmDUGproNkaz3TGQgaNSl1s4QWJp1yGl5swG419QPAH5K7XLUNma6Pbj
         xJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scZ5GnTV8I7bOvJ6lzl+PSHZYfBr3KBNNf2b3zoQP2M=;
        b=pbCAyk9kQl9CxtH8wjlq1YPPFaW6c0owXvHEa6NzWlrVCF6MWYtCAsEbr1zBgQhObS
         H3InNH30aY7RvhG5nwxmr15qFu9jdMn1FjKdatqm4bouGpPsMKKvtYhkZ34uEGeSLS9y
         X2EwN8oz51HzIbXvTFKcnwkH4TRZIySCLbVc3vKGWLfUAC0bBtphJJo1mOVOINCoEoBb
         5iO7wawOPXDCqE+YUBOQNE46Svs2wRYwgP1d3kws/5NfsziznX4ZkXhCGaXVfTudB5wb
         czbatoj9uzIBXRgJKFLK//T4RXnDqJteURogp8BG/ykVDkGBGT5k3T8hHnZT1tHIq8bl
         MCjQ==
X-Gm-Message-State: APjAAAV748iJpSVpgrrsjdKuunvJPbWtYKArZVYtpxEeETF0nLNvwg5Q
        bu9VF2cRi+7hLkgwd55/o9c=
X-Google-Smtp-Source: APXvYqxsYoEGGmCNHNAQBQFZgb/0R2hySZHxPiAq5C8OpABF8vxdTvdpQEcQZU6xSh5uHEVKOcaetQ==
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr12570537pjp.47.1561990395984;
        Mon, 01 Jul 2019 07:13:15 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id n19sm11383871pfa.11.2019.07.01.07.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 07:13:15 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 4/4] nvme: notify thermal framework when temperature threshold events occur
Date:   Mon,  1 Jul 2019 23:12:34 +0900
Message-Id: <1561990354-4084-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
References: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The NVMe controller supports the temperature threshold feature (Feature
Identifier 04h) that enables to configure the asynchronous event request
command to complete when the temperature is crossed its corresponding
temperature threshold.

This enables the reporting of asynchronous events from the controller when
the temperature reached or exceeded a temperature threshold.
In the case of the temperature threshold conditions, this notifies the
thermal framework.

The main purpose of this is to turn on a fan when overheated without
polling the device for the smart log that could prevent the lower power
state transitions.

Cc: Rob Herring <robh@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v5
- use thermal_zone_device_update() instead of thermal_notify_framework()

 drivers/nvme/host/core.c    | 14 ++++++++++++++
 drivers/nvme/host/nvme.h    |  5 +++++
 drivers/nvme/host/thermal.c | 14 ++++++++++++++
 include/linux/nvme.h        |  7 +++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d84685..80403c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1186,6 +1186,9 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
 	int status;
 
+	if (IS_ENABLED(CONFIG_THERMAL))
+		supported_aens |= NVME_SMART_CRIT_TEMPERATURE;
+
 	if (!supported_aens)
 		return;
 
@@ -3561,6 +3564,16 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
+static void nvme_handle_aen_smart(struct nvme_ctrl *ctrl, u32 result)
+{
+	u32 aer_type = result & NVME_AER_TYPE_MASK;
+	u32 aer_info = (result >> NVME_AER_INFO_SHIFT) & NVME_AER_INFO_MASK;
+
+	if (aer_type == NVME_AER_SMART &&
+	    aer_info == NVME_AER_SMART_TEMP_THRESH)
+		nvme_thermal_zones_update(ctrl);
+}
+
 static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 {
 	char *envp[2] = { NULL, NULL };
@@ -3582,6 +3595,7 @@ static void nvme_async_event_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, async_event_work);
 
+	nvme_handle_aen_smart(ctrl, ctrl->aen_result);
 	nvme_aen_uevent(ctrl);
 	ctrl->ops->submit_async_event(ctrl);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d501567..f29bc77 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -611,6 +611,7 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 
 int nvme_thermal_zones_register(struct nvme_ctrl *ctrl);
 void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl);
+void nvme_thermal_zones_update(struct nvme_ctrl *ctrl);
 
 #else
 
@@ -623,6 +624,10 @@ static inline void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
 {
 }
 
+static inline void nvme_thermal_zones_update(struct nvme_ctrl *ctrl)
+{
+}
+
 #endif /* CONFIG_THERMAL */
 
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/thermal.c b/drivers/nvme/host/thermal.c
index 431aeb4..9dcc1dc 100644
--- a/drivers/nvme/host/thermal.c
+++ b/drivers/nvme/host/thermal.c
@@ -327,3 +327,17 @@ void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
 		__clear_bit(i, ctrl->tz_enabled);
 	}
 }
+
+void nvme_thermal_zones_update(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for_each_set_bit(i, ctrl->tz_enabled, ARRAY_SIZE(ctrl->tz)) {
+		if (ctrl->tz[i].dev)
+			thermal_zone_device_update(ctrl->tz[i].dev,
+						   THERMAL_EVENT_UNSPECIFIED);
+		if (ctrl->tz[i].of_dev)
+			thermal_zone_device_update(ctrl->tz[i].of_dev,
+						   THERMAL_EVENT_UNSPECIFIED);
+	}
+}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f29728b..069b962 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -476,6 +476,7 @@ enum {
 };
 
 enum {
+	NVME_AER_TYPE_MASK		= 0x7,
 	NVME_AER_ERROR			= 0,
 	NVME_AER_SMART			= 1,
 	NVME_AER_NOTICE			= 2,
@@ -484,6 +485,12 @@ enum {
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

