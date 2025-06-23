Return-Path: <linux-pm+bounces-29335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6AAE4432
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926ED17DDEC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2624728E;
	Mon, 23 Jun 2025 13:34:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF78E4C6E;
	Mon, 23 Jun 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685655; cv=none; b=Y8aPM9ciSI//h0goYWgKEnrZgEztPSypz+6zyjHV0J66Bjkmh9HPaMOLkBpxWoUtQ+a+pl1QGJ4E++psAX8y5l4mHdwo25fLgtrCSubERh9/GljfXPwPaLJQBMAOrzkY+0MAFX6vP1cB8GblfXIYJeOKvXcpuaGaYEQrzw6pU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685655; c=relaxed/simple;
	bh=Sla9I5RfkvIfh9gnzAx8StDl6+TRHmUENk4QlnEG5i0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRvNp0fLkQK9vLuve6FCopz0NHCp9xR4JCHFvoe0FVkR/CK1w6YWUr3xEL7K/vbc6aTiUUmVDP5qPi09i/F3IoFLDzAR5YyhuVNRwT7MzrLVMl6q1oIaje2mU6X3OwGcBtHmyP6BZwIGwigBmQHGwJUabBdKkKBZOQxB/AxV1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQppj3VpyzTgm4;
	Mon, 23 Jun 2025 21:29:49 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B8BA1402DB;
	Mon, 23 Jun 2025 21:34:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 21:34:07 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH 0/7] cpufreq: Some optimizations for cpufreq.c.
Date: Mon, 23 Jun 2025 21:33:55 +0800
Message-ID: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
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
 kwepemh100008.china.huawei.com (7.202.181.93)

This patch series makes some minor optimizations for cpufreq.c to make
codes cleaner.

Lifeng Zheng (7):
  cpufreq: Disable cpufreq-based invariance when fail to register driver
  cpufreq: Init policy->rwsem before it may be possibly used
  cpufreq: Contain scaling_cur_freq.attr in cpufreq_attrs
  cpufreq: Remove duplicate check in __cpufreq_offline()
  cpufreq: Move the check of cpufreq_driver->get into
    cpufreq_verify_current_freq()
  cpufreq: Refactor code about starting governor in cpufreq_set_policy()
  cpufreq: Exit governor when failed to start old governor

 drivers/cpufreq/cpufreq.c | 53 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

-- 
2.33.0


