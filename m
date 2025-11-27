Return-Path: <linux-pm+bounces-38827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E89C8F310
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 16:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3940134F187
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6E2262FFC;
	Thu, 27 Nov 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLxLrFhP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DF214813;
	Thu, 27 Nov 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256247; cv=none; b=cg4YTWp8RrPpqO2oKzHYRr+Cdn0gc1GAvZzLOGE3TmKgKIuoXLiJxo6gD9BK2FPNdHymhqc8AaCmiwHh8I4YUldbyH6KwoWSgy/atOvQOcNvjXXBBDJuUGD3ge2MyYDS2UMkhT0hm6lbaBRUJqjlmTLVQh1fRuADXwj4BmXYdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256247; c=relaxed/simple;
	bh=6BDXEl8qoH9pzQVxJfeOO5sc3Xp0O/o0Ixyv5Uf30fo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=EU2Gnkab3ogrHjzukq9tuaMouBotivk3fv5l8WvlWdajIXvYcT4JHVxcivh1QVb1juIyp5rCi3DF+iIOO1zVixfq1g6hEt6jruWbdMf6LEdOUOpbeFL+49a5G8SqRTA9p6JNROZffv62H/W/eTuT5dGy+70RNzm5m8kT/kOhaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLxLrFhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342E6C4CEF8;
	Thu, 27 Nov 2025 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764256246;
	bh=6BDXEl8qoH9pzQVxJfeOO5sc3Xp0O/o0Ixyv5Uf30fo=;
	h=Date:From:To:Cc:Subject:From;
	b=RLxLrFhPf2o68CyKnUQ2LZbmt9OU1+GchB5UFtH7hcKuCA/YzpKewu0Q2otBjtrkd
	 secNKIp7txzpeFPhXFb+lWKXnNVKVlfxbG8gTlGzb/S4qsJR5Mo9PNLcDfU0bWyrn3
	 cQO+YNzA+xT08nYHs6RCLBwqjul2ol3Hf4ZPRyE9bfb0n3fzhOnQQXJrp7MT7+O/t5
	 O4Fzh8KlTMI4r1zh+sv0muxc5Od5+phNpnm1Mt+xAPAeUvqqbHm49A4D0nLEGXnumq
	 6XUl5wUyyN3KpC8BQTuj2x+XbDAI7tQaxdifN0SjSieqcDzM6OVbKlz9yKXE8O4CEL
	 TBrgj2PyFuUAg==
Message-ID: <80e7bf9c-50b3-4e34-aa33-ff9c82479dc9@kernel.org>
Date: Fri, 28 Nov 2025 00:10:42 +0900
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
 Chanwoo Choi <chanwoo@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Rafael,

This is devfreq-next pull request. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.19

for you to fetch changes up to d9600d57668c49308f705a660c5ad17fa3a53f73:

  PM / devfreq: Fix typo in DFSO_DOWNDIFFERENTIAL macro name (2025-11-26 13:58:59 +0900)

----------------------------------------------------------------
Update devfreq next for v6.19

Detailed description for this pull request:
- Move governor.h under include/linux/ and rename to devfreq-governor.h
  in order to allow devfreq governor definitions in out of drivers/devfreq/.

- Fix potential use-after-free issue of OPP handling on hisi_uncore_freq.c

- Use min() to improve the readability on tegra30-devfreq.c

- Fix typo in DFSO_DOWNDIFFERENTIAL macro name on governor_simpleondemand.c
----------------------------------------------------------------

Dmitry Baryshkov (1):
      PM / devfreq: Move governor.h to a public header location

Pengjie Zhang (1):
      PM / devfreq: hisi: Fix potential UAF in OPP handling

Riwen Lu (1):
      PM / devfreq: Fix typo in DFSO_DOWNDIFFERENTIAL macro name

Thorsten Blum (1):
      PM / devfreq: tegra30: use min to simplify actmon_cpu_to_emc_rate

 drivers/devfreq/devfreq.c                          |  2 +-
 drivers/devfreq/governor_passive.c                 | 27 +++++++++++++++++-
 drivers/devfreq/governor_performance.c             |  2 +-
 drivers/devfreq/governor_powersave.c               |  2 +-
 drivers/devfreq/governor_simpleondemand.c          |  6 ++--
 drivers/devfreq/governor_userspace.c               |  2 +-
 drivers/devfreq/hisi_uncore_freq.c                 |  6 ++--
 drivers/devfreq/tegra30-devfreq.c                  | 15 ++++------
 .../governor.h => include/linux/devfreq-governor.h | 33 +++-------------------
 9 files changed, 45 insertions(+), 50 deletions(-)
 rename drivers/devfreq/governor.h => include/linux/devfreq-governor.h (80%)

