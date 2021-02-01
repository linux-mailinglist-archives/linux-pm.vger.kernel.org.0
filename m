Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2330A9B9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBAO16 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 09:27:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38296 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhBAO1y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Feb 2021 09:27:54 -0500
Received: from zn.tnic (p200300ec2f06fe0090a9523b96ecdf55.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:fe00:90a9:523b:96ec:df55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B98A51EC0253;
        Mon,  1 Feb 2021 15:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612189629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=d9PD9rZtebAxEEHZkykEAzHUZgdpqobVoxB5RJ0eEyI=;
        b=ml4Ta5IgCEab8j10v0D5ZSD+Z6bbvo2t1ovxiRESD0/c1WntYIZ4LI9B1eVmFNr7+A/WXx
        ByUAqG2VRpWTn6DzkIPMXskI6ZUO+u+UuL2aQVhkNieretl6uxNBZMLf527a8SL0LSjDA7
        Ym6cd+6dboaClMXHfIc9peiK4OOVKE0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/2] Move ...mce/therm_throt.c to drivers/thermal/
Date:   Mon,  1 Feb 2021 15:27:02 +0100
Message-Id: <20210201142704.12495-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

I know I already committed those but

https://lkml.kernel.org/r/20210201032427.GB12524@xsang-OptiPlex-9020

made me look at the IRQ handler registration. And it does happen per CPU
which is particularly daft and unneeded. And it used to do that before
that change too, for some unknown reason.

So I decided to not have a handler registration but simply call the
thermal interrupt handler if all is setup and before that issue the
message about the unexpected IRQ.

I did test it by sending bogus thermal interrupts before and after
registration - see hunk below - and it looks good:

[    0.136608] 0: Sending thermal IRQ
[    0.136760] CPU0: Unexpected LVT thermal interrupt!
[    0.136917] CPU0: Thermal monitoring enabled (TM1)
[    0.137071] 1: Sending thermal IRQ
[    0.043243] 0: Sending thermal IRQ
[    0.043243] 1: Sending thermal IRQ
[    0.043243] 0: Sending thermal IRQ
[    0.043243] 1: Sending thermal IRQ
[    0.043243] 0: Sending thermal IRQ
[    0.043243] 1: Sending thermal IRQ
[    0.043243] 0: Sending thermal IRQ
[    0.043243] 1: Sending thermal IRQ
[    0.043243] 0: Sending thermal IRQ
[    0.043243] 1: Sending thermal IRQ
[    0.149436] thermal_sys: Registered thermal governor 'fair_share'
[    0.149437] thermal_sys: Registered thermal governor 'bang_bang'
[    0.149595] thermal_sys: Registered thermal governor 'step_wise'
[    0.149753] thermal_sys: Registered thermal governor 'user_space'
[    0.445717] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.707539] thermal LNXTHERM:00: registered as thermal_zone0

Logic in patch 1 got a bit simplified too.

Thx.

---
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 6221f0f418f7..e544f04eac8c 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -705,6 +705,11 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
                                | PACKAGE_THERM_INT_HIGH_ENABLE), h);
        }
 
+       pr_info("0: Sending thermal IRQ\n");
+
+       apic->send_IPI(0, THERMAL_APIC_VECTOR);
+       apic->send_IPI(3, THERMAL_APIC_VECTOR);
+
        rdmsr(MSR_IA32_MISC_ENABLE, l, h);
        wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
 
@@ -713,4 +718,8 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 
        /* enable thermal throttle processing */
        atomic_set(&therm_throt_en, 1);
+
+       pr_info("1: Sending thermal IRQ\n");
+       apic->send_IPI(0, THERMAL_APIC_VECTOR);
+       apic->send_IPI(3, THERMAL_APIC_VECTOR);
 }

Changelog:
==========

here's v2 which addresses peterz's comments to patch 2.

@thermal folks, lemme know if you have any objections otherwise I'll
route this through the tip tree.

v1:

so this has come up a bunch of times in the past and PeterZ is right
- that thing doesn't have anything to do with the MCE glue so move it
where it belongs.

Thx.

Borislav Petkov (2):
  x86/mce: Get rid of mcheck_intel_therm_init()
  thermal: Move therm_throt there from x86/mce

 arch/x86/Kconfig                              |  4 --
 arch/x86/include/asm/mce.h                    | 22 ----------
 arch/x86/include/asm/thermal.h                | 24 +++++++++++
 arch/x86/kernel/cpu/intel.c                   |  3 ++
 arch/x86/kernel/cpu/mce/Makefile              |  2 -
 arch/x86/kernel/cpu/mce/core.c                |  1 -
 arch/x86/kernel/cpu/mce/intel.c               |  1 -
 arch/x86/kernel/irq.c                         | 21 ++++++++++
 drivers/thermal/intel/Kconfig                 |  4 ++
 drivers/thermal/intel/Makefile                |  1 +
 .../thermal/intel}/therm_throt.c              | 41 ++++---------------
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  3 +-
 12 files changed, 64 insertions(+), 63 deletions(-)
 create mode 100644 arch/x86/include/asm/thermal.h
 rename {arch/x86/kernel/cpu/mce => drivers/thermal/intel}/therm_throt.c (96%)

2nd:rc6-therm_throt

-- 
2.29.2

