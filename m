Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71553C4CB
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jun 2022 08:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiFCGU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jun 2022 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFCGU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2022 02:20:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1692ED59
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 23:20:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c14so6481263pgu.13
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2022 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqtzEl4kjEH72Nt23nWdfUiQ9wMxQ4zHycvd8RVAkfE=;
        b=n7DwcIygTKwARw+cIJ+EiSpliXxhWy2SSpW+wtw49iNPETp9V+XNdpaXVdIZ23GoSR
         jzGDi7BPeCphC9pMGP7FUtnXgGQYtPr+GZQBPs5PWYrgLBgR1KIdZuW6dQhpPkl0mcBW
         ov9p9rnq3jRQucdq1A2Q/G19st9Z2/oJ2Ryx5O/RzukJhj4FUEy9gx+sPUTSduGLxZtu
         x0kxB5MiCTpwP6hn1zZb4VVNtRwcdShkjEd5SxezrXSc3zqaBvF2YYf0Ov4DsoHqMTxu
         R69+5wydVj9RsyyEcpSIM1TjfXIB2vdZhOW2rxOrRIjhqIJo3jRi/tHWze6NJMDB3KCw
         KBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqtzEl4kjEH72Nt23nWdfUiQ9wMxQ4zHycvd8RVAkfE=;
        b=Me9AjGbUR3+jUxA+nW6wt+FFoCCxTl/f4FDzo7S+n/h+oBr0Fdbq9GWJWVjz/RHzcp
         hnBACm2BKpBc7E0Y7wBDnhfoOXAC9pl843TVzG0r4PLEdQYCmPX8VWCA0vLIAkAi41fK
         V2ACQjcZ2C/2ihs3bFqnrlqjV7Jw0zl2JZUo6zDfISQf2g7Yn3zfcl6DFIhCHn0PwjE1
         RYbDrGXUBl3mMDiaCfUTu4jdetZVm8pKOsGNKB461UyG016lAfiaibscw8f5aQGZcJMT
         Xi9QcAZW3gMwndGK7c+hcy+0PGUrp3MNHByP+p6Keecgr/t9mxIsCAfEEqoHruQLP1IJ
         xvEA==
X-Gm-Message-State: AOAM530a0l4WBl+Rg/PEyVVH036nylsFOKPkzF5IMtuBCCVB6qzbxPmP
        AvGm2JoHy59ndVltDWiec2dUkhXO5hwV+A==
X-Google-Smtp-Source: ABdhPJz+eY1TNomBoThFNmRQjAWHN7qFU1D+PT5tJUlrweyypNzKO3IwqUfCyt0h1g4r0VGnrIs70w==
X-Received: by 2002:a65:44c2:0:b0:3fa:8a91:1ae9 with SMTP id g2-20020a6544c2000000b003fa8a911ae9mr7513728pgs.412.1654237224999;
        Thu, 02 Jun 2022 23:20:24 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090a15c200b001e32a7f876dsm4397240pjd.16.2022.06.02.23.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:20:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] OPP: Make ceil/floor/exact helpers share code
Date:   Fri,  3 Jun 2022 11:50:14 +0530
Message-Id: <cover.1654235445.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

All helpers of type ceil/floor/exact do pretty much the same thing. Rewrite them
in order to reduce code redundancy.

Tested the freq based routines on Hikey platform, work as expected.

This is rebased over other recent OPP changes / cleanups and is pushed here will
all dependencies:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/ceil

--
Viresh

Viresh Kumar (5):
  OPP: Remove dev_pm_opp_find_freq_ceil_by_volt()
  OPP: Add generic key finding helpers
  OPP: Use generic key finding helpers for freq key
  OPP: Use generic key finding helpers for level key
  OPP: Use generic key finding helpers for bandwidth key

 drivers/opp/core.c     | 437 ++++++++++++++---------------------------
 include/linux/pm_opp.h |   8 -
 2 files changed, 147 insertions(+), 298 deletions(-)

-- 
2.31.1.272.g89b43f80a514

