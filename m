Return-Path: <linux-pm+bounces-40984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58007D2F055
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3710330A565D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65642357A53;
	Fri, 16 Jan 2026 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="omxnjfzb"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582A35CBAE;
	Fri, 16 Jan 2026 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556799; cv=none; b=gOuTdfqZd6OPH6nVx7lHJPwUb2FwReYpvb6SJF7rVEoe34I6CytcgxpNGk6ruCfi4osZ3wOSt9uuS+fPz6QwWmOpUF18WQdkg7WDFNuR9yl11sdrtj2G23J3z6uow4Qf6S3q451ZPmxr05vi3nJ4+9KKoiljdocKk5NmeMnR+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556799; c=relaxed/simple;
	bh=6ghuYPI3X6k/G+olCwv7nNRzsVOHvzX533Yp3Hx3x6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HivksK3+GhK1vO/EOk/7J+t/8Np9yrXdmfYxGagVI4hoe8LdVBj52UblL+nfkFkMnpSXTEX1MLKYM+ZtXVPNAMsCJ1iLLRzBktyPpzTdK2kcuqYSfvQzIgDRMJq77n/xe8cQUtk13uNJxkG0pUdWUb0YWhI+hn+echjeZ+eKF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=omxnjfzb; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hx8JasnlJm5xvdHPOh4mSapH3tZSpBHiupOgHJ02sJc=;
	b=omxnjfzbMrPXk3TYkp3yyhq0p+CJ2QI26niPUZwhCSL8bu16RZ2ssfVKgenD6/IwzQz3LD+9D
	a/RKhC30Iti2Q5K6rbTZic89BOwuRxSJGWM8RYYp4ObQIeRHYSsPQpZ7YILiY7aKrLK/YoHX1mD
	cV4tBMDHJ2Swg+U6ikhlpQg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dsvzx0mQ6z12LGG;
	Fri, 16 Jan 2026 17:43:25 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A0CC201E9;
	Fri, 16 Jan 2026 17:46:24 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Jan
 2026 17:46:23 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [RFC PATCH] cpufreq: userspace: make scaling_setspeed return the actual requested frequency
Date: Fri, 16 Jan 2026 17:46:23 +0800
Message-ID: <20260116094623.2980031-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr200004.china.huawei.com (7.202.195.241)

According to the Linux kernel ABI documentation for 'scaling_setspeed':
  "It returns the last frequency requested by the governor (in kHz) or
   can be written to in order to set a new frequency for the policy."

However, the current implementation of show_speed() returns 'policy->cur'.
'policy->cur' represents the frequency after the driver has
resolved the request against the hardware frequency table and applied
policy limits (min/max).

This creates a discrepancy between the documentation/user expectation and
the actual code behavior. For instance:

1. User writes a value to 'scaling_setspeed' that is not in the OPP table
   (e.g., user asks for A, driver rounds it to B).
2. User reads 'scaling_setspeed'.
3. Code returns B ('policy->cur').
4. User expects A (the "frequency requested"), but gets B.

This patch changes show_speed() to return 'userspace->setspeed', which
stores the actual value last requested by the user. This restores the
read/write symmetry of the attribute and aligns the code with the ABI
description.

The effective frequency can still be observed via 'scaling_cur_freq' or
'cpuinfo_cur_freq', preserving the distinction between "what was
requested" (setspeed) and "what is effective" (cur_freq).

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/cpufreq/cpufreq_userspace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 77d62152cd38..4bd62e6c5c51 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -49,7 +49,9 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
 
 static ssize_t show_speed(struct cpufreq_policy *policy, char *buf)
 {
-	return sprintf(buf, "%u\n", policy->cur);
+	struct userspace_policy *userspace = policy->governor_data;
+
+	return sprintf(buf, "%u\n", userspace->setspeed);
 }
 
 static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
-- 
2.33.0


