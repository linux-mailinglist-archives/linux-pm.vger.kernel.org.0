Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768B510035
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351539AbiDZOSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351551AbiDZOSs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 10:18:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B464715A1B
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 07:15:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n14so11473184lfu.13
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=ej4+Bx6xsGOH1fAYVCANQZk2dOz8IPnGV43ikFNr5907fDFzF+LC4hNSwjs0yUKphb
         LlQcAqu6SYB9cIITtCLUcl14KCtEhMawPgVduTYHzdTyrwCcgKnmedX1eQzkzjB37JHO
         zGCMPlgOhE55LQG7hJQHMcjjXWkik63SJIlvlZ6KMauZTOGgCVkgZ+yba7liNdFvAG1l
         i139SGagphUzRBobjJet6dT0uNxatiQJ096u8Pql+KL2VIFCp9abO9Y+Lwb22wbZfyhp
         EgtzT/D/fSyXw7+PFyCHJAWKS72toMh8bBDR7dlI2y+aoy7j2gcl8MPM8ADmiqwFN2iE
         vXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=iuOMgO9XlAnCXXoUBA6EaDQzG6C162YySfqrTMIXmuVZlkuK/3Mbot1ktmKmZviqvs
         09HcPgBcyCaEwiFWcxflzk8WyweREe/3RN9Y/Zweo0BeHvziDdYkB3QNzrX81gxaClg2
         lYiwvrPjmNyIaKy6Knh9XW+rz5T4TSpooVQTAtfktmoLywVjhaoIAsc3LnK7lN6y41y0
         KhLqHewX2/RsZMQ7QxWh7YZ4/+7DMIvxwkAJpkg/QiTiOh52ZKajv+QzI6DB8DRTiGIV
         igLsnCrgOEvWEBPiE8DCWOziEvrIVdF/qiiLz/pj/uWkG3l2IAPdcYNcWYGt9+jaYgrg
         LNZA==
X-Gm-Message-State: AOAM53227GrP6Ems/yopaUKD1Hd8/ryb+pAHU76DndNwo0fEdrGMwGjJ
        VWOA4IxFssF4CY2gTfT9nqlxVQ==
X-Google-Smtp-Source: ABdhPJzVJYvpLNFNnLneCLs3awIMzJab4hFZqee6Y1nyrzQD/yDf8uZ2syfAyE7PbC6lRc5j5FlZkA==
X-Received: by 2002:a19:4f53:0:b0:472:1714:61f1 with SMTP id a19-20020a194f53000000b00472171461f1mr2746170lfk.473.1650982533737;
        Tue, 26 Apr 2022 07:15:33 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id g23-20020a2ea4b7000000b0024f096abebdsm1043360ljm.78.2022.04.26.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:15:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PM: domain: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
Date:   Tue, 26 Apr 2022 16:15:07 +0200
Message-Id: <20220426141507.89868-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426141507.89868-1-ulf.hansson@linaro.org>
References: <20220426141507.89868-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Back in the days when genpd supported intermediate power states of its
devices, it made sense to check the PM_QOS_FLAG_NO_POWER_OFF in
genpd_power_off(). This because the attached devices were all being put
into low power state together when the PM domain was also being powered
off.

At this point, the flag PM_QOS_FLAG_NO_POWER_OFF is better checked by
drivers from their ->runtime_suspend() callbacks, like in the
usb_port_runtime_suspend(), for example. Or perhaps an even better option
is to set the QoS resume latency constraint for the device to zero, which
informs the runtime PM core to prevent the device from being runtime
suspended.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 262bda9b56ef..5059c5d2e64a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -648,12 +648,6 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	}
 
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
-		enum pm_qos_flags_status stat;
-
-		stat = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_NO_POWER_OFF);
-		if (stat > PM_QOS_FLAGS_NONE)
-			return -EBUSY;
-
 		/*
 		 * Do not allow PM domain to be powered off, when an IRQ safe
 		 * device is part of a non-IRQ safe domain.
-- 
2.25.1

