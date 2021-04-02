Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF8352D53
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhDBQBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 12:01:55 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37435 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbhDBQBy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 12:01:54 -0400
Received: by mail-ot1-f46.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so5324295otr.4;
        Fri, 02 Apr 2021 09:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fief/Icmx2DGoSQURBgLOaPVIgMEWoRAyM9pQI7OxwU=;
        b=BX0Fx83TrYi2a1EQt5Wsol39Yl8iuSL07OrenUzkc8kMIYiVM13txa00Kohcgx1xrD
         ksqD4STYzsnRNLhB4K2Cm3jbCK+QVFs4yXXjbzeV5IUMcBNvSxMI9UiJ5EV6sAJp1tWe
         eWgogkoVYZf+dCCdI0CsZApzQpejtfon9/Kv98QNp7UzgwgSgSYeM9wyY3GwdrnD9ZJv
         8zdm3ZtaMIHcjMdOdlcx+fVjUtg3JUz+n72Kipu3tSwib/DsFpQB/xb8zkeRKhElLU0r
         SpnNWrb922mI3VIXJj6bVg7XrlwImM1XlK2jOftS26U7db3Y0cXYK9c8NmqMjlDcf3Oq
         09+w==
X-Gm-Message-State: AOAM531FNEdT5zcfygXQAW6W37DGDftLinH+2SMHs4Ch4PKVbt9z5fhR
        22vqdEdJJ3Omy42TghqhxOTCGYUUSJO9ggJu1fbI4lKCFEk=
X-Google-Smtp-Source: ABdhPJxGVytUzz97GC3qR4bJBOLOfTgO5Iq7otUs1Z9p+EwOiax4h/DTxzD3SJtIn+cFAag8/oycp+zTt/rmKNP9GmM=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr12176225otf.206.1617379313308;
 Fri, 02 Apr 2021 09:01:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Apr 2021 18:01:42 +0200
Message-ID: <CAJZ5v0h=RmqSfW-F0YHsbDeg191ut4ZS7SN9dcCAFg_+EoQqcQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.12-rc6
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
 pm-5.12-rc6

with top-most commit ac1790ad78f8f0cf9a588ffb530c700ad758e8b6

 Merge branch 'pm-cpufreq'

on top of commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3

 Linux 5.12-rc5

to receive power management fixes for 5.12-rc6.

These fix a race condition and an ordering issue related to
using device links in the runtime PM framework and two
kerneldoc comments in cpufreq.

Specifics:

 - Fix race condition related to the handling of supplier devices
   during consumer device probe and fix the order of decrementation
   of two related reference counters in the runtime PM core code
   handling supplier devices (Adrian Hunter).

 - Fix kerneldoc comments in cpufreq that have not been updated along
   with the functions documented by them (Geert Uytterhoeven).

Thanks!


---------------

Adrian Hunter (2):
      PM: runtime: Fix ordering in pm_runtime_get_suppliers()
      PM: runtime: Fix race getting/putting suppliers at probe

Geert Uytterhoeven (1):
      cpufreq: Fix scaling_{available,boost}_frequencies_show() comments

---------------

 drivers/base/power/runtime.c | 10 ++++++++--
 drivers/cpufreq/freq_table.c |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)
