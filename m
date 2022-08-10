Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2058EA3A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Aug 2022 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHJKHr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Aug 2022 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHJKHr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Aug 2022 06:07:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34772ED0
        for <linux-pm@vger.kernel.org>; Wed, 10 Aug 2022 03:07:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so17196357wrr.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Aug 2022 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LWzqLuQMDEGMHZoekanxcPWRbunj7NWtZ9GA9V1JO+M=;
        b=qvEDKFZl7goY+YsVsf9474bsbHIMv5a1lhvRzWEXO+qTIcBfv4R3FFaxCgoJzQ67MS
         JaVX+jvKjH5wdq6BmFRmOGAgGqRVxh/5Fm1kLJxlqVd/34xvvQjs9/hUtSnkKYt9JS2A
         wRZRxd9rZ+eI+49vciYHIfwEEZSHSscv73+JeIpN7wQ5UuxKBryD3S4T1psRd+rAdYE3
         CmEwfL0ck/SM1bxKXduhfPOC8kgjeQqf/La33nD0/GNrJKa0wuZdFFLDXLENo6sgC+oQ
         XCiMXWYTqgBx0gQBoxACArf/QUKw5d4zdE6HkjZwu06tZsVoj3PBvaz1G4OEkPemWJcK
         Yk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LWzqLuQMDEGMHZoekanxcPWRbunj7NWtZ9GA9V1JO+M=;
        b=v5FoAbCyyxTANWORVBVqTWcjtoOJ3ZuQQXFr6xYRUOJ2k34khulV/clk1Qk3T/Dd9X
         nAPGOWYAfd6IO5GUMSeodM+psOQcjLj7RCgiKwE580LuVwaDDyYCWQWn0NhNp0od5Jr4
         j0Cj9u0FBL2l/VIqJNUF4quLozP3b45rtde6gI56qp/UYrAj35Uz5zBzR5aTrGDlPzfV
         X22qrIB8AcLr+6wtLeqwU0ZTHTB7rj9fAbzsd1tLsub0kgMv+5B01v2D3URJy/Pt2YWn
         molqZZSpou0sYbFSTCLeEw8MDAcxFJ6TTVxPI80Dd+hUGdZEL3rmYkqNES6N+9rHMHx/
         RwTA==
X-Gm-Message-State: ACgBeo2Qthrbx+1yK/xIYmgHmeIBsKUi3ofnCj9vYKjVTikVG3+flZw0
        B9OhJ11ArEd2YsOW7psii8lGpw==
X-Google-Smtp-Source: AA6agR6F2DFf2ERJv6skFwyV9xeFH7tzlIIKgxlXFcn53bH1pjzj9rbMdyaC5YrLVVJ0nlWwjRHIRw==
X-Received: by 2002:a5d:6608:0:b0:220:625e:f4e1 with SMTP id n8-20020a5d6608000000b00220625ef4e1mr17635086wru.252.1660126063271;
        Wed, 10 Aug 2022 03:07:43 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b0021e491fd250sm16037067wrv.89.2022.08.10.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:07:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/core: Add missing EXPORT_SYMBOL_GPL
Date:   Wed, 10 Aug 2022 12:07:31 +0200
Message-Id: <20220810100731.749317-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function thermal_zone_device_register_with_trips() is not exported
for modules.

Add the missing EXPORT_SYMBOL_GPL().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b4c68410c158..10c979dce512 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1329,6 +1329,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	kfree(tz);
 	return ERR_PTR(result);
 }
+EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
 struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
 							 void *devdata, struct thermal_zone_device_ops *ops,
-- 
2.34.1

