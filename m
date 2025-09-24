Return-Path: <linux-pm+bounces-35279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46AB99DE0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93153B4A02
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4922FC038;
	Wed, 24 Sep 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIjfeuAn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39F1FB1
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717495; cv=none; b=NckWKaggFZXSiHxUFush8tMSwxa5ys58h+K1C7HYYi5ubtBfZ1/tO7oMjQzfa9hvOJQT9aol/qKT86valLGq4mNaJzZpepjGhNEru7U6HwgkM3neuR9T26p8s5EsJlvEKf2HhpnOiXZGnz9kZU9HVWrZgfaRmWsTXA+Y9el/ydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717495; c=relaxed/simple;
	bh=czD1suQinfy+rBLz89im1EB34LEjxwjibqErL74jV8w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R8XZeU+5khmrR0WPRthwtWmN/yZJ/SYZBIQ+Vm74385XYCOKaDaURvFko+DSi2g7G8oN87aTO0Wn90Ai4W/woFO8i622knLEoKWJMECO3d0PFA5L14NNBNe9LBO+up4IpSW46E0Zu5Hqtic6Pa9whp0DysCQx2bv6j6kjGMDpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIjfeuAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E873FC4CEF0
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758717494;
	bh=czD1suQinfy+rBLz89im1EB34LEjxwjibqErL74jV8w=;
	h=From:Date:Subject:To:Cc:From;
	b=rIjfeuAnBdJv/HPy3yIGkL35ouLhxlstO7OkjPw3v3WJPB4xem3qnvVOEA6MR6vnO
	 g/NtliDkyYyBaSIKKO+pSpVzcbMSLCPColJmYftyKgRO9JJxEio0L2uNILTp4MI/O5
	 gKvCTl7hiPb0gZvKmLITRQv0AL93f0luk25lJYTFs89sPubk8VFUqpJbS9/i4542VS
	 gmXZBEsEX7z2hrvlzCL7dx+8Lj1Pt6RVohIT1AFY/7yQZhct1y7F9YLVF5YlItC5Sk
	 ys8vcRx48EBt2ZsfRtyx2Dw4OnFOmd7F0x9ExzuasR5rC2jfbUA2kCu1OyX3+1/RKk
	 sMiT85VZa118g==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7859d18aa33so2061666a34.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 05:38:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIOeGoX0PjcMAXfJsOMM4Clzka5rZQ8RO5hqVlQx2RLv9WTUb/
	IeSkYuJ3koEcGGocSW3WJ6WapXLWUDgWmhDPY5w5gkRLEppHfoxmPn62KqaRpOZm7MuRNM8sbi0
	tfwnSmZqZpd2dRCWd9/BcZZAJ+TYtKRk=
X-Google-Smtp-Source: AGHT+IH4oiQputRouqoqiC1vt+uvYEQ86hVX9sEqhAyohQUCr9e632INcAZEMAkbH+AlDf1Jr76nYYZAxt5YU+wztqc=
X-Received: by 2002:a05:6830:2653:b0:757:44de:c0c6 with SMTP id
 46e09a7af769-79153cb9819mr3497706a34.17.1758717494282; Wed, 24 Sep 2025
 05:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 14:38:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfvPV2cmk0=7G0LyAYvnKmYMG5fM6p_-oCYTgYTgN96Q@mail.gmail.com>
X-Gm-Features: AS18NWD-I5Uq4FjQUnyU6MYt8XA4c9y3TTHkTdlRaQUlWgzKG7lMPMZTCK7q9Ik
Message-ID: <CAJZ5v0jfvPV2cmk0=7G0LyAYvnKmYMG5fM6p_-oCYTgYTgN96Q@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.17-rc8

with top-most commit 8ffe28b4e8d8b18cb2f2933410322c24f039d5d6

 cpufreq: Initialize cpufreq-based invariance before subsys

on top of commit f83ec76bf285bea5727f478a68b894f5543ca76e

 Linux 6.17-rc6

to receive a power management fix for 6.17.

This fixes a locking issue in the cpufreq core introduced recently and
caught by lockdep (Christian Loehle).

Thanks!


---------------

Christian Loehle (1):
      cpufreq: Initialize cpufreq-based invariance before subsys

---------------

 drivers/cpufreq/cpufreq.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

