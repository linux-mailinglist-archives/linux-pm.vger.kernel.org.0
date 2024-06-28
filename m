Return-Path: <linux-pm+bounces-10217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889A691C6D7
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D992285EA4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A9E76048;
	Fri, 28 Jun 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VdelCPIu"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628C7581A;
	Fri, 28 Jun 2024 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604115; cv=none; b=Cq0qg7o2ev0fMXK8zQpHHQvlAJTAk7zdffD346tUqYU9RXzTR1DwAzIGmDSIuyT+Ihj4WpZbksrarDH8BvAca3vmySi/irXXgNiFqzgI7llgKCcTkYRqepCp7Wp9LDJR58Xhu+YBItAK35oy1lo5VfBj4i2kBHeUCQ2tJDANYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604115; c=relaxed/simple;
	bh=paO3Q85MhNCJaXdzxnipweZ72m9WbwKAh6xyx8Yrj2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aXD8Yon2f0hiHvClaNcM5ZXdxJlelvHPdvo4S4LCYuHDqp/uANT1hpD5tW4loa3PJb40AdwqhFV0OcWuTuwUMf0sG03tTJt0/vcVd8lAQjr4dakmYvr9pUJ/H9+RYrPjW7mippw2h56HxT7IB8yI+5YeKuC25Hy8kpdW820nSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VdelCPIu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719604111;
	bh=paO3Q85MhNCJaXdzxnipweZ72m9WbwKAh6xyx8Yrj2k=;
	h=From:Date:Subject:To:Cc:From;
	b=VdelCPIu23TTul7DOTm/ObQnaDsLxrwtLUVnUecVFnTMw5MGFAapqd4180iLJkYVz
	 DfY8bCjNYRsxSgw+71MAZSoDxMBhcYv7foDLTIMckQJq2kCk4HCugpc8lPyx7c9dMY
	 n8ft00UMEOsFmwU7U7qrAAHxfZ0BI4+Zqn7oTxxksN05HylSlEpIWGqWvcrhllwBQu
	 p+pPsRp80ygruO/hDwASjbV5ciCCI+wxRca00g4ovQtbVYJDAtsNAAwcH1VJuLvyYm
	 Z0j0B1cDweXmA4hsq54tSlqoNnJ/7N/NLL0GX0mjpuRD0NKIFN7XbdK1WLD404EwGI
	 sjJpSDjzDi78Q==
Received: from [192.168.1.175] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A0F37378219E;
	Fri, 28 Jun 2024 19:48:29 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 28 Jun 2024 15:48:23 -0400
Subject: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
X-B4-Tracking: v=1; b=H4sIAIYTf2YC/x3NQQqDMBBA0avIrB2IgyTQq4iLkEzaoW3UiQZBv
 HtDl2/z/wWFVbjAo7tAuUqRJTcMfQfh5fOTUWIzkKHRWHL43d8Y1iMpbxhrKpi8fFCy7MiqaLy
 1FLyjyAQtsionOf+Dab7vHxN1UZdwAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Use the dev_err_probe() helper to log the errors on every error path in
the probe function and its sub-functions. This includes
* adding error messages where there was none
* converting over dev_err/dev_warn
* removing the top-level error message after mtk_cpu_dvfs_info_init() is
  called, since every error path inside that function already logs the
  error reason. This gets rid of the misleading error message when probe
  is deferred:

    mtk-cpufreq mtk-cpufreq: failed to initialize dvfs info for cpu0

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 66 ++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 518606adf14e..b21425bb83be 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -390,28 +390,23 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	int ret;
 
 	cpu_dev = get_cpu_device(cpu);
-	if (!cpu_dev) {
-		dev_err(cpu_dev, "failed to get cpu%d device\n", cpu);
-		return -ENODEV;
-	}
+	if (!cpu_dev)
+		return dev_err_probe(cpu_dev, -ENODEV, "failed to get cpu%d device\n", cpu);
 	info->cpu_dev = cpu_dev;
 
 	info->ccifreq_bound = false;
 	if (info->soc_data->ccifreq_supported) {
 		info->cci_dev = of_get_cci(info->cpu_dev);
-		if (IS_ERR(info->cci_dev)) {
-			ret = PTR_ERR(info->cci_dev);
-			dev_err(cpu_dev, "cpu%d: failed to get cci device\n", cpu);
-			return -ENODEV;
-		}
+		if (IS_ERR(info->cci_dev))
+			return dev_err_probe(cpu_dev, PTR_ERR(info->cci_dev),
+					     "cpu%d: failed to get cci device\n",
+					     cpu);
 	}
 
 	info->cpu_clk = clk_get(cpu_dev, "cpu");
