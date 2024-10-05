Return-Path: <linux-pm+bounces-15211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A83F9917AB
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0876E1F2321D
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23FA153808;
	Sat,  5 Oct 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KSlll6dr"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24F14A4F7;
	Sat,  5 Oct 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728141455; cv=none; b=B+jyzFFWP+1ntx7+i3BdgfdWrt5mhQuOR50aIJQon1O0AnzFRT3JWXJhU+19P+zmtS1OiRK3bXfEuDX/AbXy+EmFD3MGDRW/o7fSpGChmrVP3SHslVnIJf/yC8MGIwP4p7kNxkMzdKOdd0Q68/VlhvKzSZLB6+txrEXrG0XkK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728141455; c=relaxed/simple;
	bh=F46QJweJpwtblB/d3dxmqP81hCu6fL+6vDSXaEx6az4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=So5oT7Mck1yhf1r4AcUlh8c1llHElrlDzi8vlSUwiXt+8zeONjXbj8TBPlQEkcX0hqrx5rKMmun7gnOt7QpzCXIeE2Jq4FYrp2m6Q+W0bANqGgxQ5diQHpi/cHeSd6DSjRGHxxgG4nYwoaabWaWmwAtjrasXLphuZWKvG+SWSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KSlll6dr; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D34C12E09620;
	Sat,  5 Oct 2024 18:10:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1728141043;
	bh=AKVF66IPPLpeZA9R5Ac/lxvgQd0ozQhAkuVPBicpkVc=;
	h=Received:From:Subject:To;
	b=KSlll6drxNj3PCbWt09Ob/F06tfmWxF9JMisqmcs2xpNZG7M65HPV7vAXX+fonR7g
	 RJszpWXAR61EoEe3iMZKRg+CryM+TYQRj3j6hG+2WYTPT36QKx9ZVGaqvMTaJawFbM
	 2VP1nuRdHxC4C6YN10owVQAcJ4vEJP9AIgrayyc4=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2fac187eef2so37224931fa.3;
        Sat, 05 Oct 2024 08:10:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWmuGBK1JkvWNaYpPfNXKTL2gYP9goXK+vGm1DSLsbCwnRCipSz61IpE82TNBRjnp8VFRd7Xd5WVcxTvcrxLh3GCicz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg07zMCmLu9Szk69U2+61dGNcxzoggbCIGkGFm0GhyMFz/Rr2o
	RIusP9gOf9mNYr6qZIV26hlnrOMl6uF9hgNAwMxb7+GOE01rpepEy+Ja8+rT0j1hmfTleJTJdVW
	w0TyTtZrhLsQ6lKT9ksTtt8WXI+M=
X-Google-Smtp-Source: 
 AGHT+IEEmRqIlPklw2+MnjE2G0R3mNqNNrTJJzFk5fOqWwAeosOHRNdMlSrCYsqwmuPG3+FfUg2O95m4W3qG2fathuU=
X-Received: by 2002:a2e:be9e:0:b0:2f9:cf71:363a with SMTP id
 38308e7fff4ca-2faf3c721a8mr32877851fa.23.1728141042013; Sat, 05 Oct 2024
 08:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
In-Reply-To: <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 5 Oct 2024 17:10:30 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
Message-ID: 
 <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
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
 <172814104320.27553.5827163530433698683@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Hans,

> Thank you for your work on this and thank you for the comprehensive write-up
> on how Windows does modern standby.
>
> First of all may I suggest that you take the above write-up, minus the ROG
> Ally specific bits and turn this into a new documentation file under
> Documentation/power ?  And also document at which point Linux currently
> makes the various transitions.

I will try to move some of that documentation there, this is a great idea.

> And then in patches where you move the transitions, also update the docs
> on what Linux does to match.
>
> I have read the discussion about tying the display on/off calls to CRTC state
> and/or exposing a userspace knob for that. I think that this needs more
> discussion / design work.

Yes, you are right. To become a knob this would require a much bigger
discussion. I would also like to move Sleep calls as part of that. The
Legion Go and OneXPlayer devices turn off their controllers as part of
that and other modern standby devices limit their power envelope
(perhaps the Legion Go too). I think the Sleep call is where most of
the userspace usability will come from. Display On/Off is a bit of a
NOOP on most devices.

