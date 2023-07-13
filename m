Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04F57524F5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGMOS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjGMOSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 10:18:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997D1BE3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1363114e87.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257894; x=1691849894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edTXoMvhNuFH/nL1WC1npUwMJQVMfw3CQ3zP4/nOz8w=;
        b=nLEjBxXdgMUpb3KCbXWep74RoVZKaYfH4dDzOQsXLmnPx1pvm4cE+mXXPuVlMCc4y+
         JukVUoe5asdozcZJ9n5eTiliyTycs/gBw5KlaRIlUvUCtWom4ZOytH4Rkqz/sOX7wRsw
         B7IeDJQfMhJgpa3GJuaY36TIUqk9Le01rwNaBfOQoBDnLxFtCZbGJxbi9+eyMgVz3UxW
         edrB4pvXYeyzq9KuIuCv3+hjV/3lJUqhWrv8y8niuEh/WkestWJquQ5XIhHA53ITvgVW
         RhnM+napAinuinQ4dwHLwukQGtoySCnpLr0MPODoar97MQq7rUZpf2ErQKpgwy9x5uOv
         Xwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257894; x=1691849894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edTXoMvhNuFH/nL1WC1npUwMJQVMfw3CQ3zP4/nOz8w=;
        b=DLg8qWKRqp6AzhQFpPuunly7bvGyMoblOavFX5zm450J0jUjWpIFNgS45T40xVrIAC
         Q/ih4g55rNUMg00VYkDH+bFYS1hRxBX0vhOfoyIINDCOXHTdvfndiGWoo5AZ9/B01YAP
         fS9fGn+m8KwMNrowBiTwpof68TqiZs/d8vCzbXIf/fM3QRyGljFCe+VUHS3MRm1GT22V
         hfiXnsg4kpfkDF99j8MKkEPRP2KJZr7UfAZdsFl+/WaTQPfbFjYTmqjCtPOvREjoCrEi
         z2M9l9nelwhMTaMCEpFKevPAzG/OxOmy5aggZIWuKSIEC1/EVMevVU3tLxikLNuPAMKP
         V38A==
X-Gm-Message-State: ABy/qLbY6mNmPRdlwFSOw4x/w2WvVrP1rMiCgt9+y9KlvxaloDne5kqo
        V3pm//xZNs59T/dn9E7YOLyc9Q==
X-Google-Smtp-Source: APBJJlFNXJ3at9poSaiKDKcrBrUCfItFY+Wqxh9WZOMaNxZfhW5W3LRXVUiRnEjrC1On/aEC0k79YA==
X-Received: by 2002:ac2:5a50:0:b0:4fb:8de9:ac0e with SMTP id r16-20020ac25a50000000b004fb8de9ac0emr1310574lfn.1.1689257894500;
        Thu, 13 Jul 2023 07:18:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:13 -0700 (PDT)
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
Subject: [PATCH v2 04/11] firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
Date:   Thu, 13 Jul 2023 16:17:31 +0200
Message-Id: <20230713141738.23970-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
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

Most scmi_perf_proto_ops are already using an "u32 domain" as an
in-parameter to indicate what performance domain we shall operate upon.
However, some of the ops are using a "struct device *dev", which means that
an additional OF parsing is needed each time the perf ops gets called, to
find the corresponding domain-id.

To avoid the above, but also to make the code more consistent, let's
replace the in-parameter "struct device *dev" with an "u32 domain". Note
that, this requires us to make some corresponding changes to the scmi
cpufreq driver, so let's do that too.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/cpufreq/scmi-cpufreq.c   | 14 +++++++++-----
 drivers/firmware/arm_scmi/perf.c | 18 +++++-------------
 include/linux/scmi_protocol.h    |  6 +++---
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 7d05d48c0337..125e8a8421fb 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -137,7 +137,7 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret, nr_opp;
+	int ret, nr_opp, domain;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scmi_data *priv;
@@ -149,6 +149,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
+	domain = scmi_cpu_domain_id(cpu_dev);
+	if (domain < 0)
+		return domain;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -187,7 +191,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	  */
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		ret = perf_ops->device_opps_add(ph, cpu_dev);
+		ret = perf_ops->device_opps_add(ph, cpu_dev, domain);
 		if (ret) {
 			dev_warn(cpu_dev, "failed to add opps to the device\n");
 			goto out_free_cpumask;
@@ -220,7 +224,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = scmi_cpu_domain_id(cpu_dev);
+	priv->domain_id = domain;
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
@@ -228,14 +232,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = perf_ops->transition_latency_get(ph, cpu_dev);
+	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
 
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible =
-		perf_ops->fast_switch_possible(ph, cpu_dev);
+		perf_ops->fast_switch_possible(ph, domain);
 
 	return 0;
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index f3ea96dd845c..6046c0eb5959 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -585,18 +585,14 @@ static int scmi_dev_domain_id(struct device *dev)
 }
 
 static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
-				     struct device *dev)
+				     struct device *dev, u32 domain)
 {
-	int idx, ret, domain;
+	int idx, ret;
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 
-	domain = scmi_dev_domain_id(dev);
-	if (domain < 0)
-		return domain;
-
 	dom = pi->dom_info + domain;
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
@@ -618,14 +614,10 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
-				 struct device *dev)
+				 u32 domain)
 {
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
-	int domain = scmi_dev_domain_id(dev);
-
-	if (domain < 0)
-		return domain;
 
 	dom = pi->dom_info + domain;
 	/* uS to nS */
@@ -685,12 +677,12 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 }
 
 static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
-				      struct device *dev)
+				      u32 domain)
 {
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 
-	dom = pi->dom_info + scmi_dev_domain_id(dev);
+	dom = pi->dom_info + domain;
 
 	return dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr;
 }
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ed032fe83c28..71072fe8ccc9 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -140,9 +140,9 @@ struct scmi_perf_proto_ops {
 			 u32 *level, bool poll);
 	int (*device_domain_id)(struct device *dev);
 	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
-				      struct device *dev);
+				      u32 domain);
 	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
-			       struct device *dev);
+			       struct device *dev, u32 domain);
 	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			unsigned long rate, bool poll);
 	int (*freq_get)(const struct scmi_protocol_handle *ph, u32 domain,
@@ -150,7 +150,7 @@ struct scmi_perf_proto_ops {
 	int (*est_power_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			     unsigned long *rate, unsigned long *power);
 	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
-				     struct device *dev);
+				     u32 domain);
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
 };
 
-- 
2.34.1

