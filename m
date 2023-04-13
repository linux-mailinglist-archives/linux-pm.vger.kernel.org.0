Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4916E0CEB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDMLq7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDMLq6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 07:46:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717F9EC2
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso12916831wmr.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681386413; x=1683978413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMszukETqZzqN2APgbL3HkGY76Y4/3+HTAH7iHHTbjs=;
        b=fDLj+JhZmQaUGryXvgdjQCNDXdoqFgTkTrHXpJgBrIO+p8SEHrKWCOHuePGBH6lck4
         paIoa1H/oXCczGAfsP8VvFRSCqEEwb3SwOT9gSeMAo+2byYd9eNfTJfBrEk83D7kbqPc
         f1vscaOxgXDndIy4Npotz5zwdqKJpzFKkww2+i5LWp4m3hamd24pZgzN0laa/kQVt9l+
         cerLSDekVJlHYWVHFsGIl2xLZ8P1GQEU/itW2/OwhgGEb29RJkiJSOakmy9bB4Wz2TbO
         ntOebgJ8AM22I6IzdstG5HmQWIwc4RLxHlyPTWJvLcYfmhSBpLIPmueQyxoYxnwnKXQz
         tdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386413; x=1683978413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMszukETqZzqN2APgbL3HkGY76Y4/3+HTAH7iHHTbjs=;
        b=Y/+R6lbjUSuKJFFwK+UyAvkfk1R8EhdyFHGz0T7ZIIdQofVsC9kwabd4gDmMxUd3Bb
         xa13BNZfNFIo97oTZGNYvnM3ezLS40hC2QreJHPgoD+RXsH3EAN4HwUQKxKkwMRTQ9X7
         nJrZZGcnDjcHjx9G4gkq9dLvtsVjVG98oG+ztUu5XdVVZiRlkaZvKzuB+fcOsNC1E2iL
         7q2lDYYcCLZ4rcaz7G/GeASwxr562BRUEeSDv+l+MEcstz5/O3rSly/Zm1elcnJJ26j7
         a1pwCOB/6Y91yJdPiT9gbNOs8Ek8pCUr+8F3cOtvizYTm+hGYa127g+552I0rsW7cOtV
         Vdxw==
X-Gm-Message-State: AAQBX9fN1NkL3uCyGiFPTO4UYkLNX/NXTNM8F6uPGsIrM9zRKIH1n0h8
        kCPOorRGc6wTmKtSfWhuTtXdkzvAnaeL+HQn6TI=
X-Google-Smtp-Source: AKy350anACfJBHQh2ByzrA7WOF3l20/Yr3nEHUhgh97H5ghL2sDsePIl7V7m9RXXj6uMY8O9qq+XKw==
X-Received: by 2002:a7b:ca4c:0:b0:3f0:7147:2ecd with SMTP id m12-20020a7bca4c000000b003f071472ecdmr1626553wml.7.1681386413209;
        Thu, 13 Apr 2023 04:46:53 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm6730590wmb.1.2023.04.13.04.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:46:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 1/6] thermal/core: Encapsulate tz->device field
Date:   Thu, 13 Apr 2023 13:46:42 +0200
Message-Id: <20230413114647.3878792-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are still some drivers needing to play with the thermal zone
device internals. That is not the best but until we can figure out if
the information is really needed, let's encapsulate the field used in
the thermal zone device structure, so we can move forward relocating
the thermal zone device structure definition in the thermal framework
private headers.

Some drivers are accessing tz->device, that implies they need to have
the knowledge of the thermal_zone_device structure but we want to
self-encapsulate this structure and reduce the scope of the structure
to the thermal core only.

By adding this wrapper, these drivers won't need the thermal zone
device structure definition and are no longer an obstacle to its
relocation to the private thermal core headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c5025aca22ee..842f678c1c3e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1398,6 +1398,12 @@ int thermal_zone_device_id(struct thermal_zone_device *tzd)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_id);
 
+struct device *thermal_zone_device(struct thermal_zone_device *tzd)
+{
+	return &tzd->device;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 82ddb32f9876..87837094d549 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -313,6 +313,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
+struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
-- 
2.34.1

