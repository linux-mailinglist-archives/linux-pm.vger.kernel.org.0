Return-Path: <linux-pm+bounces-16378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E99AE4B0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19DB1F23091
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245891D5158;
	Thu, 24 Oct 2024 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/A6hqxX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4591CFEA9;
	Thu, 24 Oct 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772580; cv=none; b=ns/vR8ccz/QtgAaB6tt2dG/318bif1xcvcCopn4XBh2eMAzTMLXhEuSK/hInHWmGf5Fn+cS+zhP6b6iW0DJ8Hv1nyFwEGeKHy5zsrsVYUrIty0nlzIj4RMQr1YjZmNYAkScL300Aq6ylB0a04KQi0Y97mG7StAg2mTZkIN7vEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772580; c=relaxed/simple;
	bh=YI6DCCxi0CSjmzw+GwJjmI+dvr+ZCqyrsq9P/8rZE+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AymcEI616wZIARWB3IPw1umL8dX+sVEF81bNCBCKe4vlqdS4K8HCkvuQYRHhB12dn7CvMiVqM5ji5TqfSsjlFTcX6Dxt4J8sSBxqD4KNUZYN+aI8hcDG6mIgIcOXIeUUhnmE3VoRLPOmz+VK2e8E+aQZTkCEazUqDnN2ih1X2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/A6hqxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C477C4CEE8;
	Thu, 24 Oct 2024 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772579;
	bh=YI6DCCxi0CSjmzw+GwJjmI+dvr+ZCqyrsq9P/8rZE+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c/A6hqxXYD/xc6ZDjzPQ1vdFTTO/2PqbNqXQ6gq5OwC+oF/8mHCKAw6yjQSd8lTry
	 cgAg6I1RKiKBuWmC9APwGYwSHRNZjJzUa88LaiWfYVSzEaHWabfcsSLyANqARSOb7t
	 IfsQQgGdWidU1/nrnAQx+dA8yPIiUlhe+ttyRxIkdTiOxU5c/bLkKHSy6zClAnRPPj
	 JAoAl6fscL1I30PmafonqfpMU/qy8tEuFr8KOVzcq6Gp+bGsI1xJJ8QGGCbA5G9Owx
	 1B8lsvGPKse6E07+grllh8c8mrzc07d411QhMWtwmwg+ZQaTqMhd/zlOn61MJPEW8J
	 rcuZ3KJATMcyw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebc0dbc65dso456098eaf.1;
        Thu, 24 Oct 2024 05:22:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm0qU+VCgLs7JdNkOJs6O82kH1zQ3omDEgCxf0gJ3vIQYc/r6l7xBayQJPLkW8poJgZElugp9j1A95Vvs=@vger.kernel.org, AJvYcCXyrO91FtuQxLWzlnU+hQq5Jbo2/UBl6nyS+1T9YNl6Qq8rN7L58FU7Px6LwG5kV/W+MHfb6Rhxx54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1Wdbm35vHr6ewqupvvMN8btlQU39r0jz8V3eOsloNh1+61hY
	5BGeywTU3IVbM/wQS1QvQP7ET7EGCWfYsL/dfh5z2MbnoV4HlYUoUCdaB2EZqQKwm4hq978nPLH
	OFHP9RQVefSsvaRlOY3mfLuwl4pk=
X-Google-Smtp-Source: AGHT+IFnhLN215f2IyL3mFLVM7uPTwDgXuWYN5UpggpimSgaYu+su0RNZzAi8BFnyqfyl/zvyZfeGZ6MV1rX/9V9tAQ=
X-Received: by 2002:a05:6871:554:b0:277:eb79:b4fb with SMTP id
 586e51a60fabf-28ced1178bamr1643855fac.1.1729772578502; Thu, 24 Oct 2024
 05:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4958885.31r3eYUQgx@rjwysocki.net> <2003443.usQuhbGJ8B@rjwysocki.net>
 <3bbf1762-732b-4040-a3f1-eec575ee005e@arm.com>
