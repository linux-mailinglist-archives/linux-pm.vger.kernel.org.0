Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2EE15597
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEFV1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 17:27:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34409 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfEFV0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 17:26:42 -0400
Received: by mail-io1-f67.google.com with SMTP id g84so4445493ioa.1;
        Mon, 06 May 2019 14:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=rllXTOSI+l4dOxVedgJq5yZYXTiqRbCrivN8bEva+1o=;
        b=XbAHGi+9ZzQTmKRVjGiRMM8+/MG7wQmGfl1AT3d83I3LOq+YByi/vjZO5G7stu1PbA
         5Srl3aOE8jVsnuPUIpB8xIG3rHJ+m22o3KXiUx6h3Z6MU5ZG4YEBOVyU3X+zlx7M3pua
         vZ+PXSItLRIWUvOrdXSq//nnufPmXSjzLYXjU9dcK/9ojo780LoplcEWBvWWLqnVG+20
         ptzyHH/YK1A7o2iAKUB0RsV8Dff25+FuR+rMPtKorX4jjDTlTDgriJhn6dcdzWZzmnRC
         n7Rx5ro96BgyYCrjvZ+72rQyKntQOZdozbUu7xBBHY70cX9eEUfXS4kXJqjACf3vvxfh
         WFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=rllXTOSI+l4dOxVedgJq5yZYXTiqRbCrivN8bEva+1o=;
        b=hqNBc1ow6w8um+N12wqQMzVqMqFXAqnGxvr1fiDxc4n5GDvKeYswHvHupg0a994OMI
         s9uY2EB3hw3l9z7U88hm4sgsfkPDL29zJkdzVi4UX57QRdVSUs/iOvpvLBnq7Mgmr7gK
         jnG8WcJL8d3Arz/I7Me1swWNQ74JNBoSDCBWc3pIGjfJlTurk6LdY+mENIh5phXS5tW/
         YLWXw1MR8gHUMK/a3hxN+u3NpuKz1m28EW0MeoDGXIZWU7vb1segNaZe5oaqkykusZEZ
         6cvTBTtDae4Lj1jT413db5xM9AZfNJOlmL5KDni+se1hr5QhCqWeGJAGaJU3KtwURBE8
         q9Cg==
X-Gm-Message-State: APjAAAVy9fd2LM2pbmhN4kcESlHa3UjyJ3oKav1pHdUpkRDiuje55uCS
        83eg094kTAG+ZnwkkeOAFN0=
X-Google-Smtp-Source: APXvYqx6mYHaqoZF3+81oCwrxQCD2jqxgtmOU5IIWRQ3TMRVtR+/J9jOIu+qYpNcf2VSTlIjYGMEBg==
X-Received: by 2002:a05:6602:20cc:: with SMTP id 12mr3027644ioz.6.1557178001737;
        Mon, 06 May 2019 14:26:41 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:41 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 13/22] hwmon/coretemp: Support multi-die/package
Date:   Mon,  6 May 2019 17:26:08 -0400
Message-Id: <75731eb53db844af1559aa92f257cb9ca8c2a70a.1557177585.git.len.brown@intel.com>
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

