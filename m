Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB33ECD90
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhHPEXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 00:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPEXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 00:23:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA00C061764
        for <linux-pm@vger.kernel.org>; Sun, 15 Aug 2021 21:23:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so30400410pjr.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Aug 2021 21:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ZZKPEIAIH1dCk2O/M6Uefq9wmmOllhC+NfJpoa3OD3I=;
        b=YZIq1JNNk3vi5uJIeK4R37PAtVaEsgHPYRva1Nd6SxhIHqe40gUm69++E1fPbIDQFq
         pueQihfY/iTJ3JHe7odiRrf0MiwXFjVq0LicLncU5rwjPV227K9+YfvBzpTzD9dInpbC
         7fd455BDTaJbxDZ9ROK0YAEebU78EI+sGQ2oY8EbtCiqv+r+/PrFrin1PMXB3CHxH30m
         dm9t5X3dLNH1aKq7i85GvSA4A0EU2Am3ynLpmsjug9vr4pdsbi+p1tHYO52G5kpadYdF
         yk6MP3gORBzYUz94QhKIL0CHD1da3pT//vZw2XZnXpYQf+J3rbOCQUSix2AiD/2lXtww
         Zfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ZZKPEIAIH1dCk2O/M6Uefq9wmmOllhC+NfJpoa3OD3I=;
        b=txispttSV61Ox//86Kiu90e++etSRfD++DQFAUrLb3oFyB3SVX1CdUxki8JC1nNvHs
         kDzR0Xar6ovf4p5NrMjdw4BDlftc24Xbbq3LpOqsOF6ksJcKWaQ68ovNLDm/GRyixE2U
         nJwl7WCowchXFyiuFeT32Cgrg0e4x1f9D1SlcKWCi/bkgPB3b+OFLQB5u22xtFiVSSQL
         ItqYAGVGQVUScmHhH1mDkoVR2L77ISxSYdpV3r8rSsxDjMPQBm/p3yXkXgdICxdgbENv
         V61vXYv9IVrvrxRQby+QrBW3J1hIz7HB3hGT8O7PvK7Y/M+LUjPNCDso8NGaDW708VZq
         qO9w==
X-Gm-Message-State: AOAM532SsW5EXg4ymo01auLyzEEUk0d+x+kDXJC+8VKIbaUQbceSCW3W
        w7a2Roa1a9PpNpPEIDSf/6QmhxbIXHhJyw==
X-Google-Smtp-Source: ABdhPJw9Y9TwMjJYxU3A2gVUNu4WaI+Ev0ni6f9p87nXGdPsko0YgsCmByEibcCyNJtx3A0dGlC5YA==
X-Received: by 2002:a62:65c7:0:b029:3c3:4eff:1b26 with SMTP id z190-20020a6265c70000b02903c34eff1b26mr14100410pfb.48.1629087785002;
        Sun, 15 Aug 2021 21:23:05 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id k6sm7797883pjl.55.2021.08.15.21.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 21:23:04 -0700 (PDT)
Date:   Mon, 16 Aug 2021 09:53:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.14
Message-ID: <20210816042302.b5gblymaguy5qvbq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request removes few WARN() statements from the OPP core.

Thanks.

--
Viresh

-------------------------8<-------------------------
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes

for you to fetch changes up to c3ddfe66d2bb511f7fbcdc8e64952c7859e7e69d:

  opp: Drop empty-table checks from _put functions (2021-08-16 09:42:08 +0530)

----------------------------------------------------------------
Dmitry Osipenko (1):
      opp: Drop empty-table checks from _put functions

Michał Mirosław (1):
      opp: remove WARN when no valid OPPs remain

 drivers/opp/core.c | 15 ---------------
 drivers/opp/of.c   |  5 +++--
 2 files changed, 3 insertions(+), 17 deletions(-)
