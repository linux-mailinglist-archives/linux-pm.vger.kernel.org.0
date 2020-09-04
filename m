Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6425E05C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIDQ4n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 12:56:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44374 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgIDQ4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2020 12:56:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id 185so7100044oie.11;
        Fri, 04 Sep 2020 09:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0OnOLgQZ8tGW5pvZnQaqqpzyoUrNxYixyMc2d9KfrvE=;
        b=Ip9KkCXgiGRfB7U4y6qXos7K4pwlUWzhhq7JozIu0mLTMwKEXdJJ02A2uRDUuIvDW6
         B5uIau3hFi2E54WjG2HGf7fmu3dJ0d9kdgGXqnVFo4lUkA23L7VfLHIpn8+LCB2fztj8
         MxGTHODDO1Hq/gcrzMdm2pZQlCV89j/UKqbM+EfXjxcmJ8EbH+6vlrZ0aPMz2zuqoNpo
         fRutS3VtV9nlLqUqZaQJxe8O/q1LgKcM0Hz2yXe+BVJbf8AypJuN2n+/rzH2M4SNyy2/
         N+vwTKPeT7b0KjD/LcyuQ7fEmDpDhaY7+ThiG3tNXaErdJpCycs1jgI0k/Bab/jr5/KT
         HVOQ==
X-Gm-Message-State: AOAM5327IttA952mOyaewbsyCCjz+kDyu/Xa8TqkgPBZArn7ChpR+8/v
        l8Ey2m7EX/mNOTMnu0SXpKcp/Z0OYkmqKrt4juTSe7HJUrU=
X-Google-Smtp-Source: ABdhPJytcyDbfXB9T2pVEm+7DStxnDAtXUf+pPAKELN19B+kSW4gQLlJ9ae0SP+RZj7jXZCzxg0IstSvIZ/oXSVeFyE=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr6199673oiy.103.1599238600800;
 Fri, 04 Sep 2020 09:56:40 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Sep 2020 18:56:29 +0200
Message-ID: <CAJZ5v0hTogaEjc9GAwBN15kgC5+aiRLSohn3DATr51BU9rwy6A@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.9-rc4
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
 pm-5.9-rc4

with top-most commit f7ce2c3afc938b7d743ee8e5563560c04e17d7be

 Merge branch 'pm-cpufreq'

on top of commit f75aef392f869018f78cfedf3c320a6b3fcfda6b

 Linux 5.9-rc3

to receive power management fixes for 5.9-rc4.

These fix reference counting in the operating performance points
(OPP) framework and address a few intel_pstate driver issues,
mostly related to switching driver operation modes and similar
with hardware-managed P-states (HWP) enabled.

Specifics:

 - Fix reference counting of operating performance points (OPP)
   tables (Viresh Kumar).

 - Address intel_pstate driver interface issues, mostly related
   to switching operation modes and handling CPU offline and
   online and system-wide suspend/resume with hardware-managed
   P-states (HWP) enabled (Rafael Wysocki).

 - Fix the maximum frequency computation in the intel_pstate driver
   with turbo P-states disabled by the platform firmware and HWP
   enabled (Francisco Jerez).

Thanks!


---------------

Francisco Jerez (1):
      cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for turbo disabled

Rafael J. Wysocki (5):
      cpufreq: intel_pstate: Refuse to turn off with HWP enabled
      cpufreq: intel_pstate: Update cached EPP in the active mode
      cpufreq: intel_pstate: Tweak the EPP sysfs interface
      cpufreq: intel_pstate: Add ->offline and ->online callbacks
      cpufreq: intel_pstate: Free memory only when turning off

Viresh Kumar (1):
      opp: Don't drop reference for an OPP table that was never parsed

---------------

 Documentation/admin-guide/pm/intel_pstate.rst |   4 +-
 drivers/cpufreq/intel_pstate.c                | 236 ++++++++++++++++----------
 drivers/opp/core.c                            |  22 ++-
 drivers/opp/opp.h                             |   2 +-
 4 files changed, 168 insertions(+), 96 deletions(-)
