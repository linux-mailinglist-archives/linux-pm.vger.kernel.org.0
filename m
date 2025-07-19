Return-Path: <linux-pm+bounces-31082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D4FB0ADB7
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 05:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F24B5A440B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09A1A3179;
	Sat, 19 Jul 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0hwS/f4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E55EEA8;
	Sat, 19 Jul 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752895563; cv=none; b=Ul4ZVozELI/DusJA9EjO3xZNzEN1OHfynyJ+GgNboKqMQoAJgahW7HNYOqxMTcErq2/U9nMts+GBmBplkKUHaGW7UgMqkFxaQcuBw3VmLdDu0bXUV2Ls6KlLsuys/T1hVzcLCcWUd+ZKXb8CzFiXUSGjAtPmuCLgROObJvUx0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752895563; c=relaxed/simple;
	bh=2cpalJczI7pfooA0JFfOfIJXL1bS185spme0cSVp0mE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=P8Ox/p8OGt7eBZUq02mjKaFjLr0PNdxSL1ZanXQePLT27APTxmSeJzptzLYhXIanBFWKp3/pgpYWTURgFKU1zaBafcXTcOOklRQA5K9qp18O7baSTp9lNyG5w3wBS65qzr55AdueWxU/6Pw2AQ22uDPBcRovTNmKG1mDViRK6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0hwS/f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CC1C4CEEB;
	Sat, 19 Jul 2025 03:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752895562;
	bh=2cpalJczI7pfooA0JFfOfIJXL1bS185spme0cSVp0mE=;
	h=Date:From:To:Cc:Subject:From;
	b=f0hwS/f4c2gDzQKxiRjts9nmiveI0javcub3K4jD0lhbkPyY844/Fmb1D2UZ4st+r
	 BVdmfZ0rHyWsxs7rZbyEPySQtPojXH095JWQ2dKYMZcpmmh1s6QuVJPOpJ1nvBlmfZ
	 9f64GTKl69xXjESqczevPgt28kWhmiC0kM1EZV7eGDX02MCxTrzSZtHZ16efiP1apv
	 6KJ3VuYo1IyjXI9e9WzUMvFo+jfaZbSC+EQDnij8esoi9IbY+roa/n4m2Owz3NMcuW
	 lAgRizdBs+W2IMns8QObYvS+Lq5O0PBvpFTJrY4Arm7B7G20E4fo+IDEIRTI2NzKVA
	 CNs5QnwndpEmw==
Message-ID: <2fd09dd9-59f5-4852-b796-e458c89aa193@kernel.org>
Date: Sat, 19 Jul 2025 12:25:59 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] devfreq next for 6.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear Rafael,

This is devfreq-next pull request for v6.17. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.17

for you to fetch changes up to 7da2fdaaa1e6062686ac96a9f096c2d7847533e4:

  PM / devfreq: Add HiSilicon uncore frequency scaling driver (2025-07-14 20:23:57 +0900)

----------------------------------------------------------------
Update devfreq next for v6.17

Detailed description for this pull request:
- Clean devfreq core and fix bugs
 : Replace sscanf with kstrtoul
 : Remove redundant devfreq_get_freq_range() on adding devfreq driver
 : Check missing NULL pointer check on removing devfreq driver
 : Limit max_freq and min_freq to avoid unreachable value
 : Fix wrong index on trans_stat sysfs node

- Use devm_* managed function for clock control on sun81-a33-mbus driver

- Add HiSilicon uncore frequencye scaling driver for for HiSilicon Kunpeng SoCs
 : The uncore domain includes shared system resources such as interconnects
 and L3 cache, and its frequency has a significant impact on system performance
 and power consumption. The driver provides the following functions:
   - Support to scale frequency scaling with governor and user setting
   - Support to query CPUs whose performance is closely related to the uncore domain
   - Communication with the platform controller via an ACPI PCC mailbox
     to perform actual frequency changes

----------------------------------------------------------------
Chanwoo Choi (1):
      PM / devfreq: Fix a index typo in trans_stat

Jie Zhan (2):
      PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
      PM / devfreq: Add HiSilicon uncore frequency scaling driver

Lifeng Zheng (4):
      PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_freq_store()
      PM / devfreq: Limit max_freq with scaling_mina_freq
      PM / devfreq: Remove redundant devfreq_get_freq_range() calling in devfreq_add_device()
      PM / devfreq: Check governor before using governor->name

Uwe Kleine-König (1):
      PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions

 Documentation/ABI/testing/sysfs-class-devfreq |   9 +
 drivers/devfreq/Kconfig                       |  11 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/devfreq.c                     |  23 +-
 drivers/devfreq/governor_userspace.c          |   6 +-
 drivers/devfreq/hisi_uncore_freq.c            | 658 ++++++++++++++++++++++++++
 drivers/devfreq/sun8i-a33-mbus.c              |  38 +-
 include/linux/devfreq.h                       |   4 +
 8 files changed, 704 insertions(+), 46 deletions(-)
 create mode 100644 drivers/devfreq/hisi_uncore_freq.c


