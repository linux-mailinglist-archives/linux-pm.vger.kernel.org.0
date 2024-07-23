Return-Path: <linux-pm+bounces-11344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3541E93A326
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561B71C22D5F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D0157466;
	Tue, 23 Jul 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fs5k9JJw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDD156F20
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746000; cv=none; b=p3cx7azp6Pvx/0sxDEjeCj/g0w5U+dvZaVZGDcwgfGSnsvUzoZnRsMSv1rqNZzSO1ylYqCeYmL/R+pMT3FI9soU/O37xOh9noeL7zlXzlRZEmMx999raa4j4vK0biogDk0RG4quV/+ikacDqK5vTIZl7f8t4+KNr0yiJEsA/9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746000; c=relaxed/simple;
	bh=/Cz64eiORglL+JzsTj4J/qRQ+zkIqCGxhfUI/VtVVk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxB8XxoHBpwMi8dpNKjo5m7XCUQslxYBIEP1rpZK+zCJ/wvNEO0awPXQFqeb29RsQpAwgdLxJbSQXH/AH+7dIPtWUWK1Q97PALILC37LX5wLVGg8uSeaiIztAF2MGuQ5xxBWqQPK6N+VVnEtl8T0vOirRbjAx/HfWrvXHwcV3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fs5k9JJw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so5412756e87.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745996; x=1722350796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrrcMYfLG/IRNiRlIGOfcILMNeNyK16y6kYofjra+ME=;
        b=Fs5k9JJwNkn38jF5j/3cTOW6MPopJSbKnXcOYPNzoZ50zhX4iUrWqyu240TFa2g3IA
         zVT2RL9IhoYDT7vFkliRGTzQr5b3zEQsTcPY/sS6C7TDsDaFmMCkPGiYVf9hUQOJkioL
         DTpccfRNR1ptBiu/0vHr3nmJB7QP+3HDqMMnJ+zrJgLUEX0Jqjz4jNLTk38pPoiZ+CTF
         8mCT8+hzsynEXpfKscPA31g1PFhIgk7bR3LXGbJw7AilQtbBPXkUkgJjaNoDMU6Hfzu1
         KG8y2Eq2R5eqGiuVdghPK15FCT6ZNazqsb5FS82Sb7BTbt/VTM2U6UOIHQPYRtLf9K/i
         gumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745996; x=1722350796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrrcMYfLG/IRNiRlIGOfcILMNeNyK16y6kYofjra+ME=;
        b=u+zBTX0p0LegioIEiSAsl/geKZeLqfKyrQY5H7ebexk4v4BwOgkERJtrO9tU0ur5L5
         iZf57Mc/T/rsTIfxL33Ja2vLjGHkuURNxdJs7L65oDWGiTQUXWcemSMRy1aAy7z+p38d
         IuzKKEL69I9AlcLxsgXIlr6EI/rwY+48hw1+/yCOkzVZtnxbInid+ARZfC5qXeXAoJla
         /PvY5xrgYyiykqJuSZxaOpwdq9ydhqtMcnerk8Gd/6cPa1IVpAPYHMDXJFpKXTJ/mVgs
         UmvsBkCge+M5KYJz9pWCnQKB1wS1wbMBD+qrEUfV8lZMJggj/n4QQjUrd89tGdiMabT/
         y7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV4YI9vW3MslqFbsy+Pn/pvpIowlSWrpO5DHyzhPpcPbDnQzxSWy3KprBJ1tQfpugXahC/Y+rYD+OXV2lEJNyt9XMXiuSX62tI=
X-Gm-Message-State: AOJu0Yw/QVqKKxLkiba7S2hgU3PCgLl0G/lsf6mnnTZtpzcPpG5dZr/+
	y8ZW5QGycy83pRN62cN2flcvcAtZnRcl9LECs87EZFm6KE1xHiTsZaMWF6x+SF0=
X-Google-Smtp-Source: AGHT+IHI7MKcmaUYwLbT8KpWV+gZCkHNesswZsoZOrPGXmC51ZgZNSlNboV0W17HiSXE+kZ3RDydkQ==
X-Received: by 2002:a05:6512:31c7:b0:52e:be1f:bf8b with SMTP id 2adb3069b0e04-52fc406f0famr2550946e87.47.1721745996507;
        Tue, 23 Jul 2024 07:46:36 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0415eb08sm774540e87.9.2024.07.23.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:46:36 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilia Lin <ilia.lin@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/4] cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
Date: Tue, 23 Jul 2024 16:46:09 +0200
Message-Id: <20240723144610.564273-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723144610.564273-1-ulf.hansson@linaro.org>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
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
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 79 +++++++++-------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index ea05d9d67490..65739ce98658 100644
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
@@ -394,8 +395,6 @@ static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
 	return 0;
 }
 
-static const char *generic_genpd_names[] = { "perf", NULL };
-
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -406,13 +405,13 @@ static const struct qcom_cpufreq_match_data match_data_krait = {
 
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
@@ -427,28 +426,16 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
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
@@ -505,7 +492,6 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	of_node_put(np);
 
 	for_each_possible_cpu(cpu) {
-		struct device **virt_devs = NULL;
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -524,12 +510,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
@@ -538,25 +519,17 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
 
@@ -572,7 +545,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu) {
-		qcom_cpufreq_put_virt_devs(drv, cpu);
+		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
 	return ret;
@@ -586,7 +559,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu) {
-		qcom_cpufreq_put_virt_devs(drv, cpu);
+		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
 }
@@ -597,7 +570,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
 	unsigned int cpu;
 
 	for_each_possible_cpu(cpu)
-		qcom_cpufreq_suspend_virt_devs(drv, cpu);
+		qcom_cpufreq_suspend_pd_devs(drv, cpu);
 
 	return 0;
 }
-- 
2.34.1


