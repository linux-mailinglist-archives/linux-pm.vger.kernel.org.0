Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA65357BF
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiE0CfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiE0CfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C71E7314;
        Thu, 26 May 2022 19:35:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y13so6262047eje.2;
        Thu, 26 May 2022 19:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEpXPpRS/5QxndLI9caFmdEj5m5kXkNtGuMRlWBrSHs=;
        b=E0X+qqXdPlSBjWfSZWa+ICMusFqhIoGS42UiY0itOBoQB4pVR98XEZQwW8nSnDKtmk
         aPx74iZU8DFBUshDl/7ysH4ZHwZEeShl9eYhc2KAT5wM8VlAc2WDuylBe9A/uwRChyVx
         N/er9tIgSM4ytG5nblD2BOyLYivGRTXjFhQRem1hUnrqACePVsNHZwzi5oem3O6poyNP
         eCsCwoXowtdY9D7qJr+hXSroVUC6+LZ3z1jzP73AcGzyA5Bt7A0njy/9aF6k7fBhYO70
         B71fnFFjjTZjN1qag08VJPvfupjYJVdeTAEr5TqgHdBGCbGXaYNNddv89zSP0UN1lCSg
         AqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEpXPpRS/5QxndLI9caFmdEj5m5kXkNtGuMRlWBrSHs=;
        b=b27CbXaOjbEHrma/Hs7YEYjLtqAcrstJCestiTJqiuuEdvJU44NeNwtl4iEXL9RrPL
         gBu/5Rj8KxxcTK3nRSqz8hjXYfymQp3C4VBPS3G5eZAUauyna2sCYlibQqwQI62Kovuk
         2CA+/Rs+zdjiKcBYCJzrdpNynw6+S4lV515pm3nJiBHXyEXK5uUYXxcpp60zea2BWNRp
         NeJlMwTDnm5saG+Q2cBL628gG+I+2q7QXODv0eAgjqkH14RoGM8Qv9vx+OK5n4+nRvuX
         GrzycTkP3uynRbsypCP7ThEJg7PhK8vHulJm1JTj+kalBFstKJnjO+9IZcEvT+V1iD7Q
         Zpuw==
X-Gm-Message-State: AOAM530hRTDj319csYiRQpBi3DnbSOl73/KvVWKUGP/DdOkXsPEk/Egb
        GIBVGWKphJ7evxRJD+uoHJA=
X-Google-Smtp-Source: ABdhPJxTEXI2CnUyNYnjLff1cIxUJ5S157/ZO0ITikjHN7FjsG0Q3NjvxHDeMMx1udSR+WNY5sBkNg==
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id nb7-20020a1709071c8700b006f029eacc01mr36071041ejc.671.1653618912880;
        Thu, 26 May 2022 19:35:12 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:12 -0700 (PDT)
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
Subject: [PATCH v2 09/12] platform/surface: aggregator_registry: Generify subsystem hub functionality
Date:   Fri, 27 May 2022 04:34:44 +0200
Message-Id: <20220527023447.2460025-10-luzmaximilian@gmail.com>
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

The Surface System Aggregator Module (SSAM) has multiple subsystems that
can manage detachable devices. At the moment, we only support the "base"
(BAS/0x11) subsystem, which is used on the Surface Book 3 to manage
devices (including keyboard, touchpad, and secondary battery) connected
to the base of the device.

The Surface Pro 8 has a new type-cover with keyboard and touchpad, which
is managed via the KIP/0x0e subsystem. The general procedure is the
same, but with slightly different events and setup. To make
implementation of the KIP hub easier and prevent duplication, generify
the parts of the base hub that we can use for the KIP hub (or any
potential future subsystem hubs).

This also switches over to use the newly introduced "hot-remove"
functionality, which should prevent communication issues when devices
have been detached.

Lastly, also drop the undocumented and unused sysfs "state" attribute of
the base hub. It has at best been useful for debugging.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - none

---
 .../surface/surface_aggregator_registry.c     | 269 ++++++++++--------
 1 file changed, 153 insertions(+), 116 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 9f630e890ff7..09cbeee2428b 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -308,30 +308,159 @@ static int ssam_hub_register_clients(struct device *parent, struct ssam_controll
 }
 
 
-/* -- SSAM base-hub driver. ------------------------------------------------- */
+/* -- SSAM generic subsystem hub driver framework. -------------------------- */
 
