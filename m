Return-Path: <linux-pm+bounces-38731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B7C8B175
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D68AC4E1427
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985B33A70E;
	Wed, 26 Nov 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EfyIyjXA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3330EF75
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176229; cv=none; b=GhN27Yx5aoiaCuNhU/faBefCM6tZdc4DJK3vDNBQbH6QqqIV4oEE/CCcRkjkNwyzWgROS3IV8sWF4RYp/WsgT3iBsyuvr+hKB7IO9h+MC3c4bywkgg9lkyq/EQHxzHTP0ZxJ9URB1tNLmv5OWyBNv3ZSoAv2YeVy1RkvU+KyGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176229; c=relaxed/simple;
	bh=gzXc2LlfH1NtGEWbEAMpuUzR+DbcGYaJo3ZDcCkFLDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pu6UEV+yDDBuhXbJN4fw+kLszJzn/baMG4rZZfOvNotQDFjrcv8kfALL1dHvEyp73zno7umI13QXu8iqqE/MfwBGbkmW7SYuFurh/1aEiLksuSAfzanDqYNfwTk9VmbG9rPSWZpLu9v7oh9k9UOV/QWM7h+aZnxtfcJhykq71bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EfyIyjXA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37ce27af365so170221fa.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764176226; x=1764781026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbqZxnCgIP/lZ7i202XMoKrrxmiILyqg/b2DVygoqY8=;
        b=EfyIyjXAGyxGbbCS+AoYcnknAAEptjCzxQnnPTZGJ+2ABg5VyVObYSwA3iVa+P2Tc/
         MeL+jxmEqxIMX1XNq3JBkEOm8cAF5MQcQL+0qH9hyn1omebjNAxdGqv/NSoqYQ5NtT4T
         91X7F+c7R28w0U/x5IqFOEubWu3QxcoWKcr1fWNqpUyZFT0ygMrb/6MPvnOy0RngjuHs
         tzrGuKl+kZ895rlMMfGlHumgpbuTkO5Tz1aZ1ImBQKGHlPTgbfyinKtzyuM27BpbXh1i
         6D+2jF2IJ+l0M3LQqeiXttHvqSZtk+ZAz2YS+ZUB5x6S1pcWIqVaFaePMSqOLhWSsnvO
         Xy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764176226; x=1764781026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbqZxnCgIP/lZ7i202XMoKrrxmiILyqg/b2DVygoqY8=;
        b=bpsAqn7soL0M+mwbWmc4Ly4OYS4nj3Lj9mi8pYFSBr0SBddQpHE24frS9Kog/7YkP5
         UsiG1mE0SMQkKrYaicnnu8UfuFNdXLdbfzDmRPTH0Py9v/I357ylQagmOAu4TpU+sFMd
         iP09rNurw7F5+gKP1Fro2syRMgLOR0BzQGD/ChKZQp0zuH75REGxMLEI6RqbSQFKjFlU
         9XVBX0SqNAAqrhTZ3tW77BCumoXJNxC+UtPYuT3wsBLJhv5GVtX6W+WxDv0kMXyWbxgU
         GhnQY6zMurtRK6OKruNrzKQZnH8cr/3rrMsTfL3zyhKcnf2gq//Z0znBb2/HO+Tot0Y8
         N92w==
X-Forwarded-Encrypted: i=1; AJvYcCXxEVAPw4mplFDqsRSbXzOVPlDT6hdTMZmj1TV0GGK2D9lO/dinSWEUjuSJ8ryA/8hDAcmpQDUHoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Svb0rwzNxjll0+9x4R/sOS9C8XyMg+fUa4M+kI4vhCIhauDQ
	7lUB4DRmmk0jhKChrd27upz190Qg/Np42E8nm4DFxO1DZpRWGCy59bLyNbzWLsxF2KZg0J6FCS+
	8KvKPr8LbRxAylJ/Gf2G7VI7tL7xX+XmgkU62E5muvg==
