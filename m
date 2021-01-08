Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84A22EF6C9
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbhAHRw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 12:52:58 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:45985 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAHRw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 12:52:58 -0500
Received: by mail-oo1-f42.google.com with SMTP id o5so2558874oop.12;
        Fri, 08 Jan 2021 09:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ez5mXhhTrzTdRQ9SbQCDV6+1CgYl+rx+hxup8pZc1AU=;
        b=Iic07sn0BLWO1V/JqKraltn8tyIVIAnKo1z7aiKIVs1W3wlaYPvLya563axhtGGJTd
         T/53pPXT2SrDHaDfpNjD1LvpcMIcY5KrhqhhLZkH2H9b0s9g5ZJIK67pFsvmJovZzKfk
         IZtls4Nujg1DXf/EK8HzeL3pzS/+OtG/2Xyla07gO8M1y7DDuQgu6C+HOQdQr21HtEMD
         PXIYrlohVSzJOgALsFIKsyQE/R1ZxZ3sYT0+OaTO1Hsm+CGcC7gI1UF0a//vaIHid/s+
         ryGwQNC+jPCtBZaffI2X7646THMGL6Rc6uHUHPPVYlACwn1RN17TBCs8mSeKqlQaCPHm
         /dHA==
X-Gm-Message-State: AOAM531lxgxDMja02AHHHl1zCqqUE1vEeMSWvQCiu3oZTmnUvn3YCACI
        cekD40J7coMAr/t9VgW5kDy2GJilMWaSEU2CyATg2hs9Z1E=
X-Google-Smtp-Source: ABdhPJyzCCynIGv7vELT97SoT0uCT1xcdnLE15cUwfeE2LYoor1FoU2TkGwj21l8qbAT3L+o+IsL+1V2oTDe9N1ivxA=
X-Received: by 2002:a4a:bf14:: with SMTP id r20mr5121391oop.2.1610128337586;
 Fri, 08 Jan 2021 09:52:17 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jan 2021 18:52:06 +0100
Message-ID: <CAJZ5v0iPXqB1zkrbORP+N-ZgLA_fSym7o1xbkBCt0=TTdu_hxg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.11-rc3
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
 pm-5.11-rc3

with top-most commit c4151604f0603d5700072183a05828ff87d764e4

 cpufreq: intel_pstate: remove obsolete functions

on top of commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62

 Linux 5.11-rc2

to receive power management fixes for 5.11-rc3.

These address two issues in the intel_pstate driver and one in the
powernow-k8 cpufreq driver.

Specifics:

 - Make the powernow-k8 cpufreq driver avoid calling cpufreq_cpu_get(),
   which theoretically may return NULL, to get a policy pointer that
   is known to it already (Colin Ian King).

 - Drop two functions that are not used any more from the intel_pstate
   driver (Lukas Bulwahn).

 - Make intel_pstate check the HWP capabilities to get the maximum
   available P-state in the passive mode to avoid using a stale value
   of it in case of out-of-band updates (Rafael Wysocki).

Thanks!


---------------

Colin Ian King (1):
      cpufreq: powernow-k8: pass policy rather than use cpufreq_cpu_get()

Lukas Bulwahn (1):
      cpufreq: intel_pstate: remove obsolete functions

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Use HWP capabilities in intel_cpufreq_adjust_perf()

---------------

 drivers/cpufreq/intel_pstate.c | 15 +++------------
 drivers/cpufreq/powernow-k8.c  |  9 +++------
 2 files changed, 6 insertions(+), 18 deletions(-)
