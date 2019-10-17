Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09C0DAC1E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502320AbfJQM1t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:27:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43691 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502318AbfJQM1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 08:27:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so1268366pgl.10
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ILr9joUKye34Z5XuMa3tOX2NbCDB31U4gUj4EK9AjAc=;
        b=LFUgaeMdjVeFcNKERe9xHFpUZYWPcsn8/0qej7QjTdu5UabxWgRjnT6NzE3yRrQb6i
         LII1mzhB362FPr3U6rvDWoFg2f/Ll4TxW4TRRPhwIQRA161dxfolDo7NUFRjWLIfMIEa
         IzBLeDnElE12GG44AQ9OP95rnWvjhVto1pY4aqXrWR2pAWGNy85FFXsRXXqcCXThQuXd
         dBWszGjkGGA3X4B3G2qLLGnKthf1JvgwwCV9DI/pgLmGfJHiwrvy5sPsucbnfYOQzgA9
         4QXz7LhTzFXowaAPOxY2PnXfBkM4DEo2kzvS7LaLk3+aVYy7JE91a2H3FEeul8C7oe0r
         gSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ILr9joUKye34Z5XuMa3tOX2NbCDB31U4gUj4EK9AjAc=;
        b=NlvqC+Vr7p13QtvDF5WGWhi3OMbd+kJgi/TJFSBVSNAOixjrCkD9C7jkgX3nTRBa94
         femCzdl/2D3mAh5z0KV6Uo/FKj4LuOud1RczaF7YN22m4vyc05ByG7kru8BZPYX7yGaL
         XZlIiroVVsVOZKN4SLftR4DB8xh6MaNlyAeJoePpnuK7IU5TgnQQp9FxutMLQDTBmMLj
         rXMElwALM+/xyOp3moRJYap4TbPPuvceAF2hhxE//ql9ZKkMihi7UvemarPESCqeuRWC
         VJFPaP3h1YrxygkaOiBbdOH/0K0eHqaKroA6lBDtlfEz1gjJXVqVOXExnpw8TtYNGBnq
         2K3w==
X-Gm-Message-State: APjAAAW4QR+vQ0igaHHPx1cn7SFjOD5MejmZnBiH1FG9lU4p8m34pRoH
        eWna6Q+yvp3uY2dtV3u1IfMM1w==
X-Google-Smtp-Source: APXvYqy5uEgxPYOkmUJWAWdV5xV2aaKIGmNBY8acLpKp4r+NJadQlG+OI6nX8HZ0H4ECLRJmKxketA==
X-Received: by 2002:a17:90a:aa97:: with SMTP id l23mr4002710pjq.7.1571315267761;
        Thu, 17 Oct 2019 05:27:47 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id ep10sm15468221pjb.2.2019.10.17.05.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:27:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 1/6] thermal: Remove netlink support
Date:   Thu, 17 Oct 2019 17:57:33 +0530
Message-Id: <cc1b26eb9efa974bc4d36a2944d4064df0c37983.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are no users of netlink messages for thermal inside the kernel.
Remove the code and adjust the documentation.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../driver-api/thermal/sysfs-api.rst          |  26 +----
 drivers/thermal/thermal_core.c                | 107 +-----------------
 include/linux/thermal.h                       |  11 --
 3 files changed, 10 insertions(+), 134 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index fab2c9b36d08..b40b1f839148 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -725,24 +725,10 @@ method, the sys I/F structure will be built like this::
     |---temp1_input:		37000
     |---temp1_crit:		100000
 
-4. Event Notification
+4. Export Symbol APIs
 =====================
 
-The framework includes a simple notification mechanism, in the form of a
-netlink event. Netlink socket initialization is done during the _init_
-of the framework. Drivers which intend to use the notification mechanism
-just need to call thermal_generate_netlink_event() with two arguments viz
-(originator, event). The originator is a pointer to struct thermal_zone_device
-from where the event has been originated. An integer which represents the
-thermal zone device will be used in the message to identify the zone. The
-event will be one of:{THERMAL_AUX0, THERMAL_AUX1, THERMAL_CRITICAL,
-THERMAL_DEV_FAULT}. Notification can be sent when the current temperature
-crosses any of the configured thresholds.
-
-5. Export Symbol APIs
-=====================
-
-5.1. get_tz_trend
+4.1. get_tz_trend
 -----------------
 
 This function returns the trend of a thermal zone, i.e the rate of change
@@ -751,14 +737,14 @@ are supposed to implement the callback. If they don't, the thermal
 framework calculated the trend by comparing the previous and the current
 temperature values.
 
-5.2. get_thermal_instance
+4.2. get_thermal_instance
 -------------------------
 
 This function returns the thermal_instance corresponding to a given
 {thermal_zone, cooling_device, trip_point} combination. Returns NULL
 if such an instance does not exist.
 
-5.3. thermal_notify_framework
+4.3. thermal_notify_framework
 -----------------------------
 
 This function handles the trip events from sensor drivers. It starts
@@ -768,14 +754,14 @@ and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
 The throttling policy is based on the configured platform data; if no
 platform data is provided, this uses the step_wise throttling policy.
 
