Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642071B7EC1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgDXTUr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 15:20:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38849 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgDXTUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 15:20:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id g19so14338973otk.5;
        Fri, 24 Apr 2020 12:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8MV9/+u7qgMpCNZskfFSc9GcIYlBAlgzUWvj7mC9USM=;
        b=hsg7xH6dVZJ8T3s9Hzhiw4MGiZW0iTqCEfsMfcHBFWkaSoUQASleo3D9OAaHWPQ4ty
         Un4BxS0+ApHkggIVKIbG0x0y6pnP/rwLHrz9Jv36v/c9s8wyG4tP8yCjcwZ1JF3KxVP6
         d1IYJmO52xVDHO5Cv5QmUcyiJpm5Y3c5oU8H04HCeTu6mcAv0b2WRgcp80nqMbmkea0q
         Vg8jqffDh1mG9DniPYHxfLNy9vBH+YdJMiFGXdcz62HzUFNXsjpzT/hz4Dl8VVbx+9ky
         vVPS4cgv6IV9BILryGtbB4923VtSOG5M28RQiW1OIxs43SYM2d2KYl6lroBJLBFcOtIG
         kS9g==
X-Gm-Message-State: AGi0PuYbq1cb9y/iHM7ojjO6IX3ij/yjusD+mXtb7HrdmUGZyOremuAN
        se6inejrQilWKD8nKKTZ1OqXiX10Ocxk6DtSLG2squM7
X-Google-Smtp-Source: APiQypJbTbaB7HobSd0rymt4BYLsZfeLqvRv4Qy+Ur5g3pk3lvZgWhpGsF7BRNHw3csBltxjDfo37fYRqg6xniP1Ck4=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr8726815otm.167.1587756046086;
 Fri, 24 Apr 2020 12:20:46 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Apr 2020 21:20:35 +0200
Message-ID: <CAJZ5v0j1yk2k-tT+LxNH+Vq53og+rVRH413xGnzBqKd=AoQyHQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.7-rc3
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
 pm-5.7-rc3

with top-most commit 4bee16d7cccddafd769e8d8ec0625ba239d11a26

 Merge branch 'pm-tools'

on top of commit ae83d0b416db002fe95601e7f97f64b59514d936

 Linux 5.7-rc2

to receive power management updates for 5.7-rc3.

These restore an optimization related to asynchronous suspend and
resume of devices during system-wide power transitions that was
disabled by mistake (Kai-Heng Feng) and update the pm-graph suite
of power management utilities (Todd Brandt).

Thanks!


---------------

Kai-Heng Feng (1):
      PM: sleep: core: Switch back to async_schedule_dev()

Todd Brandt (1):
      pm-graph v5.6

---------------

 drivers/base/power/main.c          |   2 +-
 tools/power/pm-graph/Makefile      |   4 +
 tools/power/pm-graph/README        | 124 +++++-
 tools/power/pm-graph/bootgraph.py  |   2 +-
 tools/power/pm-graph/sleepgraph.8  |  65 ++-
 tools/power/pm-graph/sleepgraph.py | 795 +++++++++++++++++++++----------------
 6 files changed, 620 insertions(+), 372 deletions(-)
