Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2A34AC87
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 17:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZQac (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 12:30:32 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:40518 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZQaR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 12:30:17 -0400
Received: by mail-oo1-f50.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so1427244oot.7;
        Fri, 26 Mar 2021 09:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NtDVdASEeVccyeP21t4rip7g+soR+msTcoYUglm8fKQ=;
        b=B8zrZxKwlHHCp1E918tZHNJRlpzaGwKLJ0LowmdeOqT+SE/RqymCVqxyVUinw+S1Mc
         Ez3MkCavr31ee/37ibdM++N+YxrzKvppuTIAA9e/SP39yQsMwCU8vTw7sNhdx2yDKIWN
         4IKr/aZUcR6iN6TIkrH4nA/WVviDFA43A2BaE/6MjqjzyONiynmKv7++ngqvs2LS7pfy
         ysaOoQkwXfNC4WwGNjOsoi3sImLB+MLyVRfR5JV/0c1vloNFMtD/psGynRCOVTqdllrC
         EXMOTZUExp1TcZ3SfDRfVfhWmvfukWV4EqNNCjOY7I6dPx7NbNtmgJXeDOVuyzUVyFlT
         hQxw==
X-Gm-Message-State: AOAM533COpaXIC7a7/xSvM5h++d0e93n1oJwsy3YR8P+7JkfaZQ+STFV
        sEAwm0ls7blUwMiOHurOxDOJeq763pwUTd/0wMc6i9QPhFg=
X-Google-Smtp-Source: ABdhPJzSKbw8/fau8y46WDN1YW3hXukb1CI5t9h+r+Sw/jRNlkDbrJQxFAziVOS314u1mI2+TMLPgOjsooYvhhv8lMM=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr11898862oou.44.1616776216837;
 Fri, 26 Mar 2021 09:30:16 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Mar 2021 17:30:05 +0100
Message-ID: <CAJZ5v0j0Xx7_bYwCn3TL53j8ANKKFerhw_mT91=vYsGcDjS=_Q@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.12-rc5
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
 pm-5.12-rc5

with top-most commit 6f3a283c2f6bbbb5a9a6801a0befa61cb60195f1

 Merge branch 'pm-em'

on top of commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b

 Linux 5.12-rc4

to receive power management fixes for 5.12-rc5.

These fix an issue related to device links in the runtime PM
framework and debugfs usage in the Energy Model code.

Specifics:

 - Modify the runtime PM device suspend to avoid suspending
   supplier devices before the consumer device's status changes
   to RPM_SUSPENDED (Rafael Wysocki).

 - Change the Energy Model code to prevent it from attempting to
   create its main debugfs directory too early (Lukasz Luba).

Thanks!


---------------

Lukasz Luba (1):
      PM: EM: postpone creating the debugfs dir till fs_initcall

Rafael J. Wysocki (1):
      PM: runtime: Defer suspending suppliers

---------------

 drivers/base/power/runtime.c | 45 ++++++++++++++++++++++++++++++++++++++------
 kernel/power/energy_model.c  |  2 +-
 2 files changed, 40 insertions(+), 7 deletions(-)
