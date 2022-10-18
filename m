Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B426029BD
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 12:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRK7J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 06:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJRK7I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 06:59:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F72018B08
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 03:59:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 3so13732181pfw.4
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjZrb1uzpbSUsdu2NYCKr+VDGTAZuOVG9k6PDOH9SH8=;
        b=U0xNZMf2P7wU0KWO4d0yC31koip3X809RrpWvWvmnoSXbcMahU0oQ1NEpIpTDhwPwl
         AWHSP/VR36bVW/hKESTZNHrSxndiKSNO+U3GXURY7YKt+b078TZw9dvNHweHsFkz/34h
         655prfYFrnhDKLGbBky9VuK9iagP0a1l1+ncTOkvpnK+IB/obw2TH00fW5+zptnTWfVY
         OdTrrNxDdx+OIBY6ByrCNhkFsn+pXxTSGn9KL2jvxiNQps1giJpCDgn0bz1b/o8DNJcI
         K3oYX3TzX9fL1WuB0GPaCvSK+qbSpboJhtlsiQTNMV7g7Dmqv2e5GjcXDPCZzQ5B3mKp
         RefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjZrb1uzpbSUsdu2NYCKr+VDGTAZuOVG9k6PDOH9SH8=;
        b=1VEVpOGWMHlh6VIt/MXKM7EFFi1AoegasCJ4QF5N7t+32nw7Or47AJdZMHunc65xKU
         DxRy9+H+KeyyOtWCy+Ar0ADui2FTxrXA2QqIHixGfKaLF3KblCB/0z/3etcdd+yy7Ue7
         Qg+Vl9g7iEdQhTBcJm+CiNH/mq4DeKByRSu4iXWkZCAJ69BnF44H/k6Omfu2DsIy/jRq
         Oo6DnZlPr6Yv4Fi8SHiSI4b2Fu81Bk7ZMyXPbwolnCl/c3K7W6FhbqCUJmTVTJMcMpLi
         5tbI6BEd1mhETyLucOznhxfo7no7FaCI0UGtlchN2j8KztfkCYO/pHzpMPda99r3TWnW
         jpPg==
X-Gm-Message-State: ACrzQf3KGuI0/T9hmcqnzXsC4xBfzEy2w62fu8YaCLFo+0QNtDA+0Elz
        iOAHKRylpn1tNzmZr3WDTJYeMA==
X-Google-Smtp-Source: AMsMyM7Q2PnXduUe1V1hQQCwdHjECKqshmSQUsg6F6G8YO9m1grBo7b81eBGG8bRFhgLNjsfFX5RGA==
X-Received: by 2002:a05:6a00:24c9:b0:563:b4b8:cee with SMTP id d9-20020a056a0024c900b00563b4b80ceemr2616363pfv.36.1666090746510;
        Tue, 18 Oct 2022 03:59:06 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b00172e19c2fa9sm8394432plg.9.2022.10.18.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:59:06 -0700 (PDT)
Date:   Tue, 18 Oct 2022 16:29:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 6.1-rc
Message-ID: <20221018105904.ab3mtqgja5jk3twf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-6.1-rc

for you to fetch changes up to 889a50aedcd216cc5f2b98bb2412f0498d417721:

  cpufreq: sun50i: Switch to use dev_err_probe() helper (2022-10-18 16:22:26 +0530)

----------------------------------------------------------------
cpufreq arm fixes / cleanups for 6.1-rc

- Fix module loading in Tegra124 driver (Jon Hunter).
- Fix memory leak and update to read-only region in qcom driver (Fabien
  Parent).
- Miscellaneous minor cleanups to cpufreq drivers (Fabien Parent and
  Yang Yingliang).

----------------------------------------------------------------
Fabien Parent (3):
      cpufreq: qcom: fix memory leak in error path
      cpufreq: qcom: fix writes in read-only memory region
      cpufreq: qcom: remove unused parameter in function definition

Jon Hunter (1):
      cpufreq: tegra194: Fix module loading

Yang Yingliang (4):
      cpufreq: dt: Switch to use dev_err_probe() helper
      cpufreq: imx6q: Switch to use dev_err_probe() helper
      cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper
      cpufreq: sun50i: Switch to use dev_err_probe() helper

 drivers/cpufreq/cpufreq-dt.c           |  6 ++----
 drivers/cpufreq/imx6q-cpufreq.c        |  4 +---
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 25 +++++++++++++------------
 drivers/cpufreq/sun50i-cpufreq-nvmem.c |  9 +++------
 drivers/cpufreq/tegra194-cpufreq.c     |  1 +
 5 files changed, 20 insertions(+), 25 deletions(-)

-- 
viresh
