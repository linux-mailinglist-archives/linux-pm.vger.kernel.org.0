Return-Path: <linux-pm+bounces-25676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8DA92EC8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 02:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12E81891531
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A77E442C;
	Fri, 18 Apr 2025 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULXSGko9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBED125B9
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935847; cv=none; b=pDEBjor1DjDCXY0IBF9htypt5KkJZrVBW2Pj7TS0u1WwjtCLrEeyMual0ablK/QxvqTsQZj3l3RmdICCYDkD7sHMrnR9NErTUohJZR3ImeNkirUtA+icRwsjkgRduukDnO4F1R+HMNC3cwDuq9VpbXzMSnGYmPnUMAilC1dIOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935847; c=relaxed/simple;
	bh=M9fFLiC5l4KskgwTXQx/QeyA0NKn8rkzih7r0oX2aDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk2edvfzafgD1MYztYQgi9sg3Z5E9laVtvLy+u7Uj9XCDfPj4WAi1qEa8SnyXU3kgKc5TJn4u03f9oOa/l52w7FWObnx6/KXwVCklauv3B2lCHRzAm0VwDFsR1ULyhqhqzGxVV69TEw5q67+eoaJREiY2mKTvvB4YFHInDiASS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULXSGko9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so1639690e87.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744935844; x=1745540644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxdkJLhGcvUSmWPi/UwEe1UXm3/QVMd4knaXbpwDxqg=;
        b=ULXSGko9Squ+v5BSSC+CnKUkfixxhlQWDyImOqRVa4TzuFW6dxe0Bjw29mJ4wAr+JV
         oWOr01iWqvbIbZ9RRGQgUIKDnZw0qG51OjbWCj74DlpeRertYqy1qYicc38rcMpq4S5g
         TGjqkA1o3ZuIPoTFwRo5SwiZ3uQwOjKrf9JMbPMuMq6DYKp90WF50NQSuZ/KY2saGM5m
         D7q/DS/Eatf6Ry08ilLJ/s1pW0gBJYBz1KR211/2gUUJxzA0/1WW/ZAZHpthU06WCPTn
         dfXWSeFvyTgbG9zOWGGTn+ch9vJjSgw48dpSlpmmn2MwHEHk/rigYrnwkYLUNxrMjzOL
         XofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744935844; x=1745540644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxdkJLhGcvUSmWPi/UwEe1UXm3/QVMd4knaXbpwDxqg=;
        b=dSqQm6db64b4xXwRCOTA5Ng78xd3Yx9U8t6JDQXE23b/MAKicpDWUt8CZPjtXJXWv1
         sVK1DE8KUyYYBBQOQGsIvZ9eE15BPZ9Bs/OiBMITIJQxKeooAW0g1N+r7IG/vmiCcYjK
         usHz8ErUvuomsdF16gJRxkWYiLwrQqULCFgLJlqE6hbLQTy1vnhSgDZF+cfYx0w96CkM
         gfCR9gZCX6T0gse5vXBLYggweDSEAZl0Q0k+EXRhV3LFueq69BzObqqOqloxe0w6zFKI
         ByQckXfW6TQ2FJ+bfku9aupZgdANhGgBO+3KhA8sPoq1b74MYRIynsqrAzg3ginDApvo
         0y4w==
X-Forwarded-Encrypted: i=1; AJvYcCUZgi7fcgFpyf6Nbs4S0U5V6QslsEhVW7Bnsofk5d3plZxnq0eQK6i3kwsrU3vlCqXQd1zL5K3/Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxME1chdUi6LI7zh4PWSVNCY8yxu1UyKMRN32S501CGq2n8nUNs
	IJks8BYp9nldr5D7cg8zgG+whriILkvy9hk0oAy1bBszUmffr+OYjYD3IIEqh2wbRhWjibWBFgN
	XWGF5i1ZvwOleKAgqF+LLCCMYOUkn4Gb2yVtm
X-Gm-Gg: ASbGncutuzj4vvYbuww0sc8R1GtbHXjswgJDpooJjyoK9yGBdWXRg6P/0uDZDV1hWiA
	RQqqLaxqnfRz57pFtMNyBMLfo7DUBKpGqBcWelSOIFWvj/RBCLFOa8Bug6N7lllakFHHoEWS9im
	l45E2MZ3S6wkn/mBovHOKFXWD1Je0kOQnbksvh4mrgONVwZos=
X-Google-Smtp-Source: AGHT+IHbH8IHfW1jco323IJ3I8ek87dCWx6djDQi1gr/CrsHWGERJ1m1etCKkq3catleN2NzR1ZFUNRCRNXLMeqhzx0=
X-Received: by 2002:a05:6512:3b93:b0:54d:6dd3:614c with SMTP id
 2adb3069b0e04-54d6e62a372mr244799e87.14.1744935843910; Thu, 17 Apr 2025
 17:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org> <20250417142513.312939-9-ulf.hansson@linaro.org>
