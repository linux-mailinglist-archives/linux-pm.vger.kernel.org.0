Return-Path: <linux-pm+bounces-11529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7184293F0B9
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FE81F20FCD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FBD13D890;
	Mon, 29 Jul 2024 09:15:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32013A869
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244500; cv=none; b=QN0CHaKBxFdbIBs8MSUrrZqcAGyywP0HN1IATs/GOCtgHNtqQxsBFKQOuC3bLr1EAwwOpn82IXWUjqZQYIZEhQ+OFuILwZZ1LGA3zTBy/Cu18xwV7hX99ja2USTq2gfkrlxFcnCka9/EGmZuzMhTzJqQLIo6s4J0l2GlKA3Nl8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244500; c=relaxed/simple;
	bh=DVd6J0b2Rm9wNLScvbIT5tcsqZC6MS/5YiCCLp9tjfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ss7Gc6KqfFyNWnMDcASDunrfnsansWhhSHTM9AI8f3L4uUCNZDQid9/0AKNaj6R7wUiggGZykMIO29PwiwA4/CRq2NeDzvCx2SrZKLSNfazFy3LNUqve/bUNEgO4O2S3aQfebyza2S4icYtv0Xzg7ogc5Hi+26+48Y5MOMRRa2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1722244486-086e23393c4dc50001-MQbzy6
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id hAFHemZNY407UGy9 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 29 Jul 2024 17:14:46 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 17:14:46 +0800
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 17:14:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Mon, 29 Jul 2024 17:14:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from [10.32.57.247] (10.32.57.247) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 19:35:09 +0800
Message-ID: <529ae3fd-7392-4470-9404-552cf5a5494e@zhaoxin.com>
Date: Fri, 26 Jul 2024 19:35:03 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unknown NMI after S4 resume
To: Pavel Machek <pavel@ucw.cz>
X-ASG-Orig-Subj: Re: Unknown NMI after S4 resume
CC: <rafael@kernel.org>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
	<akpm@linux-foundation.org>, <dianders@chromium.org>, <tglx@linutronix.de>,
	<song@kernel.org>, <liusong@linux.alibaba.com>, <yaoma@linux.alibaba.com>,
	<kjlx@templeofstupid.com>, <lizhe.67@bytedance.com>, <linux@weissschuh.net>,
	<j.granados@samsung.com>, <linux-kernel@vger.kernel.org>,
	"CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, <SilviaZhao@zhaoxin.com>, "Linda Chai(BJ-RD)"
	<LindaChai@zhaoxin.com>, <Felixzhang@zhaoxin.com>
References: <14cf0b83-7030-4ec5-97b1-40c90424fe3f@zhaoxin.com>
 <ZqIMWDWn5W9+9RMA@duo.ucw.cz>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <ZqIMWDWn5W9+9RMA@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 7/29/2024 5:14:43 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1722244486
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6787
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128281
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/7/25 16:27, Pavel Machek wrote:
> 
> Yes, please.
> 
> The watchdog driver should get suspend/resume hooks, and probably do
> same init on boot and on resume.
> 

Two patch methods were tried and the results are as follows:

Patch 1:
diff -aNur linux-6.10/kernel/watchdog.c linux-6.10_test/kernel/watchdog.c
--- linux-6.10/kernel/watchdog.c	2024-07-15 06:43:32.000000000 +0800
+++ linux-6.10_test/kernel/watchdog.c	2024-07-26 18:38:16.442600567 +0800
@@ -25,6 +25,7 @@
  #include <linux/stop_machine.h>
  #include <linux/sysctl.h>
  #include <linux/tick.h>
+#include <linux/syscore_ops.h>

  #include <linux/sched/clock.h>
  #include <linux/sched/debug.h>
@@ -1264,3 +1265,35 @@

  	lockup_detector_setup();
  }
+
+static int watchdog_suspend(void)
+{
+        if (cpumask_test_cpu(0, &watchdog_allowed_mask))
+                watchdog_hardlockup_disable(0);
+
+        lockup_detector_cleanup();
+
+        return 0;
+}
+
+static void watchdog_resume(void)
+{
+        if (cpumask_test_cpu(0, &watchdog_allowed_mask)
+        && (watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED))
+                watchdog_hardlockup_enable(0);
+}
+
+static struct syscore_ops watchdog_syscore_ops = {
+        .resume = watchdog_resume,
+        .suspend = watchdog_suspend,
+};
+
+static int __init init_watchdog_sysfs(void)
+{
+        register_syscore_ops(&watchdog_syscore_ops);
+
+        return 0;
+}
+
+late_initcall(init_watchdog_sysfs);
+

Patch 1 result is: There is no unknown NMI after S4 resume, but this 
patch introduces the following warning:

