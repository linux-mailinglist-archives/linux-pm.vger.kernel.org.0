Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C35B19F33E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgDFKFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 06:05:38 -0400
Received: from smtp2.axis.com ([195.60.68.18]:30270 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgDFKFi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Apr 2020 06:05:38 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 06:05:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2524; q=dns/txt; s=axis-central1;
  t=1586167537; x=1617703537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=udbZg0rfhq5obQgAPCHMOu7MfWPehMKnhUi5G4Oq/kI=;
  b=BeTHKUaXoo90+CNnosI/Y5nFWqP6R7jSYyr/SMZbHoFlhltHxWIn7Igu
   CUqBYUZKsjPRdBbadsoCKE69L6icnhjfdMt6km00GXZOetAkaHBPGZMf8
   vzWxGXq9Ff+kJ1AZ4z99KSzYKzSGyFsOZL4kGZoaNN5h6XZNYrGsPI8t5
   xvS2bF6IRj7gBWt9bI1+ihUv+SMs5lh1RvUR0qNvDhF6Lr6MrZAtvj+Vn
   CL6+3OzPOxG4WWogNhgYew0wEMAgDfvfO6igysN0ffp0EzCNl6XJAQExm
   mMwBu67OH5XxVekl4xNRIoEHUQkI+N5Ee2j5xE5Ubmnxx8Bob6Ly25111
   A==;
IronPort-SDR: 5Z4ylhPBGcYjVrTIdXrBHANuvFnZoUwtw+UfHA7gcaFU6I5aMMaoV/XUyApNtZkeyQMcd9irdw
 m5a0o3u9icKDD5zzFT+p2piK6VxmaZeDD52Hwxvj7mlHIrIB9zCDmOh/tP7DWeCLc6uzN0Dbc1
 P3H9MJgHh5A5pa5heYuGvcgIFVicKpSl6Pt3FwhGmtVQbESMuOO3jvLK4y2F0AZZldzg1JrbSA
 lag4LfqbcIgzE2xTl/RaqYTZ//qPJ4d5UVT39AkTCoq5ZvHTDE0pNj93g3w5uvzAkalY9hUKzv
 FD4=
X-IronPort-AV: E=Sophos;i="5.72,350,1580770800"; 
   d="scan'208";a="7162607"
Date:   Mon, 6 Apr 2020 11:58:25 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: core: Send a sysfs notification on trip points
Message-ID: <20200406095825.a3mrkbjqlih6xa7d@axis.com>
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
 <20200402142116.22869-1-daniel.lezcano@linaro.org>
 <20200403144009.szjoss5ecleisg2f@axis.com>
 <e0c819ce-31f4-cee1-c7cc-7ecb73d374a3@linaro.org>
 <20200406074525.2bhseq3n5bw7dd2t@axis.com>
 <62f5e0d0-155a-7520-cb1b-2113a2b711b3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62f5e0d0-155a-7520-cb1b-2113a2b711b3@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 06, 2020 at 11:45:10AM +0200, Daniel Lezcano wrote:
> On 06/04/2020 09:45, Vincent Whitchurch wrote:
> > On Fri, Apr 03, 2020 at 05:26:39PM +0200, Daniel Lezcano wrote:
> >> On 03/04/2020 16:40, Vincent Whitchurch wrote:
> >>> Normally sysfs_notify() is used to notify userspace that the
> >>> value of the sysfs file has changed, but in this case it's
> >>> being used on a sysfs file whose value never changes.  I don't
> >>> know if there are other drivers that do something similar.
> >>
> >> I think so:
> >>
> >> eg.
> >>
> >> drivers/hwmon/adt7x10.c: sysfs_notify(&dev->kobj, NULL,
> >> "temp1_max_alarm"); drivers/hwmon/adt7x10.c:
> >> sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
> >> drivers/hwmon/adt7x10.c: sysfs_notify(&dev->kobj, NULL,
> >> "temp1_crit_alarm");
> >>
> >> drivers/hwmon/abx500.c: sysfs_notify(&data->pdev->dev.kobj, NULL,
> >> alarm_node); drivers/hwmon/abx500.c:
> >> sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
> >>
> >> drivers/hwmon/stts751.c: sysfs_notify(&priv->dev->kobj, NULL,
> >> "temp1_max_alarm"); drivers/hwmon/stts751.c:
> >> sysfs_notify(&priv->dev->kobj, NULL, "temp1_min_alarm");
> >>
> >> There are also some other places I believe they are doing the
> >> same like:
> >>
> >> drivers/md/md.c: sysfs_notify(&mddev->kobj, NULL,
> >> "sync_completed"); drivers/md/md.c: sysfs_notify(&mddev->kobj,
> >> NULL, "degraded");
> >
> > AFAICS all these drivers (including the hwmon ones) use
> > sysfs_notify() to notify that the value of the sysfs file has
> > changed, unlike your proposed patch.
> 
> Sorry, I don't have the same understanding:
> 
> drivers/hwmon/adt7x10.c:
> 
>  - receives an interrupt because one of the programmed temperature is
> reached
>  - reads the status to know which one and sends a sysfs notification

In the sysfs file implementation, you can see that the value in the
sysfs file changes based on the same condition:

static ssize_t adt7x10_alarm_show(struct device *dev,
                                  struct device_attribute *da, char *buf)
{
        struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
        int ret;

        ret = adt7x10_read_byte(dev, ADT7X10_STATUS);
        if (ret < 0)
                return ret;

        return sprintf(buf, "%d\n", !!(ret & attr->index));
}

static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
                             ADT7X10_STAT_T_HIGH);

It's the same case with the other examples: the sysfs file's value
changes.

Anyway, as you say it probably doesn't matter as long as it is
documented.
