Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126CD390AAC
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhEYUtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 16:49:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:9161 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhEYUtt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 May 2021 16:49:49 -0400
IronPort-SDR: fw7LG9KOQb6Go4AAIO8v/+qFV5qXRSSr5E7vR9iU8OdyJDUv23mgwqbn7zhDeoviKkR8cQGIbP
 OS9droRzOxsg==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189676392"
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="189676392"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 13:48:18 -0700
IronPort-SDR: qb089ME/bLHQ8KPl/xV9Cx5jb2qy4u2a0DuaAim2RUjDrwDN4tdCwZIc8oYerlHppxzyXQGREK
 gQOd44WoZrgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="435842393"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2021 13:48:18 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] thermal: int340x: processor_thermal: Add new PCI MMIO based thermal driver
Date:   Tue, 25 May 2021 13:48:09 -0700
Message-Id: <20210525204811.3793651-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds a new thermal driver, which uses PCI MMIO for temperature and trips. To reuse
the code the first patch just reorganizes the existing code.

This series needs the following patch to cleanly apply:
[PATCH 1/2] thermal: int340x: processor_thermal: Export mailbox interface
sent on 16th May, 21.

Srinivas Pandruvada (2):
  thermal: int340x: processor_thermal: Split enumeration and processing
    part
  thermal: int340x: processor_thermal: Add PCI MMIO based thermal driver

 .../thermal/intel/int340x_thermal/Makefile    |   3 +
 .../intel/int340x_thermal/int3401_thermal.c   |  82 ++++
 .../processor_thermal_device.c                | 289 ++------------
 .../processor_thermal_device.h                |   9 +-
 .../processor_thermal_device_pci.c            | 371 ++++++++++++++++++
 .../processor_thermal_device_pci_legacy.c     | 163 ++++++++
 6 files changed, 658 insertions(+), 259 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/int3401_thermal.c
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c

-- 
2.27.0

