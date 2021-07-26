Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9813D5A42
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhGZMnD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 08:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhGZMnA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 08:43:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE9C061757;
        Mon, 26 Jul 2021 06:23:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z8-20020a1c4c080000b029022d4c6cfc37so8163226wmf.5;
        Mon, 26 Jul 2021 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUFZDTLZHnU1oCPFZuxkDptiIQaZJMAsbw41GQLH7/Q=;
        b=IVoYLwOw5JN1oCFRdvUg0eLbzGchcEB8nZCO7lBZhKB/8147IS7l3Yk1H31VVU3z2A
         Zzi36BJr0BwAccqS8ToN9U0HVBotwuEE+JTetVSy8mpum60gIVHO2OBJFS4REbtEP5Oi
         vBzB3MZLaBo0vQc1+kq0IDflWaKKybxZ9qT7Moyo+upVzVdzOvn14PwjsxfsePynInWd
         +DTZmblbrQJDUK1SVfCaP4ayBNbBH4gU+KS0arMq8rxDVwZzebCB8org+MoHCC5Sc/zw
         HVp7edtE6LYcA9tWPN26xxlWcF/pUlLJ+f9aGbf1ttBJbJbBBJ7MEIB4xL4/pb/rcYDH
         JywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUFZDTLZHnU1oCPFZuxkDptiIQaZJMAsbw41GQLH7/Q=;
        b=ALx1EJKMMOUdaj6xyl11IK14SVBWY6voOH1TOrye7PmcJS52nOjahKlNiTw4PvlzdB
         qgYYY4dbEUhIfmCvUnl1re966NyDTAVbuBAyBk6tY7k8pxukS13ryTJN2nwVuWxBebHG
         9G3fWvnSj09xei5+RhSyZI81xQiCHwp5/54TmWCuckP9cL/CDzQna6/OHFNgUi4/Scc2
         6fAJsDmrSSXLdMEP2ah8Y6D3tsokr7Ziu4MxVKEf/g3H/IRJhAdUcYmNIGnc7wI1oSEM
         HBPhMK3SgLH686HrcDw98hK3PXnIvio/yMv6hB1ZPAnL6CeBdQpZOOuJkCxRpsMQGVAl
         W7oA==
X-Gm-Message-State: AOAM530kVfoS6tmXEg2V1cwpLTiIAlSR2HOzB1JjGf1ciDMG1Ir3MzLQ
        36l35D1esHc/CEiH5IDSku8=
X-Google-Smtp-Source: ABdhPJzcV8t+TGXZXIiVaksrhgLSCW6B1efSSPRuIX4BgWqT3wYH/A5WVMjNZNNYTKPji0dxHBj9ag==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr10032791wmq.22.1627305806793;
        Mon, 26 Jul 2021 06:23:26 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de. [95.90.192.255])
        by smtp.gmail.com with ESMTPSA id w15sm8580wmi.3.2021.07.26.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:23:26 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v2 2/2] nvme: Add abrupt shutdown support
Date:   Mon, 26 Jul 2021 13:22:23 +0000
Message-Id: <20210726132223.1661-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726132223.1661-1-sshivamurthy@micron.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Enabling the abrupt shutdown support. In this shutdown type, the host does
not need to send Delete I/O Submission Queue and Delete I/O Completion
Queue commands to the device.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 drivers/nvme/host/pci.c  | 6 ++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11779be42186..760ffb071c1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
 #include <linux/pm_qos.h>
+#include <linux/suspend.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
@@ -2159,7 +2160,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	if (pm_power_loss_imminent())
+		ctrl->ctrl_config |= NVME_CC_SHN_ABRUPT;
+	else
+		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 320051f5a3dd..07be319f63d9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/suspend.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -2524,13 +2525,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead && shutdown && freeze)
+	if (!dead && shutdown && !pm_power_loss_imminent() && freeze)
 		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		nvme_disable_io_queues(dev);
+		if (!pm_power_loss_imminent())
+			nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_suspend_io_queues(dev);
-- 
2.25.1

