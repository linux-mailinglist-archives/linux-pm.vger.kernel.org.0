Return-Path: <linux-pm+bounces-21329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73EA2746F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014591883BF3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196D621324D;
	Tue,  4 Feb 2025 14:33:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509652D057;
	Tue,  4 Feb 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679592; cv=none; b=Qc2ft1esq9lpfE+sDxILB3oFWhU6ss8rC4YR2mgZQa3AQbKs5ERYXkSGSzQMp96svk3YjEc5cwIEG7yBpLbLLQol4AyWdGaJO+Mys/nJJ7YougyJjGqUOtrKFNWD2SiE+IzG1N29Y8rJXP05fDWCsu1jdzZxgfvZsSPkAvCzWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679592; c=relaxed/simple;
	bh=3R63IJE4ryM7OJvdDBZ43Xj4Z2vvihHK05SYN6fsRXU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vErRheuOTIxEcSueYoaZ4kYdO1214p+DOHDl6Fl893wbNhyLmcN9vbVE9wrmrwrFfF1Yw1NOIAskyI9p+nZbWGxokwYBKn46UcLiITm6CmDEZbiLmZvQhq/0meCn1oHLVsAjO2n/37XSLCeBOMIhXKoBQyJ+YM4slAvONjyz9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnQkt2SxVz6L4vs;
	Tue,  4 Feb 2025 22:30:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B29B1140B67;
	Tue,  4 Feb 2025 22:33:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 15:33:04 +0100
Date: Tue, 4 Feb 2025 14:33:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>, Claudiu
	<claudiu.beznea@tuxon.dev>, <rafael@kernel.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>, "Claudiu
 Beznea" <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 2/6] thermal: of: Export non-devres helper to
 register/unregister thermal zone
Message-ID: <20250204143303.0000174a@huawei.com>
In-Reply-To: <CAPDyKFq40KB6jKapnm0mOkFGB9-7VEGiBhNrVn_2fzrcziq0=Q@mail.gmail.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
	<20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com>
	<46c8e8ff-ea39-4dbd-a26c-67fcabf4b589@linaro.org>
	<CAPDyKFq40KB6jKapnm0mOkFGB9-7VEGiBhNrVn_2fzrcziq0=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 15 Jan 2025 16:42:37 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Thu, 9 Jan 2025 at 18:34, Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
> >
> >
> > Ulf,
> >
> > can you have a look at this particular patch please ?
> >
> > Perhaps this scenario already happened in the past and there is an
> > alternative to fix it instead of this proposed change =20
>=20
> I think the patch makes sense.
>=20
> If there is a PM domain that is attached to the device that is
> managing the clocks for the thermal zone, the detach procedure
> certainly needs to be well controlled/synchronized.
>=20
Does this boil down to the same issue as
https://lore.kernel.org/linux-iio/20250128105908.0000353b@huawei.com/
?

Just to point out there is another way like is done in i2c:
https://elixir.bootlin.com/linux/v6.12.6/source/drivers/i2c/i2c-core-base.c=
#L630

Register a devres_release_group() in bus probe() and release it before
the dev_pm_domain_detach() call.  That keeps the detach procedure well
controlled and synchronized as it is entirely in control of the driver.

That IIO thread has kind of died out for now though with no resolution
so far.

Jonathan


