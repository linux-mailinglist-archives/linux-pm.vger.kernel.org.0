Return-Path: <linux-pm+bounces-6617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA458A93F5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 09:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641D31F21505
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E2757E7;
	Thu, 18 Apr 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ree+GNpx"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD16A342
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424999; cv=none; b=CEQoIsdGRyZtlzQwSrr2uqmlaDbE6AHma4QAel+tZSuw48sV4ZN77VsiIOA3A+kCkdilBtSK/ZF9mkf30INu6Yb6Cb3f3w69xrfQWdM5lWvORaauAxLCorDCBrwCi9vAYCtXEI/QETNWb7ktaXbofcRVwPGuNkTMjBgVh/AfGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424999; c=relaxed/simple;
	bh=vgK0r6JlkgRyVng0vK7xeA2Mb4CDysk3xJwerY7ubwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR5TD7+gCq2egvCNTCYEllcQeeOeaSyoDymoxuBMaUc484stj3SEtc6w7rpoq90Ry4RwAmBYndureeezZeBO4ePkHJTrdJtby8QyPaxNTCKPYPcaHRc5BcpZ5FA6DlH6S7Q8P0j1eFsw5MEzwHP9CFsN550Pmg09iKRsChRF3bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ree+GNpx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713424996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVEgCUNH2+ucbxNW8o7LrLo4xbai7FQO2lfQoIgrFHE=;
	b=Ree+GNpxlyYuGul+c4N6gWpXRgFw2d8tO7MYqo+LVEI7KtNcrT3U/1vzDGTPynZNMWEYD/
	fo+/a5BngRis8xvs2ipRW+bu23HA9EdZY4XFsKH2IB5TNvRykc/R1Syy7LXpb2BAwfmxJu
	CXCRcg5s2wbqLUMEuDaWq7HpUXvpnpA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-UbRL2cZePaGWpSV5R-thdA-1; Thu, 18 Apr 2024 03:23:11 -0400
X-MC-Unique: UbRL2cZePaGWpSV5R-thdA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a300d6a299so776148a91.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 00:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424990; x=1714029790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVEgCUNH2+ucbxNW8o7LrLo4xbai7FQO2lfQoIgrFHE=;
        b=ojk4/SGXT5nIZWAAOIicgMNg0/lKElAPGefkjwW7OLsEQ2yTG7Cathtr2MM1VICf19
         E+oNvFXwPxCP7gBh51C7M6HtuThZ19UCFx5gVcdxOxYo0YgvTq2TCZKQGNBz1ODgnGLX
         ZNunGjDRr8Ov2KcCbaCi6MsL2zVQ+1udJ83EySl0yBNqsFxkxfqedXEnv7SWUKGIsUi4
         4xjCEXI5vWw9Nki3jTFchLqUxlhlfaxIzgVhEhkodVgD7m10Xt/VRbHz0vPgNWLG560M
         sFnWQd2G1RILbION8cnnM7Rn58kUsu7cAKCkyei9YkN3UNPgbaKWlCPeJCfb+z7JLlSH
         6xpw==
X-Forwarded-Encrypted: i=1; AJvYcCVbpBsWYF6HnDZPz1wQgWX9Eqjvf3GTL6xLZCBwWYdv23pV+nklFEaF3T6IrX9fFlvAAMfUlD+WyMPOmpGmPRaFXWa0wdfDH70=
X-Gm-Message-State: AOJu0Ywye12VetzhhgEyi5k207oAaNm1Lr2I3ZRkvBQ9FeqQMSM2lRn1
	/3+gbEJrTg74REA34WWe0sjycgjB+66GE1U5e4rSLhNR90RunUOoB+kXEQhXnV2DJtdhKfZtD4+
	wlBfvJxVPEXTvAgGqTMt/LtVf5rOJLnzQ+/iU9ypzSgRLZMwQGyQMBaJPmK+8/m/CdlNM8tH0uB
	5jsrUDVY+7CLgKomeI1msgJRmnMOG98FM=
X-Received: by 2002:a05:6a21:999b:b0:1aa:66ad:6094 with SMTP id ve27-20020a056a21999b00b001aa66ad6094mr2646449pzb.8.1713424990632;
        Thu, 18 Apr 2024 00:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb6KDSdMbWA5pEE2/RfPBEDrTWyeMJrakgp6Dj7adISR0wr3x3K1kxRaRUXVxLHPRcarcIGEu4VMy3oL4mikE=
X-Received: by 2002:a05:6a21:999b:b0:1aa:66ad:6094 with SMTP id
 ve27-20020a056a21999b00b001aa66ad6094mr2646428pzb.8.1713424990300; Thu, 18
 Apr 2024 00:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-1-hpa@redhat.com> <20240416053909.256319-3-hpa@redhat.com>
 <CAHp75Vdw6gCN=45iRdKcm=qT07Z90+z6Cw=inYR+C6+5gML+_Q@mail.gmail.com>
In-Reply-To: <CAHp75Vdw6gCN=45iRdKcm=qT07Z90+z6Cw=inYR+C6+5gML+_Q@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Thu, 18 Apr 2024 15:22:59 +0800
Message-ID: <CAEth8oHx66Q8esGNNgXnOOT2RJXTFMAo3RJPLHDYh9oewxJKxQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for reviewing.

On Wed, Apr 17, 2024 at 1:29=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:39=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > This LED controller is installed on a Xiaomi pad2 and it is an x86
> > platform. The original driver is based on the device tree and can't be
> > used for this ACPI based system. This patch migrated the driver to use
> > fwnode to access the properties. Moreover, the fwnode API supports the
> > device tree so this work won't affect the original implementations.
>
> ...
>
> > -       int num_channels;
> > +       int num_channels =3D 0;
>
> Split this assignment, so...
>
> >         int i =3D 0;
>
> > -       num_channels =3D of_get_available_child_count(np);
>
> ...it become
>
>   num_channels =3D 0;
>
> here.
>
> > +       fwnode_for_each_available_child_node(fwnode, child)
> > +               num_channels++;
>

It will look like this:
       num_channels =3D 0;
       fwnode_for_each_available_child_node(fwnode, child)
              num_channels++;

> ...
>
> > -static int ktd202x_add_led(struct ktd202x *chip, struct device_node *n=
p, unsigned int index)
> > +static int ktd202x_add_led(struct ktd202x *chip,
> > +                          struct fwnode_handle *fwnode,
> > +                          unsigned int index)
>
> Why split over 3 lines? I believe it can be still two or one
> (depending if you use a relaxed limit).

Make it to be one line.

>
> ...
>
> >  static int ktd202x_probe_dt(struct ktd202x *chip)
>
> Perhaps you want to rename this to something like ktd202x_probe_fw().

Sounds good.

>
> ...
>
> > +       fwnode =3D dev_fwnode(dev);
>
> Will be no use if the bellow applied, right?

Right. It can be dropped.

>
> ...
>
> > -       for_each_available_child_of_node(np, child) {
> > +       fwnode_for_each_available_child_node(fwnode, child) {
>
> Use device_for_each_child_node() instead.

Okay.

>
> >         }
>
> ...
>
> > -       .shutdown =3D ktd202x_shutdown,
> > +       .shutdown =3D ktd202x_shutdown
>
> Stray change.

I know the reason  :)

>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