In-Reply-To: <20250417142513.312939-9-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 17 Apr 2025 17:23:27 -0700
X-Gm-Features: ATxdqUG-wMFcs_RvfIR7wkSnVzQWMhX9qiYF5MQ0YXxTofWgLSd9q6dkFbXM67w
Message-ID: <CAGETcx9rvTWPbDCnTLb+ToVk8BMipTa1Y14vpn=bPBkM=CjoZg@mail.gmail.com>
Subject: Re: [PATCH 08/11] pmdomain: core: Add internal ->sync_state() support
 for genpd providers
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 7:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> If the genpd provider's fwnode doesn't have an associated struct device
> with it, we can make use of the generic genpd->dev and it corresponding
> driver internally in genpd to manage ->sync_state().
>
> More precisely, while adding a genpd OF provider let's check if the fwnod=
e
> has a device and if not, make the preparation to handle ->sync_state()
> internally through the genpd_provider_driver and the genpd_provider_bus.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/core.c   | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  7 +++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 512f89e6d302..9c5a77bf59d2 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2374,6 +2374,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>         atomic_set(&genpd->sd_count, 0);
>         genpd->status =3D is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> +       genpd->sync_state =3D GENPD_SYNC_STATE_OFF;
>         genpd->device_count =3D 0;
>         genpd->provider =3D NULL;
>         genpd->device_id =3D -ENXIO;
> @@ -2656,6 +2657,7 @@ int of_genpd_add_provider_simple(struct device_node=
 *np,
>                                  struct generic_pm_domain *genpd)
>  {
>         struct fwnode_handle *fwnode;
> +       struct device *dev;
>         int ret;
>
>         if (!np || !genpd)
> @@ -2665,6 +2667,10 @@ int of_genpd_add_provider_simple(struct device_nod=
e *np,
>                 return -EINVAL;
>
>         fwnode =3D &np->fwnode;
> +       dev =3D fwnode->dev;
> +
> +       if (!dev)
> +               genpd->sync_state =3D GENPD_SYNC_STATE_SIMPLE;

I don't want people directly poking into fwnode.

Use get_device_from_fwnode() that's in drivers/base/core.c? Might need
to move it to a header. Make sure to put_device() it back.

Or ideally, figure it out using some other means like looking for
#power-domain-cells number? (if that'll always give the right answer).
Point being, the framework should know which type it's registering
even if there was no fwnode/fw_devlink.

>
>         device_set_node(&genpd->dev, fwnode);
>
> @@ -2718,8 +2724,10 @@ int of_genpd_add_provider_onecell(struct device_no=
de *np,
>  {
>         struct generic_pm_domain *genpd;
>         struct fwnode_handle *fwnode;
> +       struct device *dev;
>         unsigned int i;
>         int ret =3D -EINVAL;
> +       bool sync_state =3D false;
>
>         if (!np || !data)
>                 return -EINVAL;
> @@ -2728,6 +2736,10 @@ int of_genpd_add_provider_onecell(struct device_no=
de *np,
>                 data->xlate =3D genpd_xlate_onecell;
>
>         fwnode =3D &np->fwnode;
> +       dev =3D fwnode->dev;

Can you do this some other way please? I really don't like this look up.

-Saravana

> +
> +       if (!dev)
> +               sync_state =3D true;
>
>         for (i =3D 0; i < data->num_domains; i++) {
>                 genpd =3D data->domains[i];
> @@ -2737,6 +2749,11 @@ int of_genpd_add_provider_onecell(struct device_no=
de *np,
>                 if (!genpd_present(genpd))
>                         goto error;
>
> +               if (sync_state) {
> +                       genpd->sync_state =3D GENPD_SYNC_STATE_ONECELL;
> +                       sync_state =3D false;
> +               }
> +
>                 device_set_node(&genpd->dev, fwnode);
>
>                 ret =3D device_add(&genpd->dev);
> @@ -3453,6 +3470,25 @@ static void genpd_provider_remove(struct device *d=
ev)
>
>  static void genpd_provider_sync_state(struct device *dev)
>  {
> +       struct generic_pm_domain *genpd =3D container_of(dev, struct gene=
ric_pm_domain, dev);
> +
> +       switch (genpd->sync_state) {
> +       case GENPD_SYNC_STATE_OFF:
> +               break;
> +
> +       case GENPD_SYNC_STATE_ONECELL:
> +               of_genpd_sync_state(dev);
> +               break;
> +
> +       case GENPD_SYNC_STATE_SIMPLE:
> +               genpd_lock(genpd);
> +               genpd_power_off(genpd, false, 0);
> +               genpd_unlock(genpd);
> +               break;
> +
> +       default:
> +               break;
> +       }
>  }
>
>  static struct genpd_provider_drv genpd_provider_drv =3D {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index e9a1f8975c4f..2185ee9e4f7c 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -127,6 +127,12 @@ enum genpd_notication {
>         GENPD_NOTIFY_ON,
>  };
>
> +enum genpd_sync_state {
> +       GENPD_SYNC_STATE_OFF =3D 0,
> +       GENPD_SYNC_STATE_SIMPLE,
> +       GENPD_SYNC_STATE_ONECELL,
> +};
> +
>  struct dev_power_governor {
>         bool (*power_down_ok)(struct dev_pm_domain *domain);
>         bool (*suspend_ok)(struct device *dev);
> @@ -187,6 +193,7 @@ struct generic_pm_domain {
>         unsigned int performance_state; /* Aggregated max performance sta=
te */
>         cpumask_var_t cpus;             /* A cpumask of the attached CPUs=
 */
>         bool synced_poweroff;           /* A consumer needs a synced powe=
roff */
> +       enum genpd_sync_state sync_state; /* How sync_state is managed. *=
/
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
>         struct raw_notifier_head power_notifiers; /* Power on/off notifie=
rs */
> --
> 2.43.0
>

