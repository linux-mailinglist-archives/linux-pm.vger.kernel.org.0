Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD292196084
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 22:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0Vdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 17:33:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:35671 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbgC0Vdp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 17:33:45 -0400
IronPort-SDR: H9I635yBmUhWL24zUypg9OosVQFSKt7bvqFxFxSWuIeQ9ssK+7C+DpYBmcSvlB2ev2hzj/8eVC
 eCIaKvt1oytg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 14:33:43 -0700
IronPort-SDR: OhQc7XDvRNnOvb7TqkMaCQkgdqOHWj7ItCPIm9zSDCDGRMsmba0TazTQG/9vWe5Ep43dYI0KHq
 2J7kuyt3W4Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="358607252"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2020 14:33:44 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, dvhart@infradead.org, alex.hung@canonical.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 0/3] Fixes: update Tiger Lake ACPI device IDs
Date:   Fri, 27 Mar 2020 14:28:18 -0700
Message-Id: <cover.1585343507.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The hardware IDs for devices supported by Tiger Lake for various drivers
such as DPTF, fan, Intel thermal and intel-hid are added with missing 'C'
which makes them invalid. Hence fix these IDs by updating.

For instance, the updated ID now looks like
INT1047 --> INTC1047

Patch 1: Update Tiger Lake ACPI device IDs for DPTF and fan drivers
Patch 2: Update Tiger Lake ACPI device ID for intel-hid driver
Patch 3: Update Tiger Lake ACPI device IDs for thermal driver

Changes since v1:
1) Added fixes tag to each patch

Gayatri Kammela (3):
  ACPI: fix: Update Tiger Lake ACPI device IDs
  platform/x86: intel-hid: fix: Update Tiger Lake ACPI device ID
  thermal: int340x_thermal: fix: Update Tiger Lake ACPI device IDs

 drivers/acpi/device_pm.c                                | 2 +-
 drivers/acpi/dptf/dptf_power.c                          | 2 +-
 drivers/acpi/dptf/int340x_thermal.c                     | 8 ++++----
 drivers/platform/x86/intel-hid.c                        | 2 +-
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-- 
2.17.1

