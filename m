Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABD142452
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 08:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgATHle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 02:41:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33041 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATHld (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 02:41:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so12832066plb.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2020 23:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6QkfOHa+fXWPbqhX4fg/BSSEFLkJC5nKGWeuXTDHy0A=;
        b=hQJu9kN9+b47FmjPHhQJd5BW+Db3y87CWJgoCXkTHKMFrCBHiUWhv9v91PO0/f8L3C
         tsdNyrTe+h3Wf3JSRuOgXRTwubD89yw2FRv0Q0QxwSz4KIsD4arZbglh90tCpYaHO77s
         g8rGQkhMpcrJuehwOdI49P/Vz7JNwi1MFZa2q2xtLB2E3YxyhttEXcZIqoImHVDE3r8E
         p7X8GnmvSP5csBnuX6YgHIOMhwuXbizslwfiIz3NtelRcK1Fa7d0KfLagPlZEZlWMVzt
         zinMMU6RRZ6gBspy01WuMYkcWtMZTmEIG/nLP4fGa4Ih48BdPxtykTRmb4VWAXiMB8np
         ePlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6QkfOHa+fXWPbqhX4fg/BSSEFLkJC5nKGWeuXTDHy0A=;
        b=tDfpj42iLsmTixv+aEqxZSlx2KBLBqgj63SfzXfH2KnbrwUxLXl5fQH+xmI7WIB3ok
         7d0YBa7m+JxnV3uQi1QthsljzICDPWsVpc7KQNWGVxw0lfl+WBDHqDOHespSwzYcBala
         7uyMmJ2Q7YMGwqpDi6yY8BG3dLEdEWuz0Uu8XDpYHh+10wEVgDalWeHnH3XQSASbqRd5
         WysS6QiTkLod6WDW6jNm2/aYfRDH151bW1h5UEbRZlYwnLR+1Lb4mzp4wl7nEl3jXvP8
         lgy/apfbn+KdlJylD1CyQZs9hTrUbvKHsRIeaQAdirddTkxxLry7jnZyHFir2jnHO0mA
         ySYQ==
X-Gm-Message-State: APjAAAWLlrhbj0O/1lzZ7h7CPY/nbMnRuSufni4m9HNBhbx7XNtdAewJ
        ppKoaHqhxXKvcgtDnyPC9uI=
X-Google-Smtp-Source: APXvYqwHpqndko+Jyi28mqdGoJyYQK4968v4mpRNIcSF2VVk+2l7i7mo+JPwYIhXu7HHKEPSvO4gtQ==
X-Received: by 2002:a17:902:6904:: with SMTP id j4mr14045937plk.88.1579506093288;
        Sun, 19 Jan 2020 23:41:33 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id i11sm8090946pjg.0.2020.01.19.23.41.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Jan 2020 23:41:32 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mmayer@broadcom.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v4] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy refcount
Date:   Mon, 20 Jan 2020 15:41:28 +0800
Message-Id: <1579506088-6736-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq
policy, meanwhile, it also increments the kobject reference count
to mark it busy. However, a corresponding call of cpufreq_cpu_put()
is ignored to decrement the kobject reference count back, which may
lead to a potential stuck risk that the cpuhp thread deadly waits
for dropping of kobject refcount when cpufreq policy free.

With this patch, the cpuhp thread can be easily exercised by
attempting to force an unbind of the CPUfreq driver.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
changes in v4:
 - Rewrit commit message.
 - Use cpufreq_cpu_get() and a corresponding cpufreq_cpu_put()
   instead of cpufreq_get_policy() for promoting efficiency.
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d..0767206 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -453,7 +453,13 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct private_data *priv = policy->driver_data;
+	struct private_data *priv;
+
+	if (!policy)
+		return 0;
+
+	priv = policy->driver_data;
+	cpufreq_cpu_put(policy);
 
 	return brcm_avs_get_frequency(priv->base);
 }
-- 
1.9.1

