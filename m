Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0D232AB4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 06:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgG3EIY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 00:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3EIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 00:08:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E0C0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:08:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so15798366pgk.4
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cObSe1rN5NFjpPXj/9JM93EiA5rl/UYVtxX55crPVzg=;
        b=bLS406wheq5g5T3PrPTw8WNqDZRIUQzHT3z8/79K2Y0UrzGIlJdG26anZfNSL+93Bt
         pTkRWvpGmqZx89xyUtA0kwVHyOY9/cjv2b/ysqs3LvU9JBuz9IF+SYhFbasuv+LI7reh
         ttTWzItEQKptfkxzuQKBs/6APDZP7YWfza4myxd/5j/eBjZ0Z0wa3xrg5yTuMUPU+gBI
         Ixp4NZ+Wi3jyphu8xN1c5QzwbInMmKghNOCpUXVncMK9djm2so+cUA/o4Am+vPr/JBbp
         V13W7QKi871zX9spTwJLQV6hykbSnsgZV6icqzicCfKXrqT+gm/0DHFgfcbz5hKR923s
         w44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cObSe1rN5NFjpPXj/9JM93EiA5rl/UYVtxX55crPVzg=;
        b=BlsQTQDAu/YfSDPS7LgIBItOzBGmlIqzjo6jYXm7R+zjJV5a+warccEzvXx6WEVi1y
         93c1epRN9Xion/2LuIHez5ivp0KcI7pq1en9VAphm++inR046GHsTLqL4+sq3Nh8wiV8
         cG9llwcTA43CwI18imUu9FG2qIJql2NYuvtn4d1Qk4TtA+VNZevAAXoJqEcSX+a1/NNs
         4YQ0nW0uAAW+dQNGwikf+dSADFhHrZBIzFE+rPSM5/H7Zhz/zGMNHNdbz4FJZ62RXIEo
         bgSigfKj8ZnVJgDIbJVqId0Xcl8r0QLJCBLlRhbRpRxOnBpOSavI66WzOyRvJJorjhl5
         0I7w==
X-Gm-Message-State: AOAM533vzOUZGwS1owauZ/Ia69Nt5NWZv+AUhC1/kgneW18FeJleZ+qK
        XavwA56ZLc9Vz/xP0DiQ7Dso7g==
X-Google-Smtp-Source: ABdhPJyYaRSuNuJYBKx3fSlucbZ2uRJ89XZ2IPqecUch/RFu3bd3YW2RBCfkpVuDNJiA64TEF6VQsQ==
X-Received: by 2002:a63:d806:: with SMTP id b6mr30041004pgh.403.1596082102597;
        Wed, 29 Jul 2020 21:08:22 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id p127sm4059995pfb.17.2020.07.29.21.08.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:08:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: cached_resolved_idx can not be negative
Date:   Thu, 30 Jul 2020 09:38:15 +0530
Message-Id: <d48d824ab3abacb2356878780979d7ed42191eaf.1596080365.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is not possible for cached_resolved_idx to be invalid here as the
cpufreq core always sets index to a positive value.

Change its type to unsigned int and fix qcom usage a bit.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 5 +----
 include/linux/cpufreq.h           | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0a04b6f03b9a..8c0842bd6c5a 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -66,13 +66,10 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 						unsigned int target_freq)
 {
 	void __iomem *perf_state_reg = policy->driver_data;
-	int index;
+	unsigned int index;
 	unsigned long freq;
 
 	index = policy->cached_resolved_idx;
-	if (index < 0)
-		return 0;
-
 	writel_relaxed(index, perf_state_reg);
 
 	freq = policy->freq_table[index].frequency;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e62b022cb07e..58687a5bf9c8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -127,7 +127,7 @@ struct cpufreq_policy {
 
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
-	int cached_resolved_idx;
+	unsigned int cached_resolved_idx;
 
 	/* Synchronization for frequency transitions */
 	bool			transition_ongoing; /* Tracks transition status */
-- 
2.14.1

