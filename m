Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD53B16CE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFWJ2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 05:28:36 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:60510 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWJ2f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 05:28:35 -0400
X-Greylist: delayed 2707 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 05:28:35 EDT
X-QQ-mid: bizesmtp41t1624440367tecq3i3h
Received: from localhost.localdomain (unknown [182.148.13.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 23 Jun 2021 17:26:04 +0800 (CST)
X-QQ-SSF: 01000000002000309000000A0000000
X-QQ-FEAT: Pf9cZKF04xN51XnhdB6pys4i4gHiLsZF/g5Gc0DTzF2rfYcoZyxZ4tBMFybaz
        RHmWCy7ZyiDImXjymCVTZjyhW94bPUqxJZguZ13/XL7HOO3/YJOEo/LysCD2fV6jgExsXnC
        h77znUEjftYV+flZcO2LSXmgiMZfjjRkJvghcKHhrdejkAz1A+UGrGORQbalU4qWhNGr6LT
        nGSrPq5sM+q2MTJbDhnvKzv/3KhuBxI1127BeWWQhTLU4IIwpjDYXUl+o2QdmJ5fXUxDjNE
        qFa3H2O5/OjDwJZuW2vG2yBRHbDyy5QatE742CWH6v+2Be4cR8zAr2I/nxGHuCAEXLp/Oob
        In6XQp1
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wjc@cdjrlc.com
Subject: [PATCH] cpuidle: moved EXPORT_SYMBOL so that it immediately followed its function/variable
Date:   Wed, 23 Jun 2021 17:25:45 +0800
Message-Id: <20210623092545.20675-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

change made to resolve following checkpatch message:
  WARNING: EXPORT_SYMBOL(foo); should immediately follow its
function/variable

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
 drivers/cpuidle/cpuidle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd8..ddd11236a0cc 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -457,7 +457,6 @@ void cpuidle_pause_and_lock(void)
 	mutex_lock(&cpuidle_lock);
 	cpuidle_uninstall_idle_handler();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
 
 /**
@@ -468,7 +467,6 @@ void cpuidle_resume_and_unlock(void)
 	cpuidle_install_idle_handler();
 	mutex_unlock(&cpuidle_lock);
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
 
 /* Currently used in suspend/resume path to suspend cpuidle */
@@ -538,7 +536,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_enable_device);
 
 /**
@@ -566,7 +563,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 	cpuidle_remove_device_sysfs(dev);
 	enabled_devices--;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
 static void __cpuidle_unregister_device(struct cpuidle_device *dev)
@@ -665,7 +661,6 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 	__cpuidle_unregister_device(dev);
 	goto out_unlock;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_register_device);
 
 /**
@@ -689,7 +684,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 
 	cpuidle_resume_and_unlock();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
 
 /**
-- 
2.31.1



