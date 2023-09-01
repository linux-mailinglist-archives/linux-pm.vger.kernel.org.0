Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1037278FDF1
	for <lists+linux-pm@lfdr.de>; Fri,  1 Sep 2023 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjIANDV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Sep 2023 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjIANDU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2023 09:03:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFADE0
        for <linux-pm@vger.kernel.org>; Fri,  1 Sep 2023 06:03:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c615eb6feso1648314f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2023 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693573396; x=1694178196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75a9HyrrjsY749mq1nl+lxvfuPogake/gzHsJRTckdM=;
        b=qDJn9CcrxoEiTtWJQuWCa70ayJkoej6fWNI+sKOMoB5u2a3CHlhBGI7H0BttoSfE29
         rKCMat1WKELUO22R+GH9nQPKK5HKAzwUcO6YfrUhF9b+8zqmZ9Djov1ekh5T+grjGNkf
         Ul75/ADxOgw2rOFb2LbsVqzKwh11MRGsGRKDnrgriGT4gNb6q4gsclP+nILZB3oWIoeC
         eanamQ99DeSxiT/80tfl7Pn/fSBi9IbKRNI/UArF/m32UwZWhqOrK+1edUkjZ3LSoF5f
         n241Q8B9wqadTWLkn3/ICZrbKv8LvcJsUimBWcOipoeLjf8526qMhP72eVCz04Ud5lzW
         YxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573396; x=1694178196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75a9HyrrjsY749mq1nl+lxvfuPogake/gzHsJRTckdM=;
        b=IKhS0KIQ1saHOBGcVgNf/WFOgVvzFgzSanFMANaXegGUgVZpaET4p+XSU8e6SypW+M
         F5ibRiJNn5VH0e8cfMVbTR9TcjOkCIQmVy6Zl7ktb8ZuuMd7g1SdrZxn9i5GjaSQcQrM
         sN2Faqgr53PJwMf5ffkvxic+y41ugaAAZdmnR+PLQxv1UAzF0aauvJNgNMKWGQNeGCdl
         wWOKyRyac8wxGAFeWQiQqAD2/HFdiAsQKtIxbXQG6urSeu/qSzepnxC9ek1/7yt3RqD2
         3RBMa7x6n37Ap04m8V4xSh66SOhqhbCNhnYvH6aCgvj1ZwqLiECRF8y0BoRhSEHXHCiK
         9Fvg==
X-Gm-Message-State: AOJu0Ywm0Rg+MSiNbLu7Y3A/8FnY7INoWNGpp20+WQFPdvkjpCDxiOXQ
        CQURwlruP/kfhuXr1wNW/kB19Q==
X-Google-Smtp-Source: AGHT+IHxmfvngPUK7Awew8G7DdP5NSFVpNGfgrE/M5Ydxk/eDsyeJJCfJ1+9HSWbnzqkm8MYrfOrQQ==
X-Received: by 2002:a5d:500d:0:b0:31a:d90d:8d9f with SMTP id e13-20020a5d500d000000b0031ad90d8d9fmr2074597wrt.25.1693573395616;
        Fri, 01 Sep 2023 06:03:15 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:e9bd:add1:d9ac:7b3e])
        by smtp.gmail.com with ESMTPSA id i14-20020adfdece000000b003142e438e8csm5167452wrn.26.2023.09.01.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:03:15 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/4] consolidate and cleanup CPU capacity
Date:   Fri,  1 Sep 2023 15:03:08 +0200
Message-Id: <20230901130312.247719-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is the 1st part of consolidating how the max compute capacity is
used in the scheduler and how we calculate the frequency for a level of
utilization.

Fix some unconsistancy when computing frequency for an utilization. There
can be a mismatch between energy model and schedutil.

Next step will be to make a difference between the original
max compute capacity of a CPU and what is currently available when
there is a capping applying forever (i.e. seconds or more).

Vincent Guittot (4):
  sched: consolidate and cleanup access to CPU's max compute capacity
  topology: add a new arch_scale_freq_reference
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency

 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      |  9 +++------
 include/linux/arch_topology.h     |  7 +++++++
 include/linux/energy_model.h      | 20 +++++++++++++++++---
 kernel/sched/core.c               |  2 +-
 kernel/sched/cpudeadline.c        |  2 +-
 kernel/sched/cpufreq_schedutil.c  | 29 +++++++++++++++++++++++++++--
 kernel/sched/deadline.c           |  4 ++--
 kernel/sched/fair.c               | 18 ++++++++----------
 kernel/sched/rt.c                 |  2 +-
 kernel/sched/sched.h              |  6 ------
 kernel/sched/topology.c           |  7 +++++--
 14 files changed, 75 insertions(+), 34 deletions(-)

-- 
2.34.1

