Return-Path: <linux-pm+bounces-26469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DFBAA512E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EFD3BCE5B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90926137F;
	Wed, 30 Apr 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi3QaiUr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07F17A2F5;
	Wed, 30 Apr 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029243; cv=none; b=rB+ud7VajlbJDHx44chIkEDkOxlRwE2XsOPDgOouVEXcN/KFlUVcC63U5fpNzAEYs6zy8+GynMkpJcc2T2cH11UhnM8JFDlejrAMzfbndaWfrsCkDChbZCwkaay1dnOOVr101CltnIaOO0WNdOFjYilW3U4e/a16byf7AAUooz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029243; c=relaxed/simple;
	bh=2d0e5iaIZu3pd5474EGx6dQUABlZaX2gxnnAruiiSSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJXku4JkvOl3E5PYl75tyV4CnBK0CPCxbvls6OdAbxl9qOu1wWEBx7JuLRudG1MTk5TqHPLOtYkbA9iIEgQbEiQzjWl4Ye3pW4+TRpxbJc2322bhC1KITLKrKw1pAIBqageW9q4VCOT2cLAdxhYCP4vLPCuN6w3nwkAJZB1bQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi3QaiUr; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so830696d6.2;
        Wed, 30 Apr 2025 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029240; x=1746634040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEs4/vMxiR7hq6sbXkpfoC4TKgbs/ANlioALa5x6i50=;
        b=Bi3QaiUrgpwMFFWZhGrj6LN4SWGSwjZQuicRNuNlzAxUy4hHSPrFoFgyTDQ4DVjEeM
         XSv7qXr5mhNOXWGdLYkP89sDp7KEOXevi12B+GIcbUfINYnllG7Gce4WXIWHxPs6K6NC
         AiUjL46AQB0kR2DDVfMs+JCSJWu8geXWpuXIhrf0R8hhC8jirk+tjf5dqL8LJ/kangbK
         7B/2ytrpf8LlUdx9BDsAQK8ojc0GmLOIQjf+8hIfGv7Q3dRFMxvP8Jhn9THoqb83A5KY
         mRDleklSwp/7AoShbyM17hpLU0lQ/M0qFnFuCGw4WcUt3LPAIbujcTqU+IVPGB44WVZi
         MR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029240; x=1746634040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEs4/vMxiR7hq6sbXkpfoC4TKgbs/ANlioALa5x6i50=;
        b=KReDD8mlvZ/LAkunHgr51limMzuJDF3yqX1n5Eup4aeC3T6396y9LzsgIXh/UdzCkT
         UJz1vxb4AlH1hIYLlG91CXqVCkxdkzU1dN/N1YveBMMuatdjtmNvMzc9l1FnkN4abyp2
         16Y280SDSu7hC2kXjmKWZTUXww5P44BTRegJG1RTGba5GtEpmfdx1kYQkEy4gYZZyf6Y
         SvMFwXIOiBNKxc7UqI1kMQZbEQxGC25YWClofK+5xtokdXaPBnujKlrxMf+aYThpGsKg
         SJ8Lw9PoF91h/yNKl/rPqXqzkvpcahBmOcfgi9DGzp+8HG6/JbS0hjTyZvoHqmYhdliA
         v8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVE7TsEKFHTzZgKQsaaKRHT3mnE4wokva+J/30KmgCfrijl5+RuHhBNrrE90buHCZEo2wjgDBBfIdRN5OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZG2mbGO1iHUHvU4sV3QHDZ4YJyCii03aEXGx+pDX/zmAN8wQ7
	I0z5FPIsdVZW7Bs+HY+yTX6X70AfEEj5vtWaeKs0xUrGsDm8GJW/
X-Gm-Gg: ASbGncuj3XYZmVMccXPBCIVwEYnELAXJPQVNlostssAHUmOdepJUNHaku+MR9wc5ZjL
	dxWVEdiJrr2HB8QwDpD84ba1INjo5WqX1kvELT/3tdxZpze9mVJBB3j8HfKE2oKccSt4Ag/LiPK
	F5FMr4apuF2MsuatXWvEvVWjT2itaDL3KnanzBAZbRVCL7kD4YrUqt2rODg7AXEaMs287DyyAQQ
	pjHK3xCmSNF2400EQj1huEk/hXpzXzDCGZ44Ide693D0iD9jSRWLirFyQwe3BBcgrgWwR2EZOSv
	13IexP671pj66v5wJ+p34u3rjYIC6vOuKn0hJaf2R1yzKtap/O2u/vfDu5Io0PIIK/L/v4RIL7W
	6CWMptChDK0U1PVILjcEl3x7W0XXmdIo=
X-Google-Smtp-Source: AGHT+IGtWqa/7iXk55bAaDAa5NjVIWxZ7j7iN/jx6/jq0IYRfZtaHIIpY9sDStNQ1FvhYdcBEbQmew==
X-Received: by 2002:ad4:5d61:0:b0:6e4:4274:aaf8 with SMTP id 6a1803df08f44-6f4fe055990mr53152656d6.17.1746029239964;
        Wed, 30 Apr 2025 09:07:19 -0700 (PDT)
