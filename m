Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF31A5C31
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDLDcW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:32:22 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55180 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgDLDcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:32:22 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id D063420D06;
        Sun, 12 Apr 2020 03:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586661825; bh=+ULjUjhxhZgjrZLr4QNtGZOFHPRv0/ugDHj7sJtG6ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgPb1a7tm6ww/8vati/ROFgNz7SQz3VN6PgwecuxJkT6vs0HDCMJdlkT0RBLeVokx
         2joNcS8j+QpHiUorg8HWbEdKelKzPEzZczVh+zBGFzFfnTOHwHYkcqYjAfENNu0qq7
         Ijn+vaXYAYXdmK5JLyMocByYVGcrnBn1AYAt9EEGlr3eeLpytJBkE9yEB6ATWWNMDy
         Uf7KUCgW1VWGjFOhoK53PEhOKmfZF24c1JChQaXxkHzsglT0lOkqPe83gSUSzkQ/xC
         mshHe+5FCm9uiYgFx6/BKC6VfVyB3k22rXDxHyClrl+DDusDRoHYGc/5SZziceNLCI
         g9Sd7Hi1PFu0w==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steve Winslow <swinslow@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 01/11] MIPS: setup: Drop prefill_possible_map
Date:   Sun, 12 Apr 2020 11:20:31 +0800
Message-Id: <20200412032123.3896114-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the plat_smp_setup are setting up possible cpus in their
platform code. So prefill_possible_map is actually overwriting
platform's setup, which seems unreasonable.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/setup.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 10bef8f78e7c..8a418783a6bb 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -761,25 +761,6 @@ static void __init resource_init(void)
 	}
 }
 
-#ifdef CONFIG_SMP
-static void __init prefill_possible_map(void)
-{
-	int i, possible = num_possible_cpus();
-
-	if (possible > nr_cpu_ids)
-		possible = nr_cpu_ids;
-
-	for (i = 0; i < possible; i++)
-		set_cpu_possible(i, true);
-	for (; i < NR_CPUS; i++)
-		set_cpu_possible(i, false);
-
-	nr_cpu_ids = possible;
-}
-#else
-static inline void prefill_possible_map(void) {}
-#endif
-
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -804,7 +785,6 @@ void __init setup_arch(char **cmdline_p)
 
 	resource_init();
 	plat_smp_setup();
-	prefill_possible_map();
 
 	cpu_cache_init();
 	paging_init();
-- 
2.26.0.rc2

