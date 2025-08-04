Return-Path: <linux-pm+bounces-31834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C3B1999F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09163A4644
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437DB1D8E10;
	Mon,  4 Aug 2025 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDM24PFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7E13B5A9;
	Mon,  4 Aug 2025 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268085; cv=none; b=RJxON/FJar6dnnh2pc33htDfkh2G2E6tO7dZUEGr4OMDIa1lEEQmL0+0q+0qGHOPQHwbTcvoWnQh/V02iLLPIO4iRyHEAZFcksqylwazLKOxjtcaOpnOe/6/JRlHGlsoRHVkzplVxRjId7QDaiXQwxjZWzkVdD7UqTKjdGV0zSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268085; c=relaxed/simple;
	bh=tTMwGQs/BQo5tqJ1PnGEFbOv0UTs8oEvdxyQxqXJtBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryGrGlf3rp578fsDhVtHqtvEKa9wraXB0mQI7tM9k7ZxSAOdbjgPaGJxtQK9TTJ1XEPNHHgODy/ZDSFwd+cCchyy02Eb5wFZ/XvUQ2flILpbtQevvdJAkcsuzO0X/LKSTdexN2Bp7EWDyZo27VhXEukjGVnx7u4MRnIgH6I6zRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDM24PFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EFDC4CEF0;
	Mon,  4 Aug 2025 00:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268085;
	bh=tTMwGQs/BQo5tqJ1PnGEFbOv0UTs8oEvdxyQxqXJtBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDM24PFUU+Xqy379u32aF+JJgXX5SX8o1P0eYTZNqObHEeEvnbTBJDCpLZcYT3BgN
	 v+maNo3KgM4Qu+otCt/hFtRgRZjA28mpjiqhErYIVmEX+6aOD5/qByN3FcgMvdEiM/
	 2+8Ztq+w0NkUOtuS2vfIQTOf2gBEIJxD1D039rPxdZJmXcvIUUiRXaocceMTN0r6zo
	 tscQNFTX8ni3cj5XZb0JsugCNPKVEngETAlhRaTsxItg8TLxpD5ehOukAkDFDZjgK0
	 yMU1J7pr0fzo6VrBovwq1O1EQerZmhogMFgYO8o2ZnZ/LC0djR9NFcewVRrSoizoGf
	 cOfo3Snr1+ytA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/39] PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()
Date: Sun,  3 Aug 2025 20:40:19 -0400
Message-Id: <20250804004041.3628812-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004041.3628812-1-sashal@kernel.org>
References: <20250804004041.3628812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 89d9cec3b1e9c49bae9375a2db6dc49bc7468af0 ]

Clear power.needs_force_resume in pm_runtime_reinit() in case it has
been set by pm_runtime_force_suspend() invoked from a driver remove
callback.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://patch.msgid.link/9495163.CDJkKcVGEf@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit is a clear bugfix that should be backported to stable kernel
trees for the following reasons:

1. **It fixes a real bug**: The commit addresses a specific issue where
   `power.needs_force_resume` flag is not cleared in
   `pm_runtime_reinit()` when a device is removed. If a driver calls
   `pm_runtime_force_suspend()` from its remove callback (which sets
   `needs_force_resume = 1`), this flag remains set even after the
   device is removed and potentially re-probed.

2. **The fix is minimal and contained**: The change adds just 5 lines of
   code (including comments) to clear a single flag. The modification
   is:
  ```c
  dev->power.needs_force_resume = false;
  ```
  This is a very low-risk change that only affects the specific
  condition being fixed.

3. **It prevents state leakage**: Looking at the code flow:
   - `pm_runtime_force_suspend()` sets `dev->power.needs_force_resume =
     1` (line in runtime.c)
   - When a driver is removed, `pm_runtime_remove()` calls
     `pm_runtime_reinit()`
   - Without this fix, if the device is re-probed, it would still have
     `needs_force_resume = 1` from the previous instance
   - This could lead to incorrect PM runtime behavior where
     `pm_runtime_force_resume()` would incorrectly think it needs to
     resume a device that was never suspended in the current probe cycle

4. **Related to previous stable fixes**: The git history shows a
   previous commit `c745253e2a69` ("PM: runtime: Fix unpaired parent
   child_count for force_resume") was already marked for stable (4.16+),
   indicating that issues with the `needs_force_resume` flag have been
   problematic enough to warrant stable backports.

5. **Clear bug scenario**: The commit message describes a specific
   scenario where this happens - when `pm_runtime_force_suspend()` is
   called from a driver remove callback. This is a legitimate use case
   where drivers want to ensure devices are suspended before removal.

6. **No architectural changes**: This is purely a bugfix that clears a
   flag that should have been cleared during reinitialization. It
   doesn't introduce new features or change any APIs.

The fix ensures proper PM runtime state management across device removal
and re-probing cycles, which is important for system stability and
correct power management behavior.

 drivers/base/power/runtime.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 58d376b1cd68..7e912d2ed427 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1716,6 +1716,11 @@ void pm_runtime_reinit(struct device *dev)
 				pm_runtime_put(dev->parent);
 		}
 	}
+	/*
+	 * Clear power.needs_force_resume in case it has been set by
+	 * pm_runtime_force_suspend() invoked from a driver remove callback.
+	 */
+	dev->power.needs_force_resume = false;
 }
 
 /**
-- 
2.39.5


