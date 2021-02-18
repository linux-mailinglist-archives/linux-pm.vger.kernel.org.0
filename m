Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B931E8C4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 11:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhBRKjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhBRJYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:24:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEC6C061756
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:23:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id f8so924446plg.5
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzVpT18eiAjHhO55WLEfdJyCyX2yASsyssyrGm3t5zc=;
        b=nktXpTqv4+aRwS7BgGmAy7n74qVgUSi7upG3YxO85EvXNra012y0f92XRVT/lgqRXZ
         A2RHMIHjpNmCgfVCnZPfbTFyJknZNjpPlB8unWHmMUPWw+D3SbFDOYAkkxvSn7AhSPff
         ZElwY1wrUUirwM5HovqREeaimltZX4PS+KEqZmyolmtFnABM3GgefqHbBstvH0OgAdcR
         GQWeeBBtNFlbc2dW9Q8DmVpUTwTUrPwnUUVenrnkwynaaYDtnajSqkxx4nG3mfseDhhv
         o8HtJ5aUnt0g3UIE9AbtRN48SjaZJ4C9yrgm5HqsrKmUEU49ZSk91Kn4oUmo8lpCI5Jg
         5QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzVpT18eiAjHhO55WLEfdJyCyX2yASsyssyrGm3t5zc=;
        b=Yj1dx0w4st6dmmJeEiQsUFJjA/G77m5322MJSi0F3DxS0QdspKa4+RxOi0D2Wf9EDT
         s+1Bo0I9nlDBX8PREF93PjY7cmpbdSiqYudTNKaODP9P2c9Xu6n4iUVtT2LrxpAf8y9f
         jGqHGwLeGEIJrghqoDbE8RSLUymtXPRp4Qw9ZEtPj4WBjrfMqbLBrR/kGer87Nhpg8mk
         BFByM3xLq5VkyrzYU5zX9lYd22kw7D0tIrbQN5e3VRNLXmkuzKFrA1fRSAHVOnX/rNH2
         J5Vzr4Wg78QTcMXLLLBVMojYsVhgdYWs+A9x3qXmN6DUa5lGZZnGaTNknsG+JOIjBlxr
         5DAA==
X-Gm-Message-State: AOAM533qvuuDUNbZLrZLnMmZ2H54jCTrod0/oN+6dYy/A2wNkAfyK9wa
        WwaUEoYZlCwXdDWTGqzl8AE=
X-Google-Smtp-Source: ABdhPJyJZCppCUy4Z8u5FF0PiXFqagGNDjJ8jH/RzvSmWdtl+0WF+tH/PFoDLw/AaK4vZFyOHigeWQ==
X-Received: by 2002:a17:90b:1093:: with SMTP id gj19mr3163766pjb.40.1613640219605;
        Thu, 18 Feb 2021 01:23:39 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id e6sm4981965pfd.5.2021.02.18.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 01:23:39 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] cpufreq: schedutil: Correct comment to update_lock of struct sugov_policy
Date:   Thu, 18 Feb 2021 17:23:16 +0800
Message-Id: <20210218092316.1624-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, update_lock is also used in sugov_update_single_freq().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index add8081..cc0308c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -26,7 +26,7 @@ struct sugov_policy {
 	struct sugov_tunables	*tunables;
 	struct list_head	tunables_hook;
 
-	raw_spinlock_t		update_lock;	/* For shared policies */
+	raw_spinlock_t		update_lock;	/* For single + shared policies */
 	u64			last_freq_update_time;
 	s64			freq_update_delay_ns;
 	unsigned int		next_freq;
-- 
1.9.1

