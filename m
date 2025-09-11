Return-Path: <linux-pm+bounces-34466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97982B532D2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A151C85FD0
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1931A575;
	Thu, 11 Sep 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5I3wIMm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BF23AB8A;
	Thu, 11 Sep 2025 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595303; cv=none; b=n+PtN9VXP/2S+GPfcRiuT8BsfeGKSj4mjz790cvvuTeAbPICVIN3EnCagaIAQeJrWuiKt8vs+B1VZavOalCUlSa3DYwgUnmwDcyXYTdYHeNUEC+WTPrJ0lj6KyOzAKUQpUaWVXa34d0+PvFiF34e6ziHNz0tgyjfgxsfE89er6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595303; c=relaxed/simple;
	bh=kUamfGGx5n3Z4g26DreT0zQfkgHhAnmsXNz8Phr6jjk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g7vnXaQTY0ZMNwhjfHVq3e+CezWzh8H+AKEGw6sanamVl6geB4Wx2XEBkvub8eyQq6kkIuE/fHl5/GPzJCfUEqai5Lmad4SnPwVHdLvlj5BYbwJIlVTWntgj1yaQ6vw7fpDgHQ74iknu1CnY2L4zRug9Suu73QSmxx/WZ3OakFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5I3wIMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ED4C4CEF0;
	Thu, 11 Sep 2025 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595300;
	bh=kUamfGGx5n3Z4g26DreT0zQfkgHhAnmsXNz8Phr6jjk=;
	h=From:Date:Subject:To:Cc:From;
	b=T5I3wIMm5cR8a7a8WIxYydkdkIWoLqIj7V6/zWw71DH25JL9DP9yLQnXHhpi1bWFH
	 Jon60CTykRcl0LAPokqhcMq4rrRhPfbLsV5zeLoYnn4s07U7FtgkEcuvAbd57nI6ot
	 KkgssJlfjtGe9P8oQcRuY2OkbhKe74E7fDg7hwftRaohU38Yt6ZRDGUdDnb0esJOz6
	 KHrz3LIogWUSmr1172LVAly2UiMx73tH4OCx01UbqcQbDmeZHao2EuTWBz0ahn2W6E
	 5CV4hDY1CaYtVRglDbYgVEmgk28xuWlsInDndYIIaDRffAsqz+kfK2BD9A4X4abTuv
	 nFnxtKx469X8A==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-746d3b0d926so263800a34.1;
        Thu, 11 Sep 2025 05:55:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXV2Pkk35tqFyWxS6zteP3gR52/sEExyQg7ismuHdodV/dPZgiqGSHnaMSLfxt9oW2xibr8uzMvN1Hmiqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeviPbcUjoqUnBIRbQLIbSDfEABHz2OQXeRdcQolFKXY1AOOQl
	Axw4df2NKFq4JpatCACgXYDHqwhgHFEZyo58Rg5UHYfbPDF6x6BkPLuZymvIoBojbgz0HR3Au58
	4XGdxlIYHg4DBpCCTGKfLFmcR5Iihj1Q=
X-Google-Smtp-Source: AGHT+IG98WhLqVCwMY/2AvCS2rEBfCNKgym1hWiGmI+LlUs45ABBWM3HslvA2dJfb4fFE30Rskq85kM3n2B5GVb0bF4=
X-Received: by 2002:a05:6830:2584:b0:745:a21c:6a6a with SMTP id
 46e09a7af769-74c7115e030mr11993928a34.12.1757595299560; Thu, 11 Sep 2025
 05:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 14:54:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-OGp-djCo7m8Y92v1FOPTYbPp4tw_d1N4jyS_4gfgFA@mail.gmail.com>
X-Gm-Features: Ac12FXwqS_NWGj2I3GSYyJaA8rO-OqDwtZiyLBPTk9_i-irvZti3A1x1AEJMQdk
Message-ID: <CAJZ5v0j-OGp-djCo7m8Y92v1FOPTYbPp4tw_d1N4jyS_4gfgFA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.17-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.17-rc6

with top-most commit bddce1c7a5ab3ec2dd0fc404f4155c0c17e847b2

 Merge branches 'pm-sleep' and 'pm-em'

on top of commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c

 Linux 6.17-rc5

to receive power management fixes for 6.17-rc6.

These fix a nasty hibernation regression introduced during the 6.16
cycle, an issue related to energy model management occurring on Intel
hybrid systems where some CPUs are offline to start with, and two
regressions in the amd-pstate driver:

 - Restore a pm_restrict_gfp_mask() call in hibernation_snapshot() that
   was removed incorrectly during the 6.16 development cycle (Rafael
   Wysocki)

 - Introduce a function for registering a perf domain without triggering
   a system-wide CPU capacity update and make the intel_pstate driver
   use it to avoid recurring unsuccessful attempts to update capacities
   of all CPUs in the system (Rafael Wysocki)

 - Fix setting of CPPC.min_perf in the active mode with performance
   governor in the amd-pstate driver to restore its expected behavior
   changed recently (Gautham Shenoy)

 - Avoid mistakenly setting EPP to 0 in the amd-pstate driver after
   system resume as a result of recent code changes (Mario Limonciello)

Thanks!


---------------

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Fix setting of CPPC.min_perf in active mode
for performance governor

Mario Limonciello (AMD) (1):
      cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume

Rafael J. Wysocki (2):
      PM: EM: Add function for registering a PD without capacity update
      PM: hibernate: Restrict GFP mask in hibernation_snapshot()

---------------

 drivers/cpufreq/amd-pstate.c   | 19 +++++++++++--------
 drivers/cpufreq/intel_pstate.c |  4 ++--
 include/linux/energy_model.h   | 10 ++++++++++
 kernel/power/energy_model.c    | 29 +++++++++++++++++++++++++----
 kernel/power/hibernate.c       |  1 +
 5 files changed, 49 insertions(+), 14 deletions(-)

