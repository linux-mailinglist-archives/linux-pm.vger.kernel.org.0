Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D574A399E
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 22:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356338AbiA3VCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 16:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356297AbiA3VCS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 16:02:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283DC061714
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v123so8859106wme.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuuKJA9f7YLqLdO+mCS1Ti2MxJr1lgIYr2C1PeNLK3o=;
        b=LbWR9zg7i3nGEVZfAWrd8y9KBE6WPoaZlzZMNezQfJDsHfPZRQQtgiktinT+/vS1eZ
         +UY3n/PqmpUdGOzOz5Aozq5DdIkf2+jj8Cdd63SLp/J04iN3p3mVFPSvkzqG76x72d8j
         tLcyE2g7Bzpmh5wcr+S1hjbV1KJ9m9fXw/Dr21UNoCBYdWEJclqzFUI7UEikNZ7lkazU
         leW6VN9weB8m9JEMqgXytYAJpTfamaR4Xre6JtDemJ7zB3QpCZvXRcBNVBaPBYAIiV1E
         9oxcQAWa2NggJ3uSlxchQWdlRHvj4x38j/LwzqGI+y9vwYE0RCheOrbTAPx4GCTEviJx
         fOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuuKJA9f7YLqLdO+mCS1Ti2MxJr1lgIYr2C1PeNLK3o=;
        b=WeVSpQwx8CPAZR+o+zcQOo0t9OcNvnQQ4L6A70IpOPMi8zaTqMvaZxoUaUF5JLOPoF
         TN0B02s2jv3XzVxAA+pKpiF2HNYpt4KIEcO6M01ml4rGSP9Jhm+LqmpKNWZuGBmXCph4
         Odtix05P8VO60yKEhCpthGJ25CORxpSA7Iwk676xRJKk6Ie4kSEcv57fs6zdwVbY7+MG
         2EwKxqRiobC2V1pAetWBpyd2fLoG1LuuNJTqdpKAVOPQab4n6YjWIl0HEN5GXoThdkdC
         O3CcWkX4FJkn8H+zPL8QzVtwunzx2jKY0FiaDe+DE2IBQqJywCO7P5qZ1+NJgqfLEfF9
         enLg==
X-Gm-Message-State: AOAM532Zv+NXRkFNvwmKfLfXYlVVAuRpXlZbPzl7J2HW3HyfD7ABDcHv
        K22q+hsrTcKxyPlzCJOtU+2zuQ==
X-Google-Smtp-Source: ABdhPJyWDx9xdG/aa6AnVmD8qw4WCzO4tJnIyuqpp5B3OJMmIPBunA3OFRRAHgysZmgFcQTbJRShXg==
X-Received: by 2002:a05:600c:3494:: with SMTP id a20mr16200921wmq.129.1643576536119;
        Sun, 30 Jan 2022 13:02:16 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/7] powercap/dtpm_cpu: Reset per_cpu variable in the release function
Date:   Sun, 30 Jan 2022 22:02:04 +0100
Message-Id: <20220130210210.549877-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The release function does not reset the per cpu variable when it is
called. That will prevent creation again as the variable will be
already from the previous creation.

Fix it by resetting them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index eed5ad688d46..71f45d2f5a60 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -151,10 +151,17 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 static void pd_release(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
+	struct cpufreq_policy *policy;
 
 	if (freq_qos_request_active(&dtpm_cpu->qos_req))
 		freq_qos_remove_request(&dtpm_cpu->qos_req);
 
+	policy = cpufreq_cpu_get(dtpm_cpu->cpu);
+	if (policy) {
+		for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
+			per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) = NULL;
+	}
+	
 	kfree(dtpm_cpu);
 }
 
-- 
2.25.1

