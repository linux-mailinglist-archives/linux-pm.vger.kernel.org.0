Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF396E754E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 10:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjDSId7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjDSId5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 04:33:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B61CC1D
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so1010248wmq.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893228; x=1684485228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMszukETqZzqN2APgbL3HkGY76Y4/3+HTAH7iHHTbjs=;
        b=fNZBgi5/L3NSZbebaISkqutxQT/xaM4SeSQXMJbnPyvV/yxFlknwejRTPL/+W3vMHN
         Ts+vcb++sTq5LlGQy+2K0KouVsNq87U5HlHH2CTUEwXoGBmgei3wKuwoe5YEsWWI90Yc
         5geInkDOs9Yg6o9c/ATkbwFS9GWM2/OaCjNXD3cTLRP8HE6+0EPLdoKkHMNDGCTmpdo4
         FbVTrAeX3+KiTZ8FapxG7SPn1UAK4Ig7xgGTSnTqUJdgP4rLNlD4h8/pbShZfsYFX+sq
         yPrVAP9PfOXRYimayZIq4+58i5pWqdnDYbGEKRdj8WYbTjACr2ef41PswIzTWqEcTPRR
         HPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893228; x=1684485228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMszukETqZzqN2APgbL3HkGY76Y4/3+HTAH7iHHTbjs=;
        b=c/v/U33S/kvzPxUEVULN5tMCeNv7B6pqhfkl1a0P0mMw31iLVVQONajdPxOy+AexNt
         WM4kUAZdpds8WXxXYLLiazinESPakKgObFcgfYYdb+nZH3Rp8wvjiW5j0p05XRDEedL+
         s2Ds5yiwMJO0gmjsy5LB/85wm42uaYN3Q/YKF0Ft78nE9ube/mluc+ZMreioy8aeRFTe
         LgNsg1xUfGx+emzJ1grnVnofj3aYJxbmUHoTqoYRjJXIs55w9/Kgt0n3Vtb80RE6GI10
         tykF0MW5VCUCTYdVQr6ksvgIqw2ksRl4L8CW1SqSWD2pQzSnK3K9ok1Lpk+qzUqQh8ur
         it2g==
X-Gm-Message-State: AAQBX9feCN2yuVbAVGBwVcZBrZMipLt+kdlDszbYsqIDh2TwSNcQzcuU
        U+JtNH0NyQH1pcDNdKYaWohEcGhUI095mBsRkECd3g==
X-Google-Smtp-Source: AKy350aeTvxrVBN4wqb36Ek3mmEth8i47hzKwiDTK0PVlfOxRZIQFDS7D1tHtEb4wmu9rc/CsKT74w==
X-Received: by 2002:a7b:ce97:0:b0:3f1:6fea:790a with SMTP id q23-20020a7bce97000000b003f16fea790amr8789096wmj.30.1681893228584;
        Wed, 19 Apr 2023 01:33:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a794:9fb2:29fb:606d])
        by smtp.gmail.com with ESMTPSA id s5-20020a1cf205000000b003ed1ff06faasm1442033wmc.19.2023.04.19.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:33:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 1/6] thermal/core: Encapsulate tz->device field
Date:   Wed, 19 Apr 2023 10:33:38 +0200
Message-Id: <20230419083343.505780-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419083343.505780-1-daniel.lezcano@linaro.org>
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

