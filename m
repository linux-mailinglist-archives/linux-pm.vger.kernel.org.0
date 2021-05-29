Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C93394D6B
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhE2RMW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhE2RMU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 13:12:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034FFC061574;
        Sat, 29 May 2021 10:10:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 131so9272642ljj.3;
        Sat, 29 May 2021 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcXraiNoRPU0G8oGIVhPyNHE4YAr90zRs8GgZNjViE0=;
        b=YCaDe2bDmorvvCgvE1ShVN/7GR+xVx4dF6waLCCWikaW/lTY/xX0q8+9RzHGDih738
         PrQrnKTGSlToJEDVifQew+0xNe4FcXqDSVj64BH35G8zmxtzoYyspZ1sCU6jd7XmhUIN
         Q3jmCcCKR/WHjMqgXdpFeGrMjDfa4TSptNAotxo4Ro1vJoYoCav+0bSPQV2Dc6fgwI82
         f+ZRaoBvmb4VPdMz4SQcA+9nyGTRQYjrzPuCidyJrozEWGTnpMC1UAeWOECjVr357xlJ
         3qcqEokOeJcSRLKeb3CR93wvR6yvBd7jdX6NF5zB53ch4C0F1ZXuV6rJDHIu46vg611X
         zlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcXraiNoRPU0G8oGIVhPyNHE4YAr90zRs8GgZNjViE0=;
        b=bveRvCQxTwOu5Z/HWu6PsUuPDqMDNW3c6kXlQrO1z+cdSUSmCdPm0SoVXDtDgkTtuI
         wZRrWydz3qxIo48n4W+skqzduslzlydabFe2mPWiygF6whLfsPXdpaLg5HeS+Y8kqE1c
         uhCFIb6KZPCoGYVjPpDyM9/9WP+usCJwa3HW8oNJKrwrhlmzhQqDHAvkTcEGxY+LqsPm
         KVSv+Hp50pTkHHTaE/XMUEzRbwIMzrcH9tcUKmBJxK+P9WKrsDht/3afeMx0ymynJFzf
         /66xhD9nZj7iEOLIirT8A0J2NkUQ6NziLAQ9xSjxpw4NGsGotRLW6o54x1vuIG0ad3O+
         BGtA==
X-Gm-Message-State: AOAM530PEqjIVQOPgQAdazPHDOhmXt4nfUK5fEx6ktxYB2sgtP1QVagd
        8wA0j9KTiio2x6uAxHwn9eU=
X-Google-Smtp-Source: ABdhPJzrlNuE74g1qMDB/HKjZQurMpmUHoKkU6SHJ/TfTL92dLi+ni/w2bYWkHpaV7Z7Rmf350AFqQ==
X-Received: by 2002:a2e:9193:: with SMTP id f19mr10913555ljg.41.1622308240394;
        Sat, 29 May 2021 10:10:40 -0700 (PDT)
Received: from localhost.localdomain (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.gmail.com with ESMTPSA id h12sm901715ljh.130.2021.05.29.10.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:10:40 -0700 (PDT)
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
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/7] thermal: thermal_of: Stop zone device before unregistering it
Date:   Sat, 29 May 2021 20:09:50 +0300
Message-Id: <20210529170955.32574-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529170955.32574-1-digetx@gmail.com>
References: <20210529170955.32574-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Zone device is enabled after thermal_zone_of_sensor_register() completion,
but it's not disabled before senors if unregistered, leaving temperature
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

