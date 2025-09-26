Return-Path: <linux-pm+bounces-35437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AEBA24A7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 05:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5A04A3A41
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB923A995;
	Fri, 26 Sep 2025 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB5pX+XS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE423B0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758856870; cv=none; b=j/AFizF2TjSW81gWEEt+Y05AiG5PZyJ25S+z91p33LeAxhzY7znbwPFT0hCwUHuqZoCbpAse5Tuk2hzXu9uqbdGIuXNYfNt/+enWlR5aIdj3Klvrnl5dxamzrQdbSlF33HeXtzq6Ag99AowOV69pHQAWAElHHKjZnJVlzAq2pjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758856870; c=relaxed/simple;
	bh=6vv6DRG9WBb5FGx7Nbi3mzhacULPQlN/63pYG+3He40=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KumNmAxdsAshERVPiLl30N145ITVDigT/ehA4mewi1kU5ZRl2imkbqE9Ot7C/vz6fivqMGYj0gn553ElmuzdbAD0ImKRzohw51lBFFn7uD0J7GGXAe08PP14QcLeZM0ZaEq6XLM6ZmS42F/fRRCp27x12dGnsbVrbHPm00vmHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB5pX+XS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312A4C4CEF0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 03:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758856870;
	bh=6vv6DRG9WBb5FGx7Nbi3mzhacULPQlN/63pYG+3He40=;
	h=From:Date:Subject:To:Cc:From;
	b=qB5pX+XSbFLYxXVGGOy7AvOP8bzuriMV/83VqhMUU4r6hixQrA3vzA4oUBIbdJsvn
	 W7oErnMSJUDwHWzZDS/RzGHJmhTVk98fWhok3cqH0WeQ/DYrU4En2gERot6YESt+cO
	 f6WU99ASBC2D9m4HjjR1/UZOqOkC6CQWO65nLd2SFnb+EBE+q7O0WbswOT8j/3ybpX
	 F+O28Uz/4xFFH5YfgytKwYGRL6MbAsAeVNQIJ4dtemPfPBxYcke/EcHLzYUZb9SAws
	 3wG2NeWoGJQxm+TNNEOg+M29VCAX0t70H3x/qWwH8P5ntXOgbCpFFI03Qfz353FA7V
	 tEwl01oNbNZQQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7a8e7ece907so413485a34.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 20:21:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyq7MaNIBvkReDvX21ym2Z/uJTmUG22yVSbAfMO4fzWtM7MzUKw
	pYlrdPSH3BKCYd9hkj/QwVAkRgm0GnegfEzCYAyBWa1In3us5qBq1TpyzBBWiA/UREmZ/1RS5v0
	SrWNENQ4baJd0n8oadzCH/+1j35vc/pE=
X-Google-Smtp-Source: AGHT+IERUk77CapUrIP38uMBXUiT9EvYjvoM4YOXe2/qWUY9UaRy4vCRvOXSv0ncgxjnMtrfxUCvXaL2qUgTpkGgV00=
X-Received: by 2002:a05:6808:1825:b0:43f:2ab7:344e with SMTP id
 5614622812f47-43f4cf566f3mr2759318b6e.48.1758856869553; Thu, 25 Sep 2025
 20:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Thu, 25 Sep 2025 23:20:58 -0400
X-Gmail-Original-Message-ID: <CAJvTdKmpA9o1M-5Shp1vS2Feh3uLR-NdN97v7dj7odFs1YCOEw@mail.gmail.com>
X-Gm-Features: AS18NWDI0IHpIUjIQLcyZ1ylaVMlOXym20xDtftDpwxeEiWrpBYxNJAFVqIK7Hg
Message-ID: <CAJvTdKmpA9o1M-5Shp1vS2Feh3uLR-NdN97v7dj7odFs1YCOEw@mail.gmail.com>
Subject: [GIT PULL] Power utilities for Linux v6.18 merge
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rafael,

Please pull these power-utilities-for-v6.18-merge patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/power-utilities-for-v6.18-merge

for you to fetch changes up to 66f430522452fe1a8a0fd2198cf9f335125acbfc:

  tools/power x86_energy_perf_policy.8: Emphasize preference for SW
interfaces (2025-09-25 23:12:01 -0400)

----------------------------------------------------------------
turbostat and x86_energy_perf_policy bug fixes for Linux-v6.18 merge

----------------------------------------------------------------
Kaushlendra Kumar (2):
      tools/power turbostat: Fix incorrect sorting of PMT telemetry
      tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage

Len Brown (7):
      tools/power x86_energy_perf_policy: Enhance HWP enabled check
      tools/power x86_energy_perf_policy: Enhance HWP enable
      tools/power x86_energy_perf_policy: Prepare for MSR/sysfs refactoring
      tools/power x86_energy_perf_policy: EPB access is only via sysfs
      tools/power x86_energy_perf_policy: Prefer driver HWP limits
      tools/power x86_energy_perf_policy: Add make snapshot target
      tools/power x86_energy_perf_policy.8: Emphasize preference for
SW interfaces

 tools/power/x86/turbostat/turbostat.c              |   2 +-
 tools/power/x86/x86_energy_perf_policy/Makefile    |  29 ++++-
 .../x86_energy_perf_policy.8                       |  15 ++-
 .../x86_energy_perf_policy.c                       | 133 ++++++++++++++-------
 4 files changed, 129 insertions(+), 50 deletions(-)

-- 
Len Brown, Intel Open Source Technology Center

