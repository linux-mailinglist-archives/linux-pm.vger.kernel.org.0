Return-Path: <linux-pm+bounces-5467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803888D83E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 09:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF631C2638C
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751954AED2;
	Wed, 27 Mar 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G++MOIjP"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518C47F5C
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526284; cv=none; b=IWdipVnAM8s4AZmJDqW2qhqBTNZNZzm/6cx09Smid8Bt3rQ9d4jtendfZjTBGS4LvTd8LRFQGWclnx6lpHorsnfbTus55CwgTQlQVbdd4tYbuObjLEs/ip/qJrI9JIcE3mzdajvcHjPVV7krMYzOuw/PreecwsmPsAsFEnNqf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526284; c=relaxed/simple;
	bh=+jMhjERTTtRLM0KWZ1Ds1bG7HJxMTKBPNk0QcjknlfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtHR46ehV2dplvjqUeCRvhZE1YxHDy7qxH1AZaVThBwoT/hr4f9Fi0c4oLUGigby0rX1ptFrpv1Kv5vIl3+nOOeaGvVZXBrUR3J+l3aP1rjLp2tHVPC66EeSY1/L3iinaqVzkaHrfgbQIftwupKCiY2DeGNz1gRgJwyC/Ii2WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G++MOIjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711526282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvCZIXlyJ0i9W5y1NVajdFVbSmQI+ddDaK6Um2GHqYw=;
	b=G++MOIjPBHsMtmR+pyOBfnSJnp2pVeMn0+s3/qs+vj0ZHsEN0a+EEyUFTyTH2mj0pKMp77
	T+jGl0RX4OMlEkWihmnuRVwTN86KLNHcIE7RhSv42LHTMtJuLqJooylbTOLmO+v+Y0AHOd
	4L8ZRCjOvfxIijYHT3/TgaSLlbOzPhk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-tCv1HkHzMB-jK6XvCrBAcA-1; Wed, 27 Mar 2024 03:57:59 -0400
X-MC-Unique: tCv1HkHzMB-jK6XvCrBAcA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e6a7798bfdso3068654b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 00:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526279; x=1712131079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvCZIXlyJ0i9W5y1NVajdFVbSmQI+ddDaK6Um2GHqYw=;
        b=THMXRJ3QspFEgE82f0buIcGoEvRGMKKV72OFt7vIYcmSICDP4S5fn9IpVws/Sm9yVF
         JDNkg0i78/fYT6FP/G9zmGVBdli74JGjIxr386lxYIkpfS1RmCKR/bKpuy8fLd9TTwL2
         WFGUekPVtoXbc1BDGaU6QbhtxXCNAxm6FmXbMO76OWQtHziQOd0XkCgDnIhipX+6zCX5
         MqrZ0fk8l9KY+yNPHJJT1dsNsG1tKOyCZNYgMPvsESPtivV1INo8OPyAysvrZskZn+a/
         SNWKHlmoIxkAxZVaR9eZ2XjIOFw+0BCsgF8KYBXBC77FN3+PS/qvg/nE7sBY5KVYMjx/
         woGA==
X-Forwarded-Encrypted: i=1; AJvYcCVv/gbT+D7gP6L2rMvezpJjUuxgX86wHWoCXuQp5ZTqBcU9zqHRZqIOV5yBMWD65APrCejfsiWW/kzg/QTfYH1SDzTYLtENyc4=
X-Gm-Message-State: AOJu0YysoVZ17Qa0H+sqIM0J6ZCss0E/zPTGmLUjlR5zI9NW6HXz62/I
	q3D7BcG37VQLza3gH8P07+CaJk5+7m2g0jx9KB2AzpyHeftDwLg2w/6jQaRodFZn0mkh54QNfM9
	SeT3mLavYkzETS7cki/8qVMN/Y1Rpse1/IMIwF0oXDMrMUmwiJHu1bYIadID8Hw4a+3fBDvkzT6
	2XAos1F+K9NZfoNME5E5okOq6dFB0LnPg=
X-Received: by 2002:a05:6a21:78a1:b0:1a3:5440:520 with SMTP id bf33-20020a056a2178a100b001a354400520mr2261629pzc.1.1711526278845;
        Wed, 27 Mar 2024 00:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Q9fuG8yTs+ELOSdaWHYwqpSczYEeTI5UtBaHspHNLcfSZRVndgU5mB3Z2zq0Hcih2Q+cX9I9biaM+ykuO08=
X-Received: by 2002:a05:6a21:78a1:b0:1a3:5440:520 with SMTP id
 bf33-20020a056a2178a100b001a354400520mr2261613pzc.1.1711526278530; Wed, 27
 Mar 2024 00:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-2-hpa@redhat.com>
 <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
In-Reply-To: <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Wed, 27 Mar 2024 15:57:47 +0800
Message-ID: <CAEth8oG7_qFuUrL+kX3ezNatWqKPqT-qiaO5NGY-N3F3ufQL9w@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 1/6] platform: x86-android-tablets: other: Add
 swnode for Xiaomi pad2 indicator LED
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for reviewing it.

On Mon, Mar 25, 2024 at 3:30=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > There is a KTD2026 LED controller to manage the indicator LED for Xiaom=
i
> > pad2. The ACPI for it is not properly made so the kernel can't get
> > a correct description of it.
> >
> > This work add a description for this RGB LED controller and also set a
>
> adds
> sets
>
> > trigger to indicate the chaging event (bq27520-0-charging). When it is
>
> charging
>
> > charging, the indicator LED will be turn on.
>
> turned
>
> ...
>
> > +/* main fwnode for ktd2026 */
> > +static const struct software_node ktd2026_node =3D {
> > +       .name =3D "ktd2026"
>
> Leave a comma, this is not a terminator.
>
> > +};
>
> When I asked about the name I relied on the fact that you have an idea
> how it works. So, assuming my understanding is correct, this platform
> may not have more than a single LED of this type. Dunno if we need a
> comment about this.

I'll make a comment to describe the configuration.
This LED controller can be configured to an RGB LED like this. Also,
it can be configured as three single-color (RGB) LEDs to show red,
green, and blue only.
I think the name can be "ktd2026-multi-color". Is it good for you?


>
> ...
>
> > +static int __init xiaomi_mipad2_init(void)
> > +{
> > +       return software_node_register_node_group(ktd2026_node_group);
> > +}
> > +
> > +static void xiaomi_mipad2_exit(void)
>
> __exit ?
No need.
x86-andriod-tablet is based on platform_driver and platform_device so
it doesn't need __exit.

I put __exit and the compiler complained about the warning.
=3D=3D=3D
WARNING: modpost:
drivers/platform/x86/x86-android-tablets/x86-android-tablets: section
mismatch in reference: xiaomi_mipad2_info+0x50 (section: .init.rodata)
-> xiaomi_mipad2_exit (section: .exit.text)
=3D=3D=3D
>
> > +{
> > +       software_node_unregister_node_group(ktd2026_node_group);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>

I'll propose the v6 patch to fix them according to your comments.

--
BR,
Kate


