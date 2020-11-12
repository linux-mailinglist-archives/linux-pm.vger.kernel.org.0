Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577342B093A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgKLP7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 10:59:07 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:37188 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgKLP7H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 10:59:07 -0500
Received: by mail-oo1-f68.google.com with SMTP id t10so1421142oon.4;
        Thu, 12 Nov 2020 07:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DNxWM/BVH5fGeTzA5yC/21tIQu3wig2OXKcKsexOcPM=;
        b=LX9RGWSrjOnvA2vieWb8n1O3lSqFf8rTD8lQtImO/ZMynrChlrH65lqsGepQJi0MYR
         5kDoOZBteagFCgs5TAd0bMovBqGVOllGm3LH2rRIUF8k2yYuFFPLrEfAxtkFjtWqOujx
         SwZQqi0JWQwIsPbxKo5beh1fETRYUTz+TRWY4BWdYyjdxJN1juwfkx1aagYDg0BZZIQJ
         bHRFXZCQ/ArNFljy0T03zl/bAQlwjGmIzx1zpjVgrkRsiAc5Foe/T0UdcCSLluhIvgbh
         DCJ8aSuQ2eWCP+05UbUWmXtGJKAVE4ar+/RTiW5CyaSKyWiHTh6kXLrB0ZjRhJRYZ5jm
         4g7Q==
X-Gm-Message-State: AOAM531kclOu600uj1mKpflTctna4NBHFmHIvwr3mxdoC4my2myoaBbK
        vMMLhcdQI4zQTOOYjIg2M1VYgQvCIBisC9VWyx5HV+c7WSI=
X-Google-Smtp-Source: ABdhPJxXTS9+lCz5yjnp66fQrgsPqCQgz2dEWI6XQF/I71Pth/I75Etbkbiprv1EnxABrXDlmqvWeYLSWd7jmwNf48o=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr21288472oob.1.1605196746342;
 Thu, 12 Nov 2020 07:59:06 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Nov 2020 16:58:55 +0100
Message-ID: <CAJZ5v0iypErbx8R-0wOnBOK=BNsY0HCNK13BEkdUoxsXJQ1K3g@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.10-rc4
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
 pm-5.10-rc4

with top-most commit fcb3a1ab79904d54499db77017793ccca665eb7e

 cpufreq: intel_pstate: Take CPUFREQ_GOV_STRICT_TARGET into account

on top of commit f8394f232b1eab649ce2df5c5f15b0e528c92091

 Linux 5.10-rc3

to receive power management fixes for 5.10-rc4.

These make the intel_pstate driver behave as expected when it
operates in the passive mode with HWP enabled and the "powersave"
governor on top of it.

Thanks!


---------------

Rafael J. Wysocki (4):
      cpufreq: Introduce governor flags
      cpufreq: Introduce CPUFREQ_GOV_STRICT_TARGET
      cpufreq: Add strict_target to struct cpufreq_policy
      cpufreq: intel_pstate: Take CPUFREQ_GOV_STRICT_TARGET into account

---------------

 drivers/cpufreq/cpufreq.c             |  4 +++-
 drivers/cpufreq/cpufreq_governor.h    |  2 +-
 drivers/cpufreq/cpufreq_performance.c |  1 +
 drivers/cpufreq/cpufreq_powersave.c   |  1 +
 drivers/cpufreq/intel_pstate.c        | 16 +++++++++-------
 include/linux/cpufreq.h               | 18 ++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c      |  2 +-
 7 files changed, 32 insertions(+), 12 deletions(-)
