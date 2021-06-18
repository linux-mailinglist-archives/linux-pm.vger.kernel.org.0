Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23183ACF2E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhFRPgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 11:36:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:11984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhFRPgn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Jun 2021 11:36:43 -0400
IronPort-SDR: phUI6VDCWGpOJxWKYyAsdsWMXOssx2ODJUDwGDWx4QgeSPVx5watjJWwoj2ntiPM0fIHbd2pws
 YVk3zfAms3eg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="204743326"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="204743326"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:34:33 -0700
IronPort-SDR: YjUWpt7MffIQd3kXvC0VEISOuHbwiGJc62Dimqy4romcc6vUPkII6JPGzoy45KRTbvW5/UIqv5
 ALK931eNkYrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="489101532"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2021 08:34:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D30B2AA; Fri, 18 Jun 2021 18:34:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 1/1] thermal: intel: intel_soc_dts_iosf: Switch to use find_first_zero_bit()
Date:   Fri, 18 Jun 2021 18:34:51 +0300
Message-Id: <20210618153451.89246-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switch to use find_first_zero_bit() instead of open-coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 4f1a2f7c016c..342b0bb5a56d 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -350,13 +350,14 @@ int intel_soc_dts_iosf_add_read_only_critical_trip(
 	int i, j;
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		for (j = 0; j < sensors->soc_dts[i].trip_count; ++j) {
-			if (!(sensors->soc_dts[i].trip_mask & BIT(j))) {
-				return update_trip_temp(&sensors->soc_dts[i], j,
-					sensors->tj_max - critical_offset,
-					THERMAL_TRIP_CRITICAL);
-			}
-		}
+		struct intel_soc_dts_sensor_entry *entry = &sensors->soc_dts[i];
+		int temp = sensors->tj_max - critical_offset;
+		unsigned long count = entry->trip_count;
+		unsigned long mask = entry->trip_mask;
+
+		j = find_first_zero_bit(&mask, count);
+		if (j < count)
+			return update_trip_temp(entry, j, temp, THERMAL_TRIP_CRITICAL);
 	}
 
 	return -EINVAL;
-- 
2.30.2

