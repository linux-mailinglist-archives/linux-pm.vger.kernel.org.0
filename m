Return-Path: <linux-pm+bounces-24862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF6A7CFE5
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695FF16D5DA
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08845191461;
	Sun,  6 Apr 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEgetoRA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189B136337;
	Sun,  6 Apr 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743966337; cv=none; b=Ms01elLxQerFwx0IQzpgUJmpYyGpFxC2O5CplKXSa4h3AHRXYHhipizqlPBFIq9aXBcec1/B7FXzWUWoepld9MzfSXaUYig3IUZPFebzB2pvgjh7PI0+VKBWRAPztCagdVe/B24ZesZUeczGBKVgtuHNFWLQbCFoH2S7t2gYzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743966337; c=relaxed/simple;
	bh=rnkEiCJKsYL4L4KIERR35DcMdP+U5Cb/7LPs+8u2Kmg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nzHecYPSutwOevTjbwrrli8o+locfL7Tlm4lYieSpOIwaBu8nIDNvNiV0ykBtTTn8maDnJMaavPDyJUHh/ZYvrBnER9X78JFhMvFJguur/Kf1rwxgNAxRUUMipUEbrj2pkZmdnEQ3af8EswvvIxKXHtTllLchP9MucJeGOV03ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEgetoRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5436BC4CEE3;
	Sun,  6 Apr 2025 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743966337;
	bh=rnkEiCJKsYL4L4KIERR35DcMdP+U5Cb/7LPs+8u2Kmg=;
	h=From:Date:Subject:To:Cc:From;
	b=MEgetoRABXiGBI8iLCN4iqCkS3CnZi4wD337DOwVSvD+u7ipNbXsX1aesG7vIqew4
	 kzrKxaIbPfbyXBUaTwz4W27XhTa3yR7Lc5GDAzUdeGbHhyEV5NR7KFcmjaQDHJACdv
	 R/7uCE9/UrIr9XSfonoxLGws/HnCI54fQvbNKiFz2SWox9jV+XX+qDwSCAsvtCLy2m
	 PMblPJBf/EJkN3iD3jteT2dRX6tA0ho+H8+9OSG87KiucdwxsEkP6ABCZ4t9wcFQs2
	 LKZhVP433Qvqxes12HJATFiXuu8RmyTGntcmQ9xJE3+GUP2LZqDyvYg1isNeAqQ9Gt
	 ZdEDBaiqFCxng==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601c46a92d1so2599987eaf.1;
        Sun, 06 Apr 2025 12:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrbaCSsVeNBZXuUfh46R1coCnpCI0m8eA1U0jTmj5ezzmkoACZf0SIOMqXUoIuRh/tQ6WjNyVUobKzDr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThvA2GsXb1tUf2g+fJXbD7IXuShOSH1lDFFf+WKQQvN6DnCNp
	9psMqvaUypxHqKWydR7NJHsi0W6Snre5JWTo0rlHCwteSRz4wecKbPTuHzYiKmdkQehEmcjRePU
	t/CcDGYPFx2DZsFVVOFRS1mHqjFE=
X-Google-Smtp-Source: AGHT+IGeqJ/kpKrkViGuXRHU6jvWv5c/6t97ulleEBO0GwGB/4C0aFnVw8Xw+elF+yna0YpSdXzg4TWXidO0YLh8CFI=
X-Received: by 2002:a05:6820:1b88:b0:604:1:3736 with SMTP id
 006d021491bc7-6041665464bmr5346676eaf.7.1743966336700; Sun, 06 Apr 2025
 12:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sun, 6 Apr 2025 15:05:25 -0400
X-Gmail-Original-Message-ID: <CAJvTdK=2NjoVYPFO3EbKgmdrhmgDx9Q-0Zk0tYHhaBEgNzdfJw@mail.gmail.com>
X-Gm-Features: ATxdqUHDkNRoKEL4NOcWhCBUr6QX138uta2Jo1h4T0u2gx3hpFrKsShwnJoGLEE
Message-ID: <CAJvTdK=2NjoVYPFO3EbKgmdrhmgDx9Q-0Zk0tYHhaBEgNzdfJw@mail.gmail.com>
Subject: [GIT PULL] turbostat-2025.05.06 for Linux-6.15-merge
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus

Please pull these turbostat-2025.05.06 patches.

thanks!
Len Brown, Intel Open Source Technology Center


The following changes since commit 2c4627c8ced77855b106c7104ecab70837d53799:

  tools/power turbostat: version 2025.02.02 (2025-02-02 10:54:23 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2025.05.06

for you to fetch changes up to 03e00e373cab981ad808271b2650700cfa0fbda6:

  tools/power turbostat: v2025.05.06 (2025-04-06 14:49:20 -0400)

----------------------------------------------------------------
Turbostat 2025.05.06

Support up to 8192 processors
Add cpuidle governor debug telemetry, disabled by default
Update default output to exclude cpuidle invocation counts
Bug fixes

----------------------------------------------------------------
Artem Bityutskiy (2):
      tools/power turbostat: Fix names matching
      tools/power turbostat: Add idle governor statistics reporting

Justin Ernst (1):
      tools/power turbostat: Increase CPU_SUBSET_MAXCPUS to 8192

Len Brown (6):
      tools/power turbostat: Clustered Uncore MHz counters should
honor show/hide options
      tools/power turbostat: report CoreThr per measurement interval
      tools/power turbostat: Document GNR UncMHz domain convention
      tools/power turbostat: re-factor sysfs code
      tools/power turbostat: disable "cpuidle" invocation counters, by default
      tools/power turbostat: v2025.05.06

Zhang Rui (2):
      tools/power turbostat: Allow Zero return value for some RAPL registers
      tools/power turbostat: Restore GFX sysfs fflush() call

 tools/power/x86/turbostat/turbostat.8 |  16 +++-
 tools/power/x86/turbostat/turbostat.c | 162 ++++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 43 deletions(-)

