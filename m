Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA224DF24
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgHUSMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 14:12:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46786 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUSMo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:12:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id v13so2252466oiv.13;
        Fri, 21 Aug 2020 11:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4fRLhlLaF1BRs42dZn3SS3uUZBKao5hBFOcfm7E01Do=;
        b=m1UlCExyjgZM1WK9E7SrvYf+qCinnMtm2up6ssE6TIyfMKTU2EGClsJ1yAePFCXB0O
         Km/efFrvZyndAKZyq/J8tjzRZzMJ+W8/98FP2be/QLVhsSLa78blowXYwhF3nrFoqyTb
         QLpJVCKb8UsMkKd+YB+S4OF25hNVbHm5EO/CAHK4IcIZPVDWjOWPRBAGaxu2AJnP9Cq1
         LyYvPrFYvKpyE/oRysXNDcTy5XGyyP5u7y92idf10vY2B1MIsSh/RaWj/Fui3F/jdhWW
         /5fHUZnbKb36GwfDTFktRrPDTWetqYyPz17w9HfsE+Zarj6gbDvWMP7waiRWGUSBi2J2
         w2qA==
X-Gm-Message-State: AOAM533FNYqn8OgaFHM+RY2gLW3hyWGGLBokQXNBugO2J2QXpaC2Vh9S
        e0SKE76NzRfiE047YgzLv6r7px22/PbkvZXaL+iH3L9hotI=
X-Google-Smtp-Source: ABdhPJz7XhbTXhP0vSLmrKIAcTR4mnXD7awwk8eiby2xKvqRc1Iy3Z7m7qxHRq1ORUYzeZjINnniHdv0eex7T9SULVQ=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr2659047oiy.103.1598033563881;
 Fri, 21 Aug 2020 11:12:43 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Aug 2020 20:12:33 +0200
Message-ID: <CAJZ5v0hVw_1b_hf7UWv06ipusZ=xs-0Lhi-a0npqU8Uua26FPQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.9-rc2

with top-most commit cc15fd9892e28689b6e17dbd6e28d00c55d62928

 Merge branch 'opp/fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5

 Linux 5.9-rc1

to receive power management fixes for 5.9-rc2.

These fix a few issues in the operating performance points (OPP)
framework.

Specifics:

 - Fix re-enabling of resources in dev_pm_opp_set_rate() (Rajendra
   Nayak).

 - Fix OPP table reference counting in error paths (Stephen Boyd).

Thanks!


---------------

Rajendra Nayak (1):
      opp: Enable resources again if they were disabled earlier

Stephen Boyd (2):
      opp: Put opp table in dev_pm_opp_set_rate() for empty tables
      opp: Put opp table in dev_pm_opp_set_rate() if _set_opp_bw() fails

---------------

 drivers/opp/core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)
