Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CB53E9D95
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 06:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhHLEge (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 00:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhHLEgc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 00:36:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CCC0617A4
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso13235692pjb.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOkHp31PCeB99M1dSxN1Du6uw4AQKsapMxFixRcFEa0=;
        b=Kh7hj4I7h5CBlthAjIqogCoHqEsTXGwRK33ywj/3LXMyBATvxFhFWnw3YPLcQN7O8w
         7QjH4GDLQShi7mobqrYD8nw0176v1Xpc5uvJUorIClB9Ym8UAEYjVryjjeHzLIYX9dpl
         XGvTT0EZ5f0r/28shwGhJzElGs0BnhohuWx5xkLbOaLjK1oS54dDiYl2A5x04CNBGlZu
         gvCRC/3zVpYzUhuhHpDUYiRT+01GNbz1NU8XhIgcTJJT62iN2wRbkCxN5P+svmojj6lk
         XezXTEQcRWc3vVYfXyVyRPh/4X/EwnCyDiMg69Rn7Hc5vqSuNtSqiH72uRlZNV8Lw1pE
         C9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOkHp31PCeB99M1dSxN1Du6uw4AQKsapMxFixRcFEa0=;
        b=tIqqVj6z9HMjqytu4HkdCUe6dOC4X+I5fYgsyR8pEkhGt81T7zEGjX+regbCJV8ucy
         rUJVRbglHpdklGyfP9pHVl/HvpXRe7ryKtWhrYgxMV76+IQoDwQDYkcbj+2LJeW6BTaS
         My9svAk4enT7917VvyTh2HNMy+qATwgQc1J63s5/YbYkEkbVPq4e5Cv85SJDwSB7KKZO
         yHkcvBe6IhEHvnFkRy5GaNJpL1f2XTfw1Xe53ZiZyAKkaPPxFn4d6kvG58mrbAFsuzY6
         Gk6nWZr2SR6IMgoxQumkrBxXjXqOd/R2U8ifkB2uUw2D/bANGdS/GFbUEIy/gFfmUjdH
         B0gg==
X-Gm-Message-State: AOAM532HM5czE185lOTTI9Uzzdlei3EMg3RHid69YX3fGRuIQUVtR2L7
        CcytxPe2C4hHN8vynY2e2x/4Ug==
X-Google-Smtp-Source: ABdhPJyhc1Uy3xlMY0GVY5KMgo/dRuIuPuycji44bvvw6HvVyeQ3uW/K2q+eVg1ubLke2ab2XFSL1g==
X-Received: by 2002:a17:90a:4285:: with SMTP id p5mr2373269pjg.162.1628742962600;
        Wed, 11 Aug 2021 21:36:02 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z131sm1353426pfc.159.2021.08.11.21.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:36:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 6/9] cpufreq: qcom-cpufreq-hw: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:19 +0530
Message-Id: <e96c2153d0fc0a1c218bf5ba149ccdf75d19a275.1628742634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to register with the EM core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..c2e71c430fbf 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -362,8 +362,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	if (policy_has_boost_freq(policy)) {
 		ret = cpufreq_enable_boost_support();
 		if (ret)
@@ -412,6 +410,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.get		= qcom_cpufreq_hw_get,
 	.init		= qcom_cpufreq_hw_cpu_init,
 	.exit		= qcom_cpufreq_hw_cpu_exit,
+	.register_em	= cpufreq_register_em_with_opp,
 	.fast_switch    = qcom_cpufreq_hw_fast_switch,
 	.name		= "qcom-cpufreq-hw",
 	.attr		= qcom_cpufreq_hw_attr,
-- 
2.31.1.272.g89b43f80a514

