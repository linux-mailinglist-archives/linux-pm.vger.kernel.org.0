Return-Path: <linux-pm+bounces-19832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75D9FE254
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 04:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792BC16111A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 03:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAB150997;
	Mon, 30 Dec 2024 03:58:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7410E4;
	Mon, 30 Dec 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735531116; cv=none; b=rdKYDg8g+760NEc9UvI+pxyDSKRYBydkpKMXR5N9+M0aruFUugGDqM7T0qDWFWDRYhvEJHVi6gdsy+TCFePEeaiFbGDtyWI2OVgmjDhrZ24LKoHjvVRL0tdtVZGp9QtrXpOM3BDgnCCI6CR1b/Y7wVlKajP1jc6KQ06ZYSUWKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735531116; c=relaxed/simple;
	bh=GEyIvQMZZpldBb9kZGCvP5HAELRdsCF//jpJS1KQQbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ioSl4P7YoYiY1sebPYy6UzpLyfHwfREkK0bDqKEGcETIe4GpSiEOZq7zoEYG6hBllLmWYlMn4eionkvTvbwGT5IRf7beg6sZvCM6ejE0895VrXb+ZMxHc2mMovF8P0TH4YqVd8bZKV56e6/N3eo2n1LkV5kCxErTcbQ9+Hzn+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id AFJ00117;
        Mon, 30 Dec 2024 11:57:17 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 11:57:18 +0800
Received: from localhost.localdomain (10.94.16.130) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 11:57:17 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>, <maz@kernel.org>
CC: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] cpufreq: apple-soc: Fix possible null-ptr-deref for cpufreq_cpu_get_raw()
Date: Mon, 30 Dec 2024 11:57:14 +0800
Message-ID: <20241230035714.72780-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 20241230115717440586d573f96243b0e71ad65467fa0e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

cpufreq_cpu_get_raw() may return NULL if the cpu is not in
policy->cpus cpu mask and it will cause null pointer dereference.
But this returned value in apple_soc_cpufreq_get_rate() is not
checked. Add NULL check in apple_soc_cpufreq_get_rate(), to handle
kernel NULL pointer dereference error.

Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 4dcacab9b4bf..1c6d81355b41 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -104,6 +104,9 @@ static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
 static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
 	struct apple_cpu_priv *priv = policy->driver_data;
 	struct cpufreq_frequency_table *p;
 	unsigned int pstate;
-- 
2.31.1


