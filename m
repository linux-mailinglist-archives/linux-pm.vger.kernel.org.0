Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17FD4E8F8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFUNXb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 09:23:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55856 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFUNXb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 09:23:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so6312011wmj.5
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=itavUBs0pQG90hF8Ul+O9AcFp2XCaZzaOwg7vCeN/0A=;
        b=vnSjkkzGXYJoAmji3G64EnrivvmyKX5pc2X95lo9QzAAgL8upU5N1WyB698nF0MFRR
         E3pkrmYCBw/SvK92cAJ2nHa64tCNLEdNVj8+Vq1IGkBAl2GvIhRoLbHlSA8YvsZufYYQ
         BZIDxH8CWfmE5KDcskbgVUkjjDLFd15N66hpzawEBvupyGca3i4WcgXnBEV0w9p21DHg
         iZ0cY4fqZlG+g8A5xWvRmsIigz/ayyG02xih2N7ZsqoDsjFK1yzujTUGGJFrTpRMMqPT
         Go2rkLFgfvTWK0/0R3Rk9mLsLdwUMr0/chbQYKJ8CKqlYO6B1Ak8dpaGokWqqazrrhfW
         5y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=itavUBs0pQG90hF8Ul+O9AcFp2XCaZzaOwg7vCeN/0A=;
        b=FB4iIZmqRSPl2/kthUs+gT9Ixy38PgKB6XbfM0NmSC1ZkGQV7oI8eSkMQOXvJelqx1
         Lhzi4Ae/Q7quqLcAcazY5VeMK8VZFbFNQMzggphXDan879zLI3xphjnebSuY6VKsEVJR
         xSi78WwoD7MTJIrCmBTm9J1uZulMukgCtuuh/7bnyEWdedtU26PtINSzpxDpvWzx4IBe
         Rix6uBshHXCnT42TwAH6GBN+Lil8VAqfze+B8Vvr12JArNGaLi9cSKDKur6jDEgqMQW3
         ajAhyimbtIviDcmfr92hjWIUW4v61650ntXw1sLR9U+GY5jfPdmPMSX/tmLSzF7rl0LM
         AEZQ==
X-Gm-Message-State: APjAAAXmwj2ogQ7nqh/aRppqg74DXr1f6wQ5nXpXhdDI7N9ZvdSCmCoi
        w4NwTLrktvhYHAEKCrmhX8q/L4+kpt8=
X-Google-Smtp-Source: APXvYqwylvO41dcA3hzPGzxlbOBxIYi/KVk5+6iHYZ8tQ3exIyCxj8u3Ztxz0DIzSZeI11nMcuuNFA==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr4147601wmz.171.1561123409214;
        Fri, 21 Jun 2019 06:23:29 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS - ARM BIG
        LITTLE)
Subject: [PATCH 3/6] cpufreq/drivers/arm_big_little: Remove cooling device usage
Date:   Fri, 21 Jun 2019 15:22:59 +0200
Message-Id: <20190621132302.30414-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621132302.30414-1-daniel.lezcano@linaro.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq_cooling_unregister() function uses now the policy to
unregister itself. The only purpose of the cooling device pointer is
to unregister the cpu cooling device.

As there is no more need of this pointer, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 6b243202caa9..718c63231e66 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -56,7 +56,6 @@ static bool bL_switching_enabled;
 #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
 #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
 
-static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
 static const struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
@@ -501,10 +500,8 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	int cur_cluster = cpu_to_cluster(policy->cpu);
 
-	if (cur_cluster < MAX_CLUSTERS) {
+	if (cur_cluster < MAX_CLUSTERS)
 		cpufreq_cooling_unregister(policy);
-		cdev[cur_cluster] = NULL;
-	}
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -527,7 +524,7 @@ static void bL_cpufreq_ready(struct cpufreq_policy *policy)
 	if (cur_cluster >= MAX_CLUSTERS)
 		return;
 
-	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
+	of_cpufreq_cooling_register(policy);
 }
 
 static struct cpufreq_driver bL_cpufreq_driver = {
-- 
2.17.1

