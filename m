Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104C82D69FB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 22:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393994AbgLJVfj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 16:35:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:55837 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393963AbgLJVfg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 16:35:36 -0500
IronPort-SDR: XWdrJXVB9xdckm+jaw68XiRhUq5kRTcihDWoWKtF9daroAnqjc9h4/ohjhMtF18eB0yU/tJJkS
 cRhehAQIZ7VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="154145489"
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="154145489"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 13:33:48 -0800
IronPort-SDR: EPvjhwULLo1H5gbS8k3yWFpxe2BxRnmQgD1g457GJnObWtsuqQXJDCHJDJq+FE5BJ0M1DIJ0ll
 gYIrtH+htBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="372938209"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2020 13:33:47 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michael Larabel <Michael@phoronix.com>
Subject: [PATCH] thermal: int340x: processor_thermal: Correct workload type name
Date:   Thu, 10 Dec 2020 13:33:24 -0800
Message-Id: <20201210213324.2113041-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change "Burusty" to "bursty".

Reported-by: Michael Larabel <Michael@phoronix.com> 
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index 2c105fed2d7b..990f51f22884 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -87,7 +87,7 @@ static const char * const workload_types[] = {
 	"none",
 	"idle",
 	"semi_active",
-	"burusty",
+	"bursty",
 	"sustained",
 	"battery_life",
 	NULL
-- 
2.25.4

