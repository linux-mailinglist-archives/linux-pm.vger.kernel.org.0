Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12F5284824
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 10:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgJFIJE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 04:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFIJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 04:09:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C31C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 01:09:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so1187114pju.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=IM2k4cVlmtEK6muT2xOn1tB16P30SzlvEHjvukRzcWU=;
        b=moBV0FCOYwTDIBQRoXVTchQU96Qj5A+SjvBpxWW1Z5QEW7wMMJByzKG74Sjwhf0iZt
         pZmgyeJBQUldylp3kTMnUpQIvmVVhvKcLEBXxysg/cebplaW2MtdKTAC7BqCc24Ok8xX
         x77BQfK3IY2DCywn/8SrHgOAs4430NuU5slAIXt82vPyhIygiPP/bJTaavYB3eQm6rlR
         UniqqisbJek5jQpfXaWX9X9b1HBu8wwIGMYaCJ+qtljSJpwEHCn0gQgPsW8ggIwSIxVT
         9MlP8VozbwKAqXcPTHtGqRVHFiUyYueaT249/TIL5ss3UNrk8O2DbcJvH4xc/euoVNgP
         8mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=IM2k4cVlmtEK6muT2xOn1tB16P30SzlvEHjvukRzcWU=;
        b=jOkQJHo0Cd4KAshsiJ623piTEAyCm0XmZvFhT0XfxO3AxN2vPynxzXYMsxJHKermh8
         X3dN24uRKPgHJ3tK+ur58bsal9HYF/8zzBQwDD9OOwuslljgm04VaFbMLfxaohVRXKC9
         8PTT52NJ0kFQ1jVOGk0HdoE8Nr/Octj9/B78D6UBB9m201oGz0jE3mmyLrRHqZlKi0h6
         dE3tnPjqP4UDoa7qwBC9h6evrftpJvsaXEb1hurmH43WGPYyTVSf3gntGW4MkBHmK81y
         guXmpo9NXX6/zLCEDMsKQBzZlRdShRQOFd/MFeCM3qNAT84+1cdxzymjJ/kiJnvtEGIP
         Ba4g==
X-Gm-Message-State: AOAM530+BFST2oAVHis7i1KbwpSDOaGGBnJeoR1r4rntAem6PhFiD3SK
        7uWH3tmpAma53gHTn91RhW2DCh2bQ4DFjg==
X-Google-Smtp-Source: ABdhPJxQpVbXZ+k0A0VOHtGzOM1IAwKXihWel8dFSCcHye/B8808DDd4Yv6JayQq6wrnowMETXnnGA==
X-Received: by 2002:a17:90a:840d:: with SMTP id j13mr3283582pjn.31.1601971741897;
        Tue, 06 Oct 2020 01:09:01 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 15sm2113363pgt.24.2020.10.06.01.09.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 01:09:00 -0700 (PDT)
Date:   Tue, 6 Oct 2020 13:38:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq-arm for 5.10-rc1
Message-ID: <20201006080859.rzwkdl5ijfbcp723@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following changes:

- STI cpufreq driver updates to allow new hardware (Alain Volmat).

- Minor tegra driver fixes around initial frequency mismatch warnings (Jon
  Hunter).

- dev_err simplification for s5pv210 driver (Krzysztof Kozlowski).

- Qcom driver updates to allow new hardware and minor cleanup (Manivannan
  Sadhasivam and Matthias Kaehlcke).

- Add missing MODULE_DEVICE_TABLE for armada driver (Pali Rohár).

- Improved defer-probe handling in cpufreq-dt driver (Stephan Gerhold).

- Call dev_pm_opp_of_remove_table() unconditionally for imx driver (Viresh
  Kumar).

-------------------------8<-------------------------

The following changes since commit 90d46d71cce279d878793a0ed4b326b4027aca6c:

  opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1() (2020-09-16 13:56:08 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to bc9b9c5ab9d8d16157737db539929d57562926e9:

  cpufreq: qcom: Don't add frequencies without an OPP (2020-09-16 15:22:15 +0530)

----------------------------------------------------------------
Alain Volmat (3):
      cpufreq: sti-cpufreq: add stih418 support
      cpufreq: dt-platdev: Blacklist st,stih418 SoC
      cpufreq: arm: Kconfig: add CPUFREQ_DT depend for STI CPUFREQ

Jon Hunter (1):
      cpufreq: tegra186: Fix initial frequency

Krzysztof Kozlowski (2):
      cpufreq: s5pv210: Simplify with dev_err_probe()
      cpufreq: s5pv210: Use dev_err instead of pr_err in probe

Manivannan Sadhasivam (5):
      cpufreq: qcom-hw: Make use of cpufreq driver_data for passing pdev
      dt-bindings: cpufreq: cpufreq-qcom-hw: Document Qcom EPSS compatible
      cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code
      cpufreq: qcom-hw: Use of_device_get_match_data for offsets and row size
      cpufreq: qcom-hw: Add cpufreq support for SM8250 SoC

Matthias Kaehlcke (1):
      cpufreq: qcom: Don't add frequencies without an OPP

Pali Rohár (1):
      cpufreq: armada-37xx: Add missing MODULE_DEVICE_TABLE

Stephan Gerhold (1):
      cpufreq: dt: Refactor initialization to handle probe deferral properly

Viresh Kumar (2):
      cpufreq: imx6q: Unconditionally call dev_pm_opp_of_remove_table()
      Merge commit 'ded10c47f39e' into HEAD

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt |   2 +-
 drivers/cpufreq/Kconfig.arm                                   |   2 +-
 drivers/cpufreq/armada-37xx-cpufreq.c                         |   6 +++
 drivers/cpufreq/cpufreq-dt-platdev.c                          |   1 +
 drivers/cpufreq/cpufreq-dt.c                                  | 286 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------
 drivers/cpufreq/imx6q-cpufreq.c                               |  10 +----
 drivers/cpufreq/qcom-cpufreq-hw.c                             | 135 ++++++++++++++++++++++++++++++++++++++++++++-----------------------
 drivers/cpufreq/s5pv210-cpufreq.c                             |  31 ++++++----------
 drivers/cpufreq/sti-cpufreq.c                                 |   6 ++-
 drivers/cpufreq/tegra186-cpufreq.c                            |  30 +++++++++++++++
 drivers/opp/core.c                                            |  22 ++++++++---
 drivers/opp/opp.h                                             |   2 +-
 12 files changed, 305 insertions(+), 228 deletions(-)


-- 
viresh