-/*
- * Some devices (especially battery) may need a bit of time to be fully usable
- * after being (re-)connected. This delay has been determined via
- * experimentation.
- */
-#define SSAM_BASE_UPDATE_CONNECT_DELAY		msecs_to_jiffies(2500)
+enum ssam_hub_state {
+	SSAM_HUB_UNINITIALIZED,		/* Only set during initialization. */
+	SSAM_HUB_CONNECTED,
+	SSAM_HUB_DISCONNECTED,
+};
 
-enum ssam_base_hub_state {
-	SSAM_BASE_HUB_UNINITIALIZED,
-	SSAM_BASE_HUB_CONNECTED,
-	SSAM_BASE_HUB_DISCONNECTED,
+enum ssam_hub_flags {
+	SSAM_HUB_HOT_REMOVED,
 };
 
-struct ssam_base_hub {
+struct ssam_hub {
 	struct ssam_device *sdev;
 
-	enum ssam_base_hub_state state;
+	enum ssam_hub_state state;
+	unsigned long flags;
+
 	struct delayed_work update_work;
+	unsigned long connect_delay;
 
 	struct ssam_event_notifier notif;
+
+	int (*get_state)(struct ssam_hub *hub, enum ssam_hub_state *state);
 };
 
+static void ssam_hub_update_workfn(struct work_struct *work)
+{
+	struct ssam_hub *hub = container_of(work, struct ssam_hub, update_work.work);
+	struct fwnode_handle *node = dev_fwnode(&hub->sdev->dev);
+	enum ssam_hub_state state;
+	int status = 0;
+
+	status = hub->get_state(hub, &state);
+	if (status)
+		return;
+
+	/*
+	 * There is a small possibility that hub devices were hot-removed and
+	 * re-added before we were able to remove them here. In that case, both
+	 * the state returned by get_state() and the state of the hub will
+	 * equal SSAM_HUB_CONNECTED and we would bail early below, which would
+	 * leave child devices without proper (re-)initialization and the
+	 * hot-remove flag set.
+	 *
+	 * Therefore, we check whether devices have been hot-removed via an
+	 * additional flag on the hub and, in this case, override the returned
+	 * hub state. In case of a missed disconnect (i.e. get_state returned
+	 * "connected"), we further need to re-schedule this work (with the
+	 * appropriate delay) as the actual connect work submission might have
+	 * been merged with this one.
+	 *
+	 * This then leads to one of two cases: Either we submit an unnecessary
+	 * work item (which will get ignored via either the queue or the state
+	 * checks) or, in the unlikely case that the work is actually required,
+	 * double the normal connect delay.
+	 */
+	if (test_and_clear_bit(SSAM_HUB_HOT_REMOVED, &hub->flags)) {
+		if (state == SSAM_HUB_CONNECTED)
+			schedule_delayed_work(&hub->update_work, hub->connect_delay);
+
+		state = SSAM_HUB_DISCONNECTED;
+	}
+
+	if (hub->state == state)
+		return;
+	hub->state = state;
+
+	if (hub->state == SSAM_HUB_CONNECTED)
+		status = ssam_hub_register_clients(&hub->sdev->dev, hub->sdev->ctrl, node);
+	else
+		ssam_remove_clients(&hub->sdev->dev);
+
+	if (status)
+		dev_err(&hub->sdev->dev, "failed to update hub child devices: %d\n", status);
+}
+
+static int ssam_hub_mark_hot_removed(struct device *dev, void *_data)
+{
+	struct ssam_device *sdev = to_ssam_device(dev);
+
+	if (is_ssam_device(dev))
+		ssam_device_mark_hot_removed(sdev);
+
+	return 0;
+}
+
+static void ssam_hub_update(struct ssam_hub *hub, bool connected)
+{
+	unsigned long delay;
+
+	/* Mark devices as hot-removed before we remove any. */
+	if (!connected) {
+		set_bit(SSAM_HUB_HOT_REMOVED, &hub->flags);
+		device_for_each_child_reverse(&hub->sdev->dev, NULL, ssam_hub_mark_hot_removed);
+	}
+
+	/*
+	 * Delay update when the base/keyboard cover is being connected to give
+	 * devices/EC some time to set up.
+	 */
+	delay = connected ? hub->connect_delay : 0;
+
+	schedule_delayed_work(&hub->update_work, delay);
+}
+
+static int __maybe_unused ssam_hub_resume(struct device *dev)
+{
+	struct ssam_hub *hub = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&hub->update_work, 0);
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(ssam_hub_pm_ops, NULL, ssam_hub_resume);
+
+static int ssam_hub_setup(struct ssam_device *sdev, struct ssam_hub *hub)
+{
+	int status;
+
+	hub->sdev = sdev;
+	hub->state = SSAM_HUB_UNINITIALIZED;
+
+	INIT_DELAYED_WORK(&hub->update_work, ssam_hub_update_workfn);
+
+	ssam_device_set_drvdata(sdev, hub);
+
+	status = ssam_device_notifier_register(sdev, &hub->notif);
+	if (status)
+		return status;
+
+	schedule_delayed_work(&hub->update_work, 0);
+	return 0;
+}
+
+static void ssam_hub_remove(struct ssam_device *sdev)
+{
+	struct ssam_hub *hub = ssam_device_get_drvdata(sdev);
+
+	ssam_device_notifier_unregister(sdev, &hub->notif);
+	cancel_delayed_work_sync(&hub->update_work);
+	ssam_remove_clients(&sdev->dev);
+}
+
+
+/* -- SSAM base-hub driver. ------------------------------------------------- */
+
+/*
+ * Some devices (especially battery) may need a bit of time to be fully usable
+ * after being (re-)connected. This delay has been determined via
+ * experimentation.
+ */
+#define SSAM_BASE_UPDATE_CONNECT_DELAY		msecs_to_jiffies(2500)
+
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
 	.target_category = SSAM_SSH_TC_BAS,
 	.target_id       = 0x01,
@@ -342,7 +471,7 @@ SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
 #define SSAM_BAS_OPMODE_TABLET		0x00
 #define SSAM_EVENT_BAS_CID_CONNECTION	0x0c
 
-static int ssam_base_hub_query_state(struct ssam_base_hub *hub, enum ssam_base_hub_state *state)
+static int ssam_base_hub_query_state(struct ssam_hub *hub, enum ssam_hub_state *state)
 {
 	u8 opmode;
 	int status;
@@ -354,62 +483,16 @@ static int ssam_base_hub_query_state(struct ssam_base_hub *hub, enum ssam_base_h
 	}
 
 	if (opmode != SSAM_BAS_OPMODE_TABLET)
-		*state = SSAM_BASE_HUB_CONNECTED;
+		*state = SSAM_HUB_CONNECTED;
 	else
-		*state = SSAM_BASE_HUB_DISCONNECTED;
+		*state = SSAM_HUB_DISCONNECTED;
 
 	return 0;
 }
 
-static ssize_t ssam_base_hub_state_show(struct device *dev, struct device_attribute *attr,
-					char *buf)
-{
-	struct ssam_base_hub *hub = dev_get_drvdata(dev);
-	bool connected = hub->state == SSAM_BASE_HUB_CONNECTED;
-
-	return sysfs_emit(buf, "%d\n", connected);
-}
-
-static struct device_attribute ssam_base_hub_attr_state =
-	__ATTR(state, 0444, ssam_base_hub_state_show, NULL);
-
-static struct attribute *ssam_base_hub_attrs[] = {
-	&ssam_base_hub_attr_state.attr,
-	NULL,
-};
-
-static const struct attribute_group ssam_base_hub_group = {
-	.attrs = ssam_base_hub_attrs,
-};
-
-static void ssam_base_hub_update_workfn(struct work_struct *work)
-{
-	struct ssam_base_hub *hub = container_of(work, struct ssam_base_hub, update_work.work);
-	struct fwnode_handle *node = dev_fwnode(&hub->sdev->dev);
-	enum ssam_base_hub_state state;
-	int status = 0;
-
-	status = ssam_base_hub_query_state(hub, &state);
-	if (status)
-		return;
-
-	if (hub->state == state)
-		return;
-	hub->state = state;
-
-	if (hub->state == SSAM_BASE_HUB_CONNECTED)
-		status = ssam_hub_register_clients(&hub->sdev->dev, hub->sdev->ctrl, node);
-	else
-		ssam_remove_clients(&hub->sdev->dev);
-
-	if (status)
-		dev_err(&hub->sdev->dev, "failed to update base-hub devices: %d\n", status);
-}
-
 static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
 {
-	struct ssam_base_hub *hub = container_of(nf, struct ssam_base_hub, notif);
-	unsigned long delay;
+	struct ssam_hub *hub = container_of(nf, struct ssam_hub, notif);
 
 	if (event->command_id != SSAM_EVENT_BAS_CID_CONNECTION)
 		return 0;
@@ -419,13 +502,7 @@ static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam
 		return 0;
 	}
 
-	/*
-	 * Delay update when the base is being connected to give devices/EC
-	 * some time to set up.
-	 */
-	delay = event->data[0] ? SSAM_BASE_UPDATE_CONNECT_DELAY : 0;
-
-	schedule_delayed_work(&hub->update_work, delay);
+	ssam_hub_update(hub, event->data[0]);
 
 	/*
 	 * Do not return SSAM_NOTIF_HANDLED: The event should be picked up and
@@ -435,27 +512,14 @@ static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam
 	return 0;
 }
 
-static int __maybe_unused ssam_base_hub_resume(struct device *dev)
-{
-	struct ssam_base_hub *hub = dev_get_drvdata(dev);
-
-	schedule_delayed_work(&hub->update_work, 0);
-	return 0;
-}
-static SIMPLE_DEV_PM_OPS(ssam_base_hub_pm_ops, NULL, ssam_base_hub_resume);
-
 static int ssam_base_hub_probe(struct ssam_device *sdev)
 {
-	struct ssam_base_hub *hub;
-	int status;
+	struct ssam_hub *hub;
 
 	hub = devm_kzalloc(&sdev->dev, sizeof(*hub), GFP_KERNEL);
 	if (!hub)
 		return -ENOMEM;
 
-	hub->sdev = sdev;
-	hub->state = SSAM_BASE_HUB_UNINITIALIZED;
-
 	hub->notif.base.priority = INT_MAX;  /* This notifier should run first. */
 	hub->notif.base.fn = ssam_base_hub_notif;
 	hub->notif.event.reg = SSAM_EVENT_REGISTRY_SAM;
@@ -464,37 +528,10 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 	hub->notif.event.mask = SSAM_EVENT_MASK_NONE;
 	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
 
-	INIT_DELAYED_WORK(&hub->update_work, ssam_base_hub_update_workfn);
-
-	ssam_device_set_drvdata(sdev, hub);
-
-	status = ssam_device_notifier_register(sdev, &hub->notif);
-	if (status)
-		return status;
-
-	status = sysfs_create_group(&sdev->dev.kobj, &ssam_base_hub_group);
-	if (status)
-		goto err;
-
-	schedule_delayed_work(&hub->update_work, 0);
-	return 0;
+	hub->connect_delay = SSAM_BASE_UPDATE_CONNECT_DELAY;
+	hub->get_state = ssam_base_hub_query_state;
 
-err:
-	ssam_device_notifier_unregister(sdev, &hub->notif);
-	cancel_delayed_work_sync(&hub->update_work);
-	ssam_remove_clients(&sdev->dev);
-	return status;
-}
-
-static void ssam_base_hub_remove(struct ssam_device *sdev)
-{
-	struct ssam_base_hub *hub = ssam_device_get_drvdata(sdev);
-
-	sysfs_remove_group(&sdev->dev.kobj, &ssam_base_hub_group);
-
-	ssam_device_notifier_unregister(sdev, &hub->notif);
-	cancel_delayed_work_sync(&hub->update_work);
-	ssam_remove_clients(&sdev->dev);
+	return ssam_hub_setup(sdev, hub);
 }
 
 static const struct ssam_device_id ssam_base_hub_match[] = {
@@ -504,12 +541,12 @@ static const struct ssam_device_id ssam_base_hub_match[] = {
 
 static struct ssam_device_driver ssam_base_hub_driver = {
 	.probe = ssam_base_hub_probe,
-	.remove = ssam_base_hub_remove,
+	.remove = ssam_hub_remove,
 	.match_table = ssam_base_hub_match,
 	.driver = {
 		.name = "surface_aggregator_base_hub",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm = &ssam_base_hub_pm_ops,
+		.pm = &ssam_hub_pm_ops,
 	},
 };
 
-- 
2.36.1

