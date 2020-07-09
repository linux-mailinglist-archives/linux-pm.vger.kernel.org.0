Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9792219D41
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgGIKOH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGIKOF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 06:14:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97BAC061A0B
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 03:14:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so904304pjb.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7zJbzd7I0qjlOh1AsM0WBkxDNAEKcLGWWurw0dHxg8=;
        b=Wzb2c1z1qzrLVrgXLiLFowpIvwPzkNoY4wUDZk5bFzC9C5jZRUCZDoI7DhRVwdiKf4
         Yh/4b/7hKzqRD0HIFBH7U3BHCfn/mDEBDoOwwQwB9lhE51yBS8ZkU0oZZiTQqxdG2Wjf
         j9K+S5yx/XfkxgeFUN4B+hR0NfZQsulQwgIkiGV9v9Shdnj/NKMJeBiTJkUPN704jXi2
         vUOSGlD75ObH5TpHEeD6mSrWh4Nb2M5MtgVr0hY/Gk6Va/ksCgW1Sz1bZyl6TLqxDZVh
         pDrMu1EKxma+h4gUhileiX4EH8frlCZkgB9N6GhCFZfY8NaWFTsPV0ePgQX6bxCqc9Lp
         yqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7zJbzd7I0qjlOh1AsM0WBkxDNAEKcLGWWurw0dHxg8=;
        b=OkS1crpehOtIOcbDlOtun/A+5qXC2oudYhj8r31XP7DyF0KJytzIQXY4IF+R0gG1Vl
         6QoJb5rCi7I5zsfNiipPHmIrRZo1Q+kmdEYe7ruyMsTIH+O4E7Vw0JMhqU8IA65H0Adc
         6CtmSG1DDDVe7sIfzgr5qZUw9+gEo2fyeOWLz/47PEcQNIucXETBM172+nX98I3r8iWE
         vzQifX4j38I9Hzm+P/0LEP/5Xz61mpvCbpHg7hhkJcuSV/Izz+FhlNx/w0ylxnvk5QaO
         VmkHcPL2GZ4txrzQvD5G5gLOysya8gf8nVtKyLj4kTQ83ZZGsotg7Z5H8XSZn+3H/Skc
         2QBg==
X-Gm-Message-State: AOAM530WpSMT6e3ohINidtqUl+tb1dIaTG6zVXfPVtdSwnvVd/M0hUYI
        5KTT0bkRtrRImdrjXfcKQKdSY25yp2k=
X-Google-Smtp-Source: ABdhPJx+nWnxi594yoD2CfrDxx754RW3BBZ0Apz2JK7s/LWAodsbqVutddC1PmDdT2gAarFJeCbD6Q==
X-Received: by 2002:a17:90a:84:: with SMTP id a4mr9758381pja.110.1594289643321;
        Thu, 09 Jul 2020 03:14:03 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id fh12sm2026352pjb.5.2020.07.09.03.14.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:14:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Date:   Thu,  9 Jul 2020 15:43:32 +0530
Message-Id: <cover.1594289009.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

CPPC cpufreq driver is used for ARM servers and this patch series tries
to provide frequency invariance support for them. The same is also
provided using a specific hardware extension, known as AMU (Activity
Monitors Unit), but that is optional for platforms and at least few of
them don't have it.

This patchset allows multiple parts of the kernel to provide the same
functionality, by registering with the topology core.

This is tested with some hacks, as I didn't have access to the right
hardware, on the ARM64 hikey board to check the overall functionality
and that works fine.

Ionela/Peter Puhov, it would be nice if you guys can give this a shot.

This is based of my cpufreq/arm/linux-next branch (should work on
linux-next too) + a cleanup patch [1] that i sent this morning.

--
viresh

[1] https://lore.kernel.org/lkml/a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org/

Viresh Kumar (3):
  arm64: topology: Add amu_counters_supported() helper
  topology: Provide generic implementation of
    arch_freq_counters_available()
  cpufreq: cppc: Add support for frequency invariance

 arch/arm64/include/asm/topology.h |   7 --
 arch/arm64/kernel/topology.c      | 165 +++++++++++++++---------------
 drivers/base/arch_topology.c      |  43 +++++++-
 drivers/cpufreq/cppc_cpufreq.c    | 138 ++++++++++++++++++++++++-
 include/linux/arch_topology.h     |   5 +-
 kernel/sched/core.c               |   1 +
 6 files changed, 263 insertions(+), 96 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

