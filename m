Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930E91014A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfD3U4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:56:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40238 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfD3U4a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 16:56:30 -0400
Received: by mail-io1-f68.google.com with SMTP id m9so7076904iok.7;
        Tue, 30 Apr 2019 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=cOQ9Mqdvt9WYryBTzeuet0z6FEgVKdqlQkfL8BULl5A=;
        b=PL+yn0dZoCL4WNr3nSM/5DIUfF1uDT2OtRGMvozVcz98zDCwDrq4S+gJHuV1FhIruu
         mL9gvttqtycTM+DXHWrMczzxpBiZftUdgHnPclipziEpebhWp7bF6d61SPghEagz1N71
         9MtNmRtNpdpw+XN+oLj9uBRbfhJ0E0+S11KfcfzYQRwPb6DdPQ7KXr73OWRE9TojWPq1
         UqRXN3q24UB1Zmc8gMGTTqfCXWXGsqtPUpACX9gGi88UbR4s43E9bVX1WwuE1NbWoS0l
         DvjeZExKADawTmFD2SZqumI6DvD8eq2zNTqiF66GBiU94OC06r/M+7j2LahJ3nm173YH
         4EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=cOQ9Mqdvt9WYryBTzeuet0z6FEgVKdqlQkfL8BULl5A=;
        b=qgRMXik8Tum7hWWxy9HNkotZaA9FlaZkGuJEzEiGc+PXHmrJJsh6csV5sa7pXWSmBh
         GRE3JAfHZIJNi9d1tIFF1aIo6UejSKa3wxMOsb0/9SgfsJDiERfnLqIouAIG/ZLDnlMB
         ar8MHq0vm8pRE5GOvm2+IaFu2u4adSJxQYcfjuJCs4B0Y4WRwWFh7bbU+aYLJ9eDfn5h
         TO90CYQ7RM58dAqUALqmAiVHP5SZM9FII7IfhxX2WOPpE6GVKrURhT3438jHmtVEab4c
         1/S1bDig1t4BdmdfeMeX+450EQdYqMPmEa41ycNZBAoq3/5AKjwOHopVIyJdAkGH/Qwf
         CZgA==
X-Gm-Message-State: APjAAAXKiOjvrBZDaGtdl4/sxM+nXNq0hQcr2bjH+jdftw9WnR/SHR9/
        ORbQFIxcdch/wfvjJeOrrkl1U8X9
X-Google-Smtp-Source: APXvYqxyFeIxzLvmQXsCqirfnkWmKTBSbtuPpFfbNwLy1JnBpUP8CLCuaFrKLeMcvDTfQuMRZMXhmg==
X-Received: by 2002:a6b:6e0f:: with SMTP id d15mr233767ioh.116.1556657789718;
        Tue, 30 Apr 2019 13:56:29 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:29 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 12/14] hwmon/coretemp: Support multi-die/package
Date:   Tue, 30 Apr 2019 16:55:57 -0400
Message-Id: <f18272b6a1470d7fe6c08def9a334cfc9503ee50.1553624867.git.len.brown@intel.com>
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

This patch introduces coretemp driver support
for new dual-die/package systems.

On the new dual-die/package systems, the package temperature MSRs becomes
die-scope. Thus instead of one hwmon device per physical package, now
there should be one hwmon device for each die on these systems.

On the hardwares that do not have multi-die support,
topology_logical_die_id() equals topology_physical_package_id(), thus the
only difference is that physical package id is used as the coretemp
platform device id, instead of logical package id on these systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/coretemp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5d34f7271e67..57f348d43819 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -435,7 +435,7 @@ static int chk_ucode_version(unsigned int cpu)
 
 static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return pkg_devices[pkgid];
@@ -579,7 +579,7 @@ static struct platform_driver coretemp_driver = {
 
 static struct platform_device *coretemp_device_add(unsigned int cpu)
 {
-	int err, pkgid = topology_logical_package_id(cpu);
+	int err, pkgid = topology_logical_die_id(cpu);
 	struct platform_device *pdev;
 
 	if (pkgid < 0)
@@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * the rest.
 	 */
 	if (cpumask_empty(&pd->cpumask)) {
-		pkg_devices[topology_logical_package_id(cpu)] = NULL;
+		pkg_devices[topology_logical_die_id(cpu)] = NULL;
 		platform_device_unregister(pdev);
 		return 0;
 	}
@@ -732,6 +732,7 @@ static enum cpuhp_state coretemp_hp_online;
 static int __init coretemp_init(void)
 {
 	int err;
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
@@ -741,7 +742,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * c->x86_max_dies;
 	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!pkg_devices)
-- 
2.18.0-rc0

