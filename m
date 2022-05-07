Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0D51E72D
	for <lists+linux-pm@lfdr.de>; Sat,  7 May 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384897AbiEGM7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 May 2022 08:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385051AbiEGM7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 May 2022 08:59:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584E4B1C1
        for <linux-pm@vger.kernel.org>; Sat,  7 May 2022 05:55:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso5857035wml.5
        for <linux-pm@vger.kernel.org>; Sat, 07 May 2022 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9bQlM9gg7UBQwLA/AvFpX2Y6HQDQSBbVmYVoUf7zx8=;
        b=l64hwqcDceXvHHe2+llejtFh2jk8jX6S46HbYJ+N98So3DvC6m+iEEER5UGioOPsiB
         dKPOBdqogch8CLjrthyR72A89B+fsMoRcLilJlX5ZwijbvAcTkcxG7N8zrxrx8fH9XxN
         7rLwJlRcFePwppdBfnRI0QJmiRzJ2FO9TB95qe7oiAuII1JChkG5GHBrRFGhTMDt727q
         KcprLIdTQLAsZPRHtT9I0vMAFHVYTQdYtD1uRTa3YgUDoi7wdUcQOZOgX1wdaDWOUKlx
         JoLKqDabg5fH9ZxHXLnW+6GktjphB7foqvLRG9+++SuzXr3h4BvDhwguyH0YOwCl2+DI
         WKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9bQlM9gg7UBQwLA/AvFpX2Y6HQDQSBbVmYVoUf7zx8=;
        b=4JcqAeNgYUD8cWWrEXBtSIakW8HB27fDwiGIqiLjFLlePhDdeiyJ9aDmVuMJ7WIOSQ
         sQGw49KK2A5HRkZGf/V43aujkwr6ReULcbGcXPptfQ1hVGdJ/3vZ6urTbhb66HHmGY6x
         acwxPoSZvutOhk5ZHOACuyGIsfJD0eh+9gpBBEWeSJfiI4rI1ZAYhPTXcSPL4oyBlLJT
         F4ujz+vVhch+fSpUILHEDFkyeG8ZhV0f4W4YRc8OPlJJVhQVvA6PhBPOwzCsUkmItYtu
         14Cd1u9exgaK8uF2DTMtfEZb1kt8eE8kysru2WgiHid5ewisPr6NCpEfNXEUWPEdTr/X
         Jxdw==
X-Gm-Message-State: AOAM531ev7fjHS5xc5r7LOMSuNypZpdENdGW+DauoWbq5MDJSEACxjAr
        GE7ZL+GULif0KLerRPdkLOFq7g==
X-Google-Smtp-Source: ABdhPJxjwzxdFF9Unrndlh742n7Cnyqf12EENRFzGjxx9FUR2JNdz4S/dtZAIKYUf1E0IlOJvRWtVg==
X-Received: by 2002:a05:600c:1552:b0:394:52a9:e48a with SMTP id f18-20020a05600c155200b0039452a9e48amr14473567wmg.45.1651928112897;
        Sat, 07 May 2022 05:55:12 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 07/14] thermal/core: Remove unneeded EXPORT_SYMBOLS
Date:   Sat,  7 May 2022 14:54:35 +0200
Message-Id: <20220507125443.2766939-8-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
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
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 334478fe40fa..beb97cd6b799 100644
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

