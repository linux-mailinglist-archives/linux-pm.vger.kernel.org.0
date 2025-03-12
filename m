Return-Path: <linux-pm+bounces-23906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3BEA5D911
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 10:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A962C3A65C2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F62397BE;
	Wed, 12 Mar 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNkjDn2l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044F78F51;
	Wed, 12 Mar 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770953; cv=none; b=Wb/BBm5uNhpKc71bVhI5jkgqyaS9Z1WjjwYiFhsp3YRKfJfnw1+2puCZcbLYC3YKc4qMwUGr/P+f6bb+ueGykPQBB8UGMfgvdW0lyAUe640s5MVLDkfYwTAbASQXcoAiyfi/OE9pKxgf+/Ybt8p99LX+/lGMYzDbUtQlfzvSU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770953; c=relaxed/simple;
	bh=J7SVnfphE13eNn/jlvXmylH8Fs5GAsHcj180R4qjeYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcFmPjSSW+whdHNDQjX1o2ipQ5CCglm/ag9C9nl7GJLfCaWuL2J7kLnoJM26RQwmvPrXQo8yuvlvveCNWcCYbeAtNbMJGLJRXpoisPtULNpYAV6q/LmkBKWA3ulTNqPNbGt+YROSZYu7pkKatzedyhKE0+YRCwKpZaS+PJaGIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNkjDn2l; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390f5f48eafso3137790f8f.0;
        Wed, 12 Mar 2025 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741770950; x=1742375750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+Ynp9Lk3vtNpYTgOzF3jmTX4HieV5YXRXD817qkEag=;
        b=NNkjDn2lkl4hRCoWUEJClVQeaYVSGYaPNyw5EzEO0axJs2uR+EG5KnF21B3kX5mRs+
         hZd8vSGihQwfU+Edj8taK8EpspZRwGwmECHsRWIxvNaBLYIDrpW6INMi6nyJlvsGZSVJ
         YRY2eHzTfnM0jQW78ROm7XdBORmt9nrQA84q5zwlUJoujJULpY6LxbKrTdvMh1YmGSAo
         6VlDUbmZHsrIJhtnpY8ao41K1Uf5seQa0jEy1qQafOvB6I1hmNUcZSS4XrJwwpgDX5Xu
         rkNRf882YPkAT7tnjF7BZgjzmYBSQHYas92xvX5yf/f/eOgZjmTYiUT1169u5gYDWuNQ
         fb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741770950; x=1742375750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+Ynp9Lk3vtNpYTgOzF3jmTX4HieV5YXRXD817qkEag=;
        b=qPtXRON3De9qQHactp5mdwU639jyLm0JT2FpA6E8KJn/Lqv+D20uoquvRnVzhzcogZ
         7cC+iY2pZ+zJUgb+DxAQZ7pDyR5QptprikR1F0IXp+umVShDm7S+ZM8LTMXLFXHif8Kh
         s8W7MzTQaEIFsO4d5ZLrWBp+hlU10p90NNuMlwGHQuiPB/GuoYRHw5S1RUwsUEGnc2M8
         nfdQHy4Uyazr4UMMYJnAP8KeIV4O9f6RKsrqo0YzaODPoGW75i9ilEInwusVobBvQBbK
         2v22mNCiWOx7SpZdvnPaW3yCOTggzls1FmQ30XFoN7XQo4MjWxI98khShNs+YOf88jhJ
         3Otw==
X-Forwarded-Encrypted: i=1; AJvYcCVGgXvjn3p95UFP0oPyjFLf6FoXh5KHzSFR47onmwkmD7l4KuqrgjAPtXYxtIh8FQcTKntyGlJh8/xc@vger.kernel.org, AJvYcCWnBEctGf+vk8KTnhEyMTmOh9OmiRtt7BiTT2jaNcDpCSJLPneDmOdU8LBIwefnJtlNVUAAHCgYIAs=@vger.kernel.org, AJvYcCXYZDnGm0gMz3guklxsUGosmCUYx3SSSTng9EUyRadqZce4n9egcH1Bw6Vz6Lbcr+rlsv5OTL2zZhYR2L6D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EeM0LU0+0YsKYvHv8rT7242mvF8jY/SIv5krVjQmvoPRl6pD
	LzJFjVUx3+TRx09nPoadKJe4SL4ziCq+tsAAg6RUIiEv6tcsYwbA0z0iTb0nlKd6uZD3EUwTYl2
	iTkylB04GniS2Rf5MxNM17h6VGihiYfBo
