Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1057B1320BE
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgAGHxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 02:53:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43064 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgAGHxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 02:53:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so28102885pga.10;
        Mon, 06 Jan 2020 23:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GMdG9C8gJ7OZ2qYcwQfhLhwA7M4DoIR48FAZQb2CpY4=;
        b=mfvZ+nl2VOwro4m+RGPrIAHd9QL3VAMj3xze93E0KgwrT0CEke/1XWO1ksUbFoD4WT
         mwb4yEhiHZW4gKn0HFkuzy5VMYspLmyyrQ9kIfG9FFl+AYlwio5Iy7jG1g29eMIDBjnh
         zJOQ1VXVnxKLhntqNVi2P1TC0V8yoOc+hv+dRj72dMHKjwVuJJQOlRDXlUEY51oahwiC
         ykJgdkzEWOq3oLpn6VEBq37SYqjVvFE0jyKtYW1BFdmA0X+u2a7Hj0R3Twh8lNKdyF1c
         jncMj52STZjNx3adg2l2H32sU49Mq8sJtysKoQVRczxWbOu+EBOFjsgy9UjmBD02Z6T5
         E9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GMdG9C8gJ7OZ2qYcwQfhLhwA7M4DoIR48FAZQb2CpY4=;
        b=dTVZF/CZbHsSZuv3H6xKyKdwvCcCTTE1GIpgyShcudSE8pno7RUHEJhLgMxeDxxNrj
         yJJ+kunr3uXYB+7hfxunbLml+b1bbyFrSm/5QnNTJSIjbGyaS9+UYuzhvIm74xj/53jy
         9G3Ih6Y3zusrC/xJieUcWOk5+qjtn6gmCdBCCECfwoVsr6DFHE5sO5qDsL2DVhaccbU9
         pT2/bVEeyLvKipIeREFWgiyFkilqeDF9m6e1LJsKWKxbHam4qJjjk8SFmZ6SYP1AyQEU
         ZQT6woU2jefVuGfX87Sfjc2W2iRbaE6xLQfWeAN30xmRywiNtummK9aS4xPtbtQC8gcY
         i8Ow==
X-Gm-Message-State: APjAAAVCufJcYAugYOuwa6k04Tk2N/TEaR4u6NZZOgQRPu7TUze/VOz+
        J9Gwy7KObJQfq3ZLZ4n163g=
X-Google-Smtp-Source: APXvYqxUraKm+6Ut4JR7yPdItBEf0sH/C13LFJ1ca0YNFjLZ6M9LUSaQ2Eoxggm0c3PCL30r99EpfQ==
X-Received: by 2002:a63:190c:: with SMTP id z12mr106706246pgl.1.1578383604790;
        Mon, 06 Jan 2020 23:53:24 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id g67sm79798005pfb.66.2020.01.06.23.53.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Jan 2020 23:53:24 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v3] cpufreq: s3c: fix unbalances of cpufreq policy refcount
Date:   Tue,  7 Jan 2020 15:53:19 +0800
Message-Id: <1578383599-11207-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

The cpufreq_reboot_notifier_evt() call cpufreq_cpu_get() to get the
cpufreq policy of cpu0, meanwhile, it also increments the kobject
reference count to mark it busy. However, a corresponding call of
cpufreq_cpu_put() is ignored to decrement the kobject reference count
back, which may lead to a potential stuck risk that the cpuhp thread
deadly waits for dropping of kobject refcount when cpufreq policy free.

With this patch, the cpuhp thread can be easily exercised by attempting
to force an unbind of the CPUfreq driver.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
changes in v3:
 - Rewrite title and commit message.
---
 drivers/cpufreq/s3c2416-cpufreq.c | 12 +++++++++++-
 drivers/cpufreq/s5pv210-cpufreq.c | 11 ++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 1069103..5c221bc 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
 {
 	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
 	int ret;
+	struct cpufreq_policy *policy;
 
 	mutex_lock(&cpufreq_lock);
 
@@ -318,7 +319,16 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
 	 */
 	if (s3c_freq->is_dvs) {
 		pr_debug("cpufreq: leave dvs on reboot\n");
-		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
+
+		policy = cpufreq_cpu_get(0);
+		if (!policy) {
+			pr_debug("cpufreq: get no policy for cpu0\n");
+			return NOTIFY_BAD;
+		}
+
+		ret = cpufreq_driver_target(policy, FREQ_SLEEP, 0);
+		cpufreq_cpu_put(policy);
+
 		if (ret < 0)
 			return NOTIFY_BAD;
 	}
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5d10030..e84281e 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -555,8 +555,17 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
 						 unsigned long event, void *ptr)
 {
 	int ret;
+	struct cpufreq_policy *policy;
+
+	policy = cpufreq_cpu_get(0);
+	if (!policy) {
+		pr_debug("cpufreq: get no policy for cpu0\n");
+		return NOTIFY_BAD;
+	}
+
+	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
+	cpufreq_cpu_put(policy);
 
-	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
 	if (ret < 0)
 		return NOTIFY_BAD;
 
-- 
1.9.1

