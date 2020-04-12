Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC51A5C34
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLDcX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:32:23 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55216 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgDLDcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:32:22 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 67F8320D16;
        Sun, 12 Apr 2020 03:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586661973; bh=tGxZsojCaXRQzUdr7zPR3NOXIGurTKod1uy8NjI5p4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGx/6YE0io5bsdUPMhxoxEtHAD2PhTqgr8oGauD28ht0om5LPEo9Gg+mYvohWevhA
         DDt7PXbYLaEmUppcrL7V3FD5fsup9agG6l9dlf3MM/mfoiQ/qm7RY+JV/YiKSVbTX7
         t5dyba1nNAHbzbaddtE0RtBYGhPPEVgAu64dbSmm7RNhD5GvXAsUjkZS2P3k+NFHgN
         OXiiUhR58SGALxKtK3jd+Tn4s0v3SdRdz6uPrMisS7WmGYiFYnuWVS8wpT5xo5jUVa
         lPrY8npH96DYo0qUsW0z9OI4ly38crST4a56ezVKQ73/EKeXcGDHFj7RR0F5YCksH+
         t7Zh+NbVX1AWw==
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
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 04/11] arch_topology: Reset all cpus in reset_cpu_topology
Date:   Sun, 12 Apr 2020 11:20:34 +0800
Message-Id: <20200412032123.3896114-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For MIPS platform, when topology isn't probed by DeviceTree,
possible_cpu might be empty when calling init_cpu_topology,
that may result cpu_topology not fully reseted for all CPUs.
So here we can reset all cpus instead of possible cpus.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

--
v2: Use ARRAY_SIZE instead of NR_CPUS.
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 13dc4fbf043f..e7912d0a875e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -536,7 +536,7 @@ void __init reset_cpu_topology(void)
 {
 	unsigned int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for (cpu = 0; cpu < ARRAY_SIZE(cpu_topology); cpu++) {
 		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
 
 		cpu_topo->thread_id = -1;
-- 
2.26.0.rc2

