Return-Path: <linux-pm+bounces-11781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051E943D39
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 02:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C31F21710
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73D16DEC3;
	Thu,  1 Aug 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH1NQDUy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC916DEA5;
	Thu,  1 Aug 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471852; cv=none; b=S5Tw8tavN1UKMDH81WcUv4bvpXs2M9SBWOoUGVyQ0ejFa7bEZb2o//OaRYA9oOCMwTm9BpTnsBexWdcYMxbkRNUF8bp8W7X9g5Gj/M0FcyUdQNezaFjUM7LW5qskJ3lt34SyrTub+Dtojlmf5yDEiwS3nmc8tuE9M7dg25ejxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471852; c=relaxed/simple;
	bh=odM96JhS4fDeDEnXY4eab7LZPhFYf/3AFpfz4YJLqgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxz0HU1+O2rblFvWiNJlG7P8QabPWGPPn8J+IPd60WEaic13k9xPILcBZiPXFjpVnMoFrurdiZi6fbIllop8Q16BeBk9J5k5HYaQ7G+3AVWyxw4TnCv+sfX53wAwsKg9jxUqgbpQmNOQK1wNvehVkMyjywZCprcGk3g53Uotfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH1NQDUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBFFC4AF0C;
	Thu,  1 Aug 2024 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471852;
	bh=odM96JhS4fDeDEnXY4eab7LZPhFYf/3AFpfz4YJLqgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rH1NQDUyMZizV0Z4+YgBTX8xe6/RDLwHQTNiKYdxavICwS1wBmlMU4IM8h1OoTAxu
	 Qd/BK084hsfhKn7qKm6JgiOfMLpFE7TOzlvFvDrur0Q4lFQd0I8MVkq8nbYQB1JoHj
	 Cpcb6+Mba8Rf4MZSdm0/0FeWh+4Yee0BYDcCb85mZjKZpwJ8mcI8wiNN+9lx7U6kzG
	 vbCNr9l+h3LrrUcBojMvwTXt49H4EZtQoaPByvUwf1AyfDgsSZeLmvGX0R5XSiRINS
	 Y8oojPbBgSYz5yzfhJ4LybR2QkhFUZ/kowP2kmPi82Jw8Xnertw+pALUf2oNLzIwPk
	 N4UdePCALncOg==
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
Subject: [PATCH AUTOSEL 6.6 37/83] cpufreq: scmi: Avoid overflow of target_freq in fast switch
Date: Wed, 31 Jul 2024 20:17:52 -0400
Message-ID: <20240801002107.3934037-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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


