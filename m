Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC22229EE
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgGPR3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 13:29:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44916 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPR3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 13:29:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id 5so4799659oty.11;
        Thu, 16 Jul 2020 10:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hLRAAQw1hek9rcC0v4IQJbEXFqIYwef7riqylhpqMJ8=;
        b=shSPQIQ7V3HIrVMpDkOpCgrSkqoGSbj3UJVoze7Gnf6xPlUURVokKhs/cLxOhuKCvL
         6CGOHrTTfQ97JyHGK0d7ydgwCVi2lASPKkX6ApU7HD59HQNDW9EPjwN+WxMl+tQdGTPX
         qFMDnyb4L19sElmw7GG+GQfPcqdcw1S2j155B9behBbFkAtQfJ7LoyYYlPr66vPac25e
         SY4lXSn2ARosjvlaruiWOUz6WBhQPp1DrslD5Dbt0xeV6lvDMK9TgDr3phFJuzA9OJ08
         YKeIQM+Lgnd2ler3y0VFUv0rjEn56iZficzMgvPLI+Ysn3LjS8cv34Xu8nwdrx2tjPiC
         XFHw==
X-Gm-Message-State: AOAM532r+8IXUcOThNYTcvMYCR3ubOhORiV8aNALSYDcxQo8sbMKuEc5
        FWysIkOLtuvFnJA8QZleYAQKlQKl2IBXlFS1rN4DSFuH
X-Google-Smtp-Source: ABdhPJzOuAyn47IyH1V7aliQDZH8xprkbSFsARvbPH6K9CqdtEbyhqFvgPUADgSgMenaYoFyQ+TWa5vd0l7p6vA6/ts=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr5299455ots.118.1594920575691;
 Thu, 16 Jul 2020 10:29:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jul 2020 19:29:23 +0200
Message-ID: <CAJZ5v0iikebC7mujzog-Vge8=OhrZwQU0ii2FMZO215NfBpvhA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.8-rc6
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
 pm-5.8-rc6

with top-most commit 1740f21af58b89a072f33ae0912d5acf95314f22

 Merge branch 'pm-cpufreq'

on top of commit 11ba468877bb23f28956a35e896356252d63c983

 Linux 5.8-rc5

to receive power management fixes for 5.8-rc6.

These add missing handling of a command line switch to the
intel_pstate driver (Rafael Wysocki) and fix the freeing of the
operating performance point (OPP) entries for the legacy (v1) OPP
table type (Walter Lozano).

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Fix active mode setting from command line

Walter Lozano (1):
      opp: Increase parsed_static_opps in _of_add_opp_table_v1()

---------------

 drivers/cpufreq/intel_pstate.c | 8 ++++++--
 drivers/opp/of.c               | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)
