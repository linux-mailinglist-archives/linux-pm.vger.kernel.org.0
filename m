Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D0232B18
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 06:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG3E6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 00:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3E6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 00:58:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699DC061794
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:58:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so4490719pgf.7
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9RBYsM94bDUABPnAaYvdSq2HPDjCCcGmwAAvtZinn0Q=;
        b=ENG0wdx3/PjdZhviJsfqvoGlRIa3P8kT0BiTYEwujuQoOmlwFXYYVo52X3yb7SL8+D
         6FpRub9GpuWL+5MG+1ZXr4VZ8xtzYGxc9lplE7bdvWud6PmcmOL7HSsd5s6lU0eBr93w
         cFv2RNtQnsFiZTi6QZdwjGjGf95fAezXhDTpwk7PSIKHLeG06PA2jnOeSqn0uyQw6afV
         6+NeImD7WHEIS5HE1xx8QKt+pXmQMocQJ/sZ3Rz0ChyVN3Rzmd6AvMTEmQTqGIvEQ1X2
         3nDO2Zym7bitVv2QaEwcgnTCJDrAdWCSWw1udp7Ye3eg/lqDujd7cGutVbK8e2fIXKai
         VO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9RBYsM94bDUABPnAaYvdSq2HPDjCCcGmwAAvtZinn0Q=;
        b=E7L7r/065L3zs9dbUCd49AQEv0DgJA4QKVHAuvqQn76XcLwUgY1F14FwDSQz6HIvTh
         VqRiFDmzw7YLmnoYJuciiww206crSZOlU6PDzTP3BO/WpkzB5xco/YTQrCfyUJV/59hz
         eVTqUyHfWbkD+0WQMhrw8CsxTuBMnelt21gRTQ+GmecurXTFHKHQH92sPgMU7SL6MflN
         yMePZ4G9TWj0xkyLY3LQzHLohhvmyPup1luauHFxnuUha8SHiPAd60hi/DmvAoIjpseF
         9R+1XDwHsY9Cvz7+slyZKD/wx5vc6Z6U9FTJLEaOrEf6ddPeAUr5AJuP/Sis6XyCv5sh
         L4sQ==
X-Gm-Message-State: AOAM533tZqbxL6N/HtXCe2HovZB9ME6G8YIZZfSq0uZe4y1/e0RUdTy0
        aMbbFAhhBZnHdz2DALst8f1LeQ==
X-Google-Smtp-Source: ABdhPJycdIwD9HnW9fJKNmgoDPisIgA1oSM3gwnBl0tFY/FnVDFYrHxLDOZNDTBuQdNrEffGLTQ8HQ==
X-Received: by 2002:a65:688c:: with SMTP id e12mr9107726pgt.230.1596085125473;
        Wed, 29 Jul 2020 21:58:45 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id b15sm4525723pje.52.2020.07.29.21.58.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:58:44 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:28:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.9
Message-ID: <20200730045842.v6sei7nh2jc3cjwo@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following changes:

- Fix HTTP links (Alexander A. Klimov).

- Allow disabled OPPs in dev_pm_opp_get_freq() (Andrew-sh.Cheng).

- Add missing export (Valdis Kletnieks).

-------------------------8<-------------------------

The following changes since commit 6544abc520f0fff701e9da382110dc29676c683a:

  opp: Increase parsed_static_opps in _of_add_opp_table_v1() (2020-07-16 08:50:54 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 06a8a059e88bd73ee81a4ad19e97c04766f84def:

  opp: Allow disabled OPPs in dev_pm_opp_get_freq() (2020-07-24 08:05:54 +0530)

----------------------------------------------------------------
Alexander A. Klimov (1):
      opp: ti-opp-supply: Replace HTTP links with HTTPS ones

Andrew-sh.Cheng (1):
      opp: Allow disabled OPPs in dev_pm_opp_get_freq()

Valdis Kletnieks (1):
      opp: core: Add missing export for dev_pm_opp_adjust_voltage

 drivers/opp/core.c          | 3 ++-
 drivers/opp/ti-opp-supply.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
viresh