X-Gm-Gg: ASbGnctJAe41O7vDcITPmJvcIUEtU4QsILI/+l7szzG5PTZtvsGQsrR2Sxppe73IR+l
	NdY4Kf6+Wqycvc5S3zvoAfbxVl10Yu5u1cSqi/x5hVjfSvoJeRfLuyDLhLicyOw0Rp0a4mZrg3w
	IbKU3O9QeC+qSZ+wPCYUI9YAXkXnQ=
X-Google-Smtp-Source: AGHT+IFXA2UUR+nQMWK3xJ5GflMfeO6cfGqyE/nmTqoQd3Jj2v0XgwnQJAagvZfS7KhzlLu0GWY+tZ6fy1RQlnid1Ls=
X-Received: by 2002:a05:6000:2ac:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-39132d78446mr15394778f8f.9.1741770949843; Wed, 12 Mar 2025
 02:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310080237.7400-1-clamor95@gmail.com> <20250310080237.7400-3-clamor95@gmail.com>
 <axqbrwdkkuztwrz67hke2nwqgz2ifpedpypas7nuohohzlzkt4@i4d2np6vclwb>
In-Reply-To: <axqbrwdkkuztwrz67hke2nwqgz2ifpedpypas7nuohohzlzkt4@i4d2np6vclwb>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Mar 2025 11:15:38 +0200
X-Gm-Features: AQ5f1Jo_rUmBq46bqm7v3lRPc9UKpKjAC1mRBRtaXRnuKYAkcvTlgzSOmuRUpr0
Message-ID: <CAPVz0n10HskS+khCm58F7UUPu6XcYRs69dQtLPOQqoQS9MEL0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] power: supply: Add support for Maxim MAX8971 charger
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:50 Seba=
stian Reichel
<sebastian.reichel@collabora.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> I have a couple of comments inline.
>
> On Mon, Mar 10, 2025 at 10:02:37AM +0200, Svyatoslav Ryhel wrote:
> > The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
> > charger for a one-cell lithium-ion (Li+) battery.
> >
...
> > +
> > +static int max8971_get_health(struct max8971_data *priv, int *val)
> > +{
> > +     u32 regval;
> > +     int err;
> > +
> > +     err =3D regmap_field_read(priv->rfield[THM_DTLS], &regval);
> > +     if (err)
> > +             return err;
> > +
> > +     switch (regval) {
> > +     case MAX8971_HEALTH_COLD:
> > +             *val =3D POWER_SUPPLY_HEALTH_COLD;
> > +             break;
> > +     case MAX8971_HEALTH_COOL:
> > +             *val =3D POWER_SUPPLY_HEALTH_COOL;
> > +             break;
> > +     case MAX8971_HEALTH_WARM:
> > +             *val =3D POWER_SUPPLY_HEALTH_GOOD;
> > +             break;
> > +     case MAX8971_HEALTH_HOT:
> > +             *val =3D POWER_SUPPLY_HEALTH_HOT;
> > +             break;
> > +     case MAX8971_HEALTH_OVERHEAT:
> > +             *val =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> > +             break;
> > +     case MAX8971_HEALTH_UNKNOWN:
> > +     default:
> > +             *val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> > +     }
>
> I guess it makes sense to report POWER_SUPPLY_HEALTH_DEAD
> for MAX8971_CHARGING_DEAD_BATTERY?
>

It seems that I have missed that, thank you for pointing.

> > +
> > +     return 0;
> > +}
> > +
...
> > +
> > +static DEVICE_ATTR_RW(fast_charge_timer);
> > +static DEVICE_ATTR_RW(top_off_threshold_current);
> > +static DEVICE_ATTR_RW(top_off_timer);
> > +
> > +static struct attribute *max8971_attributes[] =3D {
> > +     &dev_attr_fast_charge_timer.attr,
> > +     &dev_attr_top_off_threshold_current.attr,
> > +     &dev_attr_top_off_timer.attr,
> > +     NULL
> > +};
>
> Missing ABI documentation. Also wondering if we can instead just
> configure sensible values without exposing them to userspace. For
> debugging things there is always the regmap debugfs API.
>

