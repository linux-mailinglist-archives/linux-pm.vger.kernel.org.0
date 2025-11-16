Return-Path: <linux-pm+bounces-38090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2809C613BE
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 12:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD6704E5CA8
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C422BD035;
	Sun, 16 Nov 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8+tP7k2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpODfykt"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36522756A
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293276; cv=none; b=tEWd6vnBSd0n6Dxtd/jlf8gddDwYpCFVUU0axbGdoFlPLrnYxDiBxuFCr1oJT0mOU7L8Mvu1/2E0JuxjpDE5GPD2Zw670K7kEZ+LhHZ/ECTj0IF0S9bguxb27UvwLN4khsL+w+lGt2nCKt+M4WXK8Rl4Ua3hvzicDs/zOin/3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293276; c=relaxed/simple;
	bh=dztS8ZITpfRexBgTDPAFBRUtjmHYPm7XXnxJOCZYL5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW6lLAV7JsI37woZsgvasy1pLs1dHpe0Ybc7WbVocWMfPP/PkAb/TqbRKcKuQz+fyXNszwgAY5LlBKwHGAb15zvGiDGqsugS8hsKzsSxAKbvpYMgO3DRp4Zdw7ZrfxXqQ+HM+uAKQ0HL5ppCoJF5LEMubHcS5bBFNXJNXNO+RWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8+tP7k2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpODfykt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763293272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRsv2NgYCJFeldUxTz05FhsASHZ2GxNbrz+Y660AFCo=;
	b=T8+tP7k29evaHIwY4/riN7Ity+YVzvLI+mujwM7/wvynainKKiBP8UTLPZsHN2XnzW4hwe
	I/7vxw25v5tw8W+/Rm/HZDxkFAt0VmkyuPOggu21Jo9rBKYW7aq6S4AEphLAhiNwanuIPR
	Th3WlKDzi2jpj2JkRu+NPrak1mc2VXE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-9QiKySC-P1WWKdshcEcZaA-1; Sun, 16 Nov 2025 06:41:10 -0500
X-MC-Unique: 9QiKySC-P1WWKdshcEcZaA-1
X-Mimecast-MFC-AGG-ID: 9QiKySC-P1WWKdshcEcZaA_1763293270
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2ad29140so1524345f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763293269; x=1763898069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRsv2NgYCJFeldUxTz05FhsASHZ2GxNbrz+Y660AFCo=;
        b=dpODfyktJ00/hDcd8OmvDpxIi6DPZn5DbRkd/cgiwjBObACJL4LieKDmgF+OZ3CT1G
         +t66TnyvRv5dwk3wXEoeIlkCKwDZxhI4Xb39xDTKYLEL3MEViy5A7jrdHmhJkXVAdyjy
         pb3bP7gC8jOp5MxAnyDqihopEi0cZpsh1fCXlfiXygopl7PxNLXN8IIHAXtm1OLV0uKc
         rkn7Xa/6a1P4Dh5NQ/rcYMB9cyZEieybNlpEboK9w+hbtL6zPOZHBj6KI8YZ+zg4XJXE
         dsrD/g8v42QowqZDqu1E3PzAQEc2N2zx9rRwGE1FdKtFVA2esgts1bSUBBa6UNFBFn7d
         JvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763293269; x=1763898069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRsv2NgYCJFeldUxTz05FhsASHZ2GxNbrz+Y660AFCo=;
        b=e0iFn658JIA/Asr2mYH7CWgVr9V/s65x5CqULvNETM+JAhz3MQb7dgOw/bz+9UIO8K
         wYFr21cA7t/BPz6ZrKkkmfsgS6bimWEAIv9vTW99LRARWMAlOGYdqcoBcUSdi1v2Advl
         BfYHAvDSPKQrtnqoAMNdXf4x+xMsUAtcLszZsl7F69+Nhc3587XUcJusI/vRPkeSwAHG
         eja4yOHZbovPrAa4EP6F7QeloDbwjXVavs86LaVaScri75/FMcKufDCtsKKCMNUuqzOP
         jVl15uKQv5vE+98USbBSafcsNXYaoToh6/I74XFm7r/gnYV4ijyg2rPOtimbhQC0aqdJ
         QlZw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7DIfgi0Jwx6CE5ziur9unWxTRpgTdXAaj6XmE9F8ftzX1WuYzgdyVYH8iId+H2vK1vUFsxuLtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG6EtyA0jcOOpGS1LjSxSGigDxnr/IjfP+y58FLJ5392lst9e
	uCVR5BZUk5BqIWA+bzNw9KpOWZmBwSMPx1likQ+SME2czzitREN9kbzwnMO/Dd0pNRsrzlY8mrm
	JE5t45W7spPt+dBHdw+phluFm35gqGxFkDLO0Oy0ilcq1Ju3ZRlJ/wRMRcO+oePEBULE1w7AI3z
	vSBPc83lbvUpWJJVYf9L+y1pNse4tOZMTbf2vQucn5CZY=
