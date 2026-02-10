Return-Path: <linux-pm+bounces-42444-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA4FEfUci2nSPwAAu9opvQ
	(envelope-from <linux-pm+bounces-42444-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:56:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B911A75C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FAE4300BCA1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B46327798;
	Tue, 10 Feb 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IgiSaRlf"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBE326D4F;
	Tue, 10 Feb 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724590; cv=none; b=Mfy7hXUDGsRe6eOFw408cVqDTtl5q0TRaCtYJGKGUTPHwgTY45sWFkvn150aaoLrdnbKDOe07+TSis7zrwVOOe48GPvyJM4ok/5Er1eUy1cRGPwqLG2cgJJ0NVqFhzI+wlXePiJkYG0lG1B8KkKGTtx6wzW8PszAjyQRRsXAhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724590; c=relaxed/simple;
	bh=dgxy4so066YHaxUDv0l6pgU/XUbdPC8yZ24lQYqVoWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhA25p//8MJTN8h5hkYBLmvyvHT+cwzLu03+cm6lL74yiw48zLgTTg4OzrSLWxTySpxYzZoCRL3ITG+6sNsm1/EeGZLlwCOc0uXT6x/oBp4idwyCcTY7oaHR4DkbqKiLc53S9KdQnllsK96FiDKmMaKwr2G6OM7n63IO8LrdQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IgiSaRlf; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Dv6tqvwHIfldR6vZ4I9MU0ALFn0HJqjmyVFjqA6FX3Q=;
	b=IgiSaRlfsZWi788hQ4yjxYhP/TCZjaeqvYW+26YdLMNdrdWpxe5X3/2q1s5NR1pmjHFg5EFif
	ed/txnaKoc4B3hYa5SIO0Nrsd+NTaTPIXMSI6vLN4xYOliyvigB09VWE/PvGnwhU87ROjrGvnkW
	IlV2fW84sQ0+COYnFxOx6oM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f9KfT1PdNzcb0Q;
	Tue, 10 Feb 2026 19:51:45 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id CCD5940561;
	Tue, 10 Feb 2026 19:56:18 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Feb 2026 19:56:17 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq instead of policy->cur
Date: Tue, 10 Feb 2026 19:54:56 +0800
Message-ID: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42444-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: C71B911A75C
X-Rspamd-Action: no action

The motivation for this patchset cames from a test on our platform:

With conservative governor and some pressure on CPU, the frequency rapidly
reach the max supported frequency, such as 2GHz.

Later, some frequency division strategies on our platform were triggered
and the actual frequency become 500MHz -- 1/4 of the OS distribution
frequency.

At that time, if someone excecutes 'cat cpuinfo_cur_freq', the actual
frequency will become 250MHz -- 1/4 of the min supported frequency.

After the platform recovering from the frequency division, the frequency
will stay on 1GHz, until the pressure disappear.

The reason this happens is that in cpufreq_verify_current_freq(), if
policy->cur != new_freq, policy->update will be queued, which will
ultimately lead to a call to cpufreq_policy_apply_limits(), and update the
target frequency to policy->min. And then in cs_dbs_update(), since the
pressure never vanish, it will always hit the following branches:

	if (load > dbs_data->up_threshold) {
		dbs_info->down_skip = 0;

		/* if we are already at full speed then break out early */
		if (requested_freq == policy->max)
			goto out;

Therefore, the target frequency will always remain at the lowest frequency.

The branching conditions in cs_dbs_update() may not be strict enough, but
the root cause of this problem is that the target frequency was updated
when querying cpuinfo_cur_freq. For ondemand and schedutil governor,
although the frequency will not always remain at the lowest level without
rising, will still be min_freq in a short period of time when the query
action occurs.

Using the freq requested by the governor to decide whether to update the
target frequency is more reasonable in cpufreq_policy_apply_limits().

Lifeng Zheng (2):
  cpufreq: governor: Move requested_freq to policy_dbs_info
  cpufreq: governor: Apply limits with requested_freq or next_freq

 drivers/cpufreq/cpufreq_conservative.c | 14 ++++----------
 drivers/cpufreq/cpufreq_governor.c     |  3 ++-
 drivers/cpufreq/cpufreq_governor.h     | 12 ++++++++++++
 drivers/cpufreq/cpufreq_ondemand.c     | 10 +++++-----
 include/linux/cpufreq.h                |  7 ++++---
 kernel/sched/cpufreq_schedutil.c       |  4 ++--
 6 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.33.0


