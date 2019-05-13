Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF17C1BC82
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfEMR70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 13:59:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfEMR7Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 13:59:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so7609387pfa.3;
        Mon, 13 May 2019 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=ovDsv1zygxqsz+aM2MZ2wBAE8qWaN9gCYdGAVIqjCpQ=;
        b=QNeE54Ljz+isHJVE/JHbAL+WLEN0ye1u610MEXOQz6f66daMfycotH/bU68yrEiPcG
         16iMXo8nUANl/rAvNfm4AglA67J8OMl5JllgITqKvyS6ZER50uT/8P+RhJNEbUm+rB/S
         mCEMG9H6CCZny5OMDT23ut6BUy6DZg2Fv9e7+YhOMijicl5cTuUfvq3zb2GZbZ5yWwLQ
         Hix+ex8IFcbPNs11B2PgDBxA4Zu6doij2rZYIj9APdb1AonpDH+MFCvNZMSilVSILtZc
         qDs7Uwm7mTctYPvOV0mBu1zUJQn8PDkLZVnXDdgSlDEcVk2/yaa/bHxcmal+0Ew3xMVX
         F1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=ovDsv1zygxqsz+aM2MZ2wBAE8qWaN9gCYdGAVIqjCpQ=;
        b=MGk1pD2Jo0em8Z0t1Ri4T1w1ywQ7ToNnyNlke6lZuaSalx5HL206qymY4G+eOTf1AK
         zjAFLsxXc/diSAQrB7Ick9gjBBZfsdmT6NV9NRdH02WCpWqU2l+sYXrDAUmv+HVhA14I
         5enGrpbr7GYr4VvaQF33K/OJGEAJ1JkNsmVSqhl6uoc5dr4b90rsKBWfKxMnSdKBDhLg
         AZFxiJLIPQLtqPVfnfGTrz5F0Hr0K1fpBQpAzOrKCDPEb1rWYocY8gnt6XAg3ENWZuG+
         ThDth9vW+7gZ2auRpMykukg6UMqXhPyMZvvrTs3rd9pa0jFYka6OtSG65crgP3j+a3WF
         jZUg==
X-Gm-Message-State: APjAAAXJ350VlWHz80sozqRjnLaL9kF6o6EFYLuPXNB5lKtC1mqIy/nj
        5EphmLc66vYJWmnOJte+rqSjQAn2
X-Google-Smtp-Source: APXvYqyZNocR8ryG2muTB/QpXA+4pRlqu4mtpMXXUrdEYNYZXXlywn0SVz4x3LAa5ISchaxsjQByCA==
X-Received: by 2002:a65:62d2:: with SMTP id m18mr32867359pgv.122.1557770364058;
        Mon, 13 May 2019 10:59:24 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:23 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 06/19] powercap/intel_rapl: Simplify rapl_find_package()
Date:   Mon, 13 May 2019 13:58:50 -0400
Message-Id: <ae3d1903407fd6e3684234b674f4f0e62c2ab54c.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
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

