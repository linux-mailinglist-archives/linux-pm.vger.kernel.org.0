Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F38480F6B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Dec 2021 04:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhL2Dqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Dec 2021 22:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhL2Dqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Dec 2021 22:46:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D160C061574
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 19:46:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so18131934pjf.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 19:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t6f/40xe3/92HH36DvZmEMKwi7ilZ1nUT/tuFlmylyk=;
        b=WwEkyxBavLlVLODAhjoZthIOh+R8aAzRoVfSMNWV/BEnITykpc4zEHkhsjqQfTEwAu
         13CX+4/YUQ1D9qMIYbbOlYbt5EnM+tpAnobn6XRYi0UszDdjBg+4ujsp2LWngiYVK2F/
         L58vVInF/P8EiNBkVnNgQhI8eLsIeQ5UP5/mr9944v9OI6ml8kuFjcE6/P1ePUisGTyh
         TB5jbzOyW8PYXWaYD6C34XIIdh24EsbePUFix7a5QOi2mq6IS1olDoxK16R7tQ9j1iuY
         xaRtzksK5fdFq/l9EyDK3KkgHAOYjuHNA34Tl7qDwDGMLCXDo9ZR1qlnxlnIqpjS1HzP
         Q81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t6f/40xe3/92HH36DvZmEMKwi7ilZ1nUT/tuFlmylyk=;
        b=IAmTEP2prsugcnTzug/4AzdvGJHIwWYFfuPgb1t5vkf4YdIwYWAuo6uVqGWHdYo44k
         L1FgFPOZyKyB0YwE1rASjVuIs53wQmNdjPDUgroH3yEUFjayhT0cz8eveVLmRzKSXIuB
         YXPQ4OG81VRPujfzTt3mXpD9h8EWR/7RyIfCfyLVmrhvKui4WdK7oPFNMV7xF3XoFEyP
         eruIVdSkJE9+vreq7nlkkhIizDmIYE8LxZRNQ+RJPIUqmrRMfhcH9ry8t06FZ6qpROJS
         DKwuAv3Lw9ECzxRLdcEAAxX4lRQK1oLjv3ljrhWDbtJ9SXhpBKS8P7/sGoD7WGVW0ID9
         Z1gg==
X-Gm-Message-State: AOAM532zTsfIMjzpj+sc0Xm/O8tqrtIxenv6aJDexQtEg+/lVN2b1/UV
        EDa9uWZ3yrt0bvNWqM8ee+4go2N6vDjitQ==
X-Google-Smtp-Source: ABdhPJwjZ+I7DUBR13pU4Pp9wSgyPuXZXkQwj4kL1DgQsBxoB10FIlzweUDwJBZyGE1Z+6VBoj7lRg==
X-Received: by 2002:a17:902:c652:b0:148:f1ea:a2ca with SMTP id s18-20020a170902c65200b00148f1eaa2camr24407454pls.125.1640749602723;
        Tue, 28 Dec 2021 19:46:42 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id hk8sm21846325pjb.52.2021.12.28.19.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 19:46:42 -0800 (PST)
Date:   Wed, 29 Dec 2021 09:16:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.17-rc1
Message-ID: <20211229034635.tyh53sxs5uceoljm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Qcom cpufreq driver updates improve irq support (Ard Biesheuvel, Stephen Boyd,
  and Vladimir Zapolskiy).

- Fixes double devm_remap for mediatek driver (Hector Yuan).

- Introduces thermal pressure helpers (Lukasz Luba).

Thanks.

--
Viresh

-------------------------8<-------------------------
The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to d776790a55367b9313d03c364c04ff47e7f5ea83:

  cpufreq: mediatek-hw: Fix double devm_remap in hotplug case (2021-12-27 09:44:53 +0530)

----------------------------------------------------------------
Ard Biesheuvel (1):
      cpufreq: qcom-cpufreq-hw: Avoid stack buffer for IRQ name

Hector.Yuan (1):
      cpufreq: mediatek-hw: Fix double devm_remap in hotplug case

Lukasz Luba (5):
      arch_topology: Introduce thermal pressure update function
      thermal: cpufreq_cooling: Use new thermal pressure update function
      cpufreq: qcom-cpufreq-hw: Update offline CPUs per-cpu thermal pressure
      cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function
      arch_topology: Remove unused topology_set_thermal_pressure() and related

Stephen Boyd (1):
      cpufreq: qcom-hw: Use optional irq API

Vladimir Zapolskiy (2):
      cpufreq: qcom-hw: Fix probable nested interrupt handling
      cpufreq: qcom-hw: Set CPU affinity of dcvsh interrupts

 arch/arm/include/asm/topology.h       |  2 +-
 arch/arm64/include/asm/topology.h     |  2 +-
 drivers/base/arch_topology.c          | 42 +++++++++++++++++++++++++++++++----
 drivers/cpufreq/mediatek-cpufreq-hw.c | 33 ++++++++++++++++++++++++---
 drivers/cpufreq/qcom-cpufreq-hw.c     | 39 ++++++++++++++++----------------
 drivers/thermal/cpufreq_cooling.c     |  6 +----
 include/linux/arch_topology.h         |  4 ++--
 include/linux/sched/topology.h        |  6 ++---
 init/Kconfig                          |  2 +-
 9 files changed, 96 insertions(+), 40 deletions(-)

-- 
viresh
