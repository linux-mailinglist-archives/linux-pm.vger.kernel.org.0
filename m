Return-Path: <linux-pm+bounces-4548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54986C6E4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 11:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D23DB2836F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377BF64CD4;
	Thu, 29 Feb 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ard+GFlR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9A657B7
	for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202515; cv=none; b=GmlJORiqD2ho2Gy/4koXrHZ0Fn3s3+WqICGv1eprHyv+5FnKJyMA7yfKnhbJBAwqpCKIIiljFqJDs8CGBZcy9heKLmEnlbKeL6zY1NjbfqEyxjA4qXDry2jqbN8ryYhK7eXktV+UIb7xIVy1fs8Sw+eXDb025ZILZL9cQ7Vh3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202515; c=relaxed/simple;
	bh=Gen/pPzDEnmUgS1j8ZB4uddyDs73eqpIaUAHuD12qXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVJXZEu4jNAK4n6crEFQqndCTs+xcr3k/vFfDp8YucWxJBtwvdh+MrzWlpCGDTOLtUpkQgWxQuvYzuKvfPKvGf6865+zaY/GaGznproJl5Mx1Rd3Fu3qjlAaKf9XRfwugeIJ0K3lsyb6FZbDnsmasoC56UR2OuTsnpEketigAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ard+GFlR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so7181a12.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 02:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709202512; x=1709807312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDV4jL0SIZPHNGZJLJzya8BUhcBbRTIVipyMtlb65G0=;
        b=ard+GFlRGUZsQMrcp1leI0/d8jwYrtSftPwEEzweVrCfrtLZ9Qy0YJ8diziUjZ+CI5
         uJ1GLg8R1XdQqJB/YhGFLTHwOu5JDF4a9XfczU+xqxS2PHToOenulF/OXzXlcd6EDPlv
         FgpVhIA2//i5NF3jPwEZSZil5y2iX+CaplGwxXNSi6YSjretIGGiZtnizO42HG8B5MFN
         zX1I9pGMc0pvmaEKzHfnFTG8Kx+hYqBB48ErOE6FVbm9XU3B/5bFvBdSdpnaSNbJAhUP
         J3DEToIjyVMBe0GC+KbysQjneTbuSxVxCufc1eIokYta5ynYDIBgWWX731yIAOAtqQ8o
         ksQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202512; x=1709807312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDV4jL0SIZPHNGZJLJzya8BUhcBbRTIVipyMtlb65G0=;
        b=q1YK0yirhCSTcfwaqNnOvtdT+bG3ES0i6ai2T8+TR+semiQqPevNuqdiXW6JDPed+v
         cAsDMRcnQ+IaKhMIc980wlKcUAbMLVqpLCdZAO75cEAfyXhsokCWmkRNb0kkN89yYohB
         okpWChOvaB1nH71xhtSC1H1HkLFOXXkD4qzwm3kgXHctIrjl8PNrUzlAVgcKxkN3OCHl
         +3BhSKiUwBHMPbsiMH2DIExkk5shYjrmUm6j4yWnTx6/thc2ytThcgYN7cZG1wnFNOmm
         tZ+ItMwxZNRNfkpom6mZdYmyc/VWLMw6bz/4XAV2vFvWFSFil/StQaDV2Vskb+YfNDVg
         z06w==
X-Forwarded-Encrypted: i=1; AJvYcCVf/XxI66TOkqSASCSVodZqBjXzEjLrkUYh/mztal2F7EpQ6YsyEnTVWFC54YLp2u1hiXtFtmrRtx5pcxwZEma0oKhM7/RhksI=
X-Gm-Message-State: AOJu0YwD8vkX8/kQXbkxs1peJOAhAY19TFndGVk6P9aMFEytQ1ykdrR/
	W57wBrENESvKjT7ol4LD5KFofSXzmqop4pPgYCfY3DzDJC3FBw+stfD3OmfCc7SW0B+11/Y+lO4
	0DMOvqnQiQQHoH9uANRvEIBtb8lKypJ86YbKE
X-Google-Smtp-Source: AGHT+IGxqSlWKixvBGZKaFQJW5SjqcWLJPXBbGX85VtQJOjxoM5SUFjK2E2FtgML+eAxvmhg9UFMzJjqAkFTM8jh33s=
X-Received: by 2002:a05:6402:348a:b0:566:2c0:a9d6 with SMTP id
 v10-20020a056402348a00b0056602c0a9d6mr82704edc.3.1709202511503; Thu, 29 Feb
 2024 02:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com> <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
 <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com> <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
 <2024022749-campus-multiply-d657@gregkh>
In-Reply-To: <2024022749-campus-multiply-d657@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 29 Feb 2024 18:27:00 +0800
Message-ID: <CAOuDEK3e0y_5HB3VkZoyYY8kzoWAJ3w9y7RcLJy7tSatsc+A6w@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, rafael@kernel.org, pavel@ucw.cz, 
	len.brown@intel.com, andriy.shevchenko@linux.intel.com, rdunlap@infradead.org, 
	james@equiv.tech, broonie@kernel.org, james.clark@arm.com, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Feb 27, 2024 at 04:56:00PM +0800, Guan-Yu Lin wrote:
