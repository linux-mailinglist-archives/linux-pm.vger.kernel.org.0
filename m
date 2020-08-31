Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B16257593
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgHaIi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgHaIi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 04:38:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E4C061573;
        Mon, 31 Aug 2020 01:38:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e11so5679221ljn.6;
        Mon, 31 Aug 2020 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AomksxJ5OYSsG+wno7aQihzPAx2gnzHlX4NIWn4P3YU=;
        b=VLHCSfPqaJnhCvhyMBSv/RP+pK2yFrEFSiKYCnL1wKOTxKo9JOay6McS7uuqSdN7tg
         ffo7iyYtkDiXDewH0YwGMMCYYQfK0J9XGfa4UzflCCVO/E5wYmT/jzc3W72wPlr6efCJ
         RwtUnrcRy7O0d4xiEVIoIHb+BWg/OXUQkNWFqm7jt2ChnuuSvPq+iqW1U0Fh6K3MRQQM
         PQ4lapPYwZRnvB1X5Lw7osFQNANEGeRI5by1RdJtIeSy8tf36LI6/b3aRyW8pIFdcF/w
         4VEk522eXIesXFWWmCRKODY7fX7n9ZJ9L/vhLgw0pKkecroOfO3/+MdIz8Lcj2Fr6XhW
         0ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AomksxJ5OYSsG+wno7aQihzPAx2gnzHlX4NIWn4P3YU=;
        b=iFiCf3GjNqEw2la0fMPm0lyEWRViZYZCZtSKVP2won7WFB8AukX4pU/yScl4aj5Gaz
         p91KonJ3b7QSSYgyPHjVoZ2ncO27ZrGMJGzpuGf+RZUtaKG2Unxcm7uF5+jWg2SsASZF
         zVMFh9lAo/NBci2AtXN9i4CkaWbhrQmjqk+SGFiwg8jIS6QjTjwR+3pt+HWNsb7wWBPm
         kysuZ6Z9Iwb3ZyG+DAUrZVijKZ6RNW84BzJBU47sc8Q4HfEsjZ/KP/Rk7N42xiC2j/Vi
         UBEj2ck5xKYFRNaTVf/e+YEcQ/uj2FszfIlOMNLcbklXa9cubRnQoFmpjdt6XW1py9nr
         bY4g==
X-Gm-Message-State: AOAM533g9MPJcwsz3ru8ydIbCfVo7m0Vbui/nRzsLgp+i3a6pHwSEz/n
        9lIfYk3QBIDf+4Sf02wJ2mQiHWsIvWU=
X-Google-Smtp-Source: ABdhPJx4bGZP604Ov1qRQmbLRYSQxMs+X3j3XX5j48dgWn6+Pqvqc37PvW/431ZPxnvs877RJbRHOA==
X-Received: by 2002:a05:651c:552:: with SMTP id q18mr166530ljp.248.1598863135120;
        Mon, 31 Aug 2020 01:38:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id q26sm1846374lfm.63.2020.08.31.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 01:38:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH RESEND v4] cpuidle: tegra: Correctly handle result of arm_cpuidle_simple_enter()
Date:   Mon, 31 Aug 2020 11:38:32 +0300
Message-Id: <20200831083832.17889-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The enter() callback of CPUIDLE drivers returns index of the entered idle
state on success or a negative value on failure. The negative value could
any negative value, i.e. it doesn't necessarily needs to be a error code.
That's because CPUIDLE core only cares about the fact of failure and not
about the reason of the enter() failure.

Like every other enter() callback, the arm_cpuidle_simple_enter() returns
the entered idle-index on success. Unlike some of other drivers, it never
fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
driver, and thus, there is no problem for the cpuidle-tegra driver created
by the typo in the code which assumes that the arm_cpuidle_simple_enter()
returns a error code.

The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
see the error code from arm_cpuidle_simple_enter() today.

Of course the code may get some changes in the future and then the
typo may transform into a real bug, so let's correct the typo! The
tegra_cpuidle_state_enter() is now changed to make it return the entered
idle-index on success and negative error code on fail, which puts it on
par with the arm_cpuidle_simple_enter(), making code consistent in regards
to the error handling.

This patch fixes a minor typo in the code, it doesn't fix any bugs.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v4: No code changes. Added r-b from Jon Hunter and re-sending for 5.10.

v3: The tegra_cpuidle_state_enter() now returns entered idle-index on
    success instead of 0. Hence the error message will be shown by the
    tegra-cpuidle driver if arm_cpuidle_simple_enter() will ever fail.
    Again thanks to Jon Hunter!

v2: Improved commit message by clarifying what values are returned by
    arm_cpuidle_simple_enter() and when. Thanks to Jon Hunter for the
    suggestion!

 drivers/cpuidle/cpuidle-tegra.c | 34 +++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index a12fb141875a..e8956706a291 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -172,7 +172,7 @@ static int tegra_cpuidle_coupled_barrier(struct cpuidle_device *dev)
 static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 				     int index, unsigned int cpu)
 {
-	int ret;
+	int err;
 
 	/*
 	 * CC6 state is the "CPU cluster power-off" state.  In order to
@@ -183,9 +183,9 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	 * CPU cores, GIC and L2 cache).
 	 */
 	if (index == TEGRA_CC6) {
-		ret = tegra_cpuidle_coupled_barrier(dev);
-		if (ret)
-			return ret;
+		err = tegra_cpuidle_coupled_barrier(dev);
+		if (err)
+			return err;
 	}
 
 	local_fiq_disable();
@@ -194,15 +194,15 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 
 	switch (index) {
 	case TEGRA_C7:
-		ret = tegra_cpuidle_c7_enter();
+		err = tegra_cpuidle_c7_enter();
 		break;
 
 	case TEGRA_CC6:
-		ret = tegra_cpuidle_cc6_enter(cpu);
+		err = tegra_cpuidle_cc6_enter(cpu);
 		break;
 
 	default:
-		ret = -EINVAL;
+		err = -EINVAL;
 		break;
 	}
 
@@ -210,7 +210,7 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	tegra_pm_clear_cpu_in_lp2();
 	local_fiq_enable();
 
-	return ret;
+	return err ?: index;
 }
 
 static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
@@ -236,21 +236,27 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
 			       int index)
 {
 	unsigned int cpu = cpu_logical_map(dev->cpu);
-	int err;
+	int ret;
 
 	index = tegra_cpuidle_adjust_state_index(index, cpu);
 	if (dev->states_usage[index].disable)
 		return -1;
 
 	if (index == TEGRA_C1)
-		err = arm_cpuidle_simple_enter(dev, drv, index);
+		ret = arm_cpuidle_simple_enter(dev, drv, index);
 	else
-		err = tegra_cpuidle_state_enter(dev, index, cpu);
+		ret = tegra_cpuidle_state_enter(dev, index, cpu);
 
-	if (err && (err != -EINTR || index != TEGRA_CC6))
-		pr_err_once("failed to enter state %d err: %d\n", index, err);
+	if (ret < 0) {
+		if (ret != -EINTR || index != TEGRA_CC6)
+			pr_err_once("failed to enter state %d err: %d\n",
+				    index, ret);
+		index = -1;
+	} else {
+		index = ret;
+	}
 
-	return err ? -1 : index;
+	return index;
 }
 
 static int tegra114_enter_s2idle(struct cpuidle_device *dev,
-- 
2.27.0

