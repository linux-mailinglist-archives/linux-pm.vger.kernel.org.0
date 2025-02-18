Return-Path: <linux-pm+bounces-22354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24FA3A9FF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 21:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3445B3B009E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46C280A48;
	Tue, 18 Feb 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCHWN5XW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25403280A45;
	Tue, 18 Feb 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910539; cv=none; b=ea4OKNBqNopDKv6Mx/RSA+n5/uNudnCycDifX/IaQ4x01Z3iZVnIgHwo7HyLMu9LTrpSfOkWrHcuBsAF2KfLQ3H6V2yHp4fb3h+7kATtx0jylBoFbo8pU1ZlGSW8qX2dtVV25dLNl5PClKyoSenpbmhm3zV488N2Lvc96SupCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910539; c=relaxed/simple;
	bh=R+d/UN2g1Ot0PZPzuPdC1Ph2qbaat1iTw8Rwta8bHyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHexK/B5t2upPtEnJYPQ9GCN+qO5MAvrLzk21Xgu9b2KJ+9D4xPIcHOdiKgd6entdrzB4a0fCR8ItMM9y14yXwGb4cxkL2xlWxyNwgIjpBWGQTgPz5V8ezW2P7fgOSA+KlUWoVAoTY2nNM4GoT+FmEx/9DmqTq9AfBoeXhwWHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCHWN5XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F190FC4CEE4;
	Tue, 18 Feb 2025 20:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910539;
	bh=R+d/UN2g1Ot0PZPzuPdC1Ph2qbaat1iTw8Rwta8bHyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCHWN5XWA6khghgrsxXe1U7MwQnJvlJmF5tMqrCbSpZRhoX11+LtOPU1tUxzf3NZA
	 za9W7OIVTByZd+rutpNarncbmMPFCfT6njXfiO+CC6RGHRkBsFfyc6KdRRl7NE4DLZ
	 /MCoFKMcORPVLhB0BVlx0dVdiF28+MU5EVc31e1o2m2twoTvCu+1r5ylk2j09+S/5j
	 uGglUhA1fviMZFsCdGMl4OYShzew+WfKbhyGrp5D1CSKpTnDYX4WdegjQpvi7uehYP
	 kvzP+Hn11P8EP0MFk3y8MD48ah41L9j1kIZm9UnSs2xkavdoLE8dDENx4h873Ijvgy
	 xgevZoF+x5vnw==
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
Subject: [PATCH AUTOSEL 5.15 5/6] thermal/cpufreq_cooling: Remove structure member documentation
Date: Tue, 18 Feb 2025 15:28:46 -0500
Message-Id: <20250218202848.3593863-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202848.3593863-1-sashal@kernel.org>
References: <20250218202848.3593863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 12a60415af955..8171c806f5f6f 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -56,8 +56,6 @@ struct time_in_idle {
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @em: Reference on the Energy Model of the device
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
  * @policy: cpufreq policy.
  * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
-- 
2.39.5


