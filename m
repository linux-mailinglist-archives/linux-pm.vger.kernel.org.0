Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D0112BCE3
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2019 07:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfL1GoF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Dec 2019 01:44:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47001 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1GoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Dec 2019 01:44:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so7881360pff.13;
        Fri, 27 Dec 2019 22:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k/Zh0wd0iyh47HJcj26AK+VtSYrhhFOp9r5l6dctHRg=;
        b=cQ87Up34bttOiGDEXDLiZ+4e4O19HR8fqNNWjDzMEWGjLJeDt12PbmxIzk/sHUID9c
         yPTUXIf5hAOPK1T2/s1zzolWudNsW/MYZkhVlRhXpj3Q8czVxQcMThExn6rkBiilqYLq
         dz6cInYDh3jNyF8o/vex+/jNRJSs1g+OnegrFoWJtB/Ygj9clWo4AGnQsxtPXXK+K/mg
         Jpd7VylXheG7lEVoyg9PUUlvvGYkyMSef7i/+xpgeTk0nUggIvdaAyX7jBWjWjKBLOn/
         aDjUziw1rZ2zHCWzWzdk0QbXv70r+eWvqiN1mNHhZyUnzLWetCycgQMezieDHqOWEB9M
         ZCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k/Zh0wd0iyh47HJcj26AK+VtSYrhhFOp9r5l6dctHRg=;
        b=FK2rWTEn6pV6l2yTXeVBouAkt4NWmYtWug4hwDTsB6A1NH/VSxJthyp5EcAK87Urbr
         99Jn5C54XVE1rIHkJJl/yeM6ZFFyudu/FDI1k56ZYdweO4Dsn7qbdczEc04PfEb5TKVx
         toUkGHYIdoADH+Lhulr4rfMSbfQb7ggbh6DzWNVH9Y2ikgwU27tH1zEscib5yqr+6/1S
         74C8R+Ge1+PU2rnjt3EZeo19tXx+18RAIQhAf09QgIr+f+WmF5b/zykFnG4ZSx8c8t/+
         VjHGZDjVv0guAACduzBMl1D9662q0rL5BBZz6M+jWEeiNZc3cnP25FQOePz0/tGLJKE2
         /LCA==
X-Gm-Message-State: APjAAAW53UDrefiJ0Ss4Pgn/DTsv1GR56+6rQU537nWXEiDWnDwwI/Zp
        0f7a0LWcfQLqT40920u35b8=
X-Google-Smtp-Source: APXvYqxS56Xo+lxmahknG9q55wIA+ODBR3wY7WgCdNMBd37PV7FVIa4xuPsJ37k352RZ05q1fDWlBA==
X-Received: by 2002:a65:66d7:: with SMTP id c23mr60290506pgw.40.1577515444820;
        Fri, 27 Dec 2019 22:44:04 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q15sm39751585pgi.55.2019.12.27.22.44.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Dec 2019 22:44:04 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] cpufreq: s3c: avoid use after free issue in xxx_cpufreq_reboot_notifier_evt()
Date:   Sat, 28 Dec 2019 14:43:59 +0800
Message-Id: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

There is a potential UAF issue in xxx_cpufreq_reboot_notifier_evt() that
the cpufreq policy of cpu0 has been released before using it. So we should
make a judgement to avoid it.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/cpufreq/s3c2416-cpufreq.c | 11 ++++++++++-
 drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 1069103..0f576ba 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
 {
 	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
 	int ret;
+	struct cpufreq_policy policy;
 
 	mutex_lock(&cpufreq_lock);
 
@@ -318,7 +319,15 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
 	 */
 	if (s3c_freq->is_dvs) {
 		pr_debug("cpufreq: leave dvs on reboot\n");
-		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
+
+		memset(&policy, 0, sizeof(policy));
+		ret = cpufreq_get_policy(&policy, 0);
+		if (ret < 0) {
+			pr_debug("cpufreq: get no policy for cpu0\n");
+			return NOTIFY_BAD;
+		}
+
+		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
 		if (ret < 0)
 			return NOTIFY_BAD;
 	}
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5d10030..d99b4b1 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -555,8 +555,16 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
 						 unsigned long event, void *ptr)
 {
 	int ret;
+	struct cpufreq_policy *policy;
 
-	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
+	policy = cpufreq_cpu_get(0);
+	if (!policy) {
+		pr_debug("cpufreq: get no policy for cpu0\n");
+		return NOTIFY_BAD;
+	}
+
+	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
+	cpufreq_cpu_put(policy);
 	if (ret < 0)
 		return NOTIFY_BAD;
 
-- 
1.9.1