X-Gm-Gg: ASbGncs3yMyXMUgmzB0wvnD0kvAcx6HFLC3fY13bppenX2gnnDBjbyBzmtnBry34CWr
	do9ivSkygTRX5rnlJ/F43LFII0SlMx9r7GoQv4XbbFRW7uoW3gEHg8WY4xpOxUmD9VrrxOywXEj
	1pYPF9cavdZAlehUNSfVZiu81lB8dqaiJzUoQ6LdYm96qXrwfHx922j3K3QAGTwjSjf6sjtbiTa
	MAhwiqx2+gEkMYWAWZv/l+AMch+
X-Received: by 2002:a05:6000:430e:b0:42b:39d0:6386 with SMTP id ffacd0b85a97d-42b5936796fmr7426316f8f.31.1763293269417;
        Sun, 16 Nov 2025 03:41:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMJsK/Mu81AW8RrOxMycoMigYCm1vvFEAtIVBD6SN7Gjc5Gpbt0B7e0gEepqHga1HMserLegirqZqVXgSLTMo=
X-Received: by 2002:a05:6000:430e:b0:42b:39d0:6386 with SMTP id
 ffacd0b85a97d-42b5936796fmr7426302f8f.31.1763293269015; Sun, 16 Nov 2025
 03:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113001508.713574-1-lzampier@redhat.com> <20251113001508.713574-3-lzampier@redhat.com>
 <jil4fvsfddgdj46yjy5rzw7zg6xlb2u2pgzlpkn2bte6du2ht6@5plrpdaf4u7w>
