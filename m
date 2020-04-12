Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E41A5C29
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgDLDaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:30:20 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55030 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgDLDaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:30:19 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 074EA20D28;
        Sun, 12 Apr 2020 03:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586662220; bh=n4+06mBFG2E/6pL4l2HWMXmoCzgCWYsl2JbLBTdqk/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6c6rQPj7i8G4NQzr1+RrqfibhJZrKz05vJtbSnHpUi2899+XEDwnBocTlOdWvqav
         Z5qm4Nv07R3bGOBaBW75RlbHnfToqG74vRz+p48NLsqwQkCbflshXes1diVmo41aDL
         cC2QbgVWzT2IG2VTjJ/MHcfrwNaZ42c89fjkcmpWPKNJQFSxzim7pqz6JUph1w8DVE
         1qBEF6becW1Leh8T5Tm7afBU/YEaWbkhdehIiSm8y1Xoy8XE0vv4gAnEgfpbK4XZJi
         Fu6xmqD5vmdHtzGXMElKA2nuIdJ//JB3NDC9ujK5H9kSb1sKyqMZZJTl152xIVUi9+
         ezK78J/8oWKfw==
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
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Steve Winslow <swinslow@gmail.com>,
        Richard Fontana <rfontana@redhat.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Peter Xu <peterx@redhat.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 09/11] MIPS: bmips: Switch to new topology interface
Date:   Sun, 12 Apr 2020 11:20:39 +0800
Message-Id: <20200412032123.3896114-10-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the parameter of cpu_set_core from cpudata to cpuid.
Also set cluster id for bmips as it have different method to probe
actual hwid of CPU, and smp_store_cpuinfo is using cluster id to
determine if we should probe topology info again.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/smp-bmips.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 9058e9dcf080..c40bb37eab38 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -247,7 +247,8 @@ static void bmips_init_secondary(void)
 		break;
 	case CPU_BMIPS5000:
 		write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
-		cpu_set_core(&current_cpu_data, (read_c0_brcm_config() >> 25) & 3);
+		cpu_set_core(smp_processor_id(), (read_c0_brcm_config() >> 25) & 3);
+		cpu_set_cluster(smp_processor_id(), 0);
 		break;
 	}
 }
-- 
2.26.0.rc2

