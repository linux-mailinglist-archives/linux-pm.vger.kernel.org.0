Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E54EEEF2
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbiDAON2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbiDAON1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 10:13:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806911D67C5
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 07:11:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx37so358455ljb.4
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65EJ553a/pHY2zs7jhqKI2f0MTjS1Oa9vXvePJIMBXc=;
        b=ZDH/40/1jwtbB3XOcS0sARQxa3Fs//EiF1bVzcL2P6fCZR0Qj+IciGF+Lp3beZZ83P
         vixQb1d4T93WO1qnRCRvni2Noms4HVRoTvGU9WLYr92NC9Ja+WecvehF2IUYRislzo2C
         ETSGF72aBrFQMb7HPvBVgr3n50dwEWvcdPjNMC+eO0ZnB2vQWGKQZe1GDbxty+K7nkn6
         Ohs01cmqxqPRem9T+XuVMoL7dP0a/5OlaGPpJ7O+KFwl0+NuPyN4U/kbaifeMe9ctpGe
         KPC3WNY1KAVQ5zMiUqm8UrqYj9tu1O2DAH8KQS5/GirVrYASxpyhdMbagUriGiOor8B/
         gZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65EJ553a/pHY2zs7jhqKI2f0MTjS1Oa9vXvePJIMBXc=;
        b=vt+hMY8RDPifJVrVtsk0K1R82646gZU+TpFTgTALBhU6Et/PcCkVMunXkWLR2/kwma
         02k0D0X3UfxqEIJUmjwxOaFemS4G5oT7PNVCMo8SBDv6hI31UoiFf4jXj4kRVgPvwJub
         3ygqA2GR+HjEN0M591raooSr82MhX5HKCV+5qqcLGQXHgob/ZpRV1G1sxXNjCW2pZfGZ
         psUqffvBDlDqVpRNdYVYoO7N/nFr+1dJOJMgOWKeVvvSt4ipMl3Lk9okgzv++NASwbpe
         5UN0x1u94rjVCiSODcUMaAV1Ty1sITsnX/4IaiYLppOdJZHicfDMQu5xmDvl/0p2LN87
         zEjA==
X-Gm-Message-State: AOAM530w72IIUJ2gBv9FCe7NM0B5wduPaYJQFnyzXOksK7SCIAv66Aap
        YXgST87P4jODirNsVsX9CDx3VHya9GBj/A==
X-Google-Smtp-Source: ABdhPJyq4o18Yi37xxLcbgHuUKp7UO1lOFjt+CTdroBRFBc0/cssgxEwSWccEGWFuSuSJqTF1rDecQ==
X-Received: by 2002:a2e:9886:0:b0:24a:c13b:5337 with SMTP id b6-20020a2e9886000000b0024ac13b5337mr13576470ljj.409.1648822295116;
        Fri, 01 Apr 2022 07:11:35 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24d50000000b0044a255c8d3bsm251926lfp.116.2022.04.01.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:11:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] PM: runtime/cpuidle: Improve suspend-to-ram support for cpuidle-psci
Date:   Fri,  1 Apr 2022 16:11:22 +0200
Message-Id: <20220401141124.27272-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Maulik Shah reported a problem with suspend-to-ram for one of the Qualcomm
platforms that is using PSCI OSI mode. Briefly described, the genpd on/off
notifiers doesn't get sent when the boot CPU is turned on/off, which prevents
the needed platform specific operations to be executed.

This series intends to solve these problems.

Note that, I have tested this on Dragonboard 410c, with some local hacks to the
PSCI firmware driver. This was needed because the PSCI firmware didn't support
SYSTEM_SUSPEND, so I basically made psci_system_suspend_enter() to call
cpu_do_idle() and forced a suspend ops to be registered.

Maulik, can you please test this at your setup?

Kind regards
Ulf Hansson


Ulf Hansson (2):
  PM: runtime: Allow to call __pm_runtime_set_status() from atomic
    context
  cpuidle: psci: Improve support for suspend-to-ram for PSCI OSI mode

 drivers/base/power/runtime.c   |  9 ++++---
 drivers/cpuidle/cpuidle-psci.c | 46 ++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.25.1

