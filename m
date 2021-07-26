Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A23D5A40
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhGZMm5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhGZMmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 08:42:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E927C061757;
        Mon, 26 Jul 2021 06:23:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h14so3117757wrx.10;
        Mon, 26 Jul 2021 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9K67sWK8iCvxn8wA3EP4cDIU+lrlaZyWsxH1S+wkYOk=;
        b=SuZZBJipNbPUZaCppP1IpW/GUu7EREB17r3O2x4RRKUBddZb/DPJWFM2D2yPk6HaS8
         dwpZBgsZEe+JxhCYo0i9ZfC1JzogLyjFf2r4NXY+QnIUKgYevYwGkxWgCaQjr+MKV73/
         HCfSbSFgw6B9XATA8nj/GEkkYaK19r5+Uwvtl3xKUaHHhuZhwypzUw7lraPUiE/WvEcj
         haRm31qV4CQ+iVkt5bLMNpFyFx/roj6x9k4OBrqTvojR1mgBmCZ+vMIJEDf3U5jNfGXR
         vUjkTpfTW97crzw4/5wizMHsUxf99qtVe7fvTJlc6h3SXsZr4YSU5rllmc6CTuO2crzs
         PxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9K67sWK8iCvxn8wA3EP4cDIU+lrlaZyWsxH1S+wkYOk=;
        b=VDCot7owBQAX7/ebBzxZgnNbo7swYMxhA41JXuTByunpE7itxI2bChyuUIfg2xsgxS
         T7hZrNT9fvWY6rzuSnNiKQ9tJAs5Ha9k8be940PmsqCfGHW0GsqkppkSNqk4lV8IrXrh
         osi3f2RTFd1Gph13OOx21638zJJpjoFzSSCuPxzvc4le6Mma0U7HSNFHfk0Y3fhV4qWM
         ehVpafpIbGZNE8B/CZKvJSgbKd8jhQ4Xn1HxHwHsVOnwW3AsMrjOg14dQOeJCYEqT8T1
         60XZh7o6d3u/ZPhIlVDOnnZ9dQT5nxFa0RnNuzJrmQ5mkfOeXXLP7qcaWngUGr9v+oGK
         NBLA==
X-Gm-Message-State: AOAM5304mR7Fx+Za/VuJmkjDijtd57O5mKWMxnMC/3RzPogXdTwhJlD3
        tgNPm6D3uep2cxUS/TEiYuA=
X-Google-Smtp-Source: ABdhPJwxNCP148AFjwK/y0hOukG4j4nAjYbmtdI5DOJLx1OPPGpFdCbRWSx3RwnrbXoJ7AnnSojlhA==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr9758731wru.304.1627305803088;
        Mon, 26 Jul 2021 06:23:23 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de. [95.90.192.255])
        by smtp.gmail.com with ESMTPSA id w15sm8580wmi.3.2021.07.26.06.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:23:22 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Keith Busch <kbush@kernel.org>
Subject: [PATCH v2 1/2] PM: enable support for imminent power loss
Date:   Mon, 26 Jul 2021 13:22:22 +0000
Message-Id: <20210726132223.1661-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726132223.1661-1-sshivamurthy@micron.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

If the shutdown is pwerformed when the platform is running on the
limited backup power supply, some of the devices might not have enough
power to perform a clean shutdown.

It is necessary to inform the driver about the limited backup power
supply, to allow the driver to decide to perform the minimal required
operation for a fast and clean shutdown.

Signed-off-by: Keith Busch <kbush@kernel.org>
Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 include/linux/suspend.h | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8af13ba60c7e..1898792c10d3 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -210,9 +210,10 @@ extern int suspend_valid_only_mem(suspend_state_t state);
 
 extern unsigned int pm_suspend_global_flags;
 
-#define PM_SUSPEND_FLAG_FW_SUSPEND	BIT(0)
-#define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
-#define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
+#define PM_SUSPEND_FLAG_FW_SUSPEND		BIT(0)
+#define PM_SUSPEND_FLAG_FW_RESUME		BIT(1)
+#define PM_SUSPEND_FLAG_NO_PLATFORM		BIT(2)
+#define PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT	BIT(3)
 
 static inline void pm_suspend_clear_flags(void)
 {
@@ -234,6 +235,11 @@ static inline void pm_set_suspend_no_platform(void)
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
 }
 
+static inline void pm_set_power_loss_imminent(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT;
+}
+
 /**
  * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
  *
@@ -291,6 +297,22 @@ static inline bool pm_suspend_no_platform(void)
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
 }
 
+/**
+ * pm_power_loss_imminent - Check if platform is running on limited backup power
+ * source
+ *
+ * To be called during system-wide power management transitions to sleep states.
+ *
+ * Return 'true' if power loss may be imminent due to platform running on
+ * limited backup supply. If set during a shutdown, drivers should use any
+ * available shortcuts to prepare their device for abrupt power loss.
+ */
+static inline bool pm_power_loss_imminent(void)
+{
+	return !!(pm_suspend_global_flags &
+		  PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT);
+}
+
 /* Suspend-to-idle state machnine. */
 enum s2idle_states {
 	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
-- 
2.25.1