-5.4. thermal_cdev_update
+4.4. thermal_cdev_update
 ------------------------
 
 This function serves as an arbitrator to set the state of a cooling
 device. It sets the cooling device to the deepest cooling state if
 possible.
 
-6. thermal_emergency_poweroff
+5. thermal_emergency_poweroff
 =============================
 
 On an event of critical trip temperature crossing. Thermal framework
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4481cc8958f..d21b754baee2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -19,8 +19,6 @@
 #include <linux/reboot.h>
 #include <linux/string.h>
 #include <linux/of.h>
-#include <net/netlink.h>
-#include <net/genetlink.h>
 #include <linux/suspend.h>
 
 #define CREATE_TRACE_POINTS
@@ -1464,97 +1462,6 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
-#ifdef CONFIG_NET
-static const struct genl_multicast_group thermal_event_mcgrps[] = {
-	{ .name = THERMAL_GENL_MCAST_GROUP_NAME, },
-};
-
-static struct genl_family thermal_event_genl_family __ro_after_init = {
-	.module = THIS_MODULE,
-	.name = THERMAL_GENL_FAMILY_NAME,
-	.version = THERMAL_GENL_VERSION,
-	.maxattr = THERMAL_GENL_ATTR_MAX,
-	.mcgrps = thermal_event_mcgrps,
-	.n_mcgrps = ARRAY_SIZE(thermal_event_mcgrps),
-};
-
-int thermal_generate_netlink_event(struct thermal_zone_device *tz,
-				   enum events event)
-{
-	struct sk_buff *skb;
-	struct nlattr *attr;
-	struct thermal_genl_event *thermal_event;
-	void *msg_header;
-	int size;
-	int result;
-	static unsigned int thermal_event_seqnum;
-
-	if (!tz)
-		return -EINVAL;
-
-	/* allocate memory */
-	size = nla_total_size(sizeof(struct thermal_genl_event)) +
-	       nla_total_size(0);
-
-	skb = genlmsg_new(size, GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
-
-	/* add the genetlink message header */
-	msg_header = genlmsg_put(skb, 0, thermal_event_seqnum++,
-				 &thermal_event_genl_family, 0,
-				 THERMAL_GENL_CMD_EVENT);
-	if (!msg_header) {
-		nlmsg_free(skb);
-		return -ENOMEM;
-	}
-
-	/* fill the data */
-	attr = nla_reserve(skb, THERMAL_GENL_ATTR_EVENT,
-			   sizeof(struct thermal_genl_event));
-
-	if (!attr) {
-		nlmsg_free(skb);
-		return -EINVAL;
-	}
-
-	thermal_event = nla_data(attr);
-	if (!thermal_event) {
-		nlmsg_free(skb);
-		return -EINVAL;
-	}
-
-	memset(thermal_event, 0, sizeof(struct thermal_genl_event));
-
-	thermal_event->orig = tz->id;
-	thermal_event->event = event;
-
-	/* send multicast genetlink message */
-	genlmsg_end(skb, msg_header);
-
-	result = genlmsg_multicast(&thermal_event_genl_family, skb, 0,
-				   0, GFP_ATOMIC);
-	if (result)
-		dev_err(&tz->device, "Failed to send netlink event:%d", result);
-
-	return result;
-}
-EXPORT_SYMBOL_GPL(thermal_generate_netlink_event);
-
-static int __init genetlink_init(void)
-{
-	return genl_register_family(&thermal_event_genl_family);
-}
-
-static void genetlink_exit(void)
-{
-	genl_unregister_family(&thermal_event_genl_family);
-}
-#else /* !CONFIG_NET */
-static inline int genetlink_init(void) { return 0; }
-static inline void genetlink_exit(void) {}
-#endif /* !CONFIG_NET */
-
 static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
@@ -1601,19 +1508,15 @@ static int __init thermal_init(void)
 	mutex_init(&poweroff_lock);
 	result = thermal_register_governors();
 	if (result)
-		goto error;
+		goto init_exit;
 
 	result = class_register(&thermal_class);
 	if (result)
 		goto unregister_governors;
 
-	result = genetlink_init();
-	if (result)
-		goto unregister_class;
-
 	result = of_parse_thermal_zones();
 	if (result)
-		goto exit_netlink;
+		goto exit_zone_parse;
 
 	result = register_pm_notifier(&thermal_pm_nb);
 	if (result)
@@ -1622,13 +1525,11 @@ static int __init thermal_init(void)
 
 	return 0;
 
-exit_netlink:
-	genetlink_exit();
-unregister_class:
+exit_zone_parse:
 	class_unregister(&thermal_class);
 unregister_governors:
 	thermal_unregister_governors();
-error:
+init_exit:
 	ida_destroy(&thermal_tz_ida);
 	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c75920..d9111aebb97d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -544,15 +544,4 @@ static inline void thermal_notify_framework(struct thermal_zone_device *tz,
 { }
 #endif /* CONFIG_THERMAL */
 
-#if defined(CONFIG_NET) && IS_ENABLED(CONFIG_THERMAL)
-extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
-						enum events event);
-#else
-static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
-						enum events event)
-{
-	return 0;
-}
-#endif
-
 #endif /* __THERMAL_H__ */
-- 
2.17.1

