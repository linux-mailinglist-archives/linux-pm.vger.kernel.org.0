Return-Path: <linux-pm+bounces-11783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD33C943EB5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 03:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5721F22847
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 01:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB03C1BC9EE;
	Thu,  1 Aug 2024 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqGrvh3O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652F1BC9E6;
	Thu,  1 Aug 2024 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472482; cv=none; b=hXkbEIJj7TO1GKgDGKYCTuJe7iORSrDrAGmSmomYOPdEOAyvapjcAUL9tgODKBVkFnl+z3/M4fwVr+mGRddLf5uCLsg7p+1KS9HKKs5JCc52ar15o2mx+IK8QjdgBhi/dT14kjbs/VXoW9Yx7y4ZtmwLgT44WABEYwgUCEWnYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472482; c=relaxed/simple;
	bh=yZ3UY4/gDa7REF4ZddaQg0d7YWsZBbr+sWxa2cYFNhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSg1EKpC9eOqgVMX8GJQjTl+m5OpCtZ/RiAZGW7yEMkWYhUJg7YTdJIl1fMBDoUt5YzBH1kRraiaL/DDa59J5lYptknmiVhCtJ5MY2sV25c0667KXXbLY0/o9WShbrQfMIYlRTIhARLt1hbIZgm385hCsqDjN33o9DZaC5Kz/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqGrvh3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE26C4AF0C;
	Thu,  1 Aug 2024 00:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472482;
	bh=yZ3UY4/gDa7REF4ZddaQg0d7YWsZBbr+sWxa2cYFNhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqGrvh3OFRPQ1jqawx0rM1LZVuNm9+7otw1pPAIDjbxISTp5qm6o5X0aDWzCUst6e
	 eH0eo4yJS72loxmvoy2q6Wrv4n6gCVLa9nArZS/fjJB7A5wcIXa+12goJwVMUm7tkv
	 NeqQyziZTugx7VGJl3QfZ4Sujr4s2d4mxmZU57kFvSoGABY8vbs9r0rIE4IhPbWXPI
	 cK6pFi49mgino6yLDGtwrf/dFpA6NIlB/NaJicZ7dmpj9xKfEXu4OG9Bac8QQcDn9N
	 p+bpo0B7LdAL2qqG98XffvXIOyW1sqt135oych//AQC34vOKPM9+TxsG1tgbtGvPVq
	 5sjFJe91i/l7g==
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
Subject: [PATCH AUTOSEL 5.15 23/47] cpufreq: scmi: Avoid overflow of target_freq in fast switch
Date: Wed, 31 Jul 2024 20:31:13 -0400
Message-ID: <20240801003256.3937416-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index c24e6373d3417..eb3f1952f9864 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -61,9 +61,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
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


