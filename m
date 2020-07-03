Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92F82136BB
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgGCIxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgGCIx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 04:53:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C808CC08C5C1
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 01:53:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so33280984wmf.5
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2020 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p8WFiVjLmVPpS5PevlndhZ530MlitNcSeEqWsFmmzog=;
        b=UvOQ2AGYQsTWQAF7d27PvZa/2GDvllXMrGI4ZrUBhv48EF7sRFGe57nPEC0RcvqgZ+
         uF3df68BntrYSEYXhoqsJjLi2AHwDhLY9hS5PTbm6waUGX/F8aahXKUjM/icL5BlEfq0
         GUnmKwQLsaMcyjj5UkU82dNHmDO4b97xlbWI8IHyWrIt1L2jYkGOTfoLjGkY4d+eDtQA
         OxJAA0EvgHdgrGHW7nkJJ3na0xbSEmCr9uwxSdqJ6VBq0Tt+M51XuMUHEwhua00s3ksw
         R2Xhra1KyslJyyrbHCmOrMd6lSIXjlXQMU6odWJShU7FNlc6e/xyfSLMyd24xilGATOV
         EmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p8WFiVjLmVPpS5PevlndhZ530MlitNcSeEqWsFmmzog=;
        b=gpvZUN4pgBOaHIMOei+6eWAULLtr4nOqQ8xDHEgceP9PT9COOOVyh/SM6tqJllJz/j
         4zqMax4SXdZXF7ILhIlBoy3xUPpqmS8KQGg9K6qwZIFXvG0mPs1TCFdRLCEZ66iU3pXw
         2zYv1sZAoRTkkUKNhZ95weaVEPmiXQS/OQt7PXSj0HdyMc4cT5lPBxP2+YOITeoShwdF
         nsL+LrtsYhoj8/HKmlPqZ5lRfCfoRE9X5MtOgxnb2KFK1N9iJByr8WME2wldGQwbhXuK
         QqniLouwmkbF35HDCxaqyC2nb11kY99+2mBrJO1AK/0/uk2g9L+IPcY10FJgHZGtmyRe
         NSIw==
X-Gm-Message-State: AOAM533BTBs838cDkTmle9zBzkJtr7csFJKeZOCEBr9FPkKTxyvKixLD
        XrfwT7bGjkE89csW0TdIAydC0A==
X-Google-Smtp-Source: ABdhPJxDGubryAB7wF5l0K/dtdc3JOf5bU9o5o91ELZUpumOPNR7nU5u09FpGTHnFpKSlda9HJ0YMA==
X-Received: by 2002:a1c:7204:: with SMTP id n4mr28098059wmc.9.1593766406490;
        Fri, 03 Jul 2020 01:53:26 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id z6sm12543611wmf.33.2020.07.03.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:53:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/4] thermal: core: Get thermal zone by id
Date:   Fri,  3 Jul 2020 10:53:07 +0200
Message-Id: <20200703085309.32166-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703085309.32166-1-daniel.lezcano@linaro.org>
References: <20200703085309.32166-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The next patch will introduce the generic netlink protocol to handle
events, sampling and command from the thermal framework. In order to
deal with the thermal zone, it uses its unique identifier to
characterize it in the message. Passing an integer is more efficient
than passing an entire string.

This change provides a function returning back a thermal zone pointer
corresponding to the identifier passed as parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 14 ++++++++++++++
 drivers/thermal/thermal_core.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9caaa0b6d662..5fae1621fb01 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -668,6 +668,20 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 	return ret;
 }
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id)
+{
+	struct thermal_zone_device *tz = NULL;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		if (tz->id == id)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return tz;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 71d88dac0791..4f8389efaa62 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -50,6 +50,8 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1

