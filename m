Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629362CB865
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 10:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbgLBJPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 04:15:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11492 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbgLBJPQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 04:15:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc75afc0000>; Wed, 02 Dec 2020 01:14:36 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 09:14:35 +0000
Received: from moonraker.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Dec 2020 09:14:33 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/4] cpufreq: tegra186: Fix sparse 'incorrect type in assignment' warning
Date:   Wed, 2 Dec 2020 09:14:16 +0000
Message-ID: <20201202091419.307192-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202091419.307192-1-jonathanh@nvidia.com>
References: <20201202091419.307192-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606900476; bh=rDHwvdixeWVuXBgVI8gIlWkmg2C+zDn3XtJjk9Rlc+U=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=EG8IO6nSQHb3gW7HsRU3gukjn2Hi2j2Kcl922MiAhtJ3A6c59g0EC2dXonqzGJw0r
         g+Zhbq2UlZjwlYR2vJZ2/JQ1jeg6JOzXtVJZ095DqEijuVsWy20yGNVKyPLZq8Rs0J
         fO3QFdNbdEPXh+e27SqiQ8+rNe8oEh4MA4KX78hgicP1pBL/ID42WMyOQ3NRO6tGin
         5Bauk0ioHgmSn4If9G/Wsxs/lZYT894vN6XZhXr9ufRFSpouWeBw0SciEDPK/oi35S
         bqiUCFzxd8H4MPjJ7cvMT4FUxxgZ3NpUBDrMbUFv7a3ds8oB0icJQhP3z3+g6AgXzk
         lFURsBglOaIYg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sparse warns that the incorrect type is being assigned to the CPUFREQ
driver_data variable in the Tegra186 CPUFREQ driver. The Tegra186
CPUFREQ driver is assigned a type of 'void __iomem *' to a pointer of
type 'void *' ...

 drivers/cpufreq/tegra186-cpufreq.c:72:37: sparse: sparse: incorrect
 	type in assignment (different address spaces) @@
	expected void *driver_data @@     got void [noderef] __iomem * @@
 ...

 drivers/cpufreq/tegra186-cpufreq.c:87:40: sparse: sparse: incorrect
 	type in initializer (different address spaces) @@
	expected void [noderef] __iomem *edvd_reg @@     got void *driver_data @@

The Tegra186 CPUFREQ driver is using the policy->driver_data variable to
store and iomem pointer to a Tegra186 CPU register that is used to set
the clock speed for the CPU. This is not necessary because the register
base address is already stored in the driver data and the offset of the
register for each CPU is static. Therefore, fix this by adding a new
structure with the register offsets for each CPU and store this in the
main driver data structure along with the register base address. Please
note that a new structure has been added for storing the register
offsets rather than a simple array, because this will permit further
clean-ups and simplification of the driver.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 61 ++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-=
cpufreq.c
index 7eb2c56c65de..98b5f32eb0be 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -12,13 +12,45 @@
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
=20
-#define EDVD_CORE_VOLT_FREQ(core)		(0x20 + (core) * 0x4)
-#define EDVD_CORE_VOLT_FREQ_F_SHIFT		0
-#define EDVD_CORE_VOLT_FREQ_F_MASK		0xffff
-#define EDVD_CORE_VOLT_FREQ_V_SHIFT		16
+#define EDVD_OFFSET_A57(core)		((SZ_64K * 6) + (0x20 + (core) * 0x4))
+#define EDVD_OFFSET_DENVER(core)	((SZ_64K * 7) + (0x20 + (core) * 0x4))
+#define EDVD_CORE_VOLT_FREQ_F_SHIFT	0
+#define EDVD_CORE_VOLT_FREQ_F_MASK	0xffff
+#define EDVD_CORE_VOLT_FREQ_V_SHIFT	16
+
+struct tegra186_cpufreq_cpu {
+	unsigned int edvd_offset;
+};
+
+static const struct tegra186_cpufreq_cpu tegra186_cpus[] =3D {
+	/* CPU0 - A57 Cluster */
+	{
+		.edvd_offset =3D EDVD_OFFSET_A57(0)
+	},
+	/* CPU1 - Denver Cluster */
+	{
+		.edvd_offset =3D EDVD_OFFSET_DENVER(0)
+	},
+	/* CPU2 - Denver Cluster */
+	{
+		.edvd_offset =3D EDVD_OFFSET_DENVER(1)
+	},
+	/* CPU3 - A57 Cluster */
+	{
+		.edvd_offset =3D EDVD_OFFSET_A57(1)
+	},
+	/* CPU4 - A57 Cluster */
+	{
+		.edvd_offset =3D EDVD_OFFSET_A57(2)
+	},
+	/* CPU5 - A57 Cluster */
+	{
+		.edvd_offset =3D EDVD_OFFSET_A57(3)
+	},
+
+};
=20
 struct tegra186_cpufreq_cluster_info {
-	unsigned long offset;
 	int cpus[4];
 	unsigned int bpmp_cluster_id;
 };
