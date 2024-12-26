Return-Path: <linux-pm+bounces-19772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FA9FCE46
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 22:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D2A1883086
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 21:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98119992C;
	Thu, 26 Dec 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XyTSZwZF"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039E196D8F;
	Thu, 26 Dec 2024 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735250363; cv=none; b=rPLCJLYXQTflG6D4fBq2DBSIA8xisuMcvNEMd9/b33+P0zeqXfOClHYqesFpuS0ZulkCpEtaFlZ5VbqAaP5D8uHslBlBENQgIWLh/O1IYsuJnaUQMRdhDTZSFas9N9VoSRSbhCWUvY6TPIYNAAG3P4xhfHqeiVxc1V05q2PZFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735250363; c=relaxed/simple;
	bh=BJSIBwA9CHxzU+rdENwwDBs9w+whydGHdjfnTkwrpV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q78qcBHSOsLU/+IR7ClR0VweJRpABwVlKJzhqLoM+fjPj+PmZ5rK0poApHyw+TqPNitrPB1ImVsFU+/gydJSqUtXKgS0OisiJrSubkV2JtHfIc7B7lq7LoZipsecf6kJjFQPjTsBj2E8PXn/KNgjIqR75uP/ZkYIlkC/AkAiOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XyTSZwZF; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 0F7142E08C92;
	Thu, 26 Dec 2024 23:59:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735250354;
	bh=BJSIBwA9CHxzU+rdENwwDBs9w+whydGHdjfnTkwrpV0=;
	h=Received:From:Subject:To;
	b=XyTSZwZFGxf3Izf/jDc2p4942aZGESaErCyOUH5dHwLdj3qHaIAwpVnjarz8oDe6u
	 +vpWQqFH2/lz0NMwY9q2JxPVshLH1ae8TEmLwOE0+Y3B0acUBi9NLlLSjRAj2XHT5H
	 BhFm9E+i/flkrWz4iqdv2fZx8X/RgSiFksVZjaH0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-30167f4c1e3so77610991fa.3;
        Thu, 26 Dec 2024 13:59:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVFLTYDUjOPcbsbUcsIyf8NAI5vFN7pTfTHHse8b/7ODSWaPVoe/vZraqze9pnNeALQcYe5E86GUjkmaZc=@vger.kernel.org,
 AJvYcCVJWBMzxN4OBif5M5s5+9lBfYNceORvNY8gQB1zDKMpDBaoP/VwevvXdOiW4nD/73lX+vlmSzJIeSA=@vger.kernel.org,
 AJvYcCWBFapNKUiuPgepm9KjEOxyMXpoihMSFOcfZV2U6m/glZKlvmZweIQUMRZhGqt/selTmcZVZrAiFyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQb25rjnJLyAXFrzeXbiR+Fz8yoVTSYd/dTdKK8fwTM/OwmYT
	ZpuMpKWb0Pf9BQoKqRXRj4Dvnq2+Enj8BrqvGtYoCCgqOgRn/gaUd6w4ggX3hjDOEKaSEamxwB1
	V86LdEPp54usssnZ3WhRFjT/KMD0=
X-Google-Smtp-Source: 
 AGHT+IE0uosJXNHgBNsmOK5SCygq+q2Eyw+kM1E+jmemJgvkLig/bhaA2NkLmdldhG7GfGo5HN4isBAC/9N7YVIZZd0=
X-Received: by 2002:a05:651c:212a:b0:302:264e:29ec with SMTP id
 38308e7fff4ca-30468522114mr82659321fa.11.1735250353227; Thu, 26 Dec 2024
 13:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226112740.340804-1-lkml@antheas.dev>
 <a8e6d5d5-703c-47df-ab57-58234fdeefc1@roeck-us.net>
 <E24291F9-731F-4C27-96C7-BD08FBCF7A76@gmail.com>
In-Reply-To: <E24291F9-731F-4C27-96C7-BD08FBCF7A76@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Dec 2024 22:59:02 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGdaqoiH5v9Sy5pibHYzrbYnpWKfQ-qUg0+vft_Ve4TUg@mail.gmail.com>
Message-ID: 
 <CAGwozwGdaqoiH5v9Sy5pibHYzrbYnpWKfQ-qUg0+vft_Ve4TUg@mail.gmail.com>
Subject: Re: [PATCH 00/10] hwmon: (oxpsensors) Add 2024 OneXPlayer line-up,
 add charge limiting and turbo LED, fix ABI
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <173525035443.10068.13012689396980476255@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Guenter,
Right now, OneXPlayer features a singular EC with a handful of
features. Where with this patch series we essentially have parity with
windows, apart from a VRAM feature which I will have to ask but I
suspect is WMI. It currently concerns a singular component (the EC)
and the functionality such as turbo button affects the hwmon component
(i.e., if the turbo button is not engaged, the fan control
functionality does not work).

As such it cannot be made into separate drivers. I think, and I
suspect you will agree, that the scope of the driver is _correct_ but
the place is not correct.

Therefore, can you suggest a reasonable path forward that is sparing
to this patch series? Should I add an eleventh patch that grafts this
driver to platform-x86? If appropriate, you can cc the x86 mailing
list on your next email.

Best,
Antheas

On Thu, 26 Dec 2024 at 22:16, Derek J. Clark <derekjohn.clark@gmail.com> wr=
ote:
>
>
>
> On December 26, 2024 1:08:02 PM PST, Guenter Roeck <linux@roeck-us.net> w=
rote:
> >On Thu, Dec 26, 2024 at 12:27:30PM +0100, Antheas Kapenekakis wrote:
> >> This three part series updates the oxpsensors module to bring it in li=
ne
> >> with its Windows OneXPlayer counterpart. First, it adds support for al=
l
> >> 2024 OneXPlayer handhelds and their special variants.
> >>
> >> Then, it adds the new charge limiting and bypass features that were fi=
rst
> >> introduced in the X1 and retrofit to older OneXFly variants and for
> >> controlling the turbo led found in the X1 models. For Bypass, it adds =
a new
> >> bypass variant BypassS0 that is only active while the device is in the=
 S0
> >> state.
> >>
> >
> >This is a hardware monitoring driver. It is not a charge controller driv=
er,
> >and it is not a LED controller driver. If such control is wanted/needed =
for
> >this system, it should be implemented either as mfd device with client d=
rivers,
> >or the entire driver should be moved to platform drivers if there is a d=
esire
> >to keep it as single driver.
> >
> >Guenter
>
> I think moving this to x86 platform makes a lot of sense to ensure two se=
parate drivers can't do async writes to the EC. We probably should have don=
e that when adding the turbo button toggle anyway. I'll coordinate that eff=
ort with Tobias and Antheas directly before moving forward.
>
> Thanks Guenter,
> - Derek

