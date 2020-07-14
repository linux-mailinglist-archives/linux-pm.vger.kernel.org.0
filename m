Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25C221F558
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgGNOuy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNOux (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:50:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812EEC061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so22189594wrp.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBVqVVxkCFPydp4gvp9N47SqJWklBSjEVbb+D1SR9xk=;
        b=h4Qh+z+ZYyiSuOo8neI6v9IW6E6TBYraxSGCGVufzc2pHG3de81R08TAFRAePhzBt3
         ezeF0XHmPEY1tN5gWpjs6Gg06ggJfxXjQsbUqpcz4ygJbWN1rTmQh2puteU/Ziwdntp9
         xed8JgYu3+7aYxoE64ZaV5ZxxflplAu6Mli2v44IYL35Z1LoHdixyzkLCNhVQP74z0Nb
         JBORxe2cTAWJuCiQ2qQ+FpNidrabz+Ddaz2Px9oe30miQFL0XZOWCP81XTNU8mpxfKAW
         FqMJ6fEqQCS5MVm6EZRAcGmCVst/fsjc+VtfFVNHzMvPMPCLx9CBfN1bbdvmXu8skwOi
         OPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBVqVVxkCFPydp4gvp9N47SqJWklBSjEVbb+D1SR9xk=;
        b=dJUQ+WR+LG5wkaeGW7X5LjH47hSjsrEPiMoua9iJmtEcP2C1pxSV6vXWF0E7hwj7Hr
         qgR6YxLXxM5sGPLd6SLb1Ju/6cPZrwIwi3okXI4cCaNOeVdpsVfTH/fkRq3I0p7Zq7cR
         SZ1CvwOA4Ccz4gwEOerTCYHkzB7Lk3v1pFjH9cqo5lNWbmYr1i/P/gDdrlTKdIO4vac2
         wVtLzrCMWhC6aTICpm1Ysh93VC4tGmT1y5P76h0pxQ5m5Mb2nkffsIYPkprxjbNn7otd
         R4xAJWhTZqK093WZuxFZE5mBv8whl39HSkJvO8nvSw8oruC4B+PbpFkaBNe7TAcA+oST
         vZQA==
X-Gm-Message-State: AOAM532rAJdTFniAtljBZon7VOkPfXNVB5/WaHuRo8lSJ7Ep1Iz5DbUq
        Fyai6wlBjdbSsFSgUN+r+ev76Q==
X-Google-Smtp-Source: ABdhPJxuJWZr/PeYSTFC+BJW8N1mAYAM+CjOxNV7UC21YCNpd0wztJ6jfBeMlZDcmUeWJrORwMd9+Q==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr6007105wrr.11.1594738252169;
        Tue, 14 Jul 2020 07:50:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/13] Rid W=1 warnings in CPUFreq
Date:   Tue, 14 Jul 2020 15:50:36 +0100
Message-Id: <20200714145049.2496163-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/cpufreq.

Hurrah!

Lee Jones (13):
  cpufreq: freq_table: Demote obvious misuse of kerneldoc to standard
    comment blocks
  cpufreq: cpufreq: Demote lots of function headers unworthy of
    kerneldoc status
  cpufreq: cpufreq_governor: Demote store_sampling_rate() header to
    standard comment block
  cpufreq: sti-cpufreq: Fix some formatting and misspelling issues
  cpufreq/arch: powerpc: pasemi: Move prototypes to shared header
  cpufreq: powernv-cpufreq: Functions only used in call-backs should be
    static
  cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc related issues
  cpufreq: acpi-cpufreq: Take 'dummy' principle one stage further
  cpufreq: acpi-cpufreq: Remove unused ID structs
  cpufreq: powernow-k8: Make use of known set but not used variables
  cpufreq: pcc-cpufreq: Remove unused ID structs
  cpufreq: intel_pstate: Supply struct attribute description for
    get_aperf_mperf_shift()
  cpufreq: amd_freq_sensitivity: Remove unused ID structs

 arch/powerpc/platforms/pasemi/pasemi.h    | 15 -----------
 arch/powerpc/platforms/pasemi/powersave.S |  2 ++
 drivers/cpufreq/acpi-cpufreq.c            | 16 ++----------
 drivers/cpufreq/amd_freq_sensitivity.c    |  6 -----
 drivers/cpufreq/cpufreq.c                 | 32 ++++++++++++-----------
 drivers/cpufreq/cpufreq_governor.c        |  2 +-
 drivers/cpufreq/freq_table.c              |  6 ++---
 drivers/cpufreq/intel_pstate.c            |  2 ++
 drivers/cpufreq/pasemi-cpufreq.c          |  1 +
 drivers/cpufreq/pcc-cpufreq.c             |  7 -----
 drivers/cpufreq/powernow-k8.c             |  2 ++
 drivers/cpufreq/powernv-cpufreq.c         | 15 ++++++-----
 drivers/cpufreq/sti-cpufreq.c             |  8 +++---
 include/linux/platform_data/pasemi.h      | 28 ++++++++++++++++++++
 14 files changed, 70 insertions(+), 72 deletions(-)
 create mode 100644 include/linux/platform_data/pasemi.h

-- 
2.25.1

