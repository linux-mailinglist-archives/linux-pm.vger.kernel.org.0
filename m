Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707013214ED
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBVLTQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 06:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhBVLTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 06:19:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFCC061574
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 03:18:34 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ba1so7544235plb.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 03:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rT96flgGp5OXr1BQHnPn+JClqj+1qV978OMJSYTUtHQ=;
        b=r+pugnSlMzO9/whuAbuvV5dfvU5Y1oqzQuzm8lKfQhRHer8acz6gQ7aGPF4xtN/UTw
         MJ5nEGcRJca5DrDNPJ5LNkczS2mNm8ali/Gq/Fz/G+zjmQ3vATonWXN6i0v302XW4QHq
         t3pAU3puYSJ4u+1t9ppsqnZH43pND5wg+MIG1HyC/47s3GMvuJPafa6RFHO39g3c3kzD
         ClvWosBsc9ngTx8vmpvSdT7FSz+DKfKXYYHbE2MYq2efxmZbn4LcJJFjSEUqIgoMP/qH
         OXUNswb/APCqZHKhG+oC3sy4R6kZ15BOZxkpjY0mDX7PBmmdB3J2j98ExS6gUnhdzzUr
         npgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rT96flgGp5OXr1BQHnPn+JClqj+1qV978OMJSYTUtHQ=;
        b=fbCUV0Ga3HKN6KG2rhLnot0doYYUmadUzDqPf9K+846STl/WIqEP/w6XMAZVvQzRlJ
         WmXyoFmukVI3t14fNNmIZQKSFmMaOoLQqgGd/vHOZcHBJ+V/3QySO470h7CgWUMoERxM
         d5NQQVcB/vrOtDhf7UiXEwNr8qzV82X5YHFp04GAoL3UIAbevaN2hv0tzYX5Kqea15DM
         jJvmduKpMy0RAaA1fijtLyAGMSZQ17cS7ki1uO+hPeQWZuci10ZR9AIonaqUaGIxcB9j
         dtTZkGHUs5MewYq9oPvADXrMFJRROSUm+RcNvLROP27W7+HJMf4Y6mSxBRGZhEBzPNGk
         xO5g==
X-Gm-Message-State: AOAM5315KlkqBqKUeCYWOkzq7aQhBlTIow5Hssxnn/xbnca3t9q+crck
        ocXsurHLjZlAZqKEqkGIJvEt7g==
X-Google-Smtp-Source: ABdhPJzXB2R/XDyfm6GME0jPvQ11lpNLYhTZ5C2gruN6UBmTlLWwPeFuBooazJt/UvqXQqGPA0Xczg==
X-Received: by 2002:a17:902:a5c4:b029:e3:e9c7:dcfb with SMTP id t4-20020a170902a5c4b02900e3e9c7dcfbmr7450185plq.34.1613992713816;
        Mon, 22 Feb 2021 03:18:33 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 25sm19403682pfh.199.2021.02.22.03.18.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 03:18:33 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/2] cpufreq: cppc: Add support for frequency invariance
Date:   Mon, 22 Feb 2021 16:48:21 +0530
Message-Id: <cover.1613991982.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

CPPC cpufreq driver is used for ARM servers and this patch series tries
to provide counter-based frequency invariance support for them in the
absence for architecture specific counters (like AMUs).

This is tested by:
- /me with some hacks on Hikey, as I didn't have access to the right
  hardware.

- Vincent Guittot on ThunderX2, only initial testing done so far.

- Ionela Voinescu on Juno R2, though she tested the previous version of
  this.


This is based of Linus's current master (so we will able to apply this
on 5.12-rc1).

Changes since V3:
- rebuild_sched_domains_energy() stuff moved from arm64 to drivers/base.
- Added Reviewed/Tested-by Ionela for the first patch.
- Remove unused max_freq field from structure in cppc driver.
- s/cppc_f_i/cppc_freq_inv.
- Fix an per-cpu access, there was a bug in earlier version.
- Create a single kthread which can run on any CPU and takes care of
  work from all the CPUs.
- Do the whole FIE thing under a new CONFIG option for cppc driver.
- Few minor improvements.

Changes since V2:
- Not sending as an RFC anymore.
- Several renames, reordering of code in 1/2 based on Ionela's comments.
- Several rebase changes for 2/2.
- The freq_scale calculations are optimized a bit.
- Better overall commenting and commit logs.

Changes since V1:
- The interface for setting the callbacks is improved, so different
  parts looking to provide their callbacks don't need to think about
  each other.

- Moved to per-cpu storage for storing the callback related data, AMU
  counters have higher priority with this.

--
viresh

Viresh Kumar (2):
  topology: Allow multiple entities to provide sched_freq_tick()
    callback
  cpufreq: cppc: Add support for frequency invariance

 arch/arm64/include/asm/topology.h |  10 +-
 arch/arm64/kernel/topology.c      | 105 ++++++--------
 drivers/base/arch_topology.c      |  85 +++++++++++-
 drivers/cpufreq/Kconfig.arm       |   9 ++
 drivers/cpufreq/cppc_cpufreq.c    | 223 ++++++++++++++++++++++++++++--
 include/linux/arch_topology.h     |  15 +-
 kernel/sched/core.c               |   1 +
 7 files changed, 356 insertions(+), 92 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

