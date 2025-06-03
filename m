Return-Path: <linux-pm+bounces-27982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E911AACBDEE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 02:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF8D1889D57
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3F3FB1B;
	Tue,  3 Jun 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDfbh6B+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97C2AEF1
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748910240; cv=none; b=Yo67BT9bupJi4FE3D2v3uUlRHnpyd2Z7rwxFwjLyjr6L12C5JhG4o/XVyGYmM6EuDJN1Y2tIwECFMoaQSN6HnnLdvaJ5xBPsK0DEVPrQPcd3O6SYoj3v+xyiNwEt98KcqQPyjBEJtzv79jG2AB7csf6Xxq+bQgHaQkFRKdGYyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748910240; c=relaxed/simple;
	bh=AImNFqbk31yDcxGWtqtu6Ckfs89ZrwsGNsbwdSE3RCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJUrT1BpNNjdJ7WGs2myYdAUrXXSchNIPObKm/pL+YEtY6IgsKCAMvv1wPgpBFLxE/BUqQYkwweZWaEMPUrhW0q1VAdVdMvr7+k/8Nz+EPdGHaKhHFhvJ9YCQBHIzDd4Saa1FAialcv2ZWJezQbfnzbaw4U+H/SIx1XX1kY+spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDfbh6B+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso6438712e87.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748910236; x=1749515036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FOpMiYLMMX182EYvmPfUF40zpuQGKvY/VPcmu9Q4Ac=;
        b=aDfbh6B+hS3/5rFMeoefUXQaHJvv4vJVWXZWfCm427HmV2P/CU04T7v2mMkSrHTnOD
         PB+wgTzCSx1B2kFET9YviXZXmmzvqwne1DX8D5WhdNBVDoibeuOOeL2nduqn4Jm1YcGa
         MK5MZ4X9qfBDRdtigKL7aZVxhTI6Q3gIbj5j3iasgfdzqxrZHmTlgjW4oDb5xFaJfMnS
         VF7Wew6zWgT6/wI7NFJuPUHifeMO1aZwpQ6TyWBGaQNUokrdxoddAs8G6zdsX1pp54a5
         MZPPFgCfrymrDXCaEwAdh1itBBdQCfF2hP4MtfmqMM7dI/2Ps28YhW0mOG3yThmFSfyu
         jEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748910236; x=1749515036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FOpMiYLMMX182EYvmPfUF40zpuQGKvY/VPcmu9Q4Ac=;
        b=K3nA0U+keasnS3rTelnog19VndzCnR7peMIt2QGvXJ7tBGuH6t9R97gLcubJcwwTWJ
         YMMyCQ94RurxMwBWmOJP8b+JoUFveX45ZpeqSrXEH2bwRE1eRtC0C1KHJAQxxukM0RJn
         ryuxl2X3dJhR/oYItUCxFXY2k1p0KCU5BbRw/yShfXKRaoicbbaQ8jzYLiesIQnUW5o8
         p0v7Jt/EodG/77l1IDQarCwuSXkhi+/5CGb0bpBS9kyUCjCqt2cOTCsBIyS+wsIRHLDG
         FRPDH65JXUE6vIT/ORaCH+oQT0GHCFp0nM7nZnkWaiw9DmawmH8rEot2Hubfokq1PGL6
         LRkw==
X-Forwarded-Encrypted: i=1; AJvYcCUSA+Cvzo5olXyhr+0+e8G36ygoGgPxqyQ9auzwCxWTMNlimHGZBFTd06y/2W1OcAFuJUkSH0WNfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jW7tvV0eDEn549kt8JYZM6m8F7Vs0e0zIYIxqi0Hdk8FSx5U
	DEUsen/eRhL4DO0j8rpz7f10a/5xH0DTeJr1Y66/EtxZIAyqfdj/iUy81aGf0XTRTPufMHbjAG7
	faAYU0mChtmTErAFgOuAcCpXgAC/0LvHmyf6PHbwJ
X-Gm-Gg: ASbGncvMXb4MKYwwMm7bT/zeXkvhO0m83tC2LlZ7MI9j+6gqnnzWeMDHuFcA618ibAf
	iarQDYqfRfNI4o+O7vK5cW5Y9fZqBNuwL6TJXz2Gs3rK2qRN3GsPdVjsJAv2Q5MCWjvZjt7oxNE
	wiTzHoLjB5kxlhXr/0wwDQd5/ofLkdfD8QYZ3YjLMElkOXwcxwrBwa8dzz3Ouccl/Xqh2SRN6US
	T1v1XFhNGnChs8=
X-Google-Smtp-Source: AGHT+IF0eNhrWbj9hQxfD1unRyrkdD0kp+Z0yS9s1IOEtVghOX4coHO+O1yKo9y4gO22c3TpyInE02NwNDsomxX6gBM=
X-Received: by 2002:a05:6512:b86:b0:553:291f:92e with SMTP id
 2adb3069b0e04-5533b92e470mr4356320e87.39.1748910235984; Mon, 02 Jun 2025
 17:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org> <20250523134025.75130-3-ulf.hansson@linaro.org>
