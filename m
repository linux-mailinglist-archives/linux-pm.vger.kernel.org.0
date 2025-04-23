Return-Path: <linux-pm+bounces-26009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058CA98123
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724A916521E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1626AA9B;
	Wed, 23 Apr 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkpCOhiH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B10267739
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393713; cv=none; b=f1vTgDNEO+iNivbNeDElbHNS/ws5T8m02L9yCnC+oQH7bVL9qg/24PvqQGHJI37jY96/WonHmHFb2XMqJSaGc+cY5NqJIk8fb77HJEg7nqbccxDS9d7qc9sdjIy7Jm1YFYLgk0uK6wMw5kMp+/q3KkpKg8cKc7sZQOOq+5DboQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393713; c=relaxed/simple;
	bh=tp9D6dTVIqGsT3lPvtKRa//nwdux9WpqLCvVhQY9huU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjpU4h7OWLz8rAksvmO43YUNL7IXqK4r5EcMKcC4d6R1gZHc7kZ1kW1QUtO1suwu+LitYy8hSbeWU3MV8B4kXAxHCRsTOR8PE3As7+N1x0Wijp1yFvY68wzVv3+bveQ/jjg5mMvwSV8VsY1cqpWQNoKcoifPz0qpE3JT3D1ezOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkpCOhiH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70821dba48eso5700257b3.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745393711; x=1745998511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMMHzQbc3DOKOLQmdiREJuJO+OIOF3BKkz8ey4xgZi8=;
        b=wkpCOhiHgBdQpdquh14gjfTV+pihPZ8iNnfsY17poikV5Hm509SberfKshKDSfnBet
         rd19/ce5mvr/xDX0LwW4l5/WYprzd7W/QA5Gjl4bUVw9OJDkqQ6kXYrbhD7kYsqUpywe
         Msze9f2QFVkSbFvk6KxzJLDLbHZvFrREr2iji8hus/xYVLf5y/CgVM8MAv+GGkpNK/gZ
         moXnuHQLTAkCMdKWlDQXDE8e/fIi9A06erYkW4RO/e1WSM8pDVuLimB5q+EHQ0PlNOw1
         K8MTNXSWArHGqQpy0NT4wPhLjulRikw5R+ksQitBTGSU9DEFumYVJZRsKRvQ1TgPJIsx
         SoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745393711; x=1745998511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMMHzQbc3DOKOLQmdiREJuJO+OIOF3BKkz8ey4xgZi8=;
        b=L9kIk/XYCLzCBSXdqI4UVU+kpZ0ad3KRbrkdQ6pyeWtAlRClTag6KG/Lrel8U1PzY6
         wkCyxP38+vtcmAVvQQhflLEAJn8EVa4ZIv0kQzAC9VM/aX1/XSHdJyDAqMeBhsCWPTn0
         n2rMCqZq0Fr8k/tbtEio6UFQs3ZkAA1lax5byLPT/jl3wjJD7PjTHm9aPjljhWthkuEg
         iXZRD0Ljm1+WYK+su0MLxOZ62WhQR7zMVmxVl6roJ4HDVQD0pXs2lQsdOnDXoNCboSYj
         JtQV3H4IKoeshRMUV5YikeDxyyAXdA5Dhc+QYCUu1euseiXamIhZ8AEf93rnP8QL/4FT
         75VA==
X-Forwarded-Encrypted: i=1; AJvYcCWTm+lIwQXmppMmRRL3/Z+5CZdMmhRax2N7v30lLTkAyqtsAS365hSGNePkueuM5J3TPAFEzVU38Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5FC2Bb8FOJ6Nxk3roQo8Kf067UbVffletx0S7LkQn9+ZumLu
	s4fgPGbyPC6YDhnT92bFg592V9Rah/pSqJypEFqWqP/5W3EWjUsMJQ7Xcm6f+3a6Aw7YuQft3oS
	uRmIEXqOdTcdWHbf6GX5FOxkFGTDMtmOECwVXtw==
