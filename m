Return-Path: <linux-pm+bounces-7966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3258C9192
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6A281CD1
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE54642D;
	Sat, 18 May 2024 15:57:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D43B298;
	Sat, 18 May 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716047832; cv=none; b=k53Zy6DG7dmaeRU8nK/gKOYSLe31aI2MjPs6jR2+snfAL8d9q7hqw5H/8O6ZjhC0NwtsZsr/pOiWC3Eq9PgIr9RzZQFopMxOvNrEjF+23DVa7eycTS7KrIbaETGBAJCv3Mtp6ZDGbIrE5//fkI/Lzs2iRxpsIJDPvQmn4XhNMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716047832; c=relaxed/simple;
	bh=luwsE8sJj0aAZyR5n1prlcTaj8ZGrd0q17yleeIl4b0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bz5Go2bLlfa5PdltjEysjdTgoJ7gNoBXAGqeWZWLGbT3JrEkuR/jxIEhVcki+ygFM2uPAcC9hEWGN5hHFBAnGPgOaFEUhQ5M08WcwkXZF1g8zlCUtZpRm609JER7fM60SC4Bh4vS1Xs81ghqoquC6Q3ytG3IxhC95UsYCTRqbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2451da9b4feso610406fac.0;
        Sat, 18 May 2024 08:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716047829; x=1716652629;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5oU0oxpGBmiuXxo8TPbNOfb9WkNLqCPN14da9/KZXU=;
        b=MzosRmCNLs7fPyUvJyjgbLclBghyPRS+tymKF2XdeLz2DApUP/RKP4J1+jgcA8dfAz
         l4iGAURIfRdZeD7U7Tyy3ve1fycfx5yhZ+N04Hv00Ry5BHDClR3U1mHctwRxnTwlSDXt
         m2IVe50HfT1EDAtHm8OlnIc2h4vY602FPYQe0qRUvqDTK4kjpKF9EGl3SPCEMWPKWzmu
         /KygwKwwuXoK9YRjDKcxd6BUBB0BSnaShhDwSS1I5nSyXjzxJcohqBztMShUlzIuMg+D
         j/v9VIpASOJ0c18IXCuJAIX6sGetiROiEONsktC80H+E5ZJYZg8PndfsLtE/yTABEuIy
         wpVg==
X-Forwarded-Encrypted: i=1; AJvYcCX1IbWkWusTxiuOK0fiyafcNebDsvZigrO3+I4IaSMPiyvOVL29sBihDnFG1VUaQbFkTHXNHtfxyaHtSEXogDC/o2HZ7FKuixM1jUug
X-Gm-Message-State: AOJu0YyOIvTMU1L7SfGyRMIlqV4a9hJvPYB183uyPR81IQvC1B1OiA6C
	jVA2TcL7eiWylrbgzp90t5/Iil6eoJT/seUTfSQ21DjAJpDVF6Fg9+HBrqTrvTsjgvkSa7Xw5FJ
	tJuMDR+t9a4p7lueL8lgTn+64vta+4Bsi
X-Google-Smtp-Source: AGHT+IGpfmXPV7iIGBOjBuqoO3XnNaL5Thr2FWfLExiB5HBIPBCQvDfHPcmG9859LsUxzUXM+wvM1u42r+4lY2VxkV0=
X-Received: by 2002:a05:6870:4209:b0:22e:bcfd:debc with SMTP id
 586e51a60fabf-24172a90478mr36457834fac.13.1716047828781; Sat, 18 May 2024
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sat, 18 May 2024 11:56:57 -0400
Message-ID: <CAJvTdKmgOCBUX=O4VvuVZfnXVpZcm5vDU6DtAYykuhBH7+-7ow@mail.gmail.com>
Subject: [GIT PULL] Turbostat 2024.05.10 for Linux-6.10-merge
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit a6189a7407795b3f5167ea532ac85931cd26083a:

  Merge tag 'turbostat-2024.04.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux (2024-04-10
13:13:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-for-Linux-6.10-merge-window

for you to fetch changes up to 256d218ec6aea99855dc5c54af550fcff96fc732:

  tools/power turbostat: version 2024.05.10 (2024-05-15 21:50:17 -0400)

----------------------------------------------------------------
Turbostat 2024.05.10 update since 2024.04.08:

Survive sparse die id's seen in Linux-6.9.

Handle clustered-uncore topology in new/upcoming hardware.

For non-root use, add ability to see software C-state counters.

Enable reading core and package hardware cstate via perf,
and prefer perf over the MSR driver access for these counters.

----------------------------------------------------------------
Len Brown (6):
      tools/power turbostat: Add "snapshot:" Makefile target
      tools/power turbostat: Harden probe_intel_uncore_frequency()
      tools/power turbostat: Remember global max_die_id
      tools/power turbostat: Survive sparse die_id
      tools/power turbostat: Add columns for clustered uncore frequency
      tools/power turbostat: version 2024.05.10

Patryk Wlazlyn (7):
      tools/power turbostat: Replace _Static_assert with BUILD_BUG_ON
      tools/power turbostat: Enable non-privileged users to read sysfs counters
      tools/power turbostat: Avoid possible memory corruption due to
sparse topology IDs
      tools/power turbostat: Read Core-cstates via perf
      tools/power turbostat: Read Package-cstates via perf
      tools/power turbostat: Fix order of strings in pkg_cstate_limit_strings
      tools/power turbostat: Ignore pkg_cstate_limit when it is not available

Zhang Rui (2):
      tools/power turbostat: Enhance ARL/LNL support
      tools/power turbostat: Add ARL-H support

 tools/power/x86/turbostat/Makefile    |   27 +-
 tools/power/x86/turbostat/turbostat.8 |    4 +-
 tools/power/x86/turbostat/turbostat.c | 1169 ++++++++++++++++++++++++---------
 3 files changed, 899 insertions(+), 301 deletions(-)

