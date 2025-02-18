Return-Path: <linux-pm+bounces-22352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F75A3A98E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 21:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514387A59D7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630E21B19E;
	Tue, 18 Feb 2025 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvx9Vb9+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15521A440;
	Tue, 18 Feb 2025 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910490; cv=none; b=olVguXS8wF+7ErNYkim/ev3ULsgk3N2zuqlLeG+L31l1jmBwYay+GW9NAF9/uaFWoreC1BnroJnr4XMUROd4H+p6cLlbUtdsqgILuJLNHW140GkHyHFtH2a1o4L51vSdc7361RCLcz9NEVCcNt+huP4H1axW46RjFmpHKt+ta2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910490; c=relaxed/simple;
	bh=QKrdvXReXi8KQD3WFcEkWnbwGaQsE1tvpjORmQTi0NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVVsVmnOG/vxSw/TC+90nIu45zN6KmKH2h75Zjo/UOOEq4T+gH6jYq2B/MgEg9PW1nDimn6JObsopf7er/brCAJpw7xcorGWtCEViGkqqCQbxMfPDsLXQUT1AzyDs93MlcogrwgNbpXyA//aaMBvD8qIGRN3/oR9Nya4nm8oVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvx9Vb9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E952C4CEE2;
	Tue, 18 Feb 2025 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910489;
	bh=QKrdvXReXi8KQD3WFcEkWnbwGaQsE1tvpjORmQTi0NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wvx9Vb9+hYppCkX3T/2bkzuAFohQQHBZfi3smJ3Xcv2wuXQe1PcQF/8FBAeRgUHd3
	 NLhIwxDYqq2uAD6VHg5g7IFSglQ/cSlylPHXMuYVdNDIDR71qhnZnDcGpyFpBNH9fh
	 SkCZfVSB1re9Uvap3WQ3yjiGS8oFqGcF8a3+/8Lv56Om7Gs6+BUEoKL5+91OA9GGau
	 deKy2pJAlriF+t22d2CmQHs6MzgSngJC6sPZOGYYF93sPw7o4LxcpZuFIZEA+6ss1J
	 JsfyfxMtVmzMLWKTMH2Zqin6XjGh26kFTcdcUElEao9IDyyOc8QWhzv6+rUF2cP4Jz
	 HA3wA/EbPb+OA==
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
Subject: [PATCH AUTOSEL 6.6 13/17] thermal/cpufreq_cooling: Remove structure member documentation
Date: Tue, 18 Feb 2025 15:27:37 -0500
Message-Id: <20250218202743.3593296-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202743.3593296-1-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.78
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
index e2cc7bd308620..874b4838d2c92 100644
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