In-Reply-To: <20250523134025.75130-3-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 2 Jun 2025 17:23:19 -0700
X-Gm-Features: AX0GCFs2XcbroxtBQgFIVghV_VdooKR0d1OXApi_zYrHQREB3E38JByH61YRbu0
Message-ID: <CAGETcx-hsKb_BDPLuSM3A_ac0x6Z4NOq2pCmjKKJHTYbYZPwcA@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] pmdomain: core: Add a bus and a driver for genpd providers
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:40=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> When we create a genpd via pm_genpd_init() we are initializing a
> corresponding struct device for it, but we don't add the device to any
> bus_type. It has not really been needed as the device is used as cookie t=
o
> help us manage OPP tables.
>
> However, to prepare to make better use of the device let's add a new genp=
d
> provider bus_type and a corresponding genpd provider driver. Subsequent
> changes will make use of this.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/core.c | 89 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 9a66b728fbbf..da515350c65b 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -27,6 +27,11 @@
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>
> +/* The parent for genpd_provider devices. */
> +static struct device genpd_provider_bus =3D {
> +       .init_name =3D "genpd_provider",
> +};
> +
>  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
> @@ -44,6 +49,14 @@ static DEFINE_IDA(genpd_ida);
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
>
> +#define to_genpd_provider_drv(d) container_of(d, struct genpd_provider_d=
rv, drv)
> +
> +struct genpd_provider_drv {
> +       struct device_driver drv;
> +       int (*probe)(struct device *dev);
> +       void (*remove)(struct device *dev);
> +};
> +
>  struct genpd_lock_ops {
>         void (*lock)(struct generic_pm_domain *genpd);
>         void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
> @@ -2225,6 +2238,26 @@ static int genpd_set_default_power_state(struct ge=
neric_pm_domain *genpd)
>         return 0;
>  }
>
> +static int genpd_provider_bus_probe(struct device *dev)
> +{
> +       struct genpd_provider_drv *drv =3D to_genpd_provider_drv(dev->dri=
ver);
> +
> +       return drv->probe(dev);
> +}
> +
> +static void genpd_provider_bus_remove(struct device *dev)
> +{
> +       struct genpd_provider_drv *drv =3D to_genpd_provider_drv(dev->dri=
ver);
> +
> +       drv->remove(dev);
> +}

Not sure if I'm missing some corner case you found out, but you don't
need these stubs just to call the drv ops. Driver core does it anyway
if the bus probe/remove functions are missing.

> +
> +static const struct bus_type genpd_provider_bus_type =3D {
> +       .name           =3D "genpd_provider",
> +       .probe          =3D genpd_provider_bus_probe,
> +       .remove         =3D genpd_provider_bus_remove,
> +};
> +
>  static void genpd_provider_release(struct device *dev)
>  {
>         /* nothing to be done here */
> @@ -2262,6 +2295,8 @@ static int genpd_alloc_data(struct generic_pm_domai=
n *genpd)
>         genpd->gd =3D gd;
>         device_initialize(&genpd->dev);
>         genpd->dev.release =3D genpd_provider_release;
> +       genpd->dev.bus =3D &genpd_provider_bus_type;
> +       genpd->dev.parent =3D &genpd_provider_bus;
>
>         if (!genpd_is_dev_name_fw(genpd)) {
>                 dev_set_name(&genpd->dev, "%s", genpd->name);
> @@ -3355,9 +3390,61 @@ int of_genpd_parse_idle_states(struct device_node =
*dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +static int genpd_provider_probe(struct device *dev)
> +{
> +       return 0;
> +}
> +
> +static void genpd_provider_remove(struct device *dev)
> +{
> +}

Same might apply here.

-Saravana

> +
> +static void genpd_provider_sync_state(struct device *dev)
> +{
> +}
> +
> +static struct genpd_provider_drv genpd_provider_drv =3D {
> +       .drv =3D {
> +               .name =3D "genpd_provider",
> +               .bus =3D &genpd_provider_bus_type,
> +               .sync_state =3D genpd_provider_sync_state,
> +               .suppress_bind_attrs =3D true,
> +       },
> +       .probe =3D genpd_provider_probe,
> +       .remove =3D genpd_provider_remove,
> +};
> +
>  static int __init genpd_bus_init(void)
>  {
> -       return bus_register(&genpd_bus_type);
> +       int ret;
> +
> +       ret =3D device_register(&genpd_provider_bus);
> +       if (ret) {
> +               put_device(&genpd_provider_bus);
> +               return ret;
> +       }
> +
> +       ret =3D bus_register(&genpd_provider_bus_type);
> +       if (ret)
> +               goto err_dev;
> +
> +       ret =3D bus_register(&genpd_bus_type);
> +       if (ret)
> +               goto err_prov_bus;
> +
> +       ret =3D driver_register(&genpd_provider_drv.drv);
> +       if (ret)
> +               goto err_bus;
> +
> +       return 0;
> +
> +err_bus:
> +       bus_unregister(&genpd_bus_type);
> +err_prov_bus:
> +       bus_unregister(&genpd_provider_bus_type);
> +err_dev:
> +       device_unregister(&genpd_provider_bus);
> +       return ret;
>  }
>  core_initcall(genpd_bus_init);
>
> --
> 2.43.0
>

