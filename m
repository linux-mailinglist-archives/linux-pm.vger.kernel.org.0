Return-Path: <linux-pm+bounces-18303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5A99DF373
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 23:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F030B21604
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29AE1AB51B;
	Sat, 30 Nov 2024 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLHnbaER"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74961AA7B1;
	Sat, 30 Nov 2024 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733004063; cv=none; b=DlHoo7JbTof1HcFgZYahoOXghCHDqhqlEzJvWTjY1JXu8LT/pudlJG8aBEVtivFRAu1N8lWTHzPhv9bWi3P6mKK+gZL2+go0rnoPWtjgZf+D5RZ78K9sbDqBkFa6NvorbBTTIFwYdbZcfVXg6ifCpITtndFYBL1Rf2BjZjx5joE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733004063; c=relaxed/simple;
	bh=Mf0csG0iS3wJNdsD8vZqXml7YbGbVZl0cpgv1Z1zVlQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FtZXiLgkSS3JOffJ6h5PDZJUUSqDl+xdSu+gMQDRG886KSHhkKRiQVOwSVGqMoR5Nv1U+K2bawT8+yqU78l+/4oayNQIID6eMagfU21D+dQFA+OryiQwmOpaA+YEcFAoixC5MosNZ4hBrEX+AYdIM5yTTvUD5X7AFP++gPxQMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLHnbaER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43750C4CED4;
	Sat, 30 Nov 2024 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733004063;
	bh=Mf0csG0iS3wJNdsD8vZqXml7YbGbVZl0cpgv1Z1zVlQ=;
	h=From:Date:Subject:To:Cc:From;
	b=eLHnbaERLW1z3Rxdf5/DQkrXS4soCQMqr76MdqF+25ysDo2oeS0KfZz9Bcg36Jh7B
	 vU1ZUISqbw1Wu4N/fzc1r7vJolRfME2kUf/NgOOKt5DTMKHl/MLMFJagKw7C+V6nfP
	 x91e0lgiZ9AGbLbWxmYE8nwfLLTBKSNtbOXy150rBfp06S7+PgYB1WTArkg7T7U/zM
	 g82ORxHa7eu7KlnR+ntqhrfGdVZpRgX2R+QsoiUKjQ962PQAQJx/v9mwNYrQ9y8VJb
	 SW5yGcMVUnuN+70vsj1xAsp0XsQCikrwxu4HIseSP6HvhElB9CstkOokqTzJEqvNAi
	 vd49c7kME/OJQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ea45abb4e1so1144702b6e.3;
        Sat, 30 Nov 2024 14:01:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWr7a4UKTOxSvx1JTKFrB7mMB15AoawztbFIgovD3jE7724Xe7eY0RM0wXkH81Bh4+Gtw1f7w7ebZuN8Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuogm6lwuimk1Doq6uAEXQPflGiL4M/3WiIhQPjyEQJdMz4xEI
	yJviOdJjGw735VUiMUIifF/L6aArLGzkneZZzB9/ncPTcaORld0Mg3+1U4NgNL1s89QmZjekVEC
	J8TC6hu0gZ5MKgrwluzYmv43VGzY=
X-Google-Smtp-Source: AGHT+IGgYJ4IxB3f3+Hs9t9DQ4lfe5BRz4bAPiTSQU84HIPLR5JlpIyyBrV0+lnL8xzeyNRec9tO49BXjxuIDoFhCc0=
X-Received: by 2002:a05:6808:1791:b0:3e5:fd5a:c39b with SMTP id
 5614622812f47-3ea6db6ed21mr12014671b6e.4.1733004062645; Sat, 30 Nov 2024
 14:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sat, 30 Nov 2024 17:00:51 -0500
X-Gmail-Original-Message-ID: <CAJvTdKmFGmc2EDJHVRUg8rz9Z7zRw2sruB2rofJuf_aVk9HPOg@mail.gmail.com>
Message-ID: <CAJvTdKmFGmc2EDJHVRUg8rz9Z7zRw2sruB2rofJuf_aVk9HPOg@mail.gmail.com>
Subject: [GIT PULL] turbostat 2024.11.30 for Linux 6.13-merge
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull these turbostat-2024.11.30 patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit adc218676eef25575469234709c2d87185ca223a:

  Linux 6.12 (2024-11-17 14:15:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2024.11.30

for you to fetch changes up to 86d237734091201d2ab2c1d2e1063893621c770f:

  tools/power turbostat: 2024.11.30 (2024-11-30 16:48:56 -0500)

----------------------------------------------------------------
turbostat version 2024.11.30

since 2024.07.26:

assorted minor bug fixes
assorted platform specific tweaks
initial RAPL PSYS (SysWatt) support

----------------------------------------------------------------
Len Brown (1):
      tools/power turbostat: 2024.11.30

Patryk Wlazlyn (6):
      tools/power turbostat: Fix column printing for PMT xtal_time counters
      tools/power turbostat: Allow using cpu device in perf counters
on hybrid platforms
      tools/power turbostat: Honor --show CPU, even when even when num_cpus=1
      tools/power turbostat: Force --no-perf in --dump mode
      tools/power turbostat: Fix child's argument forwarding
      tools/power turbostat: Add RAPL psys as a built-in counter

Todd Brandt (1):
      tools/power turbostat: fix GCC9 build regression

Zhang Rui (11):
      tools/power turbostat: Fix trailing '\n' parsing
      tools/power turbostat: Remove PC7/PC9 support on MTL
      tools/power turbostat: Add back PC8 support on Arrowlake
      tools/power turbostat: Rename arl_features to lnl_features
      tools/power turbostat: Remove PC3 support on Lunarlake
      tools/power turbostat: Add initial support for GraniteRapids-D
      tools/power turbostat: Enhance platform divergence description
      tools/power turbostat: Remove unnecessary fflush() call
      tools/power turbostat: Consolidate graphics sysfs access
      tools/power turbostat: Cache graphics sysfs file descriptors during probe
      tools/power turbostat: Add support for /sys/class/drm/card1

 tools/power/x86/turbostat/turbostat.8 |  27 +++
 tools/power/x86/turbostat/turbostat.c | 425 ++++++++++++++++++++++++----------
 2 files changed, 325 insertions(+), 127 deletions(-)

