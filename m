Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3665357A9
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiE0CfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiE0CfI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C0E7300;
        Thu, 26 May 2022 19:35:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so6241973ejk.5;
        Thu, 26 May 2022 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDZ/G0YfQBuvKWmot1TiK8cSRjIWW8sqvlvgqtbxUAM=;
        b=PLMSNyocMVzT3IY5f+1Ckgxium6vWZYQHaQS3rg7muFGJcLjLR68wtrlXViB+xtQpJ
         hrhf9j3e4Wwev7le1VBN01T5T3DPOkdkUNglmiNh1A4ADEGdiIVd/454kLj0oDfp0aeV
         3auSAM8IPG78IDMStyXVya7LiUoryjYIkBpLfHaQnlG64jquEFOhjYsX9Gm+vlQiD4vL
         8DhkdlS711QmjCVuqCm88S8bffZOSLTpDzZuJEkf4o8bQaEjUEWseId0HltPi42ZeeKc
         f6quR+g5huY03igrCLKsCZa0imIw3Kp+elXB0jJJ/qzlRr3k7xw3G+oFsBOEOELuE5jT
         Akfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDZ/G0YfQBuvKWmot1TiK8cSRjIWW8sqvlvgqtbxUAM=;
        b=YUn6mFBCJulUBjPxjSsZZI+ENcBPqo6Yw1D/6zEm/A6cdjJlW2B1KIGAj/Mmvv7Fhl
         O3HCxvpRE9OBnN/nRhZoqna2Pe2KAmBLFPHNlknesnzjz8ObCmnUJeJaB1TJFhXSH/kp
         fv2XolNEElP+GLuPQDln3WRJ6bCROOJSTM9HW6Qk9BiD1WsrlNElMUwLpy654h5xwjAg
         J4dGqG4IGbwr+INUBiGgRDguan5jjh0RZuOfyMq6a3H0meGQWJzKB/vPUbTdKm6gy0C4
         H0gwE4ZcTd3JxSF+1JTM+CxcfeB4QmDkgMJiby7g6/gXFJwm5PLlFwkZGGjj9BEsXnwq
         FvKQ==
X-Gm-Message-State: AOAM533xXO/zXcwKlgo9TVpy8Jvx/SXFhe5rlQ4+c0k/dt1Hfrq28p3z
        vrJyo7VN5+PFdXQk81Mf/SFqzDJfTaY=
X-Google-Smtp-Source: ABdhPJzFKTuKnAGK900l+zi060kYdMGkv+0mxrqDuEd6uCDxL5LFmfpLUExgyWoJlYC/ur+JNpFR+w==
X-Received: by 2002:a17:906:478b:b0:6f8:5850:4da9 with SMTP id cw11-20020a170906478b00b006f858504da9mr35851982ejc.619.1653618906257;
        Thu, 26 May 2022 19:35:06 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:05 -0700 (PDT)
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
Subject: [PATCH v2 04/12] platform/surface: aggregator_registry: Use client device wrappers for notifier registration
Date:   Fri, 27 May 2022 04:34:39 +0200
Message-Id: <20220527023447.2460025-5-luzmaximilian@gmail.com>
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
 drivers/platform/surface/surface_aggregator_registry.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index ce2bd88feeaa..9f630e890ff7 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -468,7 +468,7 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 
 	ssam_device_set_drvdata(sdev, hub);
 
-	status = ssam_notifier_register(sdev->ctrl, &hub->notif);
+	status = ssam_device_notifier_register(sdev, &hub->notif);
 	if (status)
 		return status;
 
@@ -480,7 +480,7 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 	return 0;
 
 err:
-	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	ssam_device_notifier_unregister(sdev, &hub->notif);
 	cancel_delayed_work_sync(&hub->update_work);
 	ssam_remove_clients(&sdev->dev);
 	return status;
@@ -492,7 +492,7 @@ static void ssam_base_hub_remove(struct ssam_device *sdev)
 
 	sysfs_remove_group(&sdev->dev.kobj, &ssam_base_hub_group);
 
-	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	ssam_device_notifier_unregister(sdev, &hub->notif);
 	cancel_delayed_work_sync(&hub->update_work);
 	ssam_remove_clients(&sdev->dev);
 }
-- 
2.36.1

