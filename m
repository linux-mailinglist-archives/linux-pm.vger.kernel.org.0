Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6E32ADD98
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 19:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJSAU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Nov 2020 13:00:20 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:46991 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJSAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 13:00:20 -0500
Received: by mail-ej1-f50.google.com with SMTP id w13so18867828eju.13;
        Tue, 10 Nov 2020 10:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fNXodH2YDGU0C6JRzXB3O87tm6Lf1nNqv5Ef8QnmCeY=;
        b=lm/7BG2dqtnMRh70vPK4gtZWCEobJW/f6mzSymEasVPKClWVUVba5Zen/LAQ5GHqaD
         MqJJd0VKlAvmG5bRK0q4u156itygBJ/iDwVZpUYuXi7pE0LGrdgA8p5abLg2TO3femTt
         /tz9HBVZSOcnmCDud3pJFRYN85Ue3BnRhdYRY6HmHM4lYgM1uuED9KPACHshTTf6Oq+Q
         r+hM3UizGx4CxvRCx8+VyNLonrgbdlgDwTLpB3Z7BwaQ42Gng2vsuV+mcFYxr8mhowMQ
         WCpU56aBcVRlhtGv56byMwXv3R2byFZPw24XXvZ38L1j31xzBIOYTzhcuBrRApkRXBWm
         TSYw==
X-Gm-Message-State: AOAM532SZ9NADF2yjJSKtF4XG7G3s+IIO73xxdG5Vk6IDwtnV0nliXLB
        w+MuXDuEZSLOo6wQDU7AR3V/MxW+6mVGrpD7X0K7QTN1W+c=
X-Google-Smtp-Source: ABdhPJzuq6esZI2wAlzhppUmGZOgPxBiRv7r1n8mxccvooFc2N3AAXd9uBI49kaIT6c2uMlPyCciFUs+G77RqyrA9yI=
X-Received: by 2002:a17:906:c43:: with SMTP id t3mr20720925ejf.219.1605031213875;
 Tue, 10 Nov 2020 10:00:13 -0800 (PST)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 10 Nov 2020 13:00:02 -0500
Message-ID: <CAJvTdKkS9ywVCp3_MK9e_N7J=LvSHFRjTfSb8Q7O+WvVh2zACA@mail.gmail.com>
Subject: [GIT PULL] turbostat: update to version 20.09.30
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull these turbostat related patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit e00b62f0b06d0ae2b844049f216807617aff0cdb:

  x86/cpu: Add Lakefield, Alder Lake and Rocket Lake models to the to
Intel CPU family (2020-07-25 12:16:59 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 3e9fa9983b9297407c2448114d6d27782d5e2ef2:

  tools/power turbostat: update version number (2020-11-10 11:41:36 -0500)

----------------------------------------------------------------
Alexander A. Klimov (1):
      tools/power turbostat: Replace HTTP links with HTTPS ones:
TURBOSTAT UTILITY

Alexander Monakov (1):
      tools/power turbostat: Build with _FILE_OFFSET_BITS=64

Antti Laakso (1):
      tools/power turbostat: Remove empty columns for Jacobsville

Chen Yu (3):
      tools/power turbostat: Make the energy variable to be 64 bit
      tools/power turbostat: Introduce functions to accumulate RAPL consumption
      tools/power turbostat: Enable accumulate RAPL display

David Arcari (1):
      tools/power turbostat: Fix output formatting for ACPI CST enumeration

Doug Smythies (1):
      tools/power turbostat: Always print idle in the system
configuration header

Kim Phillips (1):
      tools/power turbostat: Support AMD Family 19h

Len Brown (7):
      tools/power turbostat: Print /dev/cpu_dma_latency
      tools/power turbostat: Support additional CPU model numbers
      tools/power turbostat: Skip pc8, pc9, pc10 columns, if they are disabled
      tools/power turbostat: adjust for temperature offset
      tools/power turbostat: harden against cpu hotplug
      powercap: restrict energy meter to root access
      tools/power turbostat: update version number

Ondřej Lysoněk (1):
      tools/power x86_energy_perf_policy: Input/output error in a VM

Prarit Bhargava (1):
      tools/power turbostat: Use sched_getcpu() instead of hardcoded cpu 0

Rafael Antognolli (1):
      tools/power turbostat: Add a new GFXAMHz column that exposes
gt_act_freq_mhz.

 drivers/powercap/powercap_sys.c                    |   4 +-
 tools/power/x86/turbostat/Makefile                 |   3 +-
 tools/power/x86/turbostat/turbostat.8              |   2 +-
 tools/power/x86/turbostat/turbostat.c              | 573 ++++++++++++++++-----
 .../x86_energy_perf_policy.c                       |  67 ++-
 5 files changed, 509 insertions(+), 140 deletions(-)
