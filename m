Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC535357B0
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiE0CfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiE0CfI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A4E64C1;
        Thu, 26 May 2022 19:35:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so6245344ejc.4;
        Thu, 26 May 2022 19:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQ674XTr+7GfKG7wWovKtC2VHMOLO5cWQlNebEKXtnI=;
        b=WQw04GzM0d1KqMzdK9f7YuZLMNY/Mr5FraarbvoKoA06BHjEYVrI3FIcaVSJhM8lEm
         B+ZlPe5yJ8udwBlt/6JdZpPhbdb4Ybjf52rpdghibXjAGk1bMdmkgaSYv7xdQh4pD47Z
         1nR0MqBS9iGRCldZBcshaS6I/3wJ9Ygq+4WMn5VtDalvJNEEBpsCX6r21pr7dQLpHF8E
         dyv6OKvPSRjEizR0i+Zi9mU9P87IYSal15WOZgnMDjI8XwEgQLd2jp51R2B8qim+Adkn
         q149XhSodJvhxNPjOMD0uWmJ8WaOAPiEZmrVQw6Tldfck3J/Er71OLx7/AKgT2OiYTQV
         RawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQ674XTr+7GfKG7wWovKtC2VHMOLO5cWQlNebEKXtnI=;
        b=cwRCUQN4e3jMx7GbbbUvjPUQ1Vg9jxSrjfevjSfW5FmyyP1u8C70LegPtHKORMwtdd
         eHQ0vsNfWyNSIxV0bXq0xGxdLJtuCrktMZfU2rbg0EOw0x9Fjfu7ryETbzTbH9YIhlpn
         9KLRU8MEIwIVErRJVJOJ6jh9k5tL7dC3/FaDwSedL6lKZwDolleDIsS+jeeOJjwrgShC
         BeWJTqO4fj86/qxWaIGKcMo+P+y+bBVWj7X4EIdGid0CKf2/YLvS3uIc84QgmX3sQeQ8
         oCR+8zYgax7BOv1iv93GmHGfuRVPhoSuEYezmcpJ1hcJvkA59jzkLxpS7rW1GRJN+S3T
         reSg==
X-Gm-Message-State: AOAM533dZuC5AHX5AUUb3gxWpHJe5JphVjGFIq6pg+jVGH1YsGqgpfo4
        HMKmOKvwsXcm07RoIupQKCs=
X-Google-Smtp-Source: ABdhPJyGaKGHglesfdMxXtfL8YLyEIOJ7bzZdJAzKXbUOCO4cU+Jyg2DSrx47P3WzPZTaSoChKMNgQ==
X-Received: by 2002:a17:907:7faa:b0:6ff:918:5251 with SMTP id qk42-20020a1709077faa00b006ff09185251mr14070249ejc.460.1653618904971;
        Thu, 26 May 2022 19:35:04 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:04 -0700 (PDT)
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
Subject: [PATCH v2 03/12] platform/surface: aggregator: Allow notifiers to avoid communication on unregistering
Date:   Fri, 27 May 2022 04:34:38 +0200
Message-Id: <20220527023447.2460025-4-luzmaximilian@gmail.com>
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

When SSAM client devices have been (physically) hot-removed,
communication attempts with those devices may fail and time out. This
can even extend to event notifiers, due to which timeouts may occur
during device removal, slowing down that process.

Add a parameter to the notifier unregister function that allows skipping
communication with the EC to prevent this. Furthermore, add wrappers for
registering and unregistering notifiers belonging to SSAM client devices
that automatically check if the device has been marked as hot-removed
and communication should be avoided.

Note that non-SSAM client devices can generally not be hot-removed, so
also add a convenience wrapper for those, defaulting to allow
communication.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - none

---
 .../driver-api/surface_aggregator/client.rst  |  6 +-
 .../platform/surface/aggregator/controller.c  | 53 ++++++++++-----
 include/linux/surface_aggregator/controller.h | 24 ++++++-
 include/linux/surface_aggregator/device.h     | 66 +++++++++++++++++++
 4 files changed, 128 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/client.rst b/Documentation/driver-api/surface_aggregator/client.rst
index e519d374c378..27f95abdbe99 100644
--- a/Documentation/driver-api/surface_aggregator/client.rst
+++ b/Documentation/driver-api/surface_aggregator/client.rst
@@ -17,6 +17,8 @@
 .. |SSAM_DEVICE| replace:: :c:func:`SSAM_DEVICE`
 .. |ssam_notifier_register| replace:: :c:func:`ssam_notifier_register`
 .. |ssam_notifier_unregister| replace:: :c:func:`ssam_notifier_unregister`
+.. |ssam_device_notifier_register| replace:: :c:func:`ssam_device_notifier_register`
+.. |ssam_device_notifier_unregister| replace:: :c:func:`ssam_device_notifier_unregister`
 .. |ssam_request_sync| replace:: :c:func:`ssam_request_sync`
 .. |ssam_event_mask| replace:: :c:type:`enum ssam_event_mask <ssam_event_mask>`
 
