Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A001265D7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLSPfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:35:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46291 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfLSPfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 10:35:41 -0500
Received: by mail-ot1-f66.google.com with SMTP id c22so7649109otj.13;
        Thu, 19 Dec 2019 07:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ErDknmMuF0Y4DYta2Y5PJm8gsBoKkVPkmKx+Bgb4CMs=;
        b=DR05MC1cuke2C49GlmneIwuDy2HXuMYyD9zKhI1r+5FdlNGkZL8p1pr/pikwxqNkuD
         ltoK58KRrPkPTJUQe18yu/nzo0gELwczQ7qosnqqfrjeTqlLNCkKGvfpzQ9m9WPrRmNK
         jkqmg8J1j+aH42JZhjhyAlQyWI/X5brhpn+DPIyeJk9Ht4qgDKTTkpSHQg0IgqiFUPR+
         byHnM8dpS1c3W16/eE8OrJzEfyfkRQxTSlVHQjIbhoTwVjnrXoB7BWfyVzjdGK175NMN
         RmzbIvBeWfMWcHiX5WZuFPb6ser8t03t1CUUoUmSpS1VnBeQhTr3h2UHNK82mT7nh2lu
         wtRA==
X-Gm-Message-State: APjAAAVck521V8hNu1cf/mh+7SOHAxxuXvz31dedde5/LYVTo0w2z+/N
        ubHpkZ+RfL1BM8OGzKj1/5x/ZPxoBnuqonIZmvFygFuR
X-Google-Smtp-Source: APXvYqynVHxeLHCdmJUQljuDV26Ut1wFJwJYt9GPhppbUH4fXjlL+kt2mWKxWt15Ou7AABhTCabhzWtgOR3w2yAnx6w=
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr7397244otg.118.1576769740744;
 Thu, 19 Dec 2019 07:35:40 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Dec 2019 16:35:29 +0100
Message-ID: <CAJZ5v0hm1D5CJq81Ew9YjGc_ik8nw9Q_-w0a+7iMdarwPmsH7A@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.5-rc2
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
 pm-5.5-rc3

with top-most commit 505b308b6944a91fa8437a3fd9f2dab29b5c3c88

 Merge branch 'pm-cpufreq'

on top of commit 4c84515da8099f4bab5d9312a0ffaf40f14aa87b

 Merge branches 'pm-cpuidle' and 'acpi-pm'

to receive a power management fix for 5.5-rc3.

This fixes a problem related to CPU offline/online and cpufreq
governors that in some system configurations may lead to a
system-wide deadlock during CPU online.

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: Avoid leaving stale IRQ work items during CPU offline

---------------

 include/linux/cpufreq.h          | 11 -----------
 include/linux/sched/cpufreq.h    |  3 +++
 kernel/sched/cpufreq.c           | 18 ++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |  8 +++-----
 4 files changed, 24 insertions(+), 16 deletions(-)
