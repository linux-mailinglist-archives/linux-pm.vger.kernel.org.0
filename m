Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8C174D82
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 14:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCAN0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 08:26:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37884 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCAN0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 08:26:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so4031332pgl.4
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 05:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1su01q6KFmll99qzXEcg9FRrNXepwO4Dn/UlCMlPU6k=;
        b=BU/Yt0NSo8hEjIq03x2ijsSo0ghx2MscCo+4tSyzTRpenVGdm9z0MjlP5FK7kBNoZR
         Lwr7LjDJ0NqCCssJqySMvIdrBRxtvFL3732z2kuHYB1FesYGWGP3jkRk508n3yKzOiHB
         2SlEQo8ZY0p2M7oV0oSCTmSaxeXUzvPpreX7NvZIIVRnqjVARC1MzJf0GY0L9kBDhOJn
         RTtSHOCDFBjJM5ImMCpGVwi3HMDk46Aq6ZYsDfIB6t6DY/7FfYDIPtCoYoFK45N4tlS8
         oT9VWF+ev7QAIGm4CDca7Mksz9fd7+aSs2sM5CMUGSfvVjOTVNFxVz5GxMl04Bq/BzOK
         ZsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1su01q6KFmll99qzXEcg9FRrNXepwO4Dn/UlCMlPU6k=;
        b=jiGVAafvivkWLWa1grI8uSNHMkvzzIc8kqD0QUGLa2nzufTgcQtt4h4XiTvoSnmqwg
         aDnQV60tTcbBIbb+0kHJScIAC9jAipjEuCv8H27+wfbSczWdn/qE3blhJlxLRGpe4c06
         +KXlZktF4geptpKKDfWcqaTO/K0QuGxq35wpRbP/UCzPPXGyx6suZWCGs4p/qtVRsfPQ
         BtwrW5bMrtMIQXRtjqY+WM5+iRadeRVKiVHgHWsfUaPhvs+zNHNjo/AZ+nzZQblJo0dw
         vk76Y3zoElFnhUX6fCZsbXIMU88LE7RjWbpZPqczvbxKK6evQ2Jai/x8laS/kE58zklZ
         IYAg==
X-Gm-Message-State: APjAAAXJ1+qbEhYoBc47sJV4aIgYd8fQYt1W+z+anINQFlwONB4cSUsa
        b4WezqTgi+ei7Q1Fu285yMM=
X-Google-Smtp-Source: APXvYqyCHxKHHKz7A0SOsnAONlCfYpbKIpBMxJk7gu/FxW6k0vKaYTmDAdq2Wy7ioX5w31ypcDcdYw==
X-Received: by 2002:a63:fe43:: with SMTP id x3mr14958262pgj.119.1583069202898;
        Sun, 01 Mar 2020 05:26:42 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id w17sm12445333pfg.33.2020.03.01.05.26.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 01 Mar 2020 05:26:42 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] cpufreq: fix a mem leak caused by policy->max_freq_req in cpufreq_policy_free()
Date:   Sun,  1 Mar 2020 21:26:38 +0800
Message-Id: <1583069198-21060-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

There is a mem leak in cpufreq_policy_free() that the resource of
policy->max_freq_req pointer is not free.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cbe6c94..6756f7a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1280,6 +1280,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 					     CPUFREQ_REMOVE_POLICY, policy);
 		freq_qos_remove_request(policy->max_freq_req);
+		kfree(policy->max_freq_req);
+		policy->max_freq_req = NULL;
 	}
 
 	freq_qos_remove_request(policy->min_freq_req);
-- 
1.9.1

