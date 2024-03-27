Return-Path: <linux-pm+bounces-5466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF16788D6D8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 07:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6938D2A3721
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE8249ED;
	Wed, 27 Mar 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMYdglGB"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58121A06
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522423; cv=none; b=sHiB1OFWMHOf8ZEAl5Jte2AGSHUMm9sJP/nWOcc75j+XUy+nVtjUag4Zyer+BYTt4YNJdQFmC4FXAzHTwNb1a3bLWUPNXjBPZQIYmvTj7s7dfa0/fs6cQUhMLI5RiRO6yjz7iYJhuxaBRI4D1jCDDinueLuTGscCa4bs1fJsTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522423; c=relaxed/simple;
	bh=W6RLXUxCHDJY3w70KCqWzO6oGutZMiRq4O8XdSmVm20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbJOrzzM6h/qEAvdFRw7mc8gy62HQoj/6a3O/fwFjQT2rZPmMtdOEJlcv2tBQTzp3ZLNthnti134wcTdFCXn6Wtneh5whL5R091VCoxZyyvMuyHM1ggOpMcXN5rEl0lJig4c2qEA6sX3NhIoRRtEZCOWlFdXrNhIBS79nOJN6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMYdglGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711522420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjyCvIB6syQyBLc/PURAesFgBPIAm7ixXYus2PqXUv8=;
	b=DMYdglGBptN5vBmIR3K0QnAMT99IlnNae/yg1KWDZyIDAco9sgAFvzmN9mOmEsBbmKn9lK
	KwyxM5gZJqzSV36esmIE0ZJkdmhs/K6hQmAt72Tx8CLTxMnTSCOUOLXPhTSR10npYVKqnq
	9uzfHKJgmLr6byFJRA0U7NWmRJBeHPw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-POXK3OLPPOq5AAIFT1MgfA-1; Wed, 27 Mar 2024 02:53:37 -0400
X-MC-Unique: POXK3OLPPOq5AAIFT1MgfA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so4954066a12.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 23:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711522416; x=1712127216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjyCvIB6syQyBLc/PURAesFgBPIAm7ixXYus2PqXUv8=;
        b=KSrFijG43wg/+ThbQiPrN+QUHkVEYv/PuEpjUTnzUG9n9QuT2vdeY/oMGpKgjojWcj
         aeCoBIgkkw3ct7FwABMrnKY0ImMg1nCEXZIbxcuXaIAG/zJn9lD62rZHv7fCzQDURh4t
         L5DmF+pgcUFi1liH8vzK7qFUDUpx3jh9Bt8tcsO0K5bQfbGIp8NX9nbJOryqaZoQhALG
         xt+2vpsG3ls+5nxG9dhKb3TbTVe3lB5KVVlIOGgfsAXQs425E8Jvt93cZUdKOhTq2iVU
         PH3jeTUQ8NuRLoIyA7zY//tlkpWeeWUYoVcWjMENVdDXeVvGDltP4liLvO83qsyTqshU
         YDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpH4ty7fPiMx3EI+N2t/udMkaf5zIGqAJGoxDu/UTRYhDMYd+BS7uFraK5XL/GaOFKO/LaSUDRayHxPgZHRMUvfM4e4KjwT7Q=
X-Gm-Message-State: AOJu0YxZFzH+AAR/IgpSmeX7C/e0oa97ggpiYMFW/7LR9lFrQJ1207Hh
	oIDtRXz7AVt9Ly072iyg18fXOsAjc8vri3cx1+Pd/fEq5LKokxWw4FvVA9lx8bF2S/5YWAal1mA
	Z1riXkXC4muRoMYZQe7hB+K8AzRzaEBo7HK8xIZibZZ86TnPsAcKSHX/r56yZgE39EsWTVQzA1K
	wrmpE/0TilskpwdR4LCva9BBEmpzE6JSw=
X-Received: by 2002:a05:6a21:339c:b0:1a3:8904:1fc9 with SMTP id yy28-20020a056a21339c00b001a389041fc9mr3637952pzb.41.1711522416608;
        Tue, 26 Mar 2024 23:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE92cxDxgpu4LIAd0jfCXzzTSPP16EKFP9ZwNdIoRwWxtFgYT4c5S27JpSdRV4WKq/fyTzRxyP70R1xOrLebfs=
X-Received: by 2002:a05:6a21:339c:b0:1a3:8904:1fc9 with SMTP id
 yy28-20020a056a21339c00b001a389041fc9mr3637931pzb.41.1711522416229; Tue, 26
 Mar 2024 23:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-3-hpa@redhat.com>
 <CAHp75VdosbYNKU90QWt+6SU_i5dWC94=xZy0GXiKvoQeDF30wg@mail.gmail.com>
In-Reply-To: <CAHp75VdosbYNKU90QWt+6SU_i5dWC94=xZy0GXiKvoQeDF30wg@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Wed, 27 Mar 2024 14:53:24 +0800
Message-ID: <CAEth8oFuPTRq0z-YbMMFt=kKgre6x+bDhtpUkj2vJeK-u8O72A@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 2/6] leds: rgb: leds-ktd202x: Get device
 properties through fwnode to support ACPI
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

On Mon, Mar 25, 2024 at 3:57=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > This LED controller also installed on a Xiaomi pad2 and it is a x86
> > platform. The original driver is based on device tree and can't be
>
> the device
>
> > used for this ACPI based system. This patch migrated the driver to
> > use fwnode to access the properties. Moreover, the fwnode API
> > supports device tree so this work won't effect the original
>
> affect
>
> > implementations.
>
> ...
>
> > +       fwnode_for_each_available_child_node(fwnode, child) {
> > +               num_channels++;
> > +       }
>
> {} are not needed.
>
> >         if (!num_channels || num_channels > chip->num_leds)
> >                 return -EINVAL;
>
> ...
>
> > +static int ktd202x_add_led(struct ktd202x *chip,
> > +                          struct fwnode_handle *fwnode_color,
>
> Can it be simply fwnode? (Originally it was np, so I assume there is
> no name collision)
It can be. I'll revise this.

>
> ...
>
> > +       count =3D device_get_child_node_count(dev);
> >         if (!count || count > chip->num_leds)
> >                 return -EINVAL;
>
> > +       fwnode =3D dev_fwnode(chip->dev);
>
> Why not dev?
I'll use dev. I had declared it.

>
> > +       if (!fwnode)
> > +               return -ENODEV;
>
> This is dead code. Please remove these three lines.

Okay.

>
> ...
>
> > +       .id_table =3D ktd202x_id,
>
> Seems to me that you may split the I=C2=B2C ID table addition into a sepa=
rate change.

Could you please describe this more clearly? Thank you

>
> --
> With Best Regards,
> Andy Shevchenko
>

I'll propose the v6 patch according to your comments.


--=20
BR,
Kate