@@ -312,7 +314,9 @@ Handling Events
 To receive events from the SAM EC, an event notifier must be registered for
 the desired event via |ssam_notifier_register|. The notifier must be
 unregistered via |ssam_notifier_unregister| once it is not required any
-more.
+more. For |ssam_device| type clients, the |ssam_device_notifier_register| and
+|ssam_device_notifier_unregister| wrappers should be preferred as they properly
+handle hot-removal of client devices.
 
 Event notifiers are registered by providing (at minimum) a callback to call
 in case an event has been received, the registry specifying how the event
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index b8c377b3f932..6de834b52b63 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2199,16 +2199,26 @@ static int ssam_nf_refcount_enable(struct ssam_controller *ctrl,
 }
 
 /**
- * ssam_nf_refcount_disable_free() - Disable event for reference count entry if it is
- * no longer in use and free the corresponding entry.
+ * ssam_nf_refcount_disable_free() - Disable event for reference count entry if
+ * it is no longer in use and free the corresponding entry.
  * @ctrl:  The controller to disable the event on.
  * @entry: The reference count entry for the event to be disabled.
  * @flags: The flags used for enabling the event on the EC.
+ * @ec:    Flag specifying if the event should actually be disabled on the EC.
  *
- * If the reference count equals zero, i.e. the event is no longer requested by
- * any client, the event will be disabled and the corresponding reference count
- * entry freed. The reference count entry must not be used any more after a
- * call to this function.
+ * If ``ec`` equals ``true`` and the reference count equals zero (i.e. the
+ * event is no longer requested by any client), the specified event will be
+ * disabled on the EC via the corresponding request.
+ *
+ * If ``ec`` equals ``false``, no request will be sent to the EC and the event
+ * can be considered in a detached state (i.e. no longer used but still
+ * enabled). Disabling an event via this method may be required for
+ * hot-removable devices, where event disable requests may time out after the
+ * device has been physically removed.
+ *
+ * In both cases, if the reference count equals zero, the corresponding
+ * reference count entry will be freed. The reference count entry must not be
+ * used any more after a call to this function.
  *
  * Also checks if the flags used for disabling the event match the flags used
  * for enabling the event and warns if they do not (regardless of reference
@@ -2223,7 +2233,7 @@ static int ssam_nf_refcount_enable(struct ssam_controller *ctrl,
  * returns the status of the event-enable EC command.
  */
 static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
-					 struct ssam_nf_refcount_entry *entry, u8 flags)
+					 struct ssam_nf_refcount_entry *entry, u8 flags, bool ec)
 {
 	const struct ssam_event_registry reg = entry->key.reg;
 	const struct ssam_event_id id = entry->key.id;
@@ -2232,8 +2242,9 @@ static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
 
 	lockdep_assert_held(&nf->lock);
 
-	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
-		 reg.target_category, id.target_category, id.instance, entry->refcount);
+	ssam_dbg(ctrl, "%s event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 ec ? "disabling" : "detaching", reg.target_category, id.target_category,
+		 id.instance, entry->refcount);
 
 	if (entry->flags != flags) {
 		ssam_warn(ctrl,
@@ -2242,7 +2253,7 @@ static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
 			  id.instance);
 	}
 
-	if (entry->refcount == 0) {
+	if (ec && entry->refcount == 0) {
 		status = ssam_ssh_event_disable(ctrl, reg, id, flags);
 		kfree(entry);
 	}
@@ -2322,20 +2333,26 @@ int ssam_notifier_register(struct ssam_controller *ctrl, struct ssam_event_notif
 EXPORT_SYMBOL_GPL(ssam_notifier_register);
 
 /**
- * ssam_notifier_unregister() - Unregister an event notifier.
- * @ctrl: The controller the notifier has been registered on.
- * @n:    The event notifier to unregister.
+ * __ssam_notifier_unregister() - Unregister an event notifier.
+ * @ctrl:    The controller the notifier has been registered on.
+ * @n:       The event notifier to unregister.
+ * @disable: Whether to disable the corresponding event on the EC.
  *
  * Unregister an event notifier. Decrement the usage counter of the associated
  * SAM event if the notifier is not marked as an observer. If the usage counter
- * reaches zero, the event will be disabled.
+ * reaches zero and ``disable`` equals ``true``, the event will be disabled.
+ *
+ * Useful for hot-removable devices, where communication may fail once the
+ * device has been physically removed. In that case, specifying ``disable`` as
+ * ``false`` avoids communication with the EC.
  *
  * Return: Returns zero on success, %-ENOENT if the given notifier block has
  * not been registered on the controller. If the given notifier block was the
  * last one associated with its specific event, returns the status of the
  * event-disable EC-command.
  */
-int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_notifier *n)
+int __ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_notifier *n,
+			       bool disable)
 {
 	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
 	struct ssam_nf_refcount_entry *entry;
@@ -2373,7 +2390,7 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
 			goto remove;
 		}
 
-		status = ssam_nf_refcount_disable_free(ctrl, entry, n->event.flags);
+		status = ssam_nf_refcount_disable_free(ctrl, entry, n->event.flags, disable);
 	}
 
 remove:
