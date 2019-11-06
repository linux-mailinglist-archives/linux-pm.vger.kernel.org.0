Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2598FF16FF
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 14:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfKFN2t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 08:28:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39789 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731453AbfKFN2s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 08:28:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so15670225pfo.6
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 05:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M2QJIZx29Gwekb8NQRHw9lqWCpHwrUdysxQR0ZEdvxo=;
        b=YXE20HvW35Fp8pQXuwFOC39tRqHrhYYIB0Kk79+k+E6QK0j4qvWRYMcwIXgdk74Xj0
         vxAiAxqDLOc4idYj7jalm+2xF8RpeJzQflNYXKNeN0RZodAmcSkx4m9CXVQkc5dpCTqK
         y64ygp67E832PmLIBKmgWF61yy1LjpbasXdLfG0bj+Ac+C2SdTk1Qa/fMBaRsHUg9Rzd
         LVQE38dNolQKbYx+rZaEhWhyxvYSgrFiyS2KfZUu1U18mswP1e5iO8Yoh04EiDtESruo
         ZfgRnm2ij4RJNsK5kD1oftJDX76h502Lj8g9BGAVW05qiZSts4YKVDcUt4BYNRDM3bm+
         1siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M2QJIZx29Gwekb8NQRHw9lqWCpHwrUdysxQR0ZEdvxo=;
        b=bimvB2AsKzxKM1MA1nVinWHzESOwxVH6qo6rs2k1kqAEU0eQSuic53N5qJyz1t7l7M
         T8i9K0ptmZIFj6RqSoIntr+RN1WzmVxYKvZ22GEv3EK5qIh9u+i/GOPEcyz3iig2J6aX
         EDwv893qg8L3lWmKLqaZuePc4o+2uOmthAw9srLClv1LPx8qLMK6GDa3Ov4mn+rHYXTu
         InG7Qy1KgvCXRpg9eJI26ur/usco5KpWT3TTT6c82VaGrvcNf7qxymI8hDQOpmVLjoNz
         wStaNsgD9MjVwM7VsMZeWMn86x7j6kfvtBlHToEbL0Fp8G1T2Tl6qFJFGP+c6rXtty5N
         2wJw==
X-Gm-Message-State: APjAAAVZhHSQ11Sfepia5RMW0X8mr82946M0kTYFrLTsC/bDxnJ4jjy3
        74qLc8SsCbQ0Q0uBpUwea+CjZyC/OVtGUA==
X-Google-Smtp-Source: APXvYqx39ocvWK4EJjHayELfW7zIYDcufpwnEtY5mR0CiHvyOrP67iXURKLfvVVPd86QyNCrMOUkmQ==
X-Received: by 2002:aa7:9aea:: with SMTP id y10mr3292063pfp.16.1573046927655;
        Wed, 06 Nov 2019 05:28:47 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id w11sm18236846pgp.28.2019.11.06.05.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:47 -0800 (PST)
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
Subject: [PATCH 03/11] thermal: step_wise: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:19 +0530
Message-Id: <fe3fc4028189d45f8a20da48501e0ea09f2b5236.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
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
---
 drivers/thermal/fair_share.c    | 4 ++--
 drivers/thermal/gov_bang_bang.c | 4 ++--
 drivers/thermal/step_wise.c     | 4 ++--
 drivers/thermal/user_space.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index afd99f668c65d..aaa07180ab482 100644
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
index b831fc77cf64a..991a1c54296de 100644
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
index 6e051cbd824ff..2ae7198d3067c 100644
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
index 962873fd92425..293cffd9c8adb 100644
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
2.17.1

