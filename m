Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E25244E5B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHNSIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 14:08:36 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:38896 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNSIg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 14:08:36 -0400
Received: by mail-oo1-f65.google.com with SMTP id z11so2097859oon.5;
        Fri, 14 Aug 2020 11:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=emIdfFsixl10m0M5c840U75hx82p0eU8c30F0GRjyEs=;
        b=G8rQbKMNESZv3A0bItNXTG1sGgezFvNE1i8SrawBID6lUYFSyg4d/WZfUAVU+yXKcL
         cWGTteMXBotRm+PmpOMCdh88uahQOJ2SpnHDbacgWk9u4udoSfNebRUszM4cKRBK7glt
         zcawF1YiYgABAp6hSq0Zz09zJ85nrhZmUzGtZ74G0Wi4Pi3d65kj5Q2zRbr8jZPsFqF/
         gMeryverEF5301AfMXPxdqg5be9zfdxhE++ne9uRcbYmCpcBh0S9UJlhS3t09SaKkNoG
         0pAp4PMsj9yIXYHqZgQ4IZhdNvrXMqVcCUn3uXixKLg11r0yEILWRYAdrsvKvEYeBlcR
         7M6Q==
X-Gm-Message-State: AOAM530GgKnobSrPz6bCUVPSF//c8uCV8oqzS6UuoJKtLBniyH4tzlVX
        1Y7N6sIk8jTcG1qxrzv+20E2TGFLq5HCg3lghxezrepVQQ4=
X-Google-Smtp-Source: ABdhPJzKc++kR41IO5hzPDOT+ysOunMaS02XKpKOdv59xPu4JCqos/htNCsvhhXnfJVLIodkSJr0Ys+lGfP7zM2y9vE=
X-Received: by 2002:a4a:e618:: with SMTP id f24mr2549592oot.75.1597428515436;
 Fri, 14 Aug 2020 11:08:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 20:08:24 +0200
Message-ID: <CAJZ5v0g42_UymEznQCjyaQMaDbO5txyDncAaGXogpSA9R8MZwQ@mail.gmail.com>
Subject: [GIT PULL] One more power management update for v5.9-rc1
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
 pm-5.9-rc1-3

with top-most commit f3db6de55e95eee6457a14912dd382a6cfc98edd

 Merge branch 'pm-cpufreq'

on top of commit f6235eb189706bf38c82b5fa5f2db0d21bc1dcef

 Merge tag 'pm-5.9-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive one more power management update for 5.9-rc1.

This modifies the intel_pstate driver to allow it to work in the
passive mode with hardware-managed P-states (HWP) enabled.

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Implement passive mode with HWP enabled

---------------

 Documentation/admin-guide/pm/intel_pstate.rst |  89 +++++-----
 drivers/cpufreq/cpufreq.c                     |   6 +-
 drivers/cpufreq/intel_pstate.c                | 245 +++++++++++++++++++-------
 include/linux/cpufreq.h                       |   2 +
 4 files changed, 229 insertions(+), 113 deletions(-)
