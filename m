Return-Path: <linux-pm+bounces-27859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2903AAC8DC8
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 14:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75224E5AD5
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841122D7AC;
	Fri, 30 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU/JgtCf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797622D795;
	Fri, 30 May 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608739; cv=none; b=jfRi70Uue7E4b3TS9K2sD/rZgt4JhutE9CW3r0r/x1nQ16k72PaZUYZnhMBdsBXYWJP+YJVjuGyPLXH/afNJMSeE1n0bRfYXlHQqkjRiU/u8SBHzOSaJZm/3BVey4eb1NXkYAPpuSLqSASufUZbAVgC7Byhb4WBHY73kYwP5e6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608739; c=relaxed/simple;
	bh=mofjNI39pvb5v2Rqd1hK4qDlk3CC9m+PpFiOOXElFug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4lMijiZJX29Z5KhIgNy5FaZ3MPozbJUH19188VOA/Fnua2Hum5RXrbnjfqA4xAEbj/BG0cLm41/Aojgr4IIsOLKFN7nJtk9PObjWiJSp6L8Ar6VYvW47YUNTHoYi4aJo//MzI0YpJZK54l3R4AsvHA1bGLkf9p8C3DbDA947/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU/JgtCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC35C4CEF2;
	Fri, 30 May 2025 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608738;
	bh=mofjNI39pvb5v2Rqd1hK4qDlk3CC9m+PpFiOOXElFug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GU/JgtCf599mV0B/YffaBhCrOHXUR0RsetadbRxUkrgfxehhfpD17D3MoEuqZN5Ec
	 dd/brvFqtX+B3TSeWLMIhXO4nKEzoFvtNeeUBLZ6p3+sVuFOzh8UUYZZdLALCA7G5G
	 34H/OgsKI2ED6mm0on5dQDFiJseEMpXnDbK4Eb3Uc6uItC4G+Sg0sZnm9dMS/ZPjhs
	 2TWXLNa994sNSN8gV2BdokJRbdneXpbsdG7LmP5Bf+V3fHsv594sca4eykTosmOhGh
	 10d/5LrI3XXJaAWV2lsu8yUIePHwS1K31L7f2hGvn0ZpU8fWss9ripoe5thili7Efo
	 PsP0IUNUYIc2Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 04/30] power: supply: gpio-charger: Fix wakeup source leaks on device unbind
Date: Fri, 30 May 2025 08:38:26 -0400
Message-Id: <20250530123852.2574030-4-sashal@kernel.org>
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

[ Upstream commit 51212ce95354c5b51e8c3054bf80eeeed80003b6 ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250406202730.55096-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Detailed Analysis:** **1. Bug Fix Nature:** This commit fixes a
resource leak bug where wakeup sources are not properly cleaned up when
the device is unbound. The original code calls `device_init_wakeup(dev,
1)` but has no corresponding cleanup in the remove path, leading to
memory leaks. **2. Code Changes Analysis:** The fix replaces: ```c
device_init_wakeup(dev, 1); ``` with: ```c ret =
devm_device_init_wakeup(dev); if (ret) return dev_err_probe(dev, ret,
"Failed to init wakeup\n"); ``` The `devm_device_init_wakeup()` function
automatically manages the wakeup source lifecycle using the device
resource management system (`devm_add_action_or_reset()`), ensuring
proper cleanup when the device is removed. **3. Comparison with Similar
Commits:** This commit is nearly identical to the reference commits #1
and #2 (both marked "YES" for backporting): - **Similar Commit #1 (gpio:
mpc8xxx)**: Same exact pattern - replacing `device_init_wakeup(dev,
true)` with `devm_device_init_wakeup(dev)` - **Similar Commit #2 (gpio:
zynq)**: Adds `device_init_wakeup(&pdev->dev, 0)` in remove function -
Both were explicitly marked for stable with `Cc: stable@vger.kernel.org`
**4. Stable Tree Criteria Met:** - ✅ **Important bugfix**: Fixes
resource leaks that affect system stability - ✅ **Small and contained**:
Only 4 lines changed, very focused fix - ✅ **Minimal regression risk**:
Uses well-established devm pattern - ✅ **No architectural changes**:
Simple resource management improvement - ✅ **Clear side effects**: None
beyond fixing the leak **5. Technical Correctness:** The
`devm_device_init_wakeup()` function automatically calls
`device_init_wakeup(dev, false)` during device cleanup via the devm
framework. This is the standard pattern for managing wakeup sources in
modern kernel drivers. **6. Impact Assessment:** Resource leaks can
accumulate over time, especially in systems where devices are frequently
bound/unbound (like USB devices, hot-pluggable hardware). This fix
prevents potential memory exhaustion and system instability. The commit
follows the exact same pattern as other accepted backports for identical
wakeup source leak fixes, making it a clear candidate for stable tree
inclusion.

 drivers/power/supply/gpio-charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 1dfd5b0cb30d8..1b2da9b5fb654 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -366,7 +366,9 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_charger);
 
-	device_init_wakeup(dev, 1);
+	ret = devm_device_init_wakeup(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init wakeup\n");
 
 	return 0;
 }
-- 
2.39.5


