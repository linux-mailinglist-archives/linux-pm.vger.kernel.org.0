Return-Path: <linux-pm+bounces-22355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47730A3A9EA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACA17A6BC3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA81DF980;
	Tue, 18 Feb 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRuG2fB9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232251DF97F;
	Tue, 18 Feb 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910553; cv=none; b=fLPsnFiPdBHbY4XIe1PC3h0twdYFrycuqVgeO2o9/N4WcXxhJoKv/gVInOMCGA5so798Y5H0vJwfux6qEtWhXoKXJ7zb0mhm5nsw0wuvgC6k+p/6nEeuBGPJ3QWgTMa0/e/1Rsv2xDcDIYKkukqOuEM5aPRMsWtsj2H5PDmOAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910553; c=relaxed/simple;
	bh=sXtIkUA/APeJxn7Lh9q2n+/onQmwP2eLpR6VI+YxLd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1AVKFU22fOhItkbhPyoWeS9FslXPNRTCAoStJP2MmO/o+YUoY8b2GeZUOa1T0MjFhrlXCSvfzZj5z9t3ZMazB6KSuc+xGN5/ZllJ70WiMc6NdgwSqfh5D/+SBuatij5nzGNTtiVz6Rvm0yOD5sjmBndZPaa549NL+va97XtGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRuG2fB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF11C4CEE9;
	Tue, 18 Feb 2025 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910553;
	bh=sXtIkUA/APeJxn7Lh9q2n+/onQmwP2eLpR6VI+YxLd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRuG2fB9E0OnBJdgbfuhgRF+tj5h1jArtdjyXbs1KB3bVEsUetnZCvs4mO7XS9Q3Z
	 voohXmO8Dt8XglOHwYs6lyDWYwErOMQ6Vi4uefBefRi0XhLxcgLZyB7dOn8ANs+qPV
	 jMKq8QP4r/5w7ZzvR27K8wBd+zEQZPU7pTw5nuWoetkQqYtEe/h2etSlyO6hfNyfYw
	 AyJsY49wjRTJR1EqFbZpXZmqfcEjUWxe6GQwEhbQm//nba/Vt0w7JmCHg6wfhNN8cp
	 XQu5Y6VCfOnp8Qb9nN2qQctvDFImyMLWNd1k2nI7ZryNJdP4ImBhvRvZczKqfAecuN
	 KWCjiBIhqTf+w==
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
Subject: [PATCH AUTOSEL 5.10 4/4] thermal/cpufreq_cooling: Remove structure member documentation
Date: Tue, 18 Feb 2025 15:29:02 -0500
Message-Id: <20250218202903.3593960-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202903.3593960-1-sashal@kernel.org>
References: <20250218202903.3593960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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
index 6e1d6a31ee4fb..f1ae1530aa642 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -58,8 +58,6 @@ struct time_in_idle {
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @em: Reference on the Energy Model of the device
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
  * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
-- 
2.39.5


