Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3749E394D16
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhE2QO3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE2QO3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 12:14:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7255C06174A
        for <linux-pm@vger.kernel.org>; Sat, 29 May 2021 09:12:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so6205546wmf.5
        for <linux-pm@vger.kernel.org>; Sat, 29 May 2021 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RyyPRmWqdqxj1XLPKovb+x32n1V33tuLsF4DhaqWo+4=;
        b=hXG/oW1XjF71NLQlfm9Wkg/w4fOHBF2iCADaa3hoOGxGVd9yx1HDgIMzm+utJivAXD
         h5AiUj7VniPeNvYz14j+AfDqJHWpJ6bxztP/hoEL7HYJAdQYdB6nmZ6AEM+zcJ7LbS8H
         tCGdFTCttBiHTBdzRL23fsQqfJ4bT2sXqn3g10nETCkrgr+TUnjv7PALcd/PhVxWuWYG
         cdHbChZK+083Jzkjd/6hImVMKVbcqi193Ldymoz24DJqm5v0GRUcb0GfcJ6zM1J7/b4f
         XumzjpyunF9Ghmc3uKJWFN223YDnv2Dsp8GOGwVBElERLtb/N5n+JH5Xo8OU0AfVdhgo
         kTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RyyPRmWqdqxj1XLPKovb+x32n1V33tuLsF4DhaqWo+4=;
        b=qN28nyWM8tTTwuvuI3BfYqceMLXoth45F/53ZtWAHhuR6/ie7Cslcub0xRByOcqhoT
         jFqLinKJoXkxD0dpDJTHaoaOhBDULPqRkPUCxbMZtvAyz+dm8U+8c1osUm1T2Nk1Jy+8
         J+Wt6z9XHxxEqBxDdFsqmhtbJei3ElLHJys6bXgQkW3ZvMHsQ+e7yYeobYcz209laM/i
         HR7w0bl1QW1jHvW0HvEN3Ow9oCLIhGxq857hwhedOQo36VHpcnfk+Tc+BKdI9NqCe3D7
         RdzAHU4tvcLAWNpMG/TvacXzw2KJ7JDivBroL9JnY0Huqq6xurmIY9S2gD8z52J7ij1E
         UuFg==
X-Gm-Message-State: AOAM533pi/QnF9VI3tXOBFHgXeAcGhbP2ustcBc23KzSM4kOrHRQk7/R
        gbT82IxdYlbYobyxb4lX1+JNjQ==
X-Google-Smtp-Source: ABdhPJyI4xz2x0bt2dx6/2dwdVDNAaL7pHar0nJhxb47irbL9f0vE4JwzEPb+zBdTwsS1GUXgRgokA==
X-Received: by 2002:a1c:6004:: with SMTP id u4mr10505518wmb.110.1622304770225;
        Sat, 29 May 2021 09:12:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1d23:2234:5254:8179? ([2a01:e34:ed2f:f020:1d23:2234:5254:8179])
        by smtp.googlemail.com with ESMTPSA id v127sm12963629wmb.46.2021.05.29.09.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 09:12:49 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v5.13-rc4
Message-ID: <3afbc05e-437b-91e5-fdeb-9682d33adcb9@linaro.org>
Date:   Sat, 29 May 2021 18:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.13-rc4

for you to fetch changes up to 5d8db38ad7660e4d78f4e2a63f14336f31f07a63:

  thermal/drivers/qcom: Fix error code in adc_tm5_get_dt_channel_data()
(2021-05-27 11:38:34 +0200)

----------------------------------------------------------------
- Fix uninitialized error code value for the SPMI adc driver (Yang
  Yingliang)

- Fix kernel doc warning (Yang Li)

- Fix wrong read-write thermal trip point initialization (Srinivas
  Pandruvada)

----------------------------------------------------------------
Srinivas Pandruvada (1):
      thermal/drivers/intel: Initialize RW trip to THERMAL_TEMP_INVALID

Yang Li (1):
      thermal/ti-soc-thermal: Fix kernel-doc

Yang Yingliang (1):
      thermal/drivers/qcom: Fix error code in adc_tm5_get_dt_channel_data()

 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 4 ++++
 drivers/thermal/intel/x86_pkg_temp_thermal.c                 | 2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c                     | 2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                  | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