@@ -2383,7 +2400,7 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
 
 	return status;
 }
-EXPORT_SYMBOL_GPL(ssam_notifier_unregister);
+EXPORT_SYMBOL_GPL(__ssam_notifier_unregister);
 
 /**
  * ssam_controller_event_enable() - Enable the specified event.
@@ -2477,7 +2494,7 @@ int ssam_controller_event_disable(struct ssam_controller *ctrl,
 		return -ENOENT;
 	}
 
-	status = ssam_nf_refcount_disable_free(ctrl, entry, flags);
+	status = ssam_nf_refcount_disable_free(ctrl, entry, flags, true);
 
 	mutex_unlock(&nf->lock);
 	return status;
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index 74bfdffaf7b0..50a2b4926c06 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -835,8 +835,28 @@ struct ssam_event_notifier {
 int ssam_notifier_register(struct ssam_controller *ctrl,
 			   struct ssam_event_notifier *n);
 
-int ssam_notifier_unregister(struct ssam_controller *ctrl,
-			     struct ssam_event_notifier *n);
+int __ssam_notifier_unregister(struct ssam_controller *ctrl,
+			       struct ssam_event_notifier *n, bool disable);
+
+/**
+ * ssam_notifier_unregister() - Unregister an event notifier.
+ * @ctrl:    The controller the notifier has been registered on.
+ * @n:       The event notifier to unregister.
+ *
+ * Unregister an event notifier. Decrement the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the usage counter
+ * reaches zero, the event will be disabled.
+ *
+ * Return: Returns zero on success, %-ENOENT if the given notifier block has
+ * not been registered on the controller. If the given notifier block was the
+ * last one associated with its specific event, returns the status of the
+ * event-disable EC-command.
+ */
+static inline int ssam_notifier_unregister(struct ssam_controller *ctrl,
+					   struct ssam_event_notifier *n)
+{
+	return __ssam_notifier_unregister(ctrl, n, true);
+}
 
 int ssam_controller_event_enable(struct ssam_controller *ctrl,
 				 struct ssam_event_registry reg,
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 6df7c8d4e50e..c418f7f2732d 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -483,4 +483,70 @@ static inline void ssam_remove_clients(struct device *dev) {}
 				    sdev->uid.instance, ret);		\
 	}
 
+
+/* -- Helpers for client-device notifiers. ---------------------------------- */
+
+/**
+ * ssam_device_notifier_register() - Register an event notifier for the
+ * specified client device.
+ * @sdev: The device the notifier should be registered on.
+ * @n:    The event notifier to register.
+ *
+ * Register an event notifier. Increment the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the event is not
+ * marked as an observer and is currently not enabled, it will be enabled
+ * during this call. If the notifier is marked as an observer, no attempt will
+ * be made at enabling any event and no reference count will be modified.
+ *
+ * Notifiers marked as observers do not need to be associated with one specific
+ * event, i.e. as long as no event matching is performed, only the event target
+ * category needs to be set.
+ *
+ * Return: Returns zero on success, %-ENOSPC if there have already been
+ * %INT_MAX notifiers for the event ID/type associated with the notifier block
+ * registered, %-ENOMEM if the corresponding event entry could not be
+ * allocated, %-ENODEV if the device is marked as hot-removed. If this is the
+ * first time that a notifier block is registered for the specific associated
+ * event, returns the status of the event-enable EC-command.
+ */
+static inline int ssam_device_notifier_register(struct ssam_device *sdev,
+						struct ssam_event_notifier *n)
+{
+	/*
+	 * Note that this check does not provide any guarantees whatsoever as
+	 * hot-removal could happen at any point and we can't protect against
+	 * it. Nevertheless, if we can detect hot-removal, bail early to avoid
+	 * communication timeouts.
+	 */
+	if (ssam_device_is_hot_removed(sdev))
+		return -ENODEV;
+
+	return ssam_notifier_register(sdev->ctrl, n);
+}
+
+/**
+ * ssam_device_notifier_unregister() - Unregister an event notifier for the
+ * specified client device.
+ * @sdev: The device the notifier has been registered on.
+ * @n:    The event notifier to unregister.
+ *
+ * Unregister an event notifier. Decrement the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the usage counter
+ * reaches zero, the event will be disabled.
+ *
+ * In case the device has been marked as hot-removed, the event will not be
+ * disabled on the EC, as in those cases any attempt at doing so may time out.
+ *
+ * Return: Returns zero on success, %-ENOENT if the given notifier block has
+ * not been registered on the controller. If the given notifier block was the
+ * last one associated with its specific event, returns the status of the
+ * event-disable EC-command.
+ */
+static inline int ssam_device_notifier_unregister(struct ssam_device *sdev,
+						  struct ssam_event_notifier *n)
+{
+	return __ssam_notifier_unregister(sdev->ctrl, n,
+					  !ssam_device_is_hot_removed(sdev));
+}
+
 #endif /* _LINUX_SURFACE_AGGREGATOR_DEVICE_H */
-- 
2.36.1

