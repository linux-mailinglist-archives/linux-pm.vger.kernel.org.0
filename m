Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE057E7C4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jul 2022 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGVUAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jul 2022 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiGVUAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2022 16:00:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980B5007E
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 13:00:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so5808515wmi.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=RyYMkEWRyWyXOzZ5XLwkOoQNB6fRI6SQctP/iVvNIF0fmKVF2QL1gtVXaSZJXVhpGt
         3i1l0opPXyqvdYiC622Z98kL9Amqj4C1PxfApDPpsVbf96hfIYTiEiolf0CiPsyb3blk
         AC5iI96atSSJ5o6NJJTNyljknYTvI0G/EM9EzCCJNyLELZTB5gSTw65ElDVARIxTexag
         BhtCkoZrCJMCOnh9YhAhC79zkT8XaPkNOUB9+0N55l1yjZZ99bjRsene6RY6AH9s2e1W
         u4S9VaIB9/cP5zPBX0Fycys+GiSWK2kxByiL9cfvGH9BLhWdkHIlwct4k0mdBdPrJprY
         KRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=kbIyyV03awxvBG/CRZGBVmiMpOXVs/Y4mcsQQflmXsdZ3cU2wGvrvtjykkcddl5zCd
         aiPKPTbpyz2QuRjuAO8H55VhHcry61xXK8BaHXt+9k2B6PZRIiRcO4JfLz45TnGT0xNf
         6kpaXOPmKKVsBFPLfmVt9Xok0QH2aYGW3RPWu9UuIP4fF8r+U6cfX5fOBWSRXtMmHrpw
         JbJ6NBlcRfVYoYG9sLTMPJ/S7E4zU1ZJMf1j0v0vBX4pRhnX+uCjm95gWhkCUSMyJhs9
         0UGGaytv5rP8J6fkcMpZMakQBYHpAvKEmjcHfYjeaZQduoHQ7OV+5c15r2UP5ajko7w+
         ymkQ==
X-Gm-Message-State: AJIora9RHvtiLWKQJN2klDkNVmggY1yseuGqC0vTcvlnlRnonwIROTj7
        +qAY/QSQYglbeMztGDIe2uMPSQ==
X-Google-Smtp-Source: AGRyM1tnyJxzBpHxYYdJ40EdcBvRM9oa2Z2ZuGUYHijtJmgWZh17dZEvh+pAYXtjDo9lKFF5pTNpYQ==
X-Received: by 2002:a1c:cc15:0:b0:3a3:a03:588 with SMTP id h21-20020a1ccc15000000b003a30a030588mr895303wmb.29.1658520035087;
        Fri, 22 Jul 2022 13:00:35 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 05/10] thermal/core: Remove unneeded EXPORT_SYMBOLS
Date:   Fri, 22 Jul 2022 22:00:02 +0200
Message-Id: <20220722200007.1839356-6-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Different functions are exporting the symbols but are actually only
used by the thermal framework internals. Remove these EXPORT_SYMBOLS.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047e144f..f4c1e87ef040 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
@@ -228,7 +227,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	}
 	mutex_unlock(&cdev->lock);
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
-- 
2.25.1

