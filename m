Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE446BB47C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 14:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCONXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 09:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjCONXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 09:23:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6472690
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 06:23:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x13so28145842edd.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQtrWDCM+22cQpzRRbVDJZjtR/eFtKTL53q6CUnjVrA=;
        b=kcCmlMd948KTeFaT82iddBgwWZPmI85qhyHyJAJKzspk0SsOyGqNByNvBE+bAMsClo
         fiFyE57RAgHFWGTtx0x6MMBEZbVVWGTbmc5kIMsBNu60iCBvcRghGHAaJ7BFtc87EdA4
         gQIsAiC51MpVQSrv61X7jG93H+kGWQ3fc9BenKW5Kzi2S870BrFMviIX0b1INPVah++M
         3WTlJCeJcP5wH/B62iolL3NhCGoDdPmtecKFbZ5qkFujaQJxgLzaNpCR+mLxefhwaoy0
         m8E24qya4KdhgUG3MeW999hZMIAzUmzBGnlWzix4N893xlvhnGBj61IcTG8H96l9XN+v
         C7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQtrWDCM+22cQpzRRbVDJZjtR/eFtKTL53q6CUnjVrA=;
        b=beXloMlhHTt0kCLeffyzFJC/3nM9Ulnx2Y7edzm8ddsv9orb8cbPtZ1N9xa7eB/N9U
         LnYF1jCEFOp+vPinMm5mhG0aRXDXUMnUzgxldrjSELX1A9ghiOSIWWlkDb/WDhLseVAD
         3xdy6dS5Tvqst3SJl1JarFS7Eikye3TTsi2pgh+4+DR4kyNWbLvad9ylYI4TAzZxSTJ3
         mZq61gCozF06MuFY8hh4gslHjvZltuPzYsfp35GOcL3MMiJz8RNXyAUHYJoyJGnbIkgk
         bD0PDNmPPQXOdxZOsOTVDrnpxhkLgqo8+ZhUyUxpvK+6J3zD7VKidXU+RC5A/r1Fb8+n
         tKGQ==
X-Gm-Message-State: AO0yUKV95S4mvH6TA7zxkQiw/HbqFd75UyDSofSAAcWwDPomqxKG6IdD
        9K7B2Qt3jiS7mVJpARUZs4j+qw==
X-Google-Smtp-Source: AK7set+aEpLN7DIU+ICSDUHqoC29NPehGqibZ+dEU/3SKCMWs0P9gQyG0fxkTGoZVcpIiVf9y8OyVQ==
X-Received: by 2002:a17:907:9708:b0:878:711d:9310 with SMTP id jg8-20020a170907970800b00878711d9310mr7626418ejc.1.1678886617534;
        Wed, 15 Mar 2023 06:23:37 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b008b133f9b33dsm2497365ejb.169.2023.03.15.06.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:23:36 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [RFC PATCH 2/5] soc: qcom: rpmhpd: Do proper power off when state synced
Date:   Wed, 15 Mar 2023 15:23:27 +0200
Message-Id: <20230315132330.450877-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315132330.450877-1-abel.vesa@linaro.org>
References: <20230315132330.450877-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of aggregating different corner values on sync state callback,
call the genpd API for queuing up the power off. This will also mark the
domain as powered off in the debugfs genpd summary. Also, until sync
state has been reached, return busy on power off request, in order to
allow genpd core to know that the actual domain hasn't been powered of
from the "disable unused" late initcall.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index f20e2a49a669..abd999c74783 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -649,8 +649,12 @@ static int rpmhpd_power_off(struct generic_pm_domain *domain)
 	mutex_lock(&rpmhpd_lock);
 
 	ret = rpmhpd_aggregate_corner(pd, 0);
-	if (!ret)
-		pd->enabled = false;
+	if (!ret) {
+		if (!pd->state_synced)
+			ret = -EBUSY;
+		else
+			pd->enabled = false;
+	}
 
 	mutex_unlock(&rpmhpd_lock);
 
@@ -810,10 +814,8 @@ static void rpmhpd_sync_state(struct device *dev)
 {
 	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
 	struct rpmhpd **rpmhpds = desc->rpmhpds;
-	unsigned int corner;
 	struct rpmhpd *pd;
 	unsigned int i;
-	int ret;
 
 	mutex_lock(&rpmhpd_lock);
 	for (i = 0; i < desc->num_pds; i++) {
@@ -822,14 +824,7 @@ static void rpmhpd_sync_state(struct device *dev)
 			continue;
 
 		pd->state_synced = true;
-		if (pd->enabled)
-			corner = max(pd->corner, pd->enable_corner);
-		else
-			corner = 0;
-
-		ret = rpmhpd_aggregate_corner(pd, corner);
-		if (ret)
-			dev_err(dev, "failed to sync %s\n", pd->res_name);
+		genpd_queue_power_off_work(&pd->pd);
 	}
 	mutex_unlock(&rpmhpd_lock);
 }
-- 
2.34.1

