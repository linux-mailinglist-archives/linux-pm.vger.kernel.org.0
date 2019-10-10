Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D807D2819
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJJLkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36072 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJJLkK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so5859346ljj.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s32JeDhVlasQJ6pytWlkQPUAMG4/wlRqEgRTpBOYoJM=;
        b=oY4GQ9tspotLOINThxk9Kbs/w01ctme9MEPIEv5nplvQc0Gfk2yTpx63vcTwtFKh4B
         B+T2P47iK3kLvh+AM79Ow8hzpSL3BwO3bqbzE3b2EGXWMtodySrd61pw72AcbbCRFUpW
         afPqjSPD0x36xrozZ3piihjF4z1ppF7c8+sdn5Eb7tbNOIM4xve2bbcEhfKjKH3SEPiz
         mq2/6LaFi7GwljgIrb1NuH0pROuM4yrNj2ZjU5Ymvi8IEwKvRk9+do8bNp27z4n8h5v2
         epXCe1vP/SQbHMt0CKqt4ltRSdU/ZufhVj++KFLUQjmpFA0FFee9QlnZH1Yo6uEaRSRm
         /omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s32JeDhVlasQJ6pytWlkQPUAMG4/wlRqEgRTpBOYoJM=;
        b=qiDoTNxqJ/6198HSLkrvI06a/bt9BYn75nVXCD0kGCgv5Mk4Xj8m8tvNGMR2fJwDM3
         hMKZmwX7BTB/ujs1TdozJp+yxzJRXFtT9e8t4TySD04S99odzfQdGmLDLmAdvXLTt62e
         D5b8eteppJa5iga0fJ980tpv6tyQgo9/iffCq0euI7CszVp2B++1GsaYfTRwrYi0qoZ3
         1x+cqY2K/MTzqi8RBUeBFdrL8jis/XOIvdqoqkdukxKrJieBb9EHuSOPK0sgxt76PWkP
         Qg+MDs1i5iLKaSfW6k+EqlRNw352bY37sQWj4JkCDVjLjw5KklhAn+DwK1C3KaC/fFoY
         mXZQ==
X-Gm-Message-State: APjAAAXQY71R/mKJ0SJXm7Vk0/SutxxeA3jl4BSr7QuSUpnzwxm63mUS
        /3rKUHa1QmLw9p8YLNw4hKeXAA==
X-Google-Smtp-Source: APXvYqyGsGrLPyBDtCxTyveMalXdmwovqTcGDOWg4fzfp/TkTS6GWys0i/Jm2jUOUYV/1uUVYs7SYg==
X-Received: by 2002:a05:651c:105c:: with SMTP id x28mr6132302ljm.114.1570707605886;
        Thu, 10 Oct 2019 04:40:05 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 01/13] cpuidle: psci: Fix potential access to unmapped memory
Date:   Thu, 10 Oct 2019 13:39:25 +0200
Message-Id: <20191010113937.15962-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the WFI state have been selected, the in-parameter idx to
psci_enter_idle_state() is zero. In this case, we must not index the state
array as "state[idx - 1]", as it means accessing data outside the array.
Fix the bug by pre-checking if idx is zero.

Fixes: 9ffeb6d08c3a ("PSCI: cpuidle: Refactor CPU suspend power_state parameter handling")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index f3c1a2396f98..2e91c8d6c211 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -27,10 +27,10 @@ static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
-	u32 *state = __this_cpu_read(psci_power_state);
+	u32 *states = __this_cpu_read(psci_power_state);
+	u32 state = idx ? states[idx - 1] : 0;
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
-					   idx, state[idx - 1]);
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
 }
 
 static struct cpuidle_driver psci_idle_driver __initdata = {
-- 
2.17.1