These values are exposed like in the other maxim charger
(max77693_charger to be exact) so I inspired with that plus dt
maintainers were extremely against these in the tree.

Would be nice to have those configurable at least in some way, if not
by tree then by userspace. I assume ABI documentation should be a
separate patch.

> > +static const struct attribute_group max8971_attr_group =3D {
> > +     .attrs =3D max8971_attributes,
> > +};
> > +
...
> > +     err =3D devm_device_add_group(dev, &max8971_attr_group);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "failed to create sysfs at=
tributes\n");
>
> Iff we need the custom properties they should be at least registered
> automatically at device creation time via 'cfg.attr_grp'.
>

I actually did not know this was an option. Thanks for pointing out.

> > +     err =3D devm_request_threaded_irq(dev, client->irq, NULL, &max897=
1_interrupt,
> > +                                     IRQF_ONESHOT | IRQF_SHARED, clien=
t->name, priv);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "failed to register IRQ %d=
\n", client->irq);
> > +
> > +     /* Extcon support is not vital for the charger to work */
>
> The comment is a bit missleading, because the current code seems to
> make extcon support mandatory as far as I can tell.
>

Extcon is optional and charger interrupt will work fine without it,
but this charger can only detect the fact of plug event, not the type
of plug. So without extcon charging will always be done like from usb2
pc port (default mode). Hence I have added extcon support here (which
my device has and uses) to be able to set higher current if a
dedicated charger is connected.

> > +     connector =3D of_parse_phandle(dev->of_node, "maxim,usb-connector=
", 0);
> > +     extcon =3D of_get_parent(connector);
> > +     of_node_put(connector);
> > +
> > +     priv->edev =3D extcon_find_edev_by_node(extcon);
> > +     of_node_put(extcon);
> > +     if (IS_ERR(priv->edev))
> > +             return 0;
> > +
> > +     err =3D devm_delayed_work_autocancel(dev, &priv->extcon_work,
> > +                                        max8971_extcon_evt_worker);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "failed to add extcon evt =
stop action\n");
> > +
> > +     priv->extcon_nb.notifier_call =3D extcon_get_charger_type;
> > +
> > +     err =3D devm_extcon_register_notifier_all(dev, priv->edev, &priv-=
>extcon_nb);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "failed to register notifi=
er\n");
> > +
> > +     /* Initial configuration work with 1 sec delay */
> > +     schedule_delayed_work(&priv->extcon_work, msecs_to_jiffies(1000))=
;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused max8971_resume(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct max8971_data *priv =3D i2c_get_clientdata(client);
> > +
> > +     irq_wake_thread(client->irq, priv);
> > +
> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(max8971_pm_ops, NULL, max8971_resume);
> > +
> > +static const struct of_device_id max8971_match_ids[] =3D {
> > +     { .compatible =3D "maxim,max8971" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, max8971_match_ids);
> > +
> > +static const struct i2c_device_id max8971_i2c_id[] =3D {
> > +     { "max8971" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, max8971_i2c_id);
> > +
> > +static struct i2c_driver max8971_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "max8971-charger",
> > +             .of_match_table =3D max8971_match_ids,
> > +             .pm =3D &max8971_pm_ops,
> > +     },
> > +     .probe =3D max8971_probe,
> > +     .id_table =3D max8971_i2c_id,
> > +};
> > +module_i2c_driver(max8971_driver);
> > +
> > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("MAX8971 Charger Driver");
> > +MODULE_LICENSE("GPL");
>
> Otherwise LGTM.
>

Thank you for your suggestions, I will apply and test them.

> -- Sebastian

