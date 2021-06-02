Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B529F398606
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFBKOS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhFBKOR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 06:14:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE784C061574
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 03:12:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a4so1899432ljd.5
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWJY2CFLHTV9te/K12aeGYAdOeh00bsaQx3awehhTns=;
        b=otscoI9pFx2lrv6RxW/6Gl7A/sdHQxh3kPnxbLMMZGHhdC2it/DuwnF4MCeokvSaZz
         zIupfLbKOtmT4BEQ7K1IjqQUkWgfOxanvdw+SEb67ZyGIsDjCVeP6JO11fRGmgALYH+/
         K3pUMG01BEnsLg4OIyMOhLm369wsjxTzXQHmKPysQtLXG9MxfFQT1KGe+16d+jwZA/nD
         yB/uyW5CVoiTLxd4gL7vCOqMjRGtL3D/JlGQ2rTwkfefgVRxjXwmw05VdJebQ2oSu38X
         Xp4JkQfw4cL0kiQgbCnUMTxPfuZ0M69DwW+Oe93PVRRDGY8LhNT9YGBKl9Tc9I6yrw41
         Wd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWJY2CFLHTV9te/K12aeGYAdOeh00bsaQx3awehhTns=;
        b=muMFtU+ILGpfijEXIOkfChQPkte4v5PuA+IJV44hZFI+tXowenBjYrj24opqbX5ODD
         4DIywN8NF8dLWPSxqLB1h60+oDqxM0MPgHRnbyO5U82Veii9lJef0ZdVTI7mLJtwdnnW
         qushTlnWgCwbxjzrA2Tt7BSQ+X2pNZ4nLn1Uz4WYb5S5kVQZXPTLwMPorC/yYrVgY2Y2
         AQxzjmQAH+pCkHO1vknn2ayLPQIvTmhImcuU7MuE2lgOxkqEJGMHURLI9QCOi35pef+W
         Ma1sLoEu36wzMHFXbU5FW0ZhARGy0DxQ8QkClJIv5FoBgvvZxE5/pRcgdUfUzXMX1mwk
         2PLw==
X-Gm-Message-State: AOAM532uCaoy6QQWUur8omj8RTx3LWeTA6VKRPlynPsEU2wx+r3X419C
        na2sLSz3JwJT+EPMheiNZNeQ4Q==
X-Google-Smtp-Source: ABdhPJxYUSku4L7fSC+jpg2qG/mq4pKtA+sillsPDclxRNexC8+2QLmeOD45HAP9L6+27YKLwbnZUA==
X-Received: by 2002:a2e:9083:: with SMTP id l3mr24610514ljg.315.1622628751113;
        Wed, 02 Jun 2021 03:12:31 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y35sm1948938lfa.122.2021.06.02.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:12:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PM: domains: Split code in dev_pm_genpd_set_performance_state()
Date:   Wed,  2 Jun 2021 12:12:13 +0200
Message-Id: <20210602101215.78094-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602101215.78094-1-ulf.hansson@linaro.org>
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To prepare some of the code in dev_pm_genpd_set_performance_state() to be
re-used from subsequent changes, let's split it up into two functions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b6a782c31613..a3b6e751f366 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -379,6 +379,24 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	return ret;
 }
 
+static int genpd_set_performance_state(struct device *dev, unsigned int state)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	unsigned int prev_state;
+	int ret;
+
+	prev_state = gpd_data->performance_state;
+	gpd_data->performance_state = state;
+
+	state = _genpd_reeval_performance_state(genpd, state);
+	ret = _genpd_set_performance_state(genpd, state, 0);
+	if (ret)
+		gpd_data->performance_state = prev_state;
+
+	return ret;
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -397,8 +415,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 {
 	struct generic_pm_domain *genpd;
-	struct generic_pm_domain_data *gpd_data;
-	unsigned int prev;
 	int ret;
 
 	genpd = dev_to_genpd_safe(dev);
@@ -410,16 +426,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 		return -EINVAL;
 
 	genpd_lock(genpd);
-
-	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	prev = gpd_data->performance_state;
-	gpd_data->performance_state = state;
-
-	state = _genpd_reeval_performance_state(genpd, state);
-	ret = _genpd_set_performance_state(genpd, state, 0);
-	if (ret)
-		gpd_data->performance_state = prev;
-
+	ret = genpd_set_performance_state(dev, state);
 	genpd_unlock(genpd);
 
 	return ret;
-- 
2.25.1

