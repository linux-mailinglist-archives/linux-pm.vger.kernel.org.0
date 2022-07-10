Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8456CF25
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 14:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiGJMgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGJMf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 08:35:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F287913F0A
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so1295750wmj.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icoUiwKgc5ZfQQb9kyqtM6xsdul/av8PcZiURdbMJFs=;
        b=vkJN2lqSLPWI+/BzP3FTUMAWQRWtBP8xmHL3ekSHL5rJH0Ptvb9mdaQLLWO8JOWHSS
         kjEd5BEORRxLXF908meXd+XqhmnZfRVJAO1/FqhWSMhANXxpNAsldabulQmFmkEEA+o5
         t4tpeAHg4R/FtM/QEFw/2Om2c0s5au2jD1TGufvbMyEJbQ9I+hZK2Gchmm7XO/5fLuqI
         Bdguu6GimTFv1+2L+AUtIsu5zHTCJnzCIex4Z0z4yXa7uqsxl78ctfrq0n6Vyti1Ps5K
         4YObqy2kT9BQcoxU0YeB3CmQj5Pjd7odxPYxuMw0nwZ4VFaIpoJ6FvbFSk+bL4IXjOOe
         sOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icoUiwKgc5ZfQQb9kyqtM6xsdul/av8PcZiURdbMJFs=;
        b=s96A1qAm+TnOGtUG1GCFhjwbnsVrqrhg6F5b0a9/UEVMdsN6LfcKsr6gHYauGCrTdy
         ID1ZaDRI0lN9/svgj3VL3xhsK/ihNQP8NxdCQIRisLbbLnCMJA/IexSLMlBZJAqbdqcc
         bmvUrCoZiRxQBq98ZPnE1zrr5hp3Ej1YSpas/PwuJpfp+ZWQ0gEemS7kFSyQO/z2Sq7d
         Z28ckQ7wJ8DdLVltY1Xm1M3MguSk16pekcGJtzl5mvVYQVx6mtZpnKz6iYr/KBzkxut1
         W1kQpb3QyDNrusWCFTP7LHx0vfM2aAEbNF2j9LKKjlbpYbh+P9nANiDwUlO0WRU2YKXN
         Ol9A==
X-Gm-Message-State: AJIora8mzsY4tsk04XYj+ks/Pq03Z1H8QMRSZTV84QiJFpD1d47E1yZ6
        1xAew3TxctSurr8QlsZ7MN2d2g==
X-Google-Smtp-Source: AGRyM1vscx2qlLVeh0vOTuSaNxBbf1hHDyONcEKP7d1JduHpRBsmUTYb7SigAchElqILmC+8nPWvWw==
X-Received: by 2002:a05:600c:22c9:b0:3a2:d069:a046 with SMTP id 9-20020a05600c22c900b003a2d069a046mr10690759wmg.29.1657456535250;
        Sun, 10 Jul 2022 05:35:35 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 10/12] thermal/of: Store the trips in the thermal zone
Date:   Sun, 10 Jul 2022 14:35:10 +0200
Message-Id: <20220710123512.1714714-12-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
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

As the thermal zone contains the trip point, we can store them
directly when registering the thermal zone. That will allow another
step forward to remove the duplicate thermal zone structure we find in
the thermal_of code.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 19243c57b3f4..e187461dd396 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1119,11 +1119,9 @@ int __init of_parse_thermal_zones(void)
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

