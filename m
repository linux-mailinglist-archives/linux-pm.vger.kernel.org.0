Return-Path: <linux-pm+bounces-19956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95314A0158D
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 16:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564013A3142
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CAA1922E6;
	Sat,  4 Jan 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="F4i8QVe1"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B37136A;
	Sat,  4 Jan 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005057; cv=none; b=nT/73nDklpgxnnjxVYVf/qxZ00G7Fib76t+ARjRAgVmOngdyFDE7YwZZcb9wk2qjJAsoNHaKGGQNtXV1pHzRvnlkLDUM8VXS10uNqY8s4AIZtpOV+MLTZzzfnpl3yONy3/8Lm6AUuJVBwjf5ZnXmoc+ahUegkhCAALJbjdQh2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005057; c=relaxed/simple;
	bh=oO6BTuR9MKO/Rp/vP/YeD7XEnx0FuPYuT7prs40/9b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtktkYfQ+o7SGRtxY7jFmGw6JVQRLwo+KSj9la/y4XwCJJRFRGMcoTavNzDZD3Djew3VZzvzsfQ84P6YiFngNuLB2N4rPpJe/apXWl3L8r0006tqVYcWIWbrhm0FJdpOMzAJGyhP24i9MQoDPCiF65FO6hJ52vPvvkL03zKn2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=F4i8QVe1; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 407A82E08743;
	Sat,  4 Jan 2025 17:37:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1736005043;
	bh=oO6BTuR9MKO/Rp/vP/YeD7XEnx0FuPYuT7prs40/9b8=;
	h=Received:From:Subject:To;
	b=F4i8QVe1mBvli5oupsFSeSDfwaqOoPaku+szrTmpkJ1erKqMUlYrRzkBCSQY4XTIu
	 NBtJFSXNJahstWy/0kKS07dQ1vuneyjdPi/NSDG/OiTK8ZV3Hmj8tZMuKCHUXHoffU
	 0pl7pQkB89hflsj0oXNHq9BV2lR5FDgi5G7jGsdQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f171.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2ffd6af012eso180024161fa.2;
        Sat, 04 Jan 2025 07:37:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW1566IxzoTYheLnU4q45PxrlrnfvkqlD+urcvcuq0lB/Hn0EkNcS4HUhlxEEEGRobX6/JHxOHo3uy697I=@vger.kernel.org,
 AJvYcCWI/yTrCGUb6N79lqH80IyEaXvvekaRHtb8SScgo0T1GOk+MYt5q15qpJJVraZWUoPH3U7rAhhTUQk=@vger.kernel.org,
 AJvYcCWJ/hixwMRZDjBFy9nXNlmEY4XsdNasexTS8IhmBZNSNAYGkMnu5gBHMoRis2pfAkQhhOr8jj+SHqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEv5PBz2lbNc/lVPbJienin8D0zrRbZfs0bHBgo188Fxwvft6Y
	ar7CSjC4tHbS0wrZuP9faBDrnnmNYC9Zx3K/y7JxNQK30rVf7zwQUxwYT3Z5tJf8adCDxXB7on8
	wALRXc3DURiaWiH6vGGsq6+bfL2w=
X-Google-Smtp-Source: 
 AGHT+IGQuT3+RV479P8YTXLJj4Ou85qh2JdjQKRsZbm+qv09j7pzSTbsCqKn7zqUKMMqhzaC/WqWYEMGga9q6BN8xMc=
X-Received: by 2002:a2e:a991:0:b0:300:33b1:f0e1 with SMTP id
 38308e7fff4ca-304684190bemr171519001fa.0.1736005041488; Sat, 04 Jan 2025
 07:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226112740.340804-1-lkml@antheas.dev>
 <a8e6d5d5-703c-47df-ab57-58234fdeefc1@roeck-us.net>
 <E24291F9-731F-4C27-96C7-BD08FBCF7A76@gmail.com>
 <3b5b5486-9b11-484b-b5d9-6a830ad10130@roeck-us.net>
In-Reply-To: <3b5b5486-9b11-484b-b5d9-6a830ad10130@roeck-us.net>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 4 Jan 2025 16:37:10 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHwQcwbpiggZ5L9p6Gu+oDfnehH3XGVSaTOmkA5Ty+yyA@mail.gmail.com>
Message-ID: 
 <CAGwozwHwQcwbpiggZ5L9p6Gu+oDfnehH3XGVSaTOmkA5Ty+yyA@mail.gmail.com>
Subject: Re: [PATCH 00/10] hwmon: (oxpsensors) Add 2024 OneXPlayer line-up,
 add charge limiting and turbo LED, fix ABI
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <173600504267.15624.12799910774026201393@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Guenter,
I've spoken with Derek, and we are in agreement this should be moved.

Which part of the patch series do you want me to put the move in? Or
is it something you want to do yourself prior to/after the patch
series. lmk and I will coordinate for V2

As for @Joaquin, can you ack the move since you are the module author?

Antheas

On Fri, 27 Dec 2024 at 18:12, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Dec 26, 2024 at 01:16:15PM -0800, Derek J. Clark wrote:
> >
> >
> > On December 26, 2024 1:08:02 PM PST, Guenter Roeck <linux@roeck-us.net>=
 wrote:
> > >On Thu, Dec 26, 2024 at 12:27:30PM +0100, Antheas Kapenekakis wrote:
> > >> This three part series updates the oxpsensors module to bring it in =
line
> > >> with its Windows OneXPlayer counterpart. First, it adds support for =
all
> > >> 2024 OneXPlayer handhelds and their special variants.
> > >>
> > >> Then, it adds the new charge limiting and bypass features that were =
first
> > >> introduced in the X1 and retrofit to older OneXFly variants and for
> > >> controlling the turbo led found in the X1 models. For Bypass, it add=
s a new
> > >> bypass variant BypassS0 that is only active while the device is in t=
he S0
> > >> state.
> > >>
> > >
> > >This is a hardware monitoring driver. It is not a charge controller dr=
iver,
> > >and it is not a LED controller driver. If such control is wanted/neede=
d for
> > >this system, it should be implemented either as mfd device with client=
 drivers,
> > >or the entire driver should be moved to platform drivers if there is a=
 desire
> > >to keep it as single driver.
> > >
> > >Guenter
> >
> > I think moving this to x86 platform makes a lot of sense to ensure two =
separate drivers can't do async writes to the EC. We probably should have d=
one that when adding the turbo button toggle anyway. I'll coordinate that e=
ffort with Tobias and Antheas directly before moving forward.
> >
>
> Fine with me, but "ensure two drivers can't do asynchronous writes" is no=
t
> really an argument. mfd supports that as well for pretty much all mfd
> drivers.
>
> Guenter

