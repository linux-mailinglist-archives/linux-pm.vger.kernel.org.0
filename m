Return-Path: <linux-pm+bounces-15910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3CC9A3041
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 00:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64451F235C8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238341D5ADA;
	Thu, 17 Oct 2024 22:00:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA631D54E9;
	Thu, 17 Oct 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202443; cv=none; b=CRkeVelkdHUaxFyiIMRxrf7zMSUQS9A5hoM4Vm3gY2SXFfGe41w5HFErVF3du/2BonCsQa64XyYjD5nhov9J08yURL1zOmnKJKpxDPP3hAd4Peimao6jLE7nnLO3aFTDGKQSW/2MpKqWP79EoYxYv1L8jXNppx49a0GTwxlQGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202443; c=relaxed/simple;
	bh=/D3cAtxwwBDlyTGCeFoGVi0eLVxzYY9k+S5c5thfVs8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iOWntM2F9pcFURarJvI5jyz/6hiWWCtMdZUxZQpUQ709AWPhNaF6OaTd+6alqHcg520bfFjSMTe7X3TgOGQqg1W5FvoEPOmLYeT+dyxoXppC1meLDJI2flhiweFafkiNDXR2S0EqXg2efue5bUTdG5Dm6neJhpfTx7VCU5tD+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BD1FFEC;
	Thu, 17 Oct 2024 15:01:06 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728083F58B;
	Thu, 17 Oct 2024 15:00:35 -0700 (PDT)
Message-ID: <46853b6e-bad5-4ace-9b23-ff157f234ae3@arm.com>
Date: Thu, 17 Oct 2024 23:00:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>, Viresh Kumar
 <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpufreq: docs: Reflect latency changes in docs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There were two changes related to transition latency recently.
Namely commit e13aa799c2a6 ("cpufreq: Change default transition delay
to 2ms") and
commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER").

Both changed the defaults / maximums so let the documentation
reflect that.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index fe1be4ad88cb..a21369eba034 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -425,8 +425,8 @@ This governor exposes only one tunable:
 
 ``rate_limit_us``
 	Minimum time (in microseconds) that has to pass between two consecutive
-	runs of governor computations (default: 1000 times the scaling driver's
-	transition latency).
+	runs of governor computations (default: 1.5 times the scaling driver's
+	transition latency or the maximum 2ms).
 
 	The purpose of this tunable is to reduce the scheduler context overhead
 	of the governor which might be excessive without it.
@@ -474,17 +474,17 @@ This governor exposes the following tunables:
 	This is how often the governor's worker routine should run, in
 	microseconds.
 
-	Typically, it is set to values of the order of 10000 (10 ms).  Its
-	default value is equal to the value of ``cpuinfo_transition_latency``
-	for each policy this governor is attached to (but since the unit here
-	is greater by 1000, this means that the time represented by
-	``sampling_rate`` is 1000 times greater than the transition latency by
-	default).
+	Typically, it is set to values of the order of 2000 (2 ms).  Its
+	default value is to add a 50% breathing room
+	to ``cpuinfo_transition_latency`` on each policy this governor is
+	attached to. The minimum is typically the length of two scheduler
+	ticks.
 
 	If this tunable is per-policy, the following shell command sets the time
-	represented by it to be 750 times as high as the transition latency::
+	represented by it to be 1.5 times as high as the transition latency
+	(the default)::
 
-	# echo `$(($(cat cpuinfo_transition_latency) * 750 / 1000)) > ondemand/sampling_rate
+	# echo `$(($(cat cpuinfo_transition_latency) * 3 / 2)) > ondemand/sampling_rate
 
 ``up_threshold``
 	If the estimated CPU load is above this value (in percent), the governor
-- 
2.34.1

