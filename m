Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902933E900D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhHKMGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbhHKMGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:06:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6FC061798
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so9121929pji.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKg83oB/EOubumHMLyW/+CxlonCs6Sr8DZwUqs7o61s=;
        b=hVsCtquq6U45kkQsI7Vj3hNlKPy4eJSsAmLAbQEn+7pXV2fOQSrxopruKn3Ijor4hJ
         G3XsS5s9jVLqw0cMSMl5wK6FVWYmItaavWYetcFnlX4D5xn3TCcyZaVSIVPzMQQJ6I5R
         dx1WDeV5O6HZSPu941m4uq2vC2UQNKfSo7DfOH5e2VWf4Gw+gb0cgXH7QF8UrNJHR05Q
         ASd86ZctPo0kjcQxyD0AcAr7jotdkEb09HtawOdq2Yg9MgJ7Q7EkgYv6WJZ8hN8c7JGa
         czQYiGXR9gLjmD+F/9aozWcLXiB4+NT46gLj7Ed2ICK9sOgrgVSsXmWHZmxmz0ZpZed1
         iI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKg83oB/EOubumHMLyW/+CxlonCs6Sr8DZwUqs7o61s=;
        b=NHGxsRVJhFVTdr0rYZLY4GFCwKRmUZcm0KgoTry1UPzBSfjHwkytd4QiKUCGRKyl+P
         rZC5C5/ZYYM0gk1DiseU1FVPNBkPG94iPz632oSs/BZs0rOMenwaTqZzvYYENeNZZNFU
         QBbMPlnDRL7ajhu88dEq3qAsufDVsGDvC4+jG7tSlI9zMkKWk/hsVTyPbcdapftjkivl
         IpOdwONNdYU5FTdEbEmIqqCG1mbmS/6RsaRrgEnoSSNkFelEaN2sr7Ly108qV9QrAB6W
         /M8BQuKSgdfrnbRW69PJA/G87B48Tzyh+ETkcsiVvjFylczIsNgPX/aa0sdlylH2EVdv
         v47Q==
X-Gm-Message-State: AOAM532ci6NPzG1QNLlUe/6wHRXwhwoqBxvpgS7+8xmQXHSGPWd0IStG
        PWOVfLsoQEgG5NbMJrUt1Bd2Gg==
X-Google-Smtp-Source: ABdhPJztfFMMqUn9AEZt5iJ8AdfS9ivDU1oMjYwxS6YRWF0FK+JSOzQ526ggirfhbR8GWllwV35JIQ==
X-Received: by 2002:a17:90a:404a:: with SMTP id k10mr37162653pjg.145.1628683574049;
        Wed, 11 Aug 2021 05:06:14 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id v20sm2695779pgi.39.2021.08.11.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH V2 0/9] cpufreq: Auto-register with energy model
Date:   Wed, 11 Aug 2021 17:28:38 +0530
Message-Id: <cover.1628682874.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Many cpufreq drivers register with the energy model for each policy and
do exactly the same thing. Follow the footsteps of thermal-cooling, to
get it done from the cpufreq core itself.

Provide a new callback, which will be called, if present, by the cpufreq
core at the right moment (more on that in the code's comment). Also
provide a generic implementation that uses dev_pm_opp_of_register_em().

This also allows us to register with the EM at a later point of time,
compared to ->init(), from where the EM core can access cpufreq policy
directly using cpufreq_cpu_get() type of helpers and perform other work,
like marking few frequencies inefficient, this will be done separately.

This is build/boot tested by the bot for a couple of boards.

https://gitlab.com/vireshk/pmko/-/pipelines/351525873

Note that I haven't picked any of the Reviewed-by tags from the first version
since the idea is very much changed here.

V1->V2:
- Add a callback instead of flag.
- Register before governor is initialized.
- Update scmi driver as well.
- Don't unregister from the EM core.

--
Viresh

Viresh Kumar (9):
  cpufreq: Auto-register with energy model if asked
  cpufreq: dt: Use auto-registration for energy model
  cpufreq: imx6q: Use auto-registration for energy model
  cpufreq: mediatek: Use auto-registration for energy model
  cpufreq: omap: Use auto-registration for energy model
  cpufreq: qcom-cpufreq-hw: Use auto-registration for energy model
  cpufreq: scpi: Use auto-registration for energy model
  cpufreq: vexpress: Use auto-registration for energy model
  cpufreq: scmi: Use .register_em() callback

 drivers/cpufreq/cpufreq-dt.c           |  3 +-
 drivers/cpufreq/cpufreq.c              | 12 ++++++
 drivers/cpufreq/imx6q-cpufreq.c        |  2 +-
 drivers/cpufreq/mediatek-cpufreq.c     |  3 +-
 drivers/cpufreq/omap-cpufreq.c         |  2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      |  3 +-
 drivers/cpufreq/scmi-cpufreq.c         | 55 +++++++++++++++-----------
 drivers/cpufreq/scpi-cpufreq.c         |  3 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c |  3 +-
 include/linux/cpufreq.h                | 14 +++++++
 10 files changed, 65 insertions(+), 35 deletions(-)

-- 
2.31.1.272.g89b43f80a514

