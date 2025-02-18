Return-Path: <linux-pm+bounces-22350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496BA3A8F7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 21:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8401897666
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A51DF97F;
	Tue, 18 Feb 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqUIPo/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65B1DF968;
	Tue, 18 Feb 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910335; cv=none; b=T+rju0c7tToN88nLWjSprv7SZJcOIbU0wC2rKaulTC5V1bxYr4WvROOwcCrZQMM3p1wuIopdrUVqqSGA395IoFC4GUFZu2adqKv6KPlmTOhP/lrmNZqmzZVzVwUnWKu1+GE325JiSMnloP0i6vyLc0lYPTD4T79kKlCRaj+RoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910335; c=relaxed/simple;
	bh=mKMJDW6nakEGmrz4QiQyiO3fhORm4+3vCRoK1DdyepQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGLUojxWnqKTh+xjIHkC3zgEAvdHmN2JAtfKWw+33Fui6I80RbD3hWFZEH/PZUeiHC29iqcbFtk3uQcx8iUHyJBk7DCdWDS5IhIme+Wx0rYONNzkVAcW7Ur3tMcwyZpO0ZKTBBpidrDd60erK2VgFNkD55GZCl70Yk1JFmFpkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqUIPo/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10772C4CEE4;
	Tue, 18 Feb 2025 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910335;
	bh=mKMJDW6nakEGmrz4QiQyiO3fhORm4+3vCRoK1DdyepQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqUIPo/WjSHPq83ftLmqD4Xl/MdQurKXWVE529tu5t1/QeBFMHC/KqPdM4FEeogm4
	 ncM8KA8E99B5MvAe0QO7F+2pdoxtOHwqOUmcmY2OYd/3eIiT6gdgHr1yxdrMqBQ5Pn
	 6gyTNi6FFAKLsrqLeZQnDP7JaNfD0KfZwI1MXzoBiDZcEzPisHkrFjzx+apXbaZqrT
	 zg8ffhLGeSF+c0jLblFDhbXrCe/IZ+0cBa6FPQkbZfwhGXo1svCbvNic9lnzuK8x84
	 elrbfbw2t+WYikW4tpZ7AQBkNk8OvN+R1J8fhQMEY8ROU4+JdrweOrm9MdKeED+Hif
	 yQdSgTmuQ0rZQ==
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
Subject: [PATCH AUTOSEL 6.13 20/31] thermal/cpufreq_cooling: Remove structure member documentation
Date: Tue, 18 Feb 2025 15:24:40 -0500
Message-Id: <20250218202455.3592096-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
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


