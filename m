Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC64039A2A8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFCOBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 10:01:17 -0400
Received: from m12-16.163.com ([220.181.12.16]:39974 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhFCOBR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Jun 2021 10:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ovTmFJoXQpFc2h6BCr
        Ci4j2sS7eqhHBmX24K13m10vs=; b=QfV8Z/gEYzbOTgapXXMTZd9MDSDmPwuh18
        oIYv578C8Xbo/7zXr33NkFN02vHTG9RoMD8mL1kPoiRaHMNu7BgFmeJmcv2f11HK
        Vw2Pay6HttdinebgxJfzccp1YTBHYJ9ETMrXRKcOMI0sfcG0a4LGwwpgND6TIpH2
        ux8QBI8uQ=
Received: from localhost.localdomain (unknown [117.139.248.43])
        by smtp12 (Coremail) with SMTP id EMCowAAXHRn437hg6GEIvA--.51074S2;
        Thu, 03 Jun 2021 21:58:17 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] CPUFREQ: loongson2: Remove unused linux/sched.h headers
Date:   Thu,  3 Jun 2021 21:57:52 +0800
Message-Id: <20210603135752.30162-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowAAXHRn437hg6GEIvA--.51074S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWrtw15KF1DKw1fAw43KFg_yoW3tFb_u3
        W3Kr48urW7AwnxtFy3uFnaqr1Sqw43JF1vvF1rK34DXayDAan0kw4kJFyUW34Sgw47Gr1f
        Xw48Ka4xCr1YgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8JKsUUUUUU==
X-Originating-IP: [117.139.248.43]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbiDRSmYFQHWZdOUgABsf
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

Since commit 759f534e93ac(CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()),
the header <linux/sched.h> is useless in oongson2_cpufreq.c, so remove it.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 drivers/cpufreq/loongson2_cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index d05e761d9572..afc59b292153 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -16,7 +16,6 @@
 #include <linux/cpufreq.h>
 #include <linux/module.h>
 #include <linux/err.h>
-#include <linux/sched.h>	/* set_cpus_allowed() */
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 
-- 
2.17.1


