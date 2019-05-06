Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5F15595
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfEFV0i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 17:26:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39967 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfEFV0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 17:26:37 -0400
Received: by mail-it1-f195.google.com with SMTP id g71so7288216ita.5;
        Mon, 06 May 2019 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=ovDsv1zygxqsz+aM2MZ2wBAE8qWaN9gCYdGAVIqjCpQ=;
        b=pKRGEef334uc2GHUkzQaEKu5z/YZvsJ8RobXHE2ryI+6Iq3iCtjiKVL1AJlIikT/6S
         dSr6SVoc9GtPRPDhjoqgqeKuBYpm0tW6yVExYb0rNZnqLgPAzkLEXe8hg+6CDR4xTA4z
         h97rvW0CBHjgwzgcfuE2ygFsEGS/OnqFS6zlJB6xwlwsZyRguec7FNkTpL0kZ65xTC9O
         8Q/T70t/5usSp/cADqkuusoD/38rsTmxFtuTj+e2UWMRATTKM2toCbjewu85mIdEiQ8A
         Z5jFssrCRuqh0tGB4FALwk5rhVG8WFKk5oPktIcK7ojjsEf+KCgoyVq7PGSVUkFq7T0Q
         3NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=ovDsv1zygxqsz+aM2MZ2wBAE8qWaN9gCYdGAVIqjCpQ=;
        b=Ei2cd5UYiNt89JoL5nXUwU2EtWrdTeiQK7W6//szDUeM1vg1LUw0/hfgYoij/x42O9
         NpXoVZ7A4KUHV9iWON7HIOpj2gDMAEGMx+y+YaJzPCRavS69/2SOfU2UtNdfnvH7oDFf
         av/YFwZStkun01xgyH8VwP69emNy/Z8kBUVEsRIhl+7DZBD/OsfjXRy8PwvvmquCLLvA
         iQznLByixewQdsLmR5cKxJ0Jcu+IpLxo4Upu0KnCMBBPI7JwXXFRMt+49WhCHpP274IA
         pS2+clymXYSPSmU/LDM/yfJUmRppiFjzOBml+wlkSEvjBJ446Db1d1HmGgB0bbwcO7V1
         YnOg==
X-Gm-Message-State: APjAAAVIQc0MWEEx6CuO7wa9HJFEN8H6BBIwPTJIMNmdYgXwZT1etKlu
        vKKzBpGhJKD4JNwzLVep9Ts=
X-Google-Smtp-Source: APXvYqzVawC3clhIwzxntArMDX6dH+oy12J7Y7eka6HloEE2Qoec5HYxG70calzFr2E+KOKS+FEDOw==
X-Received: by 2002:a24:c4c4:: with SMTP id v187mr19473543itf.66.1557177996763;
        Mon, 06 May 2019 14:26:36 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:36 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 09/22] powercap/intel_rapl: Simplify rapl_find_package()
Date:   Mon,  6 May 2019 17:26:04 -0400
Message-Id: <b7a7b6e72e76510dc8dedb3e1b8b20de7cdca432.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Syntax only, no functional or semantic change.

Simplify how the code to discover a package is called.
Rename find_package_by_id() to rapl_find_package_domain()

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 4347f15165f8..3c3c0c23180b 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -264,8 +264,9 @@ static struct powercap_control_type *control_type; /* PowerCap Controller */
 static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 
 /* caller to ensure CPU hotplug lock is held */
-static struct rapl_package *find_package_by_id(int id)
+static struct rapl_package *rapl_find_package_domain(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1300,7 +1301,7 @@ static int __init rapl_register_psys(void)
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
 	rd->rpl[1].name = pl2_name;
-	rd->rp = find_package_by_id(0);
+	rd->rp = rapl_find_package_domain(0);
 
 	power_zone = powercap_register_zone(&rd->power_zone, control_type,
 					    "psys", NULL,
@@ -1456,8 +1457,9 @@ static void rapl_remove_package(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-static struct rapl_package *rapl_add_package(int cpu, int pkgid)
+static struct rapl_package *rapl_add_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
@@ -1466,7 +1468,7 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
 		return ERR_PTR(-ENOMEM);
 
 	/* add the new package to the list */
-	rp->id = pkgid;
+	rp->id = id;
 	rp->lead_cpu = cpu;
 
 	/* check if the package contains valid domains */
@@ -1497,12 +1499,11 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
  */
 static int rapl_cpu_online(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package_domain(cpu);
 	if (!rp) {
-		rp = rapl_add_package(cpu, pkgid);
+		rp = rapl_add_package(cpu);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -1512,11 +1513,10 @@ static int rapl_cpu_online(unsigned int cpu)
 
 static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package_domain(cpu);
 	if (!rp)
 		return 0;
 
-- 
2.18.0-rc0

