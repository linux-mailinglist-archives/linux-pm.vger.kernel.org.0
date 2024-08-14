Return-Path: <linux-pm+bounces-12218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4C952151
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724F51C21019
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B441BC065;
	Wed, 14 Aug 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1lAQCGd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E303398B;
	Wed, 14 Aug 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656853; cv=none; b=M3ImXDarH4/4HTdiR+HKTTNzvJMXqIgDwBQml0fWknpzahTJLB64u0Cn1ve+uLdJOxm9IqfXDnI4wmVMNmNC62VAfF53whuvXEcVz1LdCM4jlfD5HJWwslJFSjYDf3eFe3pYLCdQNARjx+oVtYT0vw6pU9/fTCidtE/lcxZYaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656853; c=relaxed/simple;
	bh=fQ25DDdxzXuW/iNuiQQd9sq11uV6yC4w4ps48LKQQyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOUlwjtjH6QXggDYnkDe3EsJ1LyX+RmlGgcwSVAufHQt8VWb+eX2naM/wbBYtrFHJPOHpd+c7Ot21EztxOYSBIH+ARrbpN3h+ZA/wufwOI5M5s0UZXbGIh+r3h/pB3KviP6Y7URK96QWmdXy39QkCnWajQiHj7i445aKPNwjnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1lAQCGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F3FC4AF0D;
	Wed, 14 Aug 2024 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723656852;
	bh=fQ25DDdxzXuW/iNuiQQd9sq11uV6yC4w4ps48LKQQyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g1lAQCGdpQpVcIuhHfU5vU3KZJlWKPrfoXllM5Aa9dP75PPsa2x478Gc9x67J4lno
	 +DtWQ86a+RXwIQZMOBsKTwGLyGcN8it1/QDo7gepSLTSqNIapXneFlXZFBIbwrIKhv
	 w0Jzh+zhOPYEwneg3/d5rirXRDdVsm9ACpteoEZGKWY6CJlnnO/lSYMJUpbl7NVGsM
	 hOB0pCcciKeHVkUT7PeW5FLVfko7tmOyO3j10Aaona375wnkR2rQJ3DzVIV3ryLl1T
	 zP76AxzjC3+CqeNHNMK6lj4LcoNqUUEfbgECVIWfkiyc+/8vUvAmPz9zY8D+MUISNI
	 gKCGNjBFN+9+w==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7092f277242so4285a34.3;
        Wed, 14 Aug 2024 10:34:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmxh2wBffExbb99u5nDR3ExOlw9TN49kD3NewczOQYoaP67jM5S8QUwfnKhsju0eDtw1jPmm9jrjJ9h7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWTh5CTt4hT/ZG7q9hu9/ZX8pcQPpeXK1EBpas84tN7yRqFdA
	B1eeyMuqGSIwoXJYIBOz3faTXc9ioKtfkqdscgOef8ncLox1Fzz36xgerYdEqf5vzD+smRDBJkr
	L8AL6AH7FeT8RvM6Rue0TBwq/+9Y=
X-Google-Smtp-Source: AGHT+IHbnr0oFxfpfMtSjmICfH0Gl0AmarG4KF+rru3FK/scRaIOuflZR2a1SpgFpUGYIJpz7O54/7hvEu4IV6aWT14=
X-Received: by 2002:a05:6820:2c95:b0:5da:6c8a:daa4 with SMTP id
 006d021491bc7-5da8a1b052dmr107102eaf.0.1723656851747; Wed, 14 Aug 2024
 10:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1903691.tdWV9SEqCh@rjwysocki.net> <13583081.uLZWGnKmhe@rjwysocki.net>
 <28c4f62c7f4ae2a94c2bb36e82f9827332b8205f.camel@intel.com>
In-Reply-To: <28c4f62c7f4ae2a94c2bb36e82f9827332b8205f.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Aug 2024 19:34:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jaU=YY+A2qQYavh4iHbhYUAZy-ShZa+cKZ9V5B6Qdajw@mail.gmail.com>
Message-ID: <CAJZ5v0jaU=YY+A2qQYavh4iHbhYUAZy-ShZa+cKZ9V5B6Qdajw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] thermal: gov_bang_bang: Call __thermal_cdev_update()
 directly
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, 
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "peter@piie.net" <peter@piie.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:18=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Tue, 2024-08-13 at 16:25 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of clearing the "updated" flag for each cooling device
> > affected by the trip point crossing in bang_bang_control() and
> > walking all thermal instances to run thermal_cdev_update() for all
> > of the affected cooling devices, call __thermal_cdev_update()
> > directly for each of them.
>
> with this change, we may invoke thermal_cdev_set_cur_state() for
> multiple times instead of one, in one bang_bang_control() run.

No, this cannot happen AFAICS because one cooling device cannot be
bound to the same trip point more than once.

Since bang_bang_control() only checks thermal instances for one trip
point, all cooling devices pointed to by them are guaranteed to be
different.

> So this effectively changes the notifications and statistics.
>
> If this is not a problem, maybe better to mention this change in the
> changelog?
>
> thanks,
> rui
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/thermal/gov_bang_bang.c |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/gov_bang_bang.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> > +++ linux-pm/drivers/thermal/gov_bang_bang.c
> > @@ -71,12 +71,9 @@ static void bang_bang_control(struct the
> >                 dev_dbg(&instance->cdev->device, "target=3D%ld\n",
> > instance->target);
> >
> >                 mutex_lock(&instance->cdev->lock);
> > -               instance->cdev->updated =3D false; /* cdev needs update
> > */
> > +               __thermal_cdev_update(instance->cdev);
> >                 mutex_unlock(&instance->cdev->lock);
> >         }
> > -
> > -       list_for_each_entry(instance, &tz->thermal_instances,
> > tz_node)
> > -               thermal_cdev_update(instance->cdev);
> >  }
> >
> >  static struct thermal_governor thermal_gov_bang_bang =3D {
> >
> >
> >
>

