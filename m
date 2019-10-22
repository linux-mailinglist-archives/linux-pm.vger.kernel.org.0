Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202EEE01E4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfJVKSE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 06:18:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45215 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbfJVKSD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 06:18:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id b4so1436368pfr.12
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpkkrItQ+QjSSXD1R7+2N7PNQALjVcaxdlDmgQHtPgg=;
        b=wxMNbwKNAg8unVy4Cmds8Y8rrdJW1Z1gcgp6tTY6kM95cEY36ArDfsIgK+Y2Jdq59T
         Cng5f1tYOjcoF9LcXV6lZjlbK8jZMEaqxzu8N/7BWcRXrmFyFrbR8+aEIWoHoHmwaB6Y
         bSIvhA6jGg0xOoeOpSZSbenFJRa+6oe+xdWVXY5hq9ohDZFDBHJAIndIax1UKZJ/goh1
         igUNe0mMij128BRtJjS7101BcDstkxo9OZJWIcTBpYr3XOT+le4jUomGT7EWXZuBfvAB
         7g+cWJpwZM70TmEx3crq0dmzvT58vZvbC4R26e3gdKYfQw1vBMw0Ki8LgUTMu/3T3oaG
         WtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpkkrItQ+QjSSXD1R7+2N7PNQALjVcaxdlDmgQHtPgg=;
        b=oqHwAqBQWLBG+RGUujlHvOW0eSKaQFTA16IVyC+c02izSSZ0RxUanK9MFyMGYj2zNy
         rvhEIf5lax2N0lPUEjWQ30TcZ03eB7zvRhvwU6u47us5KrwHTcZFRbFa+EDUkq3NXiBL
         RiN90OjFo6VYEZIPGdMMKGCYbVEAr92v/BEaIh9oJLCKnHt+stzXLc5nCoB1cTeCTIw8
         AHVc/5eULjVL9hoE57HLzwNmv1JsJ78RzelkBseKBFIM8ElFBn/BSczIn6vzfZdDuPYF
         MXBS/K8paZgi/5zmgAqEZLM1OhZI2jFefiWwJwmB1a7wwG51WFrWH1P3XLiEoUmaIFvZ
         bncg==
X-Gm-Message-State: APjAAAWqg2mQoi/QbcQfNX2HHgQT/U45meu32O3dhECXT7hwBk90mEUB
        fThN4L6vRDHYBQU4V3Iw5xzqWg==
X-Google-Smtp-Source: APXvYqxxS7C5M1bbbiLvBiO65w9OYYjtwGCoFToXiUXy0Muvbi4jLCDYUlfsuwKf5/QZLrpWlV3j5g==
X-Received: by 2002:aa7:8ece:: with SMTP id b14mr3399428pfr.205.1571739482892;
        Tue, 22 Oct 2019 03:18:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id q143sm19247365pfq.103.2019.10.22.03.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:18:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Clarify the comment in cpufreq_set_policy()
Date:   Tue, 22 Oct 2019 15:47:57 +0530
Message-Id: <ec3e8e001b35c9244f6406932335d7156b611373.1571739473.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

One of the responsibility of the ->verify() callback is to make sure
that the policy's min frequency is <= max frequency as this isn't
guaranteed by the QoS framework which gave us those values.

Update the comment in cpufreq_set_policy() to clarify that.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2e698b5f0f80..b4b5f11c2f1e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2384,7 +2384,10 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 	new_policy->min = freq_qos_read_value(&policy->constraints, FREQ_QOS_MIN);
 	new_policy->max = freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX);
 
-	/* verify the cpu speed can be set within this limit */
+	/*
+	 * Verify that the cpu speed can be set within this limit and make sure
+	 * min <= max.
+	 */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
 		return ret;
-- 
2.21.0.rc0.269.g1a574e7a288b

