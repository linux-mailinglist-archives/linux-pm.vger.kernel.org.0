Return-Path: <linux-pm+bounces-22351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EAA3A938
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 21:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794957A212F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3098420E016;
	Tue, 18 Feb 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl36hLIe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B920DD59;
	Tue, 18 Feb 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910421; cv=none; b=Xo5NcV47Fuqwpkgh31EAQrPN7ceHf7XeKINp8l0Q4dXBjNgMxfcBKmpQdYuVJ+XykdX3QJQ77+bnp36rdyHtQSmTqjzXwHYPHtB8orVKdMm7ile/9ogV3FZDQVZvzACOlyh0cc/ZbWaEYhhaV1Eucs8iyKI4QtuKHLTV3QpdrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910421; c=relaxed/simple;
	bh=mKMJDW6nakEGmrz4QiQyiO3fhORm4+3vCRoK1DdyepQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p78Paz2mzc5eeHf+kRT1pYPGpC3ZuHiUjuVDHxlznyKb2BZ+nnPK++Tfj/Qy0vVWQ9txQYYW1no4eb+Ym+EcwcEWcB0NcQZnUoyyQFbjEwIlJW+pXb/6tB7bQkzGaoKk1htR9Gg68oAiW6xBTLtnFFPsCPPMfZqtd42OTKI/8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl36hLIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DC4C4CEE8;
	Tue, 18 Feb 2025 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910420;
	bh=mKMJDW6nakEGmrz4QiQyiO3fhORm4+3vCRoK1DdyepQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kl36hLIeR+Aq/g8ZJBCO7Hk2KFGMHzKgkAxdAbZn30/0ptwgvqd9mZ5pyLljzGUtx
	 jD8Iy/doq5Mdv3e+EZI3XLxiYS3c60YLVswsJSZBHTOgFQZP9Oxa7BY2iY/d5pKP1Y
	 nC28FinlfOW5gqv8VK5TiDLAENA2IENhphP5TLjxMX45Z3W/Qe4ca4aJe3G6ZfFsgV
	 cRrpg9DkIowbPtNKnbzNIwQQOXa7ChC+EXxVPCeDC4OIOm/oSlhoYR3XABXypuyjmO
	 ihY7DK1wGXTLJ4hUUJk7GIDKoCjRaoCkBRnVckK5r+UkAEECWJpXaIMMdUE3nUP2G2
	 QkIKRGmdLGCfQ==
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
Subject: [PATCH AUTOSEL 6.12 20/31] thermal/cpufreq_cooling: Remove structure member documentation
Date: Tue, 18 Feb 2025 15:26:06 -0500
Message-Id: <20250218202619.3592630-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
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
index 280071be30b15..6b7ab1814c12d 100644
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


