Return-Path: <linux-pm+bounces-15228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A00991E1E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 13:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5DBB20C86
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD711741C9;
	Sun,  6 Oct 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="U2GJcr0e"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39182171099;
	Sun,  6 Oct 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214198; cv=none; b=pBzSyiJS54gyDzdPF46DY5b0PqiJU0mH8HxiZy9rmiE+JtD6bWlbaStZbgcnL2cIK17GVaabgI5D88S3ghsQSK3YU+XWAINlP26x+jHZcY/CTMNJg575bLIxvZKfyV3mOu/+U6JcgsxFYU6kLj2FSh7DaetwNyX7AvMWpoQEClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214198; c=relaxed/simple;
	bh=fLYp7ZEeGSe5/a+8GLeNuqNLIEAcEu6AMk4pNEA0csw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lp5MpNM/Qjg1cqlKHc5KbcLnF2GYEsUseH64218iJC/0KXnp+BjY9iWKbEVKV9Kzsy2W/9ldym9kLkSEGvdep6afFsFCRt0YVgyw49f2h5ii/VhuV8ZfmB/7f5l4jM42hYC0Udqc912M3oasN5t/+UOSIquC7dT9fkQzQOaxTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=U2GJcr0e; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 93A282E098AE;
	Sun,  6 Oct 2024 14:29:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1728214192;
	bh=fLYp7ZEeGSe5/a+8GLeNuqNLIEAcEu6AMk4pNEA0csw=;
	h=Received:From:Subject:To;
	b=U2GJcr0eYpzDbf34HbuybEseprIbys4SuZMQcWVZFVsRCLenssPXDgajXgeG/kamy
	 o3GAPERLJ7yfK8lGPkfYXXmCNaGUdHBze23FoffQvYJwGZkxVWlgOz7eH9A+Q8g2DD
	 YPFEF93oe5vKzrMY0Mo8svHwBFnB/kQK3lhRWGz4=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2fad75b46a3so32092601fa.2;
        Sun, 06 Oct 2024 04:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWo3hPp7P1aYp3RvtAuGGtOJvLLQN1x3RajD3cRTHn45nC4gN/Mv8zkf0Fs8aW8c8wX8QmjoPqBlO0rim+e89GPmZ4j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QHslXw4AU/Ma/ppcizNRgHxZzXiXuGj2pibYsnBrYowueXHi
	F5hZo8PRwmk9qfvwderovlFnMo/3BRdnJg9s36a7rfCs9gqRFBg5PCwsNOsJf7KhMn+F7w+gPHu
	c7fDQqDKC9sdDZY5qe1lrHKDXHj4=
X-Google-Smtp-Source: 
 AGHT+IFkLrWbh9r2iEIUbQHp5+W+GOAPe57WgHm8C7CpyzUiGt7zsncV3GpOoiygOtk2NCQ9k09vFXMXePwy8KH2F54=
X-Received: by 2002:a05:651c:545:b0:2fa:bba7:2699 with SMTP id
 38308e7fff4ca-2faf3c15aa4mr36986611fa.16.1728214190717; Sun, 06 Oct 2024
 04:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
 <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
 <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
 <ede128c0-46e7-4c94-ac7f-39db0efa612d@redhat.com>
 <CAGwozwESYc=znHvgJidjxoUskRuzxgoVGY7=fnmPQyYOLJP_0w@mail.gmail.com>
 <fca2e4bd-10c6-462c-82a2-37627a797cb9@redhat.com>
In-Reply-To: <fca2e4bd-10c6-462c-82a2-37627a797cb9@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 6 Oct 2024 13:29:39 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFEbKSCDcZHCf0g=BST89eGqNbxzAxWpOj-re2sPUUKnQ@mail.gmail.com>
Message-ID: 
 <CAGwozwFEbKSCDcZHCf0g=BST89eGqNbxzAxWpOj-re2sPUUKnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172821419210.17046.18308113948475448672@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Hans,
there is no rush from my end to see this series merge. The current
asus-wmi quirk works well for the Ally, all firmwares. New firmware is
also supposed to fix powersaving with it.

Yes, that quirk is suboptimal as it adds a noticeable delay to suspend
and resume and blocks powersaving from working correctly in old
firmwares. However, as most Ally users are on custom kernels anyway,
and this patch series can be merged quite easily into them, broadly
speaking it is a non-issue if the mainline kernel has ideal behavior
on the Ally for the next few months. From user feedback, they did not
notice changing to this patch anyway, other than the powersaving
benefit ("did you change anything? my ally just uses less power now").

Next revision I will cc dri so we get feedback from there too.

> >> Thinking some more about this I am having second doubts about
> >> moving the LPS0 display power off call to before devices are suspended,
> >> doing so would mean that the display might still be on when that call
> >> is made and that call could disable power-resources which are necessary
> >> for the display causing issues when the display driver's suspend method
> >> runs.
> >
> > Is there any device where that is used for display powersaving?
>
> The problem is that we cannot rule out that the LPS0 display off
> call relies on the displays actually being off.
>
> I have seen ACPI AML code do all sort of crazy stuff.

Indeed, as this series shows (for other reasons).

> So IMHO we really need to make sure that all physical displays
> are off before we make the LPS0 display off call.

In my use-case I'd like to be able to fire the display off
notification prior to turning off the screen or turn on the screen
after both Display Off and Sleep Entry have fired to be able to show a
dim lockscreen if the user briefly interacts with the device. I will
be doing this downstream for a limited set of prevalidated devices
though.

Therefore, before we block this behavior in a non-certain manner (as
it will be up to each gpu driver to do it), there needs to be some
documentation showing there is an issue, certain manufacturers rely on
the behavior, or that Microsoft has guaranteed that this is the case
in Windows. Even with any of the former, a blacklist quirk for those
manufacturers can be put in place in their GPU driver that blocks the
Display Off _DSM from firing and automatically calls the Display On
_DSM if the GPU wants to wake up the display.

> I have read what you wrote about this also applying to virtual
> displays, I guess that means that there should be no rendering done
> (so also no GPU non display tasks) when this is called.
>
> IOW it might be best to tie this to all VGA class PCI devices
> being in D3 as Mario suggested.

GPU can do stuff while the screen is off: render videos, hold browser
videos in main memory, have a game in the background, etc. If by D3
you mean the whole GPU has powered off, this would be a deviation from
Windows.

Antheas

