Return-Path: <linux-pm+bounces-6114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1589DC14
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 16:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B66282FB2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAC12FB2A;
	Tue,  9 Apr 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pcoVXCGB"
X-Original-To: linux-pm@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10112F5BD;
	Tue,  9 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672421; cv=none; b=q7TXrfyGc3wG4mWGpI43KOuCotPosDyvYHd1eL0HOKbK4oxAcp4SS0TVqi92gEbpQkJm/bIgUlWU7BVlYfM4dE67oE0QbL+Kr/NRRoDXTB3O5kjwTe1FPKFzNpPj6T9Hc3z5Sebz/fX2w7dPDaznYyIMkkuBQfUs6u8dwYDYKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672421; c=relaxed/simple;
	bh=eR8mjObwrnxacavEWLjfNBi8mwmRrdwSFLbY2h+f4BA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pud5QLJ7eAiVpOsdwjpY9uGEYrayP5rRE3jc4VrdCn7ayhc5asFNAxBFDaDAMnQnX5HXtbpJFEAysE7FJQeKC8bjWsGKE1+ZeAnslwIkttwTnLwZ6geJe/jaBzaZeThO4GfPF0/xTRIbZrZ72NnQJSmNWRu0kPQKdFtXuoyCznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pcoVXCGB; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KCt6W
	vX38grmIkpZ6PL0d3x3MonnLIxac4chg0TbkU0=; b=pcoVXCGBcf3ls8oM/5EwT
	uSID642AiI/E7VjA1lR/aiVBBSfxTlGdc/k7jd4YafZmEPPnHmVvWI+tF9uSNkRd
	uCP5a8CITybzK097P8sS82+twb0JF/fJTAJYNj+vNKPhtgktDeNNNTl5e6O03F/b
	+tJiSf6mCAoVIGjELc9TLM=
Received: from localhost.localdomain (unknown [101.86.11.106])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDndzFkThVmu5ZqAg--.477S4;
	Tue, 09 Apr 2024 22:19:45 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	axun.yang@flygoat.com
Cc: linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] cpufreq: Remove redundant exit() functions
Date: Tue,  9 Apr 2024 07:19:09 -0700
Message-Id: <20240409141909.4413-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDndzFkThVmu5ZqAg--.477S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1UCF1UKw13XF1xtrW8Zwb_yoW8CrW3pF
	W3ZrWUur1rJFWqq3Zru3ykW3W5u3ZFyFyDGFW7GwnYvF13AF15W3WUKFyUZrZ5CrykGFsI
	vF1kXay7GF48JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRI38UUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSAe7q2XAk0aYWwABst

The return value of exit() is 0 and it performs no action.
This function can be omitted. Please refer to the end condition
check in the __cpufreq_offline() function.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/cpufreq/cpufreq-nforce2.c   | 6 ------
 drivers/cpufreq/loongson2_cpufreq.c | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index f7a7bcf6f52e..fedad1081973 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -359,11 +359,6 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int nforce2_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver nforce2_driver = {
 	.name = "nforce2",
 	.flags = CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
@@ -371,7 +366,6 @@ static struct cpufreq_driver nforce2_driver = {
 	.target = nforce2_target,
 	.get = nforce2_get,
 	.init = nforce2_cpu_init,
-	.exit = nforce2_cpu_exit,
 };
 
 #ifdef MODULE
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index afc59b292153..6a8e97896d38 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -85,18 +85,12 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.name = "loongson2",
 	.init = loongson2_cpufreq_cpu_init,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = loongson2_cpufreq_target,
 	.get = cpufreq_generic_get,
-	.exit = loongson2_cpufreq_exit,
 	.attr = cpufreq_generic_attr,
 };
 
-- 
2.25.1


