Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2194308A37
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jan 2021 17:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhA2Q2h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jan 2021 11:28:37 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37652 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhA2Q1F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2021 11:27:05 -0500
Received: by mail-oi1-f175.google.com with SMTP id a77so10449560oii.4;
        Fri, 29 Jan 2021 08:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Sw7St9UL1LkCIt1JZNpQeAAR+iljICDwa25aSYhSN3I=;
        b=NSI5hk7qzrOlYYa75Z0ZHY1bmDFqBnP2mJhqD9KmMNx5BJck7dsB3DlbGi1dh5YoVH
         rXDHFRCJ1xLv4f5Qtmd3ZZs3UBBNkJ/zrau8dv0hQy6MxhdcU4ii2+vqmC3JerwFFo1b
         DwvvrZJGdhZdIs4Q5MMApStTxMRTV5UePdM32N4fzYVGMaU2mjI+rJCRTHMLh39dS+kl
         OiCNqCCMaR7Xe03X49HFRf8Mdq47fi+NViSGaLRfXC3l5BbYpfWTjp8PDIamBRB2xyCg
         q/DKSuqs/2v1nLBFDBObxga2Q4zfScrJmt/ReyraHZ8cdOjUdvwTd7lRuXYntICNTgJw
         Mjpg==
X-Gm-Message-State: AOAM532wNyV6GZFNEGbQzcB3CJQTadQTgRu5nUTikPA9rNq0PhAknylX
        f30w05vmc1vSsD32zuJ9oFntD9LTgRhnIUIZ9KpN3pQEbqM=
X-Google-Smtp-Source: ABdhPJz1rTcBvpsjwSKMD3OcbA5+wsLMX9EE2+NVPpGcdxNsXLoT7awBV2M0pvrjHAeRc2RczeYUdka8El1I1NKHFk0=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr3129718oii.71.1611937575270;
 Fri, 29 Jan 2021 08:26:15 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Jan 2021 17:26:04 +0100
Message-ID: <CAJZ5v0ip25AwMxWuwQMTbqQ3BSKoqLazh-Eso5SqNrHyjP3bHw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.11-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.11-rc6

with top-most commit fef9c8d28e28a808274a18fbd8cc2685817fd62a

 PM: hibernate: flush swap writer after marking

on top of commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04

 Linux 5.11-rc5

to receive power management fixes for 5.11-rc6.

These fix a deadlock in the "kexec jump" code and address a possible
hibernation image creation issue.

Specifics:

 - Fix a deadlock caused by attempting to acquire the same mutex
   twice in a row in the "kexec jump" code (Baoquan He).

 - Modify the hibernation image saving code to flush the unwritten
   data to the swap storage later so as to avoid failing to write the
   image signature which is possible in some cases (Laurent Badel).

Thanks!


---------------

Baoquan He (1):
      kernel: kexec: remove the lock operation of system_transition_mutex

Laurent Badel (1):
      PM: hibernate: flush swap writer after marking

---------------

 kernel/kexec_core.c | 2 --
 kernel/power/swap.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)