@@ -27,13 +59,11 @@ struct tegra186_cpufreq_cluster_info {
 static const struct tegra186_cpufreq_cluster_info tegra186_clusters[] =3D =
{
 	/* Denver cluster */
 	{
-		.offset =3D SZ_64K * 7,
 		.cpus =3D { 1, 2, NO_CPU, NO_CPU },
 		.bpmp_cluster_id =3D 0,
 	},
 	/* A57 cluster */
 	{
-		.offset =3D SZ_64K * 6,
 		.cpus =3D { 0, 3, 4, 5 },
 		.bpmp_cluster_id =3D 1,
 	},
@@ -51,6 +81,7 @@ struct tegra186_cpufreq_data {
=20
 	size_t num_clusters;
 	struct tegra186_cpufreq_cluster *clusters;
+	const struct tegra186_cpufreq_cpu *cpus;
 };
=20
 static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
@@ -71,13 +102,12 @@ static int tegra186_cpufreq_init(struct cpufreq_policy=
 *policy)
 		if (core =3D=3D ARRAY_SIZE(info->cpus))
 			continue;
=20
-		policy->driver_data =3D
-			data->regs + info->offset + EDVD_CORE_VOLT_FREQ(core);
 		policy->freq_table =3D cluster->table;
 		break;
 	}
=20
 	policy->cpuinfo.transition_latency =3D 300 * 1000;
+	policy->driver_data =3D NULL;
=20
 	return 0;
 }
@@ -85,11 +115,12 @@ static int tegra186_cpufreq_init(struct cpufreq_policy=
 *policy)
 static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
+	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
 	struct cpufreq_frequency_table *tbl =3D policy->freq_table + index;
-	void __iomem *edvd_reg =3D policy->driver_data;
+	unsigned int edvd_offset =3D data->cpus[policy->cpu].edvd_offset;
 	u32 edvd_val =3D tbl->driver_data;
=20
-	writel(edvd_val, edvd_reg);
+	writel(edvd_val, data->regs + edvd_offset);
=20
 	return 0;
 }
@@ -98,16 +129,15 @@ static unsigned int tegra186_cpufreq_get(unsigned int =
cpu)
 {
 	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
 	struct cpufreq_policy *policy;
-	void __iomem *edvd_reg;
-	unsigned int i, freq =3D 0;
+	unsigned int i, edvd_offset, freq =3D 0;
 	u32 ndiv;
=20
 	policy =3D cpufreq_cpu_get(cpu);
 	if (!policy)
 		return 0;
=20
-	edvd_reg =3D policy->driver_data;
-	ndiv =3D readl(edvd_reg) & EDVD_CORE_VOLT_FREQ_F_MASK;
+	edvd_offset =3D data->cpus[policy->cpu].edvd_offset;
+	ndiv =3D readl(data->regs + edvd_offset) & EDVD_CORE_VOLT_FREQ_F_MASK;
=20
 	for (i =3D 0; i < data->num_clusters; i++) {
 		struct tegra186_cpufreq_cluster *cluster =3D &data->clusters[i];
@@ -240,6 +270,7 @@ static int tegra186_cpufreq_probe(struct platform_devic=
e *pdev)
 		return -ENOMEM;
=20
 	data->num_clusters =3D ARRAY_SIZE(tegra186_clusters);
+	data->cpus =3D tegra186_cpus;
=20
 	bpmp =3D tegra_bpmp_get(&pdev->dev);
 	if (IS_ERR(bpmp))
--=20
2.25.1