[    8.994619] ------------[ cut here ]------------
[    8.999205] Interrupts enabled after watchdog_suspend+0x0/0x50
[    9.005011] WARNING: CPU: 0 PID: 219 at drivers/base/syscore.c:68 
syscore_suspend+0x17c/0x290
[    9.013463] Modules linked in: uas usb_storage i2c_hid_acpi i2c_hid 
r8169 via_rng crc32_pclmul ahci drm xhci_pci psmouse libahci 
xhci_pci_renesas realtek hid video wmi
[    9.028289] CPU: 0 PID: 219 Comm: sh Not tainted 6.10.0 #2
[    9.033726] Hardware name: Shanghai Zhaoxin Semiconductor Co., Ltd. 
ZXE CRB/HX005EZ, BIOS 47.00 06/19/2024
[    9.043289] RIP: 0010:syscore_suspend+0x17c/0x290
[    9.047953] Code: 80 fc 01 0f 87 0f 06 5f 00 41 83 e4 01 0f 85 1a ff 
ff ff 48 8b 73 10 48 c7 c7 0e c8 81 b0 c6 05 06 d4 48 01 01 e8 a4 de 5a 
ff <0f> 0b e9 fc fe ff ff 65 8b 05 f2 5e 6e 50 48 0f a3 05 7e 04 4e 01
[    9.066546] RSP: 0018:ffffbabf8073fbe8 EFLAGS: 00010246
[    9.071723] RAX: 0000000000000000 RBX: ffffffffb0bf29e0 RCX: 
0000000000000000
[    9.078792] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[    9.085864] RBP: ffffbabf8073fbf8 R08: 0000000000000000 R09: 
0000000000000000
[    9.092933] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[    9.100000] R13: fffffffffffffff2 R14: ffff8edd5106e000 R15: 
0000000000000004
[    9.107070] FS:  000070a4a2ac3740(0000) GS:ffff8ee06fa00000(0000) 
knlGS:0000000000000000
[    9.115086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.120779] CR2: 00005d4095519bd8 CR3: 00000001030e8002 CR4: 
0000000000770ef0
[    9.127849] PKRU: 55555554
[    9.130534] Call Trace:
[    9.132961]  <TASK>
[    9.135042]  ? show_regs+0x71/0x90
[    9.138416]  ? __warn+0x88/0x140
[    9.141617]  ? syscore_suspend+0x17c/0x290
[    9.145678]  ? report_bug+0x1ab/0x1c0
[    9.149313]  ? console_unlock+0x77/0x120
[    9.153204]  ? handle_bug+0x46/0x90
[    9.156665]  ? exc_invalid_op+0x19/0x80
[    9.160464]  ? asm_exc_invalid_op+0x1b/0x20
[    9.164614]  ? syscore_suspend+0x17c/0x290
[    9.168674]  ? syscore_suspend+0x17c/0x290
......

Patch 2:
diff -aNur linux-6.10/include/linux/nmi.h 
linux-6.10_test/include/linux/nmi.h
--- linux-6.10/include/linux/nmi.h	2024-07-15 06:43:32.000000000 +0800
+++ linux-6.10_test/include/linux/nmi.h	2024-07-25 18:57:38.886105105 +0800
@@ -19,6 +19,9 @@
  void lockup_detector_soft_poweroff(void);
  void lockup_detector_cleanup(void);

+extern int nmi_watchdog_bsp_suspend(void);
+extern void nmi_watchdog_bsp_resume(void);
+
  extern int watchdog_user_enabled;
  extern int watchdog_thresh;
  extern unsigned long watchdog_enabled;
diff -aNur linux-6.10/kernel/power/hibernate.c 
linux-6.10_test/kernel/power/hibernate.c
--- linux-6.10/kernel/power/hibernate.c	2024-07-15 06:43:32.000000000 +0800
+++ linux-6.10_test/kernel/power/hibernate.c	2024-07-25 
19:07:16.470095318 +0800
@@ -313,6 +313,8 @@
  	if (error || hibernation_test(TEST_PLATFORM))
  		goto Platform_finish;

+	nmi_watchdog_bsp_suspend();
+
  	error = pm_sleep_disable_secondary_cpus();
  	if (error || hibernation_test(TEST_CPUS))
  		goto Enable_cpus;
@@ -356,7 +358,9 @@

   Enable_cpus:
  	pm_sleep_enable_secondary_cpus();
-
+	
+	nmi_watchdog_bsp_resume();
+	
  	/* Allow architectures to do nosmt-specific post-resume dances */
  	if (!in_suspend)
  		error = arch_resume_nosmt();
@@ -481,6 +485,8 @@

  	cpuidle_pause();

+	nmi_watchdog_bsp_suspend();
+
  	error = hibernate_resume_nonboot_cpu_disable();
  	if (error)
  		goto Enable_cpus;
@@ -526,6 +532,8 @@
   Enable_cpus:
  	pm_sleep_enable_secondary_cpus();

+	nmi_watchdog_bsp_resume();
+
   Cleanup:
  	platform_restore_cleanup(platform_mode);

diff -aNur linux-6.10/kernel/watchdog.c linux-6.10_test/kernel/watchdog.c
--- linux-6.10/kernel/watchdog.c	2024-07-15 06:43:32.000000000 +0800
+++ linux-6.10_test/kernel/watchdog.c	2024-07-26 09:53:04.579979589 +0800
@@ -1249,6 +1249,36 @@
  }
  late_initcall_sync(lockup_detector_check);

+int bsp_watchdog_enable(void *data)
+{
+        if (cpumask_test_cpu(smp_processor_id(), &watchdog_allowed_mask))
+                watchdog_hardlockup_enable(smp_processor_id());
+        return 0;
+}
+int bsp_watchdog_disable(void *data)
+{
+        if (cpumask_test_cpu(smp_processor_id(), &watchdog_allowed_mask))
+                watchdog_hardlockup_disable(smp_processor_id());
+        return 0;
+}
+
+int nmi_watchdog_bsp_suspend(void)
+{
+        smp_call_on_cpu(0,bsp_watchdog_disable,NULL,false);
+        return 0;
+}
+EXPORT_SYMBOL(nmi_watchdog_bsp_suspend);
+
+void nmi_watchdog_bsp_resume(void)
+{
+        /* Enable the perf event */
+        if (watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED){
+               smp_call_on_cpu(0,bsp_watchdog_enable,NULL,false);
+        }
+        return;
+}
+EXPORT_SYMBOL(nmi_watchdog_bsp_resume);
+
  void __init lockup_detector_init(void)
  {
  	if (tick_nohz_full_enabled())

Patch 2 result is: There is no unknown NMI after S4 resume, and the 
results of multiple tests are ok.

Can patch 2 be used to fix this problem?

BRs!
TonyWWang-oc

