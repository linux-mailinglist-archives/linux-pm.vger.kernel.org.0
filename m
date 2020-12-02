Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6DD2CB867
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 10:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgLBJPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 04:15:19 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14450 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388113AbgLBJPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 04:15:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc75afe0000>; Wed, 02 Dec 2020 01:14:38 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 09:14:38 +0000
Received: from moonraker.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Dec 2020 09:14:36 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/4] cpufreq: tegra186: Simplify cluster information lookup
Date:   Wed, 2 Dec 2020 09:14:17 +0000
Message-ID: <20201202091419.307192-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202091419.307192-1-jonathanh@nvidia.com>
References: <20201202091419.307192-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606900478; bh=uI21NQ7JlylRAxWbg5pP4myRc1s7fFIpA6E+rzDNIuM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=IjEUYh9pHDYj6XS1VkW+XCMDuYt5Etd2XZepudOzUNJY5dtCDHYO9jBr8DCb3Mt8w
         b0Gw/eEyrstrF43/I8uL77DclLanhxLZ5i+++18ulZCljk2XM5TJlPNtMwZCEUWOmH
         KfRb3Wd9/dXnjTal+0f3O8fpKwgAYewxhGShrJEMVcS2T3rchcggukFAk/RjQCKF1+
         6VncT+eaGImn+2I7NDWys64LW4dB0fUBaN+mZoGeaa6d5JrT1bkrK7/ffx2GMuGhC4
         GFpcXWsQkhDX7HDV5G7HI0mv8+9irpY0/jPro6oopjZdYE8IKvZDvV+sBJo5IjzSpQ
         +SS6g9aJkU2gg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPUFREQ driver framework references each individual CPUs when
getting and setting the speed. Tegra186 has 3 clusters of A57 CPUs and
1 cluster of Denver CPUs. Hence, the Tegra186 CPUFREQ driver need to
know which cluster a given CPU belongs to. The logic in the Tegra186
driver can be greatly simplified by storing the cluster ID associated
with each CPU in the tegra186_cpufreq_cpu structure. This allow us to
completely remove the Tegra cluster info structure from the driver and
simplifiy the code.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 85 +++++++-----------------------
 1 file changed, 20 insertions(+), 65 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-=
cpufreq.c
index 98b5f32eb0be..e566ea298b59 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -12,6 +12,7 @@
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
=20
+#define TEGRA186_NUM_CLUSTERS		2
 #define EDVD_OFFSET_A57(core)		((SZ_64K * 6) + (0x20 + (core) * 0x4))
 #define EDVD_OFFSET_DENVER(core)	((SZ_64K * 7) + (0x20 + (core) * 0x4))
 #define EDVD_CORE_VOLT_FREQ_F_SHIFT	0
@@ -19,58 +20,44 @@
 #define EDVD_CORE_VOLT_FREQ_V_SHIFT	16
=20
 struct tegra186_cpufreq_cpu {
+	unsigned int bpmp_cluster_id;
 	unsigned int edvd_offset;
 };
=20
 static const struct tegra186_cpufreq_cpu tegra186_cpus[] =3D {
 	/* CPU0 - A57 Cluster */
 	{
+		.bpmp_cluster_id =3D 1,
 		.edvd_offset =3D EDVD_OFFSET_A57(0)
 	},
 	/* CPU1 - Denver Cluster */
 	{
+		.bpmp_cluster_id =3D 0,
 		.edvd_offset =3D EDVD_OFFSET_DENVER(0)
 	},
 	/* CPU2 - Denver Cluster */
 	{
+		.bpmp_cluster_id =3D 0,
 		.edvd_offset =3D EDVD_OFFSET_DENVER(1)
 	},
 	/* CPU3 - A57 Cluster */
 	{
+		.bpmp_cluster_id =3D 1,
 		.edvd_offset =3D EDVD_OFFSET_A57(1)
 	},
 	/* CPU4 - A57 Cluster */
 	{
+		.bpmp_cluster_id =3D 1,
 		.edvd_offset =3D EDVD_OFFSET_A57(2)
 	},
 	/* CPU5 - A57 Cluster */
 	{
-		.edvd_offset =3D EDVD_OFFSET_A57(3)
-	},
-
-};
-
-struct tegra186_cpufreq_cluster_info {
-	int cpus[4];
-	unsigned int bpmp_cluster_id;
-};
-
-#define NO_CPU -1
-static const struct tegra186_cpufreq_cluster_info tegra186_clusters[] =3D =
{
-	/* Denver cluster */
-	{
-		.cpus =3D { 1, 2, NO_CPU, NO_CPU },
-		.bpmp_cluster_id =3D 0,
-	},
-	/* A57 cluster */
-	{
-		.cpus =3D { 0, 3, 4, 5 },
 		.bpmp_cluster_id =3D 1,
+		.edvd_offset =3D EDVD_OFFSET_A57(3)
 	},
 };
