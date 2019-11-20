Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E0103FC9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfKTPpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:45:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33473 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbfKTPpl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:45:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id o14so26739pjr.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bpr+XgLcp0GJ6wIDnaLswXE+7+Imau06ErXv0DJpW/A=;
        b=HprR3YeZNVzUJusAYWgK/uwgFmScXge99pfc8msCYNQ72Nf4zHGsDis5kchJKKyRJ0
         CWKzDLrLfqmS+xtX9sE4rgAR7/d5Znx/HnYAzunhijrbr8cO0hY2ej/Abiy1ibWALYhZ
         4kzEE5XgtlcJFzIOfPVLagE/MN57OAaooQNrlUwiNEdbf12hmfUHtf6tA2cr8ApzjDXE
         1p09hF8ndjfVOtD0XBxAt1ccoygg8SB4qvt3Upb/W2s+hCVUfNXnJFxt186HIA0Cil7U
         5JuMBwXvMuNGWN2lmrjUO9WsiWbGtUfIQ+8X5AuD7eIQx+jKbObMxGP3gPYsxBsBOqfO
         nlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bpr+XgLcp0GJ6wIDnaLswXE+7+Imau06ErXv0DJpW/A=;
        b=YzPWW4fg+m3pMCR1212bNT5/1E+QdIRz+TH6uYz3B2MOvdhhb1PgcJXW3N2HUCtM9c
         LdY4my2BYsIELk4CWIzuGuclFSk5L4BnV21tTEhs4sTFIZVJsWpoWWfXtfLnN2+exdQM
         2XRp4V9n2ZW4xiviz8NhckavJcNa3oMkHb+XRJAwZrruBzmlQ8Qfs0cHVlBFY0f7A3sK
         TLUKOgNMJccJsPShYvc9GLb4VzNu5XKygraCmQ/1BGOidKiu7YxFLe/GTjDhjvIARaWe
         alOdaJwMyOgB2a0gCRBDfKycXI8d5pD4LEZ3KxQv84U6omVfTYMC/5KlHTRceNyOnH5U
         1M7Q==
X-Gm-Message-State: APjAAAUu6XglIcQo8cdNgaK4+5pBjhvLP2y1LLbfOXmXaskvHQ80Goeq
        6R2QIvJDb3KGDjQNwwMxmDGPcg==
X-Google-Smtp-Source: APXvYqwoEPmMYiC5RZe26XEvZqQ4Z4Nw9yF/I0EtDQW4twuoRbQQVPeSpxc4pSrm4S5vV6pYT9JKXg==
X-Received: by 2002:a17:90b:3007:: with SMTP id hg7mr5111000pjb.73.1574264739276;
        Wed, 20 Nov 2019 07:45:39 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id f59sm7044014pje.0.2019.11.20.07.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:38 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 03/11] thermal: step_wise: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:12 +0530
Message-Id: <5d48ac6f85667a53902092ad5bbfef8cc89a7162.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace - with : to appease the kernel-doc gods and fix warnings such as
the following when compiled with make W=1:

linux-amit.git/drivers/thermal/step_wise.c:187: warning: Function
parameter or member 'tz' not described in 'step_wise_throttle'
linux-amit.git/drivers/thermal/step_wise.c:187: warning: Function
parameter or member 'trip' not described in 'step_wise_throttle'

linux.git/drivers/thermal/fair_share.c:79: warning: Function parameter
or member 'tz' not described in 'fair_share_throttle'
linux.git/drivers/thermal/fair_share.c:79: warning: Function parameter
or member 'trip' not described in 'fair_share_throttle'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/fair_share.c    | 4 ++--
 drivers/thermal/gov_bang_bang.c | 4 ++--
 drivers/thermal/step_wise.c     | 4 ++--
 drivers/thermal/user_space.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index afd99f668c65..aaa07180ab48 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -58,8 +58,8 @@ static long get_target_state(struct thermal_zone_device *tz,
 
 /**
  * fair_share_throttle - throttles devices associated with the given zone
- * @tz - thermal_zone_device
- * @trip - trip point index
+ * @tz: thermal_zone_device
+ * @trip: trip point index
  *
  * Throttling Logic: This uses three parameters to calculate the new
  * throttle state of the cooling devices associated with the given zone.
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index b831fc77cf64..991a1c54296d 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -71,8 +71,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 /**
  * bang_bang_control - controls devices associated with the given zone
- * @tz - thermal_zone_device
- * @trip - the trip point
+ * @tz: thermal_zone_device
+ * @trip: the trip point
  *
  * Regulation Logic: a two point regulation, deliver cooling state depending
  * on the previous state shown in this diagram:
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 6e051cbd824f..2ae7198d3067 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -174,8 +174,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 /**
  * step_wise_throttle - throttles devices associated with the given zone
- * @tz - thermal_zone_device
- * @trip - trip point index
+ * @tz: thermal_zone_device
+ * @trip: trip point index
  *
  * Throttling Logic: This uses the trend of the thermal zone to throttle.
  * If the thermal zone is 'heating up' this throttles all the cooling
diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 962873fd9242..293cffd9c8ad 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -17,8 +17,8 @@
 
 /**
  * notify_user_space - Notifies user space about thermal events
- * @tz - thermal_zone_device
- * @trip - trip point index
+ * @tz: thermal_zone_device
+ * @trip: trip point index
  *
  * This function notifies the user space through UEvents.
  */
-- 
2.20.1

