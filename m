Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9688A26B1E3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgIOWhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:37:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:55540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbgIOWhK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 18:37:10 -0400
IronPort-SDR: H6iVlHaIwoCczI9bp99IJhUVZbYPh0k9oqgw+9UguwjxD9xf3pv9siRy6BVy25o3NF0xkp75Lw
 xSBK4NZ1bQiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147112835"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="147112835"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 15:37:07 -0700
IronPort-SDR: NJYyqeCrAUCFY3EejBDrbgMu0QOJ9FBm3a0Vpp3JOZzQsLYA1VtP0YGJeEf+W79CVKO6nvUhU2
 Wm59Dmc3AtHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="306813333"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2020 15:37:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: thermal: int340x: New notifications for INT340X thermal
Date:   Tue, 15 Sep 2020 15:36:47 -0700
Message-Id: <20200915223650.406046-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series contains notifications to user space using currently
used mechanism in these drivers. 

Srinivas Pandruvada (3):
  thermal: int340x: Provide notification for OEM variable change
  thermal: core: Add new event for sending keep alive notifications
  thermal: int340x: Add keep alive response method

 .../intel/int340x_thermal/int3400_thermal.c   | 51 +++++++++++++++----
 include/linux/thermal.h                       |  1 +
 2 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.25.4

