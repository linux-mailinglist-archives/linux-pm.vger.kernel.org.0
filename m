Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF619F11C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDFHp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 03:45:28 -0400
Received: from smtp1.axis.com ([195.60.68.17]:8325 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFHp2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Apr 2020 03:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1392; q=dns/txt; s=axis-central1;
  t=1586159128; x=1617695128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hKjWOr9FSgMwzvGDh1VBVkoJ1lF8KGvb+K5ewVawfCo=;
  b=H1sWTFHSQaVNHJpYmMb1ogscI348SWmEJL42VEI0J02uwu/UYekAhOQw
   kchvTPWOZV8H3w/r6HxSF/qJvqKJwrRKdu3VLEVs2peDhmCjdlelRutAN
   43fupTLtqymQPD2jr+CzyTpNoHvk5WgAHEje2ptPAOSylS5CveoO0NwMd
   TPBFjPFdjYVv04QdavAmyua0VjGABP4NxWcy6aeUdlNpdjBrd7VSR8IFJ
   YrkafmoTwI8wr9onaZSiM8bVvLNRJAILaAgAUooDSNOowhDReOfEHCBQw
   NdBqyDhxmkUct9vfZ31ViSppt855kMDiUshB8RtcrdkVe7b4STIjI5Hpy
   w==;
IronPort-SDR: rktaN4umJOdoahSgBwoHdhjxgRERbzY2cMeYoRJ4E66mpfllBiVsbl1/D6wOqUY5XzXBzQs1/q
 TaBKFoy9vy8uzlxvUGzZo1Zy1z4OsyJ1Sc7gZtBNSK0+bf1cOkBG9vl/dn97dYtskI1AU8gute
 DW+9xzSg0JTg7eKYV9TCJa3JFD4OHdro9DILAOJETJuRzSbSjB1RoVYJZEkTzzL6OGnaRDT3PH
 kfe5C4nZBlrgzc61k07H78FTHeXp+Cco/zKqGNDlZx1ESVa2a+IjIOqzZsh9pc5mhU6AtEZFmM
 OVg=
X-IronPort-AV: E=Sophos;i="5.72,350,1580770800"; 
   d="scan'208";a="7358640"
Date:   Mon, 6 Apr 2020 09:45:26 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: core: Send a sysfs notification on trip points
Message-ID: <20200406074525.2bhseq3n5bw7dd2t@axis.com>
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
 <20200402142116.22869-1-daniel.lezcano@linaro.org>
 <20200403144009.szjoss5ecleisg2f@axis.com>
 <e0c819ce-31f4-cee1-c7cc-7ecb73d374a3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0c819ce-31f4-cee1-c7cc-7ecb73d374a3@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 03, 2020 at 05:26:39PM +0200, Daniel Lezcano wrote:
> On 03/04/2020 16:40, Vincent Whitchurch wrote:
> > Normally sysfs_notify() is used to notify userspace that the value
> > of the sysfs file has changed, but in this case it's being used on
> > a sysfs file whose value never changes.  I don't know if there are
> > other drivers that do something similar.
> 
> I think so:
> 
> eg.
> 
> drivers/hwmon/adt7x10.c:
> 	sysfs_notify(&dev->kobj, NULL, "temp1_max_alarm");
> drivers/hwmon/adt7x10.c:
> 	sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
> drivers/hwmon/adt7x10.c:
> 	sysfs_notify(&dev->kobj, NULL, "temp1_crit_alarm");
> 
> drivers/hwmon/abx500.c:
> 	sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> drivers/hwmon/abx500.c:
> 	sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> 
> drivers/hwmon/stts751.c:
> 	sysfs_notify(&priv->dev->kobj, NULL, "temp1_max_alarm");
> drivers/hwmon/stts751.c:
> 	sysfs_notify(&priv->dev->kobj, NULL, "temp1_min_alarm");
> 
> There are also some other places I believe they are doing the same like:
> 
> drivers/md/md.c:
> 	sysfs_notify(&mddev->kobj, NULL, "sync_completed");
> drivers/md/md.c:
> 	sysfs_notify(&mddev->kobj, NULL, "degraded");

AFAICS all these drivers (including the hwmon ones) use sysfs_notify()
to notify that the value of the sysfs file has changed, unlike your
proposed patch.
