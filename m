Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879903A92E9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 08:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFPGnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhFPGnP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 02:43:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88BC061280
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:40:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3369604pjn.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdbF+pw9w6thId4kMOV09HnHCGHiD/yfDYRnksndebs=;
        b=nXI/8wPTHmLYi7m6rc31G8HW1u1f7eOwKHz1Eoe5JKFBQduFs8tx4GoZgR6/4REgKy
         0iGqadwkMNxEtm9VgBlc+Jhov/OMNbakx3LjYuVg+R4OVWHwdUUsEN+4lwbyJnXTnnnA
         E8vv1tsmXjwGJM3uprhF51d91BWBIjos/E7KchUHmUn9BMEa8cY+ZA+JSq/n9sBKBYCF
         yGXgOUrt9s7IMDML2KV45s41xzg+hLVqasz63FqZGDRVuWGAjOXET2ux2ZKhfz5fqQzP
         LiMrCo22aycvdJ5AYPfuuKOaOlgY2IgT85A1o6PE1hCNF7SbFoZCyR3WMUZ7+44ZyxIF
         fYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdbF+pw9w6thId4kMOV09HnHCGHiD/yfDYRnksndebs=;
        b=JOrWlNskQPSGc1J5AS1MhR1MbPCf/UuZmJmTUAWthngkqhkpSYaTjhqLMFKZAhBG6L
         /Rj2n2QyD3uxu1ksx1biyBwG1fFz9iQ5DPKqaBeS/3zswIeQKRA0dVNus2V1WDBXuzkY
         ulDPwM05o9PESnLyBzpWo3qgSRszKhibEqdibNcAv/UsXm6BwfTIBq7kCZjK5szsF3OV
         ijT2X/7LmoB31XdUDL8AaxWod2pB9sjBWMv6RzqjADNHcJnAs39fAZ9EpzyUEpHWlH6e
         ZdNlGg/Kk8HdfVSe+T2iPJMSNVoBzajC+PggYJEs+woPp1w5fu2NhEOX9lAgpNSS22H3
         SqWA==
X-Gm-Message-State: AOAM531iWS6DFeOOsSK5XPQxZd4b+EbR7O4kSfkDbNKmDhDlF0t2jf5B
        Nh+n+btW1ZAc2vOxPvDGh+gYMQ==
X-Google-Smtp-Source: ABdhPJyU6/avcwFzKeSpi7pNdQQyxsUXZ2cKmkh6igdlHCd7qmRMcyQDv9FC+doSi/anPriZ5aO/Yg==
X-Received: by 2002:a17:90b:234f:: with SMTP id ms15mr3339763pjb.202.1623825639884;
        Tue, 15 Jun 2021 23:40:39 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id u7sm1241674pgl.39.2021.06.15.23.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:40:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] cpufreq: intel_pstate: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Wed, 16 Jun 2021 12:10:27 +0530
Message-Id: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623825358.git.viresh.kumar@linaro.org>
References: <cover.1623825358.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state can't be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the exit() callback instead of stop_cpu().

Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0e69dffd5a76..37ad42926904 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2374,17 +2374,11 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
-{
-	pr_debug("CPU %d stopping\n", policy->cpu);
-
-	intel_pstate_clear_update_util_hook(policy->cpu);
-}
-
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	pr_debug("CPU %d exiting\n", policy->cpu);
 
+	intel_pstate_clear_update_util_hook(policy->cpu);
 	policy->fast_switch_possible = false;
 
 	return 0;
@@ -2451,7 +2445,6 @@ static struct cpufreq_driver intel_pstate = {
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-	.stop_cpu	= intel_pstate_stop_cpu,
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
-- 
2.31.1.272.g89b43f80a514

