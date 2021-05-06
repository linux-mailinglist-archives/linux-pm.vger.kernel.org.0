Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F773375035
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhEFHea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 03:34:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:44990 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233240AbhEFHe3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 May 2021 03:34:29 -0400
IronPort-SDR: N4LbSIrOBCNawNTztJYPobzjD4QLM0+GzY97wJipgu+IHzQJrcasera70HFoDP2MABwMwXrcS5
 nsPAoPidiXzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="219280369"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="219280369"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 00:33:31 -0700
IronPort-SDR: Z9ojw+xlk1KASmwu6ETtLNIhcLGXDoTzo5kOKmQTRb4mqqe0lZVumy5iHgFTU+7VWyhWaQMa4s
 vA1e33zDwUIA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="430405327"
Received: from cli2-mobl.ccr.corp.intel.com ([10.255.30.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 00:33:15 -0700
Message-ID: <09a30436d27037a1e3de7d57c04bdb13e6ed104b.camel@intel.com>
Subject: Re: [Bug 201761] "failed to read out thermal zone" for wifi thermal
 zone
From:   Zhang Rui <rui.zhang@intel.com>
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     klaus.kusche@computerix.info, kernelbugs@equaeghe.nospammail.net,
        oneuptingera@protonmail.com, Maurice.Smulders@windtalker.com,
        spiderx@spiderx.dp.ua, chenalias@163.com, serg@podtynnyi.com,
        daniel.lezcano@linaro.org, smirandac@gmail.com,
        rui.zhang@intel.com, mluppov@gmail.com, irherder@gmail.com,
        navarro.ime@gmail.com, stanley.king@acm.org,
        inout@users.sourceforge.net, fkrueger@mailbox.org,
        shalev.tomer@gmail.com, johannespfrang+kernel@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Thu, 06 May 2021 15:33:11 +0800
In-Reply-To: <bug-201761-8003-x4sT7iaKAE@https.bugzilla.kernel.org/>
References: <bug-201761-8003@https.bugzilla.kernel.org/>
         <bug-201761-8003-x4sT7iaKAE@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As Luca does not subscribed the kernel bugzilla, switch to email.

Luca,
can you give more details about what the userspace does for the iwlwifi
thermal zone, and how often the iwlwifi interface may become
availalble/unavailable?

We want to fully understand the drawbacks of fixing the problem by
doing thermal register/unregister.

You can check this https://bugzilla.kernel.org/show_bug.cgi?id=201761
to get the full discussion.

thanks,
rui

On Thu, 2021-05-06 at 07:20 +0000, bugzilla-daemon@bugzilla.kernel.org
wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=201761
> 
> --- Comment #50 from Zhang Rui (rui.zhang@intel.com) ---
> (In reply to Daniel Lezcano from comment #49)
> > This is clearly spotted by the error happening at the
> > end of the thermal_zone_device_register() function which calls
> > thermal_zone_device_update() at the end: the thermal zone is
> > registered
> > before the sensor is initialized.
> 
> thermal_zone_device_update() can handle a disabled thermal zone now.
> So if we
> flag the thermal zone as disabled during registration,
> thermal_zone_device_update() is a no-op.
> 
> This just means it is doable technically.
> But let's understand why the current thermal APIs
> (register/unregister) can not
> fit the current problem first.
> 
> > That is the reason why I think the driver is not doing the right
> > thing and
> > should take care of registering/unregistering the thermal zone when
> > the
> > sensor (aka firmware code) can operate, otherwise we create an
> > empty sensor
> > device which is wrong.
> 
> Okay, I found the previous conversation with Luciano Coelho, the
> iwlwifi
> maintainer.
> 
> "This issue has been know by us for a while now and we also had users
> complain
> about it, but at the time there was nothing we could do. The reason
> for
> registering before we can actually provide the temperature is because
> the wifi
> interface may go up and down many times and we didn't want the
> userspace to
> keep having to set values again."
> 
> Luca,
> can you give more details about what the userspace does for the
> iwlwifi thermal
> zone, and how often the iwlwifi interface becomes
> avaialble/unavailable?
> 
> We want to fully understand the drawbacks of doing thermal
> register/unregister.
> 
> > 
> > In addition, userspace programs may not be aware of the thermal
> > zone mode
> > and continue reading the temp file with the same ENODATA error.
> > Especially
> > when they read the temp from /sys/class/hwmon where the disabled
> > state is
> > not available.
> 
> I agree. We can only prevent access of a disabled thermal zone from
> kernel, but
> accessing via sysfs can still trigger this error.
> 
> But the kernel failure is what this bug report mainly complains.
> And if users read the temp when the wifi interface is down, it will
> get an
> error, I don't think there is a problem.
> Plus, we can add the tz->mode check in sysfs attribute callbacks, and
> give an
> extra warning of "accessing-to-a-disabled-thermal-zone".
> 

