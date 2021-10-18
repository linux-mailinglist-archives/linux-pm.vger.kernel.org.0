Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4215E4317BC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJRLsM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhJRLsL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:11 -0400
Date:   Mon, 18 Oct 2021 11:45:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhJVu8ebLMnM3z5GSHjOaIOjmCWYB4dLyxoav1f7dMM=;
        b=cl1ZUkG7uPiu/dNCdJzXWpiUrIbjKmZcyRdjAF45A6hrG2X4BAynVpReLutPeDm/3vr2Ft
        eRcfuuOTHHrRDNF4inK9J0scWlosF6sQD04yCZ2iJlDNRBsBl+pmXEYervwnMnrtu/MyTa
        pMuv1dcqnccAqN8yyA7I0DObsoEhaoLLoNNp6/dC2EE88nrevegGH3qA6DqZP6RuzFfwmF
        G6jC+ZGCjNKELx2mV4vFGGFkoE5c/tPRXcLjKH/IQIAjBSFTZbO/e9uq+9oJ8GRraez35s
        2NwB6b+NqKKqxleA5ANIC7Tvv7WqPZKYpgGoD2do8LTm0rakogUDvUwxYtQKNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhJVu8ebLMnM3z5GSHjOaIOjmCWYB4dLyxoav1f7dMM=;
        b=avgTJpK/4mYwJctfufRAOOUnOx2dE7qK7MYci8hEeydZVIj+GVM6YqJjSPoU8Ss901vThB
        uht87tTeEvvzriCQ==
From:   "thermal-bot for Yuanzheng Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Fix null pointer dereference in
 thermal_release()
Cc:     Yuanzheng Song <songyuanzheng@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211015083230.67658-1-songyuanzheng@huawei.com>
References: <20211015083230.67658-1-songyuanzheng@huawei.com>
MIME-Version: 1.0
Message-ID: <163455755909.25758.11632039922962462144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1dd7128b839f631b31a9e9dce3aaf639bef74e9d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1dd7128b839f631b31a9e9dce3aaf639bef74e9d
Author:        Yuanzheng Song <songyuanzheng@huawei.com>
AuthorDate:    Fri, 15 Oct 2021 08:32:30 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 15 Oct 2021 13:58:36 +02:00

thermal/core: Fix null pointer dereference in thermal_release()

If both dev_set_name() and device_register() failed, then null pointer
dereference occurs in thermal_release() which will use strncmp() to
compare the name.

So fix it by adding dev_set_name() return value check.

Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
Link: https://lore.kernel.org/r/20211015083230.67658-1-songyuanzheng@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9e243d9..6904b97 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -904,6 +904,10 @@ __thermal_cooling_device_register(struct device_node *np,
 		goto out_kfree_cdev;
 	cdev->id = ret;
 
+	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
+	if (ret)
+		goto out_ida_remove;
+
 	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
 	if (!cdev->type) {
 		ret = -ENOMEM;
@@ -918,7 +922,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 	thermal_cooling_device_setup_sysfs(cdev);
-	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_kfree_type;
@@ -1229,6 +1232,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->id = id;
 	strlcpy(tz->type, type, sizeof(tz->type));
 
+	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
+	if (result)
+		goto remove_id;
+
 	if (!ops->critical)
 		ops->critical = thermal_zone_device_critical;
 
@@ -1250,7 +1257,6 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
-	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
