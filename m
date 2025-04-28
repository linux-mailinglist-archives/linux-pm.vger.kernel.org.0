Return-Path: <linux-pm+bounces-26327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E99A9F71B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 19:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11032189D77E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4B288CB2;
	Mon, 28 Apr 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjK5naKx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DF25F973;
	Mon, 28 Apr 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860638; cv=none; b=mF9V0aG8IqYZAIy08Fq/VDSrj2OGM02Wl6yQBSZq8iEcE/JM4xo3XwJhWssHLhvdDZERTiQNdgbDXL/go8GcggPKLd4yajbyQWczU8zvPPeqKFC6mW/m5bbtOE+71CNr7rsETV8fKnTm1kroXfrfEFf9NfeEn8wU65g85f3WsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860638; c=relaxed/simple;
	bh=ODSgAxWbJBt9NdiXhOPCZyDcdalY9TFRVoBNWJq/xMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7xmiYrGUOEndQg5TGiUr90ASD/GU1PVPHy+ZFqPXLixStDuMkZ3fXdFKJo31rlgqQKEyMpFlYgbb2kPgZ9rkS3dwVpLuFBw/FZRyU51KRBol+eDFgipUsHo5PlIXKbW+NOln4Pyy/W5RkBvOtWblN/y1Ko2/PqGu1+bimEmHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjK5naKx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso50936736d6.2;
        Mon, 28 Apr 2025 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745860634; x=1746465434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn0Gb6p8bTLHf/Q1ND9UVncX7fPuOHXSbUhkjcvlOJQ=;
        b=QjK5naKx4Xo2H+JqqspmjfrAVnOwI2drojsO5aONRHPnKrLUoCfDkWjwsbtwOXcBOj
         mYwUldtNAmlnFXBcRAVCmIRsHWGVc1M5ArWB3CrP8fZCpv/DNTep1gi7eu56WJHTOcl0
         hwPTdTiNwXiBI6P0vO0ynRMlEaDUf1zw0Txc2nvR8dU/P3t57+laAj0pCkIGBzB+bi4Z
         7RRQd6goFrQOvX7d+Hsr3WqmIIef3iiXnXnPQKXSHGKizNyS5/tx0y7Tce5pX4ocsd9f
         KKqQOUe8FqjTX3rO4fxyEuVYKao/9D1dnMHSitFG1swDLBeaeNA6BUZBXbGyBmC1ynLg
         aFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745860634; x=1746465434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gn0Gb6p8bTLHf/Q1ND9UVncX7fPuOHXSbUhkjcvlOJQ=;
        b=cuUrfN29i8QOSvBGX/wslUhIWMglXml8PEYamL4nfE3BmGQNJH2wCq+zGVkoHeNONr
         mbRMOx3h4IGqC8bc/SEHlNlWr5O+getYN7lcgL+NHIeZkOv0I3OH+VqG0bmfPysCvIeW
         55FeJs7temWfYXrt18LNc2f5MzDmf7/5G5+/6MDqBYF4zwSbs+7yI87wwYU4TbQuvgJP
         VDu0ZjQjiUn7EUqAY3fHG4PVlL09gt8FEkmshwYX9ALLlLghvkPeNX8a089wpkdii8AD
         mrRkHHJgGJPYx7c8wUfnSGyQ6O36+3Vuj9ZyduAJuLFPPrB6TEpDAM1q7LYeGEF/Ye3S
         xNSg==
X-Forwarded-Encrypted: i=1; AJvYcCWuLhtmhfhnqNOyg8wHygeFGX079Cl27oSuMnkfexGpj9LB7Kw7sad4Sh94bd9/sJP0ISvi8bRZinctpAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2J7J5VwZUA5/Js/3dZ4ozHh95lcCNgmWoga0aZyz2xqT3aILf
	x98TXb6yJzjbRLf21DTVvvTiNhG5L6WF5WBE9DUWmQ8wri03WlY+
X-Gm-Gg: ASbGncvgwkGfk1RZjRXVXpunzEcxAysVTqtOdZNQnSmwOSzr40ymKrphCgDvrTJy+/c
	0a8xxbQRR6U+un8pIpTzZmEH+nMCttCy1lndLD7nJ5g4nfmSEbNAko+K5FkGClzpJUq5Kz80/N+
	Fo5TiI2AGrqXyAM6INv5aG7aqHXPGFtM26RzV5mB2/xI02v/O33pivA4cP9rr9JVPbGK2pnuXx7
	ayJPc6rqY8jDb2YcFTQt7p8yzPKfYtik2kNZQnV+eWMK0PsEG9nSqDY2VcyyebhAaGgSp9dxbsW
	yLy9VE5oIo8zeuaHMwaRMv5WeEQGqi2nNBafCCskiA==
X-Google-Smtp-Source: AGHT+IGxcPjNvO81CcwtPm0A1nprONnmZO2K4FxXeiwb359ItwXBCQxRnIKtwjF3TweWhQTQycGohQ==
X-Received: by 2002:a05:6214:f21:b0:6ef:3de:5ff7 with SMTP id 6a1803df08f44-6f4f1ba9885mr140276d6.15.1745860634332;
        Mon, 28 Apr 2025 10:17:14 -0700 (PDT)
Received: from iman-pc.home ([184.148.73.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0938399sm63268506d6.40.2025.04.28.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:17:13 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH v2] cpufreq: fix locking order in store_local_boost to prevent deadlock
Date: Mon, 28 Apr 2025 13:19:31 -0400
Message-ID: <20250428171931.1850-1-ImanDevel@gmail.com>
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

store_local_boost() acquires cpu_hotplug_lock *AFTER* policy->rwsem
has already been taken by the store() handler. However, the expected
locking hierarchy is to acquire cpu_hotplug_lock before policy->rwsem.
This inverted lock order creates a *theoretical* deadlock possibility.

Acquire cpu_hotplug_lock in the store() handler *only* for the
local_boost, before taking down_write(&policy->rwsem),
and remove the cpus_read_lock/unlock() calls inside the
store_local_boost().

 [1]
 ======================================================
 WARNING: possible circular locking dependency detected
 6.15.0-rc3-debug #28 Not tainted
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
Changes in v2:
 - Restrict cpu_hotplug_lock acquisition to only
   the local_boost attribute in store() handler.

Regards,
Seyediman

 drivers/cpufreq/cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index acf19b004..5464c8487 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -653,10 +653,7 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
 
 	policy->boost_enabled = enable;
 
-	cpus_read_lock();
 	ret = cpufreq_driver->set_boost(policy, enable);
-	cpus_read_unlock();
-
 	if (ret) {
 		policy->boost_enabled = !policy->boost_enabled;
 		return ret;
@@ -1045,11 +1042,17 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!fattr->store)
 		return -EIO;
 
+	if (fattr == &local_boost)
+		cpus_read_lock();
+
 	down_write(&policy->rwsem);
 	if (likely(!policy_is_inactive(policy)))
 		ret = fattr->store(policy, buf, count);
 	up_write(&policy->rwsem);
 
+	if (fattr == &local_boost)
+		cpus_read_unlock();
+
 	return ret;
 }
 
-- 
2.49.0


