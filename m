Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD64DBC1C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 06:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407142AbfJREzr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 00:55:47 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2690 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392808AbfJREzq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 00:55:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da945d60000>; Thu, 17 Oct 2019 21:55:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Oct 2019 21:55:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Oct 2019 21:55:45 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 04:55:45 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 18 Oct 2019 04:55:45 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da945d10003>; Thu, 17 Oct 2019 21:55:45 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
Date:   Thu, 17 Oct 2019 21:55:39 -0700
Message-ID: <20191018045539.3765565-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571374550; bh=df18Gs5j3cwrHl5PwObGl2FSzw7tZwBe+5B9upV/qmU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=WlTqEoi5Gs0evA3sLhhGZhfcxwx3m/vSQElv4bqkxcVwKpJJr19qDRntWBEMKxukr
         pvDQ8O0f8J0Y0ueNopFf/SiMkUxcKJWUMbyucxzHNsumK+iBvAMwN6k1LFlyMgKhuK
         QMB93N+E2Rz3FittCdYokclkYTAA7YRoW0o6AkQhwCI8n6HZADPwqGZSl55kv/oQN7
         /7avi+Xqhrt8s/39ZIs70NEca9ePo3eccO4OhblbWS3XWTaSNG6KO1GAZa0A52UTRO
         hU0PkUcGepqdlRb1NlIKtyGwVnfJiWQWKNqFRQBisPvefqIsZNaxio6Y6pAl9kPvTf
         /92RK4C9M0l3Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following build warning occurred on powerpc 64-bit builds:

drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 b=
ytes is larger than 1024 bytes [-Wframe-larger-than=3D]

This is due to putting 1024 bytes on the stack:

    unsigned int chip[256];

...and while looking at this, it also has a bug: it fails with a stack
overrun, if CONFIG_NR_CPUS > 256.

Fix both problems by dynamically allocating based on CONFIG_NR_CPUS.

Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capp=
ing at chip level")
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since v1: includes Viresh's review commit fixes.

 drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cp=
ufreq.c
index 6061850e59c9..5b2e968cb5ea 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1041,9 +1041,14 @@ static struct cpufreq_driver powernv_cpufreq_driver =
=3D {
=20
 static int init_chip_info(void)
 {
-	unsigned int chip[256];
+	unsigned int *chip;
 	unsigned int cpu, i;
 	unsigned int prev_chip_id =3D UINT_MAX;
+	int ret =3D 0;
+
+	chip =3D kcalloc(CONFIG_NR_CPUS, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
=20
 	for_each_possible_cpu(cpu) {
 		unsigned int id =3D cpu_to_chip_id(cpu);
@@ -1055,8 +1060,10 @@ static int init_chip_info(void)
 	}
=20
 	chips =3D kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
-	if (!chips)
-		return -ENOMEM;
+	if (!chips) {
+		ret =3D -ENOMEM;
+		goto free_and_return;
+	}
=20
 	for (i =3D 0; i < nr_chips; i++) {
 		chips[i].id =3D chip[i];
@@ -1066,7 +1073,9 @@ static int init_chip_info(void)
 			per_cpu(chip_info, cpu) =3D  &chips[i];
 	}
=20
-	return 0;
+free_and_return:
+	kfree(chip);
+	return ret;
 }
=20
 static inline void clean_chip_info(void)
--=20
2.23.0

