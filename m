Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF63D79A9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhG0PZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 11:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhG0PZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 11:25:43 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87529C061765
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:14 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z24so12683906qkz.7
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZK1Rd7NI6DtGUw1dux730psOSqbcpXN58j1qSdbMgw=;
        b=LyivXD0axHeLtbIXnUVgA+/WCdkotHzXVnEE4eZ/UmyvGPpdTR6C89BexzAd0cJFKW
         nP0hzyiASsVa9xQb4tTfTQ8iyzdqHS5fsiFUYQOYGc2x+5lpNWTy2j/XAN65Nkzh4uYd
         vI5kjNalDupkycWtjP8Gt+urgAGi7CJZfqMLzx84E66gxtBPGo35KuYKSYoTF/K2bnea
         KFLkScwOgFyz7jS2AWGqVgiqQMV0AzXdS7/5WxmP21KlTgTQQZtkAVtdT1PpxEuISgxk
         1zY/LWtWV/KXKD1J3qdGU6zdP9o/AgZN4OKX6K2MVEcYDnqBqhMrEI8QS3OEvOGeLdeo
         udUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZK1Rd7NI6DtGUw1dux730psOSqbcpXN58j1qSdbMgw=;
        b=S42S+4hZYNqL0TeQvNksBpnH/O/s464gzdCPMwDTBWXpdwpIvtG+gLJSDddsEsK8v8
         AKrMS/C4KS7Ep4aeYMN6rI9adXnyLGBHAKRtpFOsdEVqcLVp+Jhfs599ijyLSxfACRr8
         gCycXXTcXVp79bAsFgBNrcFH7j11CQHUJwaKUQ4KbvxsiCOBZPMWaVFElGL4u+evgHAR
         R1SyzxoFn/Y+ge4UzC7gIPpKAWx7fJ+FFQllkvGRO0CicBAz6fIv9EPBPBIVkrZCyr6h
         Nqtf1zEqZHAB1EPlqAszl36Np5G7uKs45oZ/SrUf6BbvFXeL7kuuzArFeN9c97a5AgYS
         W0qQ==
X-Gm-Message-State: AOAM533ObDsRODuNFrGOIl4cXReG7DMC3qlnhjdm+94/C2VtKN5ZeFF+
        DbswwTBwF6RSCAZM4jDOLGm1YA==
X-Google-Smtp-Source: ABdhPJw0MS12bAyHiKyVFbaWv2yJeAcpz8la/FAT+4Xeykk3cUg8jC/lY+rhfv8wuWTna2zI2mzPJA==
X-Received: by 2002:a37:313:: with SMTP id 19mr22335450qkd.295.1627399513547;
        Tue, 27 Jul 2021 08:25:13 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id q4sm1539663qtr.20.2021.07.27.08.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:25:13 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [Patch v4 0/6] Introduce LMh driver for Qualcomm SoCs
Date:   Tue, 27 Jul 2021 11:25:06 -0400
Message-Id: <20210727152512.1098329-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Limits Management Hardware(LMh) is a hardware infrastructure on some
Qualcomm SoCs that can enforce temperature and current limits as programmed
by software for certain IPs like CPU. On many newer SoCs LMh is configured
by firmware/TZ and no programming is needed from the kernel side. But on
certain SoCs like sdm845 the firmware does not do a complete programming of
the h/w block. On such SoCs kernel software has to explicitly set up the
temperature limits and turn on various monitoring and enforcing algorithms
on the hardware.

Introduce support for enabling and programming various limit settings and
monitoring capabilities of Limits Management Hardware(LMh) associated with
cpu clusters. Also introduce support in cpufreq hardware driver to monitor
the interrupt associated with cpu frequency throttling so that this
information can be conveyed to the schdeuler via thermal pressure
interface.

With this patch series following cpu performance improvement(30-70%) is
observed on sdm845. The reasoning here is that without LMh being programmed
properly from the kernel, the default settings were enabling thermal
mitigation for CPUs at too low a temperature (around 70-75 degree C).  This
in turn meant that many a time CPUs were never actually allowed to hit the
maximum possible/required frequencies.

UnixBench whets and dhry (./Run whets dhry)
System Benchmarks Index Score

                Without LMh Support             With LMh Support
1 copy test     1353.7                          1773.2

8 copy tests    4473.6                          7402.3

Sysbench cpu
sysbench cpu --threads=8 --time=60 --cpu-max-prime=100000 run

                Without LMh Support             With LMh Support
Events per
second                  355                             614

Avg Latency(ms)         21.84                           13.02

v3->v4:
	- Rebased to v5.14-rc2.

v2->v3:
        - Included patch adding dt binding documentation for LMh nodes.
        - Rebased to v5.13

Thara Gopinath (6):
  firmware: qcom_scm: Introduce SCM calls to access LMh
  thermal: qcom: Add support for LMh driver
  cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
  arm64: dts: qcom: sdm45: Add support for LMh node
  arm64: dts: qcom: sdm845: Remove cpufreq cooling devices for CPU
    thermal zones
  dt-bindings: thermal: Add dt binding for QCOM LMh

 .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 162 ++----------
 drivers/cpufreq/qcom-cpufreq-hw.c             | 142 +++++++++++
 drivers/firmware/qcom_scm.c                   |  58 +++++
 drivers/firmware/qcom_scm.h                   |   4 +
 drivers/thermal/qcom/Kconfig                  |  10 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/lmh.c                    | 232 ++++++++++++++++++
 include/linux/qcom_scm.h                      |  14 ++
 9 files changed, 587 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
 create mode 100644 drivers/thermal/qcom/lmh.c

-- 
2.25.1

