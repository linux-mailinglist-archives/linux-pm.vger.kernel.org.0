Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE450F185
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiDZGzu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 02:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245523AbiDZGzs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 02:55:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7113B2B4
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 23:52:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so17128654pfb.4
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 23:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/Jn6JRL5sfoRV4Gy9LseiyMixgXx7JBmdIMlpUBj6c4=;
        b=TDeWo+RqrUaHGKlI56zWgv/AXphWJmCnxRofyNn59emF+Ow2nqaRwkqqys655bkj07
         7KnWsi/MYHk8eWksjb+JyQFeGzzbkD7gzbPMXtuZeaSdzLk19xTEt82QkkdqvjuOFqUy
         n27qIsqtTh88fRW3ddi3DWdb8ldsx90TzZuXJkNZBlaIQlwYdLa0rk8O5sXwkrsNenMy
         1kzjMdpYZbIZFL24m1BW3wDLihdn3Epkzkretr56G6CVaRyL2tur8/AnPhfLlt6LfHOM
         LOOLW4TSRcRtEtbUSvkLC0vSYwTtl+GM54jUZJLgQxIlwuDnt+8cc8n/b0c/TC0AM3Cv
         WCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/Jn6JRL5sfoRV4Gy9LseiyMixgXx7JBmdIMlpUBj6c4=;
        b=MskS0KIySYZnv1BBntk2VnwOkVZi5cXHHojaRODWXBJNOVoFEf/Riyp+gEAa5jjjC8
         c2/ukX322jWMj766wYUH/j+7XvEWKnJsXUpdABBPZ6SdVet85nxxa+pBUA9Aa9ZoWLmQ
         ztrEy/JA8k/Bj3l5OWcWcJjgZJmYeNXPHMvJhOvMR9EGpC6W8a1GClpHLS1T6EPfo+0v
         9Jj4GV+zgfSIm664/X2axQ3Cfojdbl6Nzp50zpXKdjAAkNaUm1SDug9Jbn/Fo3pAf2vc
         o2qkMEvuFOrQTqGCf8nOt7QI+QJMnvesOeoiQdMvvKBYRfPstzpbA5uFkysX6mZDcKNA
         FROA==
X-Gm-Message-State: AOAM533xpVYjr04j4AV7qA5UOw9GYSLGSExk8K5E7nYdBh60RWK3I/7e
        n1PiBYhGIggi2QyTIQOaI2JHNQ==
X-Google-Smtp-Source: ABdhPJyHvi33/8BBGBbPBJOzp0kWz2eHET4V6m70sh+riTBclwVgEu6jDHz03xnbagsgKAPdo66vEw==
X-Received: by 2002:a63:ed45:0:b0:399:5116:312a with SMTP id m5-20020a63ed45000000b003995116312amr17884832pgk.611.1650955961699;
        Mon, 25 Apr 2022 23:52:41 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id la10-20020a17090b160a00b001d6a79768b6sm1506535pjb.49.2022.04.25.23.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:52:41 -0700 (PDT)
Date:   Tue, 26 Apr 2022 12:22:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 5.18-rc5
Message-ID: <20220426065239.qtho7kwvdohqnff2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-5.18-rc5

for you to fetch changes up to e4e6448638a01905faeda9bf96aa9df7c8ef463c:

  cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts (2022-04-26 12:08:31 +0530)

----------------------------------------------------------------
cpufreq arm fixes for 5.18-rc5

- Fix issues with the Qualcomm's cpufreq driver (Dmitry Baryshkov and
  Vladimir Zapolskiy).
- Fix memory leak with the Sun501 driver (Xiaobing Luo).

----------------------------------------------------------------
Dmitry Baryshkov (4):
      cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
      cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
      cpufreq: qcom-hw: fix the opp entries refcounting
      cpufreq: qcom-hw: provide online/offline operations

Vladimir Zapolskiy (2):
      cpufreq: qcom-cpufreq-hw: Fix throttle frequency value on EPSS platforms
      cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts

Xiaobing Luo (1):
      cpufreq: fix memory leak in sun50i_cpufreq_nvmem_probe

 drivers/cpufreq/qcom-cpufreq-hw.c      | 70 +++++++++++++++++++++++++++-------
 drivers/cpufreq/sun50i-cpufreq-nvmem.c |  4 +-
 2 files changed, 60 insertions(+), 14 deletions(-)

-- 
viresh
