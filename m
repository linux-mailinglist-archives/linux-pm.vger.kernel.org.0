Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461E95357A7
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiE0CfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiE0CfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BBE7327;
        Thu, 26 May 2022 19:35:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t26so3880250edt.0;
        Thu, 26 May 2022 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqMEdCwBNUMEosVpxwPzKGlmjyEYxbNa29zA4en7UXQ=;
        b=aatO3lBXZHYqaYg5IlpEQlQuhh7oDzNKPqU5E9jnU/XQcNIPoD2P9Ywf+kb7yRglhB
         2dqXI5OqPtAqozZUi5JHDigMHJBBXAOmoPlCE/pswBn/N9+ih8xbb9116IW0kjZ0Sok+
         DojdlQroNxHThv9rqGpzqUqcze8NiABSqasGIe2VE32ebu1C+A9TmLA90YihU184BdQ+
         5r+6ZC4WEHUDfc9dztm4SQFdWW/RWNX0PDt3vG0Jun9DtwTZC5jpCGk35wW1eC1CMRmq
         u4Ha7ftl3fqtc7ZpYoTYZZ4ahBdPbzFnDAfmxInodpOuA2Uofdj+9a4E/mtkhsMeI/k1
         /82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqMEdCwBNUMEosVpxwPzKGlmjyEYxbNa29zA4en7UXQ=;
        b=qLi+ez5vhEwBdkP5UvuW6Z1Dr2i3N9PBOozGrOcBijGAPHKhSQSFBLrNtdTUiypzdN
         FabanyVC3FL8W1GwCLNxz0JRft4KwZ3NpzDxU4C4liaUnLa2Oury7OtDBDnseaR2AqYA
         Kodi18/ND4xEyurNafzFFM+BHxGrUDnwCphr5J7KGCveaxCczy/Lzy7BfjP98swyqRU9
         dD2b6c3fkdGEwT7X4p6/KRRv2l8XIK95HRH0a9r3opvdNNhssmccFhL2JWqRfMANkKW6
         GIJ5Ov5hSU1gsYw0W5dOgFSyni6IgYODyQEeWdUQUi3KXOxxKbnU3XAPcXVNCZgudMtI
         IP5w==
X-Gm-Message-State: AOAM533W9i9g91tAuU9z6K52Icv0WtUShTBii5pYX+4MrseVCnue+dTQ
        sCwdJV4Dvz0oCev5dZ+7o/LUsCy2H8c=
X-Google-Smtp-Source: ABdhPJwz2xQAFIGNcFGhiLbTwVUXjP6ZofJtJQZNzsuNNJawjQoaujmXlOgPShpNPm05F4ayHeGMRA==
X-Received: by 2002:a05:6402:3298:b0:42a:a91d:905b with SMTP id f24-20020a056402329800b0042aa91d905bmr42100760eda.373.1653618915534;
        Thu, 26 May 2022 19:35:15 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:15 -0700 (PDT)
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
Subject: [PATCH v2 11/12] platform/surface: aggregator_registry: Add KIP device hub
Date:   Fri, 27 May 2022 04:34:46 +0200
Message-Id: <20220527023447.2460025-12-luzmaximilian@gmail.com>
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

Add a Surface System Aggregator Module (SSAM) client device hub for
hot-removable devices managed via the KIP subsystem.

The KIP subsystem (full name unknown, abbreviation has been obtained
through reverse engineering) is a subsystem that manages hot-removable
SSAM client devices. Specifically, it manages HID input devices
contained in the detachable keyboard cover of the Surface Pro 8 and
Surface Pro X.

The KIP subsystem handles a single group of devices (e.g. all devices
contained in the keyboard cover) and cannot handle devices individually.
Thus we model it as a client device hub, which (hot-)removes all devices
contained under it once removal of the hub (e.g. keyboard cover) has
been detected and (re-)adds all devices once the physical hub device has
been (re-)attached. To do this, use the previously generified SSAM
subsystem hub framework.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - Change KIP hub device UID to improve consistency.

---
 .../surface/surface_aggregator_registry.c     | 103 +++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index b11ce87c7184..f15cef60630f 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -551,6 +551,93 @@ static struct ssam_device_driver ssam_base_hub_driver = {
 };
 
 
