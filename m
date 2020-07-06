Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D862155EB
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgGFKz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgGFKzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 06:55:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431DC08C5DF
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 03:55:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so38740395wmj.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JR9CBuqG9kFS0yJ3zc7/YXBJvqVFjvO0122JPCTEViY=;
        b=DvZp82W1MgjPHYb6KpQO6W7bAHFLro9apdhW4T5UwkcECRsELXxTEEWzyY+A9qEe4F
         VCEH673T27dLls1dhOLF4ALR3ZzXDMTWMZ/CueswfPzGP504CbGGMb/EKjAsou3UhQjs
         XoLiWDgEjbgeRQVP3P63h6Jsn+vUM56BoG5vFN3bX5boOxycdRcXfj0ASRM/L7fzbYz6
         iEIpLVKObOrvJJQZcJJZbLltsmb6QpRcWb71Rp7AE9Hb2oX9QLaNTjLbyLKmb1kwr+C2
         vHFKBAZb2zxE7t5gzJe5gfcMhHwSfxtdG4jQX/mW/dqKoDjviPTeAvkyDTcGGcfNJ5Cv
         dlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JR9CBuqG9kFS0yJ3zc7/YXBJvqVFjvO0122JPCTEViY=;
        b=OSAYjT9FcVrHp5cBaPiy5BnQXd2/YtSl6JMZbM3e19Kgtz1Le81sbAV5C5y+nF4tMv
         IfLQadhsgGwAsBVvQ+RTwIrzA78HF5vkV7hw362pwymb1NlbnwxhlIKF6HxI2qxXQogy
         bxsxd7yQQaUcdSHhbNdu9JY7C8m187bqkf2jQRHFkBEDOOcKFO8g+RpDMY5zydZbnoOx
         DvO8K4XkKtAaTzdNjOrPbMAQ7K0+fP5bDD0WZin+nTOabuLpXoCTWkta+6ua1Zy6iZoW
         eK2lQKQNheNstWfqoJoZW/hx4Gc8m/nCJB/ndXXKouupKepu+cFprQvflVQC5WWPUl0T
         uOrw==
X-Gm-Message-State: AOAM531+nEcQGYdOMSwq5iOqP7pEOIeP1yrlmXzNWTCPXVuP14AHELGm
        icP1yDVI7yW4GQPiN8H3EYhBjA==
X-Google-Smtp-Source: ABdhPJzK9D1Jd6yiKePZjI7JUrN3QDcPdX06rP4pEMkPHlOqaqAXxgftGLQNEW0SRHYdK90XFJ4jJA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr40352121wma.7.1594032951854;
        Mon, 06 Jul 2020 03:55:51 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id a22sm22931481wmj.9.2020.07.06.03.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:55:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 1/4] thermal: core: Add helpers to browse the cdev, tz and governor list
Date:   Mon,  6 Jul 2020 12:55:35 +0200
Message-Id: <20200706105538.2159-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cdev, tz and governor list, as well as their respective locks are
statically defined in the thermal_core.c file.

In order to give a sane access to these list, like browsing all the
thermal zones or all the cooling devices, let's define a set of
helpers where we pass a callback as a parameter to be called for each
thermal entity.

We keep the self-encapsulation and ensure the locks are correctly
taken when looking at the list.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 51 ++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h |  9 ++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b71196eaf90e..9caaa0b6d662 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -617,6 +617,57 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *data)
+{
+	struct thermal_governor *gov;
+	int ret = 0;
+
+	mutex_lock(&thermal_governor_lock);
+	list_for_each_entry(gov, &thermal_governor_list, governor_list) {
+		ret = cb(gov, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_governor_lock);
+
+	return ret;
+}
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *data)
+{
+	struct thermal_cooling_device *cdev;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		ret = cb(cdev, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *data)
+{
+	struct thermal_zone_device *tz;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		ret = cb(tz, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c95689586e19..71d88dac0791 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -41,6 +41,15 @@ extern struct thermal_governor *__governor_thermal_table_end[];
 	     __governor < __governor_thermal_table_end;	\
 	     __governor++)
 
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *);
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *);
+
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *thermal_governor);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1

