Return-Path: <linux-pm+bounces-29350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A487FAE4744
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2530163D1C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B41267729;
	Mon, 23 Jun 2025 14:41:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB17182BC
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689664; cv=none; b=oMV1Yobgv28fv3dFdTeHnZKEl7nwuc7UiHH9c/PYWlYhyKjRX5TGS3s9QzokKAYIsnDLRNaYIFeOncEd4hGacf3XXHzLQETrdxvi1YHZwYlmfTD6sVTdF17R30Yba4zHQaRz41K7m/ifJsvocd6AJGO9oVf4mTwFRJQSd65gQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689664; c=relaxed/simple;
	bh=VsxOMIGaXs1JMl4P1We2SYf66K+K1BXyMLPhPr+wPbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h23r5Sp3/0I8gbUqtdX7i47vtj2ONZZsE1hNscrydQCeuggPN1pQ7zDF4h9RVatqVA/wewjqyQgUkNHr7Vh0q90HRn6uOlVI5I7SpUx6nFFxK/b8iNgmcEzQzkYJzP/TYt/BXgi4hBUXNpWLXKKMjUcYK32V5l4SY+vaht0gAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bQrPr0Tj7z2QTxc;
	Mon, 23 Jun 2025 22:41:52 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 396F2140276;
	Mon, 23 Jun 2025 22:40:57 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100006.china.huawei.com (7.202.195.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 22:40:56 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <jonathan.cameron@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <alireza.sanaee@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<liwei728@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v6 0/2] PM / devfreq: Add HiSilicon uncore frequency scaling driver
Date: Mon, 23 Jun 2025 22:33:59 +0800
Message-ID: <20250623143401.4095045-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
the devfreq framework.  The uncore domain contains shared computing
resources, including system interconnects and L3 cache.  The uncore
frequency significantly impacts the system-wide performance as well as
power consumption.  This driver adds support for runtime management of
uncore frequency from kernel and userspace.  The main function includes
setting and getting frequencies, changing frequency scaling policies, and
querying the list of CPUs whose performance is significantly related to
this uncore frequency domain, etc.  The driver communicates with a platform
controller through an ACPI PCC mailbox to take the actual actions of
frequency scaling.

Changelog:

v6:
Consolidate hisi_uncore_init_pcc_chan() related stuff:
- Move devm_mutex_init() to hisi_uncore_init_pcc_chan()
- Move devm_add_action_or_reset() into hisi_uncore_request_pcc_chan()

v5:
https://lore.kernel.org/all/20250619151456.3328624-1-zhanjie9@hisilicon.com/
- Comment more on error code related stuff about
  hisi_uncore_mark_related_cpus(), and return failure early on errors
  except for -EINVAL, which indicates possibly broken firmware.
- Separate error prints apart for two cases in hisi_platform_gov_handler()
- Make the 'related_cpus' sysfs ABI description more generic
- Some coding style cleanups and typo fixes

v4:
https://lore.kernel.org/linux-pm/20250530081722.280776-1-zhanjie9@hisilicon.com/
- Allow devfreq core to accept device-specific sysfs ABIs
- Replace custom sysfs attrs with dev_groups and let the devfreq core
  manage it
- Update 'related_cpus' description in the devfreq ABI doc
- Remove COMPILE_TEST in Kconfig as the mailbox_client.h doesn't support
  this yet
- Replace dev_err() with dev_err_probe() during drv->probe()
- Replace mutex_init() with devm_mutex_init() to warn on UAF
- Replace uncore->dev with dev in some places to make code a bit shorter
- Remove redundant uncore->pchan check in hisi_uncore_free_pcc_chan()
- Use __free() to let compiler release temporary memory
- Clean up the error handling and redundant 'status = 0' in
  hisi_uncore_send_cmd()
- Some coding style cleanup

v3:
https://lore.kernel.org/linux-pm/20250522031701.1912458-1-zhanjie9@hisilicon.com/
- Remove redundant resource freeing processes when drv->probe() fails as
  they're already handled by devm

v2:
https://lore.kernel.org/linux-pm/20250520074120.4187096-1-zhanjie9@hisilicon.com/
- Make devm manage the release sequence, remove drv->remove()
- Warn on !uncore or !uncore->pchan as they're no longer expected
- Remove ioremap of pcc shared memory because it's done by the pcc driver
- Fix compiler warning of discarding 'const'
- Minor trivial coding style changes

v1:
https://lore.kernel.org/linux-pm/20250506021434.944386-1-zhanjie9@hisilicon.com/

Jie Zhan (2):
  PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
  PM / devfreq: Add HiSilicon uncore frequency scaling driver

 Documentation/ABI/testing/sysfs-class-devfreq |   9 +
 drivers/devfreq/Kconfig                       |  11 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/devfreq.c                     |   1 +
 drivers/devfreq/hisi_uncore_freq.c            | 658 ++++++++++++++++++
 include/linux/devfreq.h                       |   4 +
 6 files changed, 684 insertions(+)
 create mode 100644 drivers/devfreq/hisi_uncore_freq.c

-- 
2.33.0


