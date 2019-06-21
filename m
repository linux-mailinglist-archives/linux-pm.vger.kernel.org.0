Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40ADF4E8F3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 15:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfFUNXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 09:23:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54896 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfFUNXc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 09:23:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so6305992wme.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=abmrRJIbn15CKe4jAYwpNznA72/AKAAATV1fQchJZq8=;
        b=cdA8J+bs/MRPvemLKcO6rzSy1aIFncfOfsoPbv9tLkihvL9mR4vUHXGqZNRGWY8WeV
         1n9+lWedZTxuMsje160UJwcaqNftcjDQp4mxgB7FHoYZI4CSc75WEBKTHuQic248qlmi
         pazm4zf7Y1Pgjm+nUkUA77Wu2YaqCgurF5nI35cHs15xD75THN46ZKDrj/7QSBboJzk+
         PLvf9reZ/A4i9sggeYiNObhNmqpgzzWYJIbaPZtAjwEiIqVz/KeRzHpp93W4+GOZwRpV
         SA3x+XMTA0QvUIedkoGk4pc4pvnMUVXuzwvE9uMOKHkU/KGf94zZkX0uI9wdWxlDbz9L
         ky8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=abmrRJIbn15CKe4jAYwpNznA72/AKAAATV1fQchJZq8=;
        b=jhMd3pYiW8ywqnbQV6eXKc9/dsZ7JKCEBZ5XFOJwGL0I1TUJjycZ9dv4KdbF7wyzYY
         T3PkxTrWisHHFwG9btjvxZ7oriQ3mFqzx6gaymBSN+NYpKrKMNtnat4+8bgFj679NTnd
         XSY67n10337VXsgmd3J5BvmK7zjpqVgplXeUfqVHSP/NSkyfqIMWAkrX1A4uwiuvpINa
         bmZ21E9oBA3X04UfLkkn/EFwEAPbk36NKDAmi9P4aF0YI2C4eFWgADh/3TILPRyov1Mt
         EBPj0MrY+NDU+WwpRMepAkLRT07CGi3wxFxDrlv/iu9PIWwB0xtK96+1VVzo+sOf5ed2
         XqOw==
X-Gm-Message-State: APjAAAXl1tNDgdzNhmVtLaGjYel5Ch257p+7QAKWpWhPsBUta+zw9Ocv
        ZGB/x0LyrMuVUzMLzmmN9RXZig==
X-Google-Smtp-Source: APXvYqx15WC+pGOYPsxUjY6M0s5AxON7z4GMohrz0VtpXz087dwRWRTMtDN6uRHy9tTaPz2oKaVQAA==
X-Received: by 2002:a1c:8a:: with SMTP id 132mr4159361wma.44.1561123410813;
        Fri, 21 Jun 2019 06:23:30 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH 4/6] cpufreq:  Remove cooling device usage
Date:   Fri, 21 Jun 2019 15:23:00 +0200
Message-Id: <20190621132302.30414-4-daniel.lezcano@linaro.org>
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
 drivers/cpufreq/cpufreq.c | 6 ++----
 include/linux/cpufreq.h   | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dfbc9bea606c..1d8f85faeaca 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1379,7 +1379,7 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->ready(policy);
 
 	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
-		policy->cdev = of_cpufreq_cooling_register(policy);
+		of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
 
@@ -1468,10 +1468,8 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
 		cpufreq_cooling_unregister(policy);
-		policy->cdev = NULL;
-	}
 
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d01a74fbc4db..9a42711f338b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -144,9 +144,6 @@ struct cpufreq_policy {
 
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
-
-	/* Pointer to the cooling device if used for thermal mitigation */
-	struct thermal_cooling_device *cdev;
 };
 
 struct cpufreq_freqs {
-- 
2.17.1

