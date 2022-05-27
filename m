Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726DB5357A3
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiE0CfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiE0CfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CBFE64C1;
        Thu, 26 May 2022 19:35:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gi33so6255176ejc.3;
        Thu, 26 May 2022 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weDx82Jk2FioFTnbaDWDwFOOe5VYGO11qahEOC3nnRw=;
        b=H5/mq88+SGs7fG1BLe5lR0H60sa0U6XO10AVTbBvLOHo+1G1X1Ghb8u4q23OnG/+mk
         HFOWU7Azwfmbz0vVca3hnn0REXMFaRiTiLwv480AUIoxC0TanQSPJ/HTQdF/GBcyBZIA
         WgH9oYv+R2oF0HIfIFvhD0mTyjZh0t4N9c/SUF+ff4kSFYLC87Qn0UPlPsouuYaP5/Jw
         MmoFJbDJ/I2JN8OmsqrPJAkFpRINGCtSF5qjLIAZ3tT5CWCUzXRdPHFOyRYcOzynmSnS
         HliQkOM7E9WU8oDL4rXqGcRYw2TSvdJqF+XtzcdNhfnoclQCvsYx5V/JsHvElIBdmukx
         AOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weDx82Jk2FioFTnbaDWDwFOOe5VYGO11qahEOC3nnRw=;
        b=1gCg2JRFHc6/R3NAOH2azS+x322Vqnh7Vfkxu/Swicja8bKeWq/ybhce6ErWw8w66O
         S8pHimUjnkCFdvnrKd6JHYlZZn4In/8LsX8b6Gqr6XKKFZqhXJRFjEeJKkc6w3ZKMMfT
         y8wCXGhD6/sW0pwpMHQdI6Q7/wm+kRjQY4LdOiTigz80PSWOhh72M6+QTYMZYP4BDqFV
         PBdS6igQE8R9zsvabMrgBuBSHV4abPugzDZssQHLMXUGM2yt93wjnpiCsukew3jhJXvu
         WQcHrpDx/UQcJOjRIkpCKREcnjZJdQp1ztAtfCKo80jQnh99t1O1+6rRZCsjbJYy+uFA
         Y0RA==
X-Gm-Message-State: AOAM531qhCnVpp6ynVoo5001CF6SzHJXHv5hP3CSZ703Wijr6GGlFhcG
        EsU1usBxQmGcqOqScJj5AIc=
X-Google-Smtp-Source: ABdhPJzAVSrhbTxmoXthEf42re/ivgrlL3NY3LADLk44W+l5Y6gh/xm17A6AX0L2DLDq/86iIOqDfA==
X-Received: by 2002:a17:907:7f06:b0:6fe:b81f:f885 with SMTP id qf6-20020a1709077f0600b006feb81ff885mr27812177ejc.621.1653618903591;
        Thu, 26 May 2022 19:35:03 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:03 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2 02/12] platform/surface: aggregator: Allow devices to be marked as hot-removed
Date:   Fri, 27 May 2022 04:34:37 +0200
Message-Id: <20220527023447.2460025-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527023447.2460025-1-luzmaximilian@gmail.com>
References: <20220527023447.2460025-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some SSAM devices, notably the keyboard cover (keyboard and touchpad) on
the Surface Pro 8, can be hot-removed. When this occurs, communication
with the device may fail and time out. This timeout can unnecessarily
block and slow down device removal and even cause issues when the
devices are detached and re-attached quickly. Thus, communication should
generally be avoided once hot-removal is detected.

While we already remove a device as soon as we detect its (hot-)removal,
the corresponding device driver may still attempt to communicate with
the device during teardown. This is especially critical as communication
failure may also extend to disabling of events, which is typically done
at that stage.

Add a flag to allow marking devices as hot-removed. This can then be
used during client driver teardown to check if any communication
attempts should be avoided.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - none

---
 include/linux/surface_aggregator/device.h | 48 +++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 62b38b4487eb..6df7c8d4e50e 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -148,17 +148,30 @@ struct ssam_device_uid {
 #define SSAM_SDEV(cat, tid, iid, fun) \
 	SSAM_DEVICE(SSAM_DOMAIN_SERIALHUB, SSAM_SSH_TC_##cat, tid, iid, fun)
 
+/*
+ * enum ssam_device_flags - Flags for SSAM client devices.
+ * @SSAM_DEVICE_HOT_REMOVED_BIT:
+ *	The device has been hot-removed. Further communication with it may time
+ *	out and should be avoided.
+ */
+enum ssam_device_flags {
+	SSAM_DEVICE_HOT_REMOVED_BIT = 0,
+};
+
 /**
  * struct ssam_device - SSAM client device.
- * @dev:  Driver model representation of the device.
- * @ctrl: SSAM controller managing this device.
- * @uid:  UID identifying the device.
+ * @dev:   Driver model representation of the device.
+ * @ctrl:  SSAM controller managing this device.
+ * @uid:   UID identifying the device.
+ * @flags: Device state flags, see &enum ssam_device_flags.
  */
 struct ssam_device {
 	struct device dev;
 	struct ssam_controller *ctrl;
 
 	struct ssam_device_uid uid;
+
+	unsigned long flags;
 };
 
 /**
@@ -251,6 +264,35 @@ struct ssam_device *ssam_device_alloc(struct ssam_controller *ctrl,
 int ssam_device_add(struct ssam_device *sdev);
 void ssam_device_remove(struct ssam_device *sdev);
 
+/**
+ * ssam_device_mark_hot_removed() - Mark the given device as hot-removed.
+ * @sdev: The device to mark as hot-removed.
+ *
+ * Mark the device as having been hot-removed. This signals drivers using the
+ * device that communication with the device should be avoided and may lead to
+ * timeouts.
+ */
+static inline void ssam_device_mark_hot_removed(struct ssam_device *sdev)
+{
+	dev_dbg(&sdev->dev, "marking device as hot-removed\n");
+	set_bit(SSAM_DEVICE_HOT_REMOVED_BIT, &sdev->flags);
+}
+
+/**
+ * ssam_device_is_hot_removed() - Check if the given device has been
+ * hot-removed.
+ * @sdev: The device to check.
+ *
+ * Checks if the given device has been marked as hot-removed. See
+ * ssam_device_mark_hot_removed() for more details.
+ *
+ * Return: Returns ``true`` if the device has been marked as hot-removed.
+ */
+static inline bool ssam_device_is_hot_removed(struct ssam_device *sdev)
+{
+	return test_bit(SSAM_DEVICE_HOT_REMOVED_BIT, &sdev->flags);
+}
+
 /**
  * ssam_device_get() - Increment reference count of SSAM client device.
  * @sdev: The device to increment the reference count of.
-- 
2.36.1

