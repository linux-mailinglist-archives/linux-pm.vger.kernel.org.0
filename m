Return-Path: <linux-pm+bounces-35857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E3BC9EE0
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8849D35451E
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD29D2ED870;
	Thu,  9 Oct 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRdyzqP2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E62C2ED858;
	Thu,  9 Oct 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025497; cv=none; b=Et+o4VXiLmAsI/0tRg6CMgX9CSfMMTpcYJs9NO4+ndib3TbZerJEwd8n4hufp94hVLHoIzkrYFztld4QwnoV7vXeZrxekompWsbQtOAA1lbVO0ERoP1Cx1K5Wx1E4NngPI9NM+1z9UU1XW5Yp/QwV97S8UglUBbcFW3A0v6j4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025497; c=relaxed/simple;
	bh=Imkb1krffdVd9dUc09lqWgoj2DlYbxNjjKJINgipLvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2otF5HREUM2S9JpNH9mahP6drepM+UeHiUB2JJGEPQ55qxZPzoOx81py7aJ4twM6wMMIWa4slzSNMPkYl299jDD/OOP+Ghs18mYAvOk2bLRkjyPuRzUic2QZdphH+suzlozBG7wFsbECDujrOCWMEy/7ja7UsADt6dkUO66nqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRdyzqP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92594C4CEF7;
	Thu,  9 Oct 2025 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025497;
	bh=Imkb1krffdVd9dUc09lqWgoj2DlYbxNjjKJINgipLvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRdyzqP2AVdoeZlxsAclgqFZOB4VtkHSnzycFOaiS/xMJCeOHs8TgMRfjByDr5x2w
	 /2guxGe80fb8+Ix3Tme7z8b1ocKI8hqoTGjRpCxSj6+KcqHdkMaQ81ypWfs0ObH/2P
	 Qlarzxe2BLmT20UbPo2BTOEPY4vXZ3UddDKpQ/2d7bcwfdt4YfLr4EbGDDYFO0WcmK
	 n1S7esDEDL9XsS9aDze5oeZhC8FwUKqX4hQFaDVh6w9hsYBva/DGc8NlfPvC4S1XiZ
	 NHPkELdT18iOhyAKzPhH93Ddyp6WsvSfry9cQ0yNRekXdbYCjCGd5OQ1a4HrvOg7F0
	 eSVW7C7m/HRwQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.10] cpuidle: Fail cpuidle device registration if there is one already
Date: Thu,  9 Oct 2025 11:54:43 -0400
Message-ID: <20251009155752.773732-17-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 7b1b7961170e4fcad488755e5ffaaaf9bd527e8f ]

Refuse to register a cpuidle device if the given CPU has a cpuidle
device already and print a message regarding it.

Without this, an attempt to register a new cpuidle device without
unregistering the existing one leads to the removal of the existing
cpuidle device without removing its sysfs interface.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation

- What it fixes
  - The patch adds an explicit per-CPU guard in the core registration
    path to prevent registering a second cpuidle device for a CPU that
    already has one. Specifically, it introduces an early check in
    __cpuidle_register_device:
    - drivers/cpuidle/cpuidle.c:641
      - if (per_cpu(cpuidle_devices, cpu)) { pr_info(...); return
        -EEXIST; }
  - Before this, the code unconditionally replaced the per-CPU pointer
    with the new device:
    - drivers/cpuidle/cpuidle.c:657
      - per_cpu(cpuidle_devices, cpu) = dev;
  - This “silent replacement” makes the prior device unreachable to the
    core (and duplicates entries on cpuidle_detected_devices), while its
    sysfs state remains present and bound to the old device object. The
    sysfs layer allocates a kobject that keeps a backpointer to the
    cpuidle_device:
    - drivers/cpuidle/sysfs.c:697 (cpuidle_add_sysfs) sets kdev->dev =
      dev and publishes it
    - drivers/cpuidle/sysfs.c:740 (cpuidle_remove_sysfs) tears it down
      for the same dev
  - If a new device is registered without first unregistering the old
    one, the old sysfs instance is never removed, leaving stale sysfs
    entries referencing the old cpuidle_device. That is at best user-
    visible breakage (stale sysfs) and at worst a lifetime hazard if
    that device is later freed by its owner.

- Why the change is correct and minimal-risk
  - The new guard is small, contained, and runs under the existing
    cpuidle_lock (as required by the function’s contract), so it’s race-
    safe with the unregister path.
    - The function comment already requires the lock;
      cpuidle_register_device holds it before calling
      __cpuidle_register_device (drivers/cpuidle/cpuidle.c:680).
  - It complements the existing check that only prevents double-
    registering the same struct (dev->registered):
    - drivers/cpuidle/cpuidle.c:682
    - That check does not cover the case of a different struct
      cpuidle_device for the same CPU. The new per-CPU check closes that
      gap.
  - The behavior change is limited to returning -EEXIST instead of
    proceeding to corrupt state. Callers already treat non-zero returns
    as failure and back out cleanly (see drivers like ACPI, intel_idle,
    etc., which unregister the driver or bail on error).
  - No architectural changes, no new features, no ABI changes. The only
    user-visible change is a pr_info() when misuse occurs.

- Stable backport considerations
  - It fixes a real bug with observable user impact (stale sysfs
    interface) and potential lifetime issues.
  - The fix is tiny (7 insertions and one trivial local-variable use)
    and self-contained to drivers/cpuidle/cpuidle.c: no dependencies on
    new APIs, no cross-subsystem changes.
  - It aligns with stable rules: important bugfix, minimal risk,
    confined to the cpuidle core.
  - It leverages existing per-CPU tracking (include/linux/cpuidle.h:116)
    and existing unregister semantics that clear the pointer and
    dev->registered, so it should apply cleanly across maintained stable
    branches.

Conclusion: This is a clear, contained bug fix that prevents a subtle
but serious state/lifetime problem in cpuidle registration. It is well-
suited for stable backport.

 drivers/cpuidle/cpuidle.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8b..56132e843c991 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -635,8 +635,14 @@ static void __cpuidle_device_init(struct cpuidle_device *dev)
 static int __cpuidle_register_device(struct cpuidle_device *dev)
 {
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	unsigned int cpu = dev->cpu;
 	int i, ret;
 
+	if (per_cpu(cpuidle_devices, cpu)) {
+		pr_info("CPU%d: cpuidle device already registered\n", cpu);
+		return -EEXIST;
+	}
+
 	if (!try_module_get(drv->owner))
 		return -EINVAL;
 
@@ -648,7 +654,7 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_USER;
 	}
 
-	per_cpu(cpuidle_devices, dev->cpu) = dev;
+	per_cpu(cpuidle_devices, cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
 	ret = cpuidle_coupled_register_device(dev);
-- 
2.51.0


