Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8D126B1E4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgIOWhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:37:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:55540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbgIOWhQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 18:37:16 -0400
IronPort-SDR: 4vUcubuTWcJIkP6aYAZY2JK1nDaKvsKzUZGtTw+TO7SF21mh4L7YgxASK9D/LziAqKmIgQSCR8
 QUyFRYQ2srfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147112837"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="147112837"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 15:37:07 -0700
IronPort-SDR: iq7oEeUhRErSHEFmoS1mtG6v8k484Mll85A5XWUdvLJoIQ/d0XYK5KKviH54zEvA6lzW29tjFP
 7UW+SNchzZXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="306813339"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2020 15:37:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: core: Add new event for sending keep alive notifications
Date:   Tue, 15 Sep 2020 15:36:49 -0700
Message-Id: <20200915223650.406046-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915223650.406046-1-srinivas.pandruvada@linux.intel.com>
References: <20200915223650.406046-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This event is sent by the platform firmware to confirm that
user space thermal solution is alive. The response to this event
from the user space thermal solution is platform specific.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 include/linux/thermal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 42ef807e5d84..42b69d4072a4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -55,6 +55,7 @@ enum thermal_notify_event {
 	THERMAL_DEVICE_UP, /* Thermal device is up after a down event */
 	THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
 	THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
+	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
 };
 
 struct thermal_zone_device_ops {
-- 
2.25.4

