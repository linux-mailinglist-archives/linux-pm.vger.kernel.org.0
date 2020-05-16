Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5D1D6119
	for <lists+linux-pm@lfdr.de>; Sat, 16 May 2020 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgEPMzm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 May 2020 08:55:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:44093 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgEPMzm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 May 2020 08:55:42 -0400
IronPort-SDR: 5VDLdr00A4ic7OpXSkaNZdKMh7MD0FHLH/HZXDERePDS7SbSoiCF0jXjJSw0sjyp/Z1M7IEapf
 rbirqJPnelqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 05:55:42 -0700
IronPort-SDR: yvN0SmOZJHqQmoYtjm5IXoaI46heARkHG7baRSf11Og0i45uTzKHgSDrNEzfOajO8f78C1Q4Kq
 YnuBNvBDDdlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="410756982"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2020 05:55:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZwLr-000AZ3-5p; Sat, 16 May 2020 20:55:39 +0800
Date:   Sat, 16 May 2020 20:55:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     kbuild-all@lists.01.org, amit.kucheria@verdurent.com,
        srinivas.pandruvada@linux.intel.com, arnd@arndb.de,
        rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] thermal: core: thermal_genl_sampling_temp() can be static
Message-ID: <20200516125505.GA16652@aae4cc650884>
References: <20200515141034.19154-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515141034.19154-4-daniel.lezcano@linaro.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 thermal_netlink.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index a2bce846771e4..851db26e66465 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -66,7 +66,7 @@ static struct genl_family thermal_gnl_family;
 
 /************************** Sampling encoding *******************************/
 
-int thermal_genl_sampling_temp(int id, int temp)
+static int thermal_genl_sampling_temp(int id, int temp)
 {
 	struct sk_buff *skb;
 	void *hdr;
@@ -506,7 +506,7 @@ static cb_t cmd_cb[] = {
 	[THERMAL_GENL_CMD_CDEV_GET]	= thermal_genl_cmd_cdev_get,
 };
 
-int thermal_genl_cmd_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+static int thermal_genl_cmd_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct param p = { .msg = skb };
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
@@ -532,7 +532,7 @@ int thermal_genl_cmd_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return ret;
 }
 
-int thermal_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+static int thermal_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct param p = { .attrs = info->attrs };
 	struct sk_buff *msg;
