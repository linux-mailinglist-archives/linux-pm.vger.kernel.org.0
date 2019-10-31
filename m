Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105CBEAA25
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 06:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfJaFWD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 01:22:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5308 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfJaFWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 01:22:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dba6f800003>; Wed, 30 Oct 2019 22:22:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Oct 2019 22:22:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Oct 2019 22:22:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 05:22:01 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 31 Oct 2019 05:22:01 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dba6f790002>; Wed, 30 Oct 2019 22:22:01 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] cpufreq: powernv: fix stack bloat and hard limit on num cpus
Date:   Wed, 30 Oct 2019 22:21:59 -0700
Message-ID: <20191031052159.4125031-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572499329; bh=JruVw9xyqxYwGOkvLwuaUWoisUc3Oj72psSC7yvOj9E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=M2HndkRgDEqSG30/5xzYXxZbX47HSMe5IHZqeYbu8232+KxDaFWwpP6+neQyf6SAe
         rHoltzYET4z8kYedl9AjK5p+9tMJ1xDrfXgLL+BbBC5QOa1oNLWVRQ1Xzk4sTMTE5s
         p2auRJ5SEK+izk6eHf681wKgxCyxu9NOAYka8Ag2UPAKFvQwnp9TURjIlrfUlmTHTy
         ykatPRRPK4Rn98Y8T7Ekxq73LxbPUkPRiO5JEy4VmZ4ogRfDRPYygITDdWhgTZxi8A
         UIF6BSO9ZXDgFm8S+jWDInAXmZGGcw1730EArNsprax/8NLDqmG0cPuxf1tdaLIcA/
         r54fV3Utf9WIQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following build warning occurred on powerpc 64-bit builds:

drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of
1040 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]

This is with a cross-compiler based on gcc 8.1.0, which I got from:
  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.=
0/

The warning is due to putting 1024 bytes on the stack:

    unsigned int chip[256];

...and it's also undesirable to have a hard limit on the number of
CPUs here.

Fix both problems by dynamically allocating based on num_possible_cpus,
as recommended by Michael Ellerman.

Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capp=
ing at chip level")
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since v2: applied fixes from Michael Ellerman's review:

* Changed from CONFIG_NR_CPUS to num_possible_cpus()

* Fixed up commit description: added a note about exactly which
  compiler generates the warning. And softened up wording about
  the limitation on number of CPUs.

Changes since v1: includes Viresh's review commit fixes.

thanks,
John Hubbard
NVIDIA


 drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cp=
ufreq.c
index 6061850e59c9..56f4bc0d209e 100644
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
+	chip =3D kcalloc(num_possible_cpus(), sizeof(*chip), GFP_KERNEL);
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

