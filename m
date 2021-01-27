Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB751305256
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 06:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhA0FqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 00:46:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:16888 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343523AbhA0Faw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 00:30:52 -0500
IronPort-SDR: TSfvxMLfBoEfDTGp7BxkvBbvgAZQRnqa3SkVqboHrVb+DUXVfvwWD/HdZgoHbpaI43DTW1jaBd
 Kk3KU5FByaRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177449719"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="177449719"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 21:30:11 -0800
IronPort-SDR: fyZfyDsoZBv3kybzWbzQoKIo/NeV2lDtgRUXQNqDAc/4OjVmP9iGeZmb8zXO+722K0JuOT+9kr
 umZf49KOihxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="473028939"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2021 21:30:09 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] powercap/intel_rapl: add support for AlderLake Mobile
Date:   Wed, 27 Jan 2021 13:42:27 +0800
Message-Id: <20210127054227.15642-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add intel_rapl support for the AlderLake Mobile platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index c9e57237d778..f0799837c2dd 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1049,6 +1049,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
-- 
2.17.1

