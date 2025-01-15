Return-Path: <linux-pm+bounces-20478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B281A11ECB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58906188ECC7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D870122F82E;
	Wed, 15 Jan 2025 10:01:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF251EEA2B;
	Wed, 15 Jan 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935290; cv=none; b=cRsixTztSr2jCs6Vo3oLltmQSySSG/njr61HLTzTrg4od3Y864SgmugoXxjCh3UN6r5cfvwOSh6ISBk/AxhX5uyiMWWDN0BRwQwvLVtGaAUjGUKEOA54/kVIj/9bQIvlrSGWaTALk2OoWJ9Sy13Cxi4QViI/NDl8x2+6exq1Xa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935290; c=relaxed/simple;
	bh=AhBYLD0t8YfoVLkrD8+Dx8UqljNp5NmfgR42Fs2EWD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UguG7McO5fO4DOBKGtX5vDjSEE77OjmlxgLEcch38l9P2lPiyHHBH/XoNBkgVo9VPkrDVxlCZtCXWIJ5yOVtSuk1Uq/wW+cVM1LnTDAoRGjo+qE2ARcgtarm9sEHU8Bget5fkKYR9kNEKha3tU6nGkD91beOJcO4NS4eHSMU/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YY1fs6jnTzRkMq;
	Wed, 15 Jan 2025 17:59:01 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B5AA3140159;
	Wed, 15 Jan 2025 18:01:24 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jan 2025 18:01:24 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH 0/2] cpufreq: Introduce a more generic way to boost when cpu is going online
Date: Wed, 15 Jan 2025 18:01:21 +0800
Message-ID: <20250115100123.241110-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Since commit f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on
SoCs using cpufreq_boost_set_sw()") and commit 102fa9c4b439 ("cpufreq:
Allow drivers to advertise boost enabled"), per-policy boost flag has
already been set to mirror the cpufreq_driver boost during
initialization. However, the current implementation doesn't work for all
cpufreq drivers and may fail in certain situation. A more generic
implementation is needed.

Lifeng Zheng (2):
  cpufreq: Fix re-boost issue after hotplugging a cpu
  cpufreq: Introduce a more generic way to set default per-policy boost
    flag

 drivers/cpufreq/cpufreq.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.33.0


