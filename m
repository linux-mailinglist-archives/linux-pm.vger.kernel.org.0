Return-Path: <linux-pm+bounces-11782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D5943EA5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 03:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A19B2C1BD
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 01:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233721D0DD8;
	Thu,  1 Aug 2024 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU0mzxxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24061D0DD2;
	Thu,  1 Aug 2024 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472211; cv=none; b=aSzF8VxXacjo3jJT99ggm2VZpWMZx/1gnEaWqKczxlSql49Oy/SwGL8fidALoDO0CitZlEt+ZAGx7Js3nbpAajkLSwcoJ6SupcAW59mrVMcq8DxfTgojcWqf6aMFu6EXKmjEoVaTjrMiTVMqqoJonq777384z2gNDzLmpx/0AcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472211; c=relaxed/simple;
	bh=odM96JhS4fDeDEnXY4eab7LZPhFYf/3AFpfz4YJLqgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgcEmzx0Sd1WajqTvoeImU8LcV6obKUujic3xuz49B7YnXDCre+ttXuVJC4UxhhB4ziBJmNzGbASS6oDqSjNoa5JtKS+fz/0aNr3XF4n9z0RgvKymz11NTN43b1smhOmg8YS/iu8BMU1y3IUpuLGYjz0sUtDzmhJPWmK9QB+CzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU0mzxxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350AC116B1;
	Thu,  1 Aug 2024 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472210;
	bh=odM96JhS4fDeDEnXY4eab7LZPhFYf/3AFpfz4YJLqgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WU0mzxxjYQLCnpkvrGXhzXlOygngo3btVYlBbB5y7CwvFQcGfynPBbc8XXYdD/Y7G
	 Yom9TfjFPlGLYY0m7kvpU3h1jgWDLBQ0bKAIwaZ3KznMy/u9hLH6kdXXkOOMv8Tv2s
	 UPhBevNkcLaWEbmW6WavWDhm892yN6ozlsNBZ1Hwxj80puNkpvzdlxFw+xaQq5e33n
	 4LiD6vB11/hycvKvCEVsfdbPor/3SJnKS1wGcPdNWSjtA98xWmsKTKJEfc3ZKa6qj9
	 1K/FR8nft9ER6stdh0TXZTlLT4NH9/JI9aty5ZrjwwTqOci3IxpdPMPK3Jda5BsPGe
	 iE2gF+oYuP/ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jagadeesh Kona <quic_jkona@quicinc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 28/61] cpufreq: scmi: Avoid overflow of target_freq in fast switch
Date: Wed, 31 Jul 2024 20:25:46 -0400
Message-ID: <20240801002803.3935985-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Jagadeesh Kona <quic_jkona@quicinc.com>

[ Upstream commit 074cffb5020ddcaa5fafcc55655e5da6ebe8c831 ]

Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
can lead to overflow if the multiplied result is greater than
UINT_MAX, since type of target_freq is unsigned int. Avoid this
overflow by assigning target_freq to unsigned long variable for
converting it to HZ.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 028df8a5f537a..079940c69ee0b 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -62,9 +62,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
+	unsigned long freq = target_freq;
 
-	if (!perf_ops->freq_set(ph, priv->domain_id,
-				target_freq * 1000, true))
+	if (!perf_ops->freq_set(ph, priv->domain_id, freq * 1000, true))
 		return target_freq;
 
 	return 0;
-- 
2.43.0


