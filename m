Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00523AA3CB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhFPTHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhFPTHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:07:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835BBC061574;
        Wed, 16 Jun 2021 12:05:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l15so1065996lje.10;
        Wed, 16 Jun 2021 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=va0+qiXaJa2dkVAtKTxaRs0owh7E90Unzjnj9OwUGvA=;
        b=AXtNeQfL7+Cja+Hd7a0iIQvkE0V/kOtsEiNQlb3L8fuy8WTuthYn7SUKvU2E9kFac1
         8R9b86zBxTlvf23J4c0a2K5F3OrbYlLrQ1IP4q0gaN51ZQ2OdE7RV7wULeDtzRHO4hNT
         DvwLlWaeis0nnHTVaUlXDGBySPD6/X4gETCe0IPXeJMoX6NFlPfvP54CmafIRRZBGn4Z
         kJRmJrfwxHrdD8CgYNzlFCpZ4h9aT+REdmjkFqM0Zep6gq4Uon2wQi0oGJTLX16HQp8r
         fIjMJnixn8kfGi5yltKGJRjs4RfQ24Dyd2/2PNbCpZ4vXRL9gA/7q6ou2uP3N2xbotWj
         H6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=va0+qiXaJa2dkVAtKTxaRs0owh7E90Unzjnj9OwUGvA=;
        b=SskL1CR/ENN7AHQVTU+U7b6ZUThNMuknnnHI+ln/NZa2GvfwtWDy1J9VvywnxmPqnL
         CwEYQOnmKpbKPAPkkiSEyaNHsrZTypceVcB/5I9FMW7PX4n1JJKBpz86gQSff7g+LZO/
         BXOf2aUGjYk8cOve44Yt5BhIn1wLhqYN8drG946AP3/+hxHo0ORnGjtPHZ/ErSVEQRp4
         9vPSiFuSK677oUEwLet4Cpw9rtY6O9ryzh4877JrBxW43f3o3gwmRyUdgf6Q8tre2rHi
         sM9Tg08YjI9G/hakBSf8qooqcDWLyLJ8wvu+ad8kpZ29aHpTkUqYYjc5o0E9dAU6xH+R
         JI+g==
X-Gm-Message-State: AOAM532ilhFzMw5VGLJwv+tNHYcSKNaRD10Lgqo6VayzjueyuRjLHjVE
        hOS7CNmzFyzAIbV7sHo3axw=
X-Google-Smtp-Source: ABdhPJxcw+aqBdNTD93l8/H4iNjuUjU9I2NycrrJ1U6uxBx4UiOGx9JKWBmW1f9n/PFKvZIH/a1Nuw==
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr1162603lji.304.1623870329893;
        Wed, 16 Jun 2021 12:05:29 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id e20sm365951ljk.67.2021.06.16.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:05:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 2/6] thermal: thermal_of: Stop zone device before unregistering it
Date:   Wed, 16 Jun 2021 22:04:13 +0300
Message-Id: <20210616190417.32214-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616190417.32214-1-digetx@gmail.com>
References: <20210616190417.32214-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Zone device is enabled after thermal_zone_of_sensor_register() completion,
but it's not disabled before senor is unregistered, leaving temperature
polling active. This results in accessing a disabled zone device and
produces a warning about this problem. Stop zone device before
unregistering it in order to fix this "use-after-free" problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/thermal_of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5b76f9a1280d..6379f26a335f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -559,6 +559,9 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	if (!tz)
 		return;
 
+	/* stop temperature polling */
+	thermal_zone_device_disable(tzd);
+
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
-- 
2.30.2

