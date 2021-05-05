Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDBE3732F5
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 02:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhEEALV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 20:11:21 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:35683 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEEALU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 20:11:20 -0400
Received: by mail-ej1-f44.google.com with SMTP id m12so157734eja.2;
        Tue, 04 May 2021 17:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aToIgNR6y7JgO+maz4yecvlBzkOZHi81W8xBubpDptw=;
        b=nxzrw3w0r7D08P/umVOvlayqFoQKgbKRYHC8cfw6N1nrK9J9xeAJNSIUMyA5kOmrlR
         /eCjFNuSHTqvxEEG0vor6Pbux1UjG/9QqppsoP3zV5bXt77OkdQ2e2JX6WC0BKc3C83i
         42/SCHCufbhqzaVprT4N8jHgo8UBXjtD1GWDYrcv3UBVik5rb5YhBY3M2Yr2Czo0cQ9j
         s8WCAdAD80qk3tcRMlwluQGrF/BuUOAcGNuOEpPqV5l9kZFYtNuXyDa37Kj/vwUgcgC7
         Jl0TBQ5d/mZHd3J78WwMnbdJOe94x+Aadqun0VXOn6BOu55rUmvZKOaNuf6UhzJFo+iO
         sndw==
X-Gm-Message-State: AOAM5325T9EKkYYVVQfsTbNTR7giOFzpSvPZrmQd60TmWBJtEn6qhc41
        GDmRcjA8WAmrNt1yK26u+zVkW2BVTAVaUh7sa7QDLBQs
X-Google-Smtp-Source: ABdhPJw5cdLcfNNJPVq6mVSlE0z68+s+6AThMYH90e1+PWpF5NVWlygRULMU2sWgvjNP8G1LiOn21rvrI/7ywdH8vII=
X-Received: by 2002:a17:906:3098:: with SMTP id 24mr23835072ejv.507.1620173424329;
 Tue, 04 May 2021 17:10:24 -0700 (PDT)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 4 May 2021 20:10:13 -0400
Message-ID: <CAJvTdKk9rNJhy1Ddpq-mbMzG0bJ8N8TumPfWpv6DUBP4N9tUyQ@mail.gmail.com>
Subject: [GIT PULL] turbostat update
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull these turbostat patches -- bug fixes and a smattering of features.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 3c070b2abf85b92455c2721d0a9edc68893ab6c1:

  tools/power turbostat: version 2021.05.04 (2021-05-04 20:01:09 -0400)

----------------------------------------------------------------
Bas Nieuwenhuizen (1):
      tools/power/turbostat: Fix turbostat for AMD Zen CPUs

Calvin Walton (1):
      tools/power turbostat: Fix offset overflow issue in index converting

Chen Yu (5):
      tools/power turbostat: Support Alder Lake Mobile
      tools/power turbostat: Support Ice Lake D
      tools/power/turbostat: Remove Package C6 Retention on Ice Lake Server
      tools/power turbostat: Enable tsc_tweak for Elkhart Lake and Jasper Lake
      tools/power turbostat: Print the C-state Pre-wake settings

Len Brown (8):
      tools/power turbostat: add built-in-counter for IPC --
Instructions per Cycle
      tools/power turbostat: print microcode patch level
      Revert "tools/power turbostat: adjust for temperature offset"
      tools/power turbostat: update version number
      tools/power turbostat: formatting
      tools/power turbostat: elevate priority of interval mode
      tools/power turbostat: Support "turbostat --hide idle"
      tools/power turbostat: version 2021.05.04

Randy Dunlap (1):
      tools/power turbostat: unmark non-kernel-doc comment

Zhang Rui (5):
      tools/power turbostat: Fix DRAM Energy Unit on SKX
      tools/power turbostat: Fix Core C6 residency on Atom CPUs
      tools/power turbostat: save original CPU model
      tools/power turbostat: add TCC Offset support
      tools/power turbostat: rename tcc variables

 tools/power/x86/turbostat/turbostat.8 |    6 +-
 tools/power/x86/turbostat/turbostat.c | 1316 +++++++++++++++++++--------------
 2 files changed, 773 insertions(+), 549 deletions(-)
