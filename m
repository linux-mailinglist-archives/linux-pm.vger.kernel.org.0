Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E05534E43
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiEZLnz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbiEZLny (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:43:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF4543396
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so1241836plh.1
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMXTDiDSe4RWBZyUjzABNpjeeM5K5/JQo7rqiocgzqs=;
        b=RK5uBuHgkP4THzzr3r/8dgZy3FWz+tJFUf5pFEH2NKf3Qo8z2A9A9cpIs44f9K7W/i
         CSuQRuxCvRDe7Sjwg/hAU/XrbTZ+V1rXUfNo8cQ3A5e70gVsrRlGKQYVDDgJ2vyz8Kno
         45U0HtZ1q7n7a62KeqoYG50+OPkgwhPsgjF/Z4SfIhYGm67202SWgGE9y5whATkaGC1k
         +zNHSa0VYEJcpCzLCGFRe5xde824pdhGGj1Z4te7t0BwTWUdoufDgZlMqIOv5tB20pxd
         7uHVe9GgKNaCrw8FV+kzRoLJimizK3UngS2CnT1ILUgepmG43bnb9KMCqZUWto5v151+
         085Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMXTDiDSe4RWBZyUjzABNpjeeM5K5/JQo7rqiocgzqs=;
        b=2rCFQyEoFEQFP3gSTrXylrhHncxDvFH5r3Qj2hoKZZNhcodiF0hxW4YPAmCcuQa7gC
         xIbZ0dAwvNhlfzxaMl8JuAJ1/mUZTWMVRiS7WTq+gnKGUwGa6dSKEMGVpbVzGBCe3Li9
         Uirabp0w4vQeNge4kAB8SJJozXWmUX+q42G09Q6ghA91Y2Kg4L/2GIVCPenlmHYmaWSO
         G1GBoopsCm7d/cZ6colPVq5DIcsDSk1/+mcsRofMjkupCDau+5wMhM/xRCnFaiFvcW/y
         9h193BHC9FYVujfemHezYqj15pyr3xJDXs9UE0VADrqHQ/3GyPgfD66mfCxd+ajSW+K4
         KJfw==
X-Gm-Message-State: AOAM531nv3APnbmEq/BGCJELWwZk1SjcOOUs132zAhmNhLdjAHMoF6hz
        41zr3lIl2OP/L9PTx1BrNISEVQ==
X-Google-Smtp-Source: ABdhPJx1qO+JonnXRyCzQD/eZ/vKC/txcRft5Cqc/9mtqbr6w3kFnO87zVh92dYdVJmYb7R1+w/ZcA==
X-Received: by 2002:a17:90a:8005:b0:1df:ecbc:bd2c with SMTP id b5-20020a17090a800500b001dfecbcbd2cmr2213497pjn.10.1653565432970;
        Thu, 26 May 2022 04:43:52 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709029a4200b001635f7a54e8sm1311884plv.1.2022.05.26.04.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/31] cpufreq: ti: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:08 +0530
Message-Id: <b056e9069840a52fa28c80e4f10f0b440e6c3206.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/cpufreq/ti-cpufreq.c | 38 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 8f9fdd864391..cc58675df5c4 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -324,10 +324,13 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
 	const struct of_device_id *match;
-	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
 	const char * const default_reg_names[] = {"vdd", "vbb"};
 	int ret;
+	struct dev_pm_opp_config config = {
+		.supported_hw = version,
+		.supported_hw_count = ARRAY_SIZE(version),
+	};
 
 	match = dev_get_platdata(&pdev->dev);
 	if (!match)
@@ -370,33 +373,24 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_put_node;
 
-	ti_opp_table = dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
-						   version, VERSION_COUNT);
-	if (IS_ERR(ti_opp_table)) {
-		dev_err(opp_data->cpu_dev,
-			"Failed to set supported hardware\n");
-		ret = PTR_ERR(ti_opp_table);
-		goto fail_put_node;
-	}
-
-	opp_data->opp_table = ti_opp_table;
-
 	if (opp_data->soc_data->multi_regulator) {
-		const char * const *reg_names = default_reg_names;
+		config.regulator_count = ARRAY_SIZE(default_reg_names);
 
 		if (opp_data->soc_data->reg_names)
-			reg_names = opp_data->soc_data->reg_names;
-		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
-							 reg_names,
-							 ARRAY_SIZE(default_reg_names));
-		if (IS_ERR(ti_opp_table)) {
-			dev_pm_opp_put_supported_hw(opp_data->opp_table);
-			ret =  PTR_ERR(ti_opp_table);
-			goto fail_put_node;
-		}
+			config.regulator_names = opp_data->soc_data->reg_names;
+		else
+			config.regulator_names = default_reg_names;
+	}
+
+	opp_data->opp_table = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
+	if (IS_ERR(opp_data->opp_table)) {
+		dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
+		ret = PTR_ERR(opp_data->opp_table);
+		goto fail_put_node;
 	}
 
 	of_node_put(opp_data->opp_node);
+
 register_cpufreq_dt:
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 
-- 
2.31.1.272.g89b43f80a514