As for the LSB0 enter and exit, I do not know where the correct place
for those would be, and perhaps someone from Microsoft needs to be
consulted on that. The documentation is very vague. However it is
clear to me that they should be close to where they are right now, so
they very likely do not need to move.

There is also the new _DSM intent to turn display on 9 call. Which
meshes with the sleep call. That call is made before Sleep Exit, if
the kernel knows that the wake-up will cause the display to turn on,
to boost the thermal envelope of the device and help it wake up
quicker. If the Sleep call is moved then we would also have to
introduce that somewhere to avoid wake-up time regressions on devices
that support it, which also raises the question of how would the
kernel decide if an interrupt will cause the display to turn on before
unfreezing userspace (bulk of resume) (or should it be done after
unfreezing?).

> OTOH IMHO it would be good to take patches 1 - 3 . Certainly 1 + 2 would
> be good to have. 3 is a bit unfortunate and not necessary with the current
> special ROG Ally handling in the asus-wmi driver. It might be better to
> just keep the quirks there.

From what I know Luke plans to remove that quirk ASAP due to new
firmware. I would keep it around until this patch series merges
personally and remove it as part of that. As it will probably cause
regressions if both are in place and require manual intervention if
either is not. I will also note that the quirk in asus-wmi calls the
Display On/Off calls a second time and during the suspend sequence,
which is not in any way proper. So if future devices need this kind of
quirk, it really does not seem like a good idea to me to paper over
their problems by calling the notifications a second time in random
platform drivers. There is the question of where that quirk should be
placed, that is true, but I IMO it should be a pm problem.

Perhaps not in the location where I put it though and perhaps it
should be done with LSB0 callbacks instead. Although, being done this
way allows for it to blend with the suspend sequence. Ideally, the
Display Off delay would be blended with userspace going down such that
if e.g., there is heavy userspace activity that requires ~2s to
freeze, the quirk would add no delay. Instead, it would only add delay
if userspace freezes quickly (less than .5s). Same can be said with
Sleep Entry and beginning prepare_late, which blocks the EC interrupts
(that would need a lot of investigation though).

On that note, it seems to me that the Ally has 2 bugs related to the
_DSM calls 3 and 4. First bug is that Display On is gated on current
firmware and only works when the USB subsystem is powered on.
Allegedly, this is fixed on the upcoming firmware but it is not
something I have verified personally. I will verify it in 10 days or
so, if the new firmware does not fail QA I guess.

However, there is a second bug with Display Off in _DSM 4. The
controller of the Ally needs time to power off, around 500ms.
Otherwise it gets its power clipped and/or does not power off
correctly. This causes the issues mentioned in the discussion and I
have no indication that this is fixed with newer controller firmware.
It is also my understanding that most of the testing of the new
firmware happened with the asus-wmi quirk in place, which papers over
that issue, so removing the quirk might be premature in any case.

We have currently released this patch series in Bazzite and I am happy
to report that it completely fixes all controller related issues in
the Ally devices and makes them behave exactly as they do in Windows,
regardless of firmware and bug for bug.

So we will be keeping it around and extending it as appropriate to
include the Sleep calls. I am reminded multiple times per week that
the Ally has TDP suspend bugs, where if the user is playing a heavy
game, the EC of the device tends to get stuck at 6W and fail to
respond after waking the device. So moving calls 7, 8 is the natural
next step in this investigation. I already have a draft patch on
standby, that we plan to AB test soon.

> IMHO it would be good to submit a v2 of just patches 1 - 3 run through
> checkpatch. Also the commit message of patch 3 should point to the existing
> quirk code in asus-wmi.c and mention that then is no longer necessary after
> patch 3, then we can discuss what is the best place for these quirks.

I did run it through before sending the patch. However, some of the
warnings were a bit cryptic to me... I will run it again.

I will add a note for asus-wmi on future patch series.

First 3 patches of the series are designed to NOOP before patch 4. Did
you mean patch 3 (which adds the delay) instead of 4?

> Rafael, what do you think about at least taking patches 1 - 3 upstream?
> Reading through how Windows handles things making the display on/off
> calls before suspending devices sounds like it is the right thing to do
> to me.

Antheas

