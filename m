Return-Path: <linux-pm+bounces-26312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FBAA9E70A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 06:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50970189693D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 04:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93B17A2E3;
	Mon, 28 Apr 2025 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYhvYXbZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE5487A5;
	Mon, 28 Apr 2025 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745814703; cv=none; b=ucIXjCHIYmhH6RpwCdGJGPqBIe1ABohe8kFr9AbAsNG8H24k00oT6owlcgC6yB69Jv1BGO3L3KNH+qoP6CK82c4+uo4Qx2FDmxrTYFmHkLObs4Y6RV+2xMPlTBEcqjb11P1NZ72RLE71KmL0mj8ZyY0HxThWNAHLACqTzrduXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745814703; c=relaxed/simple;
	bh=pM9WdbxbCoq91JlbmnwpX9YXcTrYb3eoYNw64DwXYww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReR/yzpvkqiBuRrXIcKY3n9wtBA4R1u880+YgJEqde6a+uuLMHOJRG0o2tJwViL2iCsK2lvCdhNPZ1b4u3rSRXTaDv8PkvkFOxsE8A6KVGVrfmE1UDB2BppYqwneBfx6kOzJfCdfaS+7XM/epytAFvDgqWmGiAJqpykocZHOwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYhvYXbZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766631a6a4so53959401cf.2;
        Sun, 27 Apr 2025 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745814701; x=1746419501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XK0ow2yQiTSwZKmXddEqpTiG/spDXu2r2XpbRTk02SA=;
        b=aYhvYXbZCwdX/sqi0bmbhJH6FGMP4qXK1HXDALH4PFB8gSohXzccdic5PgBxlx4/cr
         AQeZDRC9vkT+x9gR8DHWAdG0HI9YQ6uZKVBOU6JGOGf4Vynb5L3wedoC+L4jZUj5z5JE
         mRk6msWtUggVDz6xIkz/qWTWpKnRbvz86BousitJkwTeuhhn+4FTi1edp73bVoO398Zs
         p7prd+AoiQnCwNI30JrSPSRNhqJELjSQ494cgpG0zp2JgeyDTFl7sjH/6BxLoAQ4ktIV
         5hqT6rgYpef631kvvEnRbAlxtGEOWoP/CzIBlHmMi94gNoYRWACXh5p1y9yGbjqo/Wka
         mfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745814701; x=1746419501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XK0ow2yQiTSwZKmXddEqpTiG/spDXu2r2XpbRTk02SA=;
        b=XLIda6odHyXPEl9khjOG03diog3l2timhtQl3R31UlOeiJYuML+Ox8HIndJtvCQHId
         jkvxCIkiU+rEsX9pHB17OOV3F3Q/47DriMZ5cWBqjgKQmjQjl2qIZ9/0iZFfn3B1kosb
         mjqcDyvhpsXSFpbSnCBkkJnb14/zHUJN0iwsVp2Slx8bUCeoTk4+QFXesPhSvuov6WAj
         CDDT7Ub+ChEKJdjwftiwP536A6EHaDoHkT4FZmqVDjx2wTjU283gC1ji4KrbBqOmJJ4l
         nGVOe8F2WTNLJF9FilAgkckpkrEYX44kY16L0I7WaAA93OPx2M1EgVD8ZgksJ38uwaQX
         tB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKsdCGqcs+0zD5THGY07mSR/c2f04iv5sGCUVYW3L8FkPimDp/PNU6O7bZ45pq1sroN2GCm8PmqKGDMMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgzT9Hf0Lmi4NZJF1ii1ziC51vh2G77wDM7/k4Fe1osXAiqvk
	cK8NaWeOLHDUGxET7OKosdXhVlcuy9fDJmLsWO400/N5xx7+sJpS/ZBfRg==
X-Gm-Gg: ASbGncuMhBefYMy1yhltE5q56emNJ5pxigZJUGzsMNkK2JQD04MiFCN5cb9wWvqTn8k
	fz+d4cCMZPjb3pPYWAxmW5IPLE3GIayPZZl0ZrMZ1Bv/lH+GT6VRNg4NLX6IPrnIIz0K6AYDB+f
	DJk2FCKqC2Ah+XilkRa9bFZ9yTNED0R7iny5AS/D8irQ+69QUlA0gLj9ees2/JTviQzyIH8dpD+
	LXmi2GH9Lt/UlUuRZEIRWG+onD9IJj6r8lsZbezSH/x1yniiIAcGqPpCzZZrXW/s4X/Rc1kI8qt
	o6sVBZJujlXjQtbnhSIi+WeoA1rq5GMsw6Lh1htRFQ==
X-Google-Smtp-Source: AGHT+IFWJ3tEaTBf+jH+bBPjUDfdcAyCfgL5UKGqFyabzfonE682xDuxsGBs/Igyhpbo6VaA+QjZLw==
X-Received: by 2002:a05:622a:1b8b:b0:476:8288:9558 with SMTP id d75a77b69052e-4801eadae2dmr165843211cf.46.1745814700658;
        Sun, 27 Apr 2025 21:31:40 -0700 (PDT)
Received: from iman-pc.home ([184.148.73.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9bd6c1cbsm62593661cf.0.2025.04.27.21.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 21:31:40 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH] cpufreq: fix locking order in store_local_boost to prevent deadlock
Date: Mon, 28 Apr 2025 00:33:56 -0400
Message-ID: <20250428043356.3169-1-ImanDevel@gmail.com>
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

Take cpu_hotplug_lock in the store() before down_write(&policy->rwsem),
and remove the internal cpus_read_lock/unlock pair
inside store_local_boost().

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
 drivers/cpufreq/cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index acf19b004..6e672dcba 100644
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
@@ -1045,10 +1042,12 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!fattr->store)
 		return -EIO;
 
+	cpus_read_lock();
 	down_write(&policy->rwsem);
 	if (likely(!policy_is_inactive(policy)))
 		ret = fattr->store(policy, buf, count);
 	up_write(&policy->rwsem);
+	cpus_read_unlock();
 
 	return ret;
 }
-- 
2.49.0


