Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82485522EEE
	for <lists+linux-pm@lfdr.de>; Wed, 11 May 2022 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiEKJGk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 May 2022 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiEKJGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2022 05:06:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D81D0CA
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 02:06:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so4333572pjv.4
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsHL/Fgf/VRDzuQNj7TOsqpyMCDcKbQUomZXfLWBfKI=;
        b=e+IuamdFJTZpf5n5zxxUPfE3eAwTLOKFTxWIbi0xVTgF8k5lupUYviT1ldVmDLwI5b
         UcizCvRPkzjQ7X21TsMxwUhVLknK9YzpAqT8wDqB+HGxU2CSZXU0bfE6SL3FiHbaTEyN
         8Ccl1gnC952TZNg/1j/mmr4UdySSOlYhCj3liTNwPOKtjQHgRLYxrhNpTrKpvY80K1x0
         JdqDYcxeVvny6JJzbsmP7HVaKiPIGedXHaCOza361rAjSOs2q7CZTzqtV4jeGuPx3Wk8
         Yjo+gzUN4rEhUrYJ1jl53HzENhO6c2DHRy5KjVTOg6MmNeHPOZ82y/pUisIqC4RDWo0O
         MQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsHL/Fgf/VRDzuQNj7TOsqpyMCDcKbQUomZXfLWBfKI=;
        b=JJWqoP5z6Tmi3NVlnR5RKvzM2nNAxfpQz9YS0ibN9bTd3Z0QSPz3CPmqQ5faPgoEnn
         XVxuNfC6gYvcGPJ8De1Sf6/caxtNA22UkEV75fvXO2YnY8SCHOauojD4c+jRTvYauBWy
         OghHoHARG8svyNDtquzWu797ub5YSd++B0erAmi92WhRYNVjc+vwsOWSADYsPLThdNca
         U+h0mn3zkndfm2y3Yor158VtqERJctxET7kmeGLqtPXwSZg4ItAMkcBj4FCHQAIZbnkF
         8aAFrbUBe94WtVncWm+yXckudY+ayWDLn0YB7IZoCvtvb0+s2KqJQKPTs4f1Jb82obGO
         i/4A==
X-Gm-Message-State: AOAM532SfSzd5Pgk7guxYbllw8wNgeeTOgxxdJfEd34+TGgkkXxKodW8
        TOivOznZGleaCrERB15Yx09YE2QaxhwKBw==
X-Google-Smtp-Source: ABdhPJwBVKz8nB+2n8dSZV3VanQ8pn3CfXK/2OC9FcSog0V/gl5h4NUyfyOrtBFiBZcleQJCGXfFxg==
X-Received: by 2002:a17:902:b412:b0:15e:dc07:4c14 with SMTP id x18-20020a170902b41200b0015edc074c14mr24522004plr.99.1652259991350;
        Wed, 11 May 2022 02:06:31 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w63-20020a628242000000b0050dc7628151sm1098779pfd.43.2022.05.11.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:06:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Clear real_cpus mask from remove_cpu_dev_symlink()
Date:   Wed, 11 May 2022 14:36:24 +0530
Message-Id: <b44e39176bbba43c256ae75df26c1fd051353ff9.1652259889.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add_cpu_dev_symlink() is responsible for setting the CPUs in the
real_cpus mask, the reverse of which should be done from
remove_cpu_dev_symlink() to make it look clean and avoid any breakage
later on.

Move the call to clear the mask to remove_cpu_dev_symlink().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fbaa8e6c7d23..c8bf6c68597c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1020,11 +1020,12 @@ static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu,
 		dev_err(dev, "cpufreq symlink creation failed\n");
 }
 
-static void remove_cpu_dev_symlink(struct cpufreq_policy *policy,
+static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu,
 				   struct device *dev)
 {
 	dev_dbg(dev, "%s: Removing symlink\n", __func__);
 	sysfs_remove_link(&dev->kobj, "cpufreq");
+	cpumask_clear_cpu(cpu, policy->real_cpus);
 }
 
 static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
@@ -1532,7 +1533,7 @@ static int cpufreq_online(unsigned int cpu)
 
 out_destroy_policy:
 	for_each_cpu(j, policy->real_cpus)
-		remove_cpu_dev_symlink(policy, get_cpu_device(j));
+		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
 
 	up_write(&policy->rwsem);
 
@@ -1657,8 +1658,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpu_online(cpu))
 		cpufreq_offline(cpu);
 
-	cpumask_clear_cpu(cpu, policy->real_cpus);
-	remove_cpu_dev_symlink(policy, dev);
+	remove_cpu_dev_symlink(policy, cpu, dev);
 
 	if (cpumask_empty(policy->real_cpus)) {
 		/* We did light-weight exit earlier, do full tear down now */
-- 
2.31.1.272.g89b43f80a514

