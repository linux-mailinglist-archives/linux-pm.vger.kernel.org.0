Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387155EA30B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiIZLS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbiIZLRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 07:17:23 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51C352DCA
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 03:38:01 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id w2so6303293pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=ozeuGbffsz9VQevD2B7TcMavPkcWty6jR/2LRd7H8vw=;
        b=lJgPhFPUPQjQ2ti8YYiid1h5Jb3k7iBflRxGlCCLArhtmHWm55vQN1q7UX/Nu0pIyY
         R67THD5pH/vLT4mvGEZesOBBZKGgorzPret55d+1jtlLU8qfh06B3Vp5yIMjlgWSzSrH
         KcQVvcxCzsL0nWMOoDLHY/Qf6ggjH5I7R4MCu9YgRG1t6P6+0RAlYjnrX5spbH384G7I
         WgQZSYNmkovF/J/NzKFffb+FMXCRncxMakXhYcK8gHLn6qfwoOIUVevwnfc2PFIBnUUs
         VQw0DA4PJ3PcdZnk6r26u2kRoE9+dGBJAHMxiHzj7m7licmkn7wp/tcwWQLKAlIwx1K3
         4tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ozeuGbffsz9VQevD2B7TcMavPkcWty6jR/2LRd7H8vw=;
        b=H8tS/fqw6+VIhHOy7/lRmQUCaYq6j/tfM+bj+boyrZJVLii0M+j2O2+QgQMjzCdjC9
         4EEpynBBmAK92VuhEFuONt1zQmPwPYpLEJ/w4OrIFlRL0yzT8cVPxyGqmgl8heiiF/2T
         SrGA9zCuD254+EsZQRImCZpNjrFH2KEj8q9FSY+haQVskQ9G5mpkTj4gFSA2yplGPtSk
         1pp0UZK4n4JLoyTAEKyEcRZMcyt3pIN6gtuq07foNcwEwS7IyZLGyCUQRfv1x2JyQRu3
         4rggcuQf3vR6GYxJN84chtLQOx/WGbj+Jr31c2vv0YPzlDmj23/JPkLcDF1QaxTR7Q4A
         Nqnw==
X-Gm-Message-State: ACrzQf27mrC5Y5jZ3Ar1Nnu4a7fZBkQBrv14Hqj1mE71+CWv5viSiuTP
        gL6VDoVSG3CRXalDFrKWwA737BdtdRM/pQ==
X-Google-Smtp-Source: AMsMyM5zateHP75Xx1ifp+770Xw0K/UfJL3WwnIQVTUmBjCcXCn/ErTqyuy46ofZYexhuHin8+mf6A==
X-Received: by 2002:a05:6a00:168e:b0:53b:3f2c:3213 with SMTP id k14-20020a056a00168e00b0053b3f2c3213mr23173920pfc.56.1664188523618;
        Mon, 26 Sep 2022 03:35:23 -0700 (PDT)
Received: from localhost ([122.172.85.153])
        by smtp.gmail.com with ESMTPSA id y72-20020a62ce4b000000b00540c8ed61ddsm11598545pfg.150.2022.09.26.03.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:35:22 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:05:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.1
Message-ID: <20220926103520.jzqzjijbnfrr24yt@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.1

for you to fetch changes up to c4c0efb06f17fa4a37ad99e7752b18a5405c76dc:

  cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh (2022-09-26 14:05:45 +0530)

----------------------------------------------------------------
cpufreq/arm updates for 6.1-rc1

- Add SM6115 to cpufreq-dt blocklist (Adam Skladowski).
- Add support for Tegra239 and minor cleanups (Sumit Gupta, ye xingchen,
  and Yang Yingliang).
- Add freq qos for qcom cpufreq driver and minor cleanups (Xuewen Yan,
  and Viresh Kumar).
- Minor cleanups around functions called at module_init() (Xiu Jianfeng).
- Use module_init and add module_exit for bmips driver (Zhang Jianhua).

----------------------------------------------------------------
Adam Skladowski (1):
      cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist

Sumit Gupta (1):
      cpufreq: tegra194: Add support for Tegra239

Viresh Kumar (1):
      cpufreq: qcom-cpufreq-hw: Fix uninitialized throttled_freq warning

Xiu Jianfeng (1):
      cpufreq: Add __init annotation to module init funcs

Xuewen Yan (1):
      cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh

Yang Yingliang (1):
      cpufreq: tegra194: change tegra239_cpufreq_soc to static

Zhang Jianhua (1):
      cpufreq: bmips-cpufreq: Use module_init and add module_exit

ye xingchen (1):
      cpufreq: tegra194: Remove the unneeded result variable

 drivers/cpufreq/bmips-cpufreq.c      | 10 ++++++++--
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/highbank-cpufreq.c   |  2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c    | 24 +++++++++++++++++++-----
 drivers/cpufreq/sti-cpufreq.c        |  2 +-
 drivers/cpufreq/tegra194-cpufreq.c   | 35 ++++++++++++++++-------------------
 drivers/cpufreq/ti-cpufreq.c         |  2 +-
 7 files changed, 47 insertions(+), 29 deletions(-)

-- 
viresh