X-Gm-Gg: ASbGncv5PpmtPuMHJY4+W+7HGTB7z28nYAQzxRs+e6BcAkUeugzk/xO8xrTzNisa0yU
	7wAlMaqjNrX87DGWvf6T4YSBBqeMilRu54wBMQsPPXq9kHp4l0wT15kQM4DqOUxKQvkvwen9tNR
	f37yM4FjAyCK+qKPggzY/dVZmFB+BPImWMYGCaKvx7Ga3V/dMOsRUdMLQEO6swymqnUG2u/xo+E
	8jPQOOAop2kN+Z27ji5jwWUU7mkyE5ErFChzNtTXGGnqv8n9Kv5ncbAjEcCvC6J2ut1B2KPcOa9
	AuUpvQUPRP4PD2S7J06zo8sJKAs=
X-Google-Smtp-Source: AGHT+IErRUjhNVbLqzVjxbcK1CYjltVuZHOc5fzudcpc5EwVyEZJCC/Y6E/1dlEutCZjrPJdpyM7JVpvhPnzlPDcauA=
X-Received: by 2002:a05:651c:41c6:b0:37b:970f:d33b with SMTP id
 38308e7fff4ca-37cd9174e1dmr55217781fa.3.1764176226306; Wed, 26 Nov 2025
 08:57:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122-next-15nov_expose_sysfs-v19-0-4d3d578ad9ee@oss.qualcomm.com>
 <20251122-next-15nov_expose_sysfs-v19-2-4d3d578ad9ee@oss.qualcomm.com>
 <CAMRc=Me=F5gTmkfO+2_3_pqebsz9GvabCK+xv6bfQeGgkSs6Dw@mail.gmail.com> <dda61a49-90b1-ef48-5a46-d6953cd5375a@oss.qualcomm.com>
In-Reply-To: <dda61a49-90b1-ef48-5a46-d6953cd5375a@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Nov 2025 17:56:54 +0100
X-Gm-Features: AWmQ_bluuaTcAqYNWzEq9zAeQFhvKiBcRtbO_0icEBMpDgmmCEeuvtSQ9xCa_XI
Message-ID: <CAMRc=McgiuD1D+WqmO9x2G8devztrLy6uLwxjFpxJ+LbKx2YJg@mail.gmail.com>
Subject: Re: [PATCH v19 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:48=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> >>
> >> +static bool reboot_mode_class_registered;
> >
> > You don't need this, please see below.
>
> reboot_mode_class_registered was used for two reason.
> one is resolved: will directly call class_unregister.
>
> for second : If class_register fails, we want don't call register device
> in reboot_mode_register.
>
> at -
>         if (reboot_mode_class_registered)
>                 reboot_mode_register_device(reboot);
>

I'd just error out of the initcall if registering the class fails.
It's very unlikely anyway and points to a bigger problem.

> >> +
> >> +static void reboot_mode_register_device(struct reboot_mode_driver *re=
boot)
> >> +{
> >> +    reboot->reboot_mode_device.class =3D &reboot_mode_class;
> >> +    reboot->reboot_mode_device.release =3D reboot_mode_device_release=
;
> >> +    dev_set_name(&reboot->reboot_mode_device, reboot->driver_name);
> >> +    if (!device_register(&reboot->reboot_mode_device))
> >> +            reboot->reboot_mode_device_registered =3D true;
> >> +    else
> >> +            reboot->reboot_mode_device_registered =3D false;
> >
> > Just use device_create(). I would also suggest creating a private struc=
ture
> > that embeds the pointer to the struct device created by device_create()=
 and
> > the pointer to the reboot_mode_driver. If you pass it as driver data to
> > device_create(), you'll be able to retrieve it with dev_get_drvdata() i=
n
> > sysfs callbacks.
>
> Had made change to use device_create and dev_get_drvdata in below change,=
 and have then
> changed it to above as per the reviews on the same.
> https://lore.kernel.org/all/qhlxxfsyc42xemerhi36myvil3bf45isgmpugkuqzsvgc=
c3ifn@njrtwuooij2q/
>
> Should we change to device_create?
>

Ah, I missed that part. My preference is for device_create() as IMO it
results in much more elegant code (especially if we don't end up
extending the public struct) and memory is cheap but I'll let Bjorn
decide.

Bart

