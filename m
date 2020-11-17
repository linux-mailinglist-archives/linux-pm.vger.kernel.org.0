Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2AE2B58E4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 05:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKQEjT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 23:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgKQEjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 23:39:19 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C6C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:39:19 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so16330042pfp.5
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=X1pA+cYATHLxbnvQoWSyBODyW53Jy9N3Gxz6kLP5gEI=;
        b=HvzNQ8S1gDUyuFltnJD934r5nMNBehTIdbQiMp8K/7uDTdLPeDfe1VXp1xci3yOrKB
         BxPilH5qT6IyfuYmxD4OH+yLGNps81haLEzHt1jbjMbjxKbfyXxb3RMALxbGAohNZI/z
         VFbnZw38Ak0cjs9PoS/U547XUViU/Y5afjwM3R6w/7GGbiKTX4crVHecWCL+lw5CLBtE
         RssGwWjVN77FBbgrsSLgGZkAkfmH2PqFXcErM2hVDJTqdHG4NYOImyUR8r5jnXlCl86y
         3B9Y9W8y+eoTDhjfgYDzzbg4pI8DUKBuwJ3U+GxJXZi4CXWza9e9DG6JyGouDr2LIfhw
         AFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=X1pA+cYATHLxbnvQoWSyBODyW53Jy9N3Gxz6kLP5gEI=;
        b=WTyxl4DTR9LJgNxXbWYGmev3zKF+QmCKUrakwfJVyxf7WYkfMOiq1GpM5tkMF64fYG
         Dw9ThUZub1pXO422B3YAM5UbGLHrqiz/jWkPOPaPqFMxjF9By6UQYlaX+wy7621suZXn
         lSo45Lm5+8QJodkV7WrismypqyyORMWY4h5nLB72X4s5lLhSlWU74KQO0U3BFF+WjU1R
         pUxapfj3pB4o9/gqMKUjoU4ZOCWSv+wuGXIWOZyh922uO78zHAFOFWuZCdTsy3D2s6Ry
         en8m6XNGi1pRbzsWg3rOaIInsgepj8wmj8ZVPEgBk0QfdB8bXc6DB08f7lCVpXEpLX3I
         xNuA==
X-Gm-Message-State: AOAM530KOpLRQuMSg3SIGsWyZL59TIACc1wsUYjhKTRgSHp52d0tkGVa
        R8KimYscIza1+GXokQOPnIz+0A==
X-Google-Smtp-Source: ABdhPJxlahfUgiLIQ/gJBktQ+A7ZD9CXMbrRymPLPvMx1yQFXcgCnJekcMFkYeF3S5XCyumxEYPjuA==
X-Received: by 2002:a17:90b:4382:: with SMTP id in2mr2690594pjb.180.1605587958708;
        Mon, 16 Nov 2020 20:39:18 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 35sm14313863pgp.26.2020.11.16.20.39.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 20:39:18 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:09:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq-arm fixes for 5.10-rc5
Message-ID: <20201117043916.tqs5c2r36inoc2ss@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following changes:

- tegra186: Fix ->get() callback.
- arm/scmi: Add dummy clock provider to fix failure.

-------------------------8<-------------------------

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes

for you to fetch changes up to 8410e7f3b31e53bfa7a34c282b4313e79ed7ff8d:

  cpufreq: scmi: Fix OPP addition failure with a dummy clock provider (2020-11-17 10:04:28 +0530)

----------------------------------------------------------------
Jon Hunter (1):
      cpufreq: tegra186: Fix get frequency callback

Sudeep Holla (1):
      cpufreq: scmi: Fix OPP addition failure with a dummy clock provider

 drivers/cpufreq/scmi-cpufreq.c     |  6 ++++++
 drivers/cpufreq/tegra186-cpufreq.c | 33 +++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
viresh
