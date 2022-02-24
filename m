Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8E4C3067
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiBXPzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiBXPzN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 10:55:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673AD16DADC
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 07:54:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so54148wmp.5
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :subject:content-transfer-encoding;
        bh=eE6e4wQAtHF1L7R2NE0Y+8YGz+RyJLvQFkmjUWHVwFQ=;
        b=Hy1HTs7asakAnawD7EmFvZYi00Da0gzkMZbZgXt6YiBra8U+Po9OfoMRf0H5ZrKfxV
         ybhCk9aLDLA4DcVYsJlsYplukABSrmOmL0klPw2gdn8ZuJizqDJcNeKKTN1KRJRulKcu
         1paK2BhTEDeAsV5ppN8SGDaU5n0KpqAxOLT7TK3m6E+gjGBfRPXYoJyk2hb0pFT5qGnG
         WybQm3Nm9U52EYZTpLFMFvXvZj8pc9rr4e+Dt8IMZ+RJ/Dhz9SjCeKa7GOQapDWAGnox
         WQzim0cglp5hmB1qct9i+6uDjRgblIcht4HmKaXeci09sh6CWagndk0dORDX6iFMsr6k
         16bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:subject:content-transfer-encoding;
        bh=eE6e4wQAtHF1L7R2NE0Y+8YGz+RyJLvQFkmjUWHVwFQ=;
        b=zVnpKXz/WSP2r815FFT1rbXW6kmiZbj1v2v0srkGGqvu6NG5rxubcDMcQ7CsP8ct9n
         nOidhc3RV3F8YIHlS5+Rij8jCC1LSnJDcT38kjhrK6qez7RnhOX5HYK5LNCaB1SYZ9Jy
         xm+2FebRq+YOa/KOm6Niuv55ODZcKSFr04qIgb1LLbqwPUQunahEVQvdbWpf7/w4eB/A
         16LZe2zsoWS7vRBaHNDKcJ0elnmuN8VIqrmN1EpMcR4G9NOx84oBOScDbCJ/gZPMPEYk
         YhWPjwOlxyWmF6D5ZH7qVp3Ajf9Kxlung9onMNS+08GhpdJD8qxLwDY123/kp+oPuGYw
         gNjA==
X-Gm-Message-State: AOAM531tYfeDeS4aLNYavlSbftteMNdfYxWojxNUAZmbkaWO0KXZqneo
        ndvZvd8mtrvG8oj9aEqNaW3s9ccq08IIEA==
X-Google-Smtp-Source: ABdhPJw/NmZGYgJNf0fg+LWKjCrEwvd+/PSxT2lPdlF1MdV7ONiVR6RNNPcXH0K/ABDbHxs0P1XUKQ==
X-Received: by 2002:a05:600c:154f:b0:37b:c5cf:40e8 with SMTP id f15-20020a05600c154f00b0037bc5cf40e8mr12300049wmg.27.1645718081837;
        Thu, 24 Feb 2022 07:54:41 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id e26sm1707988wmh.12.2022.02.24.07.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 07:54:40 -0800 (PST)
Message-ID: <9e3ba314-2030-8385-33ad-6b9a0291e5cd@linaro.org>
Date:   Thu, 24 Feb 2022 16:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dtpm for v5.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
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


The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

   Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git tags/dtpm-v5.18

for you to fetch changes up to f1ebef9e55f3c49063b575e97d2019832b8f8ef9:

   dtpm/soc/rk3399: Add the ability to unload the module (2022-02-23 
19:46:29 +0100)

----------------------------------------------------------------
- Added dtpm hierarchy description (Daniel Lezcano)

- Changed the locking scheme (Daniel Lezcano)

- Fixed dtpm_cpu cleanup at exit time and missing virtual dtpm pointer
   release (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (12):
       powercap/drivers/dtpm: Convert the init table section to a simple 
array
       powercap/drivers/dtpm: Add hierarchy creation
       powercap/drivers/dtpm: Add CPU DT initialization support
       powercap/drivers/dtpm: Add dtpm devfreq with energy model support
       rockchip/soc/drivers: Add DTPM description for rk3399
       powercap/dtpm: Change locking scheme
       powercap/dtpm_cpu: Reset per_cpu variable in the release function
       powercap/dtpm: Fixup kfree for virtual node
       powercap/dtpm: Destroy hierarchy function
       powercap/dtpm: Move the 'root' reset place
       powercap/dtpm_cpu: Add exit function
       dtpm/soc/rk3399: Add the ability to unload the module

  drivers/powercap/Kconfig          |   8 ++++++
  drivers/powercap/Makefile         |   1 +
  drivers/powercap/dtpm.c           | 333 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
  drivers/powercap/dtpm_cpu.c       |  55 
+++++++++++++++++++++++++++++++++-----
  drivers/powercap/dtpm_devfreq.c   | 203 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/powercap/dtpm_subsys.h    |  22 ++++++++++++++++
  drivers/soc/rockchip/Kconfig      |   8 ++++++
  drivers/soc/rockchip/Makefile     |   1 +
  drivers/soc/rockchip/dtpm.c       |  65 
+++++++++++++++++++++++++++++++++++++++++++++
  include/asm-generic/vmlinux.lds.h |  11 --------
  include/linux/dtpm.h              |  36 ++++++++++++-------------
  11 files changed, 634 insertions(+), 109 deletions(-)
  create mode 100644 drivers/powercap/dtpm_devfreq.c
  create mode 100644 drivers/powercap/dtpm_subsys.h
  create mode 100644 drivers/soc/rockchip/dtpm.c



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