X-Gm-Gg: ASbGncuPfOMDJ513HWwaONuLPsHf6rPi2zfpE9AzfO9rcfUklYmWqOWCwsEo8LwpyiI
	1PX7d26rIxI59wPLLzha4Dyezx0yRhaLeLWv73d0dYe7PIXfLjOCE7Yd49G3Wdm5UBcASSVlEo0
	nsrkTPOwHk7DmeAsxMfiTLYw==
X-Google-Smtp-Source: AGHT+IHHAtEFUZLhcbruHxpEpPorFQEnsYo12C8JxLrs3aH6bpX9x1WDRFduNm79Hualt6eVxiRRgQbVsZLz+ZRze24=
X-Received: by 2002:a05:690c:25c8:b0:702:d54:45be with SMTP id
 00721157ae682-706cce101cfmr246843717b3.35.1745393710883; Wed, 23 Apr 2025
 00:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-5-ulf.hansson@linaro.org> <aAehkpXAxh3bI0WT@linaro.org>
In-Reply-To: <aAehkpXAxh3bI0WT@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Apr 2025 09:34:34 +0200
X-Gm-Features: ATxdqUEyxZ9BnVBWNRMOFzP2PaM9YMbsKb03WnT7UGjwnB1ecsv-8AkyK7T40lE
Message-ID: <CAPDyKFqftAzxhoSo=A7Eu_0ueK6_BgMs+-mCZy=jQdm9aXQMog@mail.gmail.com>
Subject: Re: [PATCH 04/11] pmdomain: core: Add a bus and a driver for genpd providers
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 16:03, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 25-04-17 16:25:02, Ulf Hansson wrote:
> > When we create a genpd via pm_genpd_init() we are initializing a
> > corresponding struct device for it, but we don't add the device to any
> > bus_type. It has not really been needed as the device is used as cookie to
> > help us manage OPP tables.
> >
> > However, to prepare to make better use of the device let's add a new genpd
> > provider bus_type and a corresponding genpd provider driver. Subsequent
> > changes will make use of this.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/pmdomain/core.c | 89 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 88 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 035b65563947..da51a61a974c 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -27,6 +27,11 @@
> >  /* Provides a unique ID for each genpd device */
> >  static DEFINE_IDA(genpd_ida);
> >
> > +/* The parent for genpd_provider devices. */
> > +static struct device genpd_provider_bus = {
> > +     .init_name = "genpd_provider",
> > +};
> > +
> >  #define GENPD_RETRY_MAX_MS   250             /* Approximate */
> >
> >  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)               \
> > @@ -44,6 +49,14 @@ static DEFINE_IDA(genpd_ida);
> >  static LIST_HEAD(gpd_list);
> >  static DEFINE_MUTEX(gpd_list_lock);
> >
> > +#define to_genpd_provider_drv(d) container_of(d, struct genpd_provider_drv, drv)
> > +
> > +struct genpd_provider_drv {
>
> I'd replace "provider" substring and expand drv to driver everywhere.
>
> I think that's more in line with all other subsystems.

I understand your point, but it's not that straight-forward to find a
proper name this time.

We already have another bus_type for genpd consumer devices (virtual
devices created when attaching a device to one of its multiple PM
domains). That bus is already named "genpd".

>
> > +     struct device_driver drv;
> > +     int (*probe)(struct device *dev);
> > +     void (*remove)(struct device *dev);
> > +};
> > +
> >  struct genpd_lock_ops {
> >       void (*lock)(struct generic_pm_domain *genpd);
> >       void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
> > @@ -2225,6 +2238,26 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >       return 0;
> >  }
> >
> > +static int genpd_provider_bus_probe(struct device *dev)
>
> ... and then here drop the "provider" as well.

For the reason I pointed out above, I decided to use "provider" in the
bus/driver's functions names to have a clear difference from the
"consumer" genpd bus.

I am worried that if we don't use "provider" we will mix up things
with the existing genpd bus. Maybe there is a better option?

>
> Other than that, LGTM:
>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

Thanks for reviewing!

Kind regards
Uffe

