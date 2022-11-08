Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF1A620767
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 04:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiKHDbV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 22:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiKHDbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 22:31:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D822F38A
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 19:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667878280; x=1699414280;
  h=from:to:cc:subject:date:message-id;
  bh=OsFRWUTFM3UGE17yMADSIjnYGFCmFnQp7XfjV4PEpfQ=;
  b=k11P+y3ZPBLxPiIiUkpFeIfSKyAJXV/I2Z7jMFg/oRKnAeqTYANJk3Xm
   pGuPZ7Q1CGikr4BKoR2hPKqNKqclB12gFk9399hAyxUIRqUoSb+MePgmT
   1gNLFFlh72Gd1f7FgZSTWhiqZz2MZ48Im8G9CtnqasFhv2i/89+G0ZcMv
   clHG+6L6sotNvkgHmqirTy2o24xzGGLOLMx6MRqy2krp/IJHg4B/hx53i
   GlDoqC827WfVfJNWPQIs1cZsgDDrWy5xT/HRsmWDFX1hvc6LrS1FE6bib
   LD+609fOmFxBxyw7dDRSVE5Pf4F+Tt0APC+5FlS/fyjzfaqW/bcNngXSL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372732515"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372732515"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614120221"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614120221"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 19:31:18 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 0/6] thermal/intel: Introduce intel-tcc lib and enhance tjmax handling
Date:   Tue,  8 Nov 2022 11:33:26 +0800
Message-Id: <20221108033332.27760-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, all the thermal drivers that access the Intel CPU TCC (thermal
control circuitry) MSRs have two problems,
1. they have their own implementation for the same TCC functionalities,
   including getting the tjmax/temperature, getting/setting the TCC offset.
   This introduces a lot of duplicate code.
2. they get TjMax value once and always use the cached value later.
   But Tjmax value retrieved from MSR_IA32_TEMPERATURE_TARGET can be changed
   at runtime for cases like the Intel SST-PP (Intel Speed Select Technology-
   Performance Profile) level change.

The intel-tcc library is introduced in patch 1/6 for cleaning up the duplicate
code among these drivers, and it also ensures the temperature is alway got
based on the updated tjmax value.

Patch 2 ~ 5 cleans up the drivers by using the new Intel TCC lib APIs.

Patch 6/6 enhances the x86_pkg_temp driver to handle dynamic tjmax when
progamming the thermal interrupt threshold.
Actually, the thermal interrupt threshold programming can also be part of the
TCC library, but I didn't do it in this version because x86_pkg_temp is the
only user for now.

thanks,
rui

----------------------------------------------------------------
Zhang Rui (6):
      thermal/intel: Introduce Intel TCC library
      thermal/x86_pkg_temp_thermal: Use Intel TCC library
      thermal/int340x/processor_thermal: Use Intel TCC library
      thermal/intel/intel_soc_dts_iosf: Use Intel TCC library
      thermal/intel/intel_tcc_cooling: Use Intel TCC library
      thermal/x86_pkg_temp_thermal: Add support for handling dynamic tjmax

 drivers/thermal/intel/Kconfig                      |   7 ++
 drivers/thermal/intel/Makefile                     |   1 +
 drivers/thermal/intel/int340x_thermal/Kconfig      |   1 +
 .../int340x_thermal/processor_thermal_device.c     | 123 ++++---------------
 drivers/thermal/intel/intel_soc_dts_iosf.c         |  33 +-----
 drivers/thermal/intel/intel_tcc.c                  | 132 +++++++++++++++++++++
 drivers/thermal/intel/intel_tcc_cooling.c          |  37 +-----
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |  62 ++++------
 include/linux/intel_tcc.h                          |  18 +++
 9 files changed, 219 insertions(+), 195 deletions(-)
 create mode 100644 drivers/thermal/intel/intel_tcc.c
 create mode 100644 include/linux/intel_tcc.h
