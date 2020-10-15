Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6028F506
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbgJOOor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388837AbgJOOop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 10:44:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E624DC0613D4
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b127so3982009wmb.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5JUoyfVqtjpZjkNlfJCWbI+WQsPddcI5ptqn4dRqnS4=;
        b=M1Qi00FprtY5xYwcerjaZE+WMKOs7sLUXXC6fFbubPpcPA+BWUxbUd9xBQHd3/HcKE
         V+ozmSlOesz53OdnecMn8+bIb+7IYVU0q2Gs5jaU2eB8n5bTm1KrZzQbDPfHZQpJ0ObR
         8Lb8SC5H7xz8cqqLc2zWKkhCnHtIqFPQp/7Remaws17XOPVeZ6G/VzOfzyKE1ThjQnfr
         udQlNxSufReO1qiRy5vMpt6YgJDGlKngHAcggVP7SPFfjfRruRE5j+x53h/aDOrLvGWT
         72/zvDcsy5Bmgk5bPz/pq/Q8zkIsdQndA6JLmCvMCbm/FJux+tPGPkj9HgR8p4ElAarQ
         EwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5JUoyfVqtjpZjkNlfJCWbI+WQsPddcI5ptqn4dRqnS4=;
        b=EWg1Jt0+UyP8KfIna2HTqlZulj7bQwmv9u8E3GQ7J4QoeW8p5jwzs+B+SSTDSazGgz
         C2aKj+Gi6fBV227tZX9vrpF9vVYO3+Rv3z4APBoldKs2CRMzI73Y2fl2OwUcL7vNYAZP
         Llox58n3hzpltFnXsAXedvMuZRV1Hoebdaw6C+NntaV6AByv7Bdv1ltFEcKirTtZT//9
         xAq/1ERWhSOYORfXPwmFjmuWc1AXIFw1qE7CMWIPGtd7gPTq4hQOuUxnCoYbxF66dvB/
         0d5te+Ov08yt+Rr5kqTyYk/79l9JjgQ6RXZUFTe3h/7vGZvaOhGcneIqcX3YqaSjTfYE
         GJhQ==
X-Gm-Message-State: AOAM533EUyd6SM6CvBa2WBYnSqsXAjXOAXZiZ0XxqOL750OASydJwVZR
        NrrYEaqdLc2ZwUSgCjAIMmGgnQ==
X-Google-Smtp-Source: ABdhPJxMGwzaSWU0D+nse992DXxVycFwXzLw7Fz4JN4lJ70ITxImMfBOaK72fwCoAe5Fekxfl608mA==
X-Received: by 2002:a1c:bd0a:: with SMTP id n10mr4378021wmf.177.1602773083506;
        Thu, 15 Oct 2020 07:44:43 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-134-136.adsl.proxad.net. [82.252.134.136])
        by smtp.gmail.com with ESMTPSA id 40sm5053800wrc.46.2020.10.15.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:44:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org
Subject: [PATCH 3/5] cpuidle: governor: Make possible to unregister a governor
Date:   Thu, 15 Oct 2020 16:44:29 +0200
Message-Id: <20201015144431.9979-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144431.9979-1-daniel.lezcano@linaro.org>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch allows to unregister a governor. If the unregistered
governor is the current one, it will be replaced by the governor with
the highest rating. If it is the last governor, the cpuidle framework
will be switched off.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governor.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h    |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index d46ab8ec2dd7..6ec27ef096f5 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -84,6 +84,43 @@ int cpuidle_switch_governor(struct cpuidle_governor *gov)
 	return 0;
 }
 
+/**
+ * cpuidle_unregister_governor - unregister a governor
+ * @gov: a pointer to a cpuidle governor structure
+ *
+ * Unregister the governor specified in parameter. If it is the
+ * current one, replace by another one in the list with the highest
+ * rating. If it is the last one, then switch off cpuidle.
+ */
+void cpuidle_unregister_governor(struct cpuidle_governor *gov)
+{
+	int rating = 0;
+	struct cpuidle_governor *new_gov = NULL;
+
+	mutex_lock(&cpuidle_lock);
+
+	list_del(&gov->governor_list);
+
+	/*
+	 * The governor is currently in use, switch to the one with
+	 * the best rating.
+	 */
+	if (cpuidle_curr_governor == gov) {
+
+		list_for_each_entry(gov, &cpuidle_governors, governor_list) {
+			if (gov->rating > rating)
+				new_gov = gov;
+		}
+
+		if (new_gov)
+			cpuidle_switch_governor(new_gov);
+		else
+			cpuidle_switch_off();
+	}
+
+	mutex_unlock(&cpuidle_lock);
+}
+
 /**
  * cpuidle_register_governor - registers a governor
  * @gov: the governor
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 74fdcc6106b1..457e0786b4f9 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -271,6 +271,7 @@ struct cpuidle_governor {
 };
 
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
+extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
 extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 
 #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,			\
-- 
2.17.1

