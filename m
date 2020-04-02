Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D040519C417
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgDBO2d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:28:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37419 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbgDBO2I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:28:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so4495996wrm.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IRbhPZus5ePLwsnnR/FLUI/loMrHCnubDThlTfowdJE=;
        b=NFl7TC+azwhOe/7urYy+7eOYrC7ACMCVAA9nMMJtjl34LIpAK8x2yxcdQB1fYxkRY4
         BP1w3O/jmbITRQ0YFfN7hdI2NC9XQ8XhB25dE8slVVaqmLX0YdNUMg1x9VJ8MeSQmTK6
         WSTYM9yr+/rE90fTLsob948PY5WZgmRxYVNx4/VHv6j5BsvtzmwAQDXPlrE8myMrZAxb
         8k9I4E8oqw+K94coZFjyhgaA1GWHWSILNk5T24JMnJY//M+eEhqFlJCdL1Bd29wdK481
         yQEiboUChPwfiC/rZcl31auKBYhc7skf0kDWvblsflXdbnZUpSTsLMP3aJQqxha5U0vZ
         vZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IRbhPZus5ePLwsnnR/FLUI/loMrHCnubDThlTfowdJE=;
        b=E2JjpNlYUEEXESjKiqixujoblW58tLClXORXiNxq8cXqyg5PJ+DFUxvA8/+dawBeIZ
         QIGHpqpR6EUn+2h2OGdFmiN+naRNFm1T0KVfMEPessWz6ze3w58UIFlvJyeioYx8o4Ev
         ZtHbTZZPee1aEv05t90PxNWkeT733FHbm5CzoH12Ucc7XZ7G+ibDwKEtYsMj/lEXjUtI
         48A8/ulzvmLN2Hm4bNLvMb84NOHZNHTclc8exhbWAb/1ZtmsYNmlPPETpejkRAocHA56
         vDA2HATmVoQuNJps2+uXtwgiTR/muZO6KkbigUeoVPfShKgmCp0o9NuTzwuMpIiMExUU
         w0UQ==
X-Gm-Message-State: AGi0PuawLXxDTEtnOXdO7/UaSxnxej1LuR+pXzutiivEh8rb6ZPJzwVk
        1WicpCy1uuIGlAuekwA54IFc4w==
X-Google-Smtp-Source: APiQypJC+E8+VpCIFIw5PcQuQk87nUsoE/ony9aWUiWYpNifN0jcFbqSr2cQu9avwx+x3OeWmIb2Cw==
X-Received: by 2002:adf:e946:: with SMTP id m6mr3944587wrn.187.1585837686998;
        Thu, 02 Apr 2020 07:28:06 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 5/9] thermal: Move get_tz_trend to the internal header
Date:   Thu,  2 Apr 2020 16:27:43 +0200
Message-Id: <20200402142747.8307-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function is not used any place other than the thermal
directory. It does not make sense to export its definition in the
global header as there is no use of it.

Move the definition to the internal header and allow better
self-encapsulation.

Take the opportunity to add the parameter names to make checkpatch
happy and remove the pointless stubs.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 2 ++
 include/linux/thermal.h        | 4 +---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index d37de708c28a..5fb2bd9c7034 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -72,6 +72,8 @@ struct thermal_trip {
 	enum thermal_trip_type type;
 };
 
+int get_tz_trend(struct thermal_zone_device *tz, int trip);
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7adbfe092281..8006ba5de855 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -414,7 +414,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
@@ -473,8 +472,7 @@ static inline int thermal_zone_get_slope(
 static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
-static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
-{ return -ENODEV; }
+
 static inline struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
 	struct thermal_cooling_device *cdev, int trip)
-- 
2.17.1

