Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92831F5FB6
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 03:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgFKByM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 21:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgFKByH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 21:54:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92DBC08C5C5
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 18:54:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so1701359pjv.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 18:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1X3ZX/iOwR/Uqfzsx2X/9AVb+bv3TKUHZzyCIU6EnHM=;
        b=byQoXdL9yUHiIdagQ/QkxkdVIIOdOM55WxCDdNr3/Xu+1inMXbhoEVAhu38ZZyoYSt
         mrhebQIUmr+EWcM577PZstHgA0MKAo9Yho38axOk/AAPQbtzUYm6PUCvsSqinCrEQUgx
         LEdJwoj1zqLe6bjhKXQ9Q8BCIGOutpDUq7apU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1X3ZX/iOwR/Uqfzsx2X/9AVb+bv3TKUHZzyCIU6EnHM=;
        b=GyptkN60knRZ837ltZdiS1AfxJBtskjxBLGY9TzUFpzxzW0K4fqnaQH1knMfIk/iao
         4BouIFi8j+hyqj58EYEOF5pEsP7trBzwADIDGMaUckoo8ALvFTpnj5w5v9nv3HBoMUYw
         gzsYyoRtcQRC1h8xBYsZ05Pjg8KdTxgo7oj2/4OsWU0L6YnQ9iP+1Vwu2B86Q+tzl1IC
         YqmVXULvhL+ecpbHno4PfbEgkEfip2jcpDSCLDftPS0y2MlZyJj0CVhoUJizoSqjf0q9
         xjk0rvRVZXQsNgYBrXGeFqsfpJfZLVNSJ/maA3bdsplHQpIeCpEx7gpR6nzFgdJO3UNu
         dfBA==
X-Gm-Message-State: AOAM531zDvniXT7d5ReUdOS3HjJL7gkyGTIxu2t1Z3+4NKryIL+UDUWE
        ZoLmOX5JAJSurvBF2CWFYPbcrQ==
X-Google-Smtp-Source: ABdhPJxww6szgbZ7bos55brDGgfFhu9RmKbp4hX7/6AFdIVAZUjqS8/AG1a9V5KiAsusG3waIK1W3A==
X-Received: by 2002:a17:90a:f3d6:: with SMTP id ha22mr5625289pjb.193.1591840446227;
        Wed, 10 Jun 2020 18:54:06 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b191sm998661pga.13.2020.06.10.18.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:54:05 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtman.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        mka@chromium.org, dianders@chromium.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btmrvl_sdio: Refactor irq wakeup
Date:   Wed, 10 Jun 2020 18:53:55 -0700
Message-Id: <20200610185214.3.If7946e7127c13a422d8c41d10dc8e6fe71396c8c@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200611015355.186666-1-abhishekpandit@chromium.org>
References: <20200611015355.186666-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use device_init_wakeup to allow the Bluetooth dev to wake the system
from suspend. Currently, the device can wake the system but no
power/wakeup entry is created in sysfs to allow userspace to disable
wakeup.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/btmrvl_sdio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 4c7978cb1786fc..cfb9f9db44a0d9 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -111,6 +111,9 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 					"Failed to request irq_bt %d (%d)\n",
 					cfg->irq_bt, ret);
 			}
+
+			/* Configure wakeup (enabled by default) */
+			device_init_wakeup(dev, true);
 			disable_irq(cfg->irq_bt);
 		}
 	}
@@ -1654,6 +1657,7 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
 							MODULE_SHUTDOWN_REQ);
 				btmrvl_sdio_disable_host_int(card);
 			}
+
 			BT_DBG("unregister dev");
 			card->priv->surprise_removed = true;
 			btmrvl_sdio_unregister_dev(card);
@@ -1690,7 +1694,8 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	}
 
 	/* Enable platform specific wakeup interrupt */
-	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0) {
+	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
+	    device_may_wakeup(dev)) {
 		card->plt_wake_cfg->wake_by_bt = false;
 		enable_irq(card->plt_wake_cfg->irq_bt);
 		enable_irq_wake(card->plt_wake_cfg->irq_bt);
@@ -1707,7 +1712,8 @@ static int btmrvl_sdio_suspend(struct device *dev)
 			BT_ERR("HS not activated, suspend failed!");
 			/* Disable platform specific wakeup interrupt */
 			if (card->plt_wake_cfg &&
-			    card->plt_wake_cfg->irq_bt >= 0) {
+			    card->plt_wake_cfg->irq_bt >= 0 &&
+			    device_may_wakeup(dev)) {
 				disable_irq_wake(card->plt_wake_cfg->irq_bt);
 				disable_irq(card->plt_wake_cfg->irq_bt);
 			}
@@ -1767,7 +1773,8 @@ static int btmrvl_sdio_resume(struct device *dev)
 	hci_resume_dev(hcidev);
 
 	/* Disable platform specific wakeup interrupt */
-	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0) {
+	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
+	    device_may_wakeup(dev)) {
 		disable_irq_wake(card->plt_wake_cfg->irq_bt);
 		disable_irq(card->plt_wake_cfg->irq_bt);
 		if (card->plt_wake_cfg->wake_by_bt)
-- 
2.27.0.278.ge193c7cf3a9-goog

