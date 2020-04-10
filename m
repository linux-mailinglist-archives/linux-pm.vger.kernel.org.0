Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5DA1A44B1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 11:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDJJt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 05:49:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42290 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJJt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 05:49:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id j20so647692otl.9;
        Fri, 10 Apr 2020 02:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BDftgNGFhLsA0GtFODNTD/SzPGGvfXbg9/jYVMsqdKg=;
        b=nzuZPiqGRvBiXRx3Ds+ZbZjF1wyQbAlIR+CNV7Y71cA4cBMzTc2Mg2znVEd/iYL3fI
         4fQbDbbVAj+nfWp5NQfIrp9ZTxL0ESpPAtAvgP31Dcwxe5JZyPDwiVzVonLOo50iNNGV
         LDHKhewPjJSHgehIB0CQ+r/hsTbWXV3/XB3gpYNGSMlPYZf3jtM+j8P6GPzFaUbz+BQb
         cUzh8hSqP4eGTgOavAJ4sc2Xk6ZbY3Bjzx17zezFWWzbYLtplCIDc3Oe3svfXnka58T9
         1pE1gVCV1fS4a315Ra+h7IPZGKJdwMZn6XpB/Ep+dTkfsO/XVivyTwJn/WQ57OdnOqfc
         sjhw==
X-Gm-Message-State: AGi0PubTXN4c+TUvBjDzqmn5FYazmWOengVKLVUfl2dndu00XGm5aAB9
        3u7soLaQJWW9Ptv/VDcyChwFNy76a0t2G4T5qHNpsA3q
X-Google-Smtp-Source: APiQypId9kNEpqs5uF69GdjBvwTGbjg2zQdxb5GMhraQbP1z8cEbM8V7unS832jhWtSK3Hb6qGfdhMHt4WahAuU+hV4=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr3349035otm.167.1586512164981;
 Fri, 10 Apr 2020 02:49:24 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Apr 2020 11:49:13 +0200
Message-ID: <CAJZ5v0jUWsonPL3NDdVhwQcpVpsPuA9EpOdPpDqF=5XEaPBOVw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.7-rc1
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
 pm-5.7-rc1-3

with top-most commit a31434bcd4cb73b13cd8136c3cbba966dd01f058

 Merge branch 'pm-cpuidle'

on top of commit 7e63420847ae5f1036e4f7c42f0b3282e73efbc2

 Merge tag 'acpi-5.7-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.7-rc1.

These rework the compat ioctl handling in the user space hibernation
interface (Christoph Hellwig) and fix a typo in a function name in
the cpuidle haltpoll driver (Yihao Wu).

Thanks!


---------------

Christoph Hellwig (2):
      PM / sleep: move SNAPSHOT_SET_SWAP_AREA handling into a helper
      PM / sleep: handle the compat case in snapshot_set_swap_area()

Yihao Wu (1):
      cpuidle-haltpoll: Fix small typo

---------------

 drivers/cpuidle/cpuidle-haltpoll.c |   4 +-
 kernel/power/user.c                | 101 +++++++++++++++++--------------------
 2 files changed, 48 insertions(+), 57 deletions(-)
