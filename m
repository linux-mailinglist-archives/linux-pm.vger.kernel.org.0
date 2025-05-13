Return-Path: <linux-pm+bounces-27065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85492AB48FE
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 03:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08737A5464
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 01:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25891194094;
	Tue, 13 May 2025 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/aUe5AS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0414E2E2;
	Tue, 13 May 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101303; cv=none; b=ZI5PbF8jkilHIIRv7X1A2Wdo6SXpHawy6Xcm5PPkUAQXn1sS60DSKO+Tg2SyRiAIwS+C/OJ1utIQDITa77Y5H4xvksg2QSt2QlRJkFYMpbq2gE7aZoUPZ8bUgMWKd2HoPy5/oWRSSLeYLuN6FTKoGs/3bQeYBC3F813yszEWve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101303; c=relaxed/simple;
	bh=Lzse6LpsfmjPCxHAw25TMkpoFLEQK6aNnxdLc61WhvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3/OYwT3920xfOGH2A7O8Ox/5/flyLKzyP8n/RCCt7hJ3bdrltRK4h0RZwOrfn5Leeu9VlS+JZOQiGQen/hfNjwdBdgE7YLNxG//vSNqL3z5aplxfkepn2kT269bxq1PyF/j7nD4Fd2DZRXD/UxNgo0aBGd4ndoKkS6j4MqHaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/aUe5AS; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso50198616d6.3;
        Mon, 12 May 2025 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747101299; x=1747706099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrmp34maV+5CJrub1fqE5o5oKE0u33rB5QJqF+9oIzo=;
        b=E/aUe5AS0Ggrh5fd3qdd93ag9mkzP9WgGfdakFFMSGQo9jMrXtL9wtM4CdVcYXwMaI
         Kxi8yNfglsbkel/q+nYjpR0pRCE+SQFgcgSdjCmkYe5Rz57fb0CjAAX4Yz1XSBm68Lni
         hnK3oelIHSEt0FxZWcH8UzPuzlsrisoYriCPbzbmc3kYyhSboFq+AlQfSeABQHTay7/h
         gxcx57W/3vO2hzZtvP2UZSyzoUBbhfcDHXDKpXnPT0jaP7xZlGKmkFkSnf38Bnepv7Mh
         6abOr7YuoKDWEsM/OZlyLQqxYaAoNUz6uWkVgB7wSeWSDgMWH8foTxuEVIt3Dwg6CSu9
         TJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747101299; x=1747706099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrmp34maV+5CJrub1fqE5o5oKE0u33rB5QJqF+9oIzo=;
        b=e92lbyv7VJFg534lU6VcycxB29+8R3fvsD4qxCpnb4Gde+NNICT8dV0VcItKlXlZnm
         ja7MI1Q+wlxTW1v369Gb/wi5iJP21jkrQKthdlQtmnU9h3OorTcqqFGtYqQu7myWKpzz
         LgNiTa43DLJWihd6ppK6VyOf1062o1fuMh0XAECv/ONmYCZ/XqK8Af0x0EoEu7YH4nDM
         Az9YOFeEBARPWXtzvjOIOx3KDiRmN91TMqd2F7zlkdniojWF2hbGG5fTiCvkPZCO75PG
         yvoMA5I3hYPnGXmVfU3Ng25HtyPDpyubAI9Yy0BMY90YVdEKUCSfrCDyMfhnQRtWJJ6/
         n+8A==
X-Forwarded-Encrypted: i=1; AJvYcCVhq5Xxf4ubZYb4H3A7lI/ulnWN99sNGLANGGSxZH2srE3KG9Hf1zgAnyveQN70cGqWOWdyHidr9bsXHy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqwAl69Gdg2v3S2tj6+8U9Lk2w4yTbju36Xaav//12bdpe+8T
	Zg5UVb/CI51fxhdx6fT0ezy1cyjJUh79Z6ksyhNsRG1FszPW1D89
