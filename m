Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6673F30547A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316587AbhA0Alj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 19:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730652AbhAZVaZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 16:30:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A48220449;
        Tue, 26 Jan 2021 21:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611696585;
        bh=bbHTgnTCmECprHSRP1JM2IWa3yBJ8AH/xVwCfXbtiWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=De6Sf95lmsUQFB9uMG+sz2656Hp0Z5fNzWn+C9aJeHLSugDBsgqVHaBO/561EgsYE
         mHOcRjsIFs7vawJ6tH6gDY+HSul+jOZxJlHX7VYmy8uxsy4v0WeDIRQ+x+ibiua1cR
         3yDNvc3+q0AFUylfhirFV0UHm+vWLKphxZBQENSB9J3lNHA+Vr4vgCaei2vNz/fqlE
         YWglEr6duLnZJcDY2CQeNb994xBs2WHn/XFjPTw/CBgFIlYVE3WkK0n+p0653UaTzl
         VnB4M0ym0SYMKPxSmVoSRkloSnfmEljGM5LpaukEKPnhx6ev+zQFWQ2/4b4dIlEsIt
         PzneQ8wqs0eLA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PM: Use dev_printk() when possible
Date:   Tue, 26 Jan 2021 15:29:40 -0600
Message-Id: <20210126212940.2922275-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() when possible to make messages more consistent with other
device-related messages.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/base/power/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 46793276598d..f893c3c5af07 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -16,6 +16,7 @@
  */
 
 #define pr_fmt(fmt) "PM: " fmt
+#define dev_fmt pr_fmt
 
 #include <linux/device.h>
 #include <linux/export.h>
@@ -449,8 +450,8 @@ static void pm_dev_dbg(struct device *dev, pm_message_t state, const char *info)
 static void pm_dev_err(struct device *dev, pm_message_t state, const char *info,
 			int error)
 {
-	pr_err("Device %s failed to %s%s: error %d\n",
-	       dev_name(dev), pm_verb(state.event), info, error);
+	dev_err(dev, "failed to %s%s: error %d\n", pm_verb(state.event), info,
+		error);
 }
 
 static void dpm_show_time(ktime_t starttime, pm_message_t state, int error,
@@ -1897,8 +1898,8 @@ int dpm_prepare(pm_message_t state)
 				error = 0;
 				continue;
 			}
-			pr_info("Device %s not prepared for power transition: code %d\n",
-				dev_name(dev), error);
+			dev_info(dev, "not prepared for power transition: code %d\n",
+				 error);
 			put_device(dev);
 			break;
 		}
-- 
2.25.1