=20
 struct tegra186_cpufreq_cluster {
-	const struct tegra186_cpufreq_cluster_info *info;
 	struct cpufreq_frequency_table *table;
 	u32 ref_clk_khz;
 	u32 div;
@@ -78,8 +65,6 @@ struct tegra186_cpufreq_cluster {
=20
 struct tegra186_cpufreq_data {
 	void __iomem *regs;
-
-	size_t num_clusters;
 	struct tegra186_cpufreq_cluster *clusters;
 	const struct tegra186_cpufreq_cpu *cpus;
 };
@@ -87,25 +72,9 @@ struct tegra186_cpufreq_data {
 static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
-	unsigned int i;
-
-	for (i =3D 0; i < data->num_clusters; i++) {
-		struct tegra186_cpufreq_cluster *cluster =3D &data->clusters[i];
-		const struct tegra186_cpufreq_cluster_info *info =3D
-			cluster->info;
-		int core;
-
-		for (core =3D 0; core < ARRAY_SIZE(info->cpus); core++) {
-			if (info->cpus[core] =3D=3D policy->cpu)
-				break;
-		}
-		if (core =3D=3D ARRAY_SIZE(info->cpus))
-			continue;
-
-		policy->freq_table =3D cluster->table;
-		break;
-	}
+	unsigned int cluster =3D data->cpus[policy->cpu].bpmp_cluster_id;
=20
+	policy->freq_table =3D data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency =3D 300 * 1000;
 	policy->driver_data =3D NULL;
=20
@@ -128,8 +97,9 @@ static int tegra186_cpufreq_set_target(struct cpufreq_po=
licy *policy,
 static unsigned int tegra186_cpufreq_get(unsigned int cpu)
 {
 	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
+	struct tegra186_cpufreq_cluster *cluster;
 	struct cpufreq_policy *policy;
-	unsigned int i, edvd_offset, freq =3D 0;
+	unsigned int edvd_offset, cluster_id;
 	u32 ndiv;
=20
 	policy =3D cpufreq_cpu_get(cpu);
@@ -138,24 +108,11 @@ static unsigned int tegra186_cpufreq_get(unsigned int=
 cpu)
=20
 	edvd_offset =3D data->cpus[policy->cpu].edvd_offset;
 	ndiv =3D readl(data->regs + edvd_offset) & EDVD_CORE_VOLT_FREQ_F_MASK;
-
-	for (i =3D 0; i < data->num_clusters; i++) {
-		struct tegra186_cpufreq_cluster *cluster =3D &data->clusters[i];
-		int core;
-
-		for (core =3D 0; core < ARRAY_SIZE(cluster->info->cpus); core++) {
-			if (cluster->info->cpus[core] !=3D policy->cpu)
-				continue;
-
-			freq =3D (cluster->ref_clk_khz * ndiv) / cluster->div;
-			goto out;
-		}
-	}
-
-out:
+	cluster_id =3D data->cpus[policy->cpu].bpmp_cluster_id;
+	cluster =3D &data->clusters[cluster_id];
 	cpufreq_cpu_put(policy);
=20
-	return freq;
+	return (cluster->ref_clk_khz * ndiv) / cluster->div;
 }
=20
 static struct cpufreq_driver tegra186_cpufreq_driver =3D {
@@ -171,7 +128,7 @@ static struct cpufreq_driver tegra186_cpufreq_driver =
=3D {
=20
 static struct cpufreq_frequency_table *init_vhint_table(
 	struct platform_device *pdev, struct tegra_bpmp *bpmp,
-	struct tegra186_cpufreq_cluster *cluster)
+	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id)
 {
 	struct cpufreq_frequency_table *table;
 	struct mrq_cpu_vhint_request req;
@@ -190,7 +147,7 @@ static struct cpufreq_frequency_table *init_vhint_table=
(
=20
 	memset(&req, 0, sizeof(req));
 	req.addr =3D phys;
-	req.cluster_id =3D cluster->info->bpmp_cluster_id;
+	req.cluster_id =3D cluster_id;
=20
 	memset(&msg, 0, sizeof(msg));
 	msg.mrq =3D MRQ_CPU_VHINT;
@@ -264,12 +221,11 @@ static int tegra186_cpufreq_probe(struct platform_dev=
ice *pdev)
 	if (!data)
 		return -ENOMEM;
=20
-	data->clusters =3D devm_kcalloc(&pdev->dev, ARRAY_SIZE(tegra186_clusters)=
,
+	data->clusters =3D devm_kcalloc(&pdev->dev, TEGRA186_NUM_CLUSTERS,
 				      sizeof(*data->clusters), GFP_KERNEL);
 	if (!data->clusters)
 		return -ENOMEM;
=20
-	data->num_clusters =3D ARRAY_SIZE(tegra186_clusters);
 	data->cpus =3D tegra186_cpus;
=20
 	bpmp =3D tegra_bpmp_get(&pdev->dev);
@@ -282,11 +238,10 @@ static int tegra186_cpufreq_probe(struct platform_dev=
ice *pdev)
 		goto put_bpmp;
 	}
=20
-	for (i =3D 0; i < data->num_clusters; i++) {
+	for (i =3D 0; i < TEGRA186_NUM_CLUSTERS; i++) {
 		struct tegra186_cpufreq_cluster *cluster =3D &data->clusters[i];
=20
-		cluster->info =3D &tegra186_clusters[i];
-		cluster->table =3D init_vhint_table(pdev, bpmp, cluster);
+		cluster->table =3D init_vhint_table(pdev, bpmp, cluster, i);
 		if (IS_ERR(cluster->table)) {
 			err =3D PTR_ERR(cluster->table);
 			goto put_bpmp;
--=20
2.25.1

