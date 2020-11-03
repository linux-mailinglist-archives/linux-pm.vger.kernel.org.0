Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3E2A449A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 12:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgKCLz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 06:55:27 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15840 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKCLz1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 06:55:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa145320001>; Tue, 03 Nov 2020 03:55:30 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 11:55:26 +0000
Received: from localhost.localdomain (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Nov 2020 11:55:24 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Sumit Gupta" <sumitg@nvidia.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] cpufreq: tegra186: Fix get frequency callback
Date:   Tue, 3 Nov 2020 11:55:14 +0000
Message-ID: <20201103115514.547047-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604404530; bh=Jgcrm1yKr/dhNXDY5sGl6ABti97/ySxjfHG1SGRLdws=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=faNEFoQGlub74+pHAeDnUNWAqr/EVl4Kbp5oEqncVqFjWKsu9gL6KgGgcKbLVsTQ0
         Lrrxo+9TkrT1uAVTn26LVR4BGmzWzt+G6/zv40hoTze0MOIzT/VOUWBSIq2x9Fzy68
         bGySCq5l7xTZ4j1ngB7+Kb8fWZF7FkrG7TQuKwS3j/jqPRmb0AuJELA7dY3x7pGFYH
         YcAOFd0YPHXrXcAKNstzr5hxFO6pZMdulQnXrbI+5jKupSHHey0SOcsoZxHDrrC5k4
         Ijw0/lVjMwfkuS0SlBlvAzXJqVgG+uy5SF5Fk7G565SqoC4j3ziisaHdhIuxSJnVLr
         BalNuTaF5RQUw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")
implemented the CPUFREQ 'get' callback to determine the current
operating frequency for each CPU. This implementation used a simple
looked up to determine the current operating frequency. The problem
with this is that frequency table for different Tegra186 devices may
vary and so the default boot frequency for Tegra186 device may or may
not be present in the frequency table. If the default boot frequency is
not present in the frequency table, this causes the function
tegra186_cpufreq_get() to return 0 and in turn causes cpufreq_online()
to fail which prevents CPUFREQ from working.

Fix this by always calculating the CPU frequency based upon the current
'ndiv' setting for the CPU. Note that the CPU frequency for Tegra186 is
calculated by reading the current 'ndiv' setting, multiplying by the
CPU reference clock and dividing by a constant divisor.

Fixes: b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 33 +++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-=
cpufreq.c
index 4b4079f51559..7eb2c56c65de 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -42,6 +42,8 @@ static const struct tegra186_cpufreq_cluster_info tegra18=
6_clusters[] =3D {
 struct tegra186_cpufreq_cluster {
 	const struct tegra186_cpufreq_cluster_info *info;
 	struct cpufreq_frequency_table *table;
+	u32 ref_clk_khz;
+	u32 div;
 };
=20
 struct tegra186_cpufreq_data {
@@ -94,7 +96,7 @@ static int tegra186_cpufreq_set_target(struct cpufreq_pol=
icy *policy,
=20
 static unsigned int tegra186_cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_frequency_table *tbl;
+	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
 	struct cpufreq_policy *policy;
 	void __iomem *edvd_reg;
 	unsigned int i, freq =3D 0;
@@ -104,17 +106,23 @@ static unsigned int tegra186_cpufreq_get(unsigned int=
 cpu)
 	if (!policy)
 		return 0;
=20
-	tbl =3D policy->freq_table;
 	edvd_reg =3D policy->driver_data;
 	ndiv =3D readl(edvd_reg) & EDVD_CORE_VOLT_FREQ_F_MASK;
=20
-	for (i =3D 0; tbl[i].frequency !=3D CPUFREQ_TABLE_END; i++) {
-		if ((tbl[i].driver_data & EDVD_CORE_VOLT_FREQ_F_MASK) =3D=3D ndiv) {
-			freq =3D tbl[i].frequency;
-			break;
+	for (i =3D 0; i < data->num_clusters; i++) {
+		struct tegra186_cpufreq_cluster *cluster =3D &data->clusters[i];
+		int core;
+
+		for (core =3D 0; core < ARRAY_SIZE(cluster->info->cpus); core++) {
+			if (cluster->info->cpus[core] !=3D policy->cpu)
+				continue;
+
+			freq =3D (cluster->ref_clk_khz * ndiv) / cluster->div;
+			goto out;
 		}
 	}
=20
+out:
 	cpufreq_cpu_put(policy);
=20
 	return freq;
@@ -133,7 +141,7 @@ static struct cpufreq_driver tegra186_cpufreq_driver =
=3D {
=20
 static struct cpufreq_frequency_table *init_vhint_table(
 	struct platform_device *pdev, struct tegra_bpmp *bpmp,
-	unsigned int cluster_id)
+	struct tegra186_cpufreq_cluster *cluster)
 {
 	struct cpufreq_frequency_table *table;
 	struct mrq_cpu_vhint_request req;
@@ -152,7 +160,7 @@ static struct cpufreq_frequency_table *init_vhint_table=
(
=20
 	memset(&req, 0, sizeof(req));
 	req.addr =3D phys;
-	req.cluster_id =3D cluster_id;
+	req.cluster_id =3D cluster->info->bpmp_cluster_id;
=20
 	memset(&msg, 0, sizeof(msg));
 	msg.mrq =3D MRQ_CPU_VHINT;
@@ -185,6 +193,9 @@ static struct cpufreq_frequency_table *init_vhint_table=
(
 		goto free;
 	}
=20
+	cluster->ref_clk_khz =3D data->ref_clk_hz / 1000;
+	cluster->div =3D data->pdiv * data->mdiv;
+
 	for (i =3D data->vfloor, j =3D 0; i <=3D data->vceil; i++) {
 		struct cpufreq_frequency_table *point;
 		u16 ndiv =3D data->ndiv[i];
@@ -202,8 +213,7 @@ static struct cpufreq_frequency_table *init_vhint_table=
(
=20
 		point =3D &table[j++];
 		point->driver_data =3D edvd_val;
-		point->frequency =3D data->ref_clk_hz * ndiv / data->pdiv /
-			data->mdiv / 1000;
+		point->frequency =3D (cluster->ref_clk_khz * ndiv) / cluster->div;
 	}
=20
 	table[j].frequency =3D CPUFREQ_TABLE_END;
@@ -245,8 +255,7 @@ static int tegra186_cpufreq_probe(struct platform_devic=
e *pdev)
 		struct tegra186_cpufreq_cluster *cluster =3D &data->clusters[i];
=20
 		cluster->info =3D &tegra186_clusters[i];
-		cluster->table =3D init_vhint_table(
-			pdev, bpmp, cluster->info->bpmp_cluster_id);
+		cluster->table =3D init_vhint_table(pdev, bpmp, cluster);
 		if (IS_ERR(cluster->table)) {
 			err =3D PTR_ERR(cluster->table);
 			goto put_bpmp;
--=20
2.25.1

