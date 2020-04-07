Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6341A0F03
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgDGORZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 7 Apr 2020 10:17:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:12920 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgDGORZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Apr 2020 10:17:25 -0400
IronPort-SDR: zeB+OLmTnYV/HGJlXvqujkhLodlArGeWGD62WtRjFB53sAuxI7m46zHpSWaDvUWyBayaE28I14
 cvtKcXIc9hjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 07:17:25 -0700
IronPort-SDR: nLQ9Qj9Xs0hrrMydI0L0HBiUpkBkzTSe0+UiehNicEwpF7vPq+FFBPoSc8RrS2vkw4ogyLb8JQ
 uF+hbMtc3ptA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,354,1580803200"; 
   d="scan'208";a="269440905"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 07 Apr 2020 07:17:24 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 07:17:24 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 07:17:24 -0700
Received: from shsmsx108.ccr.corp.intel.com ([169.254.8.7]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 22:17:21 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] thermal: Add a sanity check for invalid state at stats
 update
Thread-Topic: [PATCH] thermal: Add a sanity check for invalid state at stats
 update
Thread-Index: AQHWBpzH0NNV6tuj6kqI2uO2gMago6htLiyAgAALuQCAAIctYA==
Date:   Tue, 7 Apr 2020 14:17:21 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926377CEDF41@SHSMSX108.ccr.corp.intel.com>
References: <20200330140859.12535-1-tiwai@suse.de>
        <CAHLCerOGgv8k1ce43jvmhZwXWVQ_uB1WgrQN_NbkBphWE9NfHA@mail.gmail.com>
 <s5himibmljz.wl-tiwai@suse.de>
In-Reply-To: <s5himibmljz.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Right, I have a V2 patch series, which will be post soon.

Thanks,
rui

-----Original Message-----
From: linux-pm-owner@vger.kernel.org <linux-pm-owner@vger.kernel.org> On Behalf Of Takashi Iwai
Sent: Tuesday, April 07, 2020 10:13 PM
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Takashi Iwai <tiwai@suse.de>; Zhang, Rui <rui.zhang@intel.com>; Daniel Lezcano <daniel.lezcano@linaro.org>; Linux PM list <linux-pm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: Add a sanity check for invalid state at stats update
Importance: High

On Tue, 07 Apr 2020 15:30:51 +0200,
Amit Kucheria wrote:
> 
> On Mon, Mar 30, 2020 at 7:39 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > The thermal sysfs handler keeps the statistics table with the fixed 
> > size that was determined from the initial max_states() call, and the 
> > table entry is updated at each sysfs cur_state write call.  And, 
> > when the driver's set_cur_state() ops accepts the value given from 
> > user-space, the thermal sysfs core blindly applies it to the 
> > statistics table entry, which may overflow and cause an Oops.
> > Although it's rather a bug in the driver's ops implementations, we 
> > shouldn't crash but rather give a proper warning instead.
> >
> > This patch adds a sanity check for avoiding such an OOB access and 
> > warns with a stack trace to show the suspicious device in question.
> 
> Hi Takashi,
> 
> Instead of this warning, I think we should reject such input when 
> writing to cur_state.
> 
> See attached patch. If you think this OK, I'll submit it.

Actually the input value itself is correct, the problem is rather about the max_states that may vary depending on other driver.  So IMO, we don't want to refuse the input completely.

Please see the thread:
  https://lore.kernel.org/linux-acpi/s5h5zeiwd01.wl-tiwai@suse.de/


thanks,

Takashi


> 
> Regards,
> Amit
> 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >
> > We've hit some crash by stress tests, and this patch at least works 
> > around the crash itself.  While the actual bug fix of the buggy 
> > driver is still being investigated, I submit the hardening in the 
> > core side at first.
> >
> >  drivers/thermal/thermal_sysfs.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c 
> > b/drivers/thermal/thermal_sysfs.c index aa99edb4dff7..a23c4e701d63 
> > 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -772,6 +772,11 @@ void thermal_cooling_device_stats_update(struct 
> > thermal_cooling_device *cdev,
> >
> >         spin_lock(&stats->lock);
> >
> > +       if (dev_WARN_ONCE(&cdev->device, new_state >= stats->max_states,
> > +                         "new state %ld exceeds max_state %ld",
> > +                         new_state, stats->max_states))
> > +               goto unlock;
> > +
> >         if (stats->state == new_state)
> >                 goto unlock;
> >
> > --
> > 2.16.4
> >
> From 54266260d483ab4476510dd4461a1cafc611e17d Mon Sep 17 00:00:00 2001
> Message-Id: 
> <54266260d483ab4476510dd4461a1cafc611e17d.1586266224.git.amit.kucheria
> @linaro.org>
> From: Amit Kucheria <amit.kucheria@linaro.org>
> Date: Tue, 7 Apr 2020 18:48:14 +0530
> Subject: [PATCH] thermal: Reject invalid cur_state input from 
> userspace
> 
> We don't check if the cur_state value input in sysfs is greater than 
> the maximum cooling state that the cooling device supports. This can 
> cause access to unallocated memory in case THERMAL_STATISTICS in 
> enabled and could also crash cooling devices that don't check for an 
> invalid state in their set_cur_state() callback.
> 
> Return an error if the state being requested in greater than the 
> maximum cooling state the device supports.
> 
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c 
> b/drivers/thermal/thermal_sysfs.c index 7e1d11bdd258..8033e5a9386a 
> 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -703,7 +703,7 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>  		const char *buf, size_t count)
>  {
>  	struct thermal_cooling_device *cdev = to_cooling_device(dev);
> -	unsigned long state;
> +	unsigned long state, max_state;
>  	int result;
>  
>  	if (sscanf(buf, "%ld\n", &state) != 1) @@ -712,6 +712,13 @@ 
> cur_state_store(struct device *dev, struct device_attribute *attr,
>  	if ((long)state < 0)
>  		return -EINVAL;
>  
> +	result = cdev->ops->get_max_state(cdev, &max_state);
> +	if (result)
> +		return result;
> +
> +	if (state >= max_state)
> +		return -EINVAL;
> +
>  	mutex_lock(&cdev->lock);
>  
>  	result = cdev->ops->set_cur_state(cdev, state);
> --
> 2.20.1
> 
