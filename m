Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5B4C230B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 05:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiBXEcT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 23:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBXEcS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 23:32:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F9DFD7
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 20:31:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso978579pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 20:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Cf/aNkQNvLJr8xlIe0s05IdXjDi/9gEiKuTdWaGZylc=;
        b=Ah/ffugNso4n/gFeX6ahSYiSoV4dsj7kXR4JU4ayXd5mgnMCYUx+5sxe9kB4vB1Ovo
         hj2/9xp8Wzoz/FORZ/3lrQ9IHt490hgaD1LFs+0wbayM52pLEJRbjmVEgyPuqWY8Mx1j
         dQR9s8xoZzasRtKvdxt/LpP8q/PmCNqeqYae3g4ysDJhxVwF2J7+p/JD/whGIDIcUuG6
         fuGMtUG196wXNvaDi/HyWgrCD6uIpf2SEWmd5Vip6N9njQIykq8nSoD8i56bg4X8LsSe
         AuhInTHRWIexIRHqd1zDCQbgVKFlbEG0ZS3UyKnPGp4qCd41P9TYSUw7umqDhqQWsi9F
         6nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Cf/aNkQNvLJr8xlIe0s05IdXjDi/9gEiKuTdWaGZylc=;
        b=dMa5vV+sEN0BOC1fkiELtOaoLE1nob/4i5RTBoQdyjFY7DqmqGcW/4WmypSqtOEty5
         eRVlr/B1CdzhHozVQr/GiXAyNgto+LMWAksUO2oGvNihdgHc6i8JgZXEpT/AJeSc1Aq5
         fPHAGqg6LPKGbJEeyuQchpRv/FKB9pCa7yoPtt+SPks4bCH2rDx9VjI4XfX2s5uptvAu
         RelWpYPftFF/wlMjgY7AhRCVCJNXHsRBlbMpN1b5/mV5L4F2gpGHnu6E9sUwhaJyHPJS
         Tc/aegvGTH+U2P26s174DXf/tj5W0PyWU/Rb9dNK8+TY7ZE/FnElQF1xKhSVkR35MmiS
         dGkQ==
X-Gm-Message-State: AOAM531f7FvoEm3WjglRVChB6fAXwuBVkFkRhxHyQJ2xz4L4gDUPb8HG
        twHdF8bfdpU/yM/VfN+yS1wHnQ==
X-Google-Smtp-Source: ABdhPJyhtDSURlvpCGmoCgkycZxtnxuoxFK+yb0hORhTVvhhZcAkp4aIoEMh7ayMLLeBxOG1ucGaQw==
X-Received: by 2002:a17:902:8210:b0:14d:6607:bdc4 with SMTP id x16-20020a170902821000b0014d6607bdc4mr811152pln.165.1645677109474;
        Wed, 23 Feb 2022 20:31:49 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id x3sm1221412pfj.25.2022.02.23.20.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 20:31:49 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:01:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 5.17-rc6
Message-ID: <20220224043147.psbkkusn4bdv2eni@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request fixes issues related to throttle irq for Qcom SoCs.

-------------------------8<-------------------------

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes

for you to fetch changes up to ef8ee1cb8fc8976a68f5e89cd5f7b6f7de80c66f:

  cpufreq: qcom-hw: Delay enabling throttle_irq (2022-02-09 13:18:49 +0530)

----------------------------------------------------------------
Bjorn Andersson (2):
      cpufreq: Reintroduce ready() callback
      cpufreq: qcom-hw: Delay enabling throttle_irq

 Documentation/cpu-freq/cpu-drivers.rst                    |  3 +++
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |  2 ++
 drivers/cpufreq/cpufreq.c                                 |  4 ++++
 drivers/cpufreq/qcom-cpufreq-hw.c                         | 11 ++++++++++-
 include/linux/cpufreq.h                                   |  3 +++
 5 files changed, 22 insertions(+), 1 deletion(-)

-- 
viresh
