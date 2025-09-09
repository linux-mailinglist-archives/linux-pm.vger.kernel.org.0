Return-Path: <linux-pm+bounces-34215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B1CB4A400
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FBA541F86
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FC30C611;
	Tue,  9 Sep 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMwbF2j9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F93081D4;
	Tue,  9 Sep 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403592; cv=none; b=JHQ65cWqQS7o5Rmu6uOvHLbUx+xhHHteknE4ednq7dyvSyHs0D6KBlK3RZAFkzlpLggBDlWHCsC6wXUGN36VyHs/NiHdoKOzp4xgvvrd6mkq8t7qX3XAXaZEOd1jTOAlAKrQY+Y78iYNrrF/dIP/cF9fLSsWNyTK+5eFQc/xG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403592; c=relaxed/simple;
	bh=Ga5Cr0dJ0wmB7/q61wksi9ORqCdh01tkjlQ464HQdvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0n6rNqtCLMztTWt2sHHFmuGCVOTp3KYAc9u8AwIPxRsFHq3pYX0gPY+qNT8i7zuhrdkqzzvhU0/JEdMpiE8a+NvZ5kvH0RsLnQfnhBaqBgfggwuS4e2fIZ+ZM0b8XynOlPqIfnP/lH81yRfbRYxvskQEH/ONikkiA1xVNcBo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMwbF2j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2934BC4CEF4;
	Tue,  9 Sep 2025 07:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757403592;
	bh=Ga5Cr0dJ0wmB7/q61wksi9ORqCdh01tkjlQ464HQdvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=AMwbF2j9Mv2qr3wKfOwaADzJdd6ZO/t+yoApsbrDeLGuercUd/Y0aUIdeB+9Mf3nH
	 jZnLsBYD7i95pQB8xbcGfk7xVCGmYDPW81WMjFLQOUNcQiukTdojSbJr34kWl6dKkW
	 xnaz9ZpKtDG56GEdjOCLESx5aW4iEja3Mc5iF8Tww8+9ZF219i1rXEFamyrS01CI/n
	 gfyF8a2ld+Wv1D0pcbkOKl+Tc9pz6R6rLL+BQaR/lhlWpxifo6164NXr8r+E3fjK8S
	 xzma5Xwfs9kO7gUjzHWd1Jj1pMG0cDRO9q2okMg3ocEhJx5rwGZK6hm8N8C8SxV2L3
	 b9dfm7uRmifMw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvsxA-000000006bN-46IF;
	Tue, 09 Sep 2025 09:39:49 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH] cpufreq: mediatek: fix device leak on probe failure
Date: Tue,  9 Sep 2025 09:38:19 +0200
Message-ID: <20250909073819.25295-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the cci device taken by
of_find_device_by_node() on probe failure (e.g. probe deferral).

Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
Cc: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Cc: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index f3f02c4b6888..21537a05785d 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -404,9 +404,11 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	}
 
 	info->cpu_clk = clk_get(cpu_dev, "cpu");
-	if (IS_ERR(info->cpu_clk))
-		return dev_err_probe(cpu_dev, PTR_ERR(info->cpu_clk),
-				     "cpu%d: failed to get cpu clk\n", cpu);
+	if (IS_ERR(info->cpu_clk)) {
+		ret = PTR_ERR(info->cpu_clk);
+		dev_err_probe(cpu_dev, ret, "cpu%d: failed to get cpu clk\n", cpu);
+		goto out_put_cci_dev;
+	}
 
 	info->inter_clk = clk_get(cpu_dev, "intermediate");
 	if (IS_ERR(info->inter_clk)) {
@@ -552,6 +554,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 out_free_mux_clock:
 	clk_put(info->cpu_clk);
 
+out_put_cci_dev:
+	if (info->soc_data->ccifreq_supported)
+		put_device(info->cci_dev);
+
 	return ret;
 }
 
@@ -569,6 +575,8 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 	clk_put(info->inter_clk);
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 	dev_pm_opp_unregister_notifier(info->cpu_dev, &info->opp_nb);
+	if (info->soc_data->ccifreq_supported)
+		put_device(info->cci_dev);
 }
 
 static int mtk_cpufreq_init(struct cpufreq_policy *policy)
-- 
2.49.1


