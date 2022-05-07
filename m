Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9803D51E72C
	for <lists+linux-pm@lfdr.de>; Sat,  7 May 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446408AbiEGM7g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 May 2022 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391978AbiEGM7Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 May 2022 08:59:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA72B8A
        for <linux-pm@vger.kernel.org>; Sat,  7 May 2022 05:55:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e24so13429917wrc.9
        for <linux-pm@vger.kernel.org>; Sat, 07 May 2022 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/3SG51L76j371xoLprO5E0bcUDIZoNhzkCxIpDaKlc=;
        b=d1aPND7vtBHTKlopYpAirXVaCBjuyPnzkKChgWratJAiSKtLNw02EMp02G16Jx5rE/
         dBJcTfcHnlobFrBABVBNmF+qawvwJBFPPu1RGtGFIUCOX67fOeI1YqeOix/pVFJAoD7A
         YhFRJAIIIZ999lJ7a1G0NkjY6IHf23gBLR+JVLSj4/HUj/GWKlnJFzqh8yUniY3cOCgS
         rnH9+1zcLI6n8kMgIqpFssGmjVoKKQp6oc2fvIb4Js6yj91k1rzLt+vJUTL2a3Mx1twf
         8otoX6QsSiE+YgWuDRjVXn6wCMd4+X7S+hSwkhYLBIQcJDpKO3Bnkt5Y5+5FS2ec4+sA
         B6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/3SG51L76j371xoLprO5E0bcUDIZoNhzkCxIpDaKlc=;
        b=eEMIuEtL0cqJy6VuyLW3l8DBT9bBxxnCvLyI0Xk+ER1l/ulQkYg3kz8ntRNiNbSg2A
         nVA7PLzyVfy+CxowKX6MEG8sToqXnwBTpxr7W4RLBz05Rcp6CYwDbcuAmTbKKSyAFwjs
         asIDA1X/hkDb+T+xcYqHBVd1D0rQihsIVTO+ScYB8XYFifE7zPBeefj9Qzb4qlA7asHD
         qTkL6mFqCZhBL0OwCsDX5ZXgTDkWYhvbmnmeg6XWQoKupY10+jIZArED8T37eIZ+KU87
         vsM4xeC5vjAnfH4l97/7s2zUND7ZBelJPnsdQ8VCMf5oFgV3eqp8Wt6iAOZSQeZlOoX1
         gQZg==
X-Gm-Message-State: AOAM533XQPAcn9R6dDGKYaArleDWVGINq9iABT67nkk5m/wlcniHVDZ2
        Hqkuw31oAMSIz/gQjhW078xYUA==
X-Google-Smtp-Source: ABdhPJwg8CZ2XSeNZvkp6RLmvlUklOcTecMNk4pL2FHy6Iln0Hhp1MeArTV7/q2+oWYYalZl1gx7nQ==
X-Received: by 2002:adf:cc82:0:b0:20a:cf3b:4624 with SMTP id p2-20020adfcc82000000b0020acf3b4624mr6532297wrj.573.1651928120674;
        Sat, 07 May 2022 05:55:20 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 12/14] thermal/of: Store the trips in the thermal zone
Date:   Sat,  7 May 2022 14:54:40 +0200
Message-Id: <20220507125443.2766939-13-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the thermal zone contains the trip point, we can store them
directly in the when registering the thermal zone. That will allow
another step forward to remove the duplicate thermal zone structure we
find in the thermal_of code.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index a8a3cb309822..200d1d784211 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1105,11 +1105,9 @@ int __init of_parse_thermal_zones(void)
 		tzp->slope = tz->slope;
 		tzp->offset = tz->offset;
 
-		zone = thermal_zone_device_register(child->name, tz->ntrips,
-						    mask, tz,
-						    ops, tzp,
-						    tz->passive_delay,
-						    tz->polling_delay);
+		zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
+							       mask, tz, ops, tzp, tz->passive_delay,
+							       tz->polling_delay);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
-- 
2.25.1

