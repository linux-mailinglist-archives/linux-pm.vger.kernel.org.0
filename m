Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496DA56CBC6
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 00:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiGIWc7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Jul 2022 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiGIWc6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jul 2022 18:32:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6087018373
        for <linux-pm@vger.kernel.org>; Sat,  9 Jul 2022 15:32:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q9so2591778wrd.8
        for <linux-pm@vger.kernel.org>; Sat, 09 Jul 2022 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=HcpqwxZikqXjR6TUiqlV1zMK15j5+AFK+kPI4Gqfyv0tYjrStuATm49z6VAu3+2MbS
         nYutoLrPGid9YTw2Y2jUMIVVJu8GIHnr/jznmABXgCm8no6tsisjTtt0MP0kMn3cQLNZ
         BGxKyyY56PLT+BXVI9DXtORAvVGKtEXDciHkS2mO74wcSaGLWoAjRbyNWdiJuXGioq8t
         sgeqedA8r8qYVUpbEIPP4VZh4zIoWNuXmhE9mnA2LpbBV1rINxuuFJi/KVnaYh8+p4Ub
         WlH6wjmtkDjQVeEX2FqsNidPE4w6hCZ+B7Er46SjW3u3Jn8EyVUeLp8cq0pBot/fSG4X
         SIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=bcBmATxSsNTF+m8xIqG3WAvOjcKPtfuyc7fHOZRgdMeQrOCy7ee5DqfUl6j4F+bWAZ
         NOQWkGI4ebqX9TqcI23h+7FHsbg0L3HxSlrHycMrVclvNRi9s7qU2OKF0mMhYatBh1Lc
         BP/TVKumSbw7FpKxVq704K5CzzJM6Vvhip9V14TPP00bXRneT18hwkDKCIovMQ/t0dVs
         amcEidZANGVE8dydKhfSAaBnR2wrN6n5qophJRokaZQuMeyFpsniZoqFJ0LunjVjPT4e
         cHK3eIDA3QAN7kO+DQmywG8WI/LpWP/Y7Osz5fMD4FN4yk+/ci35Mh826Q9laqwQJNup
         sqgg==
X-Gm-Message-State: AJIora/DUo6R2uxqkMHmhLs5HWOi1AWflV7NOn6fnRek7+xK0Iufafil
        25Q9lYTmom7wrJIdPfNOBAF9xA==
X-Google-Smtp-Source: AGRyM1tsSkzuJFzYQD6I3kxw5bTYNEUrOqI++35wwohmRJ5/QIG/KARbvz8Hn7LzBGTwm8Ix5hS/+Q==
X-Received: by 2002:a5d:440e:0:b0:21d:85ce:6b8e with SMTP id z14-20020a5d440e000000b0021d85ce6b8emr9918504wrq.248.1657405966976;
        Sat, 09 Jul 2022 15:32:46 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
Date:   Sun, 10 Jul 2022 00:32:22 +0200
Message-Id: <20220709223229.1619339-6-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

