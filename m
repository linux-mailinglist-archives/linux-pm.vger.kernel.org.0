Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4867885AA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbjHYL1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243324AbjHYL1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 07:27:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2D2115
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:27:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so1220399e87.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962820; x=1693567620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6dRAO4EfoAn2re7zIc0y2rFhEJtu95IouhvL8pLKsw=;
        b=PrZOmJtwD08yAaOBlxYOMRmce35UWUSuZX0cID7fIByJYAZOWPG8UCdKFup591sQdw
         aKEI+RKumG0cR/ggCV3sMS5P1Ijo8gRorJS6WSFgojpYP9gzV7OGOQvvqPfujjkPGAfW
         7JWaa6YenhNptu1oDfaA/xqYK5zss6bs0QLHr0fOH10oOr0FnoxfFnoMP0QuEarVB06N
         ovxeRI2klfCdGI74WApPOYSAkcREByMy7Fc2n+DHtVHG4U65ECP/VCtbjsp4tSzbmIIO
         ZAoIcXX814Vl0ats39/tvRJDVfJdYacYzyR6g5OPuLFa5EgBUukGwPw88mWcHMI8cNPO
         7tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962820; x=1693567620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6dRAO4EfoAn2re7zIc0y2rFhEJtu95IouhvL8pLKsw=;
        b=AmdPmjisANAr/Wkawyrrt10euHCyURs+Ui76/fQXc6Gc3X24ZcXmrNroLfABMHOlL9
         i1c253SloOSgx8ERl5teECFn3kw8fpt7zmbVXxTtzCFZW3mi9fgHYUlDUGbHeApBtA1d
         J6cXCMEpJapNCBCKxkTjLiRRJBDpciTwqQV9sOuARoMCby/J/6hVvA2qSRRTVVR5mxNo
         HKvSFR4fbPLjfCur3kBpyUSI/umc4fI+8B6yZkhK7kY1e1d4ppg+SX6SfLz2AF2NRwTX
         ivaur4h8Xz23pWnwl3+71jgtjNTm1DAmyfgPP1uf8PhBVHKOIaLStxJ6hCUh/68Ts3Bh
         008w==
X-Gm-Message-State: AOJu0Ywdzi8kNto973Nw3tE+dcUoCu2Lgr1MRyF0h/Wh71vFZX137hER
        D4DAQCqCApXX1mKDMNurnLTzVg==
X-Google-Smtp-Source: AGHT+IHYk6QR/qJHStjgxhG5KWjzyp+nCjXgemUVAMEhLlaa2oudO6hS4L4C6mpOzsgc6fGW9YmYcA==
X-Received: by 2002:a05:6512:3e9:b0:4ff:95c:e158 with SMTP id n9-20020a05651203e900b004ff095ce158mr10864148lfq.64.1692962820057;
        Fri, 25 Aug 2023 04:27:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:59 -0700 (PDT)
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
Subject: [PATCH v3 06/13] cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
Date:   Fri, 25 Aug 2023 13:26:26 +0200
Message-Id: <20230825112633.236607-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
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

The domain-id for the cpu_dev has already been parsed at the point when
scmi_get_sharing_cpus() is getting called. Let's pass it as an in-parameter
to avoid the unnecessary OF parsing.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

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

