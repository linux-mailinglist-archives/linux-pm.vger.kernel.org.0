Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A976E81E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfGSPoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 11:44:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:24287 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSPoG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jul 2019 11:44:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 08:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="scan'208";a="252186468"
Received: from jiajial1-mobl1.ccr.corp.intel.com ([10.255.30.115])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2019 08:34:03 -0700
Message-ID: <1563550442.2455.1.camel@intel.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Fri, 19 Jul 2019 23:34:02 +0800
In-Reply-To: <alpine.DEB.2.21.1907190601580.2769@hp-x360>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360>
         <1563514893.2433.3.camel@intel.com>
         <alpine.DEB.2.21.1907182308321.2769@hp-x360>
         <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
         <alpine.DEB.2.21.1907190601580.2769@hp-x360>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 五, 2019-07-19 at 06:03 -0700, Kenneth R. Crudup wrote:
> On Fri, 19 Jul 2019, Rafael J. Wysocki wrote:
> 
> > 
> > So can you disable PROC_THERMAL_MMIO_RAPL in Kconfig and retest?
> It can't be manually disabled, as it's auto-selected:
> 
> 	Depends on: THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n]
> ||
> 	COMPILE_TEST [=n]) && INT340X_THERMAL [=y] && 64BIT [=y] &&
> POWERCAP [=y]
> 
> so I just reverted the commit to get going again,
> 
> 	-Kenny
> 
please try the patch below and confirm if it helps or not.

From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 19 Jul 2019 23:25:14 +0800
Subject: [PATCH] powercap: adjust init order

The MMIO RAPL interface driver depends on both powercap subsystem and
the intel_rapl_common code.
But when all of the are built in, the MMIO RAPL interface driver is loaded
before the later two and this breaks the system during boot.

Fix this by adjusting the init order of powercap subsystem and the
intel_rapl_common code, so that it can be loaded first.

Fixes: 555c45fe0d04 ("int340X/processor_thermal_device: add support for MMIO RAPL")
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 drivers/powercap/powercap_sys.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 9fd6dd3..6df4818 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1454,7 +1454,7 @@ static void __exit rapl_exit(void)
 	unregister_pm_notifier(&rapl_pm_notifier);
 }
 
-module_init(rapl_init);
+fs_initcall(rapl_init);
 module_exit(rapl_exit);
 
 MODULE_DESCRIPTION("Intel Runtime Average Power Limit (RAPL) common code");
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 540e8aa..f808c5f 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -671,7 +671,7 @@ static int __init powercap_init(void)
 	return class_register(&powercap_class);
 }
 
-device_initcall(powercap_init);
+fs_initcall(powercap_init);
 
 MODULE_DESCRIPTION("PowerCap sysfs Driver");
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
-- 
2.7.4

