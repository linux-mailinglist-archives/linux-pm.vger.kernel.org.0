Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5895357A5
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiE0CfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiE0CfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2AE7300;
        Thu, 26 May 2022 19:35:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n22so885310eda.5;
        Thu, 26 May 2022 19:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VER7t6O4p/WBXotWyZuCQ0g2btWScgTYqTETtztn0Uc=;
        b=K5nbtd1AURtWfc8hjUm7KZq40KzjQu1vQ4auSVU4tWgtgyAVKZM0dXKjVFhJGsxAYf
         X7RkrqNFgQhSIHnooegFbEsiMcBHYx2tjyj2R2lxXXAX2bAaKyjNxaFIQULFLWiS4olO
         /jVbF0kNHDHTjg5t3azaoqDSlR8JHn81bKLGIursK7Hiqe1Dx/s8LhJP4+loxiv5GkFG
         zyoPDX2/cQrjpj894/hq3mUdZ1XClsJQ+XjKLFJnPf4JymgSIoX90a735ovu4ksDvsxG
         BnIZcTduFihIhKpYw0IBjhy3j/zp9oCpes4Iil+5OkxF0K2hJ0cQixdDW5SRzMCCFnId
         cEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VER7t6O4p/WBXotWyZuCQ0g2btWScgTYqTETtztn0Uc=;
        b=1dwFovk/YSVbtvPtagN1FnJfDc5UlKPhVPBsmFkH45c0KAPzMK74vQ96f6L3vuQXH2
         EF3T+O/G0B9sFnM/8RbF/SaaZCIPbmETISX9FjhjFxKEX91gB7YSQ2JN2bvfaLv22MlC
         9Tv2jmYY1WoMn6uwBpGOrn8+iuoFhitnbzdBCY6vmkkUDOvTGGiUhUG0QXHH+by5OlMX
         YPesL7CUH9Oeq8/9yNREu95LJKWmX/S1fB+H9yVru1gafYbohdYRRbHhnljWj0P5lo20
         MLOAKUMwweqmLASckoWrtbxB3qVCoy5FqZRFGAfBD5OxW25tRY9T6tYaJxqmGL6hU6k+
         rRTQ==
X-Gm-Message-State: AOAM530Vfn24rD9f6BoxtOdfqmq4MtCrG1a4zGG0YujzdgRc82N3nmH0
        c4yQnwbhrEEDhOhPM2xupjPvOOXAtSE=
X-Google-Smtp-Source: ABdhPJwkyMtX/RSgf+5LBBWWsdYiEu5HTKatMcuvi0fplHa8bm7te+91GtApnapKKIVPkk7aNZND9Q==
X-Received: by 2002:a05:6402:6d5:b0:42b:e1df:a1b6 with SMTP id n21-20020a05640206d500b0042be1dfa1b6mr4173911edy.341.1653618910146;
        Thu, 26 May 2022 19:35:10 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:09 -0700 (PDT)
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
Subject: [PATCH v2 07/12] HID: surface-hid: Add support for hot-removal
Date:   Fri, 27 May 2022 04:34:42 +0200
Message-Id: <20220527023447.2460025-8-luzmaximilian@gmail.com>
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

Add support for hot-removal of SSAM HID client devices.

Once a device has been hot-removed, further communication with it should
be avoided as it may fail and time out. While the device will be removed
as soon as we detect hot-removal, communication may still occur during
teardown, especially when unregistering notifiers.

While hot-removal is a surprise event that can happen at any time, try
to avoid communication as much as possible once it has been detected to
prevent timeouts that can slow down device removal and cause issues,
e.g. when quickly re-attaching the device.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - none

---
 drivers/hid/surface-hid/surface_hid_core.c | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/surface-hid/surface_hid_core.c b/drivers/hid/surface-hid/surface_hid_core.c
index e46330b2e561..87637f813de2 100644
--- a/drivers/hid/surface-hid/surface_hid_core.c
+++ b/drivers/hid/surface-hid/surface_hid_core.c
@@ -19,12 +19,30 @@
 #include "surface_hid_core.h"
 
 
+/* -- Utility functions. ---------------------------------------------------- */
+
+static bool surface_hid_is_hot_removed(struct surface_hid_device *shid)
+{
+	/*
+	 * Non-ssam client devices, i.e. platform client devices, cannot be
+	 * hot-removed.
+	 */
+	if (!is_ssam_device(shid->dev))
+		return false;
+
+	return ssam_device_is_hot_removed(to_ssam_device(shid->dev));
+}
+
+
 /* -- Device descriptor access. --------------------------------------------- */
 
 static int surface_hid_load_hid_descriptor(struct surface_hid_device *shid)
 {
 	int status;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	status = shid->ops.get_descriptor(shid, SURFACE_HID_DESC_HID,
 			(u8 *)&shid->hid_desc, sizeof(shid->hid_desc));
 	if (status)
@@ -61,6 +79,9 @@ static int surface_hid_load_device_attributes(struct surface_hid_device *shid)
 {
 	int status;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	status = shid->ops.get_descriptor(shid, SURFACE_HID_DESC_ATTRS,
 			(u8 *)&shid->attrs, sizeof(shid->attrs));
 	if (status)
@@ -88,9 +109,18 @@ static int surface_hid_start(struct hid_device *hid)
 static void surface_hid_stop(struct hid_device *hid)
 {
 	struct surface_hid_device *shid = hid->driver_data;
+	bool hot_removed;
+
+	/*
+	 * Communication may fail for devices that have been hot-removed. This
+	 * also includes unregistration of HID events, so we need to check this
+	 * here. Only if the device has not been marked as hot-removed, we can
+	 * safely disable events.
+	 */
+	hot_removed = surface_hid_is_hot_removed(shid);
 
 	/* Note: This call will log errors for us, so ignore them here. */
-	ssam_notifier_unregister(shid->ctrl, &shid->notif);
+	__ssam_notifier_unregister(shid->ctrl, &shid->notif, !hot_removed);
 }
 
 static int surface_hid_open(struct hid_device *hid)
@@ -109,6 +139,9 @@ static int surface_hid_parse(struct hid_device *hid)
 	u8 *buf;
 	int status;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -126,6 +159,9 @@ static int surface_hid_raw_request(struct hid_device *hid, unsigned char reportn
 {
 	struct surface_hid_device *shid = hid->driver_data;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	if (rtype == HID_OUTPUT_REPORT && reqtype == HID_REQ_SET_REPORT)
 		return shid->ops.output_report(shid, reportnum, buf, len);
 
-- 
2.36.1

