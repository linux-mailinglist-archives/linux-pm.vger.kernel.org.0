Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84B18E3FA
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 20:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCUTbz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 15:31:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgCUTby (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 15:31:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so11664306wrd.0
        for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2020 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tAhMZYvG/G7C+UxGyPYY7dK/Sq4D4s4ohO0yGJZTXxY=;
        b=SFSkxNikzlUEPoZZkz9LGgx8W0ZYrakIf9SQ2cED+xBRql8xEffMwXkqluyb7PYY2D
         MrPKftWf9bd/BJV6ZAdi573Gp+F7dSKXAswYTRvUTubdzO6nIuYDgE4rVLNvsdMmbBn3
         fGVuGxYINpcwDlYoZ9OBMMFny6gPsg9dqoFbqXwtQk8zTn7esFWJE6l2FGikN/AluTwT
         HjZLD27u0oiAwJlawipPVhVgrhaIQyVOoZOhawyJ2jGaqC1VoeeUiEWbc0DZWjtuR+N5
         vPZwwKc6+7O9JFOZJUt010k8EM+Dj/BZqtkwhICSdbd8czvcrvktfcjMNQXz2gA/Rlbw
         6gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tAhMZYvG/G7C+UxGyPYY7dK/Sq4D4s4ohO0yGJZTXxY=;
        b=hMtqf7CNUsw9g/Mb4a2o13gPFizZEYhZXW6frzONcf+PnJRvxelhjEtUp12Y/KVTcK
         QUk+LWENlujCy7z+dguXu6O80wwZYL1Zzc22uNaLQfFV80qKkgKHJzKTkwdsQl0iLVfV
         zBH+5MDW9GLEq1mYfHV/podjehxc0ZAJfsaWSxs/c9MoprorlhpoGNx0paYrVu2x5kMn
         /sdzfrnGJc3yxCLLaKjSrB6xOLKaR9yiUJiHj4GJew+qgZ+0Y4FJIYnqU9Ywz+nD3ber
         1DeuYgB2EJXz0oMZkTFtvbWdoTihUMaMfsxpG/YBda/kfZasE3PfXRoOZkN/0VreX2ri
         5aDw==
X-Gm-Message-State: ANhLgQ24SABXfk5N3hYRqEON26n7UnNE0eZqxpg/hnWfP+gWX87rtNLA
        N9jcTpy9PfUmkCXjVYaUfTD5KOzw0O0=
X-Google-Smtp-Source: ADFU+vviGuHhsNoh791a6fmt5zGMi1TMVN4TNwD7gf+jlyLbXgSp/3Ucq0V4kGML+qzTr1054nIAgQ==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr16031186wrp.84.1584819112216;
        Sat, 21 Mar 2020 12:31:52 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:ca2:a5ed:e238:a0c0])
        by smtp.gmail.com with ESMTPSA id n124sm8990714wma.11.2020.03.21.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 12:31:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/cpufreq_cooling: Remove abusing WARN_ON
Date:   Sat, 21 Mar 2020 20:31:07 +0100
Message-Id: <20200321193107.21590-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The WARN_ON macros are used at the entry functions state2power() and
set_cur_state().

state2power() is called with the max_state retrieved from
get_max_state which returns cpufreq_cdev->max_level, then it check if
max_state is > cpufreq_cdev->max_level. The test does not really makes
sense but let's assume we want to make sure to catch an error if the
code evolves. However the WARN_ON is overkill.

set_cur_state() is also called from userspace if we write to the
sysfs. It is easy to see a stack dumped by just writing to sysfs
/sys/class/thermal/cooling_device0/cur_state a value greater than
"max_level". A bit scary. Returing -EINVAL is enough.

Remove these WARN_ON.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index af55ac08e1bd..d66791a71320 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -273,7 +273,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
 	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_cdev->max_level))
+	if (state > cpufreq_cdev->max_level)
 		return -EINVAL;
 
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
@@ -434,7 +434,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	int ret;
 
 	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_cdev->max_level))
+	if (state > cpufreq_cdev->max_level)
 		return -EINVAL;
 
 	/* Check if the old cooling action is same as new cooling action */
-- 
2.17.1

