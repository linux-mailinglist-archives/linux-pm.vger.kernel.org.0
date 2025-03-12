Return-Path: <linux-pm+bounces-23918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5CA5DC96
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 13:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084B6189A03E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D89242902;
	Wed, 12 Mar 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNHqDjlL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533F24168E;
	Wed, 12 Mar 2025 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782499; cv=none; b=G8awYEPUj/B/zOiwgaYJE8L8n8ZnfEzipxeB5XY+Ur/xC8ty/1eccyCGsUnoQFWyQb95I7wo5IkK/0v57AYa6mSTS2qf5KenW4+VeQf1vxcov685kkhux75zv+7NpseYlBIKUUI/jbRCDR7UoJcQ6CJHrupFZwdqbDklUvVeueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782499; c=relaxed/simple;
	bh=ScMo6cxu9GAUKKMkRreSUwJHaKc/7+d2xJ+MUTi+tb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2Z1IDZuMW98EH0FXfJFtXKFGGh6CsnSEgZZgSXVm/Dg7YLdon/DhDFoQ5ATLE2gsQrNf0dMO5n7rTtW7spe9aQduWiXYicRwrLfofHh0yhoGkJ8qnW3yNUiSaneC56ro94ATmSg5pKoc1X8eAJL+e0ET4QjePk5mqY9KKjau/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNHqDjlL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so3285819f8f.2;
        Wed, 12 Mar 2025 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782495; x=1742387295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whTPFNzffZEytuTs/4Y0GBzNv+sq0yVAXgQvl7RTfWI=;
        b=QNHqDjlLDFnGguIxUklscWxzG00GLrD2SRNoskxHzNv+JcPEtn+sBNYmHmR6Zvz8jK
         l4BIyMEFofbuVfVImq88+Mnq+yNhhxC0mArlj1bZvLAgT+ud8Kt4d8S9rX9U2dnQI3D1
         +NEpy7gRH8mNMsBI7G+kpMZSezwcLkTBPlHyUBJDNcK5ZT1dtEbHRspQwLqunaXIVNNb
         +LSRgP9ZcVVUlFlMY/SzoUn2GXrDsmlX6e+TBxunjG9CedJmsTPv5XJZEE9eS/zhA2hs
         wsLPHGOlmcdBAfaKDVLVYBYo7Z1qQDRVQqzx6NuihK8kWKFWWW5nxsTQ+Xcds4LONSS4
         pxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782495; x=1742387295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whTPFNzffZEytuTs/4Y0GBzNv+sq0yVAXgQvl7RTfWI=;
        b=PSaJ9SZUwP49GfJo5onVs/dOGAFzueGRRn7NEouFdu/QS8HvHcGpblPGtuCNS833sa
         wyiVxIk9tlyHvNMwxGjkchqeYfa5+uL/+X6SIMBFWALA5JiJibk+tnRq+nN+HdNB+pT5
         sEGelWVI4vBfYKPxCk/+XtRJ9MZEbyA9QajBJK+ACa6wiM799DIlrs+77PJeZ+StdXhO
         1Cxyod9jBAo0FHlgAAgwGswAa6dukTs/5PmI+Hbh2BtyYJ9JLqGBmh+3CwvwyXJduXfO
         Iv0bA4JoSsTzesJ4Bwmy4+5D80JiIu0ctxlcaMnT80/b8QG5Ro1aWleTVa68HJqGHzaM
         5DGw==
X-Forwarded-Encrypted: i=1; AJvYcCU7y3k4dljHRjz7nfCpgk7ekLhqLd1ci3IYMvxCp+xng8xr7DfW38KSA/ODXaBZFKBjWH3N4a4G+ys9Mkh0@vger.kernel.org, AJvYcCVSHz5DFfGUykKpT1sJkDiVL1bdNRTMuJ9npQhA2de6ZNtsrekROa8xXD8w2A60pwpuSSueArqb/kO+@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9HVFbe+z8KxLQQRY016m7hik50OjKJ8/1/3NYa8694CnbPjc
	p4t3bLmcNE6sS6OyuPHFsQ33uu176k08Z1j/kK9AboQT7fq69CbWy9WjuzLIioZ6UUtMr/qWr7R
	GwB+rPkMOKY+qJ+9+u5rtqrFaRKjVILm7
