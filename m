Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704831F9DE4
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgFOQz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 12:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFOQz6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 12:55:58 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED2C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 09:55:57 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s20so13505903qvw.12
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xbDm2rIeE4s6AcLj4uHfUqAXvLAtlmUfof9kDGDNf38=;
        b=BBxgUldUHKuA2KJSpz9pj8p/Z+mffn8sj+QDHWbHacoBsLGhSYybHKP/D/agragbF8
         t0vIGiE87Z/7/gsMDFaKs+dvf2nU5UQadkPgIrqXr7MdWoeLYPk9WLLqsOku1xmUO5f5
         9e2hb/bCQUmxAQ5RYnNb+YVYW45yO0wopsfEER5dDMtJ6wpvMp1SCS9QYZGQPHhUUGGo
         ZknFtQEhPJw2E5NR/21uHblPdZNsoZSlI0gdYF5tCt1fsubY2Urk4xXEundiYAenL3Ja
         224gYb6WeLgu9ln5gFQ/O9D9XPbkZtUoAJ/Dk90kE9xXRjjXD0uo0TP/bTxzZF2SYvlB
         27Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xbDm2rIeE4s6AcLj4uHfUqAXvLAtlmUfof9kDGDNf38=;
        b=TMp3VADXYOCXEY58YrtAqUj4dJpD0p4DOaYi0zq4ohX6L31C6zYrM+OO8yvlZhxfkL
         WsIIAJUwsyPSeP/SpdfFgwRxgeJW49oPNRNfM3gcAtxJ5pCOOq7IQJ7xv16D8G4hLF6h
         vCwQRNgnhHlDmM6p9eED8VGc/fjUARyM6qOf2mwb4lbD/V1Agi1VUOCGKe0CHQ1utBJK
         KNT86uM49SbhZBuY8ysryMIVBNB/dU2ZjTmUavJH8dx5PXwBeIO17n0sNobyGiaW964U
         bAVA/guZpqz8SbpGWi2t2h05sw96sBxgPSXd/EDUYUYCwcRIJmB5L6qkfabdqk+lh9rj
         0sgQ==
X-Gm-Message-State: AOAM5334ae8Sr+dc9qr1qcMSY9lRR7Bty9uAg9VwuOwLJfY2cXSN2gdZ
        MI6GWbE8T16+4PwgIq8Y/BOGAR7r7V0d
X-Google-Smtp-Source: ABdhPJyFXynzAao5s3Yi9KETHCllT8sCdWRGLd1bF9N/edNipexLvxfnpuJsltcL7ifNDIp1A6az2cGf2C0f
X-Received: by 2002:a0c:f494:: with SMTP id i20mr25770627qvm.179.1592240157096;
 Mon, 15 Jun 2020 09:55:57 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:55:52 +0100
Message-Id: <20200615165554.228063-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 0/2] cpufreq: Specify the default governor on command line
From:   Quentin Perret <qperret@google.com>
To:     rjw@rjwysocki.net, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        qperret@google.com, tkjos@google.com, adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables users of prebuilt kernels (e.g. distro kernels) to
specify their CPUfreq governor of choice using the kernel command line,
instead of having to wait for the system to fully boot to userspace to
switch using the sysfs interface. This is helpful for 2 reasons:
  1. users get to choose the governor that runs during the actual boot;
  2. it simplifies the userspace boot procedure a bit (one less thing to
     worry about).

To enable this, the first patch moves all governor init calls to
core_initcall, to make sure they are registered by the time the drivers
probe. This should be relatively low impact as registering a governor
is a simple procedure (it gets added to a llist), and all governors
already load at core_initcall anyway when they're set as the default
in Kconfig. This also allows to clean-up the governors' init/exit code,
and reduces boilerplate.

The second patch introduces the new command line parameter, inspired by
its cpuidle counterpart. More details can be found in the respective
patch headers.

Feedback is very much welcome :-)

Thanks,
Quentin

Quentin Perret (2):
  cpufreq: Register governors at core_initcall
  cpufreq: Specify default governor on command line

 .../admin-guide/kernel-parameters.txt         |  5 +++
 Documentation/admin-guide/pm/cpufreq.rst      |  6 ++--
 .../platforms/cell/cpufreq_spudemand.c        | 26 ++------------
 drivers/cpufreq/cpufreq.c                     | 34 ++++++++++++++++---
 drivers/cpufreq/cpufreq_conservative.c        | 22 +++---------
 drivers/cpufreq/cpufreq_ondemand.c            | 24 ++++---------
 drivers/cpufreq/cpufreq_performance.c         | 14 ++------
 drivers/cpufreq/cpufreq_powersave.c           | 18 ++--------
 drivers/cpufreq/cpufreq_userspace.c           | 18 ++--------
 include/linux/cpufreq.h                       | 14 ++++++++
 kernel/sched/cpufreq_schedutil.c              |  6 +---
 11 files changed, 73 insertions(+), 114 deletions(-)

-- 
2.27.0.290.gba653c62da-goog

