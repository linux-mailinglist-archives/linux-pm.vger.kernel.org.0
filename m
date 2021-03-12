Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4D33962E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 19:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCLSVH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 13:21:07 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46143 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhCLSUq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 13:20:46 -0500
Received: by mail-oi1-f177.google.com with SMTP id q130so8808591oif.13;
        Fri, 12 Mar 2021 10:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u1zMBOwzFggkKO0X05Cxt62y2sT28xZo85GHgVUn4NU=;
        b=BwBV6qAFCF88tHVlITAe5ssgZtV0xmWEVj8GHKIYe7yC8tNV82Rb2OwuqZQIU5gLtm
         OiT0iZHVNPxpo1emOR5igx79pmp09OvqlvfFTtxyHM7HRQGs5XvBstkuF3XNFwVXa0IL
         MmbKdUq3Ih39IMjOumpPfFgeGXC9ghrhhHds/Wd12snBj5/sGX8X/CXEOIgA8RnfM9Y2
         AMTQJYk8n4cTGzjmQ6pO7aHVVj0WPlCwr8MsSbwEvqZuvALvBhd83UArcPKCOVD2V9tS
         w2pUxTJ8Jj++wNTYUUVpRnN+FeOZ8hS9Fx7ffLYcbzOzI1bd1/wTY6er/9MxfIRgj1YG
         reKA==
X-Gm-Message-State: AOAM5319Ers9wu6TPW5lW0Y4NXbRiZHrfdgGLq2i8Rh29PH7cvnu6Brs
        dqu9dVT2eBlhOaAgQnSYyFciFtBkHu/rsLY/mHoTOw9V00A=
X-Google-Smtp-Source: ABdhPJzHzrWyVa032lK3DISjUNxZxcJVICLSOLWuPrHoonupl0u1U9MbC1PoPjgIoiztD0ma9KyYnmn2BHHeu9bZZl0=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr11076567oia.157.1615573246118;
 Fri, 12 Mar 2021 10:20:46 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Mar 2021 19:20:35 +0100
Message-ID: <CAJZ5v0jzkMkavZVnwQzjRmu9gg-ReicViPG4QU+Lh4Yp0sVohg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.12-rc3
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
 pm-5.12-rc3

with top-most commit 7180323227702b46677e51d0da71f452615efd8c

 Merge branch 'pm-opp'

on top of commit a38fd8748464831584a19438cbb3082b5a2dab15

 Linux 5.12-rc2

to receive power management fixes for 5.12-rc3.

These fix an operating performance point (OPP) reference
counting issue and three issues in ARM cpufreq drivers.

Specifics:

 - Add a flag to mark OPPs that are not referenced by he OPP
   core any more to prevent OPPs from being freed prematurely
   by mistake (Beata Michalska).

 - Add ARM Vexpress platforms to the cpufreq-dt-platdev blacklist
   since the actual scaling of them is handled elsewhere (Sudeep
   Holla).

 - Fix a function return value check and a possible use-after-free
   in the qcom-hw cpufreq driver (Shawn Guo, Wei Yongjun).

Thanks!


---------------

Beata Michalska (1):
      opp: Don't drop extra references to OPPs accidentally

Shawn Guo (1):
      cpufreq: qcom-hw: fix dereferencing freed memory 'data'

Sudeep Holla (1):
      cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev

Wei Yongjun (1):
      cpufreq: qcom-hw: Fix return value check in qcom_cpufreq_hw_cpu_init()

---------------

 drivers/cpufreq/cpufreq-dt-platdev.c |  2 ++
 drivers/cpufreq/qcom-cpufreq-hw.c    |  6 ++---
 drivers/opp/core.c                   | 48 +++++++++++++++++++-----------------
 drivers/opp/opp.h                    |  2 ++
 4 files changed, 32 insertions(+), 26 deletions(-)
