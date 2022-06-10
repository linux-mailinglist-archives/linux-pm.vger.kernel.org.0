Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907F5545EC6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347337AbiFJIYU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348090AbiFJIYC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 04:24:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7973E7DCE
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so13927596pgc.7
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e26ugP+G0D2r5xR0rmI7tzXuT4/A3dEEKa7RW0oG3h8=;
        b=rp11IKySQeUqZjSXxco0cSSupsGWjAH2k0IcKlNpZgrodfzpYhZ9EhosVi0nJnzCvu
         OvPa27L5AFIJYsuKoxLfrmVpeRCapjhj2DUgHw35rVtgGB7CxnoOBgAF0FXW9MnsfQ88
         Fpzl/XGYfoPrFuq6cHZ6j/+j5+ewGEVT4QH1+oMhfyWlWfcS4suvKkrcTi7FVpaQfJEk
         HesevTNGOjveg2q3nqEkBjczH8z3v0cbv2CNNmxS8e1J0upmjFLV0KPYxcpYU7mkNdy1
         cnO28senNigNxDEgGyXSSV4stL+DGoTxfaQlUS9XouiqxfyoFQRgP4zh9fgUoxaDZ6y8
         gFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e26ugP+G0D2r5xR0rmI7tzXuT4/A3dEEKa7RW0oG3h8=;
        b=Fc1+5NibCGEMY5KgjL6Q4rc9RDyWbjnXAeZvXW+IBYbiiDw68VNDhdNgm7YTBkoBio
         auY6Jh23SwOzNMpdwVkNUnp96AHZw2OAz1pT6ZhE//BARbVV4kfPao6AIGn+cVYnQxsQ
         K9HBZGwVZdo7Aed+/NrovTGSHNNHJcjqmyli9oiQiMeRnixAsT8j4qKQD3yRC6XoPO82
         +a0/6332+UKApQMzC1oO7U21HU2eHPQiHrAHnWb99N/TG9hup0MFmK+Rv8rdRKZZE1jP
         gvp3E6tNkIcYpxssitacrnCh1rpPsjx91G1uneUlsGDu3oDtU6fuszyK6SAyyBX9HOq6
         KqTg==
X-Gm-Message-State: AOAM5312pUSfM9zksnbZt4+frwVw8M52T75zmQ2yswJOcXy1qGosDBHR
        r/91gsYMvz/4QSBckAHLM6hleA==
X-Google-Smtp-Source: ABdhPJzS5tE0forDdQKBwrlwDpZzjHGLAz8PkQkqz1GDmOqpjiduq08hWCxEpAi6sQyk+83yDqtd6A==
X-Received: by 2002:a63:441f:0:b0:3fc:8bd2:f828 with SMTP id r31-20020a63441f000000b003fc8bd2f828mr38169652pga.579.1654849263818;
        Fri, 10 Jun 2022 01:21:03 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id gi6-20020a17090b110600b001e2f53e1042sm1117593pjb.7.2022.06.10.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] OPP: Add support for multiple clocks
Date:   Fri, 10 Jun 2022 13:50:44 +0530
Message-Id: <cover.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset adds support for device with multiple clocks. None of the clocks
is considered primary in this case and all are handled equally.

This is rebased over a lot of other OPP changes and is pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/clk

Krzysztof, can you please test this for your use case. I wasn't able to test he
multiple clock support.

--
Viresh

Viresh Kumar (8):
  OPP: Use consistent names for OPP table instances
  OPP: Remove rate_not_available parameter to _opp_add()
  OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
  OPP: Make dev_pm_opp_set_opp() independent of frequency
  OPP: Allow multiple clocks for a device
  OPP: Add key specific assert() method to key finding helpers
  OPP: Assert clk_count == 1 for single clk helpers
  OPP: Provide a simple implementation to configure multiple clocks

 drivers/opp/core.c     | 337 +++++++++++++++++++++++++++++++----------
 drivers/opp/cpu.c      |  12 +-
 drivers/opp/debugfs.c  |  27 +++-
 drivers/opp/of.c       |  91 +++++++----
 drivers/opp/opp.h      |  22 +--
 include/linux/pm_opp.h |  17 ++-
 6 files changed, 378 insertions(+), 128 deletions(-)

-- 
2.31.1.272.g89b43f80a514

