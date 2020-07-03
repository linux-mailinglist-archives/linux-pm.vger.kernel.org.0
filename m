Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6345213DF7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGCRD7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 13:03:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:14250 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGCRD7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:59 -0400
IronPort-SDR: 1glVaI7W9cm4lXPUN1hyuZqTrqKpZbXYxEmRlsFmsWXiU7mjE0x5ZdKCSp5wky2RohwAaqkpwa
 sEQDe1hgYlzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="232040223"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="232040223"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 10:03:58 -0700
IronPort-SDR: PIEqIiLMk8gg77c1rFPhbRvX7CJsQMiaV2V7BXXzehkh2IYM1CTaMHjl+GVuVR5LBS9naxkYd1
 3py4Dd2RF/UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="482424118"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2020 10:03:56 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jrP6S-0000JB-7v; Fri, 03 Jul 2020 17:03:56 +0000
Date:   Sat, 4 Jul 2020 01:03:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     kbuild-all@lists.01.org, srinivas.pandruvada@linux.intel.com,
        rkumbako@codeaurora.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH] thermal: core: thermal_cdev_set_cur_state() can be static
Message-ID: <20200703170337.GA27219@874d1626a6d5>
References: <20200703085309.32166-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703085309.32166-4-daniel.lezcano@linaro.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 thermal_helpers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 53dd92ccfd193..2831a93f069c9 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -175,7 +175,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int target)
+static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int target)
 {
 	if (cdev->ops->set_cur_state(cdev, target))
 		return;
