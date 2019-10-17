Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD3DAA0F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 12:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408876AbfJQKbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 06:31:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34908 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408870AbfJQKbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 06:31:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so934300plo.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F14E7+MnIlpQiExL8cWFs9niwCwKQjYO3IRinn+L/UE=;
        b=mJkfaeHTf5SBolO1l341lKb2fM/RiZRWB6y8rVMAkkkS+3N2h6YC2xVz6Tm2TmGi+a
         SXHCEbQSnH8epN9/FUj9MslvLwHwqTbB7LeNYnG8jCOBESG4GHYnUBHT7N9vpHi+kXY/
         sH7OmR9uZm1/erNfJi0NzI/usUghKUPxI+ngYZ5YA3aG7p1IpGa/Dl6uUaeP8gPWCFdw
         jZ/w3TB+FHwiiHELD1a6blOq5bkei/6E8xHgNmhdms7YlSLW1MibS/ABwGmTXTAJTKQP
         9V1sbvG363bhskzlo8JPrnWuflf2+8vj5mZuCr9KRgmmTmcfRjb+zii8bAVSmo5Xpgnf
         y6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F14E7+MnIlpQiExL8cWFs9niwCwKQjYO3IRinn+L/UE=;
        b=shlK09g2JpWW6cDrXXugZv3UJ0c5iRb0cS/NzlXZsi6NKFzxc/gUgmsrEpL42beqO7
         HrHZUkVz+k0YFCj4l2MhP8ASWJiNDjOIXVq8b4SHJovEpBFAsh5t0e1iV0FVCwCTZ+bI
         tRJZVNHLUyhSj0KYx6MMHjd0mI3Gtic7wi2y4HoInCW+9pWL+wnyFFBDCbwsHraLq9AB
         wPHx1nyzhBHKAdcPWqGj/u690lgj1Ul47bqMHRw2Gyv4cPQr0pKenzJCk23N3Tywa6/s
         LoT/Kza/+owm0zxek0LVYdj/q385dKd1xEl8Thb1+Tr9Il/qXMXf07JDd1gFvvQE31Ka
         9bSA==
X-Gm-Message-State: APjAAAWZtVC4pjcOihzYEE2rcShlLyhhimD45qo0Is7a5VtAG0jiA7kp
        wHhpfxHEjWpmruxBbNQ4uw/3ow==
X-Google-Smtp-Source: APXvYqy1LP7Lthi555ShDVQUVG8kkkNA3uUgauY6GCI0jNrgtxDAa6pq5gTrjM3/cNT063eg1b02vQ==
X-Received: by 2002:a17:902:fe86:: with SMTP id x6mr3301438plm.320.1571308266786;
        Thu, 17 Oct 2019 03:31:06 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id p11sm2133031pgs.51.2019.10.17.03.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 03:31:06 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 2/5] cpufreq: Initialise the governors in core_initcall
Date:   Thu, 17 Oct 2019 16:00:51 +0530
Message-Id: <f1d7214951e4b2caa394c722b4d8aaca9cc2c4c4.1571307382.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initialise the cpufreq governors earlier to allow for earlier
performance control during the boot process.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
 drivers/cpufreq/cpufreq_performance.c  | 2 +-
 drivers/cpufreq/cpufreq_powersave.c    | 2 +-
 drivers/cpufreq/cpufreq_userspace.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index b66e81c06a57..737ff3b9c2c0 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -346,7 +346,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_CONSERVATIVE;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index dced033875bf..82a4d37ddecb 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -483,7 +483,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_ONDEMAND;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index aaa04dfcacd9..def9afe0f5b8 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
 MODULE_LICENSE("GPL");
 
-fs_initcall(cpufreq_gov_performance_init);
+core_initcall(cpufreq_gov_performance_init);
 module_exit(cpufreq_gov_performance_exit);
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index c143dc237d87..1ae66019eb83 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -43,7 +43,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_powersave;
 }
 
-fs_initcall(cpufreq_gov_powersave_init);
+core_initcall(cpufreq_gov_powersave_init);
 #else
 module_init(cpufreq_gov_powersave_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index cbd81c58cb8f..b43e7cd502c5 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -147,7 +147,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_userspace;
 }
 
-fs_initcall(cpufreq_gov_userspace_init);
+core_initcall(cpufreq_gov_userspace_init);
 #else
 module_init(cpufreq_gov_userspace_init);
 #endif
-- 
2.17.1

