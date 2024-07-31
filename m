Return-Path: <linux-pm+bounces-11779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E417F943B68
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 02:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D00B2148B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 00:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C9184523;
	Thu,  1 Aug 2024 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMV+21Yy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8604183CC3;
	Thu,  1 Aug 2024 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471276; cv=none; b=igY0eHxAlfbfDq2Hvy6k/DzZfrUZw+70Llib4eh6nJitp+R0Ad+XsqKO3M5dviUuCSZappcMOa0XWAj0CaXSYwEMXxjmUWgE8Aj97rlfYAw0zdAbY4WCI2+4NDWU8h4gXevvv2a5GPBor5s4mOtwprRmmcrllldgPo3FQ616xYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471276; c=relaxed/simple;
	bh=c7h2qCNge6oqAZEQO/VOGmgfKeBOTAktulPHHQX7VNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0oLt0UiIlW3bPZNpT2YUcHGLyiBPMChF10d1iJ8qMeHq8B9F6s6l+OAR6M+Wx3f5FTrXMS3O1e43A0RphZJMaGVo6xwhItiVrRSI+DOWOaiIchcrN05/Wp0K3v4draQU1wBnK3Uh0zcHKW9pOQ41DhB7hRPBZhwLUahFWEc5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMV+21Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BAAC4AF16;
	Thu,  1 Aug 2024 00:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471275;
	bh=c7h2qCNge6oqAZEQO/VOGmgfKeBOTAktulPHHQX7VNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMV+21YytigUMG0jg9mQWTLIwpdQVc2LCNhp/Ssj323K4DHSQ0X9OIiq2pbgD76OK
	 0YWl1r+NNSjwOYza5tsL8DVySNp0zh7pRaWZ1nOEHUTi7J39mOO2p+7GruTjc47s19
	 eD6R8pJhy9BybbR93u2PW25N/dCxeAIvdztqtEy22hN394xKJA8RIG/0mZ3llBIYuv
	 YfRXdi3FO1CIb2LcTjgQOFTqJilNIJRnRxATO63k3n7uiqgDj7VnHCz/5ATkh6w/Hr
	 /nnDkxo7XLGBxAqU+6K1axdbxnNV5PECpzzM4HLwq2r1h4fI7rfOwXECucOvLj2APA
	 HU29plJzIumVA==
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
Subject: [PATCH AUTOSEL 6.10 054/121] cpufreq: scmi: Avoid overflow of target_freq in fast switch
Date: Wed, 31 Jul 2024 19:59:52 -0400
Message-ID: <20240801000834.3930818-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 3b4f6bfb2f4cf..b87fd127aa433 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -63,9 +63,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
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


