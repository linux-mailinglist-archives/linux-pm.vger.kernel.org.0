Return-Path: <linux-pm+bounces-7860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACA8C5F14
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 04:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77BE5B20AF7
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9EE63B9;
	Wed, 15 May 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gw6+lAKB"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF811109
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715739695; cv=none; b=SSdAQbG39eFGRYK0D0avKOfnpYghBvoU1L++Rgpn6W7WRpZERXPKvbzz4C3TYuslNCSa0FWGzVyTZgtm5scabYdPJagy/2suOImqgjP0+dGPZxb99vw2IznKOw3v6L/2fJ8Bv/GvbsW+dwv7ISwhutYcJYVAct2k+oXOZ/XhqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715739695; c=relaxed/simple;
	bh=AjxHnV7HYdFlYeZNOEGBsxVDWucGAfW7ZZdV1ASlGno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EnQv83PWYQqS/D3r8maZ7sx5gJtq4Vn2OLIuqyda4kyQyBigxEoiUW8Q5oB+bPm1wEdsvW9ky79XJ85eh0B6JDfRQSBYR1msYLe79f7xkoZ1j+K+ADvM3/b5wEG8vwX/wutL+1lT5qvFInn8z4GccAsLObGD/GuWPXNf1dSC1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gw6+lAKB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IiE2O
	zrfZe0qxduYtVgYZZK0g136LDbyJB501dPI6C4=; b=Gw6+lAKBUQ7dwgldUJ8yR
	Bk/T4Kxz1XxV5DFPT7l+61zuRS86QbN4PqWrHw6J3X6Ls3qgfqYKgQUTWod7MLpH
	13/N4O1jh/TyjtxP2B7Y3QhGESuXhd+4v8zcPrBmyWEdBD1+Eg0gjwSHkfVYR1BY
	Rr/Vp13JURLhxKqOjmPtWk=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDnTyb4G0Rmsz5MAA--.12297S2;
	Wed, 15 May 2024 10:20:40 +0800 (CST)
From: chizhiling@163.com
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] cpufreq: add a check for unsupported CPU frequencies
Date: Wed, 15 May 2024 10:20:37 +0800
Message-Id: <20240515022037.818078-1-chizhiling@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTyb4G0Rmsz5MAA--.12297S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy8Gr43JFWkGF1DXF1kZrb_yoW8uryrpF
	4F9FZFkrWrXa1DZw47Ww1jg3W5C3ZrZ347Gr90gr9Yy3sxAFyFga45KF17J34F9rs5Cayf
	Zrn8ta1Iqr4UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1D7-UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBZhjfnWV4HPa8DgAAs5

From: Chi Zhiling <chizhiling@kylinos.cn>

When user wants to control the CPU frequency on their own,
if they write an unsupported frequency to the
scaling_min_freq/scaling_max_freq node, the execution will not report an
error, which will make the user think that the execution is successful.

So, this patch add a check to return an error if an unsupported frequency
is written.

Testing:
CPU supported frequency [min, max] = [800000, 4600000]

before patch:
root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
root:

after patch:
root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
-bash: echo: Invalid argument
root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
-bash: echo: Invalid argument
root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
-bash: echo: Invalid argument
root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
-bash: echo: Invalid argument
root:

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 drivers/cpufreq/freq_table.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 10e80d912b8d..416826d582a4 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -76,6 +76,11 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
 	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n",
 					policy->min, policy->max, policy->cpu);
 
+	if (policy->min > policy->max ||
+	    policy->max > policy->cpuinfo.max_freq ||
+	    policy->min < policy->cpuinfo.min_freq)
+		return -EINVAL;
+
 	cpufreq_verify_within_cpu_limits(policy);
 
 	cpufreq_for_each_valid_entry(pos, table) {
-- 
2.27.0


