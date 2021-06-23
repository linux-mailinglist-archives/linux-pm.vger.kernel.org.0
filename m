Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55BA3B12DA
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFWE10 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFWE1Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:27:25 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB946C061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:25:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y14so657390pgs.12
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IsYDkx5V1mJjZwOsL/IXqLmlqBdgt7SKxZu32NLqyoA=;
        b=KoW+3L+nAzHaFgbRElzs5uOdutafEIWxBC8B5+GDKPJmQleXVfldK7z7iqfjfcts1Q
         rPL0kfSafE8oFpk6vrVZuNwIRU6AgR8g80QroxtsUVS3fgsrxmhUjcHJybPvXNrlECFn
         AAucYr0aZJMlHLGw09t3jUjQgj2XGLYNcQaGeuAUDeAoyhWbX1LrqiB6kBBDGV/8z/CN
         ++aB+n41chkQUj2WNQ3WqdialMd1lKj6yKzDF0hXvNUGzITEYsvfRPlJpIra4FVwPNQk
         b7US4tsXnrqo0EG6dj8k2TY/Ebg3EXPdt97zdZ9/IXIIO+2y6YkdmcBVH7hSDt3Fb6qh
         gNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IsYDkx5V1mJjZwOsL/IXqLmlqBdgt7SKxZu32NLqyoA=;
        b=I52eohotLMaS11bjoOBqVhks1AB5+J+KJmun1OOFMplRr0cnXQNiY/esU0a2Q5oPz9
         OsnLsrkmStYRSLn7gNJtjObFGx1/59hkN6ZupmuRNKwOfCGPVj/5skFLoouQyWTf0+//
         8qJslZa/SSmJ/00LR7+sIvJvzXJlgd7zQJkZPYNwUh4iHEWMLE2C5aFxiyUnA1XSEsLC
         J6WAW3hd7BCufZAGzL0A5UsKDaIuJYM6aAi6ew34jCrgKnL6j0EEMH+B6mvCq8g4vyez
         s/Dc56cAIn6/qYiewTEIIczqO4lvNMUcAiMFvojzqNlb5aMpT1dOMALJhaQHmJfsKG9u
         bYPQ==
X-Gm-Message-State: AOAM530oKnSzHT4hB3nb6czw8DlRmIAAexmZR6xWUBS6ywnPHEW+FSeM
        3q/NEfBCX9LK1/8/rw+NgsxuPg==
X-Google-Smtp-Source: ABdhPJykxyALIdJtvZ3O3tAzyqaObMPTohAMm6rjwil0SUh9TpEoeEcPD3F2IEayX6QLESd2Wz/U6g==
X-Received: by 2002:a63:5743:: with SMTP id h3mr1946424pgm.362.1624422308452;
        Tue, 22 Jun 2021 21:25:08 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id u11sm3770311pjf.46.2021.06.22.21.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:25:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/4] cpufreq: Remove stop_cpu() callback
Date:   Wed, 23 Jun 2021 09:54:42 +0530
Message-Id: <56e8fadcecf014ef0786499fbf4e93975b123483.1624421816.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624421816.git.viresh.kumar@linaro.org>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that all users of stop_cpu() are migrated to use other callbacks,
lets remove its support from the core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpu-drivers.rst                    | 3 ---
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst | 3 ---
 drivers/cpufreq/cpufreq.c                                 | 3 ---
 include/linux/cpufreq.h                                   | 1 -
 4 files changed, 10 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index a697278ce190..74fac797c396 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -71,9 +71,6 @@ And optionally
  .exit - A pointer to a per-policy cleanup function called during
  CPU_POST_DEAD phase of cpu hotplug process.
 
- .stop_cpu - A pointer to a per-policy stop function called during
- CPU_DOWN_PREPARE phase of cpu hotplug process.
-
  .suspend - A pointer to a per-policy suspend function which is called
  with interrupts disabled and _after_ the governor is stopped for the
  policy.
diff --git a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
index 0ca2cb646666..9570e9c9e939 100644
--- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -76,9 +76,6 @@ 并且可选择
  .exit - 一个指向per-policy清理函数的指针，该函数在cpu热插拔过程的CPU_POST_DEAD
  阶段被调用。
 
- .stop_cpu - 一个指向per-policy停止函数的指针，该函数在cpu热插拔过程的CPU_DOWN_PREPARE
- 阶段被调用。
-
  .suspend - 一个指向per-policy暂停函数的指针，该函数在关中断且在该策略的调节器停止
  后被调用。
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cbab834c37a0..5e4b5316d254 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1606,9 +1606,6 @@ static int cpufreq_offline(unsigned int cpu)
 		policy->cdev = NULL;
 	}
 
-	if (cpufreq_driver->stop_cpu)
-		cpufreq_driver->stop_cpu(policy);
-
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 353969c7acd3..2e2267a36502 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -371,7 +371,6 @@ struct cpufreq_driver {
 	int		(*online)(struct cpufreq_policy *policy);
 	int		(*offline)(struct cpufreq_policy *policy);
 	int		(*exit)(struct cpufreq_policy *policy);
-	void		(*stop_cpu)(struct cpufreq_policy *policy);
 	int		(*suspend)(struct cpufreq_policy *policy);
 	int		(*resume)(struct cpufreq_policy *policy);
 
-- 
2.31.1.272.g89b43f80a514

