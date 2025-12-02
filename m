Return-Path: <linux-pm+bounces-39040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C4C9A6FF
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B065345E50
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8392FD7CA;
	Tue,  2 Dec 2025 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5Kbw7I/o"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6474594A;
	Tue,  2 Dec 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660466; cv=none; b=B3Ds1LJzGv6M2NrsQJ9Dh68Ey6LnOBMUFSZJqSycfIdgwY8g4PdLb4mQD/jAqsAMUWNVtH7Hm85jcVFmF+Mho0+X7PbVRTfyNmijUe9a73OHA1yuy8c0fzY/bGIei38M3Ylv6z71SGFzAVtMIh9w3jkhw5f3oaCcmFiMHtr5dbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660466; c=relaxed/simple;
	bh=dqBlbPYnjAyEeji9+CdiBcELowqR4ZF+jHhqZypZC/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuCUCGXcWosQs4bVZab/pVc8Yf1oK9FP8oJBtBY9LeVWsljBo3YzTjBmfcpUoG3TOfDuRBYJRX2kDLIDTr3aib6Es4bsP0PoVN5qhkqk19fsBueledP8GkphoMJRRiy88pStQQi/6LOP4t8tQJ2InClCgS6lUgOGj5PKZY45h0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5Kbw7I/o; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2GS7qtSDw+BZM96k6dIDy10qacv2ZcaeCUF7Nwq8GZE=;
	b=5Kbw7I/oOSpjPGPnxzLLQfmgluVCXcjkkYz5SMjx3c5KaEkI3ru389JPTOgM/20CioVP3FS+g
	GLs4bqwlSQWxVi8/+awXH8iSb3v4HQt8t4l6x9mGgCcr7I5VULTSnXburNj4w1U+K8f/VHsJQHC
	chf7gv8VCAlq80nXKD4Qr4I=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dLC3x2kMpzmV7L;
	Tue,  2 Dec 2025 15:25:49 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D794140143;
	Tue,  2 Dec 2025 15:27:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 15:27:40 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v3 1/2] cpufreq: Return -EOPNOTSUPP if no policy is boost supported
Date: Tue, 2 Dec 2025 15:27:26 +0800
Message-ID: <20251202072727.1368285-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
References: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)

In cpufreq_boost_trigger_state(), if all the policies are boost
unsupported, policy_set_boost() will not be called and this function will
return 0. But it is better to return an error to indicate that the platform
doesn't support boost.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e8d7544b77b8..a4399e5490da 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2806,7 +2806,7 @@ static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
 	unsigned long flags;
-	int ret = 0;
+	int ret = -EOPNOTSUPP;
 
 	/*
 	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
@@ -2826,6 +2826,10 @@ static int cpufreq_boost_trigger_state(int state)
 		if (ret)
 			goto err_reset_state;
 	}
+
+	if (ret)
+		goto err_reset_state;
+
 	cpus_read_unlock();
 
 	return 0;
-- 
2.33.0


