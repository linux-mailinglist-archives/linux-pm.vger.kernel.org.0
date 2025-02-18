Return-Path: <linux-pm+bounces-22353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E59FA3A9CA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 21:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135F81892AD0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81F270EDD;
	Tue, 18 Feb 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceGEIUg9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B42270EC2;
	Tue, 18 Feb 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910519; cv=none; b=ke1LT1BDuAOd1RcY70uHmY43QcWW/LsE1p+xON6tWeJ6UUSIjinOMnQ5Fu0gIHwR7jMsZ37+q7SgElZZjRWgIrmLBwRenMELUERWwK9oDw6cNAdFjQ0blud3ktUJZDcopvTwN2MbSnwUDHBlDJ9H+AILHN+i44KGHgEeYytYjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910519; c=relaxed/simple;
	bh=cDLiSDmsMXuenS+SicvdZHK93D6F34bp5PAEwgqlvYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdaoUCNGNP43otlSPNEaCoQlnu89koGj2s0If/3SO2SmmIHISZ22TzG8evE1yIFBLaf2HoNwMxH2nOws9CaYUtsoXg9UTaYhhPcjxzFV0qgUS4fe+nBAaV94P1BKOjXlZN2GKbwGT+CQtqF0nkwBUsalk3WmTYfl1H70Mdxv8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceGEIUg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C28C4CEE8;
	Tue, 18 Feb 2025 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910519;
	bh=cDLiSDmsMXuenS+SicvdZHK93D6F34bp5PAEwgqlvYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceGEIUg92Eu3Yfru+ffDetG3mPTsWM6i47koDZoTYJDU4TCHZmKGFdAlHhKhc21KA
	 T3IzAV1HLOjUcI6yCbBroGiy7dCg+Eak39KUY41gLCUIx0OtVVyl3RXKihZ7d8qADT
	 FeLFazi2L98HvWX0TX83m9QV3ct7+ck1ikkxhh0H151Py/nDKcCHMaluXjuPWZovpY
	 aCageMrKnux33JhK0M6hq/UGO1OdE7YZ8Jv5CSCN7WUcDBYfpGddfXhvRIf/8NXBpp
	 kjAfXD35oKv+WAElWX0WEKktG8ypR8BVbqNJSPY86OuaYovNRs1j8MmrtH/dWizk72
	 tZVSrdFxxlwRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	amit.kachhap@gmail.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/13] thermal/cpufreq_cooling: Remove structure member documentation
Date: Tue, 18 Feb 2025 15:28:14 -0500
Message-Id: <20250218202819.3593598-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202819.3593598-1-sashal@kernel.org>
References: <20250218202819.3593598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit

From: Daniel Lezcano <daniel.lezcano@linaro.org>

[ Upstream commit a6768c4f92e152265590371975d44c071a5279c7 ]

The structure member documentation refers to a member which does not
exist any more. Remove it.

Link: https://lore.kernel.org/all/202501220046.h3PMBCti-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501220046.h3PMBCti-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/20250211084712.2746705-1-daniel.lezcano@linaro.org
[ rjw: Minor changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/cpufreq_cooling.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9f8b438fcf8f8..bac0f52a361bd 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -57,8 +57,6 @@ struct time_in_idle {
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @em: Reference on the Energy Model of the device
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
  * @policy: cpufreq policy.
  * @cooling_ops: cpufreq callbacks to thermal cooling device ops
  * @idle_time: idle time stats
-- 
2.39.5


