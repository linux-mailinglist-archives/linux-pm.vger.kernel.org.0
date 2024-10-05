Return-Path: <linux-pm+bounces-15220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD57991B2E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 00:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B7B21EF7
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 22:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42E142624;
	Sat,  5 Oct 2024 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="3ze2R4oV"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F104E1CA;
	Sat,  5 Oct 2024 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728166571; cv=none; b=WKOJRGY6jhYIpZDARPBx7Cb+xee7CORiLHzn0cJyv5wY2meiH9RN8klL9BeAASLgCzo012geotUMfxJRfup06KN4vN3MtRQZbUgfA8NhOVi9u/MTGwDTFr8+msFv98PVo2p+w7icnw6VsjHz/bzozNKDy+Hv09fB1Zm7Mq+4RaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728166571; c=relaxed/simple;
	bh=/zDwBqr1YcZcrLHfJXKpEaXDRKBq4cUxi1JobrekPaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYcbseClX55yMWo85ktKV95CPN9qaCr0OY1gu6YEXT5QwYGOhz0jHnDp8nnZ4J2Rli1BwjYQMwYwtRNLaZyuT5dQzD8hMBI1Y9Sx1798By4uRFTCd5Q6mJ8TU8CKQQFNq0d7JCbMRU/XkA/aJX4DAk0fCZJkmPRTOpvjxeemMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=3ze2R4oV; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id BD5F72E02014;
	Sun,  6 Oct 2024 01:16:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1728166564;
	bh=/zDwBqr1YcZcrLHfJXKpEaXDRKBq4cUxi1JobrekPaA=;
	h=Received:From:Subject:To;
	b=3ze2R4oVbamPn9tlh61Bsch5cIiqLkZoalFUGBnEnNFFkiRXjvfvN8mQsD6G5Gv8w
	 CEy1ntX2cll9MlKoDaYzVirQB6mwtWKoSBfFD7HHuT7gGNfKocUBGoTlwlW2j851ra
	 lZW3EXc8/yUcugoJ5BdPAc02hnbXr42/pv1gR3d4=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f173.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2fad100dd9fso45752981fa.3;
        Sat, 05 Oct 2024 15:16:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW76OzXr/bMAzZj67m3GbOVzW8MYTSG8IHKDqhpWkYIdWim5USY04vbEmsgzfM42pEX9jnbbXQCdCRTsNwEGCS1Zfq1@vger.kernel.org
X-Gm-Message-State: AOJu0YyurfbrQzWHsTc2rVpU20gbC+m45784zI08TYvyefhhSTbOaqr8
	0LvZ9HnNrIYzTZabbBe+JezKQ8SVJBYzUTRN4oghxhMNh/21LzQHeHtT6sjcp+tcnu3XrEATpsR
	8Vvi6znC0SUxPuNSGR9Ljh0lmS6c=
X-Google-Smtp-Source: 
 AGHT+IGpPEFXgJZu+u9+/Gz8Z9Al6yz2ynde5Sp5IYaQ+x5SfyFVIqf94L5lpYpHGF6P+kGvoN3iOEC1PFjkyFr3Ugk=
X-Received: by 2002:a05:651c:1989:b0:2fa:d49d:45ae with SMTP id
 38308e7fff4ca-2faf3c0c2bcmr48943331fa.8.1728166563050; Sat, 05 Oct 2024
 15:16:03 -0700 (PDT)
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
In-Reply-To: <ede128c0-46e7-4c94-ac7f-39db0efa612d@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 6 Oct 2024 00:15:51 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwESYc=znHvgJidjxoUskRuzxgoVGY7=fnmPQyYOLJP_0w@mail.gmail.com>
Message-ID: 
 <CAGwozwESYc=znHvgJidjxoUskRuzxgoVGY7=fnmPQyYOLJP_0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <172816656422.23588.9215590334041796372@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

<skip>

> Thinking some more about this I am having second doubts about
> moving the LPS0 display power off call to before devices are suspended,
> doing so would mean that the display might still be on when that call
> is made and that call could disable power-resources which are necessary
> for the display causing issues when the display driver's suspend method
> runs.

Is there any device where that is used for display powersaving?

> So I think that we need something closer to Mario's POC from:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=
=3Dsuperm1/dsm-screen-on-off
>
> here where the call is made when the last display is turned off.
>
> IOW have the drm modesetting core call this.

I can see two problems with this approach: 1) it would happen in a
random point in the suspend sequence, introducing race conditions with
sensitive modern standby devices (e.g., Ally). 2) It would not be
gated and debounced properly, so a drm driver could call it 5 times
when you e.g., plug in an HDMI cable.

And indeed that is the case, that PR horribly breaks the Ally even
while any asus-wmi quirk was active. Perhaps DRM can be consulted
though, see below.

> Maybe have something like a enabled_displays counter in the
> drm-core which gets increased / decreased by helpers and
> have the drm-core call platform_suspend_screen_off() /
> platform_suspend_screen_on() when the counter goes from 1 -> 0
> resp. 0 -> 1, ignoring the very first 0 -> 1 transition
> which will be done when the first GPU with an enabled
> output is found ?

To quote Microsoft [1], "This _DSM Function will be invoked when the
operating system has entered a state where all displays=E2=80=94local and
*remote*, if any=E2=80=94have been turned off."

Since it says remote, binding it to DRM could prove difficult. In
addition, the call in Windows is made 5 seconds after the displays
turn off due to inactivity. To mirror this behavior you would need
userspace.

If there is strong indication that the Display On/Off calls interfere
with the DRM subsystem, e.g., turn off a GPU in certain laptops, the
call could be gated with a counter similar to Mario's PR and error
out. In that way, it is still controllable by userspace while ensuring
the device display is off. Is there such an indication/do we know of
such a device?

The Ally and Legion Go which I tested happily had their display turn
on after I yanked their display on and sleep exit callbacks. The
Legion Go even had its suspend light blink while the screen was on.
And both had disabled controllers. This behavior was sticky even after
a reboot. I suppose this is due to the fact that the device might
hibernate, so the EC would have to remember the last state before
power off.

> The idea being that the first increase() call gets made when
> a drm/kms driver probes a display and finds outputs which are
> light up during probe() and then further increase / decrease
> calls are made either when all displays go off; or maybe
> per crtc when the crtc gets enabled / disabled.
>
> Anyways how best to do this at display off time should be
> discussed with the drm/kms community on the dri-devel list.

I can cc on the next version.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-expe=
riences/modern-standby-firmware-notifications#display-off-notification-func=
tion-3
[1]

Antheas

