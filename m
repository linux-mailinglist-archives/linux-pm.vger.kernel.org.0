Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF60A4610
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfHaUFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 16:05:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41066 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfHaUFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 16:05:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id z9so6719575edq.8
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 13:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AO9OdbzWGJ8d6+8+mtR61TUxVX7eFim+aLupGmq8wkk=;
        b=Jaqqp6MYqjPj/6i0x8qOqPHqt7u3Y18HnBI226f8Jv7RRVK9zMdwkHNfKH7bOF+OSu
         lcwbZD3+8EZc4a7A5dAzyK0VlC90TN8r4BUM+oxENk3ldM5V2NRmwRfDZyNzTpnkqx16
         vqEJdJW5d5HoIDjKY7zdcfD2AtiLWBD1CYxjNhhxsFX9AS/ZBsaS4tnawDOJ9oJmViSw
         ZMJ7sZW6ZuTtj6rj+Cm8TrbOlI7yKGOHZJp89gNL6THz2FTpsyGlNYT61SfB2h8tvkA5
         AndoCSQaNU4kG2oFuPedrEPls9CVLpTURuYvdPRRfNLxeI/he3pCUnaSNccGYaburxDi
         ofYg==
X-Gm-Message-State: APjAAAXdm5Zvgm72eGetkPPanWjuMqMnpX+jQFWBSGRL5EagMC/NX7fl
        mTCwLxCgAIwlXdjfFp4FyemYJXIxcb4ct6ZgCuQ=
X-Google-Smtp-Source: APXvYqybNK1ZTHtQHPTNbCQxflk7fEjeTVJyBS6nacErvjw5d6PvVwh4L8UEl8eNg66C641Kma+BzPQTUhgX7LVTfUU=
X-Received: by 2002:a17:906:528a:: with SMTP id c10mr17410707ejm.229.1567281942268;
 Sat, 31 Aug 2019 13:05:42 -0700 (PDT)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Sat, 31 Aug 2019 16:05:30 -0400
Message-ID: <CAJvTdKmWZduW3ZyFGG2Rh54kTEa8izkZT1EQ0890xPmijWofTA@mail.gmail.com>
Subject: [GIT PULL] turbostat: update to version 19.08.31
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull these user-space turbostat (and x86_energy_perf_policy) patches.
They are primarily bug fixes from users.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 9eb4b5180d33c827f16829644ae0cd7382ecdb82:

  tools/power turbostat: update version number (2019-08-31 14:48:39 -0400)

----------------------------------------------------------------
Artem Bityutskiy (2):
      tools/power turbostat: read from pipes too
      tools/power turbostat: do not enforce 1ms

Ben Hutchings (2):
      tools/power x86_energy_perf_policy: Fix "uninitialized variable"
warnings at -O2
      tools/power/x86: Enable compiler optimisations and Fortify by default

Colin Ian King (1):
      tools/power turbostat: fix leak of file descriptor on error return path

Gustavo A. R. Silva (1):
      tools/power turbostat: fix file descriptor leaks

Len Brown (4):
      tools/power turbostat: remove duplicate pc10 column
      tools/power turbostat: Fix Haswell Core systems
      tools/power turbostat: rename has_hsw_msrs()
      tools/power turbostat: update version number

Matt Lupfer (1):
      tools/power: Fix typo in man page

Naoya Horiguchi (1):
      tools/power turbostat: fix buffer overrun

Pu Wen (2):
      tools/power turbostat: Fix caller parameter of get_tdp_amd()
      tools/power turbostat: Add support for Hygon Fam 18h (Dhyana) RAPL

Rajneesh Bhardwaj (1):
      tools/power turbostat: Add Ice Lake NNPI support

Srinivas Pandruvada (1):
      tools/power turbostat: Fix CPU%C1 display value

Yazen Ghannam (1):
      tools/power turbostat: Make interval calculation per thread to
reduce jitter

Zephaniah E. Loss-Cutler-Hull (1):
      tools/power x86_energy_perf_policy: Fix argument parsing

Zhang Rui (1):
      tools/power turbostat: add Jacobsville support

 tools/power/x86/turbostat/Makefile                 |   3 +-
 tools/power/x86/turbostat/turbostat.c              | 101 ++++++++++++++-------
 tools/power/x86/x86_energy_perf_policy/Makefile    |   3 +-
 .../x86_energy_perf_policy.8                       |   2 +-
 .../x86_energy_perf_policy.c                       |  28 +++---
 5 files changed, 90 insertions(+), 47 deletions(-)
