Return-Path: <linux-pm+bounces-30728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F97B02C7E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4649CA42A77
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111128A3ED;
	Sat, 12 Jul 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXTY0zfg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86F1EE7B7
	for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752346739; cv=none; b=misSciQ6fORuBXx2fdatLCfnL7xAHwR9DnHBZNo553rGsCZ7f3dFeUjcKNR9j58xklcaD3k2N4rukyBWQLysEOXyF9aK6SsNwk+eZ3LCBlusn5r9SuFDVyW98tLV6IJG7tPfylMo5DEtzkjbzcNmQrlgVGSApwcEQSCQSB+j4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752346739; c=relaxed/simple;
	bh=JkwH/l3SChOKmygtbFKD/IU6sIEe364VAj4aot2JrfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+7gY6FVxUyewif0JelKIJ3iKtu5adZtw3MBhoUWNzdUNh4fsj4yUYtHD4rgFrOr2a9YsqunE9unY2oAqQ9vnZZ6p0ND5g4nx/XD3urXHmm7EPud4S8mxi8wkNvGiayzl+qqWVcN8LN7rENbtv9ZRBLCyecfgYrW+p5t/V+qWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXTY0zfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB628C4CEEF;
	Sat, 12 Jul 2025 18:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752346738;
	bh=JkwH/l3SChOKmygtbFKD/IU6sIEe364VAj4aot2JrfI=;
	h=From:To:Cc:Subject:Date:From;
	b=nXTY0zfgmRJZ2bDUQ7fz/fsTsKm/Q28lMVRatB097sEE3AKlUEodMdFSRFt9xFjtU
	 ZHUQZrs+X4yT8UIWasfW0ySysZJavtETckdrR3y4fujgjmA5t/kdVC81anNUj1e82e
	 Wc9HbINMMsnjgeQbea1jeA0Nrqpf28md7AmMcJ6dk9QhrwSxZMm+3+T66lXabv389e
	 OCdw3iMYDppKgCpE1EYj70QQfXpoEgPgFZBQ8zRzLjYmUFMUA8iSiHlA4lihWMXMDt
	 TdefsXnRqdpGjg/ZMeiN/O39jZ9u2YwEtM8CX9m1C6SHxzqBlWwRqP2T4Zflulxmej
	 y8FGDh8Auy4kw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	guoqing.zhang@amd.com
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: Add stub for pm_hibernate_is_recovering()
Date: Sat, 12 Jul 2025 13:58:49 -0500
Message-ID: <20250712185851.591024-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Randy reports that amdgpu fails to compile with the following error:
ERROR: modpost: "pm_hibernate_is_recovering" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

This happens because pm_hibernate_is_recovering() is only compiled when
CONFIG_PM_SLEEP is set.  Add a stub for it so that drivers don't need
to depend upon CONFIG_PM.

Cc: Samuel Zhang <guoqing.zhang@amd.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/dri-devel/CAJZ5v0h1CX+aTu7dFy6vB-9LM6t5J4rt7Su3qVnq1xx-BFAm=Q@mail.gmail.com/T/#m2b9fe212b35fde11d58fcbc4e0727bc02ebba7b0
Fixes: c2aaddbd2dede ("PM: hibernate: add new api pm_hibernate_is_recovering()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/linux/suspend.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 293137210fdf4..b4f1d1f781df6 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -401,6 +401,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data);
 int hibernate_resume_nonboot_cpu_disable(void);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
+bool pm_hibernate_is_recovering(void);
 
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
@@ -416,6 +417,7 @@ static inline bool hibernation_available(void) { return false; }
 static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 	return -ENOTSUPP;
 }
+static inline bool pm_hibernate_is_recovering(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
 int arch_resume_nosmt(void);
@@ -426,7 +428,6 @@ int is_hibernate_resume_dev(dev_t dev);
 static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
 #endif
 
-bool pm_hibernate_is_recovering(void);
 
 /* Hibernation and suspend events */
 #define PM_HIBERNATION_PREPARE	0x0001 /* Going to hibernate */
-- 
2.43.0


