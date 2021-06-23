Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE11E3B12B2
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFWE1N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFWE1N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:27:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93ECC061756
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:24:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e22so663860pgv.10
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gou6rZ1fClnIKlq6Cu8N3kM3E3lWreX0Ru3iix00OOg=;
        b=Yk45k7i+nKXIrumvirg4IqL1aBpbj1sB2EW5lDMY7mla0i7rjMxwlcIgPNXjinslmj
         ugsDMLwLFfREcqd7ii8nvlAUoJvREVNKSVh1AdcoWC3XjARJ7QGoL9L7mB7R/EcJPanP
         W9/yIzNUW6VQgSEzPWFHTBxz7MKxgYyL8bbqJpm35IFk8OxSLo9/AHb6xtU5GX9Am81D
         kIBVuANU47QyJrAInAEDdBC+4WkY5GHvqInPMMhyEdXtuuHnVx9LNJ/l4/hiCW3OdFbX
         NUlecpupFDfgH0hEqZTYsNc5I20FzYcLRquq99SDTmzJC5nyajkqAreMfq4JvA0JmfXS
         hIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gou6rZ1fClnIKlq6Cu8N3kM3E3lWreX0Ru3iix00OOg=;
        b=Qw4vqhQh37MHynPYqfDNydcQxFu4Y6BsC5X3xfYBKyegX2MUKrKI1e0tfk4as69dND
         TWPc9xBRJAXBYvmwL8Ga9izbn8tAEu/Yk5IB9ou0GetMLDBMi1/ZtVlFSyxns3oiVzeE
         23ZDllqjNr3SKOeEfgLY2yg+KOspgeJzRKDf0HNgM4yx3uG3cHnfPSV+FWaD2kjLpNo7
         ZXlf8DAF7tA1TytDOjq4ryFkeYagF58Wg1mU1mdKzwZDYbaI/auMZxUAmKcFENiE9pWt
         ICAzyY04J+Tf/F7oYpG4e6OUlVh6xjKO6t2UIV4zNVvVSgPFjIlqDPWsFHbL24STCnbD
         FUJA==
X-Gm-Message-State: AOAM5302OvBtucugXEHxGhtnuMnr8MFSfCKnsLdbv5VwrnI90xS8WpWY
        5riB8E5djJ/SWR4P3deipXnSDQ==
X-Google-Smtp-Source: ABdhPJyy710LA90MinM5iDdivfKD7aD592/AhCFzZHQnDhskdAN8PTcQO74w1Zq6FFRznhQXkhmmsA==
X-Received: by 2002:aa7:8d86:0:b029:2ec:82d2:5805 with SMTP id i6-20020aa78d860000b02902ec82d25805mr54120pfr.11.1624422295255;
        Tue, 22 Jun 2021 21:24:55 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id u21sm779531pfh.163.2021.06.22.21.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:24:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Alex Shi <alexs@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V4 0/4] cpufreq: Migrate away from ->stop_cpu() callback
Date:   Wed, 23 Jun 2021 09:54:38 +0530
Message-Id: <cover.1624421816.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

These are based on your patch [1] now.

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state can't be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the offline() or exit() callback instead of stop_cpu().

V3->V4:
- Based on a cleanup patch [1] from Rafael, apart from 5.13-rc7.
- No need to update exit() for intel pstate anymore.
- Remove the stop_cpu() callback completely.

--
Viresh

[1] https://lore.kernel.org/linux-pm/5490292.DvuYhMxLoT@kreacher/

Viresh Kumar (4):
  cpufreq: cppc: Migrate to ->exit() callback instead of ->stop_cpu()
  cpufreq: intel_pstate: Migrate to ->offline() instead of ->stop_cpu()
  cpufreq: powerenv: Migrate to ->exit() callback instead of
    ->stop_cpu()
  cpufreq: Remove stop_cpu() callback

 Documentation/cpu-freq/cpu-drivers.rst        |  3 --
 .../zh_CN/cpu-freq/cpu-drivers.rst            |  3 --
 drivers/cpufreq/cppc_cpufreq.c                | 46 ++++++++++---------
 drivers/cpufreq/cpufreq.c                     |  3 --
 drivers/cpufreq/intel_pstate.c                | 10 +---
 drivers/cpufreq/powernv-cpufreq.c             | 23 ++++------
 include/linux/cpufreq.h                       |  1 -
 7 files changed, 35 insertions(+), 54 deletions(-)

-- 
2.31.1.272.g89b43f80a514

