Return-Path: <linux-pm+bounces-31965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF7B1B4B7
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4817AAD93
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA827703D;
	Tue,  5 Aug 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUOzlLul"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CE21146C;
	Tue,  5 Aug 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399534; cv=none; b=Ijjxv9Bh7o/RcZxPLzEzBKapOCZe+96HKPUiHBvHTTBbF7oBjuA9JjdVno67qHzqOKn+fAm04NHwPpdMijxQPpKxrLWyuYoS7I3yb7RrD8GmIkLhv+PVlBmjer4t5Ttdiu1iTVsmep2sqL7HHwGT31s139zyT++17cyGuP04+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399534; c=relaxed/simple;
	bh=K0B0wmFt8B/msOHiP3rD2mNLmCrvReFg4m/49vbj8Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjZzLBvh9wuDNvdp7jFiTCTcH9J2eaQZXIuY+N+Ly0LnkiAIfQAccUYNtgVezTFnKitXn6eRmol02Rd0sLpDymROjxqV0ywMbFGcuCkhLESIaL+Y8IqQgtKJrlpwAGcjmO85R4gX3n9at6YGgAVVMkA4IWmzSztKooYnmy8jOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUOzlLul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D2C4AF09;
	Tue,  5 Aug 2025 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754399533;
	bh=K0B0wmFt8B/msOHiP3rD2mNLmCrvReFg4m/49vbj8Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUOzlLul8o6q80qTzuywppaQLtOZ6eAKjpT5U2EvX5GTENJ1h3i+u7bV+3RsrptPP
	 A+hv2hGPr3TO7bDYo/xg1bjggxusedXt/3IawF7k77izjNyaTZ51+OudcOjnSaoAw7
	 b9Lg1/cN+d5XyEBaGOwNVjMfL/nctjP9H48wGPhoD7USYO9t2mDkBn4pL+ClutHA1B
	 b7KnYQDdqPULD2a8sJ4vdgZ89Tie4pO88/rIRjKjHontp+uesekKT0kAu68MKDSTyB
	 8npgE677mlvU8AQNeCwbk/hgoYys+1APouXzkpXsrBNcVPKB9XYuwGPYSLlSSzfRv8
	 johdOHfu5Qj9g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.6] power: supply: qcom_battmgr: Add lithium-polymer entry
Date: Tue,  5 Aug 2025 09:09:39 -0400
Message-Id: <20250805130945.471732-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805130945.471732-1-sashal@kernel.org>
References: <20250805130945.471732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 202ac22b8e2e015e6c196fd8113f3d2a62dd1afc ]

On some Dell XPS 13 (9345) variants, the battery used is lithium-polymer
based. Currently, this is reported as unknown technology due to the entry
missing.

[ 4083.135325] Unknown battery technology 'LIP'

Add another check for lithium-polymer in the technology parsing callback
and return that instead of unknown.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250523-psy-qcom-battmgr-add-lipo-entry-v1-1-938c20a43a25@linaro.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis, here is my determination:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real user-visible bug**: The commit addresses a specific
   bug where lithium-polymer batteries are incorrectly reported as
   "Unknown battery technology" with the error message `Unknown battery
   technology 'LIP'`. This affects real hardware (Dell XPS 13 9345
   variants) and causes incorrect battery technology reporting to
   userspace.

2. **Small and contained fix**: The change is minimal - it adds just 2
   lines of code:
  ```c
  if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
  return POWER_SUPPLY_TECHNOLOGY_LIPO;
  ```
  This is well within the 100-line limit for stable patches.

3. **Obviously correct**: The fix is straightforward and follows the
   existing pattern in the code. It simply adds recognition for "LIP"
   chemistry strings, similar to how "LIO" is already handled for
   lithium-ion batteries. The `POWER_SUPPLY_TECHNOLOGY_LIPO` constant
   already exists in the kernel's power supply framework.

4. **No architectural changes or new features**: This is purely a bug
   fix that enables proper recognition of an existing battery technology
   type. It doesn't introduce new functionality or change any APIs.

5. **Low regression risk**: The change only affects systems that report
   "LIP" battery chemistry. Systems with other battery chemistries
   remain unaffected. The fix follows the exact same pattern as the
   existing lithium-ion handling.

6. **Affects supported hardware**: The qcom_battmgr driver has been in
   the kernel since v6.3, and this fix is needed for proper battery
   reporting on Dell XPS 13 9345 devices using Qualcomm platforms with
   lithium-polymer batteries.

7. **Meets stable kernel rules**: According to
   Documentation/process/stable-kernel-rules.rst, this qualifies as it
   "fixes a real bug that bothers people" - specifically incorrect
   battery technology reporting that could affect power management
   decisions and user-facing battery information.

The commit is an ideal candidate for stable backporting as it fixes a
clear bug with minimal code changes and virtually no risk of regression.

 drivers/power/supply/qcom_battmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index fe27676fbc7c..2d50830610e9 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -981,6 +981,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
 {
 	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
+	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
+		return POWER_SUPPLY_TECHNOLOGY_LIPO;
 
 	pr_err("Unknown battery technology '%s'\n", chemistry);
 	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
-- 
2.39.5


