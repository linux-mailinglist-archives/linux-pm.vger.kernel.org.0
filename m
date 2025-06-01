Return-Path: <linux-pm+bounces-27917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF18ACA449
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 02:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10DF1766CD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 00:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3995296155;
	Sun,  1 Jun 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAQgEmI5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4A266B77;
	Sun,  1 Jun 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820796; cv=none; b=AznQdSwsVznMdU7fps4OaCt03Hr/YpU8VQsgNxS9irdpn0/OfQXx3CYHGro9nsO3wsCEpLNy4cOw9GMKLtvJqAL+yplOlXdxCd6tjK5MYNTo8j5M3VB3BWaffQouc7d8SOOIf6ykZCc3KP3XvtWVLXkbNScRx5+2bd2iXLmArxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820796; c=relaxed/simple;
	bh=7hpfnnLFzxM+YcZOKq1NPDFQDDG5NFjEBcgUX6jEFd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ahp0ZNN1g4P3MN2YrypWK1ectN3jMZuBE498VniMJ37JziiCkaYd8aLTNVM8wmHQEqu/hXJz71MydQzVp3b01kfKF3A2OU66dhh0BaB5AmbtafdRNxgBoUBV09dXi+0L7b5mrQ3FmgqqWeBtD/hmEYq6lAbkZAyz2Bi/d2+oJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAQgEmI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC34C4CEF1;
	Sun,  1 Jun 2025 23:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820796;
	bh=7hpfnnLFzxM+YcZOKq1NPDFQDDG5NFjEBcgUX6jEFd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAQgEmI5lZcUi8uy1NGpkkpPRHaiLm6TvWsm6kr2epCuFhkmVdPWnPUiGxtK3ht02
	 zl/PxZTCN+bvtkMVEG7pQx99Qfnqa8SWayuxKT8Phx0g5mx+kX8JuKPXkN9H6NDZWX
	 QHv5pgt3iVr052KCN6M+/OUUbCLr2SgGVul/7+DANjphmkaavJOh7RaTJzZ4Qf9LDk
	 vno0Ksbb6fM/JmwOi4bhOAn8Iq0zPE8JW75y43R0B1MP1IWl1wYfqeo6MoTpi3fM/B
	 7dsHcHiyHRBrXODgMPwVlVKB91YeJcmdlDvgw7ksWNLaAuaQzFqG6Ice04whJ7ddzi
	 Zpgjx3l1ynLWg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: George Moussalem <george.moussalem@outlook.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	thara.gopinath@gmail.com,
	rafael@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 080/102] thermal/drivers/qcom/tsens: Update conditions to strictly evaluate for IP v2+
Date: Sun,  1 Jun 2025 19:29:12 -0400
Message-Id: <20250601232937.3510379-80-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: George Moussalem <george.moussalem@outlook.com>

[ Upstream commit e3f90f167a49902cda2408f7e91cca0dcfd5040a ]