> > On Tue, Feb 27, 2024 at 2:40=E2=80=AFAM Florian Fainelli <f.fainelli@gm=
ail.com> wrote:
> > >
> > > On 2/26/24 02:28, Guan-Yu Lin wrote:
> > > > On Sat, Feb 24, 2024 at 2:20=E2=80=AFAM Florian Fainelli <f.fainell=
i@gmail.com> wrote:
> > > >>
> > > >> On 2/23/24 06:38, Guan-Yu Lin wrote:
> > > >>> In systems with a main processor and a co-processor, asynchronous
> > > >>> controller management can lead to conflicts.  One example is the =
main
> > > >>> processor attempting to suspend a device while the co-processor i=
s
> > > >>> actively using it. To address this, we introduce a new sysfs entr=
y
> > > >>> called "conditional_skip". This entry allows the system to select=
ively
> > > >>> skip certain device power management state transitions. To use th=
is
> > > >>> feature, set the value in "conditional_skip" to indicate the type=
 of
> > > >>> state transition you want to avoid.  Please review /Documentation=
/ABI/
> > > >>> testing/sysfs-devices-power for more detailed information.
> > > >>
> > > >> This looks like a poor way of dealing with a lack of adequate reso=
urce
> > > >> tracking from Linux on behalf of the co-processor(s) and I really =
do not
> > > >> understand how someone is supposed to use that in a way that works=
.
> > > >>
> > > >> Cannot you use a HW maintained spinlock between your host processo=
r and
> > > >> the co-processor such that they can each claim exclusive access to=
 the
> > > >> hardware and you can busy-wait until one or the other is done usin=
g the
> > > >> device? How is your partitioning between host processor owned bloc=
ks and
> > > >> co-processor(s) owned blocks? Is it static or is it dynamic?
> > > >> --
> > > >> Florian
> > > >>
> > > >
> > > > This patch enables devices to selectively participate in system pow=
er
> > > > transitions. This is crucial when multiple processors, managed by
> > > > different operating system kernels, share the same controller. One
> > > > processor shouldn't enforce the same power transition procedures on
> > > > the controller =E2=80=93 another processor might be using it at tha=
t moment.
> > > > While a spinlock is necessary for synchronizing controller access, =
we
> > > > still need to add the flexibility to dynamically customize power
> > > > transition behavior for each device. And that's what this patch is
> > > > trying to do.
> > > > In our use case, the host processor and co-processor are managed by
> > > > separate operating system kernels. This arrangement is static.
> > >
> > > OK, so now the question is whether the peripheral is entirely visible=
 to
> > > Linux, or is it entirely owned by the co-processor, or is there a
> > > combination of both and the usage of the said device driver is dynami=
c
> > > between Linux and your co-processor?
> > >
> > > A sysfs entry does not seem like the appropriate way to described whi=
ch
> > > states need to be skipped and which ones can remain under control of
> > > Linux, you would have to use your firmware's description for that (AC=
PI,
> > > Device Tree, etc.) such that you have a more comprehensive solution t=
hat
> > > can span a bigger scope.
> > > --
> > > Florian
> > >
> >
> > We anticipate that control of the peripheral (e.g., controller) will
> > be shared between operating system kernels. Each kernel will need its
> > own driver for peripheral communication. To accommodate different
> > tasks, the operating system managing the peripheral can change
> > dynamically at runtime.
>
> That sounds like a nightmare of control and handling, how are you going
> to do any of that?  Where is the code for that?
>

Since the peripheral can issue different types of interrupts, we plan
to assign the handling of those interrupts to separate operating
system kernels. Additionally, only one operating system kernel will
have the privilege to issue commands to the peripheral. We think that
this could resolve potential conflicts.

> > We dynamically select the operating system kernel controlling the
> > target peripheral based on the task at hand, which looks more like a
> > software behavior rather than hardware behavior to me. I agree that we
> > might need a firmware description for "whether another operating
> > system exists for this peripheral", but we also need to store the
> > information about "whether another operating system is actively using
> > this peripheral". To me, the latter one looks more like a sysfs entry
> > rather than a firmware description as it's not determined statically.
>
> So you want to download different firmware to the device depending on
> "something".  What is going to control that "something"?  Is that coming
> from the kernel, or from userspace?  If userspace, why is any of this an
> issue and just load whatever firmware you decide at that point in time?
> Why does the kernel care?
>
> confused,
>
> greg k-h

In our design, no single firmware can fully control or communicate
with the peripheral. Different functions of the peripheral are
supported by different operating system kernels. Therefore, we should
keep both firmwares active to use the peripheral effectively.