X-Gm-Gg: ASbGnctXfLgdW60ZBJ+FmEAgwEYxhbe9BSg5XeSH2/0a3E5HjHyHmNLHqRnE3cbSFY1
	xs5xvQBMvcH1sD6+nDj8rZArXUp0UFS/waQFyESiHeeJBhA3fSteIQsRGtkjVHJrPzYx79e62TB
	Nqw7Y7pRSIvXzNwFI2oKjEM7gGF/8=
X-Google-Smtp-Source: AGHT+IG18Hd4qUNRFWk+M7OjaiZaUNfiMsN8okVKRXKKrQIS8pFMNuH8q+FXCe6V3qTKm6gehcD++eKjLYKejG6OcGI=
X-Received: by 2002:a5d:6d8c:0:b0:390:e48a:3869 with SMTP id
 ffacd0b85a97d-39132d774a1mr16118020f8f.11.1741782495248; Wed, 12 Mar 2025
 05:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310080237.7400-1-clamor95@gmail.com> <20250310080237.7400-3-clamor95@gmail.com>
 <axqbrwdkkuztwrz67hke2nwqgz2ifpedpypas7nuohohzlzkt4@i4d2np6vclwb> <CAPVz0n10HskS+khCm58F7UUPu6XcYRs69dQtLPOQqoQS9MEL0g@mail.gmail.com>
