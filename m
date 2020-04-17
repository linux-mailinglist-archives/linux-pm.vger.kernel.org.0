Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACCF1ADF96
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgDQONH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 10:13:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38096 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbgDQONG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 10:13:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so1515791otl.5;
        Fri, 17 Apr 2020 07:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aoUIdBjTaN11kKJSU6IsZ2r0W/vYSM5CLodiWWDXF+U=;
        b=jIXAVr/KTBi+XNwXD49TxWHINrqvUlY2x0kRCS4l6lZocUYIh+IgV2wFHviWSClKlG
         A9kKzfYxx6Za5SJYKMzw/4XyDvHfvS7+9cLC/o4B/b86k5O8cADDAnbfviBpSiAPaTOI
         iF0bI+/RnOn5ak1oPWOrZy4cryM99gFrXe6CjqmMjuD3z05CkHD/z/WTK645WT2sZwGY
         DmWVhrQf1P7lY/kXErNZKT1xxhNCrb5Msufq/HXur7MQ990J0vI6pe60RwMPUH5NDo0v
         5v3E5u+b0QstJq9sFYBnbwtjtG6YhK86f4cZWS34NmB3/GwCvhjonX4q44cTNAQ+FEGe
         zS2g==
X-Gm-Message-State: AGi0PuYW0g84iKRleh6/rGudba2JeAiIgolCoOalcx071bcvavqTMgZ1
        PMcdYAV755ZS84NWfI1HEEUm0/QD9Mqg3HPfHjKBCcaB
X-Google-Smtp-Source: APiQypL0si9YpyIahVYTr/KaMWSV7CQfS7jr1p2+4SXNHR7KGg9FED6IOoLuZ1PIvnJtZ5Rr9uUgqFvaXW841hySgl8=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr2569158otm.167.1587132784974;
 Fri, 17 Apr 2020 07:13:04 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Apr 2020 16:12:53 +0200
Message-ID: <CAJZ5v0hX7hayUrCD3JA8USBhYthRcKKxdu6Ru_EB49=pCYSGKg@mail.gmail.com>
Subject: [GIT PULL] Power management update for v5.7-rc2
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
 pm-5.7-rc2

with top-most commit 2c127c46ec98ff0f1cdb236321bdd54e6e43fcf5

 Merge branch 'opp/linux-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 8f3d9f354286745c751374f5f1fcafee6b3f3136

 Linux 5.7-rc1

to receive a power management update for 5.7-rc2.

This allows the operating performance points (OPP) core to be used
in the case when the same driver is used on different platforms,
some of which have an OPP table and some of which have a clock
node (Rajendra Nayak).

Thanks!


---------------

Rajendra Nayak (1):
      opp: Manage empty OPP tables with clk handle

---------------

 drivers/opp/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
