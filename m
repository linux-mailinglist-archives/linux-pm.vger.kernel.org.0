Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDC130FB3
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 10:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgAFJo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 04:44:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44716 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFJo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 04:44:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id 195so25872308pfw.11;
        Mon, 06 Jan 2020 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KtGrKb7t1nXkvA9RAp03OXaiGM0Udf6t6g9rmOrwqQA=;
        b=h3uH4bw2GU+o7uTeRb6skr6Lw6iWOzi9RYNZW+55FiG0+SlNjQei6NHPEjTEDs+5nI
         HxYgS7bX6DgDzLlZRkirtbIM6O4tvP+ZtsdYxpaHg34HubMIlgcROK9AjKM+YESs6juR
         4FA4EJiZq2VK5wshg1aBt5whcBt33ETeDV9DxiBzYCd9vyiMm7dWgfpK++DrsLul5NCz
         +gSjZOjPIr0sgF+BpSEIE/Hei4C82qIjjGUfC+ATL4FqVOV5fbfk8NXlcqehG2W85uUe
         uqBbmBXCt9uqRNSWkCTDWHtpZ2NovetviHdgDzrlhKnoc6MJl4mCF0vnyXMdyV9yS5U/
         Ya8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KtGrKb7t1nXkvA9RAp03OXaiGM0Udf6t6g9rmOrwqQA=;
        b=c6cvt6kXh15w2RlLb/bYt0dqwLzdOMuwRiASEKFf6dWzLiWxbkGuZjo9+zfq7G6cUH
         sJNGgyJaDTDsSxhSs2fYwxmL7ox6Z7I+JB6II8OBdWPc9lqHRuTOHaPT2jztlTv5FjJ1
         1YZrxzNDLCZw7+AR9ZHKWeee1F+JEPfzt71y4H/M6MDGj886p3o72PJtTPiO7Q4ahdpj
         iy4vBH8gk0Bal+N3lY7YvXdjqHlyptfX2MaJ6GGwwjLJeux8kddHnAmVopwcLv/MhCqk
         rn40r6NFBqM6ImM1hE7vwlm4ZZZBo433P6aa+eo82RywEveE+rB/+DxGQPFRyNcho6cS
         iPNQ==
X-Gm-Message-State: APjAAAUzeAlePa0IKTRre6Jq9iTOkr7RR0qMpmx8+ir1hx+EMjZn8xEj
        yYFonlY6pAZaZRztC2GGOck=
X-Google-Smtp-Source: APXvYqwXV771FUqOJJoDqNegv2vvgsnsYNEq3vey/xKO088jvc38DW99nYZ6CpWk+IyeSVRKLC6AAQ==
X-Received: by 2002:a63:6c82:: with SMTP id h124mr109322399pgc.328.1578303865779;
        Mon, 06 Jan 2020 01:44:25 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id u26sm74215521pfn.46.2020.01.06.01.44.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Jan 2020 01:44:25 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v2] cpufreq: s3c: avoid use after free issue in xxx_cpufreq_reboot_notifier_evt()
Date:   Mon,  6 Jan 2020 17:44:21 +0800
Message-Id: <1578303861-7217-1-git-send-email-qiwuchen55@gmail.com>
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
changes in v2:
 - use the combination of cpufreq_cpu_get() and cpufreq_cpu_put()
   instead of cpufreq_get_policy() in s3c2416-cpufreq.c
---
 drivers/cpufreq/s3c2416-cpufreq.c | 12 +++++++++++-
 drivers/cpufreq/s5pv210-cpufreq.c | 11 ++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 1069103..f07c5d1 100644
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
+		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
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

