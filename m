Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF76A350F
	for <lists+linux-pm@lfdr.de>; Sun, 26 Feb 2023 23:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBZW4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Feb 2023 17:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBZWzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Feb 2023 17:55:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFAEF94
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k37so3192943wms.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h75YgLAzThWP+FOpMQKnxnohte85PKa1jrYzQU01Og=;
        b=szdvHvEQFacto3jfDsgXs69woDlNj6Qfat9BZZMO7Mhjhb44Hfv/5UR2NpHEpMnhUb
         fZWPxUTwb/RHMVbBtUDkqpmKWuWvxSFMB4NFBhTeLmMIs80SINsioOvnX9Tt/UME7CzQ
         rBATD1N6LkwX/YB8ZQj5a7bP5wkFex+TJUklEkXWoEIPSOw0TSekPh3P+8QYtObVFUg0
         WXheRumCQrJM72MVT9iU8ySciJrN3ofjghGY6n3Al0orLiBaoIlsbVY9U7kSVylFYqTt
         3/s1Hbf0Vccv0l6RE5Nlj7IgJr5eMBC5LWE8kg2XKntoDaq9pxpVQ8Y5ArqbO8+GoCWO
         TI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/h75YgLAzThWP+FOpMQKnxnohte85PKa1jrYzQU01Og=;
        b=SDOH2BLvJOJ2Mh7sCkHIgqVkCbJp0LDVBthB9GctCvTAmIwre8NKyl5VVG7I1FtSp8
         ERWC784dOcHJkr+XRbUKEo+I4XptdLY1I5KOwDFrEnTuIqh1acrhtGbq3yg7WD5c0K3n
         +jRWAT1KwBLeWU1jIXo8RUU91XeymEROXjs51/ER1xL3NozONFYCXjuHyxswHbpFNxqn
         bY4Gksk95ya5vH/+hfUMU4/z5tjFlY69sxzpDvoNQKZCKePUAPmxMiOjEKmEq2xr9Syj
         mUF57PyrI7qNKO64XVMgT6ZQRkR3214P4uUGTqxKKJdw2NrajyYHaegg6DbNY3S6MmfE
         0xaw==
X-Gm-Message-State: AO0yUKUMHzK+GTpff6t97EuWE8zPj4U8zKvBwu/+ZpoBBBEhsZOUPmBA
        ANCYt6M3C+2tjF6f6+dtpr3/bQ==
X-Google-Smtp-Source: AK7set/dI8KXWuQsmb8TxnXXrtA+ItUhp6CBsztIvjFlFAJF2CTBGRmbqPcvU4ckNwk7cBhxrdsWUQ==
X-Received: by 2002:a05:600c:16c7:b0:3de:e8c5:d826 with SMTP id l7-20020a05600c16c700b003dee8c5d826mr11260810wmn.28.1677452107900;
        Sun, 26 Feb 2023 14:55:07 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:07 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 10/20] thermal/core: Add thermal_zone_device structure 'type' accessor
Date:   Sun, 26 Feb 2023 23:53:56 +0100
Message-Id: <20230226225406.979703-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

