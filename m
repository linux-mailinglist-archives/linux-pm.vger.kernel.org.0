Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777802057CA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgFWQrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733052AbgFWQrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 12:47:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47383C061755;
        Tue, 23 Jun 2020 09:47:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g21so4001237wmg.0;
        Tue, 23 Jun 2020 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=2a8A3SZ7tBOcfEqWak8yyvM0vR1xvbK/AAfn7XUHse8=;
        b=XaG5IS7m1eA+gI4FIsCp1abY5EaS5J4F++5cxdUwUG2r6Oj46qpLOXkCiesfyQ+75z
         5e1kVESZ1WPd+WbF1ptJigMflNi8z0SqXlT85/Jy2hBzcQKK56SkP6qFr77pZHnkTVHU
         og9a64+MImwd6LMEHElbEuslUPh57AbB7GqvCWjqbdwrAXyD/tMgKzx2DTeu64K4cUjJ
         Ab295T4L4df3dCYNjJNyGD2Bnz58dIMwlJemGRZLq668ic4/wmCEsew/Di9V5GbP0z7T
         bR7srReGDI5xCZ0am81PqoKq18wXCcaE/d9u27k0n0AMwjBJhcxh88BWphAs7Yz5thUe
         IbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=2a8A3SZ7tBOcfEqWak8yyvM0vR1xvbK/AAfn7XUHse8=;
        b=LvvCRSC9gllARgeK+p+oKgKnVhyD8YD1d3dGDidQp8/eSyh24GW9lMqHJ0ICcz9Tlr
         TI/7VI6/GW9e8vJxukmjEiAMTpygDmofls2vD67ew5+1ZDBgjLyU+HlWaS3unrAcJ4rn
         WvBFFFihgZ3VDbug0l9BBLhA/rE7WI8Pjb81RjP1D4TTJffZanOX6i8x71NuCpMfnk18
         XS14vRqH4eDuqFGhgyIjRiaNf//+szsFCtnZ6xDchiEsDzUP5zFFiI8Epr+FlUSwZqDH
         /mVA4UREh5GTACjdLDL/OLHlllLIflq8bZ2B7rvu6fNW7re9VBmYfRw4qlG3rPafwiNk
         1dSA==
X-Gm-Message-State: AOAM5300vQpqnPa9XAOgN5nGXCW57x+cm37upcPCbxvc/TXJL13Ex/tV
        Z5TtMJENEV90PH+CX/3Z5YE=
X-Google-Smtp-Source: ABdhPJxSuhZVggr1/EQ+Jrz7f0zu6OuFXAZICwjiL3Xfp9K7vXfwNBCxLQtiBy6U5aX7CEwNsEZHRQ==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr22257875wmk.138.1592930855034;
        Tue, 23 Jun 2020 09:47:35 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id d28sm25319430wrc.50.2020.06.23.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:47:34 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:47:33 +0200
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: brocken devfreq simple_ondemand for Odroid XU3/4?
Message-ID: <20200623164733.qbhua7b6cg2umafj@macmini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi everybody,

Is DVFS for memory bus really working on Odroid XU3/4 board?
Using a simple microbenchmark that is doing only memory accesses, memory DVFS
seems to not working properly:

The microbenchmark is doing pointer chasing by following index in an array.
Indices in the array are set to follow a random pattern (cutting prefetcher),
and forcing RAM access.

git clone https://github.com/wwilly/benchmark.git \
  && cd benchmark \
  && source env.sh \
  && ./bench_build.sh \
  && bash source/scripts/test_dvfs_mem.sh

Python 3, cmake and sudo rights are required.

Results:
DVFS CPU with performance governor
mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
benchmark is running.
- on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
- on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).

While forcing DVFS memory bus to use performance governor,
mem_gov = performance at 825000000 Hz in idle,
- on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
- on the big cluster it takes 1.18448 s to run (243.664 c per memory access).

The kernel used is the last 5.7.5 stable with default exynos_defconfig.

Cheers,
Willy
