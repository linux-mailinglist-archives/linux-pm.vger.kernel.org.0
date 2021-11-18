Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A444563EA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 21:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhKRURm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 15:17:42 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42734 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhKRURm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 15:17:42 -0500
Received: by mail-oi1-f180.google.com with SMTP id n66so16745302oia.9;
        Thu, 18 Nov 2021 12:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Q4e3yXOc46SogxUy0h0v0wQNg6qfhEQqmGWpxzUVSNw=;
        b=ng+brzIK6IIR1VTWuVYUPWX0HQ3n1ur+cK+AmQ1GKyyQ2gmvZwM6GuUN5kbwhVhtOn
         9kBDn6VFPxhWjvR09EXZzziFBoEL6dvv65OOUktk8PrJF0zD6d2dHZNBZU55/fSZRVKX
         pYpFSLPbVoaDUlZ5r2zdkRLK8x9W9gUuEFR8ea1RN0xWr/K9WdBfK9vmZoLr0zR9Hn4a
         aoTsJB0cD0Lf8FCrRXtWDhxZFJgHtZaj7gAJLJzU2xKx4kDna2zAZVo/WPLNBDWvo6K0
         9Bl78oVlYQdAH1FOV+MA9lD5u4snuAabocCxDje5ysjsHcG/Gf6u90U3Bfy4Vj9DD2uz
         PoSg==
X-Gm-Message-State: AOAM533u5rwAi0ZCI5owRYYKKPht0Q4xMO5fRiUOhve0TOEAOXw/yTGM
        jqLc9VU8ZEKsZkw+4HMAf7HV33GTuRor92Zv3xNcdHLaJ80=
X-Google-Smtp-Source: ABdhPJxSo2GlEGN1Fu5NJaWRrpuJd2/xTgRMpfWUXuStT5Y4naVCNik4YeXQl0/vut+puotlnwxFwNBtGD63tRD+kfM=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr10212943oiw.154.1637266481443;
 Thu, 18 Nov 2021 12:14:41 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 21:14:30 +0100
Message-ID: <CAJZ5v0hWGX0txDBHfUMX=hgynrsyhp0T8NX-rY8YXdPbdZPKtA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.16-rc2
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
 pm-5.16-rc2

with top-most commit 47b577ae6fba635de1e5e042d425ebd0f9313111

 Merge branch 'powercap'

on top of commit 881007522c8fcc3785c75432dbb149ca1b78e106

 Merge tag 'thermal-5.16-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for 5.16-rc2.

These fix a system-wide suspend issue in the DTPM framework and
improve the Energy Model documentation.

Specifics:

 - Fix system suspend handling in DTPM when it is enabled, but not
   actually used (Daniel Lezcano).

 - Describe the new cpufreq callback for Energy Model registration
   and explain the "advanced" and "simple" EM variants in the EM
   documentation (Lukasz Luba).

Thanks!


---------------

Daniel Lezcano (1):
      powercap: DTPM: Fix suspend failure and kernel warning

Lukasz Luba (2):
      Documentation: power: Add description about new callback for EM
registration
      Documentation: power: Describe 'advanced' and 'simple' EM models

---------------

 Documentation/power/energy-model.rst | 53 ++++++++++++++++++++++++++----------
 drivers/powercap/dtpm_cpu.c          |  9 ++----
 2 files changed, 41 insertions(+), 21 deletions(-)
