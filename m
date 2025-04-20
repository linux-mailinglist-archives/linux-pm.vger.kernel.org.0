Return-Path: <linux-pm+bounces-25758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE0A9499E
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE22A189100D
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D01D86E8;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leb5+tje"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D981D5ADE;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745181743; cv=none; b=NCRAEJzFUfdDGfU6mVlWfOxHEYAKmZ7CDosGmP4C92N24ftE79RolDMhXtmawJ9MFmxivN6xHSQnPzsBcHXvq1Ls5a0/uWJqm+D6H9hZTFg8GPS+yHVmCHiCyN+CPNLo0sUmoqKZHFE7Pg5ve/SGzWARY8w8ID4EiLrBxX0jdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745181743; c=relaxed/simple;
	bh=jxXLdAriBCeGyIuvDWxDfzGlSo6MZaMMh/ec+5W+3ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2JEfJFpETtMMJLXoSsE4x14IwXaxwdc7qytIsyBcW76LCFKt3kPcPWPzNMHFeXQh5osXoE3b2gslBYAR/EvB6vD5DYqdJEwIZlVtOU/v0uZwVK1OvPwY61jUD405wy94xY4pHEhYR6Yd/8T8ddkpX+63bzMzfyh0iSSSIueZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leb5+tje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38F62C4CEED;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745181743;
	bh=jxXLdAriBCeGyIuvDWxDfzGlSo6MZaMMh/ec+5W+3ic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=leb5+tjef2gDsIFRKJ8e/q9WwHHLQIB0JIXV71Em+HVVw68JR1fnVun9pO3ZD0nO6
	 gh0Hu66d9tLF2AJmhCvn5U2CULla8tIDcBiYVCNi+DOZxI7wDRdVlqe/rzffGj9vNT
	 1zCZgHnnHGMByRGV8GEOSDcnnO5GOaTNqEz4nGFYeg8kp8h7wG0UVCgsplX8dVo9Jk
	 lwhQ3EVOGBKRNiwp1YTXmTCiygYRpaM8K7v4RDZpAt4XtjsflreFfOMnhAKE9+WG5a
	 46uR+Nc8kilfZ1Q2u8ivmdVOwbxDAEVV4g0+G8psRyLLNKmO/8C8XIPoV+ioNJUN23
	 QI+ItkteS7Jkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29010C369D2;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Apr 2025 15:42:00 -0500
Subject: [PATCH 1/2] cpufreq: Export disable_cpufreq()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-tegra124-cpufreq-v1-1-0a47fe126091@gmail.com>
References: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
In-Reply-To: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745181742; l=614;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=lPtQ3+EArJBMl5gBrzCQeGZ6Aeo+U8TlBMXfq1u6eL8=;
 b=0yPG4YbW08dCVz3jh6d1950YItYdKNcKvxxXgmaTYIL9mKSmVgfTmOFJvS6eGqriBkX2vf72w
 9zJU+U1/Uj2CjCDxApISiNM4FLGPZHxd3GUgPl21eGnL2uBD9PVtcTA
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This is used by the tegra124-cpufreq driver.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0cf5a320bb5e864709b259249fb1af8bfbc0b04b..78cddc78ee98630f99ccc332c64c94f437297177 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -109,6 +109,7 @@ void disable_cpufreq(void)
 {
 	off = 1;
 }
+EXPORT_SYMBOL_GPL(disable_cpufreq);
 static DEFINE_MUTEX(cpufreq_governor_mutex);
 
 bool have_governor_per_policy(void)

-- 
2.48.1



