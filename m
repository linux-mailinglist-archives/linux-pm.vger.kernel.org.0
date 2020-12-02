Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19542CB86A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 10:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgLBJPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 04:15:21 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11497 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbgLBJPU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 04:15:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc75b000001>; Wed, 02 Dec 2020 01:14:40 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 09:14:40 +0000
Received: from moonraker.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Dec 2020 09:14:38 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 3/4] cpufreq: tegra194: Remove unnecessary frequency calculation
Date:   Wed, 2 Dec 2020 09:14:18 +0000
Message-ID: <20201202091419.307192-4-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202091419.307192-1-jonathanh@nvidia.com>
References: <20201202091419.307192-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606900480; bh=IIOwydvHQGBQsUl10GTUpD6i84b6O4uOJA62idcOqfM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=UG5XlU/I37/BRSYzl4sOsuv3z5QZs1qq4HNgVJFxYLC+xBoV4PLQwsN5qSX1runGc
         buXruJ9eNLUmJODmT++YC0AyFLV/Ufd9qHZQlOxiPJj1+Qon2TodzxjYYxqomXrLUk
         RlKNbacorD5llMXHWh/cS9tkfcfhnrIDIvqbMtkA5ZyPcBUsfp1Wb2OMBUzy6mFg+Q
         FMm2hMLfaUskQhARdm+Q/fx7P13vDp6wVFHr0xylcUT0qGWGvrL2mcSnxM0R40RSLY
         aNt1daC797IwDazCxlkZTFypa6lYuc38bni7tA4C4nnw5CVsHXynlTRjII37jD5DXo
         bzGf986WEaThw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra194 CPUFREQ driver sets the CPUFREQ_NEED_INITIAL_FREQ_CHECK
flag which means that the CPUFREQ framework will call the 'get' callback
on boot to determine the current frequency of the CPUs. Therefore, it is
not necessary for the Tegra194 CPUFREQ driver to internally call the
tegra194_get_speed_common() during initialisation to query the current
frequency as well. Fix this by removing the call to the
tegra194_get_speed_common() during initialisation and simplify the code.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-=
cpufreq.c
index 79015875f346..a706ba929424 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -21,7 +21,6 @@
 #define KHZ                     1000
 #define REF_CLK_MHZ             408 /* 408 MHz */
 #define US_DELAY                500
-#define US_DELAY_MIN            2
 #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
 #define MAX_CNT                 ~0U
=20
@@ -44,7 +43,6 @@ struct tegra194_cpufreq_data {
=20
 struct tegra_cpu_ctr {
 	u32 cpu;
-	u32 delay;
 	u32 coreclk_cnt, last_coreclk_cnt;
 	u32 refclk_cnt, last_refclk_cnt;
 };
@@ -112,7 +110,7 @@ static void tegra_read_counters(struct work_struct *wor=
k)
 	val =3D read_freq_feedback();
 	c->last_refclk_cnt =3D lower_32_bits(val);
 	c->last_coreclk_cnt =3D upper_32_bits(val);
-	udelay(c->delay);
+	udelay(US_DELAY);
 	val =3D read_freq_feedback();
 	c->refclk_cnt =3D lower_32_bits(val);
 	c->coreclk_cnt =3D upper_32_bits(val);
@@ -139,7 +137,7 @@ static void tegra_read_counters(struct work_struct *wor=
k)
  * @cpu - logical cpu whose freq to be updated
  * Returns freq in KHz on success, 0 if cpu is offline
  */
-static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
+static unsigned int tegra194_get_speed_common(u32 cpu)
 {
 	struct read_counters_work read_counters_work;
 	struct tegra_cpu_ctr c;
@@ -153,7 +151,6 @@ static unsigned int tegra194_get_speed_common(u32 cpu, =
u32 delay)
 	 * interrupts enabled.
 	 */
 	read_counters_work.c.cpu =3D cpu;
-	read_counters_work.c.delay =3D delay;
 	INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
 	queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
 	flush_work(&read_counters_work.work);
@@ -209,7 +206,7 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
=20
 	/* reconstruct actual cpu freq using counters */
-	rate =3D tegra194_get_speed_common(cpu, US_DELAY);
+	rate =3D tegra194_get_speed_common(cpu);
=20
 	/* get last written ndiv value */
 	ret =3D smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
@@ -248,9 +245,6 @@ static int tegra194_cpufreq_init(struct cpufreq_policy =
*policy)
 	if (cl >=3D data->num_clusters)
 		return -EINVAL;
=20
-	/* boot freq */
-	policy->cur =3D tegra194_get_speed_common(policy->cpu, US_DELAY_MIN);
-
 	/* set same policy for all cpus in a cluster */
 	for (cpu =3D (cl * 2); cpu < ((cl + 1) * 2); cpu++)
 		cpumask_set_cpu(cpu, policy->cpus);
--=20
2.25.1

