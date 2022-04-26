Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A25510031
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351529AbiDZOSg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 10:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351526AbiDZOSe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 10:18:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC112769
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 07:15:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g19so32214368lfv.2
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5o32wUvvQH//2mVRnrNn2QEStbroChjE5Xk/XzAuRBk=;
        b=ZS+FRmGXxGxWy+Sr0qmhaRwRYeghMgckGEwpLe57mjpM/s7TW3ohc4Mcat9ZFwf6jh
         HbHzKOSNz2NJDBeVwwMgcitMnahz1LqMhGC+7jO78Edqz5IKSKFcO3pd60CyC747oNVB
         iEFbAfWik+yhAKMHjP1h55bT97a53CxnUJSXEaDVlppg2l0ocHDEmamIQ3FagetDHvOI
         OiGCe3HnIBSdu0xvbHgUqS1+0H9Vbbf3iPJDDvVFxS32aIbFk5VtiZiDb6h/z95xRfk3
         3BSqZHaeXWlCUdJiz9jBsMTjxeJN22axVv6/M4EEuZ7raz+IclxnjJ9ZA0+2P6b2Ziim
         mGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5o32wUvvQH//2mVRnrNn2QEStbroChjE5Xk/XzAuRBk=;
        b=5DewpmrXZl3FbfbrCHuOsp9pP1/ro1bCie2YB85j/FGhCQH+ShiPWYOiRp/DNigSLb
         9s5squiKafIDc+cjAUruedAgnFYh+D/+sKP+ZC7q9jW+rXasbS98a7da7owghCQCofea
         mz1b+LEK9g6+k9n525yNr0d4Tve5MJrHSH612GmQaPb/RTSPhHl8qx8/WU7U/r6OjIs2
         Se6IeXxpWm25A9islBhS9bb54Edd1L39krwHtfaMhIJ8ongEx7pE0YB7djka/WLbWXU+
         P7mAK2fTWwSOTrsLv2g4h+FFn+pe9hbfPFp8zNVQq00d/DsYKqvJ3VT/l7PJ/mfzrugb
         hXnw==
X-Gm-Message-State: AOAM5319L8+GNUemf2KPVbWOLsKunkRWK+d1wYpBF0RsmDRXGZh4qCt5
        zk+opuEcLW+1AKnhsZkZzokT7w==
X-Google-Smtp-Source: ABdhPJxI1wm79Ps82LwseJjrRMrpea/rINXfvkndAZAVAPzCBHLRmNGZgLrDZEbnnIZcFl3Yso6hVg==
X-Received: by 2002:a05:6512:3f01:b0:46b:a5ba:3b89 with SMTP id y1-20020a0565123f0100b0046ba5ba3b89mr17067969lfa.28.1650982520769;
        Tue, 26 Apr 2022 07:15:20 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id g23-20020a2ea4b7000000b0024f096abebdsm1043360ljm.78.2022.04.26.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:15:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
Date:   Tue, 26 Apr 2022 16:15:05 +0200
Message-Id: <20220426141507.89868-2-ulf.hansson@linaro.org>
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

Rather than relying on the genpd provider to set the corresponding flag,
GENPD_FLAG_RPM_ALWAYS_ON, when the always-on governor is being used, let's
add it in pm_genpd_init(). In this way, it starts to benefits all genpd
providers immediately.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 18cd7965e5d6..262bda9b56ef 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2016,6 +2016,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	/* The always-on governor works better with the corresponding flag. */
+	if (gov == &pm_domain_always_on_gov)
+		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+
 	/* Always-on domains must be powered on at initialization. */
 	if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
 			!genpd_status_on(genpd))
-- 
2.25.1

