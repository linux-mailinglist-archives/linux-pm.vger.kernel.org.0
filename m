Return-Path: <linux-pm+bounces-12786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2436995C117
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA9A282195
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2401D414E;
	Thu, 22 Aug 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4tVCANt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAF1D1743
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366780; cv=none; b=IAlcXvq5NN6qr9QxBXYMxMCFwX46Z+ODWk9jHIi1bjD4g2tNx4eguJ27YWdFnD1G1U1AJ3rHw6sdzVQPbGdh94mOrc2bgppdHj5jMLFJr61mVZs08DRRERW1iAqcBmz0gxgrcm1EKecmm7mMJAd8BSr18NbCfWSrXgAOYQPLA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366780; c=relaxed/simple;
	bh=fzv2Qhm8qkbuiNawozPPsMhWU0ubmi4ni4I/TKeUmdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBK+osurjkqnAU/IFLRAczaVl2bb26L12M5q+wZ/r0Lua0K34vRDRCLx2FF0YPPonUG5w/dPCtZRHzlhHk7gzjGwURtbQw9ROr8+C+xIgZOfL4/fLhWcNKdfCjVKvsn3yKL9RYctKssA7SpjMbYZ0HeDWyntKiaC524Wx5clg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h4tVCANt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334c4d6829so1754956e87.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366777; x=1724971577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iksFSJ//26ReVaxAnVHvTDyArAC4NnchBY2BZAJDBow=;
        b=h4tVCANtLg/Hai7zD3IRKcelktZ8/qw4aWtj6JFt6o0Uu+wuK/g4mO9M82r8KzfeSN
         Tsnnf6sNMlrRVGvWbrXsHceLbucnQmJAyckQSoWYDAoipRSWqyMsLtU1GOyIzz2LX7pe
         PM1qe3oL1nuGzckGy2HLizataa7AHiZ4qTjGP6sxEJ4N58xuqkWFo/OPmfM7GTkvF56d
         oM7EGprVswx/WIZJvHzJo3sgCpbRh+5cgyoaQOmFn/ejN4MvjKGhsT0KY5irnO2IpxHw
         uxZJf+DztaHY3BKECZ75Bxa7jk9F3sp2wfA2i3INKMvjxC2EpsMlqXl5YkJmemCDGjKk
         PVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366777; x=1724971577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iksFSJ//26ReVaxAnVHvTDyArAC4NnchBY2BZAJDBow=;
        b=UG9JgJA/TT5wMU/2YU8QiW0vihWhAmT+91TSre29BYRA+Dr+5czv2BD/CYX6Zfp88t
         DVXoTijqBCnqvIH8qLZWjAVhutldg552Ek0dH/Ru5R48Xt3w7C80d4RUFmyPnpj212sI
         S5bHDfaRbe7yn744gpnO1dwZI7Gva6aif8TUkqt0YoxMvJcOo9Sj14TCixtZWIytAfVa
         HMaBaCwhMR//t4ym+Q5Z10bNh1MotG46MBMhBA62SHmQg6G0Bq+rd8cPdmDBpjJAVrGM
         XA0Yf4hQ63b+w/V26IEovyNhqtivLZ2QRFSR6NWvwUSV0w9lGRCmTLX+0b0wgzhXWoSR
         IDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6gFsDcvCLS1GsNoWw+sUGnl6+g4UcKpUizureBwJZZS06qe9hbqavtV9UWSsc8YyOEMrG3oj2ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLy/TWbVNZFcRcVAk3UAExoGeAYEBbKwhNvOE5j47ziTuAe+eg
	QdyRbfw4TYZNJiQwT+MlqjaGihK/KLaFkWjludTt2DhmnWu5F+TeK64NG0lLdL0=
X-Google-Smtp-Source: AGHT+IFqYnnUrUddlV2VzJzkFcuvSxGz0XMOiVMuzx0Kw0HD/D4q6JeKW5PZ8PIU3LGdvGhnAFZwtQ==
X-Received: by 2002:a05:6512:15a2:b0:530:ba4b:f65d with SMTP id 2adb3069b0e04-534387852e1mr179442e87.28.1724366776756;
        Thu, 22 Aug 2024 15:46:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:16 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
Date: Fri, 23 Aug 2024 00:45:46 +0200
Message-Id: <20240822224547.385095-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822224547.385095-1-ulf.hansson@linaro.org>
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than hooking up the PM domains through _opp_attach_genpd() and
manually manage runtime PM for the corresponding virtual devices created by
genpd during attach, let's avoid the boilerplate-code by converting into
dev_pm_domain_attach|detach_list.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 79 +++++++++-------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 939702dfa73f..6ba8c8378384 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -52,12 +52,13 @@ struct qcom_cpufreq_match_data {
 			   struct nvmem_cell *speedbin_nvmem,
 			   char **pvs_name,
 			   struct qcom_cpufreq_drv *drv);
