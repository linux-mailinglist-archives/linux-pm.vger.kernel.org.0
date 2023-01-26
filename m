Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925E867D9CB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 00:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjAZXl6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 18:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjAZXl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 18:41:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12D474DF
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 15:41:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q10so3474408wrm.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnAyme+18j6KOPf6iRNbRr3tHa520TeEGKv2pHUyxsg=;
        b=EVaGZ2eSnG+0XVwaIjbh+ZI03+/vFgVhoQhIG3OghMLgQ5R+zljPkZIZTclKyOWu/l
         f+GYYrKqS3qHX9MaWjVNZ0zEhtWAWq0fv4LqpdcpR4mSEnb8Ns36h+DVRh6gOVfOcxsP
         rMMeGeL/krHqLBVhNJ7QG0Cr8f7+K/6bh3hRzkHXjW0HCiLXpohwfSbYPVSrASdbTho/
         /WmsfmMnkx84ZELcOG2C0kxnY/bkqatTcX6efPE0z9kpIeM5xdQY8n0nV3Ptgt2kF+49
         hEP0vR8XEupELCm0FWZXNlftC+3k+76Y5KGkuOopclEZiGXqZnp2pa9WbcoVOfcIoCA6
         5iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnAyme+18j6KOPf6iRNbRr3tHa520TeEGKv2pHUyxsg=;
        b=wRAL0XGgXkpcA9UiWHJ0YIKt9fZMKoxE90/uNn5+aSGAWp8M3+GIAKqAeBL+XxNp/2
         O2ETqAbc/fbT7pM85FH1Y9C1SJOps5tUc5fKOyzDXxy1Kg/kOuY+4nnSqdrFw7J/KKAq
         IH5Dh6p8Ss22YC3CiWLP3w2crWdTR6Ofr76+nIz+IzDP5RcjdJnWfMJxAi4RBBSp3FO8
         PdIwCnT3y638VKZhy9jrHqqOB8qUkljUZh6j2AUyUm0coxyB8odjetDDSHzvu1OdcXjL
         Lj8b05abR/gPKbmokzONL/tvD0rUJ50EqwHfoGIw5Fvie3Gi4hz/imZdL/Dx01UEvLpT
         HmwQ==
X-Gm-Message-State: AFqh2kpSqywNH46bhPrc4NJ8WVvS9thZYaXSCJr/YrPm1pg6gpLcwH0J
        0SmxJF1YCQD2oINdnP7nTVaXkw==
X-Google-Smtp-Source: AMrXdXt7ZykcZm8+avHGdBvOtqm7wIEodJMiz/bX3gyWZfzVQr/vlnHzmmcdMAu5FAZDPJXoB1VG1A==
X-Received: by 2002:adf:e197:0:b0:2be:546f:50c2 with SMTP id az23-20020adfe197000000b002be546f50c2mr25865313wrb.12.1674776425507;
        Thu, 26 Jan 2023 15:40:25 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d5105000000b002bdfcd8c77csm2481182wrt.101.2023.01.26.15.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:40:24 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [RFC] PM: domains: Skip disabling unused domains if provider has sync_state
Date:   Fri, 27 Jan 2023 01:40:13 +0200
Message-Id: <20230126234013.3638425-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Currently, there are cases when a domain needs to remain enabled until
the consumer driver probes. Sometimes such consumer drivers may be built
as modules. Since the genpd_power_off_unused is called too early for
such consumer driver modules to get a chance to probe, the domain, since
it is unused, will get disabled. On the other hand, the best time for
an unused domain to be disabled is on the provider's sync_state
callback. So, if the provider has registered a sync_state callback,
assume the unused domains for that provider will be disabled on its
sync_state callback.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This approach has been applied for unused clocks as well.
With this patch merged in, all the providers that have sync_state
callback registered will leave the domains enabled unless the provider's
sync_state callback explicitly disables them. So those providers will
need to add the disabling part to their sync_state callback. On the
other hand, the platforms that have cases where domains need to remain
enabled (even if unused) until the consumer driver probes, will be able,
with this patch in, to run without the pd_ignore_unused kernel argument,
which seems to be the case for most Qualcomm platforms, at this moment.

 drivers/base/power/domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 84662d338188..8e72e8e38c77 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
 	mutex_lock(&gpd_list_lock);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
-		genpd_queue_power_off_work(genpd);
+		if (!dev_has_sync_state(genpd->provider->dev))
+			genpd_queue_power_off_work(genpd);
 
 	mutex_unlock(&gpd_list_lock);
 
-- 
2.34.1

