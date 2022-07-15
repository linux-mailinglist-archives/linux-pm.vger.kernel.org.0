Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34013575AA8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 06:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiGOE7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 00:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGOE7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 00:59:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FBE32B92
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 21:59:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g126so3725835pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qfl5SYfunKNQ74X5iwyD1VNFlRqh0+ITebB7/op0Xm4=;
        b=TM0ma6JN/lptGt1wRmfecTgDjfP2dKVrGrTp/J0SYWQqbV7bl8Jtjh35oFvCv8+KA5
         4RK5B46hyrtnF2c7dsrgazF5JtJbXObfCCryPmzyBA62Y931ALuBcf4xI7PsWlDtAZmi
         VZpVBhqF0CKPWigWDhQ7/9g3KwdNPwncqch3zU0TwyiD2LE+gLN8gJ/8mYq+tvWGlNfR
         xGjRBTqzQy9kdHvxoWfPDQUD2vrXgmzbBJm7Ui5ta7csp4uSrS33bZeSNYnGdcX0rhzc
         z+v6v8LwQf99nufXgKcF1+W0VCJs1gaQE1ThNLVEwLyOeB4RDZ6irsoxStXwVVZFxh1Y
         TMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qfl5SYfunKNQ74X5iwyD1VNFlRqh0+ITebB7/op0Xm4=;
        b=JYr7WvyDEIYvBkTXUoGm7T4E4ixfdup1j36KY+TNmFKHz8UWYmJ6ste6KLtRfL1Nck
         JS3/aR8xl76eollh+2up44e4W/InQPkWe6KKQqge6+2F5UJpL5AV6oXHUZaq1gcCakEQ
         pYixNLhMM8FX4bVcA/xQAB/RgQuw/JnQCbMV62nw8O3LySeyRiy6hSqIffUf7J5U4XXC
         YGH/P5cbqL169z543AvIVTvZi5xK6EFy4ZaXBda8s7Vuw7BbGOBbXvXOhPAZH4rfJokN
         uWstXnkmFgLTdr9pUxyL1s/QhRmhmHoXNYd1fQpoLlIF2cUvt7CwVM8ZZuMOZJUKeib/
         eHvw==
X-Gm-Message-State: AJIora8vodjiKos0JB6aMlH7zNvraoKHIdkfYwi1WxA0kblk3kcV2OU+
        hR3QxZyki5RhWREuHScPcznyBQ==
X-Google-Smtp-Source: AGRyM1sooPEnHMSDaZry3c8FxtzUAUJQHduNBLAM3ifFeokwnypMARSZLnHFMGPGYXFlC8qnluO3GQ==
X-Received: by 2002:a05:6a00:1915:b0:52b:17fa:6f33 with SMTP id y21-20020a056a00191500b0052b17fa6f33mr8426657pfi.54.1657861182661;
        Thu, 14 Jul 2022 21:59:42 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78ed2000000b00525302fe9c4sm2632489pfr.190.2022.07.14.21.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 21:59:42 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:29:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 5.19-rc7
Message-ID: <20220715045936.xsrxduwit4beijzi@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit be4b61ec45b3efe5e9077525fc92d544305eb2a6:

  cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist (2022-06-28 13:34:56 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-5.19-rc7

for you to fetch changes up to d2394860b45c3c1484e4b0a5d09909a1e3f6569e:

  cpufreq: mediatek: Handle sram regulator probe deferral (2022-07-13 16:51:32 +0530)

----------------------------------------------------------------
cpufreq arm fixes for 5.19-rc6

- mediatek: Handle sram regulator probe deferral

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      cpufreq: mediatek: Handle sram regulator probe deferral

 drivers/cpufreq/mediatek-cpufreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