In-Reply-To: <jil4fvsfddgdj46yjy5rzw7zg6xlb2u2pgzlpkn2bte6du2ht6@5plrpdaf4u7w>
From: Lucas Zampieri <lzampier@redhat.com>
Date: Sun, 16 Nov 2025 11:40:58 +0000
X-Gm-Features: AWmQ_bkuyR1DZZLukvJgvD9V6rdqtxs5NK_nCcGLLPt9oEJsegGD7q6xmoBQgTs
Message-ID: <CAOOg__DqNTZpWV96ozgd=RJdUd+JkUDfeMfoa54mgnb1pb27Wg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] HID: input: Refactor battery code to use
 struct hid_battery
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:54=E2=80=AFAM Benjamin Tissoires <bentiss@kernel=
.org> wrote:
>
> On Nov 13 2025, Lucas Zampieri wrote:
> > Refactor the battery handling code to use the newly introduced
> > struct hid_battery internally, replacing direct access to individual
> > power_supply and state fields.
> >
> > The legacy dev->battery and dev->battery_* fields are maintained and
> > synchronized for backward compatibility. This refactoring prepares
> > the code for supporting multiple batteries per device in a subsequent
> > patch.
> >
> > Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> > ---
> >  drivers/hid/hid-input.c | 125 ++++++++++++++++++++++++++--------------
> >  1 file changed, 83 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index e56e7de53279..0e71efea9da3 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -454,7 +454,8 @@ static int hidinput_get_battery_property(struct pow=
er_supply *psy,
> >                                        enum power_supply_property prop,
> >                                        union power_supply_propval *val)
> >  {
> > -     struct hid_device *dev =3D power_supply_get_drvdata(psy);
> > +     struct hid_battery *bat =3D power_supply_get_drvdata(psy);
> > +     struct hid_device *dev =3D bat->dev;
> >       int value;
> >       int ret =3D 0;
> >
> > @@ -465,13 +466,13 @@ static int hidinput_get_battery_property(struct p=
ower_supply *psy,
> >               break;
> >
> >       case POWER_SUPPLY_PROP_CAPACITY:
> > -             if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
> > -                 !dev->battery_avoid_query) {
> > +             if (bat->status !=3D HID_BATTERY_REPORTED &&
> > +                 !bat->avoid_query) {
> >                       value =3D hidinput_query_battery_capacity(dev);
> >                       if (value < 0)
> >                               return value;
> >               } else  {
> > -                     value =3D dev->battery_capacity;
> > +                     value =3D bat->capacity;
> >               }
> >
> >               val->intval =3D value;
> > @@ -482,20 +483,20 @@ static int hidinput_get_battery_property(struct p=
ower_supply *psy,
> >               break;
> >
> >       case POWER_SUPPLY_PROP_STATUS:
> > -             if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
> > -                 !dev->battery_avoid_query) {
> > +             if (bat->status !=3D HID_BATTERY_REPORTED &&
> > +                 !bat->avoid_query) {
> >                       value =3D hidinput_query_battery_capacity(dev);
> >                       if (value < 0)
> >                               return value;
> >
> > -                     dev->battery_capacity =3D value;
> > -                     dev->battery_status =3D HID_BATTERY_QUERIED;
> > +                     bat->capacity =3D value;
> > +                     bat->status =3D HID_BATTERY_QUERIED;
> >               }
> >
> > -             if (dev->battery_status =3D=3D HID_BATTERY_UNKNOWN)
> > +             if (bat->status =3D=3D HID_BATTERY_UNKNOWN)
> >                       val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> >               else
> > -                     val->intval =3D dev->battery_charge_status;
> > +                     val->intval =3D bat->charge_status;
> >               break;
> >
> >       case POWER_SUPPLY_PROP_SCOPE:
> > @@ -513,8 +514,9 @@ static int hidinput_get_battery_property(struct pow=
er_supply *psy,
> >  static int hidinput_setup_battery(struct hid_device *dev, unsigned rep=
ort_type,
> >                                 struct hid_field *field, bool is_percen=
tage)
> >  {
> > +     struct hid_battery *bat;
> >       struct power_supply_desc *psy_desc;
> > -     struct power_supply_config psy_cfg =3D { .drv_data =3D dev, };
> > +     struct power_supply_config psy_cfg;
> >       unsigned quirks;
> >       s32 min, max;
> >       int error;
> > @@ -530,16 +532,22 @@ static int hidinput_setup_battery(struct hid_devi=
ce *dev, unsigned report_type,
> >       if (quirks & HID_BATTERY_QUIRK_IGNORE)
> >               return 0;
> >
> > -     psy_desc =3D kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> > -     if (!psy_desc)
> > +     bat =3D kzalloc(sizeof(*bat), GFP_KERNEL);
> > +     if (!bat)
> >               return -ENOMEM;
> >
> > +     psy_desc =3D kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> > +     if (!psy_desc) {
> > +             error =3D -ENOMEM;
> > +             goto err_free_bat;
> > +     }
> > +
> >       psy_desc->name =3D kasprintf(GFP_KERNEL, "hid-%s-battery",
> >                                  strlen(dev->uniq) ?
> >                                       dev->uniq : dev_name(&dev->dev));
> >       if (!psy_desc->name) {
> >               error =3D -ENOMEM;
> > -             goto err_free_mem;
> > +             goto err_free_desc;
>
> I wonder if a devm conversion of the whole battery support handling
> would not be beneficial here.
>
I'll give it a try and see how it looks.

> >       }
> >
> >       psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> > @@ -559,63 +567,85 @@ static int hidinput_setup_battery(struct hid_devi=
ce *dev, unsigned report_type,
> >       if (quirks & HID_BATTERY_QUIRK_FEATURE)
> >               report_type =3D HID_FEATURE_REPORT;
> >
> > -     dev->battery_min =3D min;
> > -     dev->battery_max =3D max;
> > -     dev->battery_report_type =3D report_type;
> > -     dev->battery_report_id =3D field->report->id;
> > -     dev->battery_charge_status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +     /* Initialize battery structure */
> > +     bat->dev =3D dev;
> > +     bat->min =3D min;
> > +     bat->max =3D max;
> > +     bat->report_type =3D report_type;
> > +     bat->report_id =3D field->report->id;
> > +     bat->charge_status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +     bat->status =3D HID_BATTERY_UNKNOWN;
> >
> >       /*
> >        * Stylus is normally not connected to the device and thus we
> >        * can't query the device and get meaningful battery strength.
> >        * We have to wait for the device to report it on its own.
> >        */
> > -     dev->battery_avoid_query =3D report_type =3D=3D HID_INPUT_REPORT =
&&
> > -                                field->physical =3D=3D HID_DG_STYLUS;
> > +     bat->avoid_query =3D report_type =3D=3D HID_INPUT_REPORT &&
> > +                        field->physical =3D=3D HID_DG_STYLUS;
> >
> >       if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
> > -             dev->battery_avoid_query =3D true;
> > +             bat->avoid_query =3D true;
> >
> > -     dev->battery =3D power_supply_register(&dev->dev, psy_desc, &psy_=
cfg);
> > -     if (IS_ERR(dev->battery)) {
> > -             error =3D PTR_ERR(dev->battery);
> > +     psy_cfg.drv_data =3D bat;
> > +     bat->ps =3D power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> > +     if (IS_ERR(bat->ps)) {
> > +             error =3D PTR_ERR(bat->ps);
> >               hid_warn(dev, "can't register power supply: %d\n", error)=
;
> >               goto err_free_name;
> >       }
> >
> > -     power_supply_powers(dev->battery, &dev->dev);
> > +     power_supply_powers(bat->ps, &dev->dev);
> > +
> > +     /* Maintain legacy single battery fields for backward compatibili=
ty */
> > +     dev->battery =3D bat->ps;
> > +     dev->battery_min =3D bat->min;
> > +     dev->battery_max =3D bat->max;
> > +     dev->battery_report_type =3D bat->report_type;
> > +     dev->battery_report_id =3D bat->report_id;
> > +     dev->battery_charge_status =3D bat->charge_status;
> > +     dev->battery_status =3D bat->status;
> > +     dev->battery_avoid_query =3D bat->avoid_query;
>
> Already mentioned in the cover letter, but what's the point of keeping
> those legacy fields when the exact same data is stored in bat?
>
Yep, now that I know that is better to have cohereand-API instead of
maintaining backwards compatiliby to a single battery structure that
was only internal, I'll update those as well.

> > +
> >       return 0;
> >
> >  err_free_name:
> >       kfree(psy_desc->name);
> > -err_free_mem:
> > +err_free_desc:
> >       kfree(psy_desc);
> > -     dev->battery =3D NULL;
> > +err_free_bat:
> > +     kfree(bat);
> >       return error;
> >  }
> >
> >  static void hidinput_cleanup_battery(struct hid_device *dev)
> >  {
> > +     struct hid_battery *bat;
> >       const struct power_supply_desc *psy_desc;
> >
> >       if (!dev->battery)
> >               return;
> >
> > +     bat =3D power_supply_get_drvdata(dev->battery);
> >       psy_desc =3D dev->battery->desc;
> >       power_supply_unregister(dev->battery);
> >       kfree(psy_desc->name);
> >       kfree(psy_desc);
> > +     kfree(bat);
> >       dev->battery =3D NULL;
> >  }
> >
> > -static bool hidinput_update_battery_charge_status(struct hid_device *d=
ev,
> > +static bool hidinput_update_battery_charge_status(struct hid_battery *=
bat,
> >                                                 unsigned int usage, int=
 value)
> >  {
> >       switch (usage) {
> >       case HID_BAT_CHARGING:
> > -             dev->battery_charge_status =3D value ?
> > -                                          POWER_SUPPLY_STATUS_CHARGING=
 :
> > -                                          POWER_SUPPLY_STATUS_DISCHARG=
ING;
> > +             bat->charge_status =3D value ?
> > +                                  POWER_SUPPLY_STATUS_CHARGING :
> > +                                  POWER_SUPPLY_STATUS_DISCHARGING;
> > +             /* Update legacy field for backward compatibility */
> > +             if (bat->dev->battery =3D=3D bat->ps)
> > +                     bat->dev->battery_charge_status =3D bat->charge_s=
tatus;
> >               return true;
> >       }
> >
> > @@ -625,32 +655,43 @@ static bool hidinput_update_battery_charge_status=
(struct hid_device *dev,
> >  static void hidinput_update_battery(struct hid_device *dev, unsigned i=
nt usage,
> >                                   int value)
> >  {
> > +     struct hid_battery *bat;
> >       int capacity;
> >
> >       if (!dev->battery)
> >               return;
> >
> > -     if (hidinput_update_battery_charge_status(dev, usage, value)) {
> > -             power_supply_changed(dev->battery);
> > +     bat =3D power_supply_get_drvdata(dev->battery);
> > +
> > +     if (hidinput_update_battery_charge_status(bat, usage, value)) {
> > +             power_supply_changed(bat->ps);
> >               return;
> >       }
> >
> >       if ((usage & HID_USAGE_PAGE) =3D=3D HID_UP_DIGITIZER && value =3D=
=3D 0)
> >               return;
> >
> > -     if (value < dev->battery_min || value > dev->battery_max)
> > +     if (value < bat->min || value > bat->max)
> >               return;
> >
> >       capacity =3D hidinput_scale_battery_capacity(dev, value);
> >
> > -     if (dev->battery_status !=3D HID_BATTERY_REPORTED ||
> > -         capacity !=3D dev->battery_capacity ||
> > -         ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time))=
 {
> > -             dev->battery_capacity =3D capacity;
> > -             dev->battery_status =3D HID_BATTERY_REPORTED;
> > -             dev->battery_ratelimit_time =3D
> > +     if (bat->status !=3D HID_BATTERY_REPORTED ||
> > +         capacity !=3D bat->capacity ||
> > +         ktime_after(ktime_get_coarse(), bat->ratelimit_time)) {
> > +             bat->capacity =3D capacity;
> > +             bat->status =3D HID_BATTERY_REPORTED;
> > +             bat->ratelimit_time =3D
> >                       ktime_add_ms(ktime_get_coarse(), 30 * 1000);
> > -             power_supply_changed(dev->battery);
> > +
> > +             /* Update legacy fields for backward compatibility */
> > +             if (dev->battery =3D=3D bat->ps) {
> > +                     dev->battery_capacity =3D bat->capacity;
> > +                     dev->battery_status =3D bat->status;
> > +                     dev->battery_ratelimit_time =3D bat->ratelimit_ti=
me;
> > +             }
> > +
> > +             power_supply_changed(bat->ps);
> >       }
> >  }
> >  #else  /* !CONFIG_HID_BATTERY_STRENGTH */
> > --
> > 2.51.1
> >
>
> Cheers,
> Benjamin
>

Best,
Lucas Zampieri


