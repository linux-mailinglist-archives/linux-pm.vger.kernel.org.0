Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B944852366B
	for <lists+linux-pm@lfdr.de>; Wed, 11 May 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbiEKO6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 May 2022 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245374AbiEKO5o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2022 10:57:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A021FD840
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 07:57:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p26so4006409lfh.10
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wm0nSY0tUggN6kcNzdaUXf+PYrABsccvOtQau2Ce9iQ=;
        b=WQtq5qfYkLwVtGKAcl9QF1e5Pr8UIw3GYZ58KZoTRibMv5wSoX0SUfJS+o3HfCsJPG
         tRK9mXg48ZI6JzeY0m2xpWbo6wBs/K/zoS49qwOnms03hOPGJd6OZzzCw2gMqWH5vqmY
         vRp+5a+S+CZh21KgW3Nw8LIauUwfaWNxkUlbe60XWltx7jandBZW4NAFt/W9v6brov39
         YJ5j/9/l9ce0EzqirfhoEG07KESvaBVSgWo/j3QlYv1ezdxEZOw5cdKqz79VMY58eIhL
         h/wTSbaZRPoDwsbDMTyhdFzKXWZ6SZImJo6b59RjOql2MMjyH/QvTLvm7WtmGOQVeLoh
         BuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wm0nSY0tUggN6kcNzdaUXf+PYrABsccvOtQau2Ce9iQ=;
        b=za5dHp3O+McqDJK1OC9wjnfArPrdyPSqY7lsXM3M9VqEXIAhXVYPzS0d3vapKyc8TX
         4YjL13dR/+ubYxPCnXwHFmfxqmZ9dvybG28/qE8Ag+fLOLp0vcc+zjZTHaIGAU4vKT6Q
         dzDkcanSJRo5uWSBdXAlPl/id/pnQX/3/tEhd1TPDq33vDlRiqVNwn2G6SGd8Splb02S
         GfYKq1vz/CBQ8SJJoUT9dSia9zQikHmpS5gwqa+uT1fFjElEyiHodfqz5srQQAhO51Iz
         XkJihJHkHcX2FjgcaisUS42wbbhm6cAYfp8sdng8h3AVFWVjUN5WNyY+yCF087moDVRN
         HlSw==
X-Gm-Message-State: AOAM533skDY3z2RVNeRiY8eCA6QG8zvEvEdllinN9US1FfdoNaxxltLZ
        AtUXlXwmwFO6mTyG9OuXsgdjfw==
X-Google-Smtp-Source: ABdhPJwdyvaKZNp8WowmGL6vZ5f9jKJU+XH0dBAIFAYhbjyLPuTOl6U9uoiXJcg0+r2v8LKzMOg75w==
X-Received: by 2002:a05:6512:1148:b0:448:39c8:89d with SMTP id m8-20020a056512114800b0044839c8089dmr20435225lfg.644.1652281061305;
        Wed, 11 May 2022 07:57:41 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] PM: domains: Measure power-on/off latencies in genpd based on a governor
Date:   Wed, 11 May 2022 16:57:03 +0200
Message-Id: <20220511145704.698189-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The measurements of the power-on|off latencies in genpd for a PM domain are
superfluous, unless the corresponding genpd has a governor assigned to it,
which would make use of the data.

Therefore, let's improve the behaviour in genpd by making the measurements
conditional, based upon if there's a governor assigned.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a7de5fb8f073..83b073cdd0ed 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -509,6 +509,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_on)
 		goto out;
 
+	timed = timed && genpd->gd;
 	if (!timed) {
 		ret = genpd->power_on(genpd);
 		if (ret)
@@ -527,8 +528,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 		goto out;
 
 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
-	if (genpd->gd)
-		genpd->gd->max_off_time_changed = true;
+	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "on", elapsed_ns);
 
@@ -559,6 +559,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_off)
 		goto out;
 
+	timed = timed && genpd->gd;
 	if (!timed) {
 		ret = genpd->power_off(genpd);
 		if (ret)
@@ -577,8 +578,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 		goto out;
 
 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
-	if (genpd->gd)
-		genpd->gd->max_off_time_changed = true;
+	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "off", elapsed_ns);
 
-- 
2.25.1

