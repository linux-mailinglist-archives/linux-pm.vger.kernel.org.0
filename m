Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F9F5357C1
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiE0CfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiE0CfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA9E64C1;
        Thu, 26 May 2022 19:35:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h11so3830430eda.8;
        Thu, 26 May 2022 19:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zy0ZMngfTOngFEr2IYaeKfKrlSi1ZcJUZpm4PtyoKk=;
        b=CFTp3sTkY5CI8c8bv7T4i4oB//dxfwZP4PtkA6hHzdT4UKYA8tNK7wAfjOBE6a42vf
         5x4Nhboo4ywWbGmUC0MnTHWWyRWFdpUCcoaZBU/91pVIXK0iPoZri4fj4PhW45ZOSCpR
         dIGcD0f/dVXwUlviSMq+MzFU0Y79Y8fLKWxIUTTKo6IHV85Vgha/2wo6hF1Y+310LCZ2
         x4Cyk2W89y01zeST7O5hZE/wcHkaqcgnVQ2JEfFFAS3NOCbBFPVcr9oeeYPNDUIkeIt1
         OHp+yn7GDG61dNUnuHmUO+kmuUxpfL4YfE8FkJ4xp/Hzc791fONPNqksMZWzJv8zChlB
         B4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zy0ZMngfTOngFEr2IYaeKfKrlSi1ZcJUZpm4PtyoKk=;
        b=IaWOFYWf1YM08hX6gXuDXios51R2ndHRivWsrUqyOMd/hrhLrEVreV+9/D0UdcPnr9
         V0cUU6JJXiAO8pQs7JifLdviiHQ5xfdZyscd9WAAcR40DoB5IYQGDaqIIeLAHNOJSxYh
         K4q842qbGiJM9R6DTmQFXQ30TW/EjU4JiEF18y4dHgqZgTqDIbVnPySwdrc769ANqID5
         gp81eFyZj6Nq7HKuOQKlb6RBt8EAybZsodyBtGPtspyRcwCWcv+dAtq+LrD613Oan+Z6
         ErNNqO1Q9gG6gurTyWI3EejkWkatemL1qKYm8iE5GmkeGWrqRg+VzkdgouyBPQWhKhSq
         8DCw==
X-Gm-Message-State: AOAM531QJbVCok+3trYOs0k0AZH23Ud8pS9b8VtPoSa9XddjA6ngrne1
        bMHxnBSZHep59l3ag3e0e6A=
X-Google-Smtp-Source: ABdhPJwFjNXrX7OMZt7PLSL2J6omXHehakVkWuDP2UASzot24lrRxYlHgRbZuREjkzMOZYQMbZjLuw==
X-Received: by 2002:a05:6402:2682:b0:42b:5ace:b0e5 with SMTP id w2-20020a056402268200b0042b5aceb0e5mr26557462edd.358.1653618908819;
        Thu, 26 May 2022 19:35:08 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:08 -0700 (PDT)
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
Subject: [PATCH v2 06/12] power/supply: surface_battery: Use client device wrappers for notifier registration
Date:   Fri, 27 May 2022 04:34:41 +0200
Message-Id: <20220527023447.2460025-7-luzmaximilian@gmail.com>
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

Use newly introduced client device wrapper functions for notifier
registration and unregistration.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - none

---
 drivers/power/supply/surface_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index 5ec2e6bb2465..540707882bb0 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -802,7 +802,7 @@ static int spwr_battery_register(struct spwr_battery_device *bat)
 	if (IS_ERR(bat->psy))
 		return PTR_ERR(bat->psy);
 
-	return ssam_notifier_register(bat->sdev->ctrl, &bat->notif);
+	return ssam_device_notifier_register(bat->sdev, &bat->notif);
 }
 
 
@@ -837,7 +837,7 @@ static void surface_battery_remove(struct ssam_device *sdev)
 {
 	struct spwr_battery_device *bat = ssam_device_get_drvdata(sdev);
 
-	ssam_notifier_unregister(sdev->ctrl, &bat->notif);
+	ssam_device_notifier_unregister(sdev, &bat->notif);
 	cancel_delayed_work_sync(&bat->update_work);
 }
 
-- 
2.36.1

