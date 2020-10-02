Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF128183E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbgJBQrS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 12:47:18 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:32835 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgJBQrR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 12:47:17 -0400
Received: by mail-oo1-f67.google.com with SMTP id m25so500095oou.0;
        Fri, 02 Oct 2020 09:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9RK7VejWgItG0CTHowBvgms6hSYrpd2XFIs5Wdvgz48=;
        b=X8+z9HuSIrmjD2fDSzwwILD09eamC88GXBgXiB0sTSsZYKyUQxIERbGVwLNg+DQ25g
         KM7WtO2qAB28SXnIvGgn+o+0TsLco3Ccm5O/EKYjisbQdt/MstTtwSK4nF8/19fpnZmO
         wxGWwzo3ozgjl0zlWeOFQd38AB8WUqJR/up40jLRMYB1ZH+yKAGLsmOIbBI6blb7GY33
         EB42TA7MqOW9NNGaMOWcP7gjBuuLff1waBQ7RSoHaTYJJlxoiApNQXS1Q1Ex3xXFI2ws
         HiUL3hlVaT+HpDqe7JMmoBur4ahKmmLgKjpev+uXeAQOtp687qcuOvTF5F2r3ASlS15R
         LdRw==
X-Gm-Message-State: AOAM533ckPCW5RNQ8w7DOFegmAHJn66OC8xcbrX9vT6/s12Vfba7+EBW
        H0aERDK25TglPMKFBRpXpy5CGjnaJ667JTM8tH7QaE34slY=
X-Google-Smtp-Source: ABdhPJxLeAUmx01jVxMKnoqCSGd/TQIbdKVlvHV2UFONW3hTLdZVb4Pd12LYsXyfQmAApb5FBJKD5I9g4TtcC4eKlwA=
X-Received: by 2002:a4a:e946:: with SMTP id v6mr2561193ood.38.1601657236708;
 Fri, 02 Oct 2020 09:47:16 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 18:47:05 +0200
Message-ID: <CAJZ5v0jppvMLqbSu20gx6dL=bZWv6_ZbDRYW6Djg3V1oTJyWAA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.9-rc8
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
 pm-5.9-rc8

with top-most commit 7bbe8f2a7e7e819c050212a4bc984f03dc85af9d

 Merge branch 'pm-cpufreq'

on top of commit a1b8638ba1320e6684aa98233c15255eb803fac7

 Linux 5.9-rc7

to receive power management fixes for 5.9-rc8.

These fix one more issue related to the recent RCU-lockdep
changes, a typo in documentation and add a missing return
statement to intel_pstate.

Specifics:

 - Fix up RCU usage for cpuidle on the ARM imx6q platform (Ulf
   Hansson).

 - Fix typo in the PM documentation (Yoann Congal).

 - Add return statement that is missing after recent changes
   in the intel_pstate driver (Zhang Rui).

Thanks!


---------------

Ulf Hansson (1):
      ARM: imx6q: Fixup RCU usage for cpuidle

Yoann Congal (1):
      Documentation: PM: Fix a reStructuredText syntax error

Zhang Rui (1):
      cpufreq: intel_pstate: Fix missing return statement

---------------

 Documentation/admin-guide/pm/cpuidle.rst | 2 +-
 arch/arm/mach-imx/cpuidle-imx6q.c        | 4 +++-
 drivers/cpufreq/intel_pstate.c           | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
