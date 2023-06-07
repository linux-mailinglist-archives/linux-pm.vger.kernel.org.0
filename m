Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B5725FE2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbjFGMrZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbjFGMrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 08:47:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834D19AC
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 05:47:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1badb8f9bso54841451fa.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142023; x=1688734023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcFIFzlxuaj95mrPekLslPaq6LF3WQagm1CvzdpttW8=;
        b=nHwwPnA9ljX4h2OItxC5R61hMDJGQXC4NQicB85qJzaiv/1PAEAmc+ZTqbh5R7iMIN
         G7Co+6il9T22wVppZZjlwyNyIyF6WuBIGpBM1EhvXchD89Z1rwJJTOb6+Fhd+EOnJ/Mw
         XiXg1ASLg7D+CAhIuEYdDSEfnYqHVu2Nhrg7FfaNbaJR4cUX5HFexxAsNdEEWXDczrJK
         x5GlxIUJZ9My4guxbqa4+WFr6KnSUwCRUGDOf0dZS+7SCJPAgguillYbg9wAqhJOUpJP
         ppm4t8fO1Wkkj/BLBzLf88LMENST/kfA/Mz5yhEOe2SQlZave+e+2ODJJgx9WPaqSFaR
         YWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142023; x=1688734023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcFIFzlxuaj95mrPekLslPaq6LF3WQagm1CvzdpttW8=;
        b=Rb7I7XZjsvcH0guV4RsPKkws53ySrUVwO6GITwhXzlIfhNdrm8+GVrUllpCefGdTsw
         u++eL82EfusBtaJPbOSO+uUNuKahS28+uaouONwO/Jl8wTEFavzqOEhjY+VN+OqUVG9H
         RCrQHApiav2SWilMUiv/OAwBYXOtsXPfIB5hmbXs4fs4kjvf3WXVix89vGH1OBu2BokQ
         S292tgRaNqk1bFD6vy7KwzCirO5ysMVpwGy1/RKPAuuPf1NewyHzy3ODH7t7VbegUZtx
         k0eTgMdrg0g2eG21mUiU2jrQjzR9qx9KIT3Bm5Vn+AfGD7GxHjFAMotORl2itMxpxoRQ
         NaKg==
X-Gm-Message-State: AC+VfDxyqI1iYigngN8uAkL4pn/uZ2k8d83L7jNw9xL+2CytaIhKisLI
        7YkCJu4F0B5GlngdifDQ2IYAEw==
X-Google-Smtp-Source: ACHHUZ7MfrKrmho6SvmAbt/n1doRuY4rUhqfbuKmIzQhUWTjjDOL4+dQPQ+ue8e0r5O4Q+P3ADMvkQ==
X-Received: by 2002:a2e:3515:0:b0:2af:1844:6fdb with SMTP id z21-20020a2e3515000000b002af18446fdbmr2148166ljz.5.1686142023625;
        Wed, 07 Jun 2023 05:47:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
Date:   Wed,  7 Jun 2023 14:46:19 +0200
Message-Id: <20230607124628.157465-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
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

The domain-id for the cpu_dev has already been parsed at the point when
scmi_get_sharing_cpus() is getting called. Let's pass it as an in-parameter
to avoid the unnecessary OF parsing.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 125e8a8421fb..78f53e388094 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -82,15 +82,12 @@ static int scmi_cpu_domain_id(struct device *cpu_dev)
 }
 
 static int
-scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
+scmi_get_sharing_cpus(struct device *cpu_dev, int domain,
+		      struct cpumask *cpumask)
 {
-	int cpu, domain, tdomain;
+	int cpu, tdomain;
 	struct device *tcpu_dev;
 
-	domain = scmi_cpu_domain_id(cpu_dev);
-	if (domain < 0)
-		return domain;
-
 	for_each_possible_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
@@ -163,7 +160,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/* Obtain CPUs that share SCMI performance controls */
-	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
+	ret = scmi_get_sharing_cpus(cpu_dev, domain, policy->cpus);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
 		goto out_free_cpumask;
-- 
2.34.1

