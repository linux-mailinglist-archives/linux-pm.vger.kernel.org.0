Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD26A5D9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfGPJt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:49:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43863 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPJt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:49:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so2875031pld.10
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2pQOR1f7DHhM0Qtl8EEm1QRrX6xqQ9Jku8fM4tSlRk=;
        b=eWuR4BWgpheOmCtw4+kojvX5WouC4KSz5jV/JpYetm1IJwE8WFQ0Y3E7aQ/xgr+pyT
         Qj02V6mPD2oTaWBvK8eWGD/yjZqYozTdGyVRQaFef2A6zxdtGGVUieak0WTn4XKcTws/
         6f6Mgl/IVQho2TwZEldORKlOxns5g6WQwYuUwo9cI2RftvqkqKMbVQBBg8bFA//OhLai
         LQ+3tKZZYAIX3il6vCxYOsCSUTcVstHUp/iTKLFNEriPeHSAQoPX4RK82tH6VSWXa3cN
         qbGbrlFFizujBFgMXiKDSfbc9w1EYJHrb1SIy2prXfP6XkHmOcMjih7XjOAemxAeILj9
         4kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2pQOR1f7DHhM0Qtl8EEm1QRrX6xqQ9Jku8fM4tSlRk=;
        b=h5u9H628CZb4/X7TKxPJXymdC8EhF9+Al8wIS9XNzIHLxNgnjasaFd2PDwysaTU+Ay
         cVFFr50VDhhVcv4dA8UEk7R9pwyNdKD13IEINnDDYjBl3wuUIZXVdsqIddjOl313Zsnu
         5iuh5snOP3PrbX7KA9hMSwNclA6z1AQjZ8+/B/PbpO+HP/7g2dyqnQix3zULPSCH48DX
         wz75lDjOH3P7lIDodxKrn3eWFKxhkx3yVRrtfVRZLI2MqIg5Leu9N52W/8+u7qpOXSsn
         TyzkZvxvdk7ug7R98+9NeiZjh4e1QiXGvTPQMBGjie+pqRyvkGRapcQ8TqwiGGPm0hFd
         snRQ==
X-Gm-Message-State: APjAAAWKH5T06Q5/EdGMLkHRib8l+DTPU0rrVAtRFxhWS3Fr5SI49H8H
        5k/xOT3w90R/41id3K8k0X7f2USl9TA=
X-Google-Smtp-Source: APXvYqzbOOzbjo3FzFCtJezebgRb1OxMiIkrqUibaTnZhvgRbxUBjVWBNq44NgKnsrOO/Hd4KkyUHA==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr32950833pls.96.1563270568321;
        Tue, 16 Jul 2019 02:49:28 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f12sm18339014pgo.85.2019.07.16.02.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:49:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] cpufreq: Add policy create/remove notifiers
Date:   Tue, 16 Jul 2019 15:18:57 +0530
Message-Id: <cc34754314ee513eff9f09c08cd1e325614779ce.1563269894.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563269894.git.viresh.kumar@linaro.org>
References: <cover.1563269894.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.

We have a new use case for policy create/remove notifiers (for
allocating/freeing QoS requests per policy), lets add them back.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 ++++++++++++++-
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4d6043ee7834..8a7eff2a3771 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1268,7 +1268,17 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
-	dev_pm_qos_remove_request(policy->max_freq_req);
+
+	if (policy->max_freq_req) {
+		/*
+		 * CPUFREQ_CREATE_POLICY notification is sent only after
+		 * successfully adding max_freq_req request.
+		 */
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+					     CPUFREQ_REMOVE_POLICY, policy);
+		dev_pm_qos_remove_request(policy->max_freq_req);
+	}
+
 	dev_pm_qos_remove_request(policy->min_freq_req);
 	kfree(policy->min_freq_req);
 
@@ -1393,6 +1403,9 @@ static int cpufreq_online(unsigned int cpu)
 				ret);
 			goto out_destroy_policy;
 		}
+
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				CPUFREQ_CREATE_POLICY, policy);
 	}
 
 	if (cpufreq_driver->get && has_target()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d757a56a74dc..e28c8af697d2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -458,6 +458,8 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_ADJUST			(0)
 #define CPUFREQ_NOTIFY			(1)
+#define CPUFREQ_CREATE_POLICY		(2)
+#define CPUFREQ_REMOVE_POLICY		(3)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.21.0.rc0.269.g1a574e7a288b

