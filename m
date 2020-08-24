Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BC250049
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHXO7R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 10:59:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18555 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXO7Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 10:59:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43d5860000>; Mon, 24 Aug 2020 07:58:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 07:59:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 07:59:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 14:59:15 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Aug 2020 14:59:15 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.74.138]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f43d5c10000>; Mon, 24 Aug 2020 07:59:14 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2] cpufreq: tegra186: Fix initial frequency
Date:   Mon, 24 Aug 2020 15:59:07 +0100
Message-ID: <20200824145907.331899-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598281094; bh=EmuB4is9VINRVTLC+GeQuqGP2D8AcHAOKBPg4Mi7SQ8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=i0RiXfl0RArXB2ERXcAAdV5/PXOm5Z4aMm/cu0PkFOxYwalCltIQ8oT4iUQjDPynX
         wL/O9yF2f+Sy0x1N5XMNi4zBpCzScvZnAobQcQIt6Q47/lFP3u6NuHlqyxHII8tozM
         7wc2cw7NQmp97/krVV0P/0VYa+R3pA9QQ67k2OrCKu4kkt9LYruTsdgWvsDJqzBzbE
         Klysni5Ia7QhVfdzz9aNOgYn92scUyi3rZQCDAouQnSrmcAUXTTWdRgAe07wnXoo+a
         k+drvz9EGxx84N8ETxupW9lWqS3Qk9fjPFqU20FRGa6XFF3Ldi96hWgrazt5fUJ4W8
         tcBwv4HModW3g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 6cc3d0e9a097 ("cpufreq: tegra186: add
CPUFREQ_NEED_INITIAL_FREQ_CHECK flag") fixed CPUFREQ support for
Tegra186 but as a consequence the following warnings are now seen on
boot ...

 cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 2035=
200 KHz
 cpufreq: cpufreq_online: CPU1: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU1: Unlisted initial frequency changed to: 2035=
200 KHz
 cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 2035=
200 KHz
 cpufreq: cpufreq_online: CPU3: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU3: Unlisted initial frequency changed to: 2035=
200 KHz
 cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 2035=
200 KHz
 cpufreq: cpufreq_online: CPU5: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU5: Unlisted initial frequency changed to: 2035=
200 KHz

Fix this by adding a 'get' callback for the Tegra186 CPUFREQ driver to
retrieve the current operating frequency for a given CPU. The 'get'
callback uses the current 'ndiv' value that is programmed to determine
that current operating frequency.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1:
- Moved code into a 'get' callback

 drivers/cpufreq/tegra186-cpufreq.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-=
cpufreq.c
index 01e1f58ba422..0d0fcff60765 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -14,6 +14,7 @@
=20
 #define EDVD_CORE_VOLT_FREQ(core)		(0x20 + (core) * 0x4)
 #define EDVD_CORE_VOLT_FREQ_F_SHIFT		0
+#define EDVD_CORE_VOLT_FREQ_F_MASK		0xffff
 #define EDVD_CORE_VOLT_FREQ_V_SHIFT		16
=20
 struct tegra186_cpufreq_cluster_info {
@@ -91,10 +92,39 @@ static int tegra186_cpufreq_set_target(struct cpufreq_p=
olicy *policy,
 	return 0;
 }
=20
+static unsigned int tegra186_cpufreq_get(unsigned int cpu)
+{
+	struct cpufreq_frequency_table *tbl;
+	struct cpufreq_policy *policy;
+	void __iomem *edvd_reg;
+	unsigned int i, freq =3D 0;
+	u32 ndiv;
+
+	policy =3D cpufreq_cpu_get(cpu);
+	if (!policy)
+		return -EINVAL;
+
+	tbl =3D policy->freq_table;
+	edvd_reg =3D policy->driver_data;
+	ndiv =3D readl(edvd_reg) & EDVD_CORE_VOLT_FREQ_F_MASK;
+
+	for (i =3D 0; tbl[i].frequency !=3D CPUFREQ_TABLE_END; i++) {
+		if ((tbl[i].driver_data & EDVD_CORE_VOLT_FREQ_F_MASK) =3D=3D ndiv) {
+			freq =3D tbl[i].frequency;
+			break;
+		}
+	}
+
+	cpufreq_cpu_put(policy);
+
+	return freq;
+}
+
 static struct cpufreq_driver tegra186_cpufreq_driver =3D {
 	.name =3D "tegra186",
 	.flags =3D CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 			CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.get =3D tegra186_cpufreq_get,
 	.verify =3D cpufreq_generic_frequency_table_verify,
 	.target_index =3D tegra186_cpufreq_set_target,
 	.init =3D tegra186_cpufreq_init,
--=20
2.25.1

