Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40E6470F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGJNe1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 09:34:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:16272 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJNe1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 09:34:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 06:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="166071632"
Received: from ygao39-mobl1.ccr.corp.intel.com ([10.255.30.205])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2019 06:34:23 -0700
Message-ID: <1562765663.2597.16.camel@intel.com>
Subject: Re: [PATCH] drivers: thermal: processor_thermal: mark pm function
 __maybe_unused
From:   Zhang Rui <rui.zhang@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Jul 2019 21:34:23 +0800
In-Reply-To: <20190708124743.3585020-1-arnd@arndb.de>
References: <20190708124743.3585020-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Arnd,

thanks for the report.

On 一, 2019-07-08 at 14:47 +0200, Arnd Bergmann wrote:
> Without CONFIG_PM, we get a harmless warning:
> 
> drivers/thermal/intel/int340x_thermal/processor_thermal_device.c:446:
> 12: error: 'proc_thermal_resume' defined but not used [-
> Werror=unused-function]
>  static int proc_thermal_resume(struct device *dev)
> 
> Mark it __maybe_unused to shut up the warning.
> 
> Fixes: aaba9791fbb4 ("drivers: thermal: processor_thermal: Read PPCC
> on resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2
> +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index a3210f09f366..5ce639a99330 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -443,7 +443,7 @@ static void  proc_thermal_pci_remove(struct
> pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  
> -static int proc_thermal_resume(struct device *dev)
> +static int __maybe_unused proc_thermal_resume(struct device *dev)
>  {
>  	struct proc_thermal_device *proc_dev;
>  
I'd rather prefer to add #ifdef CONFIG_PM_SLEEP for
proc_thermal_resume().
Just like the patch below, what do you think?

thanks,
rui

From 6c395f66e98c895cf3ebf87c0b2fc63b6a57a196 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 9 Jul 2019 21:19:12 +0800
Subject: [PATCH] drivers: thermal: processor_thermal_device: Fix build warning

As a system sleep callback, proc_thermal_resume() should be defined only
if CONFIG_PM_SLEEP is set.

This fixes a build warning when CONFIG_PM_SLEEP is not set,
drivers/thermal/intel/int340x_thermal/processor_thermal_device.c:446:12: error: 'proc_thermal_resume' defined but not used [-Werror=unused-function]
 static int proc_thermal_resume(struct device *dev)

Fixes: aaba9791fbb4 ("drivers: thermal: processor_thermal: Read PPCC on resume")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index a3210f0..77dae1e 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -443,6 +443,7 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int proc_thermal_resume(struct device *dev)
 {
 	struct proc_thermal_device *proc_dev;
@@ -452,6 +453,9 @@ static int proc_thermal_resume(struct device *dev)
 
 	return 0;
 }
+#else
+#define proc_thermal_resume NULL
+#endif
 
 static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
 
-- 
2.7.4

