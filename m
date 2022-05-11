Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B352365A
	for <lists+linux-pm@lfdr.de>; Wed, 11 May 2022 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245306AbiEKO5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 May 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiEKO5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2022 10:57:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DFC68F99
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 07:57:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b32so2979603ljf.1
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=V/31BKjOnBuESidovgo43nJAiR5JKlgrJQNGaqAU7dLJYVdepjBNzq/lWLJ3slYo26
         U4eIVgIrMQdYdFTd8FdkEY5FpiBtaZHls/kyWiY4fDVb0JxB7NO7CQFVZ3rPJ8NhoknG
         6G2aHdMCUOccjL6eDyV6ug/xMELBa7zfwKIBY5Wd43/rILca53Mgbr+rswKI1vrZZoJ8
         ZhICBFSbfyTRBMUbPxQPbyXM1xULVhx0BLriddMn2PKiS314ftTcApyCJO/ifMVpT+pK
         dT9d4+Y2h6DSBMQocdEQwMsVeWYsiPgXsENadyV/vcD9SUISHpTHg+EY80rl+Yerf+n3
         RH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=cnMMv7b4HQeMII9yWiwPfakVvjY+3lanHqV4BVvlYYFyOWnSuCkoYffGqzZm62Ma1M
         wg6SmmtDFn/gH2AbiEOTvi8czmLlzfEwj9fqhEQX7cIP2SolWjsdsMv54yQ7BOg/++qL
         /PlYNCzY0mSRA2tfZXBW4zpvSD/nF056pxlSB2Lo7sXvuSbvJpoh10s+gd98u4gMUd9N
         jlU+eq73mlV0id4zra6jA5sqwOmtZk+1BFJafPeRxqkXCZJxqIOmJfaTpHoMLlm9n1lo
         t/xfaZ/4aDiZA7s9X1NSRVUiFAsJ0JlvVG9bs3KyvUc0+w9KdP9c2MYA66mcJGZYi/xv
         0OJA==
X-Gm-Message-State: AOAM530oL1GqfB/OS0i3zQ1eBjIsMLLLDHK8+DkfCizfAFbxC6IDsMUc
        HcaBguzyGhBH7lHpGvBX8qpnMg==
X-Google-Smtp-Source: ABdhPJz1+tPV+8eDT+kPK5sJaKCDGNqX6EPItVfc9C6kKk4dAZILCFEIkrqbrtFC5Dyum/eekyW7+w==
X-Received: by 2002:a2e:a30a:0:b0:24f:8e8:76a1 with SMTP id l10-20020a2ea30a000000b0024f08e876a1mr16880346lje.14.1652281043856;
        Wed, 11 May 2022 07:57:23 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:22 -0700 (PDT)
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
Subject: [PATCH 03/14] PM: domains: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
Date:   Wed, 11 May 2022 16:56:53 +0200
Message-Id: <20220511145704.698189-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

