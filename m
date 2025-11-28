Return-Path: <linux-pm+bounces-38870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F99FC91618
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 10:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251F23A3732
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47D3019D0;
	Fri, 28 Nov 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="k5Gr9VUk"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25E2E8B8F;
	Fri, 28 Nov 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321255; cv=none; b=qRLLfgxiDf/tLOmzaxlXVdqwBgPAjMBzdy/S5PdsqLRZF78EAL4ibnQvdW8t7Ugv9tLngGX12WlrKKxBVLZn4kEgxG0F2twBApLSp/3L67XCHtL0aVolbOvkQZrP8eEu2BgFkizzqhxR0Ig4jqo4Xla9r62GYXqlIMxwooLEv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321255; c=relaxed/simple;
	bh=Ufo0aS2FSZzFYgvDt7FWV31D8pAUKErMxp4xjrwWc7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XJOxzEseqJ5ct1f3IUzz0jZaNaeVxVSNa1oWytNvlz+zvKuuGslHOTbeTEKNqxKjSUxsjhlGkfBkdomopgSCDLWvjeAiwUY0HsNjXk70crH+lqqa/JusWVSCvIMXrGWQjQIGANc19yThS0XmYp/alpKVM8sbcHJlJcXfpaoJKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=k5Gr9VUk; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Nualv5ERhi4fh9wWgADhQ9L7CyUbVLq7Dw6eASKm3Z8=;
	b=k5Gr9VUkoXswItmUdQtzfrGfrS91Sx6RWGFhH+Kv7yGZn1samuVSe0YcydWwULLX3Xt8Hsrbg
	qOgCOiETIQqLYvv/3oizv21K7XZPw/J//qeSSUHkaY30UxKJd0tR+LUQr/ywch2lBKiKhyOHVX7
	NvuefHxv04KhbP0wPI6Lfbg=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dHncZ2rrnz1cyNp;
	Fri, 28 Nov 2025 17:12:14 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id DDF221A016C;
	Fri, 28 Nov 2025 17:14:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 17:14:03 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 0/2] cpufreq: Return -EOPNOTSUPP if no policy is boost supported
Date: Fri, 28 Nov 2025 17:13:50 +0800
Message-ID: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Make cpufreq_boost_trigger_state() return error when boost isn't supported
by any policy.

Changelog:

v2:

 - change the error to -EOPNOTSUPP
 - remove the comment and blank line
 - split the optimization into another patch

---
Discussions of previous version:
v1: https://lore.kernel.org/all/20251126031916.3641176-1-zhenglifeng1@huawei.com/

Lifeng Zheng (2):
  cpufreq: Return -EOPNOTSUPP if no policy is boost supported
  cpufreq: cpufreq_boost_trigger_state() optimization

 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.33.0