In-Reply-To: <CAPVz0n10HskS+khCm58F7UUPu6XcYRs69dQtLPOQqoQS9MEL0g@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Mar 2025 14:28:04 +0200
X-Gm-Features: AQ5f1JppyVER9nAeNBd5d3p10n8zIEqgWAW-Q6YKsv3G3qCC_v4Z1v7eH1W5yKc
Message-ID: <CAPVz0n1HG2qw6qgtEe0ok+9MVkzVhHkaO2vkoELwQAGpm-045w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] power: supply: Add support for Maxim MAX8971 charger
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:15 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=81=D1=80, 12 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:50 Se=
bastian Reichel
> <sebastian.reichel@collabora.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi,
> >
> > I have a couple of comments inline.
> >
> > On Mon, Mar 10, 2025 at 10:02:37AM +0200, Svyatoslav Ryhel wrote:
> > > The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
> > > charger for a one-cell lithium-ion (Li+) battery.
> > >
> ...
> > > +
> > > +static int max8971_get_health(struct max8971_data *priv, int *val)
> > > +{
> > > +     u32 regval;
> > > +     int err;
> > > +
> > > +     err =3D regmap_field_read(priv->rfield[THM_DTLS], &regval);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     switch (regval) {
> > > +     case MAX8971_HEALTH_COLD:
> > > +             *val =3D POWER_SUPPLY_HEALTH_COLD;
> > > +             break;
> > > +     case MAX8971_HEALTH_COOL:
> > > +             *val =3D POWER_SUPPLY_HEALTH_COOL;
> > > +             break;
> > > +     case MAX8971_HEALTH_WARM:
> > > +             *val =3D POWER_SUPPLY_HEALTH_GOOD;
> > > +             break;
> > > +     case MAX8971_HEALTH_HOT:
> > > +             *val =3D POWER_SUPPLY_HEALTH_HOT;
> > > +             break;
> > > +     case MAX8971_HEALTH_OVERHEAT:
> > > +             *val =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> > > +             break;
> > > +     case MAX8971_HEALTH_UNKNOWN:
> > > +     default:
> > > +             *val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> > > +     }
> >
> > I guess it makes sense to report POWER_SUPPLY_HEALTH_DEAD
> > for MAX8971_CHARGING_DEAD_BATTERY?
> >
>
> It seems that I have missed that, thank you for pointing.
>

MAX8971_CHARGING_DEAD_BATTERY is not same as POWER_SUPPLY_HEALTH_DEAD
so we cannot use MAX8971_CHARGING_DEAD_BATTERY here. DEAD_BATTERY in
charging context is state of deep discharge not the battery health
overall. max8971_get_health returns charger state, not battery.
Battery state is monitored by dedicated controller.

> > > +
> > > +     return 0;
> > > +}
> > > +
> ...
> > > +
> > > +static DEVICE_ATTR_RW(fast_charge_timer);
> > > +static DEVICE_ATTR_RW(top_off_threshold_current);
> > > +static DEVICE_ATTR_RW(top_off_timer);
> > > +
> > > +static struct attribute *max8971_attributes[] =3D {
> > > +     &dev_attr_fast_charge_timer.attr,
> > > +     &dev_attr_top_off_threshold_current.attr,
> > > +     &dev_attr_top_off_timer.attr,
> > > +     NULL
> > > +};
> >
> > Missing ABI documentation. Also wondering if we can instead just
> > configure sensible values without exposing them to userspace. For
> > debugging things there is always the regmap debugfs API.
> >
>
> These values are exposed like in the other maxim charger
> (max77693_charger to be exact) so I inspired with that plus dt
> maintainers were extremely against these in the tree.
>
> Would be nice to have those configurable at least in some way, if not
> by tree then by userspace. I assume ABI documentation should be a
> separate patch.
>
> > > +static const struct attribute_group max8971_attr_group =3D {
> > > +     .attrs =3D max8971_attributes,
> > > +};
> > > +
> ...
> > > +     err =3D devm_device_add_group(dev, &max8971_attr_group);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "failed to create sysfs =
attributes\n");
> >
> > Iff we need the custom properties they should be at least registered
> > automatically at device creation time via 'cfg.attr_grp'.
> >
>
> I actually did not know this was an option. Thanks for pointing out.
>
> > > +     err =3D devm_request_threaded_irq(dev, client->irq, NULL, &max8=
971_interrupt,
> > > +                                     IRQF_ONESHOT | IRQF_SHARED, cli=
ent->name, priv);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "failed to register IRQ =
%d\n", client->irq);
> > > +
> > > +     /* Extcon support is not vital for the charger to work */
> >
> > The comment is a bit missleading, because the current code seems to
> > make extcon support mandatory as far as I can tell.
> >
>
> Extcon is optional and charger interrupt will work fine without it,
> but this charger can only detect the fact of plug event, not the type
> of plug. So without extcon charging will always be done like from usb2
> pc port (default mode). Hence I have added extcon support here (which
> my device has and uses) to be able to set higher current if a
> dedicated charger is connected.
>
> > > +     connector =3D of_parse_phandle(dev->of_node, "maxim,usb-connect=
or", 0);
> > > +     extcon =3D of_get_parent(connector);
> > > +     of_node_put(connector);
> > > +
> > > +     priv->edev =3D extcon_find_edev_by_node(extcon);
> > > +     of_node_put(extcon);
> > > +     if (IS_ERR(priv->edev))
> > > +             return 0;
> > > +
> > > +     err =3D devm_delayed_work_autocancel(dev, &priv->extcon_work,
> > > +                                        max8971_extcon_evt_worker);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "failed to add extcon ev=
t stop action\n");
> > > +
> > > +     priv->extcon_nb.notifier_call =3D extcon_get_charger_type;
> > > +
> > > +     err =3D devm_extcon_register_notifier_all(dev, priv->edev, &pri=
v->extcon_nb);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "failed to register noti=
fier\n");
> > > +
> > > +     /* Initial configuration work with 1 sec delay */
> > > +     schedule_delayed_work(&priv->extcon_work, msecs_to_jiffies(1000=
));
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int __maybe_unused max8971_resume(struct device *dev)
> > > +{
> > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > +     struct max8971_data *priv =3D i2c_get_clientdata(client);
> > > +
> > > +     irq_wake_thread(client->irq, priv);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(max8971_pm_ops, NULL, max8971_resume);
> > > +
> > > +static const struct of_device_id max8971_match_ids[] =3D {
> > > +     { .compatible =3D "maxim,max8971" },
> > > +     { /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, max8971_match_ids);
> > > +
> > > +static const struct i2c_device_id max8971_i2c_id[] =3D {
> > > +     { "max8971" },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, max8971_i2c_id);
> > > +
> > > +static struct i2c_driver max8971_driver =3D {
> > > +     .driver =3D {
> > > +             .name =3D "max8971-charger",
> > > +             .of_match_table =3D max8971_match_ids,
> > > +             .pm =3D &max8971_pm_ops,
> > > +     },
> > > +     .probe =3D max8971_probe,
> > > +     .id_table =3D max8971_i2c_id,
> > > +};
> > > +module_i2c_driver(max8971_driver);
> > > +
> > > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > +MODULE_DESCRIPTION("MAX8971 Charger Driver");
> > > +MODULE_LICENSE("GPL");
> >
> > Otherwise LGTM.
> >
>
> Thank you for your suggestions, I will apply and test them.
>
> > -- Sebastian