-	const char **genpd_names;
+	const char **pd_names;
+	unsigned int num_pd_names;
 };
 
 struct qcom_cpufreq_drv_cpu {
 	int opp_token;
-	struct device **virt_devs;
+	struct dev_pm_domain_list *pd_list;
 };
 
 struct qcom_cpufreq_drv {
@@ -395,8 +396,6 @@ static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
 	return 0;
 }
 
-static const char *generic_genpd_names[] = { "perf", NULL };
-
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -407,13 +406,13 @@ static const struct qcom_cpufreq_match_data match_data_krait = {
 
 static const struct qcom_cpufreq_match_data match_data_msm8909 = {
 	.get_version = qcom_cpufreq_simple_get_version,
-	.genpd_names = generic_genpd_names,
+	.pd_names = (const char *[]) { "perf" },
+	.num_pd_names = 1,
 };
 
-static const char *qcs404_genpd_names[] = { "cpr", NULL };
-
 static const struct qcom_cpufreq_match_data match_data_qcs404 = {
-	.genpd_names = qcs404_genpd_names,
+	.pd_names = (const char *[]) { "cpr" },
+	.num_pd_names = 1,
 };
 
 static const struct qcom_cpufreq_match_data match_data_ipq6018 = {
@@ -428,28 +427,16 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
 
-static void qcom_cpufreq_suspend_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
+static void qcom_cpufreq_suspend_pd_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
 {
-	const char * const *name = drv->data->genpd_names;
+	struct dev_pm_domain_list *pd_list = drv->cpus[cpu].pd_list;
 	int i;
 
-	if (!drv->cpus[cpu].virt_devs)
+	if (!pd_list)
 		return;
 
-	for (i = 0; *name; i++, name++)
-		device_set_awake_path(drv->cpus[cpu].virt_devs[i]);
-}
-
-static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
-{
-	const char * const *name = drv->data->genpd_names;
-	int i;
-
-	if (!drv->cpus[cpu].virt_devs)
-		return;
-
-	for (i = 0; *name; i++, name++)
-		pm_runtime_put(drv->cpus[cpu].virt_devs[i]);
+	for (i = 0; i < pd_list->num_pds; i++)
+		device_set_awake_path(pd_list->pd_devs[i]);
 }
 
 static int qcom_cpufreq_probe(struct platform_device *pdev)
@@ -503,7 +490,6 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	for_each_possible_cpu(cpu) {
-		struct device **virt_devs = NULL;
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -522,12 +508,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 				config.prop_name = pvs_name;
 		}
 
-		if (drv->data->genpd_names) {
-			config.genpd_names = drv->data->genpd_names;
-			config.virt_devs = &virt_devs;
-		}
-
-		if (config.supported_hw || config.genpd_names) {
+		if (config.supported_hw) {
 			drv->cpus[cpu].opp_token = dev_pm_opp_set_config(cpu_dev, &config);
 			if (drv->cpus[cpu].opp_token < 0) {
 				ret = drv->cpus[cpu].opp_token;
@@ -536,25 +517,17 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			}
 		}
 
-		if (virt_devs) {
-			const char * const *name = config.genpd_names;
-			int i, j;
-
-			for (i = 0; *name; i++, name++) {
-				ret = pm_runtime_resume_and_get(virt_devs[i]);
-				if (ret) {
-					dev_err(cpu_dev, "failed to resume %s: %d\n",
-						*name, ret);
+		if (drv->data->pd_names) {
+			struct dev_pm_domain_attach_data attach_data = {
+				.pd_names = drv->data->pd_names,
+				.num_pd_names = drv->data->num_pd_names,
+				.pd_flags = PD_FLAG_DEV_LINK_ON,
+			};
 
-					/* Rollback previous PM runtime calls */
-					name = config.genpd_names;
-					for (j = 0; *name && j < i; j++, name++)
-						pm_runtime_put(virt_devs[j]);
-
-					goto free_opp;
-				}
-			}
-			drv->cpus[cpu].virt_devs = virt_devs;
+			ret = dev_pm_domain_attach_list(cpu_dev, &attach_data,
+							&drv->cpus[cpu].pd_list);
+			if (ret < 0)
+				goto free_opp;
 		}
 	}
 
@@ -570,7 +543,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu) {
-		qcom_cpufreq_put_virt_devs(drv, cpu);
+		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
 	return ret;
@@ -584,7 +557,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu) {
-		qcom_cpufreq_put_virt_devs(drv, cpu);
+		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
 }
@@ -595,7 +568,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
 	unsigned int cpu;
 
 	for_each_possible_cpu(cpu)
-		qcom_cpufreq_suspend_virt_devs(drv, cpu);
+		qcom_cpufreq_suspend_pd_devs(drv, cpu);
 
 	return 0;
 }
-- 
2.34.1


