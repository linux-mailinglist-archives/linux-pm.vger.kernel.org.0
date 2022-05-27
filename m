Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA545357B2
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiE0CfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiE0CfJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F3E7300;
        Thu, 26 May 2022 19:35:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n22so885310eda.5;
        Thu, 26 May 2022 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dk2CW0KMrU8cUUrOM6+5oNfiuXKphpsTeJl2rd9O1jE=;
        b=EVxd+bqaqEwLNWSfop+9ovXmDXm+fdgk4OAoH1RJ0K+E1cRdHmbnMJmvgp1yqi68aG
         UTSaoW0u9QBE2P8aAWrdvH3lugg8L8XOt7niraQSNx5EQaZ5IYV6tXNKnS8DepCuxqM6
         CSKJ8tfsBqlAdkybniXZOV9skzg1MfarWA29LFd3ccTYdZkMFHpis9Im5kEcqnsr4+Yo
         Ht+hoSi7H54dzr/EXFN3DAcu60RMMbj5ujXc4odDHm0jfzRONZA8f4qxYZER5Em4sKi1
         yM7caSaljDZ/M2bbjch80usULpacclQZ94KHqmjZx1Mr0BaR32uGWMv+YBQpJA9+dWP3
         wUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dk2CW0KMrU8cUUrOM6+5oNfiuXKphpsTeJl2rd9O1jE=;
        b=UUbMY1ea+JlFzI/WItSIyQD8437mble6DlqT2iGweudVx9YCy5UlVU1ycStxkJh/Bw
         A6/qvCOoIGm1dp/aBpIimJ1WpIPymUbMcjqms3f0q1aeFQdiFrRXnYqfAGBE9UwkHHVV
         mG4yDYkL0zL6GEAlBgWUBgtIOvCkNaeQjRSAIfaacNTtoxZv3YAODFKiuMJDPUgvT0N4
         74wPRC/MUwEu5KFdBL7c5E6SSe6xIVJ4Mk3e46hO8r/zl7X29T7itq5ukRnvx96m7XKz
         AU6Bt8sDS9fjB/ywaJGCk9GlxQOYwu8QQnNxpRGavwWDl9SzSTqMJJdqlNBzOittnkXl
         mEHA==
X-Gm-Message-State: AOAM531ZZ7UU6YfZ60JeQP/gS3vU07imDci+avEMs2RtvaxKsuzb8AlZ
        YzLIYXDo1Yrcup/chGV276c=
X-Google-Smtp-Source: ABdhPJww5phKO6ZTWttlGFWlqMHY/0LEKcufOVU/YqIt7E5NxZE1CzlLfzjMqhAT3ntNyeKVzjpWCA==
X-Received: by 2002:aa7:d2cb:0:b0:42b:c9f8:a236 with SMTP id k11-20020aa7d2cb000000b0042bc9f8a236mr11194395edr.347.1653618907541;
        Thu, 26 May 2022 19:35:07 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:07 -0700 (PDT)
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
Subject: [PATCH v2 05/12] power/supply: surface_charger: Use client device wrappers for notifier registration
Date:   Fri, 27 May 2022 04:34:40 +0200
Message-Id: <20220527023447.2460025-6-luzmaximilian@gmail.com>
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
 drivers/power/supply/surface_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index a060c36c7766..59182d55742d 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -216,7 +216,7 @@ static int spwr_ac_register(struct spwr_ac_device *ac)
 	if (IS_ERR(ac->psy))
 		return PTR_ERR(ac->psy);
 
-	return ssam_notifier_register(ac->sdev->ctrl, &ac->notif);
+	return ssam_device_notifier_register(ac->sdev, &ac->notif);
 }
 
 
@@ -251,7 +251,7 @@ static void surface_ac_remove(struct ssam_device *sdev)
 {
 	struct spwr_ac_device *ac = ssam_device_get_drvdata(sdev);
 
-	ssam_notifier_unregister(sdev->ctrl, &ac->notif);
+	ssam_device_notifier_unregister(sdev, &ac->notif);
 }
 
 static const struct spwr_psy_properties spwr_psy_props_adp1 = {
-- 
2.36.1

