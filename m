Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843603F34B1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 21:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhHTTfk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 20 Aug 2021 15:35:40 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45762 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhHTTfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 15:35:38 -0400
Received: by mail-ot1-f44.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso16249146oth.12;
        Fri, 20 Aug 2021 12:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=UhhdjSVB/AbbZ0MLULfGdhAskZ9J1ly9WiPjDdOzwC4=;
        b=YTD+F83E6UIKdPiFr3FcsUOQ+sLdOy+V0Ny7AEER+bHnKCVi7GlgYDaYe/Ajsvqgin
         zdbrK8+z9LX+LCowx0E+Ksc/1ZTMJNMeLpfBXo4t8hDx/0Vq0fRfyM3HrgNNmeHWoGd5
         bxr1a9FXMu2Wv3je/1znTgB7JkPyoYThH3oFiV01LLD5TKeBrRZDyZriQOLHYdTvDz/E
         /R4QVWDbHPyuaqKkrbfB+Z/et6xq4rz/BN5n8C5il30JaOPBlGfS9yvWBBER6bXoYswQ
         hYmiyqsJ13RgZjyXbe//O3F+GKn3rTAmkwd+PufdS+WCuBIekKOePlf7vw3yqhx6t2Bu
         TDAg==
X-Gm-Message-State: AOAM5300MRqLxhvog4pYORP6iH0e30T3TL05pF8okrMB39rbRg3K4Cky
        UE1UOJSRR37XS/ZADXSxPJ2pVolZRgfsni9kLvKQDwqUzZFqvQ==
X-Google-Smtp-Source: ABdhPJzvwKhSjGFsvgjSHHxLsEY+O3hKaLvTv6ew8y8HgOE2xJjATeGRRUvBVeC51PeInGvRazFmUQJqDaQWmqkeHAI=
X-Received: by 2002:a05:6830:1f59:: with SMTP id u25mr18642775oth.321.1629488099804;
 Fri, 20 Aug 2021 12:34:59 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Aug 2021 21:34:48 +0200
Message-ID: <CAJZ5v0j7hmSZObB5Aptr=9z4LbbazwzWy7UK6KCjSp_1C8QCOQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.14-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.14-rc7

with top-most commit f2963c7ec7cc337ca286271f3111b1ed3ad5f023

 Merge branch 'pm-opp'

on top of commit 7c60610d476766e128cc4284bb6349732cbd6606

 Linux 5.14-rc6

to receive power management fixes for 5.14-rc7.

These fix some issues in the ARM cpufreq drivers and in the
operating performance points (OPP) framework.

Specifics:

 - Fix unuseful WARN() in the OPP core and prevent a noisy warning
   from being printed by OPP _put functions (Dmitry Osipenko).

 - Fix error path when allocation failed in the arm_scmi cpufreq
   driver (Lukasz Luba).

 - Blacklist Qualcomm sc8180x and Qualcomm sm8150 in
   cpufreq-dt-platdev (Bjorn Andersson, Thara Gopinath).

 - Forbid cpufreq for 1.2 GHz variant in the armada-37xx cpufreq
   driver (Marek Behún).

Thanks!


---------------

Bjorn Andersson (1):
      cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev

Dmitry Osipenko (1):
      opp: Drop empty-table checks from _put functions

Lukasz Luba (1):
      cpufreq: arm_scmi: Fix error path when allocation failed

Marek Behún (1):
      cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant

Michał Mirosław (1):
      opp: remove WARN when no valid OPPs remain

Thara Gopinath (1):
      cpufreq: blocklist Qualcomm sm8150 in cpufreq-dt-platdev

---------------

 drivers/cpufreq/armada-37xx-cpufreq.c |  6 +++++-
 drivers/cpufreq/cpufreq-dt-platdev.c  |  2 ++
 drivers/cpufreq/scmi-cpufreq.c        |  2 +-
 drivers/opp/core.c                    | 15 ---------------
 drivers/opp/of.c                      |  5 +++--
 5 files changed, 11 insertions(+), 19 deletions(-)
