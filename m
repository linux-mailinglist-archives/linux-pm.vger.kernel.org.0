Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C9531D336
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 01:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBQAA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 19:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBQAAz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 19:00:55 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28683C061574
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 16:00:15 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id q85so11236824qke.8
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 16:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7pgxfLYtB4b4dqlNRuCkDcBYdwrqTW32/gAXyaE8lXM=;
        b=i2C77GrEYhmSVsDSIlvbowp1+1tIWUO2pPflB6TfUO8/UZuZTeEOCS0o0LAV6JxHUz
         JO6YOis2IlNULxuxeACG5HlZwd0bXumgAgC2u7sFkVwlOeCuaofn+dBSRezXRLb1iPRf
         gvvXlFUs75h56CtGgoG2PHUdJOZmPvfPUKQyB5Qhp2d6Bit6nJsjSjWa8fxkA4t81ZEO
         oJJgV0rM+midM4o+RxU57dzfgmjSeNEumY5/TskkrCz4pGTCW1suJUN+JAH3KbbRnkai
         dMazmQgMxWmwRUwtKLvIt0tN4EsQP0ZiKLzAIiirrNre3dQKNBxCxZozHYRJ0CuMFJhc
         Hm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7pgxfLYtB4b4dqlNRuCkDcBYdwrqTW32/gAXyaE8lXM=;
        b=bUkHc1ayS4ZrKX8b6/t2i+ZVH3V/LdQ7vX9JU+fjylOgFF9AwCHdXVJ74eeMCO5RPi
         r5VtGqOq6mmnikDEmQWakADy8ZMY/4HuGnFel/bU3kjCAkR4udoT8DNpCefDluq9hIt9
         w3OSfNAApJfOkXit1uQ5ny58rAyzgF9V9hgAVZA0VyrK2juJUmvY/RpwYs645SWKKXTF
         MHdTv/3+qIxpG+7qxYEDVUZ0qI1bbEYdyvsjIXVTi9xe4E0PyVuz2AgE/LD5GYNEBYNW
         TfuwgCIlD38SbcmkD8ZUZiJ9rgPK1QGNwLABqtNVR4osU5GdolGms36B8pLiBR7zOSWV
         Pc5w==
X-Gm-Message-State: AOAM530ajJKt09gf+bBjYYkFnhhlBENl9BiGE+zJKBeYfIAc33B+YYBX
        vAAPOyzEhdKdxw+WHFzi27CzHQ==
X-Google-Smtp-Source: ABdhPJykqFxNudS+GmqRQWf8wikxvlbLHS4VcisT2qH/HdTqsT2hMFYTRhK64deqnxhel8d6Oygj2A==
X-Received: by 2002:a05:620a:1435:: with SMTP id k21mr17977868qkj.289.1613520014253;
        Tue, 16 Feb 2021 16:00:14 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g21sm94091qtv.68.2021.02.16.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:00:13 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] cpufreq: exclude boost frequencies from valid count if not enabled
Date:   Tue, 16 Feb 2021 19:00:13 -0500
Message-Id: <20210217000013.4063289-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a fix for a regression observed on db845 platforms with 5.7-rc11
kernel.  On these platforms running stress tests with 5.11-rc7 kernel
causes big cpus to overheat and ultimately shutdown the system due to
hitting critical temperature (thermal throttling does not happen and
cur_state of cpufreq cooling device for big cpus remain stuck at 0 or max
frequency).

This platform has boost opp defined for big cpus but boost mode itself is
disabled in the cpufreq driver. Hence the initial max frequency request
from cpufreq cooling device(cur_state) for big cpus is for boost
frequency(2803200) where as initial max frequency request from cpufreq
driver itself is for the highest non boost frequency (2649600). qos
framework collates these two requests and puts the max frequency of big
cpus to 2649600 which the thermal framework is unaware of. Now during an
over heat event, with step-wise policy governor, thermal framework tries to
throttle the cpu and places a restriction on max frequency of the cpu to
cur_state - 1 which in this case 2649600. qos framework in turn tells the
cpufreq cooling device that max frequency of the cpu is already at 2649600
and the cooling device driver returns doing nothing(cur_state of the
cooling device remains unchanged). Thus thermal remains stuck in a loop and
never manages to actually throttle the cpu frequency. This ultimately leads
to system shutdown in case of a thermal overheat event on big cpus.

There are multiple possible fixes for this issue. Fundamentally,it is wrong
for cpufreq driver and cpufreq cooling device driver to show different
maximum possible state/frequency for a cpu. Hence fix this issue by
ensuring that the max state of cpufreq cooling device is in sync with the
maximum frequency of the cpu in cpufreq driver.
cpufreq_table_count_valid_entries is used to retrieve max level/max
frequency of a cpu by cpufreq_cooling_device during initialization. Add
check in this api to ignore boost frequencies if boost mode is not enabled
thus keeping the max state of cpufreq cooling device in sync with the
maximum frequency of the cpu in cpufreq driver.
cpufreq_frequency_table_cpuinfo that calculates the maximum frequency of a
cpu for cpufreq driver already has such a check in place.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/cpufreq.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9c8b7437b6cd..fe52892e0812 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1006,8 +1006,11 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
 	if (unlikely(!policy->freq_table))
 		return 0;
 
-	cpufreq_for_each_valid_entry(pos, policy->freq_table)
+	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+		if (!cpufreq_boost_enabled() && (pos->flags & CPUFREQ_BOOST_FREQ))
+			continue;
 		count++;
+	}
 
 	return count;
 }
-- 
2.25.1

