Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4687F1CDB44
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEKNdy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbgEKNdx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 09:33:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDABC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 06:33:53 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so7513008lfa.10
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pD+rR7D06+zskc19Z/Pv5SiqhDDKHoIwqYjQ0Wayknc=;
        b=wGeFNaCNE319dM+/gmrxsh9u5N2NlvakeOBIH0GiNZHjeBYijjs7Fd8B8OWF55HT+L
         AW9YhQJa4Qz8QPC6Wi3TF6kh1feJTCQn9YzYxswaK+lft2JhtoRU52Qe6i0/K9w7n+1b
         s3aFK8kia0sbUDBCQEI9QJVZg4BEJ7prPmHhkP2DJPiNHsdDUqOLx2woVgzOL115FEt0
         L5NDZccGHzfLOXWFA3Ws0GP7mTKvN6CBQWe1Y2bkdTHaPHvXeR6T8uUZoAzPD6omlfWu
         X6jfkySYRkYV3mPYcn57v+bpbAJJNeLvoQuO/SZr9JhQWowl+JAnGzI29UIcO9FTgkw6
         12gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pD+rR7D06+zskc19Z/Pv5SiqhDDKHoIwqYjQ0Wayknc=;
        b=OIrpzSpbcSarBGWSMe4kOqTAAwqcr75ANM24IE9c10LwvDcYzi2KephtTzOlTnR9hB
         qHETun7moIsQQMstNc3L4Bg/0ev+QnGS5zXQUyFwyIf5YaM6o6YvOX2SIcC12rX9pUKo
         3XaEw1ER93pNRlymfWPXzyjsuCBLgQ3o3Mbmijsewp+3SD6Q+guxvxxwmKxLXo6eK+hJ
         dCKhE3+py8G3BX2nF3MUd3CcsTbQjVhzh1PJVjK0MPHrTeONLETMEcxjXC0SXVHcRsLH
         luKmZvQQcL/4HQaaD4NIzu2zV8Xr6e0fmFo+CLOuo4mQZVL1SLNDvxCJsdwFqYsKxpA9
         zhzA==
X-Gm-Message-State: AOAM530rCQiXT39VBV+4FpoeZcH4GkRMNJWXLQnHLb1LquT7NZ9Tz9ia
        uyrFz3ba4w7+i5ELOFlQXpTv3g==
X-Google-Smtp-Source: ABdhPJziSi1YV5QdlXPx0bt8kOzmpPToYnuHC1CNLcZpxF6+CeliIUVJusEuJofyX9lU33BAJ2K3QQ==
X-Received: by 2002:ac2:555b:: with SMTP id l27mr11295444lfk.170.1589204031084;
        Mon, 11 May 2020 06:33:51 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id q2sm5647426lfc.7.2020.05.11.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:33:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] cpuidle: psci: Fixup execution order when entering a domain idle state
Date:   Mon, 11 May 2020 15:33:46 +0200
Message-Id: <20200511133346.21706-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Moving forward, platforms are going to need to execute specific "last-man"
operations before a domain idle state can be entered. In one way or the
other, these operations needs to be triggered while walking the
hierarchical topology via runtime PM and genpd, as it's at that point the
last-man becomes known.

Moreover, executing last-man operations needs to be done after the CPU PM
notifications are sent through cpu_pm_enter(), as otherwise it's likely
that some notifications would fail. Therefore, let's re-order the sequence
in psci_enter_domain_idle_state(), so cpu_pm_enter() gets called prior
pm_runtime_put_sync().

Fixes: ce85aef570df ("cpuidle: psci: Manage runtime PM in the idle path")
Reported-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index bae9140a65a5..d0fb585073c6 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -58,6 +58,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	u32 state;
 	int ret;
 
+	ret = cpu_pm_enter();
+	if (ret)
+		return -1;
+
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
 	pm_runtime_put_sync_suspend(pd_dev);
 
@@ -65,10 +69,12 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	if (!state)
 		state = states[idx];
 
-	ret = psci_enter_state(idx, state);
+	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
 	pm_runtime_get_sync(pd_dev);
 
+	cpu_pm_exit();
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 	return ret;
-- 
2.20.1

