Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB39E104C5
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 06:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEAEZg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 00:25:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50873 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfEAEYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 00:24:45 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so8375519itk.0;
        Tue, 30 Apr 2019 21:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=ovDsv1zygxqsz+aM2MZ2wBAE8qWaN9gCYdGAVIqjCpQ=;
        b=OraoV+8GUOkNSgX84+Q8zD9nlTMzPGH3E8/IryUIAt+Y2MMkRywldq77T122sv6aAb
         7QiiLd0/8qUfgN1SEZDfH0AOI0ooTe5Go59O8EujRVF3vteCkeqtoXCQ0G6Kmc3kO8zI
         t24N9kyAhQDL9t8nUR9nCCy0k+wc7aF3u7gsIQUeqZZqHK5cozaqVM9kcZ3S/4jYWjnV
         GkGZ9e+E5Q7W1KK61E7vQKyMOafy+I3FcCoddQrNlHbVqtWj8R7XpN0eA3daeH3wXy0+
         d2JXCj/85DXVukB5pPA5ePft+2uHphvd7EofnAMd8eXqUtRRwcRJv7/yTl8jVFFDXiEO
         gqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=ovDsv1zygxqsz+aM2MZ2wBAE8qWaN9gCYdGAVIqjCpQ=;
        b=TV1EQYp0GdNqEvM2/5AMmWCN26D6mkanMbtyFKdKciBLLxreJsQYg4pj9IVPqHpghO
         +RGbiFrkSv1ZDys8tTjc3RIp1Gd0jQjBGIV56UkOYqN8MdoxNN/IixPo9hHN3b26AT07
         g/oizWlC7174J/hp2rr+rVW6/PIjIsS8dLUO36zx3vuWShAi13lSo56Be2bHzouxEbdJ
         S6G+BdOXugf8x+laOS1cBOG+hJv05L7irkqc9Hhw05O8JzNItCEnpMwMMVJhy/ivb4io
         LTcOT7ii5dkEBOiFNlARr6BjUMhGi3rFJHkYIbwoNuroM71nGCHZZQpQagZ88iQdFWl2
         ZxFQ==
X-Gm-Message-State: APjAAAUv5R46+VeOQVesVpmV+u2HWbLJXCAGA7JkmCfAvb2QWuKm0xjg
        r49cc/LJcOJbGOWhwOfZTg4=
X-Google-Smtp-Source: APXvYqzfQqSMdvhgAbICOZbG7illtwnkA1ltAuo7YpHuAsWy0ALADXLXHvwGf4zsxF+vcNGzLRQLyQ==
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr6256531ith.72.1556684684994;
        Tue, 30 Apr 2019 21:24:44 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:44 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 09/18] powercap/intel_rapl: Simplify rapl_find_package()
Date:   Wed,  1 May 2019 00:24:18 -0400
Message-Id: <b7a7b6e72e76510dc8dedb3e1b8b20de7cdca432.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
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

