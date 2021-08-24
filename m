Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0DA3F578B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 07:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhHXFSS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 01:18:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:55331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhHXFSS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Aug 2021 01:18:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="278249107"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="278249107"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 22:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="515282840"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2021 22:17:34 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        lenb@kernel.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 0/3] Reuse cpuidle cooling for non DT/ARM
Date:   Mon, 23 Aug 2021 22:17:28 -0700
Message-Id: <20210824051731.2495462-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset reused existing cpuidle cooling implementation and
develops a new driver which can be used in non DT/ARM platforms.

This has added advantage for per cpu idle injection instead of
a global one using Intel powerclamp driver.

Srinivas Pandruvada (3):
  thermal/drivers/cpuidle_cooling: Reorganize cpuidle cooling driver
  powercap: idle_inject: Export symbols
  thermal/drivers/cpuidle_cooling: cpuidle cooling driver for non DT/ARM

 drivers/powercap/idle_inject.c            |   4 +
 drivers/thermal/Kconfig                   |  18 ++-
 drivers/thermal/Makefile                  |   3 +
 drivers/thermal/cpuidle_cooling.c         | 141 +-------------------
 drivers/thermal/cpuidle_cooling_core.c    | 148 +++++++++++++++++++++
 drivers/thermal/cpuidle_cooling_core.h    |  24 ++++
 drivers/thermal/cpuidle_cooling_generic.c | 155 ++++++++++++++++++++++
 7 files changed, 353 insertions(+), 140 deletions(-)
 create mode 100644 drivers/thermal/cpuidle_cooling_core.c
 create mode 100644 drivers/thermal/cpuidle_cooling_core.h
 create mode 100644 drivers/thermal/cpuidle_cooling_generic.c

-- 
2.30.2

