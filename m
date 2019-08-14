Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C671E8CCE1
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfHNHck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 03:32:40 -0400
Received: from muru.com ([72.249.23.125]:57436 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfHNHcj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 03:32:39 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9956480C8;
        Wed, 14 Aug 2019 07:33:05 +0000 (UTC)
Date:   Wed, 14 Aug 2019 00:32:34 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Tri Vo <trong@android.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: Re: Regression in Linux next with show wakeup sources stats in sysfs
Message-ID: <20190814073234.GZ52127@atomide.com>
References: <20190814063803.GY52127@atomide.com>
 <5d53b378.1c69fb81.31b2e.5077@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d53b378.1c69fb81.31b2e.5077@mx.google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Stephen Boyd <swboyd@chromium.org> [190814 07:09]:
> Quoting Tony Lindgren (2019-08-13 23:38:03)
> > Hi all,
> > 
> > Looks like commit 986845e747af ("PM / wakeup: Show wakeup sources stats
> > in sysfs") has caused a regression in Linux next where I can now get
> > some errors like this during the boot:
> > 
> > kobject_add_internal failed for wakeup10 (error: -2 parent: usb)
> > 
> > Any ideas why this might be happening? Maybe some deferred probe
> > related issue?
> > 
> 
> Yeah! Take a look at this thread[1] and please test out patches I'm
> throwing out there like a total cowboy(d).
> 
> [1] https://lkml.kernel.org/r/1565731976.8572.16.camel@lca.pw

Oh OK thanks, looks like I'm a bit behind then. My test case turned
out to be caused by device_init_wakeup() called before device_add() for
power_supply in case that helps. In that case create_dir() will fail
for kobject_add_internal(). Doing something like below fixes the
issue, but seems like we probably have other similar issues as well.
Adding Sebastian to Cc in case this might be a real problem despite
the other issues.

Regards,

Tony

8< -----------------------
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1051,14 +1051,14 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
-	rc = device_init_wakeup(dev, ws);
-	if (rc)
-		goto wakeup_init_failed;
-
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
 
+	rc = device_init_wakeup(dev, ws);
+	if (rc)
+		goto wakeup_init_failed;
+
 	rc = psy_register_thermal(psy);
 	if (rc)
 		goto register_thermal_failed;
@@ -1100,9 +1100,9 @@ __power_supply_register(struct device *parent,
 register_cooler_failed:
 	psy_unregister_thermal(psy);
 register_thermal_failed:
+wakeup_init_failed:
 	device_del(dev);
 device_add_failed:
-wakeup_init_failed:
 check_supplies_failed:
 dev_set_name_failed:
 	put_device(dev);
