Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A120D4479E3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 06:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhKHFYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 00:24:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:44601 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231444AbhKHFYy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 00:24:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="229626050"
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="229626050"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 21:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="469480737"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Nov 2021 21:22:07 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mjx6d-000BZM-5d; Mon, 08 Nov 2021 05:22:07 +0000
Date:   Mon, 8 Nov 2021 13:21:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Marangoni <thomas.marangoni@mec.at>, sre@kernel.org,
        wens@csie.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Thomas Marangoni <thomas.marangoni@mec.at>
Subject: [RFC PATCH] PM: axp20x_ocv_values_uV[] can be static
Message-ID: <20211108052141.GA10523@9d7d69d1eba2>
References: <20211025144455.16665-1-thomas.marangoni@mec.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025144455.16665-1-thomas.marangoni@mec.at>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/power/supply/axp20x_battery.c:105:11: warning: symbol 'axp20x_ocv_values_uV' was not declared. Should it be static?
drivers/power/supply/axp20x_battery.c:1004:1: warning: symbol 'dev_attr_voltage_low_alert_level1' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 axp20x_battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 5997c8192c73e..ec17841d51733 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -102,7 +102,7 @@ struct axp20x_batt_ps {
  * OCV curve has fixed values and percentage can be adjusted, this array represents
  * the fixed values in uV
  */
-const int axp20x_ocv_values_uV[AXP20X_OCV_MAX + 1] = {
+static const int axp20x_ocv_values_uV[AXP20X_OCV_MAX + 1] = {
 	3132800,
 	3273600,
 	3414400,
@@ -1001,7 +1001,7 @@ static ssize_t voltage_low_alert_level1_store(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR_RW(voltage_low_alert_level1);
+static DEVICE_ATTR_RW(voltage_low_alert_level1);
 
 static ssize_t voltage_low_alert_level2_show(struct device *dev,
 					     struct device_attribute *attr,
