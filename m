Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1944539CEC1
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jun 2021 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhFFMCY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 08:02:24 -0400
Received: from m12-15.163.com ([220.181.12.15]:36706 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFMCY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Jun 2021 08:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5DNqCgIEYsAPhbxy70
        VziB6mO/s+Jpa/55ZR38soNo0=; b=hM3dF3saz39vmODbbWocHW5czToQbP7SAz
        ssL6d0ySMkz78TF3iVjhniii2onhFJVgNZelDFQatBRKME/qXk6gu09mgoj6TEEi
        +WP5wqcGXmN1cvjAkAQ3CBxbH7nFfheuELFiGmzGe66xlkBnKnS776mj8wZqolru
        5Uj0DuRso=
Received: from localhost.localdomain (unknown [117.139.248.43])
        by smtp13 (Coremail) with SMTP id EcCowABXQXlwuLxg+0755g--.33446S2;
        Sun, 06 Jun 2021 19:58:40 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] cpufreq: sh: Remove unused linux/sched.h headers
Date:   Sun,  6 Jun 2021 19:58:28 +0800
Message-Id: <20210606115828.27020-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowABXQXlwuLxg+0755g--.33446S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF43uF43urW5WF1ftF1fZwb_yoW3Awc_uw
        13Gr4Uury7Cw1ktF1ak3Zav34Fvw13XF1vvFn5K3srta9rA3909ws7Xa4DX3s3uw4UCr1S
        9ryUt3WI9ryUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbHmh7UUUUU==
X-Originating-IP: [117.139.248.43]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbiDRCpYFQHWb-R7QAAsd
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

Since commit '205dcc1ecbc5(cpufreq/sh: Replace racy task affinity logic)'
the header <linux/sched.h> is useless in sh-cpufreq.c, so remove it.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 drivers/cpufreq/sh-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 0ac265d47ef0..1a251e635ebd 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -23,7 +23,6 @@
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
-#include <linux/sched.h>	/* set_cpus_allowed() */
 #include <linux/clk.h>
 #include <linux/percpu.h>
 #include <linux/sh_clk.h>
-- 
2.17.1


