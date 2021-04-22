Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57746367F9D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhDVLfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhDVLfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 07:35:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB532C06138C
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:35:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n4-20020a05600c4f84b029013151278decso2920419wmq.4
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvmGnR6fqZoWGO+g5KCcukp75k8kdVWhlFSmREYCODM=;
        b=coK/So83Z+mSD4tpAr7Z52tFLvTMp4KQbeAuXoQICTLfBRKytKCAl3MUT/jf7RLHkt
         HlzZ/HLOiaIT9otzb5XeeRAvfOdTYmnDnIzLEMd1KBKj9Dg9TgQKgxxVUsywbO3O0o+i
         tikPeYBQcT++BYYsMUbgxgw2+SusJ6gWl6J3pV/ZhPYmVdNAwqchPug9k7ZtGwiL6irT
         FdMOWzlPcyex9V3FKyiJiRSy7gw7DX3ZV8y+2vNz/NW2Tn0BgnmKsvPKAO477ylz561R
         cyNJp1MGMKnoNBuHph5LeHXJrl5Clk7tHqUXr4E10KAiAYbDdTYpz6nt7yhR12F+ADMf
         WCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvmGnR6fqZoWGO+g5KCcukp75k8kdVWhlFSmREYCODM=;
        b=G8RocztLOMuh8JKjW+x1kxYGZn2yH6Bmo64iKqagecRHc5Uy++69pI/WDC3qzy+zoF
         LPZTLHqNLi34uu0Kb3nBRyvuueVJvlPQknrK7ZdlHZl6RktwOSR5RCOUwvLPjUfviEta
         +gFWyxYzooY83SHXoKe/C0zqFJoR2/i24xbOfty/rHwUjX8iE/ijdUaTZTFiXUwOkOID
         iJanJNI6+ASrekY9x0sVIEJCpn2r+UtiMXJuuyYD5e4aWmX/DpS8sA7IsbiicnlppVMc
         1N8rydxxMH87vc8e5tHC+PfWkacCYFLdW5dQWZeC0197W4RrhnKqPysOfH9fmi7a0Rn4
         OOAQ==
X-Gm-Message-State: AOAM533Y/qnx06hM89WFV3zqJwg8dBkwFJR9qc1wUdx59BSsxVLSilhJ
        JRtcbPDihQvILNjbHqn2hyLKIA==
X-Google-Smtp-Source: ABdhPJzrYExd2/JRMa38rbWMA4zaMAIHSyQcTpBabzlTpDnfo7zv0ijWlGMUItsEsf1w7znniQv5Ug==
X-Received: by 2002:a1c:7707:: with SMTP id t7mr14745827wmi.76.1619091310528;
        Thu, 22 Apr 2021 04:35:10 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e88d:2580:c20:b786])
        by smtp.gmail.com with ESMTPSA id u6sm3237890wml.23.2021.04.22.04.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 04:35:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 2/2] thermal/core: Remove unused EXPORT_SYMBOLS
Date:   Thu, 22 Apr 2021 13:34:56 +0200
Message-Id: <20210422113457.51578-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422113457.51578-1-daniel.lezcano@linaro.org>
References: <20210422113457.51578-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The functions exported in the thermal_helpers.c file are only used by
the governors and those are not compilable as module.

Remove the EXPORT_SYMBOL as no module code needs them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../driver-api/thermal/sysfs-api.rst          | 28 +------------------
 drivers/thermal/thermal_helpers.c             |  3 --
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 4b638c14bc16..c35266bbc119 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -711,33 +711,7 @@ method, the sys I/F structure will be built like this::
     |---temp1_input:		37000
     |---temp1_crit:		100000
 
-4. Export Symbol APIs
-=====================
-
-4.1. get_tz_trend
------------------
-
-This function returns the trend of a thermal zone, i.e the rate of change
-of temperature of the thermal zone. Ideally, the thermal sensor drivers
-are supposed to implement the callback. If they don't, the thermal
-framework calculated the trend by comparing the previous and the current
-temperature values.
-
-4.2. get_thermal_instance
--------------------------
-
-This function returns the thermal_instance corresponding to a given
-{thermal_zone, cooling_device, trip_point} combination. Returns NULL
-if such an instance does not exist.
-
-4.3. thermal_cdev_update
-------------------------
-
-This function serves as an arbitrator to set the state of a cooling
-device. It sets the cooling device to the deepest cooling state if
-possible.
-
-5. thermal_emergency_poweroff
+4. thermal_emergency_poweroff
 =============================
 
 On an event of critical trip temperature crossing. Thermal framework
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 7f50f412e02a..0ecf2c66aa76 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
@@ -63,7 +62,6 @@ get_thermal_instance(struct thermal_zone_device *tz,
 
 	return target_instance;
 }
-EXPORT_SYMBOL(get_thermal_instance);
 
 /**
  * thermal_zone_get_temp() - returns the temperature of a thermal zone
@@ -221,7 +219,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
-- 
2.25.1

