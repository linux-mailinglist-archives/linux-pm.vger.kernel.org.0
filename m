Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5434E534E3C
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbiEZLnt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243744AbiEZLnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:43:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27373CA6B
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so1211930plr.9
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMTBzF5GicTdtcI+q0Njd7W32oNENUig/mMmCqOVS/0=;
        b=ECi8lONJz84vPA+6+yEdoeSZJvDmlwibpoOcQAEudBjrrORfDZ/A7oQAi1gqj8vgRR
         R+aqLr1rCe0jlBex5tphEGJ7fCpucrSMkTjnakJRfX97TsQII573ISpzpCCuM58QT9nH
         nXZ5IxBlFOY0JD+INnxF8anGEdvIsejZPxNtpwcXyOqsf0eWz3z4Nk0RTuKsXtgHsbvs
         0HYW94kSNL3bXaYX2ZN84qn8SAu6dvkj+XsKjLzs78nPc836WmFnEydmRKvjQPiwZp5p
         Rs/39UtauVouAx7r0D/kbMkbS+cibwfpPKIo2VVimuLkcQPb6ZfAtSDavkUFyl2OxuET
         sYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMTBzF5GicTdtcI+q0Njd7W32oNENUig/mMmCqOVS/0=;
        b=n8Y3Qeqcd6S6Wq0gTjHSGQkeJN3x6pBRNvWzppqHpsTFy8695aSCX/Dn9Okuodk2qU
         GSZ5PgXuD3fqpirV2U7k8g76MhlXZuKu6bffWVQ6xWZdVK++2AuPIiAncw9phxXYryB6
         jO8vdU01oxhhYKM5b14XPx3mqjsxCV+HFpvfEdi/ZtqoYCLknCbWUYvIT5tjhgHwJlUy
         RQvAEHzHQD52DXTIOj1Z9tB/OWz/YA0rxpsgiHz4tnnfCu63Uj6oV+ud8OL53h2mmDBi
         g1RehUXi/9iATaEIiSsXzvtoRzKmnQ1q9/HUDWe0yfF5ca7TkXd8zJR6dAxksQQjNxXi
         r2bw==
X-Gm-Message-State: AOAM530s3Kzamg/XAfxWopsQKNutVWnaTAUgSTGxOl+Xs09TBTxtUv4m
        GZ1aYeEcxfRxjNrTjPuEB0pdog==
X-Google-Smtp-Source: ABdhPJzBbBXOIW7AH9VqiZmcSr1TWNB9MDwyZf88IfV8UNEVzAgf3SeMfmF1BnlsZTyvge51/vwdqw==
X-Received: by 2002:a17:90b:4a8c:b0:1df:c71d:5104 with SMTP id lp12-20020a17090b4a8c00b001dfc71d5104mr2184562pjb.216.1653565414412;
        Thu, 26 May 2022 04:43:34 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902d58300b0016168e90f3fsm1314412plh.5.2022.05.26.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/31] cpufreq: dt: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:02 +0530
Message-Id: <a1fb3c6b287d9fb872ad5a73ba5475482f930b8e.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq-dt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8fcaba541539..65f299acb0c4 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -220,12 +220,16 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	 */
 	reg_name = find_supply_name(cpu_dev);
 	if (reg_name) {
-		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, &reg_name,
-							    1);
+		struct dev_pm_opp_config config = {
+			.regulator_names = &reg_name,
+			.regulator_count = 1,
+		};
+
+		priv->opp_table = dev_pm_opp_set_config(cpu_dev, &config);
 		if (IS_ERR(priv->opp_table)) {
 			ret = PTR_ERR(priv->opp_table);
 			if (ret != -EPROBE_DEFER)
-				dev_err(cpu_dev, "failed to set regulators: %d\n",
+				dev_err(cpu_dev, "failed to set OPP config: %d\n",
 					ret);
 			goto free_cpumask;
 		}
@@ -295,7 +299,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 out:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-	dev_pm_opp_put_regulators(priv->opp_table);
+	dev_pm_opp_clear_config(priv->opp_table);
 free_cpumask:
 	free_cpumask_var(priv->cpus);
 	return ret;
@@ -309,7 +313,7 @@ static void dt_cpufreq_release(void)
 		dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
 		if (priv->have_static_opps)
 			dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-		dev_pm_opp_put_regulators(priv->opp_table);
+		dev_pm_opp_clear_config(priv->opp_table);
 		free_cpumask_var(priv->cpus);
 		list_del(&priv->node);
 	}
-- 
2.31.1.272.g89b43f80a514

