Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8BF5357B9
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiE0CfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiE0CfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37017E7300;
        Thu, 26 May 2022 19:35:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so6245344ejc.4;
        Thu, 26 May 2022 19:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFOZ0wSJDgueU2ApWnB4MpwbpRX3WdE3tzmT7S9PvJc=;
        b=G1mmGNRNUl74FG9g/HTs0FcH4PgdmnI+yMm7v3YoIvZhY0kXOVkSMheJ7OQEJ/dqw4
         PR4HShdnxC4NA/bL5UQmnrWn+TyYHOFQMZLKuLFKV+804h6enijYWIZObpWeflPdcRKP
         wKCln0LjYNtxPq6s/w+Zp7LTEGouQlQIYAotylhQ5mz+I9rzybev74gb6Lh6rpk/2/r5
         d6lMcgmOdl5IXDg+6+E9cNxp/KJMd0ke6UY0Ay6nip8bOtT8ejfyzSViLgr2Kko3rnm5
         1SSNdQJzqNNxerRdAB8v1+4OVGFgGP3XxCK+aPWYi9wBfkGelaIRHqQnQ4/cwC7i1DN4
         mODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFOZ0wSJDgueU2ApWnB4MpwbpRX3WdE3tzmT7S9PvJc=;
        b=pa8XZ3PP3rzAYfd4YGXZpGc9u0dIONuAULlPcXbwXfq2kpcEeQ7RcYCAFyutkyF8dW
         FcLwWaVrRo/QDd1JW1NaAmIic7fRG7m1eTnzvJvQyy1WopgmnBhfHinhbWYorpUFWKDe
         XbqX0KfNEuvMmKA8neHvzIB0bxrgVlmh1CJ4ANCZUbl9KfgqNjP3LrOwhApjONIZzwx4
         k9xwohnHhRpuGmNL3BEoDf+k0KbfC0YlfpXVw5AqiFTyFJPtsq1RMhYDK3PpWc5B2ld+
         vsz/S11GCIRltx/kWQudjkecO8aaS2Nm782tfUstB3zzEY2cNSacMwXNA9tZj0adi4f0
         cGpw==
X-Gm-Message-State: AOAM533nnWCSkKjKfahLPNVPFjUbvH8I8TFzDcU4u4gYrPVxBnShj3ma
        HHpOrP7z8cndZtuq4+nLPSp/3qq9VFg=
X-Google-Smtp-Source: ABdhPJzo0N5ai7blH/ekrgVvA9G5UhSkdgGbol1Xwnud+CzDevIEuF0Ljy43o56zR0FB0XKVhtaWXg==
X-Received: by 2002:a17:907:7f26:b0:6ff:ab8:e85 with SMTP id qf38-20020a1709077f2600b006ff0ab80e85mr12677292ejc.281.1653618916823;
        Thu, 26 May 2022 19:35:16 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:16 -0700 (PDT)
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
Subject: [PATCH v2 12/12] platform/surface: aggregator_registry: Add support for keyboard cover on Surface Pro 8
Date:   Fri, 27 May 2022 04:34:47 +0200
Message-Id: <20220527023447.2460025-13-luzmaximilian@gmail.com>
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

Add support for the detachable keyboard cover on the Surface Pro 8.

The keyboard cover on the Surface Pro 8 is, unlike the keyboard covers
of earlier Surface Pro generations, handled via the Surface System
Aggregator Module (SSAM). The keyboard and touchpad (as well as other
HID input devices) of this cover are standard SSAM HID client devices
(just like keyboard and touchpad on e.g. the Surface Laptop 3 and 4),
however, some care needs to be taken as they can be physically detached
(similarly to the Surface Book 3). Specifically, the respective SSAM
client devices need to be removed when the keyboard cover has been
detached and (re-)initialized when the keyboard cover has been
(re-)attached.

On the Surface Pro 8, detachment of the keyboard cover (and by extension
its devices) is managed via the KIP subsystem. Therefore, said devices
need to be registered under the KIP device hub, which in turn will
remove and re-create/re-initialize those devices as needed.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - Change order of KIP and BAS hub definitions to reflect IDs.

---
 .../surface/surface_aggregator_registry.c     | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index f15cef60630f..bf3303f1aa71 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -41,6 +41,12 @@ static const struct software_node ssam_node_root = {
 	.name = "ssam_platform_hub",
 };
 
+/* KIP device hub (connects keyboard cover devices on Surface Pro 8). */
+static const struct software_node ssam_node_hub_kip = {
+	.name = "ssam:00:00:01:0e:00",
+	.parent = &ssam_node_root,
+};
+
 /* Base device hub (devices attached to Surface Book 3 base). */
 static const struct software_node ssam_node_hub_base = {
 	.name = "ssam:00:00:02:11:00",
@@ -155,6 +161,30 @@ static const struct software_node ssam_node_hid_base_iid6 = {
 	.parent = &ssam_node_hub_base,
 };
 
+/* HID keyboard (KIP hub). */
+static const struct software_node ssam_node_hid_kip_keyboard = {
+	.name = "ssam:01:15:02:01:00",
+	.parent = &ssam_node_hub_kip,
+};
+
+/* HID pen stash (KIP hub; pen taken / stashed away evens). */
+static const struct software_node ssam_node_hid_kip_penstash = {
+	.name = "ssam:01:15:02:02:00",
+	.parent = &ssam_node_hub_kip,
+};
+
+/* HID touchpad (KIP hub). */
+static const struct software_node ssam_node_hid_kip_touchpad = {
+	.name = "ssam:01:15:02:03:00",
+	.parent = &ssam_node_hub_kip,
+};
+
+/* HID device instance 5 (KIP hub, unknown HID device). */
+static const struct software_node ssam_node_hid_kip_iid5 = {
+	.name = "ssam:01:15:02:05:00",
+	.parent = &ssam_node_hub_kip,
+};
+
 /*
  * Devices for 5th- and 6th-generations models:
  * - Surface Book 2,
@@ -230,10 +260,15 @@ static const struct software_node *ssam_node_group_sp7[] = {
 
 static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_root,
+	&ssam_node_hub_kip,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
-	/* TODO: Add support for keyboard cover. */
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_kip_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_iid5,
+	/* TODO: Add support for tablet mode switch. */
 	NULL,
 };
 
-- 
2.36.1

