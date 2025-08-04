Return-Path: <linux-pm+bounces-31839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9FB199B1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7763B1BC5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967531EB5D6;
	Mon,  4 Aug 2025 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1JPy556"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95C15A8;
	Mon,  4 Aug 2025 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268179; cv=none; b=JW6MJR8UquCXli+vFjpO5lbgOu99j78h/9Xr1jYpW+jlOaOR12J+J9hg8U6ikGEYhoVu4smw1Qc5xplvAtC1WCvhRdbk7CXMlnurv87QJmcU3SRIJksKNSvf7PPJwpRgdcrYIpPl3dhbP70piyRlFBuOTkhi6Y3o8JKwx5o9vP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268179; c=relaxed/simple;
	bh=Ocw9mSuJmrBghlUl0i7EmtkvcRwW95PrxHa/ffOmmnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=em0tsEM+VokcUAcN2lhFLts6WvZys7gqDpgcyd1rIO6x6PZOyYQidJOqkVMxfzodV1eoQbZB8HN6ulSggatG+NPmhRFJa+gy6KvIkJu6Qq+8nqv3G68D7Evd0uY3uckUhBpZTahLEJ+wvZJEfbAtnmPoWfWxPVftuQg9YKpMQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1JPy556; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D81C4CEEB;
	Mon,  4 Aug 2025 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268179;
	bh=Ocw9mSuJmrBghlUl0i7EmtkvcRwW95PrxHa/ffOmmnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1JPy556GXDZpG+78NzMXJjbAxQlBYPgQTtmrSGuRYJZgaHsCFoYpVGeJ8ogcCMnl
	 go+mR49TBaR4OUCXTVCbfX1FPOzio163pZfFR5PPkDvMIDnleK5OcWygyXYk9J9JuO
	 QFdOJvRfaSWNsSGBi8Lt/nTK5YNzpF7/O1w5Bjq4WgK3zsbrUQ0XwN8lHa03mSAzP/
	 WURy2kI4Nm5H5hDoT2x7RebMF6EHlJ177wEy47VZy6ZXHjBFOsjs8VZyy+4saTzzHa
	 8o7Ec++oHUExmpfyP6HE4XWTlOHPQ4Cw3R9vdo6zLoyzEJTV9Y3w6d8e6N1ogaW4h2
	 W0VJFWImkFnhA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/28] PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()
Date: Sun,  3 Aug 2025 20:42:13 -0400
Message-Id: <20250804004227.3630243-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004227.3630243-1-sashal@kernel.org>
References: <20250804004227.3630243-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.296
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
index 7fa231076ad5..7d362b38f2e8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1698,6 +1698,11 @@ void pm_runtime_reinit(struct device *dev)
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


