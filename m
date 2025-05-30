Return-Path: <linux-pm+bounces-27860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848BFAC8DCF
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BC8A24844
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FD22DFAD;
	Fri, 30 May 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px5MgdZr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50B22DF96;
	Fri, 30 May 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608741; cv=none; b=gtJePHAi5sP+4PCQfFHDAIKEhztC4M8uiIvKkoTWJMEEiy5CkeB3lXjY4pWEeI9S3cKZ7uS5h+WlnQbaa41/GWLv3e+238q/86rveXBABSoOfkC/3+lTo4GAsP9Ss7y/AGBY6/JlSirfgIJSuNe6ylda6bOEEnM7AENtoMshqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608741; c=relaxed/simple;
	bh=xg8veMOPGvIOw6WvGZ0ho8TejVo3zpsy6lpGwjyRjUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFciuK1t7sJLchSeuKuFurJv7iqlL7jGZKZ4+dJh+TEqKsUApe07RSF8fzHxlYQ83PQmrLxBMRbmVPa04RsBQlHDCLDzqtpywCwtoSFkdnNEUcH9aSlvnO3HLz0R2M8j6Bb5M9yISHw0lO1i74tuXFwLMuIYz9ztW9XVFT6zhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px5MgdZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316CDC4CEE9;
	Fri, 30 May 2025 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608741;
	bh=xg8veMOPGvIOw6WvGZ0ho8TejVo3zpsy6lpGwjyRjUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Px5MgdZrYgiWBFcbv6B7c2aHS8KvqQMz+vhsiz+fiBO0KsEIlFticn/D1KTGMlMPa
	 1vVn2XtBNEnx5YmngK3D49T7HkWm+zE4HNNFcWTvryMCG5tMBAmqEBSwgNq61wEx9w
	 2q0R52/qb7rECSp5ibuNMhWTlqCIF8+TDqmtFDoiL2AMK8uMCDxFXQp2E9JE2T1QdY
	 vPRhJ/O9MCHc6co8fMj4GMb3spr7ytunybcPvdhFCK3+3Q86D5Le6e0/yqC9mTAYnY
	 +6ZsKQHZ3ifc6r9B6k/m9w3eb+V7ahBKVi9Pg1ACZdkxN9DF6lCyZfevqAF9nC5TbS
	 NCxTk9NrXxiPQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 06/30] power: supply: collie: Fix wakeup source leaks on device unbind
Date: Fri, 30 May 2025 08:38:28 -0400
Message-Id: <20250530123852.2574030-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123852.2574030-1-sashal@kernel.org>
References: <20250530123852.2574030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c73d19f89cb03c43abbbfa3b9caa1b8fc719764c ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250406202730.55096-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Perfect! This confirms the pattern. Now let me analyze the commit:
**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Justification for Backporting ### 1. **Bug Fix
Nature** The commit fixes a resource leak bug where wakeup sources are
not properly cleaned up when the device is unbound. This is a clear bug
fix that affects system resource management. ### 2. **Matching Pattern
with Similar Commits** This commit follows the exact same pattern as the
similar commits marked "YES" for backporting: - **Similar Commit #1
(gpio: mpc8xxx)** and **Similar Commit #3 (gpio: zynq)** both have
identical commit messages and fix the same type of wakeup source leak by
adding `device_init_wakeup(&pdev->dev, 0)` in the remove function. - All
these commits are from the same author (Krzysztof Kozlowski) and have
`Cc: stable@vger.kernel.org` in their commit messages, indicating
explicit intention for stable tree inclusion. ### 3. **Code Analysis**
The code change is minimal and surgical: - **Single line addition**:
`device_init_wakeup(&ucb->dev, 0);` in the `collie_bat_remove()`
function - **Proper cleanup ordering**: The line is added at the
beginning of the remove function, which is the correct place for
resource cleanup - **Symmetric operation**: The probe function calls
`device_init_wakeup(&ucb->dev, 1)` at line 414, and now the remove
function properly disables it with `device_init_wakeup(&ucb->dev, 0)`
### 4. **Resource Leak Prevention** From examining the kernel tree, I
can see that: - The probe function enables wakeup with
`device_init_wakeup(&ucb->dev, 1)` - Without this fix, when the driver
is unbound, the wakeup source memory is leaked - This follows the
established pattern seen in other drivers like gpio-zynq.c where
`device_init_wakeup(&pdev->dev, 0)` is called in remove functions ### 5.
**Low Risk Assessment** - **Minimal scope**: Only affects the collie
battery driver cleanup path - **No functional changes**: Doesn't change
driver behavior, only fixes resource cleanup - **No architectural
changes**: Single line addition for proper resource management - **No
new features**: Pure bug fix ### 6. **Stable Tree Criteria Compliance**
- ✅ **Important bug fix**: Prevents resource leaks - ✅ **Minimal risk**:
Single line, well-understood API call - ✅ **No new features**: Only
fixes cleanup - ✅ **Small and contained**: Confined to one driver's
remove function - ✅ **Clear side effects**: Only positive effect of
proper resource cleanup ### 7. **Explicit Stable Tree Intent** The
commit message doesn't include `Cc: stable@vger.kernel.org`, but the
similar commits #1 and #3 from the same author fixing identical issues
do have this tag, suggesting this is part of a series addressing wakeup
source leaks across multiple drivers. The fix is essential for proper
resource management and follows established kernel patterns for wakeup
source cleanup during device unbinding.

 drivers/power/supply/collie_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/collie_battery.c b/drivers/power/supply/collie_battery.c
index 68390bd1004f0..3daf7befc0bf6 100644
--- a/drivers/power/supply/collie_battery.c
+++ b/drivers/power/supply/collie_battery.c
@@ -440,6 +440,7 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 
 static void collie_bat_remove(struct ucb1x00_dev *dev)
 {
+	device_init_wakeup(&ucb->dev, 0);
 	free_irq(gpiod_to_irq(collie_bat_main.gpio_full), &collie_bat_main);
 	power_supply_unregister(collie_bat_bu.psy);
 	power_supply_unregister(collie_bat_main.psy);
-- 
2.39.5


