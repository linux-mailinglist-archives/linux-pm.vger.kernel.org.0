Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B911933F095
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCQMjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhCQMjN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:13 -0400
Date:   Wed, 17 Mar 2021 12:39:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbYPZJMit2S6mcexfMsE9CKRGjsB5bQkGXLvdlG5gis=;
        b=BMBC8CvEHSaRbktI1Kdj8LAzS4yAN7/GPugUODfALeh7ET2X54EwXOqgQP6jhwWKJQ9Vu3
        dfDJvdlyCfFos+pbEyWlYQShlTmyor+h0pBvmLCIqGbUriRjRM6rjRD3tQxiefSSRJAFK3
        t44JVx5CLnM31xzv38rcw3U4X6UrHGZcvqkYqsEWNp0jkZYFlDtWNS9LR/YGaaPbuPEETF
        ScKQT9vNpxrdJuXWhZQbs+hCD9DT3maVTjNBS4oucVYkEhPiB+ERaDKPAKmW+2jN0OAnRT
        ClafbTCxOIZ3VQHpU+FY7Ne4WwBVrEIM4Zpv8p6hUOpZimzC8IUmynNEhiP21w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbYPZJMit2S6mcexfMsE9CKRGjsB5bQkGXLvdlG5gis=;
        b=6qFvvF7LABJ6sVljQzphffl+MK/8Si26mV0kdTqZvGwSLMERymFnr8Az40ci2viYrVAcs0
        f5uCWeF118YpBNAA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/core: Use a char pointer for
 the cooling device name
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ido Schimmel <idosch@nvidia.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210314111333.16551-1-daniel.lezcano@linaro.org>
References: <20210314111333.16551-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161598475138.398.3398009902870639070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     58483761810087e5ffdf36e84ac1bf26df909097
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//58483761810087e5ffdf36e84ac1bf26df909097
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Sun, 14 Mar 2021 12:13:29 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Mar 2021 04:46:25 +01:00

thermal/drivers/core: Use a char pointer for the cooling device name

We want to have any kind of name for the cooling devices as we do no
longer want to rely on auto-numbering. Let's replace the cooling
device's fixed array by a char pointer to be allocated dynamically
when registering the cooling device, so we don't limit the length of
the name.

Rework the error path at the same time as we have to rollback the
allocations in case of error.

Tested with a dummy device having the name:
 "Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch"

A village on the island of Anglesey (Wales), known to have the longest
name in Europe.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20210314111333.16551-1-daniel.lezcano@linaro.org
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  2 +-
 drivers/thermal/thermal_core.c                     | 38 +++++++------
 include/linux/thermal.h                            |  2 +-
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index bf85ce9..7447c2a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -141,7 +141,7 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_thermal *thermal,
 	/* Allow mlxsw thermal zone binding to an external cooling device */
 	for (i = 0; i < ARRAY_SIZE(mlxsw_thermal_external_allowed_cdev); i++) {
 		if (strnstr(cdev->type, mlxsw_thermal_external_allowed_cdev[i],
-			    sizeof(cdev->type)))
+			    strlen(cdev->type)))
 			return 0;
 	}
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 996c038..c8d4010 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -960,10 +960,7 @@ __thermal_cooling_device_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
-	int result;
-
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
-		return ERR_PTR(-EINVAL);
+	int ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
@@ -973,14 +970,17 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	result = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
-	if (result < 0) {
-		kfree(cdev);
-		return ERR_PTR(result);
+	ret = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto out_kfree_cdev;
+	cdev->id = ret;
+
+	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
+	if (!cdev->type) {
+		ret = -ENOMEM;
+		goto out_ida_remove;
 	}
 
-	cdev->id = result;
-	strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->np = np;
@@ -990,12 +990,9 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->devdata = devdata;
 	thermal_cooling_device_setup_sysfs(cdev);
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-	result = device_register(&cdev->device);
-	if (result) {
-		ida_simple_remove(&thermal_cdev_ida, cdev->id);
-		put_device(&cdev->device);
-		return ERR_PTR(result);
-	}
+	ret = device_register(&cdev->device);
+	if (ret)
+		goto out_kfree_type;
 
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
@@ -1013,6 +1010,14 @@ __thermal_cooling_device_register(struct device_node *np,
 	mutex_unlock(&thermal_list_lock);
 
 	return cdev;
+
+out_kfree_type:
+	kfree(cdev->type);
+	put_device(&cdev->device);
+out_ida_remove:
+	ida_simple_remove(&thermal_cdev_ida, cdev->id);
+out_kfree_cdev:
+	return ERR_PTR(ret);
 }
 
 /**
@@ -1171,6 +1176,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 	device_del(&cdev->device);
 	thermal_cooling_device_destroy_sysfs(cdev);
+	kfree(cdev->type);
 	put_device(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6ac7bb1..1695021 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -91,7 +91,7 @@ struct thermal_cooling_device_ops {
 
 struct thermal_cooling_device {
 	int id;
-	char type[THERMAL_NAME_LENGTH];
+	char *type;
 	struct device device;
 	struct device_node *np;
 	void *devdata;
