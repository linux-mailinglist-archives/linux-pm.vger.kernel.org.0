Return-Path: <linux-pm+bounces-14065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F197629B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 09:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1B9B20E39
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595518C92D;
	Thu, 12 Sep 2024 07:25:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707A383;
	Thu, 12 Sep 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125959; cv=none; b=g40buKjZuMQnlYFcuTwOncfh5taPe2tB+3H4AxMK0ixvmgA3qrEZpvgo24EcqvMzMh851zGgRHlfRkMK2fycARyoUZcVrV9BswTZN0qJA/AkFiqdYBBlsqkzA8zdbZWwOcRhU3psPgQO42vgwQ4nj0zrHI74DQZJEoC2KHhpaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125959; c=relaxed/simple;
	bh=yqkaUARPSxjgK9nVazge9e3tyP0UO4vjPWJjbjH9x2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7ELlQ7PWl3p2HUoBIqBeJqRMXu3CzulX5zE3JKoX/FgW6Qy7Zbt0M9miBee9WyxjZ+Ym0ws6nWqJuXcLtbxEzNIVnzUbB91eHLT2Bnute+zBWDG8oyn/UFGQLw2ws3cDBvOF3DxX+8VkzhL+rAyzTXMGybV1IOrkBKZBPHC+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X489l2G0nz20l3L;
	Thu, 12 Sep 2024 15:25:47 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C1361A016C;
	Thu, 12 Sep 2024 15:25:54 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 15:25:53 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v2 0/3] cppc_cpufreq: Rework ->get() error handling when cores are idle
Date: Thu, 12 Sep 2024 15:19:58 +0800
Message-ID: <20240912072001.433980-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)

Internal:

A quick update of V2 with the feedback received today.
Also, cc'd a wider range of people.
Looking forward to further discussion and feedback.

-----------------
External:

CPPC feedback counters can be unchanged or 0 when cores are idle, e.g.
clock-gated or power-gated.  In such case, get the latest desired perf for
calculating frequency.  Also, the HiSilicon CPPC workaround is now handled
by the common code and can be removed.

Jie Zhan (3):
  cppc_cpufreq: Return desired perf in ->get() if feedback counters are
    0
  cppc_cpufreq: Return latest desired perf if feedback counters don't
    change
  cppc_cpufreq: Remove HiSilicon CPPC workaround

 drivers/cpufreq/cppc_cpufreq.c | 103 +++++++++------------------------
 1 file changed, 27 insertions(+), 76 deletions(-)

-- 
2.33.0


