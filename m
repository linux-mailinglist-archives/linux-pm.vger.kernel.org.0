Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707EF27E78D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgI3LUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgI3LUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 07:20:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E12C061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 04:20:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x69so1674052lff.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JaBYkCpqxdbjLQb1w+KKEU4S8vRsQ/8VWeCdl0OLNmw=;
        b=ZQUJnNObqdGuqomARat9Rzcy1IMw/qk9+IKE4ijq8mcEnxCUlIYe+Xr0IIVv6LytD8
         RPJYRdmjB74vyhEK0C++tvW/9hNpc7pmhmXYzjLY5z9EWt3m1QZkFRwcwjrKdG0ccE3S
         dvZ0AFvgnYJ3CrPviGAZJ/zrH7Q6Qqh53Rr/c8zh0doO5gCcYlVu2IsH18tLcYF3ewGL
         DdqGnHJwCW57AmbetW0uftX75VcX/r4rndYX9LMfpuJJcU+F1pPhppZ7dKd5vz34xoSp
         27KErU6W1k/hXubW4Qb9DjSZqWrRixJCSmEJ04S5W8TtDa2wDjRWwAv7rTxzBPpLcbWH
         blkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JaBYkCpqxdbjLQb1w+KKEU4S8vRsQ/8VWeCdl0OLNmw=;
        b=RvTx6S/n4ZPteEiD0+7BN5SSnG1S4YFe89AeW+aLOV2U78FaSLrTd2ugmmXU+EKoFX
         Y/odNKckbtDuV9587YGCIu9SElPc44dtpEJi+2iLxoZnyFipxhzMAROadPQNMt8ILh1A
         M8VWW/u3MkhY3znww1Lku86jaCH65+9smFUbwbqDfwH2EzFDZiFRL56JShIt/fCH+HBk
         XiSMN01AjGT5vMw5m7kxub1NHRc/q56EiaRc3+ONCLMxFKaEImyVRk8RWrvdlKUal2yP
         n6JZ1rI/I/T9KDY8AY68niZI9zR0KvEfXHr1sNtKpPm93yVyLoJbpL+H7LcuJusSW1fc
         ttgg==
X-Gm-Message-State: AOAM533s236d6Z23upY6HkswBSoCBOpnjVYDpfruXLL4FuONC3DC01ir
        sGj6qY6IUJDBOIsl2HFlDPoANg==
X-Google-Smtp-Source: ABdhPJzhbbNwWxMqHCyhim49dAaiswEhhMSkIreW4KtcezyQ5OH951tEGHQ39H7clnjw9VFmPgpQrg==
X-Received: by 2002:a05:6512:207:: with SMTP id a7mr670315lfo.127.1601464843110;
        Wed, 30 Sep 2020 04:20:43 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id 138sm155770lfl.241.2020.09.30.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 04:20:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: imx6q: Fixup RCU usage for cpuidle
Date:   Wed, 30 Sep 2020 13:20:23 +0200
Message-Id: <20200930112023.121821-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit eb1f00237aca ("lockdep,trace: Expose tracepoints"), started to
expose us for tracepoints. For imx6q cpuidle, this leads to an RCU splat
according to below.

[6.870684] [<c0db7690>] (_raw_spin_lock) from [<c011f6a4>] (imx6q_enter_wait+0x18/0x9c)
[6.878846] [<c011f6a4>] (imx6q_enter_wait) from [<c09abfb0>] (cpuidle_enter_state+0x168/0x5e4)

To fix the problem, let's assign the corresponding idlestate->flags the
CPUIDLE_FLAG_RCU_IDLE bit, which enables us to call rcu_idle_enter|exit()
at the proper point.

Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 24dd5bbe60e4..094337dc1bc7 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -24,7 +24,9 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
 		imx6_set_lpm(WAIT_UNCLOCKED);
 	raw_spin_unlock(&cpuidle_lock);
 
+	rcu_idle_enter();
 	cpu_do_idle();
+	rcu_idle_exit();
 
 	raw_spin_lock(&cpuidle_lock);
 	if (num_idle_cpus-- == num_online_cpus())
@@ -44,7 +46,7 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
 		{
 			.exit_latency = 50,
 			.target_residency = 75,
-			.flags = CPUIDLE_FLAG_TIMER_STOP,
+			.flags = CPUIDLE_FLAG_TIMER_STOP | CPUIDLE_FLAG_RCU_IDLE,
 			.enter = imx6q_enter_wait,
 			.name = "WAIT",
 			.desc = "Clock off",
-- 
2.25.1

