Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7CC253D2E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 07:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgH0FYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 01:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgH0FYW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 01:24:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56249C061240
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 22:24:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i10so2533277pgk.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 22:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWnOmZQiE1diGG7f4xMEwIVX10lb7UFm+giUYyHedJQ=;
        b=kRaZNdmGKAg4HLrE/uGXgzjrobjeg9t/Pk1pY/YiXJZG9LKcE3HWgvpc4pXBQdT/Dp
         BaxA6FsrvZamlFnpGRQfXE9kC616WOSDQ+UkXmHO/nVFHtVRF3KfvAlKf0HVXh4O9ED3
         RpTwruLbf3b8F+mcY1Z9kMuuz7h6G9SICrgihKOAfx8BPtrYjBw9dDEDjZ3f2Y2aCD7b
         /uQWeevM+9Lk0bvjrRJMSn9D+v/jHpvXY+fyM2NVl5fuXGJMU35CMX3EOqBr5vRBq9gw
         cUI0oG4KZ6HRY4MaES8SY9+2m1Wx2QSkcsw8LU7zafJbDKf4IVnSwo9VMnNgBjCljAp4
         OBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWnOmZQiE1diGG7f4xMEwIVX10lb7UFm+giUYyHedJQ=;
        b=cbRK0xmUzKNknkNA/85R581Mrtr0xSsjodNiUSZfNPZj8JvEG5LsxvOBixxngyTeHg
         FDBUU90IagVi5l8p0w4WRRsMUS59DAimNZpN5u70a8maKpSiWb0zv6Tuy9Xi6Fe1/wYM
         KA93VnLmCIK+1zX5MYtjh5ZqEcSt0Sm0hX5Fa6YXeFPov9RqXaDycf2+nKY3Tt3JR7ww
         pJN6XX2yS4fC4YlJemGbF4PiFs7H9XQgk3lmHweNva6Ge0eH19Sg2/XTFkN7ILpl8eh9
         /1DrhxQ25FZu1yuWaNHHA8p3EwbhEhiQkDjjoAH1GyAah3T39bGWWrGKNQ+6XjMa1RTz
         R77w==
X-Gm-Message-State: AOAM531HFtTuTPcOtrOKaguCH2WrKuqbnTKBWaL8XRO2c6pEBZYnkrRb
        13jvJx3PbVf7zGFWof8+MN4c1Q==
X-Google-Smtp-Source: ABdhPJzLh8QWqb6t7LN/bIJ2Bx9v84RwevI1yawLpJgTb5mA0YA9lIcxzQ+ainiIvHZ6F4jr/Q+fXA==
X-Received: by 2002:aa7:91ce:: with SMTP id z14mr7473320pfa.241.1598505861790;
        Wed, 26 Aug 2020 22:24:21 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id mp1sm858405pjb.27.2020.08.26.22.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 22:24:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: No need to verify cpufreq_driver in show_scaling_cur_freq()
Date:   Thu, 27 Aug 2020 10:54:15 +0530
Message-Id: <906198d77aa73613a1b588425aa45e5025ee60cb.1598505843.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"cpufreq_driver" is guaranteed to be valid here, no need to check it
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02ab56b2a0d8..47aa90f9a7c2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -703,8 +703,7 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 	freq = arch_freq_get_on_cpu(policy->cpu);
 	if (freq)
 		ret = sprintf(buf, "%u\n", freq);
-	else if (cpufreq_driver && cpufreq_driver->setpolicy &&
-			cpufreq_driver->get)
+	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
 		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
 	else
 		ret = sprintf(buf, "%u\n", policy->cur);
-- 
2.25.0.rc1.19.g042ed3e048af

