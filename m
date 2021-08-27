Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9D3F9F40
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhH0Szn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 14:55:43 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42823 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhH0Szf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 14:55:35 -0400
Received: by mail-oi1-f178.google.com with SMTP id bi4so7036569oib.9;
        Fri, 27 Aug 2021 11:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cJzqcTZF3D93KOJy22n9/xJntgyLy5n8Pb1qlIMUGEg=;
        b=gY0BX+dlZ6V58tc3RBVbINAzzD7vUwqviW4tabZY6aac04CWM/fAxFP5d+MkhThiWA
         BHRKhLo3TzJherKZp46a+YVrfm1Y4/TdY9VlOle1nDzb5Q2y1GR/vZCy2ValpP+cd1F0
         SWNLMYwnFnPyKzfmDIo11IAdpfrIknGyuD9g975wVSa1T/LIhcGsRW4SCNd4juGIOC50
         aaNShi97CdVsjXeWrthqPv8jal3li1o6e8lomuYAS+1iW/X7vgZ1mbRy7bwxy2g/aHD8
         g1JrhM937Qy/NJHTJEE6koDwu0xVWREtN0h5IrXyQrzSv5bl12LsdaP6YXrBnwxnNIkI
         I5/A==
X-Gm-Message-State: AOAM5311osQQ6HRc0pbqbyPbQC0RoU5/v82xgV4ZBGZoafq/FpzLyyuI
        TXEdEHrvPoqoijMxfU9FB1pM4qNo80G7p+e9XeKcPuV9shsf6w==
X-Google-Smtp-Source: ABdhPJxCY26tIzZyHh6NA+Ujsafc5l9vBPJ5GdiG0OjrVDECYs5PXBPvl7BIXPD7ERw5j1nFtZj//RUhlZzx07GlNlE=
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr16583165ois.157.1630090481187;
 Fri, 27 Aug 2021 11:54:41 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Aug 2021 20:54:30 +0200
Message-ID: <CAJZ5v0i0a-mYqok8qQfQjpG-zPti=smyZR9HKxFAcQQY6VNrJw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.14-rc8
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
 pm-5.14-rc8

with top-most commit 7ee5fd12e8cac91bdec6de8417b030ed05d5d7ee

 Merge branch 'pm-opp'

on top of commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93

 Linux 5.14-rc7

to receive power management fixes for 5.14-rc8 (or final 5.14).

These fix two issues introduced during this cycle, one of which
is a regression and the other one affects new code.

Specifics:

 - Prevent the operating performance points (OPP) code from crashing
   when some entries in the table of required OPPs are set to error
   pointer values (Marijn Suijten).

 - Prevent the generic power domains (genpd) framework from
   incorrectly overriding the performance state of a device set
   by its driver while it is runtime-suspended or when runtime
   PM of it is disabled (Dmitry Osipenko).

Thanks!


---------------

Dmitry Osipenko (1):
      PM: domains: Improve runtime PM performance state handling

Marijn Suijten (1):
      opp: core: Check for pending links before reading required_opp pointers

---------------

 drivers/base/power/domain.c | 10 ++++++++--
 drivers/opp/core.c          |  8 ++++----
 2 files changed, 12 insertions(+), 6 deletions(-)