> >
> >
> > On 03/01/2025 17:38, Claudiu wrote: =20
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}=
),
> > > clocks are managed through PM domains. These PM domains, registered on
> > > behalf of the clock controller driver, are configured with
> > > GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
> > > clocks are enabled/disabled using runtime PM APIs.
> > >
> > > During probe, devices are attached to the PM domain controlling their
> > > clocks. Similarly, during removal, devices are detached from the PM d=
omain.
> > >
> > > The detachment call stack is as follows:
> > >
> > > device_driver_detach() ->
> > >    device_release_driver_internal() ->
> > >      __device_release_driver() ->
> > >        device_remove() ->
> > >          platform_remove() ->
> > >         dev_pm_domain_detach()
> > >
> > > In the upcoming Renesas RZ/G3S thermal driver, the
> > > struct thermal_zone_device_ops::change_mode API is implemented to
> > > start/stop the thermal sensor unit. Register settings are updated wit=
hin
> > > the change_mode API.
> > >
> > > In case devres helpers are used for thermal zone register/unregister =
the
> > > struct thermal_zone_device_ops::change_mode API is invoked when the
> > > driver is unbound. The identified call stack is as follows:
> > >
> > > device_driver_detach() ->
> > >    device_release_driver_internal() ->
> > >      device_unbind_cleanup() ->
> > >        devres_release_all() ->
> > >          devm_thermal_of_zone_release() ->
> > >         thermal_zone_device_disable() ->
> > >           thermal_zone_device_set_mode() ->
> > >             rzg3s_thermal_change_mode()
> > >
> > > The device_unbind_cleanup() function is called after the thermal devi=
ce is
> > > detached from the PM domain (via dev_pm_domain_detach()).
> > >
> > > The rzg3s_thermal_change_mode() implementation calls
> > > pm_runtime_resume_and_get()/pm_runtime_put_autosuspend() before/after
> > > accessing the registers. However, during the unbind scenario, the
> > > devm_thermal_of_zone_release() is invoked after dev_pm_domain_detach(=
).
> > > Consequently, the clocks are not enabled, as the device is removed fr=
om
> > > the PM domain at this time, leading to an Asynchronous SError Interru=
pt.
> > > The system cannot be used after this.
> > >
> > > Add thermal_of_zone_register()/thermal_of_zone_unregister(). These wi=
ll
> > > be used in the upcomming RZ/G3S thermal driver.
> > >
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> =20
>=20
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Kind regards
> Uffe
>=20
> > > ---
> > >   drivers/thermal/thermal_of.c |  8 +++++---
> > >   include/linux/thermal.h      | 14 ++++++++++++++
> > >   2 files changed, 19 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_o=
f.c
> > > index fab11b98ca49..8fc35d20db60 100644
> > > --- a/drivers/thermal/thermal_of.c
> > > +++ b/drivers/thermal/thermal_of.c
> > > @@ -329,11 +329,12 @@ static bool thermal_of_should_bind(struct therm=
al_zone_device *tz,
> > >    *
> > >    * @tz: a pointer to the thermal zone structure
> > >    */
> > > -static void thermal_of_zone_unregister(struct thermal_zone_device *t=
z)
> > > +void thermal_of_zone_unregister(struct thermal_zone_device *tz)
> > >   {
> > >       thermal_zone_device_disable(tz);
> > >       thermal_zone_device_unregister(tz);
> > >   }
> > > +EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
> > >
> > >   /**
> > >    * thermal_of_zone_register - Register a thermal zone with device n=
ode
> > > @@ -355,8 +356,8 @@ static void thermal_of_zone_unregister(struct the=
rmal_zone_device *tz)
> > >    *  - ENOMEM: if one structure can not be allocated
> > >    *  - Other negative errors are returned by the underlying called f=
unctions
> > >    */
> > > -static struct thermal_zone_device *thermal_of_zone_register(struct d=
evice_node *sensor, int id, void *data,
> > > -                                                         const struc=
t thermal_zone_device_ops *ops)
> > > +struct thermal_zone_device *thermal_of_zone_register(struct device_n=
ode *sensor, int id, void *data,
> > > +                                                  const struct therm=
al_zone_device_ops *ops)
> > >   {
> > >       struct thermal_zone_device_ops of_ops =3D *ops;
> > >       struct thermal_zone_device *tz;
> > > @@ -429,6 +430,7 @@ static struct thermal_zone_device *thermal_of_zon=
e_register(struct device_node *
> > >
> > >       return ERR_PTR(ret);
> > >   }
> > > +EXPORT_SYMBOL_GPL(thermal_of_zone_register);
> > >
> > >   static void devm_thermal_of_zone_release(struct device *dev, void *=
res)
> > >   {
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 69f9bedd0ee8..adbb4092a064 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -195,13 +195,23 @@ struct thermal_zone_params {
> > >
> > >   /* Function declarations */
> > >   #ifdef CONFIG_THERMAL_OF
> > > +struct thermal_zone_device *thermal_of_zone_register(struct device_n=
ode *sensor, int id, void *data,
> > > +                                                  const struct therm=
al_zone_device_ops *ops);
> > >   struct thermal_zone_device *devm_thermal_of_zone_register(struct de=
vice *dev, int id, void *data,
> > >                                                         const struct =
thermal_zone_device_ops *ops);
> > >
> > > +void thermal_of_zone_unregister(struct thermal_zone_device *tz);
> > >   void devm_thermal_of_zone_unregister(struct device *dev, struct the=
rmal_zone_device *tz);
> > >
> > >   #else
> > >
> > > +static inline
> > > +struct thermal_zone_device *thermal_of_zone_register(struct device_n=
ode *sensor, int id, void *data,
> > > +                                                  const struct therm=
al_zone_device_ops *ops)
> > > +{
> > > +     return ERR_PTR(-ENOTSUPP);
> > > +}
> > > +
> > >   static inline
> > >   struct thermal_zone_device *devm_thermal_of_zone_register(struct de=
vice *dev, int id, void *data,
> > >                                                         const struct =
thermal_zone_device_ops *ops)
> > > @@ -209,6 +219,10 @@ struct thermal_zone_device *devm_thermal_of_zone=
_register(struct device *dev, in
> > >       return ERR_PTR(-ENOTSUPP);
> > >   }
> > >
> > > +static inline void thermal_of_zone_unregister(struct thermal_zone_de=
vice *tz)
> > > +{
> > > +}
> > > +
> > >   static inline void devm_thermal_of_zone_unregister(struct device *d=
ev,
> > >                                                  struct thermal_zone_=
device *tz)
> > >   { =20
> >
> >
> > --
> > <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog =20
>=20


