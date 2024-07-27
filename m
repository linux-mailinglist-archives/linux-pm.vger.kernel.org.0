Return-Path: <linux-pm+bounces-11489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603793E0AD
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 21:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222211C20C3F
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D918755C;
	Sat, 27 Jul 2024 19:11:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB815B570;
	Sat, 27 Jul 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722107503; cv=none; b=gILLr9wacgJV0d6WqhH5Z1yDJA5LBCeTJn0TNitPmPFFzPtQ+FM4R3+iNRjOhulwqHMor5oDdyY0XgfFLt6AXSO2sm8SD7H+ObH6VqXzUIspd6f75Dxk+15UXmPHw9zC76RdD4nF5VPZXvLHCfV9SAAKRYIB4LWJUfdB8VngWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722107503; c=relaxed/simple;
	bh=nKvWUVR/oTeV71PdUgP2hI6ww6eaino7g+EdNFlSC9I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sqA04hq/VfoXiFDESc+hcZY62Jm8xa7LhtKRNVvY2unynoacMxHIbrDpmMsnRFGfYnQcNEncYKfKQ4naWRxiRIuDxJgX6JGVomJTprdZjSNRsRspul8CWLOEtwuoqRzslzEnxrUOUGEXBZcL+9ze5TG68RKILSFjXAFwhhDwWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-260f863109cso1352969fac.1;
        Sat, 27 Jul 2024 12:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722107501; x=1722712301;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDIB7c0sILO/knUgvZlVA7r7ElBc2AbO2B42Uc06C88=;
        b=o3ZJbPXAZN3O0aSrNPu34dMsluTTJISiT/PHiIMCFFkcC0JuK94VbugoSmXHPs0vUW
         t42QWW6w0L16xMN93ktNtx8OsOy0fnvRVZeTJCt8cEB7pT70A/F5tzZPSt7rGp2WeKQ5
         orOahfS8SYY0Cu5Kw0Wa666rF9FgFHDSLdJueOEV3QKlhrLSBHXXSvGhJI7vywj3PbD/
         +n1jlUJ2GMAQ6/lOSJtlzpCiAYn+4rmket1FjXQFe1J2fnBdBGcJ6wN3LdJLNnIzYNZl
         xiRtFe4jz0vAnx4cx3CutcWftqX/v2ehYBcAcP6WZ621YKgPU3N5FVZBVgGffqeQkKKZ
         FO6w==
X-Forwarded-Encrypted: i=1; AJvYcCXwqG+CuLyDS8nNy/eOqzfUIZm7nRj21RcIQcM+FwyMpuXZCqYSYkC19w5Devh8U3nzVWQGFH6gjqcplEJdOZF4ZH42udflh5qgZeQr
X-Gm-Message-State: AOJu0YwFGwX4CvXqzeKhJ921Y5lfTJz8vz/aODg2bgZ2a1KhIoWau66y
	eAIJTJhdy8P0maNDzu+9WvTHU0mgXWV/VU7upnp443xMid/op7i/GshZzwvVIxBaggHq5DLD8Sj
	FmPmcM3UW/ldMIVRjq935M6kST6PWsOPj
X-Google-Smtp-Source: AGHT+IGziHFDotrmMFNvvp6kjuGMHtgF8O1lHoFfz/47jjPhJRiTguk/dkPxR2ht2TG1OYRtn56MG1DJmIsR3i4oUic=
X-Received: by 2002:a05:6871:5207:b0:261:1b0f:dc94 with SMTP id
 586e51a60fabf-267d4f3b525mr4023833fac.45.1722107501023; Sat, 27 Jul 2024
 12:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sat, 27 Jul 2024 15:11:30 -0400
Message-ID: <CAJvTdK=eR67WE6e9YDZKoVTStoeTMPaJ2D-2=_agwU1tjFbu1g@mail.gmail.com>
Subject: [GIT PULL] turbostat-2024.07.26 for Linux-6.11-merge
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit b15943c4b3351173d5f3b0d87362d2994a89bb66:

  tools/power turbostat: Add local build_bug.h header for snapshot
target (2024-06-27 23:53:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/v6.11-merge

for you to fetch changes up to 866d2d36b81d7d0e6d91423b6dd9b1bcfd0510dd:

  tools/power turbostat: version 2024.07.26 (2024-07-26 14:36:08 -0400)

----------------------------------------------------------------
turbostat release 2024.07.26

Enable turbostat extensions to add both perf and PMT
(Intel Platform Monitoring Technology) counters via the cmdline.

Demonstrate PMT access with built-in support for Meteor Lake's Die%c6 counter.

----------------------------------------------------------------
Len Brown (1):
      tools/power turbostat: version 2024.07.26

Patryk Wlazlyn (16):
      tools/power turbostat: Remove anonymous union from rapl_counter_info_t
      tools/power turbostat: Replace enum rapl_source and
cstate_source with counter_source
      tools/power turbostat: Add ZERO_ARRAY for zero initializing builtin array
      tools/power turbostat: Group SMI counter with APERF and MPERF
      tools/power turbostat: Extend --add option with perf counters
      tools/power turbostat: Fix formatting in turbostat.8
      tools/power turbostat: Add perf added counter example to turbostat.8
      tools/power turbostat: Fix typo in turbostat.8
      tools/power turbostat: Move debug prints from stdout to stderr
      tools/power turbostat: Move verbose counter messages to level 2
      tools/power turbostat: Add selftests for SMI, APERF and MPERF counters
      tools/power turbostat: Add selftests for added perf counters
      tools/power turbostat: Add early support for PMT counters
      tools/power turbostat: Add MTL's PMT DC6 builtin counter
      tools/power turbostat: Document PMT in turbostat.8
      tools/power turbostat: Include umask=%x in perf counter's config

Tony Luck (1):
      tools/power/turbostat: Switch to new Intel CPU model defines

 tools/power/x86/turbostat/Makefile                 |    1 +
 tools/power/x86/turbostat/turbostat.8              |   98 +-
 tools/power/x86/turbostat/turbostat.c              | 2341 ++++++++++++++++----
 .../selftests/turbostat/added_perf_counters.py     |  178 ++
 .../testing/selftests/turbostat/smi_aperf_mperf.py |  157 ++
 5 files changed, 2277 insertions(+), 498 deletions(-)
 create mode 100755 tools/testing/selftests/turbostat/added_perf_counters.py
 create mode 100755 tools/testing/selftests/turbostat/smi_aperf_mperf.py

