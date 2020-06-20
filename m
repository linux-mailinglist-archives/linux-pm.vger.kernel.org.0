Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35763202589
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jun 2020 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgFTRLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Jun 2020 13:11:11 -0400
Received: from mail.rc.ru ([151.236.222.147]:39506 "EHLO mail.rc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFTRLK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Jun 2020 13:11:10 -0400
X-Greylist: delayed 1549 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2020 13:11:09 EDT
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:57788)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1jmgbs-0005A3-VC; Sat, 20 Jun 2020 17:44:52 +0100
Date:   Sat, 20 Jun 2020 17:44:49 +0100
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: dt: fix oops on armada37xx
Message-ID: <20200620164449.GA19776@mail.rc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 0c868627e617e43a295d8 (cpufreq: dt: Allow platform specific
intermediate callbacks) added two function pointers to the
struct cpufreq_dt_platform_data. However, armada37xx_cpufreq_driver_init()
has this struct (pdata) located on the stack and uses only "suspend"
and "resume" fields. So these newly added "get_intermediate" and
"target_intermediate" pointers are uninitialized and contain arbitrary
non-null values, causing all kinds of trouble.

For instance, here is an oops on espressobin after an attempt to change
the cpefreq governor:

[   29.174554] Unable to handle kernel execute from non-executable memory at virtual address ffff00003f87bdc0
...
[   29.269373] pc : 0xffff00003f87bdc0
[   29.272957] lr : __cpufreq_driver_target+0x138/0x580
...

Fixed by zeroing out pdata before use.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index aa0f06dec959..df1c941260d1 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -456,6 +456,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	/* Now that everything is setup, enable the DVFS at hardware level */
 	armada37xx_cpufreq_enable_dvfs(nb_pm_base);
 
+	memset(&pdata, 0, sizeof(pdata));
 	pdata.suspend = armada37xx_cpufreq_suspend;
 	pdata.resume = armada37xx_cpufreq_resume;
 
-- 
2.20.1
