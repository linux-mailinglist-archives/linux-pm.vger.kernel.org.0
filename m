Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4405D32F123
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCER1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 12:27:10 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44252 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCER0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 12:26:48 -0500
Received: by mail-oi1-f180.google.com with SMTP id x20so3279475oie.11;
        Fri, 05 Mar 2021 09:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qiq2wjeDzmlX8X0mPNtwJVLyr9wjO06RgkE08BY1C/o=;
        b=KtCNe5HmJfONdYQVBUplDKuefQbXVrR0d5H9ulyna5/b33mj5v9nFRxJVBKiiQagVH
         r99yfUiQqe1ugRQD7VjSdJmgFyWbvONaLDmx46HzGfLFx95FAnlq5XZTyUtRbYFpyzbS
         Lsw6DRLn/Sxa75QX28R5WOw3xZHrfrqINX3aIq5/bbYir0FoBIFMQaXmsbxzYTdiyQ6Y
         zk6JCnbpQPkjSsEV2Guy1Z/BnbYDIMzA/k5Pmo3rrLuJLlYF4V7/TDq9+Jzvu5JtBvMm
         zywXmiDrimognxa1NAFD54hOKWvtv+LY0PrCFUBDYL6avbfyZKDYNGuSnhWiyGbKxtrT
         zePA==
X-Gm-Message-State: AOAM531hQcA9IoWGrg1WrLa2/FbekwyjN1M0Rf2GGmoFlt1wvsCV4Bnx
        n2O059jTV2X+UTv02ZIjjMDwoFrq+YXPq+I2NDw=
X-Google-Smtp-Source: ABdhPJxjKeTcVEQbd8EU+/eWnLHq6u72U9YWLLCI2j0gALTIxKfb4DnPLpgbA14XHB/e2p9y/JNtq3ef5Fiy4L1Enbo=
X-Received: by 2002:aca:f245:: with SMTP id q66mr7700002oih.69.1614965207796;
 Fri, 05 Mar 2021 09:26:47 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 18:26:37 +0100
Message-ID: <CAJZ5v0jrtn6cbeQ9rgqmeiV_rAc_GB+rRT6qjtwbmgcCFPg-Qg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.12-rc2
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
 pm-5.12-rc2

with top-most commit 7bff4c26b6d2c82bebf8630f31b1cca11b1bd562

 Merge branch 'powercap'

on top of commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8

 Linux 5.12-rc1

to receive power management fixes for 5.12-rc2.

These fix the usage of device links in the runtime PM core
code and update the DTPM (Dynamic Thermal Power Management)
feature added recently.

Specifics:

 - Make the runtime PM core code avoid attempting to suspend
   supplier devices before updating the PM-runtime status of
   a consumer to "suspended" (Rafael Wysocki).

 - Fix DTPM (Dynamic Thermal Power Management) root node
   initialization and label that feature as EXPERIMENTAL in
   Kconfig (Daniel Lezcano).

Thanks!


---------------

Daniel Lezcano (2):
      powercap/drivers/dtpm: Fix root node initialization
      powercap/drivers/dtpm: Add the experimental label to the option
description

Rafael J. Wysocki (1):
      PM: runtime: Update device status before letting suppliers suspend

---------------

 drivers/base/power/runtime.c | 62 ++++++++++++++++++++++++++------------------
 drivers/powercap/Kconfig     |  2 +-
 drivers/powercap/dtpm.c      |  3 +++
 3 files changed, 41 insertions(+), 26 deletions(-)
