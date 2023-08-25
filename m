Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA087885A1
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbjHYL11 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbjHYL1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 07:27:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039031FF7
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:26:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ff882397ecso1177862e87.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962816; x=1693567616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2TQdtT3qz2vpAW4ejhOrGqY7dksVjSBILvmL3wVcIM=;
        b=cook8dCIOEfC72pZlPohdnANtElNcqRXK/Sj6beTTedacdXKArpYT8qdVCpmTn808f
         6krWWGR/5P+3F8sXBbu//NqpKiN8Xddjm3YS2StA9bPamMonXMhpLWJ6F47lXCwxB42h
         RIOnjp+VLRRcYtNHIQFrCwCfZ6EJAOzNQcuf/rpC1h7uy5gAHQzUwq/3Xf6W/V4Kdfk6
         M/I1v1G0E8mFcyKGfX8UuGrhW0wtUxKOqKuUqhgCV+7eYcRdP38hG1vnNv9HMFJVUR/f
         CZgZtxHG72rfp+JotzSGwxYvl6Z0nSFpdxSryNXPofJ2TukmFCCJJoJNudoiumJz7j6Z
         jpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962816; x=1693567616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2TQdtT3qz2vpAW4ejhOrGqY7dksVjSBILvmL3wVcIM=;
        b=bj+mbyFN/EWuRbMXk4R/rT3CNDBrVRvy1HKMvUVJlLAHbvW0Ui/pEAS+2kfc6itWNQ
         bSO8EryKI0at2hK2bVN7MmHCYrMqMQN3/KrpoBE8TlKUO5sacwA4hICGVqxqpkw+TSsk
         8171/6GyM9ks0/QpsfFx2xFKdhfRHnkuG+/1VgFMJJXNmA28viRLYlgXizg2ZaG3BPZz
         rxf8gH/PIsFzdS1NRbG/lwBW9G6SfUBmRb8ps/m8lAmXcUybsobFD/2mnLwWo5u5IYz0
         VOeRL2qR9C3ZG+UGvgruEeEWCdn0ufUrCz4ke6TE13XWz41w0QpmjEvQq+H6yEK3XcPD
         4f0w==
X-Gm-Message-State: AOJu0YxtsBO4FkhaH0fl5ltP3ik4vwSk0ZwyEcW1anLny9Qps8yZYdqB
        B1F+0AHfkcXmBcVR5XlC6L6WtQ==
X-Google-Smtp-Source: AGHT+IHMQx4lOZzpnya1byJyjRj+QtAOUhCzJn4PjtWUpUtj2hPvoRUsssQS0fIEtqMyKCazZSRwkg==
X-Received: by 2002:a05:6512:224e:b0:4fd:c84f:30c9 with SMTP id i14-20020a056512224e00b004fdc84f30c9mr15770842lfu.47.1692962816101;
        Fri, 25 Aug 2023 04:26:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:55 -0700 (PDT)
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
Subject: [PATCH v3 03/13] cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
Date:   Fri, 25 Aug 2023 13:26:23 +0200
Message-Id: <20230825112633.236607-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OF parsing of the clock domain specifier seems to better belong in the
scmi cpufreq driver, rather than being implemented behind the generic
->device_domain_id() perf protocol ops.

To prepare to remove the ->device_domain_id() ops, let's implement the OF
parsing in the scmi cpufreq driver instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Re-based.

---
 drivers/cpufreq/scmi-cpufreq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index f34e6382a4c5..7d05d48c0337 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -70,13 +70,24 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static int scmi_cpu_domain_id(struct device *cpu_dev)
+{
+	struct of_phandle_args clkspec;
+
+	if (of_parse_phandle_with_args(cpu_dev->of_node, "clocks",
+				       "#clock-cells", 0, &clkspec))
+		return -EINVAL;
+
+	return clkspec.args[0];
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
 	int cpu, domain, tdomain;
 	struct device *tcpu_dev;
 
-	domain = perf_ops->device_domain_id(cpu_dev);
+	domain = scmi_cpu_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -88,7 +99,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		if (!tcpu_dev)
 			continue;
 
-		tdomain = perf_ops->device_domain_id(tcpu_dev);
+		tdomain = scmi_cpu_domain_id(tcpu_dev);
 		if (tdomain == domain)
 			cpumask_set_cpu(cpu, cpumask);
 	}
@@ -104,7 +115,7 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	unsigned long Hz;
 	int ret, domain;
 
-	domain = perf_ops->device_domain_id(cpu_dev);
+	domain = scmi_cpu_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -209,7 +220,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = perf_ops->device_domain_id(cpu_dev);
+	priv->domain_id = scmi_cpu_domain_id(cpu_dev);
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
-- 
2.34.1

