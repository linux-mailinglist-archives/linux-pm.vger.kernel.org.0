Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476D755DF3D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbiF1IIR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 04:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiF1IIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 04:08:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCA27176
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 01:08:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so15048110pjl.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0oSmaLR+28Vey1AntXDwzdvwmM5t4l3rGQbsZ0pL0kU=;
        b=ULrEtJ6miGSFek07X2ReqvueYRylLFYHtMtwhB3RFbAT4cE18E5Kkp2GfVqkzKkVps
         AnFyxTBidjy+3Ll+FVZBTFYErmS5Yv3mC/fAygfT0sADQVbTTz19BgAttE9iG/2JCkph
         MANM41S/oATkml7FWLADOA6SPgaZmPczO7nvjjHJVQAF/O3J/SuoDVYBY/9G3wkjP5PV
         z5JEi5WXVUZp1UvnS9RTRqUudVaqTJkjPeecaYGDLvhmWMT/iMze1zzqz9kgc5Y3dd/O
         xwS4scwTvwThRj/sCi+G8UqCHHFz6ROJEWFNqYkkxanS57nvX7G+F303o76/RWsB8JhV
         gWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0oSmaLR+28Vey1AntXDwzdvwmM5t4l3rGQbsZ0pL0kU=;
        b=xM9nJn2GBzxvZUubYTYTiSKBfSUIH4mxWdps0T8P8AAwadMq8ShH2cmzpt+Rl/tRs2
         mqOnLgxldNUPU+9W+fna0+hwAd+LtDpFY3YOZDsdT038AQwfBRKeZMqqAy8XzaTZ6Daj
         f8WpqMH0xNRkyEZ1yb0fl5pXqgb04/8hIkr/X8iFz/v5GyfYt+G52Vz2OWAdCd/i94A1
         U6Po5FOA4EaFgwdmJlxxyWn1exRCxVLAqi515H+4eZMgJDVF5XWV9uNXdzQ3bKb5l3nx
         sL4fkBdgv/rv98UwCLerswuOjq+PkEH/I3QkokI2xcmxyWzywh9dWLN5NORCqq75IDl3
         6WEw==
X-Gm-Message-State: AJIora9gf4SgWAkLuE7RwG3SGAVYNinzpR1cZ8gWBjMzDdQQMwQUB/XM
        A4MrsHQLbEIT+38T70GLG7CIlA==
X-Google-Smtp-Source: AGRyM1t2E0Whkd9xD25Gd5EgPgoheHr1FJ6pE7dacByOyFMVTJP3x/3gsYn8tVI6Ca52eJf0ms/6Qw==
X-Received: by 2002:a17:902:e48c:b0:16a:9fc:9a7e with SMTP id i12-20020a170902e48c00b0016a09fc9a7emr3746268ple.51.1656403695745;
        Tue, 28 Jun 2022 01:08:15 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b0051ba303f1c0sm8665795pfw.127.2022.06.28.01.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:08:15 -0700 (PDT)
Date:   Tue, 28 Jun 2022 13:38:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 5.19
Message-ID: <20220628080812.twfoo2tzot3m32i2@vireshk-i7>
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

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-5.19-rc5

for you to fetch changes up to be4b61ec45b3efe5e9077525fc92d544305eb2a6:

  cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist (2022-06-28 13:34:56 +0530)

----------------------------------------------------------------
cpufreq arm fixes for 5.19-rc5

- Fix missing of_node_put for qoriq and pmac32 driver (Liang He).
- Fix issues around throttle interrupt for qcom driver (Stephen Boyd).
- Add MT8186 to cpufreq-dt-platdev blocklist (AngeloGioacchino Del Regno).

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist

Liang He (2):
      drivers: cpufreq: Add missing of_node_put() in qoriq-cpufreq.c
      cpufreq: pmac32-cpufreq: Fix refcount leak bug

Stephen Boyd (1):
      cpufreq: qcom-hw: Don't do lmh things without a throttle interrupt

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/pmac32-cpufreq.c     | 4 ++++
 drivers/cpufreq/qcom-cpufreq-hw.c    | 6 ++++++
 drivers/cpufreq/qoriq-cpufreq.c      | 1 +
 4 files changed, 12 insertions(+)

-- 
viresh