In-Reply-To: <3bbf1762-732b-4040-a3f1-eec575ee005e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 14:22:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gotNhMKe8EiGZNFf_WTqoEHVj4wXruU3ZiHSZ2DUK0NA@mail.gmail.com>
Message-ID: <CAJZ5v0gotNhMKe8EiGZNFf_WTqoEHVj4wXruU3ZiHSZ2DUK0NA@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] thermal: core: Use trip lists for trip crossing detection
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 1:47=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 10/16/24 12:35, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Modify the thermal core to use three lists of trip points:
> >
> >   trips_high, containing trips with thresholds strictly above the curre=
nt
> >   thermal zone temperature,
> >
> >   trips_reached, containing trips with thresholds at or below the curre=
nt
> >   zone temperature,
> >
> >   trips_invalid, containing trips with temperature equal to
> >   THERMAL_ZONE_INVALID,
> >
> > where the first two lists are always sorted by the current trip
> > threshold.
> >
> > For each trip in trips_high, there is no mitigation under way and
> > the trip threshold is equal to its temperature.  In turn, for each
> > trip in trips_reached, there is mitigation under way and the trip
> > threshold is equal to its low temperature.  The trips in trips_invalid,
> > of course, need not be taken into consideration.
> >
> > The idea is to make __thermal_zone_device_update() walk trips_high and
> > trips_reached instead of walking the entire table of trip points in a
> > thermal zone.  Usually, it will only need to walk a few entries in one
> > of the lists and check one entry in the other list, depending on the
> > direction of the zone temperature changes, because crossing many trips
> > by the zone temperature in one go between two consecutive temperature
> > checks should be unlikely (if it occurs often, the thermal zone
> > temperature should probably be checked more often either or there
> > are too many trips).
> >
> > This also helps to eliminate one temporary trip list used for trip
> > crossing notification (only one temporary list is needed for this
> > purpose instead of two) and the remaining temporary list may be sorted
> > by the current trip threshold value, like the trips_reached list, so
> > the additional notify_temp field in struct thermal_trip_desc is not
> > necessary any more.
> >
> > Moreover, since the trips_reached and trips_high lists are sorted,
> > the "low" and "high" values needed by thermal_zone_set_trips() can be
> > determined in a straightforward way by looking at one end of each list.
> >
> > Of course, additional work is needed in some places in order to
> > maintain the ordering of the lists, but it is limited to situations
> > that should be rare, like updating a trip point temperature or
> > hysteresis, thermal zone initialization, or system resume.
>
> Good point I agree. Even the trips from userspace that Daniel
> proposed shouldn't impact that design decision IMHO.
> Any disagreement (or am I missing something)?

No disagreement AFAIK.

> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c |  211 +++++++++++++++++++++++++------=
----------
> >   drivers/thermal/thermal_core.h |    7 +
> >   2 files changed, 136 insertions(+), 82 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -33,7 +33,6 @@ struct thermal_trip_desc {
> >       struct thermal_trip_attrs trip_attrs;
> >       struct list_head list_node;
> >       struct list_head thermal_instances;
> > -     int notify_temp;
> >       int threshold;
> >   };
> >
> > @@ -78,6 +77,9 @@ struct thermal_governor {
> >    * @device: &struct device for this thermal zone
> >    * @removal:        removal completion
> >    * @resume: resume completion
> > + * @trips_high:      trips above the current zone temperature
> > + * @trips_reached:   trips below or at the current zone temperature
> > + * @trips_invalid:   trips with invalid temperature
> >    * @mode:           current mode of this thermal zone
> >    * @devdata:        private pointer for device private data
> >    * @num_trips:      number of trip points the thermal zone supports
> > @@ -118,6 +120,9 @@ struct thermal_zone_device {
> >       struct completion removal;
> >       struct completion resume;
> >       struct attribute_group trips_attribute_group;
> > +     struct list_head trips_high;
> > +     struct list_head trips_reached;
> > +     struct list_head trips_invalid;
> >       enum thermal_device_mode mode;
> >       void *devdata;
> >       int num_trips;
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -421,7 +421,7 @@ static void move_trip_to_sorted_list(str
> >
> >       /* Assume that the new entry is likely to be the last one. */
> >       list_for_each_entry_reverse(entry, list, list_node) {
> > -             if (entry->notify_temp <=3D td->notify_temp) {
> > +             if (entry->threshold <=3D td->threshold) {
> >                       list_add(&td->list_node, &entry->list_node);
> >                       return;
> >               }
> > @@ -429,53 +429,6 @@ static void move_trip_to_sorted_list(str
> >       list_add(&td->list_node, list);
> >   }
> >
> > -static void handle_thermal_trip(struct thermal_zone_device *tz,
> > -                             struct thermal_trip_desc *td,
> > -                             struct list_head *way_up_list,
> > -                             struct list_head *way_down_list)
> > -{
> > -     const struct thermal_trip *trip =3D &td->trip;
> > -     int old_threshold;
> > -
> > -     if (trip->temperature =3D=3D THERMAL_TEMP_INVALID)
> > -             return;
> > -
> > -     /*
> > -      * If the trip temperature or hysteresis has been updated recentl=
y,
> > -      * the threshold needs to be computed again using the new values.
> > -      * However, its initial value still reflects the old ones and tha=
t
> > -      * is what needs to be compared with the previous zone temperatur=
e
> > -      * to decide which action to take.
> > -      */
> > -     old_threshold =3D td->threshold;
> > -     td->threshold =3D trip->temperature;
> > -
> > -     if (tz->last_temperature >=3D old_threshold &&
> > -         tz->last_temperature !=3D THERMAL_TEMP_INIT) {
> > -             /*
> > -              * Mitigation is under way, so it needs to stop if the zo=
ne
> > -              * temperature falls below the low temperature of the tri=
p.
> > -              * In that case, the trip temperature becomes the new thr=
eshold.
> > -              */
> > -             if (tz->temperature < trip->temperature - trip->hysteresi=
s) {
> > -                     td->notify_temp =3D trip->temperature - trip->hys=
teresis;
> > -                     move_trip_to_sorted_list(td, way_down_list);
> > -             } else {
> > -                     td->threshold -=3D trip->hysteresis;
> > -             }
> > -     } else if (tz->temperature >=3D trip->temperature) {
> > -             /*
> > -              * There is no mitigation under way, so it needs to be st=
arted
> > -              * if the zone temperature exceeds the trip one.  The new
> > -              * threshold is then set to the low temperature of the tr=
ip.
> > -              */
> > -             td->notify_temp =3D trip->temperature;
> > -             move_trip_to_sorted_list(td, way_up_list);
> > -
> > -             td->threshold -=3D trip->hysteresis;
> > -     }
> > -}
> > -
> >   static void thermal_zone_device_check(struct work_struct *work)
> >   {
> >       struct thermal_zone_device *tz =3D container_of(work, struct
> > @@ -484,9 +437,30 @@ static void thermal_zone_device_check(st
> >       thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> >   }
> >
> > +static void move_to_trips_high(struct thermal_zone_device *tz,
> > +                            struct thermal_trip_desc *td)
> > +{
> > +     td->threshold =3D td->trip.temperature;
> > +     move_trip_to_sorted_list(td, &tz->trips_high);
> > +}
> > +
> > +static void move_to_trips_reached(struct thermal_zone_device *tz,
> > +                               struct thermal_trip_desc *td)
> > +{
> > +     td->threshold =3D td->trip.temperature - td->trip.hysteresis;
> > +     move_trip_to_sorted_list(td, &tz->trips_reached);
> > +}
> > +
> > +static void move_to_trips_invalid(struct thermal_zone_device *tz,
> > +                               struct thermal_trip_desc *td)
> > +{
> > +     td->threshold =3D INT_MAX;
> > +     list_move(&td->list_node, &tz->trips_invalid);
> > +}
> > +
> >   static void thermal_zone_device_init(struct thermal_zone_device *tz)
> >   {
> > -     struct thermal_trip_desc *td;
> > +     struct thermal_trip_desc *td, *next;
> >
> >       INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
> >
> > @@ -500,6 +474,21 @@ static void thermal_zone_device_init(str
> >               list_for_each_entry(instance, &td->thermal_instances, tri=
p_node)
> >                       instance->initialized =3D false;
> >       }
> > +     /*
> > +      * At this point, all valid trips need to be moved to trips_high =
so that
> > +      * mitigation can be started if the zone temperature is above the=
m.
> > +      */
> > +     list_for_each_entry_safe(td, next, &tz->trips_invalid, list_node)=
 {
> > +             if (td->trip.temperature !=3D THERMAL_TEMP_INVALID)
> > +                     move_to_trips_high(tz, td);
> > +     }
> > +     /* The trips_reached list may not be empty during system resume. =
*/
> > +     list_for_each_entry_safe(td, next, &tz->trips_reached, list_node)=
 {
> > +             if (td->trip.temperature =3D=3D THERMAL_TEMP_INVALID)
> > +                     move_to_trips_invalid(tz, td);
> > +             else
> > +                     move_to_trips_high(tz, td);
> > +     }
> >   }
> >
> >   static void thermal_governor_trip_crossed(struct thermal_governor *go=
vernor,
> > @@ -544,45 +533,120 @@ static void thermal_trip_crossed(struct
> >   void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
> >                               struct thermal_trip *trip, int hyst)
> >   {
> > +     struct thermal_trip_desc *td =3D trip_to_trip_desc(trip);
> > +
> >       WRITE_ONCE(trip->hysteresis, hyst);
> >       thermal_notify_tz_trip_change(tz, trip);
> > +     /*
> > +      * If the zone temperature is above or at the trip tmperature, th=
e trip
> > +      * is in the trips_reached list and its threshold is equal to its=
 low
> > +      * temperature.  It needs to stay in that list, but its threshold=
 needs
> > +      * to be updated and the list ordering may need to be restored.
> > +      */
> > +     if (tz->temperature >=3D td->threshold)
> > +             move_to_trips_reached(tz, td);
> >   }
> >
> >   void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> >                               struct thermal_trip *trip, int temp)
> >   {
> > -     if (trip->temperature =3D=3D temp)
> > +     struct thermal_trip_desc *td =3D trip_to_trip_desc(trip);
> > +     int old_temp =3D trip->temperature;
> > +
> > +     if (old_temp =3D=3D temp)
> >               return;
> >
> >       WRITE_ONCE(trip->temperature, temp);
> >       thermal_notify_tz_trip_change(tz, trip);
> >
> > -     if (temp =3D=3D THERMAL_TEMP_INVALID) {
> > -             struct thermal_trip_desc *td =3D trip_to_trip_desc(trip);
> > +     if (old_temp =3D=3D THERMAL_TEMP_INVALID) {
> > +             /*
> > +              * The trip was invalid before the change, so move it to =
the
> > +              * trips_high list regardless of the new temperature valu=
e
> > +              * because there is no mitigation under way for it.  If a
> > +              * mitigation needs to be started, the trip will be moved=
 to the
> > +              * trips_reached list later.
> > +              */
>
> Good comment
>
> > +             move_to_trips_high(tz, td);
> > +             return;
> > +     }
> >
> > +     if (temp =3D=3D THERMAL_TEMP_INVALID) {
> >               /*
> > -              * If the trip has been crossed on the way up, some adjus=
tments
> > -              * are needed to compensate for the lack of it going forw=
ard.
> > +              * If the trip is in the trips_reached list, mitigation i=
s under
> > +              * way for it and it needs to be stopped because the trip=
 is
> > +              * effectively going away.
> >                */
> >               if (tz->temperature >=3D td->threshold)
> >                       thermal_trip_crossed(tz, td, thermal_get_tz_gover=
nor(tz), false);
> >
> > +             move_to_trips_invalid(tz, td);
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * The trip stays on its current list, but its threshold needs to=
 be
> > +      * updated due to the temperature change and the list ordering ma=
y need
> > +      * to be restored.
> > +      */
> > +     if (tz->temperature >=3D td->threshold)
> > +             move_to_trips_reached(tz, td);
> > +     else
> > +             move_to_trips_high(tz, td);
> > +}
> > +EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> > +
> > +static void thermal_zone_handle_trips(struct thermal_zone_device *tz,
> > +                                   struct thermal_governor *governor,
> > +                                   int *low, int *high)
> > +{
> > +     struct thermal_trip_desc *td, *next;
> > +     LIST_HEAD(way_down_list);
> > +
> > +     /* Check the trips that were below or at the zone temperature. */
> > +     list_for_each_entry_safe_reverse(td, next, &tz->trips_reached, li=
st_node) {
> > +             if (td->threshold <=3D tz->temperature)
> > +                     break;
> > +
> > +             thermal_trip_crossed(tz, td, governor, false);
> >               /*
> > -              * Invalidate the threshold to avoid triggering a spuriou=
s
> > -              * trip crossing notification when the trip becomes valid=
.
> > +              * The current trips_high list needs to be processed befo=
re
> > +              * adding new entries to it, so put them on a temporary l=
ist.
> >                */
> > -             td->threshold =3D INT_MAX;
> > +             list_move(&td->list_node, &way_down_list);
> > +     }
> > +     /* Check the trips that were previously above the zone temperatur=
e. */
> > +     list_for_each_entry_safe(td, next, &tz->trips_high, list_node) {
> > +             if (td->threshold > tz->temperature)
> > +                     break;
> > +
> > +             thermal_trip_crossed(tz, td, governor, true);
> > +             move_to_trips_reached(tz, td);
> > +     }
>
> nit:
> I would add and extra empty line here, since this is
> quite separate from the loop above and has important
> meaning.

It is though closely related to the first loop.

I'll add a one-line comment here when applying the patch.

> > +     list_for_each_entry_safe(td, next, &way_down_list, list_node)
> > +             move_to_trips_high(tz, td);
> > +
> > +     if (!list_empty(&tz->trips_reached)) {
> > +             td =3D list_last_entry(&tz->trips_reached,
> > +                                  struct thermal_trip_desc, list_node)=
;
> > +             /*
> > +              * Set the "low" value below the current trip threshold i=
n case
> > +              * the zone temperature is at that threshold and stays th=
ere,
> > +              * which would trigger a new interrupt immediately in vai=
n.
> > +              */
> > +             *low =3D td->threshold - 1;
> > +     }
> > +     if (!list_empty(&tz->trips_high)) {
> > +             td =3D list_first_entry(&tz->trips_high,
> > +                                   struct thermal_trip_desc, list_node=
);
> > +             *high =3D td->threshold;
> >       }
> >   }
> > -EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> >
> >   void __thermal_zone_device_update(struct thermal_zone_device *tz,
> >                                 enum thermal_notify_event event)
> >   {
> >       struct thermal_governor *governor =3D thermal_get_tz_governor(tz)=
;
> > -     struct thermal_trip_desc *td, *next;
> > -     LIST_HEAD(way_down_list);
> > -     LIST_HEAD(way_up_list);
> >       int low =3D -INT_MAX, high =3D INT_MAX;
> >       int temp, ret;
> >
> > @@ -614,25 +678,7 @@ void __thermal_zone_device_update(struct
> >
> >       tz->notify_event =3D event;
> >
> > -     for_each_trip_desc(tz, td) {
> > -             handle_thermal_trip(tz, td, &way_up_list, &way_down_list)=
;
> > -
> > -             if (td->threshold <=3D tz->temperature && td->threshold >=
 low)
> > -                     low =3D td->threshold;
> > -
> > -             if (td->threshold >=3D tz->temperature && td->threshold <=
 high)
> > -                     high =3D td->threshold;
> > -     }
> > -
> > -     list_for_each_entry_safe(td, next, &way_up_list, list_node) {
> > -             thermal_trip_crossed(tz, td, governor, true);
> > -             list_del_init(&td->list_node);
> > -     }
> > -
> > -     list_for_each_entry_safe_reverse(td, next, &way_down_list, list_n=
ode) {
> > -             thermal_trip_crossed(tz, td, governor, false);
> > -             list_del_init(&td->list_node);
> > -     }
> > +     thermal_zone_handle_trips(tz, governor, &low, &high);
> >
> >       thermal_thresholds_handle(tz, &low, &high);
> >
> > @@ -1507,6 +1553,9 @@ thermal_zone_device_register_with_trips(
> >       }
> >
> >       INIT_LIST_HEAD(&tz->node);
> > +     INIT_LIST_HEAD(&tz->trips_high);
> > +     INIT_LIST_HEAD(&tz->trips_reached);
> > +     INIT_LIST_HEAD(&tz->trips_invalid);
> >       ida_init(&tz->ida);
> >       mutex_init(&tz->lock);
> >       init_completion(&tz->removal);
> > @@ -1536,7 +1585,7 @@ thermal_zone_device_register_with_trips(
> >                * this only matters for the trips that start as invalid =
and
> >                * become valid later.
> >                */
> > -             td->threshold =3D INT_MAX;
> > +             move_to_trips_invalid(tz, td);
> >       }
> >
> >       tz->polling_delay_jiffies =3D msecs_to_jiffies(polling_delay);
> >
> >
> >
>
> It took me a while to get the new code flow and idea.
>
> Anyway, not that much controversial changes, which might
> look like, on the first glance, LGTM.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you and thanks for all of the reviews!

