Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795E0663807
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 05:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjAJELb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 23:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjAJEL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 23:11:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC1DF36
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 20:11:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso10295188pjl.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 20:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjTYM2M5jCHaf6eyBj5sIhfES0Fy7EPHG4zUMmuKJXo=;
        b=iEVUklb8oAgoSs094Sc2W7FZRF38N0HL65kZCzUtCHTyH4m5a01KSTHINMT/XTYP8R
         0Xt8+sJZ8EwzqTknQEm4UALlYZgAQg4Vf6hSjmPaGQ/+oCE5n6VvhanKJ+5QAs52YwyU
         U285wTOQOGfMPcQyLs9sillkBzffOlrkLFYug2sQ+YSMlI2xbsLbYpo35tGuCJpCqyp6
         jk8w7kmQpIqSN/b6pngcymzP0UDUl83DfLkAqnQugEeIp1Jo2HyWvoFmxurno0rjnkfc
         S0FnkqP5TpOuM61dRK/Di49ZGDnZcOJiQvW+WMpSiUZsp92ZTNKszapIbOkm+LykDgTU
         wTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjTYM2M5jCHaf6eyBj5sIhfES0Fy7EPHG4zUMmuKJXo=;
        b=vypiPgluXqZZKUX17hKN54LHlUgEN/HJu1AB8N4ewA1BlO9jsiyDSaYgvf7NzOH36Q
         lY/C0GUqD/n6H0kFU2tUDAwxKQO8EnpQ7Qz90Zzzzq76vj8d9fUPm/Yqskf9Ov0O6zee
         CPnc1eI5NK8WduLaxb4JMRrgsDTkz5ZhB1oFyNBOV3cbat5CXE2EpZHPCLflw8JkRTLB
         Pkk26z9NtpmmqrKFExXvSMIPIOzWaCxD4bW+iRLwFa4U9CYR+uXAsZJPqvAVNn5qZOft
         nQ93ZcGM6rugDYDJNWCcFyfhUDbWmUh0oKElmUlbZDJV4HtkXzuGT/1WhInrPZeP2zut
         I+mQ==
X-Gm-Message-State: AFqh2krlGwe7x1S2Xj7VmBIqqGELja1VkuLF0kJaLwPU2T1l+cDQMaJh
        qT1gE1NCYvoEQqyn9GUM6TRWwA==
X-Google-Smtp-Source: AMrXdXspGRV1y2qWHxOEU1tyDQJej282H0Mio/YwudPwENIw/86slqS2H8u+Rw+Bh2vrbPJg3fZRrQ==
X-Received: by 2002:a17:902:eb84:b0:192:9094:cbb6 with SMTP id q4-20020a170902eb8400b001929094cbb6mr43130102plg.65.1673323887792;
        Mon, 09 Jan 2023 20:11:27 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b00176b84eb29asm6810416plb.301.2023.01.09.20.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 20:11:27 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:41:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 6.2-rc
Message-ID: <20230110041125.tamqbqec5aqyck22@vireshk-i7>
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

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq/arm/fixes-6.2-rc4

for you to fetch changes up to 08f0adb193c008de640fde34a2e00a666c01d77c:

  cpufreq: armada-37xx: stop using 0 as NULL pointer (2023-01-10 09:32:03 +0530)

----------------------------------------------------------------
cpufreq arm fixes for 6.2-rc4

- Fix double initialization and set suspend-freq for Apple's cpufreq
  driver (Arnd Bergmann and Hector Martin).

- Fix reading of "reg" property, update cpufreq-dt's blocklist and
  update DT documentation for Qualcomm's cpufreq driver (Konrad Dybcio
  and Krzysztof Kozlowski).

- Replace 0 with NULL for Armada driver (Miles Chen).

- Fix potential overflows in CPPC driver (Pierre Gondois).

- Update blocklist for Tegra234 Soc (Sumit Gupta).

----------------------------------------------------------------
Arnd Bergmann (1):
      cpufreq: apple: remove duplicate intializer

Hector Martin (1):
      cpufreq: apple-soc: Switch to the lowest frequency on suspend

Konrad Dybcio (2):
      cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2
      cpufreq: Add SM6375 to cpufreq-dt-platdev blocklist

Krzysztof Kozlowski (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: document interrupts

Miles Chen (1):
      cpufreq: armada-37xx: stop using 0 as NULL pointer

Pierre Gondois (1):
      cpufreq: CPPC: Add u64 casts to avoid overflowing

Sumit Gupta (1):
      cpufreq: Add Tegra234 to cpufreq-dt-platdev blocklist

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 11 +++++++++++
 drivers/cpufreq/apple-soc-cpufreq.c                            |  3 ++-
 drivers/cpufreq/armada-37xx-cpufreq.c                          |  2 +-
 drivers/cpufreq/cppc_cpufreq.c                                 | 11 ++++++-----
 drivers/cpufreq/cpufreq-dt-platdev.c                           |  2 ++
 drivers/cpufreq/qcom-cpufreq-hw.c                              | 22 ++++++++++++++++++++--
 6 files changed, 42 insertions(+), 9 deletions(-)

-- 
viresh
