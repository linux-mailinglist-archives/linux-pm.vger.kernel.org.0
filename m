Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF11BC76
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfEMR7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 13:59:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36160 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfEMR7a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 13:59:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so7609526pfa.3;
        Mon, 13 May 2019 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=rllXTOSI+l4dOxVedgJq5yZYXTiqRbCrivN8bEva+1o=;
        b=P2R9iMibtoLad0qOV2+DiBMkXyuXf3CQycA8i3D+rYFgcUOhvBff8tb07olonxdyZ7
         EPR1qiixByolrP00F9/QiDJeC0WrCoatZhz0uX5PWOtnkLAKq5sm+ivdFIgUsw+jatCR
         XRSDJf+lBn1fdNKKAQPov56whA7FcvWt7xElnBS6N1/CncQ8e1K/glLMn+ZylC2mUtk4
         LgcQu8O6Ile1SXpVLkxP7vlYLTYeVVRO+5oJAWZ04qhEbW6tAHLQOpq4apneRVO/dlEj
         Uci7hpCy8r5PEu5g2UDwpeEOrPqZRp3fbszFTMQ4oMFSD3Ywf7uNyie439oxeSILOOpI
         nf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=rllXTOSI+l4dOxVedgJq5yZYXTiqRbCrivN8bEva+1o=;
        b=edhZwnSzOB8/2GCCMnL/I6ANW4xHlkTZNanHXzjh0JahtcPccVSMh/wMP0TXYqaftF
         70yDYDMoP8+68bkRfGwm04tjDTPPq/zjFazxkCQKBOIy6qPFzX8Qfhb8IbZMYZ+kAvcH
         MDgUInfwwEBYvmLesQRqWetercs9vdNq/4epvqgCP2ajAIJ0W859Ig514Bofh7p2JOj1
         ui5Jz3U+iF9vEgI1MiBlAcT/PlcAXipu+oxm/umRpFbK4IuY7jyi9K7GlPEOFWVWSAoh
         0VMJotdzsUpsuYXoWIvhBh2ALHxo1+cfFG9Ef9zUx7r/lYy7wyAkdZi6A69UhvlNDUus
         QTEA==
X-Gm-Message-State: APjAAAWkMxZ6MkSdTwl6fEBcv4n5HkBxNZcdDbkw3BGXp2CSvNi555HJ
        t/byPt2FmGwN1Zwc1QEGF+aleEK6
X-Google-Smtp-Source: APXvYqw4isY2CZSWFLw0cWYvh2NWwmmEFT2LoyQOEgEsbI31Z+B5w7inOWYLYdrjGOymQR4vwByrKQ==
X-Received: by 2002:aa7:8e04:: with SMTP id c4mr34899854pfr.48.1557770370110;
        Mon, 13 May 2019 10:59:30 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:29 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 10/19] hwmon/coretemp: Support multi-die/package
Date:   Mon, 13 May 2019 13:58:54 -0400
Message-Id: <ec2868f35113a01ff72d9041e0b97fc6a1c7df84.1557769318.git.len.brown@intel.com>
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

Package temperature sensors are actually implemented in hardware per-die.

Update coretemp to be "die-aware", so it can expose mulitple sensors
per package, instead of just one.  No change to single-die/package
systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/coretemp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5d34f7271e67..c64ce32d3214 100644
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
@@ -741,7 +741,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!pkg_devices)
-- 
2.18.0-rc0

