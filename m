Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E772B9A98
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgKSS1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 13:27:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36872 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgKSS1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 13:27:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id j15so2064754oih.4;
        Thu, 19 Nov 2020 10:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JamelLsbVORyJN0XzcrjAbAeKUsWi0BD2NvAx1ihwTo=;
        b=i5vZlZJFYLVwlLEM5nqcQBavJ70MWtaSV86ZpqIZXVd5h8GjuBaAzD+LZSOifMM8Zn
         eDZGZUvx/jnuzYUeMuzvnkclBN2oBbxndgKul/ZSV5IN45Gj+LcfmhSkAcy5EvKCnd0k
         ytARiwv43d6RKfo6EkW5jq28TkBB4IMRN/p67jBaQJhrlbb1XCalkr9bvgl6dlPCkW4X
         58TgmJkladNcGF8QQtL4qcm0Eqxsw71Q8poVuoc6hujCqVwuBaAoOOPESg10EHn7ySaD
         Y2tViTQidFNLBUlpNkcc3jMmQbzyLdRoWuMfCet3YfEV8eEj5gMhI4b9UVeQeDT78Uwa
         gIQg==
X-Gm-Message-State: AOAM530xLL+n4CfX9bAZewTA46d40N1GiUIY9JeycOf4VEeA6X98aFXZ
        iW9pvdKKVpUThVfp/q8L4MgemGwfXGMuVx+xSoZmAdqGYIY=
X-Google-Smtp-Source: ABdhPJzTsIJJXmuEvdRIMOoMYMKHo9IHcvWZaami02ky2tY6Pp1a+NGLbXHB0Bd7o9IRpf04azrTl7Hr5fut16xKVhU=
X-Received: by 2002:aca:1c0b:: with SMTP id c11mr3760464oic.71.1605810431098;
 Thu, 19 Nov 2020 10:27:11 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Nov 2020 19:27:00 +0100
Message-ID: <CAJZ5v0jBUToP9sxeuhw_AVwoPNc8RwJD_31WoCLSOiXH6Dcy8A@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.10-rc5
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
 pm-5.10-rc5

with top-most commit 3a8ac4d39651c71d6d2f3376b13d0bad1484249a

 Merge branch 'pm-cpuidle'

on top of commit 09162bc32c880a791c6c0668ce0745cf7958f576

 Linux 5.10-rc4

to receive power management fixes for 5.10-rc5.

These fix two issues in ARM cpufreq drivers and one cpuidle
driver issue.

Specifics:

 - Add missing RCU_NONIDLE() annotations to the Tegra cpuidle
   driver (Dmitry Osipenko).

 - Fix boot frequency computation in the tegra186 cpufreq driver (Jon
   Hunter).

 - Make the SCMI cpufreq driver register a dummy clock provider to
   avoid OPP addition failures (Sudeep Holla).

Thanks!


---------------

Dmitry Osipenko (1):
      cpuidle: tegra: Annotate tegra_pm_set_cpu_in_lp2() with RCU_NONIDLE

Jon Hunter (1):
      cpufreq: tegra186: Fix get frequency callback

Sudeep Holla (1):
      cpufreq: scmi: Fix OPP addition failure with a dummy clock provider

---------------

 drivers/cpufreq/scmi-cpufreq.c     |  6 ++++++
 drivers/cpufreq/tegra186-cpufreq.c | 33 +++++++++++++++++++++------------
 drivers/cpuidle/cpuidle-tegra.c    |  4 ++--
 3 files changed, 29 insertions(+), 14 deletions(-)
