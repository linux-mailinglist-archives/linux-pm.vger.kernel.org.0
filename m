Return-Path: <linux-pm+bounces-25762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DDA94B46
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF61890D64
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52A256C99;
	Mon, 21 Apr 2025 03:00:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68591E47CC;
	Mon, 21 Apr 2025 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204431; cv=none; b=nfM4N30iqvjHmfTtnm2UlahT34BSeqgAa0Q51o+i7JdhxjnwSGiUPWd2GCRFjRxRhscnzTHR/iA1mUjfC6jWZCp8gjcv9HTSq03JPQSOKmROTMT66Iua7nwjQ22E2KX5bMD6qxEmvevl5Mk9/4SHmsIMdvhXy06riDqKGVRRBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204431; c=relaxed/simple;
	bh=/gqV5rb8YfmenVMBBZdUCYAZ4bPszeklgaru24FvQ1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKqQj115f5wU8uvkR8jYBWyQtHabNL7xwDqhU5EmuKQT9meBaOxgkOWfa7VRHR0H6qDyfcCd7FVp62iHG5+zWpAwd+F/3sT4iTGwdpOMKmM85frExlevD3BdbHwSgpHgEitOHcqprjh+dEkAmgAM8KUK6DCy1NYuIRe5nasuTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZgqlT1Pm1z2CdJS;
	Mon, 21 Apr 2025 10:56:53 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C0EB1400DD;
	Mon, 21 Apr 2025 11:00:21 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 11:00:20 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<cenxinghai@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 0/4] PM / devfreq: Some optimizations of devfreq
Date: Mon, 21 Apr 2025 11:00:16 +0800
Message-ID: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)


Lifeng Zheng (4):
  PM / devfreq: governor: Replace sscanf() with kstrtoul() in
    set_freq_store()
  PM / devfreq: Limit max_freq with scaling_min_freq
  PM / devfreq: Remove redundant devfreq_get_freq_range() calling in
    devfreq_add_device()
  PM / devfreq: Check governor before using governor->name

 drivers/devfreq/devfreq.c            | 20 +++++---------------
 drivers/devfreq/governor_userspace.c |  6 +++++-
 2 files changed, 10 insertions(+), 16 deletions(-)

-- 
2.33.0


