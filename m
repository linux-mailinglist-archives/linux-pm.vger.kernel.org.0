Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95F562DCE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiGAIWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiGAIVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:21:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5607127D
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:21:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so5728821pjs.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JX/iuVBCiH5yj/WHuJ1/f+3WaqUl5eDHzSMUfsG02Q=;
        b=oXr6tPXGRlwJyo7ncqnJ8UPZRb3uawOmoReKvVpwTiZjWFBXYflSM7jEaKzg8PZYPE
         dD/4ilotL0U7US5/tlJkTQmmuzQKM0G/yZFuhApDntNmMoKE/AVOST/FGLSgcrwIg6Ta
         P9DRyk09nOuLX3FhQ8BKO6hZrP1HDaUoTf5E8YxYOPBfNl3O4QiTqdMDTC5QvmAm0XgL
         LfzMOWe1uBs53DHy7YUSfj97XsELS/VwZMIKr+LaxQ8Pdshf9gt3DvKbl6oGyX02DQDc
         8nOMM223R5lXDqAY0SJ1Hsu5QI3pT7pzqUqAZzWIrhfwUqai0bSpy66fdZnMiMEpi7Jq
         pE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JX/iuVBCiH5yj/WHuJ1/f+3WaqUl5eDHzSMUfsG02Q=;
        b=kDfPp0tAFDklhsO3JdgrIVU6JHFyw+xDoVj5LQONM8NLx5qYeRIESQfS2RTKY1OHnN
         qCgQ+Ypy84PAueux91eJAOZ43JdJCKoXStHXVwDTHsJ9Us5+qFHl5eiJY3Gwd0+a9co2
         CBBq6TX+oAHIlN1j/VvROWJhf5TUm5b/BMCdAikoGVd2lgChzXYgB3KKo0lKrPapyLrg
         ecu0c5sJwcMkQ6tSRoL2/Pg+I/ZP6uBgWRnofxS6UE+1R9x9EOvsEofVTzTGC3r7hlNV
         Hl6C76xpav10RmBXPMcKh3xr7Q7b86WOGqUG+yC0s6CwxsRoUzG9O7dloX0brzSVuRr9
         BrHg==
X-Gm-Message-State: AJIora91dUIE0HVO5fHEevWtp6A3Nrjh/Cjn+Ni+I52kJLlLVfIZ3XrS
        rAYtNNGvL6upODXf2PjpMCxrUw==
X-Google-Smtp-Source: AGRyM1v9z853kLDeBAeq79Scb9HDzro3Uyn0gVbpfMw6suMfjPhB2mkfyUWMkJIrsml3S0jT+kWzwA==
X-Received: by 2002:a17:903:40cd:b0:16a:2dcf:408f with SMTP id t13-20020a17090340cd00b0016a2dcf408fmr18611553pld.18.1656663680823;
        Fri, 01 Jul 2022 01:21:20 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm5883557pjo.17.2022.07.01.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:20 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 13/30] drm/lima: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:08 +0530
Message-Id: <9e65578ab96ae33acbe7bcba664ef65663fff938.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 8989e215dfc9..d8c67843fa1b 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -111,6 +111,12 @@ int lima_devfreq_init(struct lima_device *ldev)
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.regulator_names = (const char *[]){ "mali" },
+		.regulator_count = 1,
+		.clk_names = (const char *[]){ "core" },
+		.clk_count = 1,
+	};
 
 	if (!device_property_present(dev, "operating-points-v2"))
 		/* Optional, continue without devfreq */
@@ -118,11 +124,7 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	spin_lock_init(&ldevfreq->lock);
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
-	if (ret)
-		return ret;
-
-	ret = devm_pm_opp_set_regulators(dev, (const char *[]){ "mali" }, 1);
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV)
-- 
2.31.1.272.g89b43f80a514

