Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C081D8BAF
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgERXka (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 19:40:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:29440 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgERXk3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 19:40:29 -0400
IronPort-SDR: AUOXTi/Ynv3CgSfudNR8mWxUMZcwqqSf6iOfH1sZG9enQE6w8xVp8v9YRmI1YW/dZ5wV9/QsNo
 HpSvHrWlMoAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:40:25 -0700
IronPort-SDR: iz1nXBt9K4ogBQpYtnjfZYYRebULUmKsIDkJcJ1yJMO4IBF9SMKYcL6iIJw/BPeJlZXXbHihq6
 S0VBYro51sqQ==
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="411441805"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.227.7])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:40:24 -0700
Message-ID: <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
Subject: Re: [RFC][PATCH 3/5] thermal: Add support for setting notification
 thresholds
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Mon, 18 May 2020 16:40:22 -0700
In-Reply-To: <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
         <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
         <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-05-18 at 18:37 +0200, Daniel Lezcano wrote:
> On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > Add new attributes in thermal syfs when a thermal drivers provides
> > callbacks for them and CONFIG_THERMAL_USER_EVENT_INTERFACE is
> > defined.
> > 
> > These attribute allow user space to stop polling for temperature.
> > 
> > These attributes are:
> > - temp_thres_low: Specify a notification temperature for a low
> > temperature threshold event.
> > temp_thres_high: Specify a notification temperature for a high
> > temperature threshold event.
> > temp_thres_hyst: Specify a change in temperature to send
> > notification
> > again.
> > 
> > This is implemented by adding additional sysfs attribute group. The
> > changes in this patch are trivial to add new attributes in thermal
> > sysfs as done for other attributes.
> 
> Isn't it duplicate with the trip point?
A trip point is where an in-kernel governor takes some action. This is
not same as a notification temperature. For example at trip point
configured by ACPI at 85C, the thermal governor may start aggressive
throttling. 
But a user space can set a notification threshold at 80C and start some
active controls like activate some fan to reduce the impact of passive
control on performance.

We need a way to distinguish between temperature notification threshold
and actual trip point. Changing a trip point means that user wants
kernel to throttle at temperature.


Thanks,
Srinivas

