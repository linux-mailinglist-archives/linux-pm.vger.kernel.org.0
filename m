Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06205650EBD
	for <lists+linux-pm@lfdr.de>; Mon, 19 Dec 2022 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiLSPjM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 10:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiLSPjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 10:39:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834618FD4
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 07:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671464350; x=1703000350;
  h=from:to:cc:subject:date:message-id;
  bh=9g7R1jAjVA9SmGQhHj8G/+d+ZdC3Zc1DBKbarTlZNUg=;
  b=Fy2Yt+VSk/twgEncx8axv8wctKp21HlsXE+eEwBgF2NZK6E3AWjFXRJA
   fUdmCdpcwjk+JBTMNsEnXoV8Y1vY6fZ4wX5Ro5JJh+jBwYrXzC2m3ZP1G
   2syQd7ZrUtBH2YbG6M2eFoIZMGr+3nJfZBolG60uLm6Ir7zKL3r5ZPFdF
   sfbnJQPZWh1KvnsOj9h8Vmx4WAFppPAR8Rq3PRC9AaUrv0QV8aK3PoKvV
   4nrJ2gqsygcaFuf66rJDFQP1eixpJ7WrxBPYJTIi7CtiqUvrmwy3uHmAy
   zWIQfZbf9vdTGcjfRu79PdLzXPmC18O1XcPSxXJe8iSj9SzMdW7Efnry7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307051194"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="307051194"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 07:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="774960306"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774960306"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 07:39:07 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 0/6] thermal/intel: Introduce intel-tcc lib and enhance tjmax handling
Date:   Mon, 19 Dec 2022 23:46:14 +0800
Message-Id: <20221219154620.3630-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

---
Changes since V1:
 - remove unnecessary API parameters
 - avoid reading MSR on a remote CPU when possible
 - coding format improvements
