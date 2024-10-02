Return-Path: <linux-pm+bounces-15062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247098D31E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D484A28237B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF01D0B9E;
	Wed,  2 Oct 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0NoTj8e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689C1D0975
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871784; cv=none; b=CT10TcC6yeM+rEJqNh8dXTGeenyDe7VRCoVCn73D3We12oyGraQh2Muld6dA9MHPiR8AeoLvLq2tKE5vYdSc/dbtGWGhihsT2EzxbemllyMqiOEKikNTQvCBiCJl9eOAwqb2h/S5nIT8vfOwZAz55MwFyGLH/SDv3GdQ2DaHnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871784; c=relaxed/simple;
	bh=SmO3sdlVk0x8zX0KM6W3DZtxwnyTB8/LIKgDqf6GADQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBKlba2UQMpiZ6n48ThDSBfReT/7FD2qvUPZL2A7CFEi0JtZZxiswtqZAj472O7X1FRZF1gHEWyvMyGgcLe5IQ8jrKQ/SSsjnN7eqdLmwhtp/llBUs/cqOKePlsi8D+TAq7HsG9IJhMawpRMIYNh3z6ycDYzYEmt9bm7MWO0nzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l0NoTj8e; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so708103e87.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871780; x=1728476580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioJK8BOaSsn9HTDSl84hfYEjyAU3JP05p6zQ+wzakGg=;
        b=l0NoTj8eoRDMZWbsZFMRnWSOxBAm7PkGeK9x8dIeP+IXLFgA3iRCJLivpoLC4Nsku1
         ZQUEA/lfoU9h2y1HrQg53d0PnFX+zkYqB4RtKlnIvneBTjwKqOXwqkUvFtNMAJGs7GE0
         KgFVdztl2E6vTnEAV8gsp1DoVoHTiRrS+CB+hJekOVLZnVXxgSw86s7ou+xE5JUqySp1
         UYYDp8toQN5lMkxtm1oI0zcLuD3cxhvB0StpQemehA4Q63nN66275zDcS66NtG0k4Q+x
         bNS+6BPPlbhASgv51apXTEH+UTWJnIXG8df6xmMjQiiGlk+bz8uhpgj3RhiA2Gafjrt+
         51jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871780; x=1728476580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioJK8BOaSsn9HTDSl84hfYEjyAU3JP05p6zQ+wzakGg=;
        b=Xd3P+LFdyS5lHZmNvCcuqd05oJv9K2FD3C/yWFD6DUZvNCE0s8FBhhmNN6hSH3A06p
         ZeBdhflqcYKXHDv9ryw/1YgSHVbqObx+QmrhwwjfOnTupnGI3eZ9F2ZusSNHs3m3nNFy
         2fhK35sXItTl/TXOYb4qZKD4mvEe28CEs3Vm7zKzZlE/i5s8p/4EnVWRTjEarbWMrjC0
         1aXokhapmuaGzGXDyes0mBj3qWac9qPTe7L18Y+w1PvLgQPOqyAxg7iSQg7qGbs0TIbd
         HLzY3z+6JjBT7pniK1CnFnj4OTNcsnJaEms1qw3bk0TbHHZjD9Ry4U2SkBihGj2gPu0L
         fOMA==
X-Forwarded-Encrypted: i=1; AJvYcCUbY4FSCJJxIjVHGyROjToL10YBqXkNERVWgANie/q5cym2p2i+UBpPPyQFH+7Bb3vL/5hB2D9fPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6hpidVlSzmq4w6D6FC8bPXaYfqzqn6gmm60wM7T7bJQPN5Xk5
	WfkbUfFdfDY+cp24E0+TL1IMfsZ0RLrRccKPW6D83GA+AzDPt1SDbfZKvv/vDLI=
X-Google-Smtp-Source: AGHT+IHZvUpUQVKydq2pw6p7GG/MT83+FpL8b5ACaxZ94aFtOvkahJE/oZ+bt2LWwTM0yOZWU2UVgw==
X-Received: by 2002:a05:6512:e9a:b0:539:922e:2374 with SMTP id 2adb3069b0e04-5399a23594bmr2277661e87.1.1727871780381;
        Wed, 02 Oct 2024 05:23:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:59 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 10/11] cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
Date: Wed,  2 Oct 2024 14:22:31 +0200
Message-Id: <20241002122232.194245-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002122232.194245-1-ulf.hansson@linaro.org>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Minor. Use PD_FLAG_REQUIRED_OPP.

---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 82 ++++++++++------------------
 1 file changed, 28 insertions(+), 54 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 703308fb891a..ae556d5ba231 100644
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
-{
-	const char * const *name = drv->data->genpd_names;
-	int i;
-
-	if (!drv->cpus[cpu].virt_devs)
-		return;
-
-	for (i = 0; *name; i++, name++)
-		device_set_awake_path(drv->cpus[cpu].virt_devs[i]);
-}
-
-static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
+static void qcom_cpufreq_suspend_pd_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
 {
-	const char * const *name = drv->data->genpd_names;
+	struct dev_pm_domain_list *pd_list = drv->cpus[cpu].pd_list;
 	int i;
 
-	if (!drv->cpus[cpu].virt_devs)
+	if (!pd_list)
 		return;
 
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
@@ -536,25 +517,18 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
-
-					/* Rollback previous PM runtime calls */
-					name = config.genpd_names;
-					for (j = 0; *name && j < i; j++, name++)
-						pm_runtime_put(virt_devs[j]);
-
-					goto free_opp;
-				}
-			}
-			drv->cpus[cpu].virt_devs = virt_devs;
+		if (drv->data->pd_names) {
+			struct dev_pm_domain_attach_data attach_data = {
+				.pd_names = drv->data->pd_names,
+				.num_pd_names = drv->data->num_pd_names,
+				.pd_flags = PD_FLAG_DEV_LINK_ON |
+					    PD_FLAG_REQUIRED_OPP,
+			};
+
+			ret = dev_pm_domain_attach_list(cpu_dev, &attach_data,
+							&drv->cpus[cpu].pd_list);
+			if (ret < 0)
+				goto free_opp;
 		}
 	}
 
@@ -570,7 +544,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu) {
-		qcom_cpufreq_put_virt_devs(drv, cpu);
+		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
 	return ret;
@@ -584,7 +558,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu) {
-		qcom_cpufreq_put_virt_devs(drv, cpu);
+		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
 }
@@ -595,7 +569,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
 	unsigned int cpu;
 
 	for_each_possible_cpu(cpu)
-		qcom_cpufreq_suspend_virt_devs(drv, cpu);
+		qcom_cpufreq_suspend_pd_devs(drv, cpu);
 
 	return 0;
 }
-- 
2.34.1