X-Gm-Gg: ASbGncv2zKXO7Qquj0iOsPEt76abUtjtfUbS0oiy5+CAZ8iX3NB6Fm+Vtcq13vb8ALJ
	+aPuBM+MfxTHGzR+9oHYV7iuMlcBTpiY+cGWfWUbEu5kw9MgS3mou6Reg6NbaEFzqoU/mNyP9K0
	lGdi32EzxtDc/qy2eADvvISUSOd6K9oGELC/W1ywGMWY0r48d6yQfI1F+gqJRipi7JxFJjSv7IX
	cvlRsyZLntMjlct5cClJ+0ULEkQFSxWnujxyO1t7wIq8FpanjOYKCJCcRoCV1l2SvZDEVICxWld
	7MKhUknacVyQEYWN/RKsQPtFVQ2pcJI0a3BhtIjDj3eWcFpJyOY=
X-Google-Smtp-Source: AGHT+IHXujBhknGKYXu+3zqtXoBJw59paSUC9d1k4V/EEAXbsu/8/DE0TCswHmauBk+p0M1JMwzehg==
X-Received: by 2002:a05:6214:268e:b0:6e4:4194:df35 with SMTP id 6a1803df08f44-6f6e479573fmr268630366d6.9.1747101299450;
        Mon, 12 May 2025 18:54:59 -0700 (PDT)
Received: from iman-pc.home ([142.186.8.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a47311sm60064036d6.73.2025.05.12.18.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 18:54:58 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH] cpufreq: drop redundant cpus_read_lock() from store_local_boost()
Date: Mon, 12 May 2025 21:57:26 -0400
Message-ID: <20250513015726.1497-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep reports a possible circular locking dependency[1] when
cpu_hotplug_lock is acquired inside store_local_boost(), after
policy->rwsem has already been taken by store().

However, the boost update is strictly per-policy and does not
access shared state or iterate over all policies. Since policy->rwsem
is already held, this is enough to serialize against concurrent
topology changes for the current policy.

Remove the cpus_read_lock() to resolve the lockdep warning and
avoid unnecessary locking.

 [1]
 ======================================================
 WARNING: possible circular locking dependency detected
 6.15.0-rc6-debug-gb01fc4eca73c #1 Not tainted
 ------------------------------------------------------
 power-profiles-/588 is trying to acquire lock:
 ffffffffb3a7d910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0x56/0xd0

 but task is already holding lock:
 ffff8b6e5a12c380 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&policy->rwsem){++++}-{4:4}:
        down_write+0x29/0xb0
        cpufreq_online+0x7e8/0xa40
        cpufreq_add_dev+0x82/0xa0
        subsys_interface_register+0x148/0x160
        cpufreq_register_driver+0x15d/0x260
        amd_pstate_register_driver+0x36/0x90
        amd_pstate_init+0x1e7/0x270
        do_one_initcall+0x68/0x2b0
        kernel_init_freeable+0x231/0x270
        kernel_init+0x15/0x130
        ret_from_fork+0x2c/0x50
        ret_from_fork_asm+0x11/0x20

 -> #1 (subsys mutex#3){+.+.}-{4:4}:
        __mutex_lock+0xc2/0x930
        subsys_interface_register+0x7f/0x160
        cpufreq_register_driver+0x15d/0x260
        amd_pstate_register_driver+0x36/0x90
        amd_pstate_init+0x1e7/0x270
        do_one_initcall+0x68/0x2b0
        kernel_init_freeable+0x231/0x270
        kernel_init+0x15/0x130
        ret_from_fork+0x2c/0x50
        ret_from_fork_asm+0x11/0x20

 -> #0 (cpu_hotplug_lock){++++}-{0:0}:
        __lock_acquire+0x10ed/0x1850
        lock_acquire.part.0+0x69/0x1b0
        cpus_read_lock+0x2a/0xc0
        store_local_boost+0x56/0xd0
        store+0x50/0x90
        kernfs_fop_write_iter+0x132/0x200
        vfs_write+0x2b3/0x590
        ksys_write+0x74/0xf0
        do_syscall_64+0xbb/0x1d0
        entry_SYSCALL_64_after_hwframe+0x56/0x5e

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 731ecfc17..759dd178a 100644
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
 
-- 
2.49.0


