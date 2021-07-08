Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F903BF9C0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhGHMJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhGHMJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 08:09:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F5C061760
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 05:06:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g12so4638130qtb.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WraCm6k694qyYZdK9xEDzADtbPmoM6wh7ruMF3c9sT0=;
        b=ooXDU9ur9KqdBlX6bSV3k88fMSWEpbTCC5Kpt1F9uzG3Gzg4wQeTWPXlVVs9CylHHS
         eEKbJPm21Ur3c6zSEG0znz/VLOPWIK+jp1rF+BSYCuCgC8Bhofc0ILZ4MnTPhxUL2ES0
         jzxbIwh4RqQLf4KddXHHVO0dEvmL373dxEjwkWbmfaoCQKz7GNengI4yO1Tz+YFITGb0
         G9xTikM6/8K2mYvPZg8ZHaqxdoguMGdUwOrZRh3RX6EGCY6jQXAbfpzxt+sDfNsf0xfz
         y3flDutrawBHu0GtBOfyCHQjOPeenB1WZa99D1Xb0vGBGTsr6+xQ/J43WiJksKzZZI8i
         mhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WraCm6k694qyYZdK9xEDzADtbPmoM6wh7ruMF3c9sT0=;
        b=VckNq/VEnpbY8vUrXfQKXSfCVRxSrORNm2cAqeUvoEL0jfzQWXeSmj6X4Ur3jbfT5j
         AJpkKj1KxnUlMijUqif2X/XDVyGsz8l/1oNYjHhMG6SrqMYvhTdILtF8dqlJzWNK8cAX
         jo848U1LpYLwfY+cBGsmPVgeQsC6U+IHUVC3PQwpD/c+nzMYAK7gNIdnmMaODyMUpm1K
         N1av7RfJ+Bc3+qYUEwY5mzDe9pubE8oXu+kFXkeZEan8Pnsf2ViqMN1ZNPmUx7ERdmvP
         OIchtp3/Cc/dvUSTEHcUv3tYX96iPxB7gBj6vpCqOnyHgGACp1gb26VQRYYCDUyP0kog
         sLCQ==
X-Gm-Message-State: AOAM531q7fqQ/CS9qK+93YR7dnxHZDp2OZEDO+kZ8cnesss3HMXbOyI0
        xy7DnDsgGt+huEqhpWAhRMwjCA==
X-Google-Smtp-Source: ABdhPJwpRfkMwjPp9U/1oZkibxvoQP+bjlbHKSCDkFJsNoCT4uIFKSTrQ03gIVxwkC67HJsfh5IQ3w==
X-Received: by 2002:ac8:5c08:: with SMTP id i8mr28001007qti.129.1625746017582;
        Thu, 08 Jul 2021 05:06:57 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i2sm912541qko.43.2021.07.08.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 05:06:57 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v3 0/6] Introduce LMh driver for Qualcomm SoCs
Date:   Thu,  8 Jul 2021 08:06:50 -0400
Message-Id: <20210708120656.663851-1-thara.gopinath@linaro.org>
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

v2->v3:
	- Included patch adding dt binding documentation for LMh nodes.
	- Rebased to v5.13

Thara Gopinath (6):
  firmware: qcom_scm: Introduce SCM calls to access LMh
  thermal: qcom: Add support for LMh driver
  cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
  arm64: boot: dts: qcom: sdm45: Add support for LMh node
  arm64: boot: dts: qcom: sdm845: Remove cpufreq cooling devices for CPU
    thermal zones
  dt-bindings: thermal: Add dt binding for QCOM LMh

 .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 162 ++----------
 drivers/cpufreq/qcom-cpufreq-hw.c             | 118 +++++++++
 drivers/firmware/qcom_scm.c                   |  58 +++++
 drivers/firmware/qcom_scm.h                   |   4 +
 drivers/thermal/qcom/Kconfig                  |  10 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/lmh.c                    | 239 ++++++++++++++++++
 include/linux/qcom_scm.h                      |  14 +
 9 files changed, 570 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
 create mode 100644 drivers/thermal/qcom/lmh.c

-- 
2.25.1

