Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F84386DE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFGJQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 05:16:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40903 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGJQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 05:16:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id x24so1206073otp.7;
        Fri, 07 Jun 2019 02:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z/VYg0Jx14XcKn6GQFFqLz5S19Toc5HM7cATHCyy104=;
        b=rcTSnXCI+tvc+yiagpt8raOPuUjFKyKNp2izdocySObuQBILx3p9Kx4TeVhPKe+Vj+
         O2jbALErPK+UfZbztSH5F/mPKAH0CWAfQkJ9zgvp0GTQ2xnDqKgnQ+TKpzgZzk6Y/ho9
         ta+im7zPJxzDLlAWKeeiNT5ooENaYeHtsG/QZeLxOFCQEnSyO3o0fBQLBz95QJAKbbCl
         bqXJ/clTLlB1u4EFW4Dw0utrDJjTkI7Cg0QEGGc/Il8hyWY0RU2R40aRuR0ocybVouop
         8TptuTOi3jr9N/l1/Dqbs3ydR0/HcF9czWxicdv6jA2dTuAIt4JvttbeWy2Ph4MEd6XA
         lLog==
X-Gm-Message-State: APjAAAUBgW5g3XD+95lWIScSekvMfl66lFn4e+FVO1xAJ6B/kSo7ChLm
        9G5YSR0kycIjHrfPXWw2vj+TAgrMmJmMde8gyO+VMiAR
X-Google-Smtp-Source: APXvYqz/OuGDfIIjMm5pVYW8fqWUYHuitYacU1Qucnci1GMGPCKzrr43fqBuch3oQA7QikjAxUW7yg/LbrurDnZamWA=
X-Received: by 2002:a9d:6414:: with SMTP id h20mr5568395otl.118.1559898960631;
 Fri, 07 Jun 2019 02:16:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Jun 2019 11:15:49 +0200
Message-ID: <CAJZ5v0gsNdzUMQuWmaTi8fFub0=AL3-7iPq93AVMyFB1yzkmcA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.2-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.2-rc4

with top-most commit a964d23c94e8177c501fc9a37dcf1f0dd2750527

 Merge branch 'pm-x86'

on top of commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a

 Linux 5.2-rc3

to receive power management fixes for 5.2-rc4.

These fix a crash during resume from hibernation introduced during
the 4.19 cycle, cause the new Performance and Energy Bias Hint (EPB)
code to be built only if CONFIG_PM is set and add a few missing
kerneldoc comments.

Specifics:

 - Fix a crash that occurs when a kernel with 'nosmt' in the command
   line is used to resume the system from hibernation (as the "restore"
   kernel), because memory mapping differences between the restore and
   image kernels cause SMT siblings to be woken up from idle states
   and subsequently they try to fetch instructions from incorrect
   memory locations (Jiri Kosina).

 - Cause the new Performance and Energy Bias Hint (EPB) code to be
   built only if CONFIG_PM is set, because that code is not really
   necessary otherwise (Rafael Wysocki).

 - Add kerneldoc comments to documents some helper functions related
   to system-wide suspend to avoid possible confusion regarding their
   purpose (Rafael Wysocki).

Thanks!


---------------

Jiri Kosina (1):
      x86/power: Fix 'nosmt' vs hibernation triple fault during resume

Rafael J. Wysocki (2):
      x86: intel_epb: Do not build when CONFIG_PM is unset
      PM: sleep: Add kerneldoc comments to some functions

---------------

 arch/x86/kernel/cpu/Makefile    |  5 ++++-
 arch/x86/kernel/cpu/intel_epb.c | 22 +---------------------
 arch/x86/power/cpu.c            | 10 ++++++++++
 arch/x86/power/hibernate.c      | 33 +++++++++++++++++++++++++++++++++
 include/linux/cpu.h             |  4 ++++
 include/linux/suspend.h         | 31 +++++++++++++++++++++++++++++++
 kernel/cpu.c                    |  4 ++--
 kernel/power/hibernate.c        |  9 +++++++++
 kernel/power/suspend.c          |  6 ++++++
 9 files changed, 100 insertions(+), 24 deletions(-)