-	if (IS_ERR(info->cpu_clk)) {
-		ret = PTR_ERR(info->cpu_clk);
-		return dev_err_probe(cpu_dev, ret,
+	if (IS_ERR(info->cpu_clk))
+		return dev_err_probe(cpu_dev, PTR_ERR(info->cpu_clk),
 				     "cpu%d: failed to get cpu clk\n", cpu);
-	}
 
 	info->inter_clk = clk_get(cpu_dev, "intermediate");
 	if (IS_ERR(info->inter_clk)) {
@@ -431,7 +426,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 
 	ret = regulator_enable(info->proc_reg);
 	if (ret) {
-		dev_warn(cpu_dev, "cpu%d: failed to enable vproc\n", cpu);
+		dev_err_probe(cpu_dev, ret, "cpu%d: failed to enable vproc\n", cpu);
 		goto out_free_proc_reg;
 	}
 
@@ -439,14 +434,17 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	info->sram_reg = regulator_get_optional(cpu_dev, "sram");
 	if (IS_ERR(info->sram_reg)) {
 		ret = PTR_ERR(info->sram_reg);
-		if (ret == -EPROBE_DEFER)
+		if (ret == -EPROBE_DEFER) {
+			dev_err_probe(cpu_dev, ret,
+				      "cpu%d: Failed to get sram regulator\n", cpu);
 			goto out_disable_proc_reg;
+		}
 
 		info->sram_reg = NULL;
 	} else {
 		ret = regulator_enable(info->sram_reg);
 		if (ret) {
-			dev_warn(cpu_dev, "cpu%d: failed to enable vsram\n", cpu);
+			dev_err_probe(cpu_dev, ret, "cpu%d: failed to enable vsram\n", cpu);
 			goto out_free_sram_reg;
 		}
 	}
@@ -454,31 +452,34 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &info->cpus);
 	if (ret) {
-		dev_err(cpu_dev,
+		dev_err_probe(cpu_dev, ret,
 			"cpu%d: failed to get OPP-sharing information\n", cpu);
 		goto out_disable_sram_reg;
 	}
 
 	ret = dev_pm_opp_of_cpumask_add_table(&info->cpus);
 	if (ret) {
-		dev_warn(cpu_dev, "cpu%d: no OPP table\n", cpu);
+		dev_err_probe(cpu_dev, ret, "cpu%d: no OPP table\n", cpu);
 		goto out_disable_sram_reg;
 	}
 
 	ret = clk_prepare_enable(info->cpu_clk);
-	if (ret)
+	if (ret) {
+		dev_err_probe(cpu_dev, ret, "cpu%d: failed to enable cpu clk\n", cpu);
 		goto out_free_opp_table;
+	}
 
 	ret = clk_prepare_enable(info->inter_clk);
-	if (ret)
+	if (ret) {
+		dev_err_probe(cpu_dev, ret, "cpu%d: failed to enable inter clk\n", cpu);
 		goto out_disable_mux_clock;
+	}
 
 	if (info->soc_data->ccifreq_supported) {
 		info->vproc_on_boot = regulator_get_voltage(info->proc_reg);
 		if (info->vproc_on_boot < 0) {
 			ret = info->vproc_on_boot;
-			dev_err(info->cpu_dev,
-				"invalid Vproc value: %d\n", info->vproc_on_boot);
+			dev_err_probe(info->cpu_dev, ret, "invalid Vproc value\n");
 			goto out_disable_inter_clock;
 		}
 	}
@@ -487,7 +488,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	rate = clk_get_rate(info->inter_clk);
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
 	if (IS_ERR(opp)) {
-		dev_err(cpu_dev, "cpu%d: failed to get intermediate opp\n", cpu);
+		dev_err_probe(cpu_dev, ret, "cpu%d: failed to get intermediate opp\n", cpu);
 		ret = PTR_ERR(opp);
 		goto out_disable_inter_clock;
 	}
@@ -501,7 +502,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
 	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);
 	if (ret) {
-		dev_err(cpu_dev, "cpu%d: failed to register opp notifier\n", cpu);
+		dev_err_probe(cpu_dev, ret, "cpu%d: failed to register opp notifier\n", cpu);
 		goto out_disable_inter_clock;
 	}
 
@@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 	int cpu, ret;
 
 	data = dev_get_platdata(&pdev->dev);
-	if (!data) {
-		dev_err(&pdev->dev,
-			"failed to get mtk cpufreq platform data\n");
-		return -ENODEV;
-	}
+	if (!data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to get mtk cpufreq platform data\n");
 
 	for_each_possible_cpu(cpu) {
 		info = mtk_cpu_dvfs_info_lookup(cpu);
@@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			ret = -ENOMEM;
+			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");
 			goto release_dvfs_info_list;
 		}
 
 		info->soc_data = data;
 		ret = mtk_cpu_dvfs_info_init(info, cpu);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to initialize dvfs info for cpu%d\n",
-				cpu);
+		if (ret)
 			goto release_dvfs_info_list;
-		}
 
 		list_add(&info->list_head, &dvfs_info_list);
 	}
 
 	ret = cpufreq_register_driver(&mtk_cpufreq_driver);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register mtk cpufreq driver\n");
+		dev_err_probe(&pdev->dev, ret, "failed to register mtk cpufreq driver\n");
 		goto release_dvfs_info_list;
 	}
 

---
base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
change-id: 20240627-mtk-cpufreq-dvfs-fail-init-err-0a662ca72de2

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


