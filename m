Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F121A5C2C
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDLDbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:31:10 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55098 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgDLDbJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:31:09 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id C95F420D2B;
        Sun, 12 Apr 2020 03:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586662270; bh=ZVoEHgyxwKRnpz9YM+7JK0CgnU+b6VSlDxJRGNc9WhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AguW/aEn9egIUVf9Xs/nZ5oJzpXDA+gH+31H66p/dgAjejW5GZBsekpFsfshFyn1/
         Q/7+38hfghIhqY7aWWUphwB01sJsYYQSoQ4zoftpqR8/T17hwt7yebt5/4yKQCDAaE
         3J/V1guU57bOZGpQvEEfacr3dbG6+iRtebHsV9hHfMBBbJbS3OzqoV+mRjYSUPU67m
         Z4XrMASt7salrpbY8/x9z8SNk0LHVLdeHRT21uD8UBOzR7H1imATE05DT3jPzLzVp6
         D0+pr6x8u70Q7CayGX2NbOd7e2fJAcjXcO+fGJxu/6ljl74DBo9cH/UMcUV5RaWJeK
         LQhxAdnggTMYw==
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
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Steve Winslow <swinslow@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 10/11] MIPS: nlm: Switch to new topology interface
Date:   Sun, 12 Apr 2020 11:20:40 +0800
Message-Id: <20200412032123.3896114-11-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use new functions to set core_id & cluster_id.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/netlogic/common/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 39a300bd6cc2..14bfa8a099cc 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -122,8 +122,8 @@ static void nlm_init_secondary(void)
 	int hwtid;
 
 	hwtid = hard_smp_processor_id();
-	cpu_set_core(&current_cpu_data, hwtid / NLM_THREADS_PER_CORE);
-	current_cpu_data.package = nlm_nodeid();
+	cpu_set_core(smp_processor_id(), hwtid / NLM_THREADS_PER_CORE);
+	cpu_set_cluster(smp_processor_id(), nlm_nodeid());
 	nlm_percpu_init(hwtid);
 	nlm_smp_irq_init(hwtid);
 }
-- 
2.26.0.rc2

