Return-Path: <linux-pm+bounces-19840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D09FE49F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 10:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B0A3A2623
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000581A76AE;
	Mon, 30 Dec 2024 09:11:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCA1A8407;
	Mon, 30 Dec 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549878; cv=none; b=RHrnevrX9Xl/sWkobbtTZbpmvgP9Ypkx+KtNQZCCjZgGS779hqugniShIhiJUaUGe+EuWvpjxfv0KagHFQGvVqWm4MbFOfk6xOnhZNsS8tzIgjLzHrldhxkQjzor36Q4eA+KqB+ZIi5Nv8hJQkSL3HoSOXmvP9k+HZv9BIpY93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549878; c=relaxed/simple;
	bh=y4L8hO4mSubGVwG8jhpI9T9WWPRMAmZNvO/5c32N2FM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BGcdj7zA4uEdKRMkjxJLuAxeBOBFbpJgSLaFm5fCd4RDTpbGy/6dCrTm8qEAiAFV4skbvpbYPrZjcqvtwe5muHcbKSsjSs/49fvqe5dxvr8cgKyZw+z0Hsf5omkvSkFil2jNUdwaqrehvSHFW3m5/goTXi4g2xmnkDXpwLGwMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id BNQ00011;
        Mon, 30 Dec 2024 17:11:11 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 17:11:10 +0800
Received: from localhost.localdomain (10.94.16.130) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 17:11:08 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>, <maz@kernel.org>,
	<Markus.Elfring@web.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH  v2] cpufreq: apple-soc: Prevent null pointer dereference in apple_soc_cpufreq_get_rate()
Date: Mon, 30 Dec 2024 17:10:53 +0800
Message-ID: <20241230091053.247719-1-hanchunchao@inspur.com>
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
tUid: 202412301711117422a1f991e589291e20510d2f3b4f04
X-CorpSPAM-Fhash: Yes
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

cpufreq_cpu_get_raw() may return NULL if the cpu is not in
policy->cpus cpu mask and it will cause null pointer dereference.
Prevent null pointer dereference in apple_soc_cpufreq_get_rate().

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