> 
> 
> 
> 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 136
> > +++++++++++++++++++++++++++++++-
> >  include/linux/thermal.h         |  10 ++-
> >  2 files changed, 143 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_sysfs.c
> > b/drivers/thermal/thermal_sysfs.c
> > index aa99edb4dff7..aa85424c3ac4 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -215,6 +215,125 @@ trip_point_hyst_show(struct device *dev,
> > struct device_attribute *attr,
> >  	return ret ? ret : sprintf(buf, "%d\n", temperature);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_THERMAL_USER_EVENT_INTERFACE)
> > +
> > +#define create_thres_attr(name)					
> > \
> > +	static ssize_t							
> > \
> > +	name##_show(struct device *dev, struct device_attribute
> > *devattr, \
> > +		char *buf)						\
> > +	{								\
> > +	struct thermal_zone_device *tz = to_thermal_zone(dev);	\
> > +	int temperature, ret;						
> > \
> > +									
> > \
> > +	ret = tz->ops->get_##name(tz, &temperature);			
> > \
> > +									
> > \
> > +	return ret ? ret : sprintf(buf, "%d\n", temperature);	\
> > +	}								\
> > +									
> > \
> > +	static ssize_t							
> > \
> > +	name##_store(struct device *dev, struct device_attribute
> > *devattr, \
> > +		const char *buf, size_t count)				
> > \
> > +	{								\
> > +		struct thermal_zone_device *tz = to_thermal_zone(dev);	
> > \
> > +		int temperature, ret;					
> > \
> > +									
> > \
> > +		if (kstrtoint(buf, 10, &temperature))			
> > \
> > +			return -EINVAL;				\
> > +									
> > \
> > +		ret = tz->ops->set_##name(tz, temperature);		\
> > +		return ret ? ret : count;				\
> > +	}
> > +
> > +create_thres_attr(temp_thres_low);
> > +create_thres_attr(temp_thres_high);
> > +create_thres_attr(temp_thres_hyst);
> > +
> > +static int create_user_events_attrs(struct thermal_zone_device
> > *tz)
> > +{
> > +	struct attribute **attrs;
> > +	int index = 0;
> > +
> > +	if (tz->ops->get_temp_thres_low)
> > +		++index;
> > +	if (tz->ops->get_temp_thres_high)
> > +		++index;
> > +	if (tz->ops->get_temp_thres_high)
> > +		++index;
> > +
> > +	/* One additional space for NULL */
> > +	attrs = kcalloc(index + 1, sizeof(*attrs), GFP_KERNEL);
> > +	if (!attrs)
> > +		return -ENOMEM;
> > +
> > +	tz->threshold_attrs = kcalloc(index, sizeof(*tz-
> > >threshold_attrs), GFP_KERNEL);
> > +	if (!tz->threshold_attrs) {
> > +		kfree(attrs);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	index = 0;
> > +
> > +	if (tz->ops->get_temp_thres_low) {
> > +		snprintf(tz->threshold_attrs[index].name,
> > THERMAL_NAME_LENGTH,
> > +			 "temp_thres_low");
> > +
> > +		sysfs_attr_init(&tz->threshold_attrs[index].attr.attr);
> > +		tz->threshold_attrs[index].attr.attr.name =
> > +						tz-
> > >threshold_attrs[index].name;
> > +		tz->threshold_attrs[index].attr.attr.mode = S_IWUSR |
> > S_IRUGO;
> > +		tz->threshold_attrs[index].attr.show =
> > temp_thres_low_show;
> > +		tz->threshold_attrs[index].attr.store =
> > temp_thres_low_store;
> > +		attrs[index] = &tz->threshold_attrs[index].attr.attr;
> > +		++index;
> > +	}
> > +	if (tz->ops->get_temp_thres_high) {
> > +		snprintf(tz->threshold_attrs[index].name,
> > THERMAL_NAME_LENGTH,
> > +			 "temp_thres_high");
> > +
> > +		sysfs_attr_init(&tz->threshold_attrs[index].attr.attr);
> > +		tz->threshold_attrs[index].attr.attr.name =
> > +						tz-
> > >threshold_attrs[index].name;
> > +		tz->threshold_attrs[index].attr.attr.mode = S_IWUSR |
> > S_IRUGO;
> > +		tz->threshold_attrs[index].attr.show =
> > temp_thres_high_show;
> > +		tz->threshold_attrs[index].attr.store =
> > temp_thres_high_store;
> > +		attrs[index] = &tz->threshold_attrs[index].attr.attr;
> > +		++index;
> > +	}
> > +	if (tz->ops->get_temp_thres_hyst) {
> > +		snprintf(tz->threshold_attrs[index].name,
> > THERMAL_NAME_LENGTH,
> > +			 "temp_thres_hyst");
> > +
> > +		sysfs_attr_init(&tz->threshold_attrs[index].attr.attr);
> > +		tz->threshold_attrs[index].attr.attr.name =
> > +						tz-
> > >threshold_attrs[index].name;
> > +		tz->threshold_attrs[index].attr.attr.mode = S_IWUSR |
> > S_IRUGO;
> > +		tz->threshold_attrs[index].attr.show =
> > temp_thres_hyst_show;
> > +		tz->threshold_attrs[index].attr.store =
> > temp_thres_hyst_store;
> > +		attrs[index] = &tz->threshold_attrs[index].attr.attr;
> > +		++index;
> > +	}
> > +	attrs[index] = NULL;
> > +	tz->threshold_attribute_group.attrs = attrs;
> > +
> > +	return 0;
> > +}
> > +
> > +static void delete_user_events_attrs(struct thermal_zone_device
> > *tz)
> > +{
> > +	kfree(tz->threshold_attrs);
> > +	kfree(tz->threshold_attribute_group.attrs);
> > +}
> > +#else
> > +static int create_user_events_attrs(struct thermal_zone_device
> > *tz)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> > +static void delete_user_events_attrs(struct thermal_zone_device
> > *tz)
> > +{
> > +}
> > +#endif
> > +
> >  static ssize_t
> >  passive_store(struct device *dev, struct device_attribute *attr,
> >  	      const char *buf, size_t count)
> > @@ -625,16 +744,27 @@ int thermal_zone_create_device_groups(struct
> > thermal_zone_device *tz,
> >  {
> >  	const struct attribute_group **groups;
> >  	int i, size, result;
> > +	int start = 0;
> >  
> >  	/* we need one extra for trips and the NULL to terminate the
> > array */
> >  	size = ARRAY_SIZE(thermal_zone_attribute_groups) + 2;
> > +
> > +	result = create_user_events_attrs(tz);
> > +	if (!result) {
> > +		++size;
> > +		++start;
> > +	}
> > +
> >  	/* This also takes care of API requirement to be NULL
> > terminated */
> >  	groups = kcalloc(size, sizeof(*groups), GFP_KERNEL);
> >  	if (!groups)
> >  		return -ENOMEM;
> >  
> > -	for (i = 0; i < size - 2; i++)
> > -		groups[i] = thermal_zone_attribute_groups[i];
> > +	if (start)
> > +		groups[0] = &tz->threshold_attribute_group;
> > +
> > +	for (i = 0; i < size - 2 - start; i++)
> > +		groups[i + start] = thermal_zone_attribute_groups[i];
> >  
> >  	if (tz->trips) {
> >  		result = create_trip_attrs(tz, mask);
> > @@ -660,6 +790,8 @@ void thermal_zone_destroy_device_groups(struct
> > thermal_zone_device *tz)
> >  	if (tz->trips)
> >  		destroy_trip_attrs(tz);
> >  
> > +	delete_user_events_attrs(tz);
> > +
> >  	kfree(tz->device.groups);
> >  }
> >  
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index f5e1e7c6a9a2..ee9d79ace7ce 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -102,6 +102,12 @@ struct thermal_zone_device_ops {
> >  			  enum thermal_trend *);
> >  	int (*notify) (struct thermal_zone_device *, int,
> >  		       enum thermal_trip_type);
> > +	int (*set_temp_thres_low)(struct thermal_zone_device *, int);
> > +	int (*set_temp_thres_high)(struct thermal_zone_device *, int);
> > +	int (*set_temp_thres_hyst)(struct thermal_zone_device *, int);
> > +	int (*get_temp_thres_low)(struct thermal_zone_device *, int *);
> > +	int (*get_temp_thres_high)(struct thermal_zone_device *, int
> > *);
> > +	int (*get_temp_thres_hyst)(struct thermal_zone_device *, int
> > *);
> >  };
> >  
> >  struct thermal_cooling_device_ops {
> > @@ -208,6 +214,8 @@ struct thermal_zone_device {
> >  	struct list_head node;
> >  	struct delayed_work poll_queue;
> >  	enum thermal_notify_event notify_event;
> > +	struct attribute_group threshold_attribute_group;
> > +	struct thermal_attr *threshold_attrs;
> >  };
> >  
> >  /**
> > @@ -558,7 +566,7 @@ enum thermal_device_events {
> >  	THERMAL_PERF_CHANGED,
> >  };
> >  
> > -#ifdef CONFIG_THERMAL_USER_EVENT_INTERFACE
> > +#if IS_ENABLED(CONFIG_THERMAL_USER_EVENT_INTERFACE)
> >  int thermal_dev_send_event(int zone_id, enum thermal_device_events
> > event, u64 event_data);
> >  #else
> >  int thermal_dev_send_event(int zone_id, enum thermal_device_events
> > event, u64 event_data)
> > 
> 
> 

