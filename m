Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7746E307414
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhA1Ktp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhA1Ktm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 05:49:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F5EC061574
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:49:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id j12so3723232pfj.12
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8tY7xOSVL8TKmu23l5iwSWLMDTVdZzvIWOkVTMFGtE=;
        b=GOVFFIZleKeu/u0ClRM2qZBnFQcwtfJ8rA2iqIzKh4pprvawvMHg+/qykqmwoO4Qv6
         wx5VoD8JLCNalnmcuv46OFtu0o96/BWOseUB+v/QBLExW4R3c2nq2iA1VA2xUTYZbu5r
         Rd6vqPsDA6dhwCO3+h4J4lGF7AkGQ4jl3FGuvCNyniC6VwNLOWVtUcJ2X/OLD6RHs9g2
         mzkLcdThwlY++oad1iemBQy65e0FdneukoyiNpD7I6+9tC7m0Bn2pfwtZ7j5A41pNufT
         xzw9TUQVwy5Qdz6My0hZ6zqsN1wz2VUNLJTJN/2l+9yX2gJRBUTmvdiJ2m37syVS/mC6
         HNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8tY7xOSVL8TKmu23l5iwSWLMDTVdZzvIWOkVTMFGtE=;
        b=b6nMQ4pcxy3Pn2xsj1hjbRCPbIPcfEkbKmKmUTG8Uua5TY9vznlFxYOWgYz7rbNFAO
         1Z/J8u8AKL9xwJ9AQOk6bSLvP0q2/Iimvx3cZM8faWMPR05W9mQKxAdaEPkNQkl4cFRz
         xsx155GA7IhQ7M3Jb9BcRGOHXaer4NHqGgV2wU7xvNvRDU1kt4mkYQR1b+sgidozcXQt
         K4Tp1Kzwg70YEse15ngZsg/lupUko4FmXePYFFT3hnrfugdHBWuyiBSuY0v14Jzdmk0u
         V7Zn8x3raCVke6exenVX1wcDGDFeRd1Qy5hUEABXr/bD1i8WzKINbdjQUXtm5rAMjl+w
         bOgg==
X-Gm-Message-State: AOAM533l23o26fjDYf8IaFtkakU/tykK0306eqwf+mnnD5NdJQ44CDru
        y8Ysnb8Clm+wgR3CvIcPYlfpPQbjIC3eMg==
X-Google-Smtp-Source: ABdhPJwa+ZzBlBpHuDnGeZby0eouiQdqpT0URVUu78gQU8t16ZFZ3MV/GorfSzD1iZ9T/VN5tnBVxQ==
X-Received: by 2002:a63:1a48:: with SMTP id a8mr16032597pgm.257.1611830942070;
        Thu, 28 Jan 2021 02:49:02 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a30sm5378756pfh.66.2021.01.28.02.49.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 02:49:01 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH V3 0/2] cpufreq: cppc: Add support for frequency invariance
Date:   Thu, 28 Jan 2021 16:18:54 +0530
Message-Id: <cover.1611829953.git.viresh.kumar@linaro.org>
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

This is tested with some hacks, as I didn't have access to the right
hardware, on the ARM64 hikey board to check the overall functionality
and that works fine.

Vincent/Ionela, it would be nice if you guys can give this a shot on
some real hardware where counters work.

This is based of pm/linux-next (need some stuff from the arm64 tree).
These patches should get merged via the arm64 tree only for the same
reason.

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
 arch/arm64/kernel/topology.c      |  89 +++++++--------
 drivers/base/arch_topology.c      |  56 +++++++++-
 drivers/cpufreq/cppc_cpufreq.c    | 179 ++++++++++++++++++++++++++++--
 include/linux/arch_topology.h     |  15 ++-
 kernel/sched/core.c               |   1 +
 6 files changed, 274 insertions(+), 76 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