Received: from iman-pc.home (bras-base-bitnon2805w-grc-06-184-148-73-125.dsl.bell.ca. [184.148.73.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe6ad6a8sm9803796d6.4.2025.04.30.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:07:19 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH v3] cpufreq: fix locking order in store_local_boost to prevent deadlock
Date: Wed, 30 Apr 2025 12:09:43 -0400
Message-ID: <20250430160943.2836-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep reports a possible circular locking dependency[1] when
writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
triggered by power-profiles-daemon at boot.

store_local_boost() used to acquire cpu_hotplug_lock *after*
the policy lock had already been taken by the store() handler.
However, the expected locking hierarchy is to acquire
cpu_hotplug_lock before the policy guard. This inverted lock order
creates a *theoretical* deadlock possibility.

Acquire cpu_hotplug_lock in the store() handler *only* for the
local_boost attribute, before entering the policy guard block,
and remove the cpus_read_lock/unlock() calls from store_local_boost().
Also switch from guard() to scoped_guard() to allow explicitly wrapping
the policy guard inside the cpu_hotplug_lock critical section.

 [1]
 ======================================================
 WARNING: possible circular locking dependency detected
 6.15.0-rc4-debug #28 Not tainted
 ------------------------------------------------------
 power-profiles-/596 is trying to acquire lock:
 ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0x6a/0xd0

 but task is already holding lock:
 ffff9eaa48377b80 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&policy->rwsem){++++}-{4:4}:
        down_write+0x29/0xb0
        cpufreq_online+0x841/0xa00
        cpufreq_add_dev+0x71/0x80
        subsys_interface_register+0x14b/0x170
        cpufreq_register_driver+0x154/0x250
        amd_pstate_register_driver+0x36/0x70
        amd_pstate_init+0x1e7/0x270
        do_one_initcall+0x67/0x2c0
        kernel_init_freeable+0x230/0x270
        kernel_init+0x15/0x130
        ret_from_fork+0x2c/0x50
        ret_from_fork_asm+0x11/0x20

 -> #1 (subsys mutex#3){+.+.}-{4:4}:
        __mutex_lock+0xc2/0x930
        subsys_interface_register+0x83/0x170
        cpufreq_register_driver+0x154/0x250
        amd_pstate_register_driver+0x36/0x70
        amd_pstate_init+0x1e7/0x270
        do_one_initcall+0x67/0x2c0
        kernel_init_freeable+0x230/0x270
        kernel_init+0x15/0x130
        ret_from_fork+0x2c/0x50
        ret_from_fork_asm+0x11/0x20

 -> #0 (cpu_hotplug_lock){++++}-{0:0}:
        __lock_acquire+0x1087/0x17e0
        lock_acquire.part.0+0x66/0x1b0
        cpus_read_lock+0x2a/0xc0
        store_local_boost+0x6a/0xd0
        store+0x50/0x90
        kernfs_fop_write_iter+0x135/0x200
        vfs_write+0x2ab/0x540
        ksys_write+0x6c/0xe0
        do_syscall_64+0xbb/0x1d0
        entry_SYSCALL_64_after_hwframe+0x56/0x5e

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
Changes in v3:
 - Rebased over PM tree's linux-next branch
 - Added a comment to explain why this piece of code is required
 - Switched from guard() to scoped_guard() to allow explicitly wrapping
   the policy guard inside the cpu_hotplug_lock critical section.

Changes in v2:
 - Restrict cpu_hotplug_lock acquisition to only
   the local_boost attribute in store() handler.

Regards,
Seyediman

 drivers/cpufreq/cpufreq.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 21fa733a2..b349adbeb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
 	if (!policy->boost_supported)
 		return -EINVAL;
 
-	cpus_read_lock();
 	ret = policy_set_boost(policy, enable);
-	cpus_read_unlock();
-
 	if (!ret)
 		return count;
 
@@ -1006,16 +1003,28 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
+	int ret = -EBUSY;
 
 	if (!fattr->store)
 		return -EIO;
 
-	guard(cpufreq_policy_write)(policy);
+	/*
+	 * store_local_boost() requires cpu_hotplug_lock to be held, and must be
+	 * called with that lock acquired *before* taking policy->rwsem to avoid
+	 * lock ordering violations.
+	 */
+	if (fattr == &local_boost)
+		cpus_read_lock();
 
-	if (likely(!policy_is_inactive(policy)))
-		return fattr->store(policy, buf, count);
+	scoped_guard(cpufreq_policy_write, policy) {
+		if (likely(!policy_is_inactive(policy)))
+			ret = fattr->store(policy, buf, count);
+	}
 
-	return -EBUSY;
+	if (fattr == &local_boost)
+		cpus_read_unlock();
+
+	return ret;
 }
 
 static void cpufreq_sysfs_release(struct kobject *kobj)
-- 
2.49.0


