Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1BE7EDEAD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 11:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjKPKnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 05:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjKPKnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 05:43:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B418B
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 02:43:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso5757675ad.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700131396; x=1700736196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBCtZrQ5H8T1TJ4dOAfwL/GAJ5Ua7JQfulVL3ulFxHg=;
        b=cIolR5mmT90CwgMmOYgQTvSjmHBJ37YYjOxL7KZFwEVgsT83yx594wWoBtGJYAEmBM
         ecIacn7Oq5dxY2pCSQXHUgUvgLIMgVRr3+X3nKpnCaLwyTNyZnga22FQrYwB0DhXy5aa
         Ynvch+aY5AVtENWxuFGvH4lOMNYLHz4CSD85676wA182LxvOcGMavnoePhIpJrSqCgHJ
         D/BK+608DIypvPA1fEKO6pPhPfjz+ehdkqrmaVG8doIGsZc4BovSLA6yqsOKPlGPF4jR
         k3reA/4YaX/6mSvOjFH7mNmbgLozm7J/yhNADEBwdtXgTeZYzfxHnZD06YZOP8rwGxk/
         4uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131396; x=1700736196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBCtZrQ5H8T1TJ4dOAfwL/GAJ5Ua7JQfulVL3ulFxHg=;
        b=MLDyoYC6MKHk9R38rtgz+pLQ27EhoWCaZBdt1tkUzh5ZTerFrx1dQ0kGiAhWXFstY7
         ccT0PxswrlkDyHFDLSn7qcBvM5FCGdvTDaWrkNgL7wyM5Efkqyl7VbWmGsCGEg0t6yEa
         aigU0nQkL7pECwBNE9M1lh8g7tGwsOcvpspxxi0tZ12WE6Wy3ovMnl32Bi8pxjDVQ8l3
         Y5oPi56QmPrZ47Al3Vzk6N09EyAsgwFc9URvYBLHwCHDL8vJ7fyeYV9nRxRFwZo6pN0U
         Xs481KovfJv/mhwi4fHfJMX8/rvNHiEPZF2Ge2mzkAUO3pJbGhBNXWANCgsbRFWWBS3m
         DYUQ==
X-Gm-Message-State: AOJu0YxXaH2d9/lBT8BpFdZne/Y4IXvJz+fXxw2o2dp2g9G9yCJzRPhq
        ZhA5tYhuVww1FyafRAAq82h8Hg==
X-Google-Smtp-Source: AGHT+IEU86RYQ2iJlNRS2Ow2xZr6+w+lY/jO6UV8ohs0jeJQBJx1+/f/9TBfJ/d0ByM0ZWTxCAOC0w==
X-Received: by 2002:a17:903:2289:b0:1cc:345b:c7e1 with SMTP id b9-20020a170903228900b001cc345bc7e1mr9101817plh.60.1700131395561;
        Thu, 16 Nov 2023 02:43:15 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b001acae9734c0sm8880495plg.266.2023.11.16.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:43:15 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3]  OPP: Simplify required-opp handling
Date:   Thu, 16 Nov 2023 16:13:04 +0530
Message-Id: <cover.1700131353.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Configuring the required OPP was never properly implemented, we just
took an exception for genpds and configured them directly, while leaving
out all other required OPP types.

Now that a standard call to dev_pm_opp_set_opp() takes care of
configuring the opp->level too, the special handling for genpds can be
avoided by simply calling dev_pm_opp_set_opp() for the required OPPs,
which shall eventually configure the corresponding level for genpds.

This also makes it possible for us to configure other type of required
OPPs (no concrete users yet though), via the same path. This is how
other frameworks take care of parent nodes, like clock, regulators, etc,
where we recursively call the same helper.

Pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/required-opps

V2->V3:
- Dropped patch 1/3, merged.
- Added a new commit to avoid propagation and a WARN() for parent genpd case.

V1->V2:
- Support opp-level 0, drop vote i.e..
- Fix OPP pointer while calling dev_pm_opp_set_opp() recursively.
- Minor checks and fixes.
- Add Reviewed-by from Ulf.

--
Viresh

Viresh Kumar (3):
  OPP: Use _set_opp_level() for single genpd case
  OPP: Call dev_pm_opp_set_opp() for required OPPs
  OPP: Don't set OPP recursively for a parent genpd

 drivers/opp/core.c     | 180 ++++++++++++++++++++++-------------------
 drivers/opp/of.c       |  49 ++++++++---
 drivers/opp/opp.h      |   8 +-
 include/linux/pm_opp.h |   7 +-
 4 files changed, 144 insertions(+), 100 deletions(-)

-- 
2.31.1.272.g89b43f80a514

