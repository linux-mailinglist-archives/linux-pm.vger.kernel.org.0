Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF8442647
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 04:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhKBEBZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 00:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhKBEBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 00:01:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF7C061714
        for <linux-pm@vger.kernel.org>; Mon,  1 Nov 2021 20:58:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 127so18329292pfu.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Nov 2021 20:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cyQfvXDhwojfxqzr3BlbhsTIfxzkKDigiB+qM8dIskg=;
        b=ErCntaP+tnCzr9gmD04HqoCEc9P3Ij6R+TM+tvzJTkGMcE8rJ5aqIIzMzCrIfQIcCx
         9v0cup9ETf25lml0oBY6pObIn3dAkE6wpZ4Q1kp5XcNdXw9Zvl5pxYVd86rxTGbOHTrz
         aWbzWVsyPluYNDx8OxXWf/D7hrK7PJ3Poz89Zj9HY0JJspKf2VXI1fZ49Sm85aWujvas
         u4BVLBCnzHDzHIQ5OFdpIT7HOsTgRTsik/r/bltHsnuZ2CKQQo0LvryX3vgV9AKCVa7a
         PGn/6d3/+aUMw5+xiHBPWQNB24bPmhAH4y3WInRSoA7ETVBU62bYnQTVVvankN9dYEmk
         DCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cyQfvXDhwojfxqzr3BlbhsTIfxzkKDigiB+qM8dIskg=;
        b=V8y37I7DKWLPK6iaZwud1dULAB9mV0938+S1od0j65+mNQXhFGXUkCVOqqV5Vj+4Cz
         oLsYLdFfjgim8oG8DexYxdsp+4P05LHkndp3ViFNIdrhUwCMD2HfA2LCzg070GVD4NIj
         ehUlRaWRSYz3RQ0SRxeoDC9qbLOfc1GOvNDYH+2v3aCVcxrOzyiPksGF8eDaSMaSuRSR
         n1UhpKl7QpJSpRIXUh9czHeqHfb5RyNgaL8+i7xRhGoLRQJzQN/mKmLKYuhfhZYm8SF8
         ZKMLEPvJewe4u14K3yzTcbViQV8lp7WAnAG1X+ssEs/+JBSsNqGblF0BjpUbhD/miRHr
         sr/A==
X-Gm-Message-State: AOAM531ijxj/bqvvXj0f2yetfvDn5iiooBDlezEXGc8PvuBYo0gkgQM0
        Amz4isJT8evoKR+T6NwBQ9mQbg==
X-Google-Smtp-Source: ABdhPJyx9F9KDCVwUDTYWXJiaxzl+V6cfzutJvcXKnndQmuJ2vUpsTnyKYIHeNdA3BDpxea++BgeSg==
X-Received: by 2002:a63:b204:: with SMTP id x4mr24757815pge.212.1635825529823;
        Mon, 01 Nov 2021 20:58:49 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id g8sm6108441pfc.65.2021.11.01.20.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:58:49 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:28:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: OPP updates for 5.16-rc1
Message-ID: <20211102035847.52yvfw4ywbxrtqhf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following changes:

- Fix return value of _opp_add_static_v2() helper (YueHaibing).

- Fix required-opp handle count (Pavankumar Kondeti).

- Resource managed OPP helpers, type update to
  dev_pm_opp_attach_genpd() and update to their devfreq users, and
  minor DT binding change (Dmitry Osipenko).

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 7ca81b690e598fdf16a6c738a466247ef9be7ac7:

  dt-bindings: opp: Allow multi-worded OPP entry name (2021-11-02 09:25:05 +0530)

----------------------------------------------------------------
Dmitry Osipenko (6):
      opp: Change type of dev_pm_opp_attach_genpd(names) argument
      opp: Add more resource-managed variants of dev_pm_opp_of_add_table()
      PM / devfreq: Add devm_devfreq_add_governor()
      PM / devfreq: tegra30: Use resource-managed helpers
      PM / devfreq: tegra30: Check whether clk_round_rate() returns zero rate
      dt-bindings: opp: Allow multi-worded OPP entry name

Pavankumar Kondeti (1):
      opp: Fix required-opps phandle array count check

YueHaibing (1):
      opp: Fix return in _opp_add_static_v2()

 .../devicetree/bindings/opp/opp-v2-base.yaml       |   2 +-
 drivers/devfreq/devfreq.c                          |  26 +++++
 drivers/devfreq/governor.h                         |   3 +
 drivers/devfreq/tegra30-devfreq.c                  | 109 +++++++++------------
 drivers/opp/core.c                                 |   6 +-
 drivers/opp/of.c                                   |  50 ++++++++--
 include/linux/pm_opp.h                             |  20 +++-
 7 files changed, 137 insertions(+), 79 deletions(-)

