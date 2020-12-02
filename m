Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8908D2CB86C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 10:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgLBJPy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 04:15:54 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11563 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387755AbgLBJPy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 04:15:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc75b020000>; Wed, 02 Dec 2020 01:14:42 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 09:14:42 +0000
Received: from moonraker.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Dec 2020 09:14:40 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4/4] cpufreq: tegra194: Rename tegra194_get_speed_common function
Date:   Wed, 2 Dec 2020 09:14:19 +0000
Message-ID: <20201202091419.307192-5-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202091419.307192-1-jonathanh@nvidia.com>
References: <20201202091419.307192-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606900482; bh=S8sJJMoQpyzSm2gQKsnuGora2uy6mUIWNJQuzPmFQqk=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=laPZy85I7Cdd2CB8DCAOXWVuNop35dgr7a2LLpT9X056I0HfG1Q1D6pExk58J4mTZ
         sEg7i87a28P120ORHRQhAaNrlmlWhh154yBrSWPxJV6ozwxskqYhEVslBjLnBZtFgc
         6KtWnXY8aRbQYADy0YpjBf4adWxepYRQc7JdOrJiiy5/22CNChHZ8nqKmbe85gV5E0
         pmwwpEzyGDlqbCWXr1dB3NDKRvz3Uc5wZwoPww/0pKuz99ORvOatPUATxGV60nswVt
         iH85DATGzD985xc9EHD6LaSWWzeOlX+GP9VCFZU2cNhJ9Gh9jQEbZRAvaD8TMB1QMF
         kVOQD4vLEop3w==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function tegra194_get_speed_common() uses hardware timers to
calculate the current CPUFREQ and so rename this function to be
tegra194_calculate_speed() to reflect what it does.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-=
cpufreq.c
index a706ba929424..6a67f36f3b80 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -137,7 +137,7 @@ static void tegra_read_counters(struct work_struct *wor=
k)
  * @cpu - logical cpu whose freq to be updated
  * Returns freq in KHz on success, 0 if cpu is offline
  */
-static unsigned int tegra194_get_speed_common(u32 cpu)
+static unsigned int tegra194_calculate_speed(u32 cpu)
 {
 	struct read_counters_work read_counters_work;
 	struct tegra_cpu_ctr c;
@@ -206,7 +206,7 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
=20
 	/* reconstruct actual cpu freq using counters */
-	rate =3D tegra194_get_speed_common(cpu);
+	rate =3D tegra194_calculate_speed(cpu);
=20
 	/* get last written ndiv value */
 	ret =3D smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
--=20
2.25.1

