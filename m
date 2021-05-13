Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43737FDD5
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 21:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhEMTJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 15:09:55 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41624 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEMTJy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 15:09:54 -0400
Received: by mail-ot1-f49.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so18177389oth.8;
        Thu, 13 May 2021 12:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ePZHFJCtmrVsjp+9/OV7g2oHOPLo7h9AjfdleZwyfFg=;
        b=P1tODqexCqjUSn41N3dRElvpZpvzh8B6b60Cs1NkEnqm1Fxj/EM7gxB3JB+QWZsmLV
         BxX7CmHZKoLsNVlsXbHw4oRpHz6FCEQNPQ1DOxL0UoJEtLjvhRsT9fze6M3KC9oHNu9E
         5BmiHDryRmMpPVon5l90Sncabx4QDgA6Sz0g5e1riannyayQOf43c/MCydcQABuGxW/B
         WSIVrQb8hXFcmrB20gvfYWMqyc59fd25WEiYJLpBxjt4H/B/dzp9CWnaSTL+cvi8xkPC
         vVlhwIO+fnW3GQ/CVuJl6T59oWYOZ17ULTuPS6MLKJ1G15Ce8NzgIT1uvLQWhY15PM8o
         m1IQ==
X-Gm-Message-State: AOAM530y+klRRfpJjAXjArpOhue1ByjnE1lWhTCPhrn4/kpyuNVjmqnl
        qeUfIOEnHkEdCfI7WSjj3ZtAnHb1xv+hHWxZwAY=
X-Google-Smtp-Source: ABdhPJwIeXyLMQibWuoZG2P169Fgm4vn4LvXQrwqNl1ZKXipmxPbHgaNJvZ0dO2e9BBdmHub3cb/oXGAKQTm9XM++nk=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr36348182otb.260.1620932924257;
 Thu, 13 May 2021 12:08:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 May 2021 21:08:33 +0200
Message-ID: <CAJZ5v0i+NXd-toRCSsv89zTNq3+T7v6CCy2D8Y2qE=5wMMP4dA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.13-rc2
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
 pm-5.13-rc2

with top-most commit 78a6948bbadd0da46d318f3b7a954a71e02c39f7

 Merge branch 'pm-core'

on top of commit 6efb943b8616ec53a5e444193dccf1af9ad627b5

 Linux 5.13-rc1

to receive power management fixes for 5.13-rc2.

These close a coverage gap in the intel_pstate driver and fix
runtime PM child count imbalance related to interactions with
system-wide suspend.

Specifics:

 - Make intel_pstate work as expected on systems where the platform
   firmware enables HWP even though the HWP EPP support is not
   advertised (Rafael Wysocki).

 - Fix possible runtime PM child count imbalance that may
   occur if other runtime PM functions are called after invoking
   pm_runtime_force_suspend() and before pm_runtime_force_resume()
   is called (Tony Lindgren).

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Use HWP if enabled by platform firmware

Tony Lindgren (1):
      PM: runtime: Fix unpaired parent child_count for force_resume

---------------

 drivers/base/power/runtime.c   | 10 +++++++---
 drivers/cpufreq/intel_pstate.c | 14 +++++++++++++-
 include/linux/pm.h             |  1 +
 3 files changed, 21 insertions(+), 4 deletions(-)
