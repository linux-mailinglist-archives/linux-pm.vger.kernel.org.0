Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97FF1C459E
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgEDSQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 14:16:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:27142 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbgEDSQm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 14:16:42 -0400
IronPort-SDR: iCyM7OTrg9xXAbpe5CP/qc2iHeBrJRDvswaHw9vT0ABO2ZrOme+fpu17rR6NR22JfqwOcg/dSn
 BqYJ19LFG5hA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 11:16:33 -0700
IronPort-SDR: V766HvWC6rBdcZA8Jv4qpDf6TH6op0Ofg3z2QG/C+iaWJhoNwivZZQTLjSJKncla9w9g1xdsqG
 oMMZ6K9bQ2Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="259427120"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.145.237])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 11:16:32 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH 2/5] thermal: Add notification for zone creation and deletion
Date:   Mon,  4 May 2020 11:16:13 -0700
Message-Id: <20200504181616.175477-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Whenever thermal_zone_device_register() is called and zone is created
successfully, send a notification "THERMAL_ZONE_CREATE".
Similarly send "THERMAL_ZONE_DELETE" when thermal_zone_device_unregister
is called.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/thermal_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a321dc548c8..14770d882d42 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1350,6 +1350,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+	thermal_dev_send_event(tz->id, THERMAL_ZONE_CREATE, 0);
+
 	return tz;
 
 unregister:
@@ -1379,6 +1381,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
+	thermal_dev_send_event(tz->id, THERMAL_ZONE_DELETE, 0);
+
 	tzp = tz->tzp;
 
 	mutex_lock(&thermal_list_lock);
-- 
2.25.4

