Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F70544C304
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 15:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhKJOgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 09:36:13 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46776 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhKJOgN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 09:36:13 -0500
Received: by mail-ot1-f54.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so4105886otk.13;
        Wed, 10 Nov 2021 06:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=axI27ETmu5Dt0KbqSL9bIhsurhtAWljYPkjBLFRv4z4=;
        b=sqcg6OfTKBmdQMYGhwL2hu9tNFN0zYYcVJa06ChcH1MzwrpMGws+m8/bTPQwL+0dmd
         rxWD9puLaaUNe7Rs5zrdc0fFG6i3UnENXYiZCcRLtax5yZGUZNR28QTwP1rCHYYuq/01
         S6dtv2qRu0WqjF2vaSxikEqrnwevcj1zxLVS+fq4iRowoh5yHlvXg1P+4KuAi3KFQDKD
         sHae1CunuFWa0IkGCJJGGdDkee2mvW6gVRaE8Q2g4b1D/m3VeJ+m/WTdcn+a4W8a60UK
         pEWGNonr463aV9yO0afup3wllC6J4cG5gBA46S6SVGh3fVNnhMw9QCxSE1VWTWHpYwWd
         bs9w==
X-Gm-Message-State: AOAM533KS4PBRAdAm18NV88tcLch5NQZroJvJuEhhIRWKNhVjSPNnI3S
        3l6NMd6O+wCzIga4iBEPmEperiKpVoBUgsogrdK6oclTcP0=
X-Google-Smtp-Source: ABdhPJwz7M75opxyr/Z5bJBBRe4b6tpcjtrfpXgF67bS8EArRTaTdqVwbpBq0fhtyLd+wgRywJxlPnpk8HBn+REymU8=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr273250otj.16.1636554805201;
 Wed, 10 Nov 2021 06:33:25 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Nov 2021 15:33:14 +0100
Message-ID: <CAJZ5v0is9Prsk4OyqZAZaUvg0WJJfLxiU+GG9vckOdCD7Mfsvg@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v5.16-rc1
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
 thermal-5.16-rc1-2

with top-most commit 61988e0a624400fe79f124914ecc4b19a8803f7f

 Merge branch 'thermal-int340x'

on top of commit f73cd9c951a9dc23f0ee1260fef5cc61d2825fb3

 Merge tag 'thermal-5.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 5.16-rc1.

These fix 2 issues in the thermal core and 1 issue in the int340x
thermal driver.

Specifics:

 - Replace pr_warn() with pr_warn_once() in user_space_bind() to
   reduce kernel log noise (Rafael Wysocki).

 - Extend the RFIM mailbox interface in the int340x thermal driver
   to return 64 bit values to allow all values returned by the
   hardware to be handled correctly (Srinivas Pandruvada).

 - Fix possible NULL pointer dereferences in the of_thermal_ family
   of functions (Subbaraman Narayanamurthy).

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal: Replace pr_warn() with pr_warn_once() in user_space_bind()

Srinivas Pandruvada (1):
      thermal/drivers/int340x: processor_thermal: Suppot 64 bit RFIM responses

Subbaraman Narayanamurthy (1):
      thermal: Fix NULL pointer dereferences in of_thermal_ functions

---------------

 drivers/thermal/gov_user_space.c                   |  4 ++--
 .../int340x_thermal/processor_thermal_device.h     |  2 +-
 .../intel/int340x_thermal/processor_thermal_mbox.c | 22 +++++++++++++---------
 .../intel/int340x_thermal/processor_thermal_rfim.c | 10 +++++-----
 drivers/thermal/thermal_of.c                       |  9 ++++++---
 5 files changed, 27 insertions(+), 20 deletions(-)
