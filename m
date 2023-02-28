Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06346A57DB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 12:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjB1LY0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 06:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjB1LYI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 06:24:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175AD83FF
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h14so9339557wru.4
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h75YgLAzThWP+FOpMQKnxnohte85PKa1jrYzQU01Og=;
        b=EoPFM3nXOOVR3R9zMG/bqeRFGOggehpwTgel7J0QSyd9r9qjGkmkhXtuT3hSdMaD/n
         8QCUYF5zzqN3LGiu6czsKP1mNpEoQyT3w025nGAMiVA0RkHThb7QbL6Za2gZExEFb0OP
         KI1PdtT+75sKVg8TzLFM0WYj/ud2bkxRy7L+pTAY/LH6OvbvbnZPqiYBUUF97HS1EKqP
         o66HEBOa0s82DwD8H4GNnaW2KF/psP13Crp1FEcrYqqXdSHxingmCYOeDzF5xKXUDTmG
         U86j7g23P+ZRFEVwjqpTfSCZrfNQRRbKtJ+r6tLPSwIoEcnRrURV28VeHa4w2afSaMR2
         xDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/h75YgLAzThWP+FOpMQKnxnohte85PKa1jrYzQU01Og=;
        b=R9U8IWZfxlW1QpCtf9mOmyKJJnPx80+uOoibil6vuh/YyAeMjvdDl+KzlRVEc4KDSi
         /53l5oDg7nFYm/PU3tlHLBV+av4u7ChezJQFVipVCXlqcE925HnAC3Xza74bAAudnJB4
         aKvUVFkJf5ikFFZ5pGw69Ng//j2mchK6SWEV35eqC8ZzF16578KK6hq5TbfshnrQcPG/
         ytokNRk5hZU8KO/I2k91EZvrRw6gG2ZmPhViqxamnAam23BLvI1uz+Jzo4bpLwnhPf39
         nLwHpQ7z2/nKUOfuhOrwtA4V+4NLzkxQmHvmTvWQsKf1/T5VSkgCM0zmklIfUTS9RvwI
         7RLA==
X-Gm-Message-State: AO0yUKVnlfzZcyOfW8S3aBCbxr7K/Xt35buyn6kr86/CemRcW0bqIF4u
        2I8IGX/ErO7iiKnNsk/wlmanUgBIQ/ZvPr85I9w=
X-Google-Smtp-Source: AK7set83C+IPXo+v9Py+BS5DoZCn57Ys6WIwQUCbxSOTUvKfKPlYHOKz0RpI7oXIE5//MQ9SN+fkjg==
X-Received: by 2002:a05:6000:1705:b0:2c6:c9f1:e444 with SMTP id n5-20020a056000170500b002c6c9f1e444mr8212787wrc.16.1677583409540;
        Tue, 28 Feb 2023 03:23:29 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:29 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 10/19] thermal/core: Add thermal_zone_device structure 'type' accessor
Date:   Tue, 28 Feb 2023 12:22:29 +0100
Message-Id: <20230228112238.2312273-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal zone device structure is exposed via the exported
thermal.h header. This structure should stay private the thermal core
code. In order to encapsulate the structure, let's add an accessor to
get the 'type' of the thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9fa12147fead..913ba9ca9792 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1384,6 +1384,12 @@ void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
 
+const char *thermal_zone_device_type(struct thermal_zone_device *tzd)
+{
+	return tzd->type;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_type);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7dbb5712434c..21686e676b3d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -366,6 +366,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 					struct thermal_zone_params *, int, int);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
+const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
@@ -443,6 +444,11 @@ static inline void *thermal_zone_device_priv(struct thermal_zone_device *tz)
 	return NULL;
 }
 
+static inline const char *thermal_zone_device_type(struct thermal_zone_device *tzd)
+{
+	return NULL;
+}
+
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-- 
2.34.1

