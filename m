Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217B01014B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfD3U5A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:57:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41311 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfD3U4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 16:56:25 -0400
Received: by mail-io1-f66.google.com with SMTP id r10so13452415ioc.8;
        Tue, 30 Apr 2019 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=w/ZY9LTiyXKRM2OFIeRR1GiI8yAd/kYfgFgfki8il0s=;
        b=YtJt6pfFzExu2nn2LD/pkgzdudwBDuE9TUPd9cJOxZbchHajih+IO9O2DlwWaCge8C
         vrkIQHu3PXCNJroWsn2EKTyqnZs1lZt9GDmUMILlmp7LelLOpoWJyhV8dcE9vlizJ19N
         woTX8yMwAUWG5+cublTU0hJeSToDwqWSQTZSFHfuE5EdS+BDRIsIsTksACKYCP94PFQt
         +EK8VSoBqV19fmYDF42i7XdigDYg5k0rEG1FkkuEc/VhcUFzaqMEwqbJESKImL/zEI0l
         qT8MQiXa6+aQXeytm0s5b8vjtCu7GYrJbv7CcjaF9jclweaI+PpBUnF3iZHEGBsLSJ0a
         ljCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=w/ZY9LTiyXKRM2OFIeRR1GiI8yAd/kYfgFgfki8il0s=;
        b=FdAshPbIlgkXeCD7mpRQP+Qf4mJVELFw3h2qIIXgyFtnJ+69/h/Y1wSBgO6O/bWts2
         i/YjUpgJIAar3Bm8JfPG+9BGo3IcWZZsEVBLmhf1MhfXRlvHTtomSRGJ6HZethwey6OF
         xAHnGqXg6Ez7Ut+E6U/vSM0UjpqLHSNzbHOUqkgmr4NJf7NSeEY43jybDTa9/zfebezH
         JRXYlwDqWE6IiYsol0XE82wfzs2CkgJo79K4cna/ZdT+/j+/cKBosi1X+sP64v93oPjR
         iu+oOgIqTwQJZodngnlFJd+Ps5xJiUL3vf+UwkjM4jmnJ9kriNf0E3uADN2PzMYgHjDK
         wdCA==
X-Gm-Message-State: APjAAAVsDBb9h4r+9uEvVythR4YB1ttZbxJ/Fbsf4HsUNbKQ0R/EUSD7
        SjCkBI8KEMDV9d57VfhCj1A=
X-Google-Smtp-Source: APXvYqw+hkhvc4UfnFK9B4mXemX3ZTN3zSJ+I9BaX1p+MLWYR/R/gF5jtQXW0ZqQtut+wXsAqlbIiw==
X-Received: by 2002:a6b:ee13:: with SMTP id i19mr6970437ioh.113.1556657784833;
        Tue, 30 Apr 2019 13:56:24 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:24 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 08/14] powercap/intel_rapl: Simplify rapl_find_package()
Date:   Tue, 30 Apr 2019 16:55:53 -0400
Message-Id: <f1e0f58b39cc60cbb90f4b3e476b5827041d0a12.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
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
index 6cdb2c14eee4..8b2f3631aba6 100644
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
@@ -1298,7 +1299,7 @@ static int __init rapl_register_psys(void)
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
 	rd->rpl[1].name = pl2_name;
-	rd->rp = find_package_by_id(0);
+	rd->rp = rapl_find_package_domain(0);
 
 	power_zone = powercap_register_zone(&rd->power_zone, control_type,
 					    "psys", NULL,
@@ -1454,8 +1455,9 @@ static void rapl_remove_package(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-static struct rapl_package *rapl_add_package(int cpu, int pkgid)
+static struct rapl_package *rapl_add_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
@@ -1464,7 +1466,7 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
 		return ERR_PTR(-ENOMEM);
 
 	/* add the new package to the list */
-	rp->id = pkgid;
+	rp->id = id;
 	rp->lead_cpu = cpu;
 
 	/* check if the package contains valid domains */
@@ -1495,12 +1497,11 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
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
@@ -1510,11 +1511,10 @@ static int rapl_cpu_online(unsigned int cpu)
 
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

