Return-Path: <linux-pm+bounces-14587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CD97EFA4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA5B1F219A8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6661991D9;
	Mon, 23 Sep 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="DYY30CjC"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2019F40A
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110496; cv=none; b=A/dzBAOmZdW+l6Wiq8IFEYt/GsUz7MPflLMUQafPPXIe+8sL2bW1wLa1U5v7ZqstFrfa2P07PlshtiCTGbk+sNJd/TmV7hPSpHNsL6B2dsBPvxaYMkHh9z2EuNiWUpobEVU42ab9QP19vleKQYKG2lhoMnJROGTMTgPlZn7C0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110496; c=relaxed/simple;
	bh=I3It6gBYooIu+p61xnrYJCenoDzRPtV0cjr/dPQN1F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOKiqQqGbPZtELFLbBfTE68umzZu3gnOz+7QocLvX537BFPR+TpucbAAAm8sDWfMUPQ97IZuROZS2lCtTDq0OAci/emxGChY9C5TSD+pfdiQYnwoafnK2ptg6DTAJf1bB0oYOzUJpfFgblc+l7AtTHx7uIQX+4dLyy40Uif3EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=DYY30CjC; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 300D72E00D18
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 19:54:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727110490;
	bh=ea2nMGOBsfrVvo6L8+qxl8lkJQ/fxIwLdkiUDWVwcyA=;
	h=Received:From:Subject:To;
	b=DYY30CjCYptesm/XsiUK27+8LqJ5eNq4JDEB7Tq67+k/CaVFsR5E0zjjh5wqgpttB
	 WrNcStPmEfblRypF4aZ4Hz3n7VNdvgETH5cfLLIg6TcjMkWSm4Uy8+21wFaol/syVm
	 /7/B/hSHCoPWPG7KMAM5ZwsjtOwhwpCA3RmFTasI=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2f75d044201so44983311fa.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 09:54:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUbwsDqGLtGzx4m9mRMCL968DfEb5UwPJzVa65xePFQivgAm3TkrkHl2/dvP3vFkUzci4Qo72pdnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkP7karV+GKIQGzhkS74JTDUyAYBjCIit1KgPHTCr8Vd9MIBV
	bxDYMenizu3rcjK5UjLUuDnJZVk7aeRhSWr4Ft5Tj4AzDDSyYtYzBZ60mnuIDTrKowUC4QzoSUN
	TF2Dq88PYXEYnsWzr4IPNOwjmffk=
X-Google-Smtp-Source: 
 AGHT+IErGysnspOd41gQJRK9/rlbfBX1W4GjWUKg8R1uGNBVy8xspcKYoDlNFQr3OVvRT7+MkIEWGecd39WqUoJQS/4=
X-Received: by 2002:a05:651c:1545:b0:2f7:a759:72a3 with SMTP id
 38308e7fff4ca-2f8d0ba1958mr874191fa.24.1727110489354; Mon, 23 Sep 2024
 09:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
 <20240923013657.7464-1-derekjohn.clark@gmail.com>
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
 <b43f9654-4dd7-4f3c-95b5-575473c3bcc1@app.fastmail.com>
 <CAGwozwE_MXuqreQvDFyVyodrzH5HFB=Nab9LfxD9DMB+HGkt3Q@mail.gmail.com>
 <fa1cb9c1-8b56-4fbf-89aa-86ffc6dc837b@amd.com>
 <CAGwozwHvXkG824xHcfnr6E+B6iLr6KJiLEjJhx4hEhieHYob8g@mail.gmail.com>
 <358ca905-ae53-4d2d-b09a-8e708d6fadd8@amd.com>
In-Reply-To: <358ca905-ae53-4d2d-b09a-8e708d6fadd8@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 18:54:37 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGsyebGE78SKMckkm2=8uqDTX+S-Jnxrn61X_UHVEDcDA@mail.gmail.com>
Message-ID: 
 <CAGwozwGsyebGE78SKMckkm2=8uqDTX+S-Jnxrn61X_UHVEDcDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Luke Jones <luke@ljones.dev>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172711049056.22266.6721309054129621677@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> Part of the problem here is that we (Linux kernel developers) don't have
> the details of how the MCU actually interacts with the OS vs how it
> wants to interact with the OS.  Only ASUS knows this and all we can do
> is guess (or join an NDA).

I want to say that that is beginning to change, at least for these
devices. Manufacturers want the experience that comes with owning the
whole OS. Mobile phones and TVs figured that out long ago.

> "For example" (not saying this is the problem; I don't know) if we have
> a Linux sequence that we put the XHCI host controller into D3 but don't
> turn off the port first this might not matter to most devices because
> you're saving power by the controller being in D3.  But if the device is
> looking for some sequence of packets there could be a failure if those
> never happen or happen at the wrong time.

The problem here is probably that. Killing the power too early made it
not save its state, asking it to be brought up before it powers on
made it NOOP, and asking it to be brought up in prepare_early ended up
with a bunch of race conditions with the kernel.

Lenovo figured it out, so there is no reason Asus wouldn't. Although
the latest bios from lenovo made the controllers take 2 seconds longer
to wake up. We did not have any problem in Linux, that was in Windows.
Unplugging XInput devices is really a mess.

I am really happy with the patch on the Ally X. We will get to testing
it on the Ally. It does a little reboot with powersave on, but that is
a cosmetic failure and happens in Windows too. When Asus fixes that I
will point them to Windows to update if they care about powersave so
much.

> >
> > I am currently playing a bit with the calls in the Legion Go. Seems
> > like one of them turns off its controller as well.
> >
> > I did not know fwupd could do microprocessors, if it is simple that
> > would be great.
>
> Yeah in this case it interacts with the USB HID interface.
>
> Unfortunately we don't have the HID spec from ASUS, so the entire thing
> would need to be reverse engineered.
>
> I hope that more of these handhelds with MCUs that get regular updates
> make the same investment.

I do not think every manufacturer creates a HID spec for updates. They
use the same cookiecutter stuff, for which there is no linux
implementation at all, so kind of the same. Probably after we do 1-3,
we will have all of them.

I saw that HID interface though, and the Legion Go has one and I am
none the wiser.

I've been doing HID for over a year by now, so I am used to it.
Biggest problem is you cannot trigger an update in Windows whenever
you want to sniff it. At least on the Lenovo.

However, I think I have bigger fish to fry, so it is not high in my
priority list.

Antheas

