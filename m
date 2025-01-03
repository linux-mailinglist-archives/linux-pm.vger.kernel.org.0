Return-Path: <linux-pm+bounces-19923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E154BA0052C
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CAF7A1A4F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5FD1C1F10;
	Fri,  3 Jan 2025 07:41:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5E157A67;
	Fri,  3 Jan 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890113; cv=none; b=HCHnBqq95MdMUEw4bYx3+Hd9fBhsP+ab9FjjsfhIXv8693m88os1YTympd48eM7ZY2tgo41CbAEJVNIFBK7YAJGRTuf4+Nv8GeueT0WBxAXFg58rikgIBkl4b7GsVYavX6iHs0qJL6fhcmQHUO7wYsh3YraKVJpo51/b2tO7kEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890113; c=relaxed/simple;
	bh=6vwTd2R+7iSSUMxwqyFL42SlVO4CegWJ+wsYnxeVTRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mcQV5MfVHIPmXUPMhAHo40fWpr/c5nxY7lsrD5/RQSckyV5DMN0DFa72n+LOGi3sarE6q85Gp3EOLpkbHNt7WZKrBVvRrn711875FOzRfnquHV0LvTVW4wsyVmI48J3muKF71vHOQS/C00jxHVW5uvWacT3v81SFC1VYU+dBJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YPbBM3jpfz20nG8;
	Fri,  3 Jan 2025 15:42:03 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id CB3001A016C;
	Fri,  3 Jan 2025 15:41:41 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Jan 2025 15:41:41 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix per-policy boost flag incorrect when fail
Date: Fri, 3 Jan 2025 15:41:39 +0800
Message-ID: <20250103074139.1080092-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
boost state") sets per-policy boost flag to false when boost fail.
However, this boost flag will be set to reverse value in
store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
will cause the per-policy boost flag set to true when fail to set boost.
Remove the extra assignment in amd_pstate_set_boost() and keep all
operations on per-policy boost flag outside of set_boost() to fix this
problem.

Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66e5dfc711c0..4ce923788f3a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -730,7 +730,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	mutex_lock(&amd_pstate_driver_lock);
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
-	policy->boost_enabled = !ret ? state : false;
 	refresh_frequency_limits(policy);
 	mutex_unlock(&amd_pstate_driver_lock);
 
-- 
2.33.0


