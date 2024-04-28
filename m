Return-Path: <linux-pm+bounces-7231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30CA8B4944
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 05:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193B21C20BA9
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098415C9;
	Sun, 28 Apr 2024 03:02:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EF15A4
	for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2024 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273347; cv=none; b=qlvrEp7OZ3fjezCvHvHEgWOYDoRZp7lFFqhe6/H/w/W9NNorSesXuogrsB0W8+6Kv5AJCqV5cH5omEdvq7YjupyzJKIWYEQtu/uXXTEl8fyLCxq7IudbCM4008NIfYcPJZ0dKIYM3EZxAdjrwGuo7tm4X7guFz6bye9hQcUtNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273347; c=relaxed/simple;
	bh=BCkZAyvBoteC25Yv5sy/lDpC/HZn+FB3Q+0ffNJoOtw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nWDm+/FfdhvtrngapMzh01e347czXukHCzJVscnNO+R7uv3IszFbBaP4VML5S1kLBilDvZIW9mz82jF8Z9q4G+/uuGWsgC1mXN+57wGZwp/KnSMH2ja0zquYDbEZZEHCzE5ntbPr/DBMpdMq9PIBsF3hHmdqFPOzlEoVChyIKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5acb90b2a82so2351122eaf.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 20:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714273344; x=1714878144;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CaGJV+6KKtlNxP4BOy/aTAMDRKxW6rbiCHcRjYXo/E=;
        b=S0lSQX/SR9VVpxllAY/OySaQQzQn+o9JHV9okzY7lF9J9Id4OJX8e5AjErftNSdin2
         b4p9LeZRRTSsoYZ5FjtJROpvwy9Qtou3TDzwJpTREXNjPZUwYQDfEpsSb9lcVGra3yBR
         hExmKRHAqJBg2MEH4wrpiq+K3b/UoNPIXVhoL1hM4++q9ldM4d8Z4NrUjouHACtQNUdw
         gyvpiUs6XXl/yQBFDGT/ZxEhGUNafMMuGwAhDmABsbfbsSLb7zB11eUOhuPTp5rp+Mve
         42yzCHWbKob42Gqa8M+j+dXfzBeEcViuxZLb2lxG8rTlcwskCiH23E7QGsOnJnQanfHi
         ubrA==
X-Gm-Message-State: AOJu0YyUWZrNDNTQXwldEhOsPCqj08ntM4rb6jOjG2Mai+LWY5FKroVp
	0imHvPyKR/mz/Z6Y7ms1Bu4zP6axXUIa1EkhwgjMb50Iu/5dB8p1ulVhY/zu6R2/8V+aYbR1s0j
	aMqNCn5EQprSZaDpR41i3vanL3a7PRIBx
X-Google-Smtp-Source: AGHT+IHY+YM1Y/wvm5p/OFD53RIDGH7W4dojt3JkrhAWCe7jURvOlLazIGKqjxaUar5kawUSQZ1BheA7jt7rfNS9ayI=
X-Received: by 2002:a05:6870:b683:b0:234:56db:7c8c with SMTP id
 cy3-20020a056870b68300b0023456db7c8cmr8039540oab.57.1714273343985; Sat, 27
 Apr 2024 20:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sat, 27 Apr 2024 23:02:12 -0400
Message-ID: <CAJvTdKmqJx5nnwfxehRRHrYi7mR=6Y8bbrwL083Ain=MhBQq6g@mail.gmail.com>
Subject: [GIT PULL] turbostat 2024.04.27 for linux-next
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,
Please add this branch to linux-next:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git next

Currently, and in the foreseeable future, I will stage some upstream-bound
user-space power management utility work on this branch.

I do not expect any other trees to touch these files,
including Rafael's pm/linux-next branch,
and so it should merge without conflicts.

If you pull today, you'll get the changes below.

thanks!
-Len

The following changes since commit a6189a7407795b3f5167ea532ac85931cd26083a:

  Merge tag 'turbostat-2024.04.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux (2024-04-10
13:13:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git next

for you to fetch changes up to c9d06640119383d166924f0739cfaaefd442394a:

  tools/power turbostat: version 2024.04.27 (2024-04-27 22:15:48 -0400)

----------------------------------------------------------------
Len Brown (6):
      tools/power turbostat: Add "snapshot:" Makefile target
      tools/power turbostat: Harden probe_intel_uncore_frequency()
      tools/power turbostat: Remember global max_die_id
      tools/power turbostat: Survive sparse die_id
      tools/power turbostat: Add columns for clustered uncore frequency
      tools/power turbostat: version 2024.04.27

Patryk Wlazlyn (2):
      tools/power turbostat: Replace _Static_assert with BUILD_BUG_ON
      tools/power turbostat: Enable non-privileged users to read sysfs counters

Zhang Rui (2):
      tools/power/turbostat: Enhance ARL/LNL support
      tools/power/turbostat: Add ARL-H support

 tools/power/x86/turbostat/Makefile    |  27 +-
 tools/power/x86/turbostat/turbostat.8 |   4 +-
 tools/power/x86/turbostat/turbostat.c | 485 ++++++++++++++++++++++------------
 3 files changed, 343 insertions(+), 173 deletions(-)

