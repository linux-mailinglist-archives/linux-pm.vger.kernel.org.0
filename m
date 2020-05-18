Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED51D8BC4
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 01:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgERXqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 19:46:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:57890 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgERXqP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 19:46:15 -0400
IronPort-SDR: WG4JpC2fLle2/pFmcP2nnQ2kK8EqePGqhPPeyAbGZctYRl5x2UouoLfbquD1BSe6BTD7VWl/qo
 9ilggpVbiL9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:46:15 -0700
IronPort-SDR: ipZ7LcBdI0Kp+BKLIJ31Z+FXg551fHuZqwIGB6snDp0VXJuoQC+Yx2nK169zbJISBsYpvy/cCd
 PlLofdBIoYrw==
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="373550847"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.227.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:46:14 -0700
Message-ID: <b74767964b028c297840aefc166e2384333afd3b.camel@linux.intel.com>
Subject: Re: [RFC][PATCH 4/5] thermal: Add support for setting polling
 interval
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Mon, 18 May 2020 16:46:13 -0700
In-Reply-To: <c2aad548-32c2-f008-5ce4-97b76a19271d@linaro.org>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
         <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
         <c2aad548-32c2-f008-5ce4-97b76a19271d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-05-18 at 18:51 +0200, Daniel Lezcano wrote:
> On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > Add new attribute in the thermal syfs for setting temperature
> > sampling
> > interval when CONFIG_THERMAL_USER_EVENT_INTERFACE is defined. The
> > default
> > value is 0, which means no polling.
> > 
> > At this interval user space will get an event THERMAL_TEMP_SAMPLE
> > with
> > temperature sample. This reuses existing polling mecahnism when
> > polling
> > or passive delay is specified during zone registry. To avoid
> > interference
> > with passive and polling delay, this new polling attribute can't be
> > used
> > for those zones.
> 
> The userspace can get the temperature whenever it wants via the
> temperature file. The polling is designed for a specific hardware and
> the slope of the temperature graphic.
> 
> The userspace has the alternative of reading the temperature based on
> its own timer or wait for (and stick to) the thermal framework
> sampling
> rate. Adding a notification in the update is enough IMO.
> 
The problem with this approach is that the user can't change sampling
interval. Those polling intervals are fixed during thermal-zone
register. Is there any way to change those defaults from user space?

Kernel can start with some long polling interval and user space can
change close to some trip.

Thanks,
Srinivas




> 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/thermal/thermal_core.c  |  7 +++++++
> >  drivers/thermal/thermal_sysfs.c | 36
> > +++++++++++++++++++++++++++++++--
> >  include/linux/thermal.h         |  1 +
> >  3 files changed, 42 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 14770d882d42..17cd799b0073 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -313,6 +313,8 @@ static void monitor_thermal_zone(struct
> > thermal_zone_device *tz)
> >  		thermal_zone_device_set_polling(tz, tz->passive_delay);
> >  	else if (tz->polling_delay)
> >  		thermal_zone_device_set_polling(tz, tz->polling_delay);
> > +	else if (tz->temp_polling_delay)
> > +		thermal_zone_device_set_polling(tz, tz-
> > >temp_polling_delay);
> >  	else
> >  		thermal_zone_device_set_polling(tz, 0);
> >  
> > @@ -446,6 +448,11 @@ static void update_temperature(struct
> > thermal_zone_device *tz)
> >  	tz->temperature = temp;
> >  	mutex_unlock(&tz->lock);
> >  
> > +	if (tz->temp_polling_delay) {
> > +		thermal_dev_send_event(tz->id, THERMAL_TEMP_SAMPLE,
> > temp);
> > +		monitor_thermal_zone(tz);
> > +	}
> > +
> >  	trace_thermal_temperature(tz);
> >  	if (tz->last_temperature == THERMAL_TEMP_INVALID)
> >  		dev_dbg(&tz->device, "last_temperature N/A,
> > current_temperature=%d\n",
> > diff --git a/drivers/thermal/thermal_sysfs.c
> > b/drivers/thermal/thermal_sysfs.c
> > index aa85424c3ac4..0df7997993fe 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -248,6 +248,36 @@ create_thres_attr(temp_thres_low);
> >  create_thres_attr(temp_thres_high);
> >  create_thres_attr(temp_thres_hyst);
> >  
> > +static ssize_t
> > +temp_polling_delay_store(struct device *dev, struct
> > device_attribute *attr,
> > +		   const char *buf, size_t count)
> > +{
> > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > +	int val;
> > +
> > +	if (kstrtoint(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	if (val && val < 1000)
> > +		return -EINVAL;
> > +
> > +	tz->temp_polling_delay = val;
> > +	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t
> > +temp_polling_delay_show(struct device *dev, struct
> > device_attribute *attr,
> > +		     char *buf)
> > +{
> > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > +
> > +	return sprintf(buf, "%d\n", tz->temp_polling_delay);
> > +}
> > +
> > +static DEVICE_ATTR_RW(temp_polling_delay);
> > +
> >  static int create_user_events_attrs(struct thermal_zone_device
> > *tz)
> >  {
> >  	struct attribute **attrs;
> > @@ -260,8 +290,8 @@ static int create_user_events_attrs(struct
> > thermal_zone_device *tz)
> >  	if (tz->ops->get_temp_thres_high)
> >  		++index;
> >  
> > -	/* One additional space for NULL */
> > -	attrs = kcalloc(index + 1, sizeof(*attrs), GFP_KERNEL);
> > +	/* One additional space for NULL and temp_pollling_delay */
> > +	attrs = kcalloc(index + 2, sizeof(*attrs), GFP_KERNEL);
> >  	if (!attrs)
> >  		return -ENOMEM;
> >  
> > @@ -312,6 +342,8 @@ static int create_user_events_attrs(struct
> > thermal_zone_device *tz)
> >  		attrs[index] = &tz->threshold_attrs[index].attr.attr;
> >  		++index;
> >  	}
> > +	if (!tz->polling_delay && !tz->passive_delay)
> > +		attrs[index++] = &dev_attr_temp_polling_delay.attr;
> >  	attrs[index] = NULL;
> >  	tz->threshold_attribute_group.attrs = attrs;
> >  
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index ee9d79ace7ce..0ec4bd8c9c5c 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -216,6 +216,7 @@ struct thermal_zone_device {
> >  	enum thermal_notify_event notify_event;
> >  	struct attribute_group threshold_attribute_group;
> >  	struct thermal_attr *threshold_attrs;
> > +	int temp_polling_delay;
> >  };
> >  
> >  /**
> > 
> 
> 

