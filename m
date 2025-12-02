Return-Path: <linux-pm+bounces-39042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0CC9A705
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D38A4E315E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C2301706;
	Tue,  2 Dec 2025 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W35i8PoQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C88221DB1;
	Tue,  2 Dec 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660467; cv=none; b=hMbveYqy7og8MhswezvytCrfX5gkawZhiJKqlkhNW3Y4u6BrCtOi5B0aBxwe0yZ9ECMt3e6IfZonEHuJ5OseUUxecZr47un/e+aaIsWyeY024JOiEe4O0RaYETXvPT2FRqhuv6RRHyfVvHeKxJRtZJOloYmKY6RjyeFHutssJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660467; c=relaxed/simple;
	bh=uS99S80io6a6U/5hLltsmuS8JC9aERTzvqQXzRXc0Qk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0t1J2263VmCqlwYOE9IT47vajKK12I9jxNcv12w+9xIe+qiuWrWhuA4KzUTmTe9fYrsSXK6CkLaKjMU2+hY+PshEOVByivSWJ6xC8cv/oYE+sbM9DLQgAGIvO3WQiaTXP6k56en3GXhVRUdcqOQdeSUAVCUGx3/ENQfUFm9jdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W35i8PoQ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yLrEbT7Eff5TN5L01evaNY76SuW8M4SeJ+qEMgIgP4I=;
	b=W35i8PoQGEbRH3p/kui/2mgOw4xBq9gcM2SaRnlJuQANol5neVUO+qs292x4PdaxIzgs+Zmuq
	0ePtMqFAMDBOdACbB99xkBW/yEQLnAYBh+d1EwY0So/fn5ZxEMrqkaAdGmnxWoJF8B0/1cq/fZ9
	jMZs9UvUw51TeGeN5/MfjXM=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dLC3x3xK9z1T4GL;
	Tue,  2 Dec 2025 15:25:49 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C22F1402CF;
	Tue,  2 Dec 2025 15:27:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 15:27:39 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v3 0/2] cpufreq: Return -EOPNOTSUPP if no policy is boost supported
Date: Tue, 2 Dec 2025 15:27:25 +0800
Message-ID: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
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

Make cpufreq_boost_trigger_state() return error when boost isn't supported
by any policy.

Changelog:

v3:

 - add `likely` and `unlikely` to if conditions in
   cpufreq_boost_trigger_state()

v2:

 - change the error to -EOPNOTSUPP
 - remove the comment and blank line
 - split the optimization into another patch

---
Discussions of previous version:
v1: https://lore.kernel.org/all/20251126031916.3641176-1-zhenglifeng1@huawei.com/
v2: https://lore.kernel.org/all/20251128091352.1969333-1-zhenglifeng1@huawei.com/

Lifeng Zheng (2):
  cpufreq: Return -EOPNOTSUPP if no policy is boost supported
  cpufreq: cpufreq_boost_trigger_state() optimization

 drivers/cpufreq/cpufreq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.33.0


