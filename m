Return-Path: <linux-pm+bounces-36721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA485C0133D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 14:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4057F35A5D8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52CD13DBA0;
	Thu, 23 Oct 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqdpin9J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15714086A
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223582; cv=none; b=FDKfKeE3BiUHTSmICmsZVZt8hT0Ds87MLAzOQ+EFE7b8ooJmszb3ON9/SQnujopi/84v2YPUVqcpDglFGt9uiFAsrPV/QwtmHoYa/cR8D6NWxBiZxkhfjG8842zUTxfenNY2kub1YQhazagHQcpiWZ6gld1+q1v26D8bYwO4YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223582; c=relaxed/simple;
	bh=Sizf7CGeACdwP7gOc5o1U4haoeWMTWq90HUAkt/cODY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CfD2YncSvS07bf2vgMs/2GiALzWmN1acMwvR95+RUhaGi8jL1vnErwPdQL2YEIuPf4IcecOKU9uLmeAZBD0rbLZbiRA/7trZyBNTUQ7x84bG404SxdA3CEBAH+vVQXhaY0Z6MjTszdT1J3RB3WJDvd4qtgeQgN3Wb9eTnSGsJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqdpin9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780B6C4CEE7
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761223582;
	bh=Sizf7CGeACdwP7gOc5o1U4haoeWMTWq90HUAkt/cODY=;
	h=From:Date:Subject:To:Cc:From;
	b=hqdpin9JHOvvwCEmLhnNbj1Ay+lVvqZEGDQM6WUUMvq7Z2BnfuKKWk296WeF/vtfD
	 ydNGqqZ+8ow00z6BGS49o5hKNQjFfDdt2sBxvKQNz4L5PicY9KlNnRdHb8UgGAHyap
	 MM9dLXGk20SdgJRoz61Cph/ZpuoKsM1N3dfTWwlyO1ndQvfeY3wJsK4E8fNqAVw5Vq
	 96c+OzFd/mJGAlSsD8w4G2wQ/blssiBpY9241A/8T5oax2E41rYksjrpyxP2NIJ3ho
	 xMUU18xBqO0qn1MJ4zTp5MEpyNLOgjwPJ2mNso0FoJNbPP1aWeGwgOdQFGQahGI4gX
	 ywWDa9jjQsgrQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4444887d8d1so379443b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 05:46:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzcF+fBKmZw2WzCkITt/grANqkQPaU1+oMHEOq6WLM3EdW9glgS
	LqS/1/lvQGEvX9W1ScYmPo6/EjobqXQi/YuMiFTbu7PwPAbfQ1Cja3K7Xjlsf5qz3ER/EX1v0RF
	8Ebnx+mVJpBWovRrSiMWAjdpUe9a4Tkg=
X-Google-Smtp-Source: AGHT+IHOn8VUQsDPmWsiYFCKPqh/+AVdKwBQAHtuCTh8mhrqvInJacgO2I2XTeiGIxF8SMEI+t8beoax3YHZT/p+u8A=
X-Received: by 2002:a05:6808:2f12:b0:443:a060:28e5 with SMTP id
 5614622812f47-44bd4307e34mr832695b6e.48.1761223581811; Thu, 23 Oct 2025
 05:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 14:46:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGoHmc0bV2WC-pvok6a-teOR76XnmSUu_LBromN-kFRQ@mail.gmail.com>
X-Gm-Features: AS18NWCGVExabVNosS-Hym7XJ6gfOtuPFAH_FVR5bTGW_F-oXKAIVG3ckszRQr8
Message-ID: <CAJZ5v0iGoHmc0bV2WC-pvok6a-teOR76XnmSUu_LBromN-kFRQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.18-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.18-rc3

with top-most commit b62bd2cf7e991efbc823665e54dd7d7d8372c33b

 Merge branches 'pm-cpuidle' and 'pm-cpufreq'

on top of commit 211ddde0823f1442e4ad052a2f30f050145ccada

 Linux 6.18-rc2

to receive power management fixes for 6.18-rc3.

These revert a cpuidle menu governor commit leading to a performance
regression, fix an amd-pstate driver regression introduced recently,
and fix new conditional guard definitions for runtime PM.

 - Add missing _RET == 0 condition to recently introduced conditional
   guard definitions for runtime PM (Rafael Wysocki)

 - Revert a cpuidle menu governor change that introduced a serious
   performance regression on Chromebooks with Intel Jasper Lake
   processors (Rafael Wysocki)

 - Fix an amd-pstate driver regression leading to EPP=0 after
   hibernation (Mario Limonciello)

Thanks!


---------------

Mario Limonciello (AMD) (1):
      cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate

Rafael J. Wysocki (2):
      Revert "cpuidle: menu: Avoid discarding useful information"
      PM: runtime: Fix conditional guard definitions

---------------

 drivers/cpufreq/amd-pstate.c     |  6 +++++-
 drivers/cpuidle/governors/menu.c | 21 +++++++++------------
 include/linux/pm_runtime.h       |  8 ++++----
 3 files changed, 18 insertions(+), 17 deletions(-)

