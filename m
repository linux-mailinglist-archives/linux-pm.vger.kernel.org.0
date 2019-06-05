Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FB3363B0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 21:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFETCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 15:02:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51862 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFETCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 15:02:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A4E54260D04
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 2/2] PM / devfreq: Sanitize prints
Date:   Wed,  5 Jun 2019 16:00:53 -0300
Message-Id: <20190605190053.19177-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605190053.19177-1-ezequiel@collabora.com>
References: <20190605190053.19177-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit is a simple cosmetic cleanup, where pr_fmt is used to avoid
the "DEVFREQ" prefix in some prints.

Also, messages are changed to not start with a capital. This is just
a cosmetic change, meant to sanitize all prints from this file.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/devfreq/devfreq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8868ad9472d2..44392fa1c570 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -10,6 +10,8 @@
  * published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/kmod.h>
 #include <linux/sched.h>
@@ -59,7 +61,7 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 	struct devfreq *tmp_devfreq;
 
 	if (IS_ERR_OR_NULL(dev)) {
-		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
+		pr_err("%s: invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 	WARN(!mutex_is_locked(&devfreq_list_lock),
@@ -208,7 +210,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 	struct devfreq_governor *tmp_governor;
 
 	if (IS_ERR_OR_NULL(name)) {
-		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
+		pr_err("%s: invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 	WARN(!mutex_is_locked(&devfreq_list_lock),
@@ -238,7 +240,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 	struct devfreq_governor *governor;
 
 	if (IS_ERR_OR_NULL(name)) {
-		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
+		pr_err("%s: invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 	WARN(!mutex_is_locked(&devfreq_list_lock),
@@ -1001,7 +1003,7 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 	int err = 0;
 
 	if (!governor) {
-		pr_err("%s: Invalid parameters.\n", __func__);
+		pr_err("%s: invalid parameters.\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1066,7 +1068,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 	int err = 0;
 
 	if (!governor) {
-		pr_err("%s: Invalid parameters.\n", __func__);
+		pr_err("%s: invalid parameters.\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.20.1