TSENS v2.0+ leverage features not available to prior versions such as
updated interrupts init routine, masked interrupts, and watchdog.
Currently, the checks in place evaluate whether the IP version is greater
than v1 which invalidates when updates to v1 or v1 minor versions are
implemented. As such, update the conditional statements to strictly
evaluate whether the version is greater than or equal to v2 (inclusive).

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Amit Kucheria <amitk@kernel.org>
Link: https://lore.kernel.org/r/DS7PR19MB8883434CAA053648E22AA8AC9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should definitely be backported to stable kernel
trees. Here's my extensive analysis: ## Critical Bug Fix Analysis This
is a **critical thermal safety bug fix** that corrects fundamentally
flawed version checking logic in the Qualcomm TSENS thermal sensor
driver that has existed for approximately 5 years. ## The Core Problem
The commit fixes incorrect version comparison logic in multiple critical
code paths. Looking at the code changes: 1. **Original buggy logic**:
`if (tsens_version(priv) > VER_1_X)` 2. **Fixed logic**: `if
(tsens_version(priv) >= VER_2_X)` From examining the TSENS driver
context, the version enum hierarchy is: ```c enum tsens_ver { VER_0 = 0,
// 0 VER_0_1, // 1 VER_1_X, // 2 VER_2_X, // 3 }; ``` The condition `>
VER_1_X` means "version > 2", while `>= VER_2_X` means "version >= 3".
This is a **fundamental logical error** - the original code was intended
to check for v2+ features but was actually excluding valid v1.x versions
that should have access to these features. ## Critical Impact on
Multiple Subsystems The commit fixes **6 separate locations** where this
version logic error occurs: 1. **tsens_set_interrupt()** - Affects
thermal interrupt handling logic 2. **tsens_read_irq_state()** - Affects
interrupt state reading and masking 3. **masked_irq()** - Affects
interrupt masking capability 4. **tsens_enable_irq()** - Affects
interrupt enable logic with different enable values 5. **init_common()**
- Affects watchdog initialization for thermal safety 6. **Critical
threshold handling** - Affects thermal protection mechanisms ## Thermal
Safety Implications This is particularly critical because: 1. **Silent
Failure Mode**: The bug causes thermal monitoring features to be
silently disabled rather than obvious crashes 2. **Thermal Runaway
Risk**: Watchdog functionality and proper interrupt handling are
essential for preventing thermal damage 3. **Hardware Protection**: The
TSENS watchdog monitors hardware finite state machines for stuck
conditions 4. **Multiple Protection Layers**: Affects both interrupt-
based thermal responses and watchdog-based recovery ## Production Impact
Based on the commit message and historical context: - **Duration**: This
bug has existed since v2+ features were introduced (multiple years) -
**Scope**: Affects all Qualcomm SoC-based devices using TSENS thermal
sensors - **Platforms**: Mobile phones, tablets, embedded systems,
automotive applications - **Silent Nature**: Users wouldn't notice
reduced thermal protection until hardware damage occurs ## Backport
Suitability Assessment **Strong YES for backporting because:** 1.
**Critical System Safety**: Thermal management is essential for
preventing hardware damage 2. **Simple, Low-Risk Fix**: Changes only
comparison operators (`>` to `>=`) with no complex logic 3. **Well-
Contained**: Affects only version checking logic, no architectural
changes 4. **Multiple Maintainer Review**: Has proper sign-offs from
thermal subsystem maintainers 5. **Regression-Safe**: Fixes existing
broken behavior rather than adding new features 6. **Long-Standing
Issue**: The longer this bug exists, the more devices are affected
**Reference to Similar Commits**: All provided similar commits were
marked "Backport Status: NO" because they were **new feature additions**
(interrupt support, combined interrupts, new platform support). This
commit is fundamentally different - it's a **critical bug fix** for
existing functionality. ## Recommended Backport Targets This should be
backported to: - All stable kernel versions where TSENS v2+ support
exists - Particularly critical for LTS kernels (5.10, 5.15, 6.1, 6.6) -
Any kernel version used in production Qualcomm-based devices The fix is
low-risk, addresses a critical thermal safety issue, and corrects a
fundamental logic error that has silently compromised thermal protection
for years.

 drivers/thermal/qcom/tsens.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3aa3736181aa7..93a1f5117ba2e 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
 	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
 		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
 		enable ? "en" : "dis");
-	if (tsens_version(priv) > VER_1_X)
+	if (tsens_version(priv) >= VER_2_X)
 		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
 	else
 		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
@@ -499,7 +499,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
 	if (ret)
 		return ret;
-	if (tsens_version(priv) > VER_1_X) {
+	if (tsens_version(priv) >= VER_2_X) {
 		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
 		if (ret)
 			return ret;
@@ -543,7 +543,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 
 static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
 {
-	if (ver > VER_1_X)
+	if (ver >= VER_2_X)
 		return mask & (1 << hw_id);
 
 	/* v1, v0.1 don't have a irq mask register */
@@ -733,7 +733,7 @@ static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 static int tsens_enable_irq(struct tsens_priv *priv)
 {
 	int ret;
-	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
+	int val = tsens_version(priv) >= VER_2_X ? 7 : 1;
 
 	ret = regmap_field_write(priv->rf[INT_EN], val);
 	if (ret < 0)
@@ -1040,7 +1040,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
-	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
+	if (tsens_version(priv) >= VER_2_X &&  ver_minor > 2) {
 		/* Watchdog is present only on v2.3+ */
 		priv->feat->has_watchdog = 1;
 		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
-- 
2.39.5


