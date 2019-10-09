Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8FD1770
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfJISQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 14:16:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38434 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJISQn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 14:16:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so3480434ljj.5
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=s32JeDhVlasQJ6pytWlkQPUAMG4/wlRqEgRTpBOYoJM=;
        b=kGFD5Gdl4C8u9owfyNXhb2acQFuwDz+UXa/i0LTXZTEcbdMmh0AjkXF0QMhR+4cMoh
         XaLzPoP1P9yHpEWRBwQBtxXnN9/OoTnLCaNOvyselGfJG30lA1mfvooZOW4ZcjVHWrda
         hA34NlpqWban8B3XKZZXTGS6T5NYkgN+ZkUQ90+oRbUPFmCvppGke60q85I1LuUq2ZLM
         jot3NVT9dEvLTcnxRjL0rU2KxNMl0LKvpMUBLSbvwIrbXyuRPJ4QE1qPIuen7jElm7PU
         mklEqTwyGxyq/oqf9xoEoHm4rZViyl7vX90D1BDXoi7PyD0LxYxm7V2z90duFy/go7r9
         SHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s32JeDhVlasQJ6pytWlkQPUAMG4/wlRqEgRTpBOYoJM=;
        b=lSncYcstG6FHVSFvz6hJbefIH1fzSwfRHwzt5SmMts4KoF/Y+NKwSHARSZf3sqBpKS
         RZx4sYv12T12JZHSna8clbTNhn8emSAxCy/8A0Lx0SMAke8J/vCka7S/pwNDxOE/nFFC
         RT1Z9yoteEcaqgEEh0gnGwZXPX59Z7R+kczAbGxcWUQmikl1N427wNaSWBnifAkncgzv
         9Icn6tcXZEgFm2KGh6T7g8qTA7JitA3cd6xS5DG9rY1sn8Yy8wrjcDzkVaCyOVk272CC
         /Pl3VUYVdc6hPL1PZY/bYt3GNTmFzmddyLJs+mwtRZfJ3HwhsyNce78YRBZtql1jXYR5
         UfFQ==
X-Gm-Message-State: APjAAAX5eteXwMkd9RgPyjWitoMA5/FNBPw7DvcqDRU37d/8V9M8IeOA
        W9HgZJ7e0Hh7ubem9n1uTz+SYw==
X-Google-Smtp-Source: APXvYqypJOmbC04F3ddNDxg3qFWuyfnh+IG/HcNE3wdr5Kwiz9gCv6E8h7Kf7XglrnbPMWUreNn2hw==
X-Received: by 2002:a2e:3003:: with SMTP id w3mr3313997ljw.208.1570645001423;
        Wed, 09 Oct 2019 11:16:41 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id c21sm638710lff.61.2019.10.09.11.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 11:16:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] cpuidle: psci: Fix potential access to unmapped memory
Date:   Wed,  9 Oct 2019 20:16:29 +0200
Message-Id: <20191009181629.12447-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
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