+/* -- SSAM KIP-subsystem hub driver. ---------------------------------------- */
+
+/*
+ * Some devices may need a bit of time to be fully usable after being
+ * (re-)connected. This delay has been determined via experimentation.
+ */
+#define SSAM_KIP_UPDATE_CONNECT_DELAY		msecs_to_jiffies(250)
+
+#define SSAM_EVENT_KIP_CID_CONNECTION		0x2c
+
+SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_get_connection_state, u8, {
+	.target_category = SSAM_SSH_TC_KIP,
+	.target_id       = 0x01,
+	.command_id      = 0x2c,
+	.instance_id     = 0x00,
+});
+
+static int ssam_kip_get_connection_state(struct ssam_hub *hub, enum ssam_hub_state *state)
+{
+	int status;
+	u8 connected;
+
+	status = ssam_retry(__ssam_kip_get_connection_state, hub->sdev->ctrl, &connected);
+	if (status < 0) {
+		dev_err(&hub->sdev->dev, "failed to query KIP connection state: %d\n", status);
+		return status;
+	}
+
+	*state = connected ? SSAM_HUB_CONNECTED : SSAM_HUB_DISCONNECTED;
+	return 0;
+}
+
+static u32 ssam_kip_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
+{
+	struct ssam_hub *hub = container_of(nf, struct ssam_hub, notif);
+
+	if (event->command_id != SSAM_EVENT_KIP_CID_CONNECTION)
+		return 0;	/* Return "unhandled". */
+
+	if (event->length < 1) {
+		dev_err(&hub->sdev->dev, "unexpected payload size: %u\n", event->length);
+		return 0;
+	}
+
+	ssam_hub_update(hub, event->data[0]);
+	return SSAM_NOTIF_HANDLED;
+}
+
+static int ssam_kip_hub_probe(struct ssam_device *sdev)
+{
+	struct ssam_hub *hub;
+
+	hub = devm_kzalloc(&sdev->dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	hub->notif.base.priority = INT_MAX;  /* This notifier should run first. */
+	hub->notif.base.fn = ssam_kip_hub_notif;
+	hub->notif.event.reg = SSAM_EVENT_REGISTRY_SAM;
+	hub->notif.event.id.target_category = SSAM_SSH_TC_KIP,
+	hub->notif.event.id.instance = 0,
+	hub->notif.event.mask = SSAM_EVENT_MASK_TARGET;
+	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
+
+	hub->connect_delay = SSAM_KIP_UPDATE_CONNECT_DELAY;
+	hub->get_state = ssam_kip_get_connection_state;
+
+	return ssam_hub_setup(sdev, hub);
+}
+
+static const struct ssam_device_id ssam_kip_hub_match[] = {
+	{ SSAM_VDEV(HUB, 0x01, SSAM_SSH_TC_KIP, 0x00) },
+	{ },
+};
+
+static struct ssam_device_driver ssam_kip_hub_driver = {
+	.probe = ssam_kip_hub_probe,
+	.remove = ssam_hub_remove,
+	.match_table = ssam_kip_hub_match,
+	.driver = {
+		.name = "surface_kip_hub",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = &ssam_hub_pm_ops,
+	},
+};
+
+
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_match[] = {
@@ -673,18 +760,30 @@ static int __init ssam_device_hub_init(void)
 
 	status = platform_driver_register(&ssam_platform_hub_driver);
 	if (status)
-		return status;
+		goto err_platform;
 
 	status = ssam_device_driver_register(&ssam_base_hub_driver);
 	if (status)
-		platform_driver_unregister(&ssam_platform_hub_driver);
+		goto err_base;
+
+	status = ssam_device_driver_register(&ssam_kip_hub_driver);
+	if (status)
+		goto err_kip;
 
+	return 0;
+
+err_kip:
+	ssam_device_driver_unregister(&ssam_base_hub_driver);
+err_base:
+	platform_driver_unregister(&ssam_platform_hub_driver);
+err_platform:
 	return status;
 }
 module_init(ssam_device_hub_init);
 
 static void __exit ssam_device_hub_exit(void)
 {
+	ssam_device_driver_unregister(&ssam_kip_hub_driver);
 	ssam_device_driver_unregister(&ssam_base_hub_driver);
 	platform_driver_unregister(&ssam_platform_hub_driver);
 }
-- 
2.36.1

