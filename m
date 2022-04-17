Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812D5504645
	for <lists+linux-pm@lfdr.de>; Sun, 17 Apr 2022 06:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiDQEXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Apr 2022 00:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiDQEXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Apr 2022 00:23:35 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4719C10
        for <linux-pm@vger.kernel.org>; Sat, 16 Apr 2022 21:21:01 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u19so19777526lff.4
        for <linux-pm@vger.kernel.org>; Sat, 16 Apr 2022 21:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AFNdvypbywU08KQkQwFTqfJBBfNeN7zJXlGfInkNW2A=;
        b=T2OQEfRIwuSM/aueUhCxqJH1+PSdDdgCygOs4nbQ2EKrjIAH755fAMVqNVSIxexM8v
         /WvEfKVbaqK0pY6/8eLO8VvQmPQutVUzax9yvHAPOQ453sNK/R9vytv2CvjvIJsZFSZW
         8FeNai52f7Bhuz7ELvS/A4IjeulieNZY0qxYjQC9/XJ16AyD24otgWB/Dy6/DUnx5a4I
         xoLn65LqEdF+POQyfeMw4lOBZGFpKqbeUfVoNUdvl5zhj5R99RuqDwfFwn0q/m0Fxe/V
         799mB/mMRWqdvfgwYjJB0xI2o3oB8Dd0BU/BNHIFUd855zc9/h3wkmRQcIk9jB9BZ5WC
         jCng==
X-Gm-Message-State: AOAM5314h78fneUSgndKzwVYpEvBup5dinyvxJYa4vYq68Vc8pa0TUE6
        jcqPnM3oxF/SoX4M3pO1fmbC/+D58s8sk9xuu19I6cuWEtM=
X-Google-Smtp-Source: ABdhPJyELTQ1+XdqnbIXOkAuO0Ig74ETBCdrmuW49IJcuguHoYL7+H5VRdsJWACt72XNsxt2taEpGBNPuwW09X2FRSE=
X-Received: by 2002:a05:6512:4c7:b0:46d:3cf0:4346 with SMTP id
 w7-20020a05651204c700b0046d3cf04346mr4140998lfq.216.1650169259758; Sat, 16
 Apr 2022 21:20:59 -0700 (PDT)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Sun, 17 Apr 2022 00:20:48 -0400
Message-ID: <CAJvTdKm=LUqHRHZ6DwvEEK-3ReOhJF7h+NLRKP7+Lqfb=dAXyg@mail.gmail.com>
Subject: [GIT PULL] turbosat 2022.04.16
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Please pull these turbostat patches to sync upstream with turbostat 2022.04.06.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit f443e374ae131c168a065ea1748feac6b2e76613:

  Linux 5.17 (2022-03-20 13:14:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 58990892ca29c310eca7df1d39d3dbc1b18c2d0e:

  tools/power turbostat: version 2022.04.16 (2022-04-17 00:05:25 -0400)

----------------------------------------------------------------
Chen Yu (1):
      tools/power turbostat: Support thermal throttle count print

Dan Merillat (1):
      tools/power turbostat: fix dump for AMD cpus

Len Brown (5):
      tools/power turbostat: tweak --show and --hide capability
      tools/power turbostat: fix ICX DRAM power numbers
      tools/power turbostat: be more useful as non-root
      tools/power turbostat: No build warnings with -Wextra
      tools/power turbostat: version 2022.04.16

Sumeet Pawnikar (2):
      tools/power turbostat: Add Power Limit4 support
      tools/power turbostat: print power values upto three decimal

Zephaniah E. Loss-Cutler-Hull (2):
      tools/power turbostat: Allow -e for all names.
      tools/power turbostat: Allow printing header every N iterations

 arch/x86/include/asm/msr-index.h      |   1 +
 tools/power/x86/turbostat/Makefile    |   2 +-
 tools/power/x86/turbostat/turbostat.8 |   2 +-
 tools/power/x86/turbostat/turbostat.c | 594 ++++++++++++++++++++++------------
 4 files changed, 389 insertions(+), 210 deletions(-)
