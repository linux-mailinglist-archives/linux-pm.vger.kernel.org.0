Return-Path: <linux-pm+bounces-19837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8619FE401
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 10:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693881881642
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E91A238A;
	Mon, 30 Dec 2024 09:02:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68B1A0BFE;
	Mon, 30 Dec 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549379; cv=none; b=Us0vkBpp6h563CyYok0wWD+HrwRWJdk9gg5HH/kqRSWVISYVce9A9A8mg//MtryBZ0+oYpoAtAVZ4JhZq6LpO2YTWhSA8oJJdus6W1lJECOnl7re6DaueJye6mVGIY1IX53Vpooa6JDbElbE8zYQ5MNIP0A+t0Z786x6wr97F88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549379; c=relaxed/simple;
	bh=y4L8hO4mSubGVwG8jhpI9T9WWPRMAmZNvO/5c32N2FM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NcUL+QTqnTfvbwV3LEDZcu2JxTnDkAuDhGxT9W34WkbGEhiErbQK1ZaGRPwPZqnRR9utcxvr5nYmGtOqErpEkqr6Kp81KJKnLyNMyBJSz5/eXSzc3XNNnjFnw6Zu3CQgTuT/XFacl84znD0x0qiByKT8L+4IQ7SlHRM0fx1ORYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id BNG00142;
        Mon, 30 Dec 2024 17:01:42 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 17:01:41 +0800
Received: from localhost.localdomain (10.94.16.130) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 17:01:40 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
	<afael@kernel.org>, <viresh.kumar@linaro.org>, <maz@kernel.org>,
	<Markus.Elfring@web.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH  v2] cpufreq: apple-soc: Prevent null pointer dereference in apple_soc_cpufreq_get_rate()
Date: Mon, 30 Dec 2024 17:01:37 +0800
Message-ID: <20241230090137.243825-1-hanchunchao@inspur.com>
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
tUid: 20241230170142493d58637f608581f9d59fb39e6fbd50
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


