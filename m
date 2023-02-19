Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E869C0EA
	for <lists+linux-pm@lfdr.de>; Sun, 19 Feb 2023 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBSOjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Feb 2023 09:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBSOib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Feb 2023 09:38:31 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66541E05C
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2023 06:38:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s17so439840wrt.8
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2023 06:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwIPDKt1NKah2ZF5gKdn4z7lJuGWL0P0jWTGeT+NApM=;
        b=rko85JpPzkGDr7nw73V9ShJorcL22/szXUgHF7fomf0L9Bob5r/SBQe8DivWZpHPck
         Id/3qKIAZml1QfPMTJZ2R1/VJtkPrWSNKnZcxxWVMsr3NfvSyZ7vZ+9hT1qQrWpD8L02
         3+FTd2fM/jBmJ2DnKNzHPWtCDiWFdbnunspXRUpvnT9MaSsrsnA4GOJwe1wGsWZtu6lE
         BVqtDot0lXNUpNhiQBmXYZ1k0/uTuVWmUZWCnfOog6O+dNuY1D8YE99I84dcK+U93VRv
         jiQPOcC1/h6aKO3XlyM5GSXsh5Eu4UiZV/TmsXsf//6js1Qqs4PGyggSk8WRvQqyJkmn
         UMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwIPDKt1NKah2ZF5gKdn4z7lJuGWL0P0jWTGeT+NApM=;
        b=Vg6mr20esuPUxfaWcqEDhXpizn3FVeYKG4Rk0KBeAHZoqCeQrIQaaugn2s62rcD16Z
         nzNjyLs3tJov77r8drSuxMr1j0x1q5IXus95k9VCYQZvvqqg+QXN9IGk7IXWwWczj8gN
         6hT8HE6v6Tq/uVD7Lg3IF3liR947MPU9RO2MS6oMYRwR7CzaNxxFcTlj3KrgS+kvzESK
         bnQ7QWFkW4IQ6prabhyuHDisaNqrhL3iecMealB9D+26vEOeByyF/YxOkd8gSYGogslc
         iFdKbWd4qlgkQyr6lYivaOei9fCAlt4Hdxrz/Ol4qjo/MF5jHZCXX1AfylFZ83d4higd
         RTyQ==
X-Gm-Message-State: AO0yUKXrZnhsr3tWL9sa2hKMhy7WZ7imEYvqRqP63xVpRo/dU/iA7UYS
        z4KXaFlncC3jsjfcuJOFTercFQ==
X-Google-Smtp-Source: AK7set+T6NGS+8dLBFQbXc5KviKVoYqPgYbHtt4Fa+ii31MWbUlC+0tgTBmpM8q48+kVxUhmjMTwFQ==
X-Received: by 2002:a5d:6906:0:b0:2c3:e7d8:245c with SMTP id t6-20020a5d6906000000b002c3e7d8245cmr1145326wru.13.1676817482798;
        Sun, 19 Feb 2023 06:38:02 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 07/17] thermal/hwmon: Use the thermal API instead tampering the internals
Date:   Sun, 19 Feb 2023 15:36:47 +0100
Message-Id: <20230219143657.241542-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
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

In this function, there is a guarantee the thermal zone is registered.

The sysfs hwmon unregistering will be blocked until we exit the
function. The thermal zone is unregistered after the sysfs hwmon is
unregistered.

When we are in this function, the thermal zone is registered.

We can call the thermal_zone_get_crit_temp() function safely and let
the function use the lock which is private the thermal core code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_hwmon.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index bc02095b314c..15158715b967 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -77,15 +77,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int temperature;
 	int ret;
 
-	mutex_lock(&tz->lock);
-
-	if (device_is_registered(&tz->device))
-		ret = tz->ops->get_crit_temp(tz, &temperature);
-	else
-		ret = -ENODEV;
-
-	mutex_unlock(&tz->lock);
-
+	ret = thermal_zone_get_crit_temp(tz, &temperature);
 	if (ret)
 		return ret;
 
-- 
2.34.1

