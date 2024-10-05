Return-Path: <linux-pm+bounces-15215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EEF991896
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D9C282AB3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E9158853;
	Sat,  5 Oct 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jzLVOR2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514A1586F2;
	Sat,  5 Oct 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147473; cv=none; b=n7ryqizSokYySrfGuSrotT1aP/5c48kUcF6enb3Q/qM3Zg6x/29q1MODGshfAArDCQSh9yOgayDWkszlqgHMpa6pmbjXS4FowK+w/PTOngRhQosqR7i+7026J9nPOtUtEU0WP/Pp75Gb4XMA/tLzkTag0BJcHSgTB1+jGhCQ58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147473; c=relaxed/simple;
	bh=Jb0l6T5svSdAl19EbbsL2oeKIjfJCvfegyguF+bskFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipPpMYznDNS20yc+3vF0kaPGG34er6DD9wgaMGmQtBkU8+kfolNgGAlf3PUf8iZRrclCf1XjYWqrcEiXi7nO1D774yQa4iEyfOVPD/XYXg6Yh4YTa3qmZvnomUgIK80drfk4+bQVg+YcquW5XS2bgfvlORX7R0ykv5k5md5dAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jzLVOR2A; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 0E2112E0A737;
	Sat,  5 Oct 2024 19:57:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1728147468;
	bh=oaA6CMnnOKhlSxNvskSa44qEltk6R6eDMHCMGHbK8pY=;
	h=Received:From:Subject:To;
	b=jzLVOR2Af/PfVrk88kjcKcn076QChbiaLRjV00AfpcvTfRyYDeBR/Qm6PKALN78Bn
	 4FQE6ttjp4vCVkU1qgH27AQ4TvmIuBDTFIsUrYiq24wil746N3Lu3h6Y2k6GrKjON1
	 pJv96oB8NY7HnTn9Z37TxCs/vlxtZZWeY/P6fx58=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2fadb636abaso31092151fa.3;
        Sat, 05 Oct 2024 09:57:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXY9cTi3F+XuhXLfCK5ZRTeaIm7EVcNz/EvOfiWLDzMD/z6McX+aI94d0i/OCYqTPVOGY5mYrR/BUSCVVyDsETDOSRk@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSlOg9Apq8SU/qpKr70Ceor228yWvoHhyGv++aI6SLWMZCLoo
	dnU76YeAezXQ0Ae88GgkuVovnlqYQ3WD5Jl0aljCSWHJGxEkufOehA+f83GKNAWdl1biqd8IcUK
	a7S35hDYY7tcFd225WT6NL/hwvqQ=
X-Google-Smtp-Source: 
 AGHT+IEGZOgU6L0wmL59wzPa1HtDfCrriWVnJVBm3Lv4Uljgcrr0q6ehVvcv65oQqSo4NlUpnGihdz0dj4F1x5ehkVk=
X-Received: by 2002:a2e:b889:0:b0:2ef:29d4:3d97 with SMTP id
 38308e7fff4ca-2faf3c143aamr31010751fa.5.1728147467341; Sat, 05 Oct 2024
 09:57:47 -0700 (PDT)
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
In-Reply-To: <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 5 Oct 2024 18:57:36 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGBsoLy0GHeHH4i5asVy8cK=pL+cZcG2HqG+kFWX2Pyog@mail.gmail.com>
Message-ID: 
 <CAGwozwGBsoLy0GHeHH4i5asVy8cK=pL+cZcG2HqG+kFWX2Pyog@mail.gmail.com>
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
 <172814746843.27168.16189223917684957095@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 5 Oct 2024 at 18:24, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Antheas,
>
> On 5-Oct-24 5:10 PM, Antheas Kapenekakis wrote:
> > Hi Hans,
> >
> >> Thank you for your work on this and thank you for the comprehensive write-up
> >> on how Windows does modern standby.
> >>
> >> First of all may I suggest that you take the above write-up, minus the ROG
> >> Ally specific bits and turn this into a new documentation file under
> >> Documentation/power ?  And also document at which point Linux currently
> >> makes the various transitions.
> >
> > I will try to move some of that documentation there, this is a great idea.
> >
> >> And then in patches where you move the transitions, also update the docs
> >> on what Linux does to match.
> >>
> >> I have read the discussion about tying the display on/off calls to CRTC state
> >> and/or exposing a userspace knob for that. I think that this needs more
> >> discussion / design work.
> >
> > Yes, you are right. To become a knob this would require a much bigger
> > discussion. I would also like to move Sleep calls as part of that. The
> > Legion Go and OneXPlayer devices turn off their controllers as part of
> > that and other modern standby devices limit their power envelope
> > (perhaps the Legion Go too). I think the Sleep call is where most of
> > the userspace usability will come from. Display On/Off is a bit of a
> > NOOP on most devices.
> >
> > As for the LSB0 enter and exit, I do not know where the correct place
> > for those would be, and perhaps someone from Microsoft needs to be
> > consulted on that. The documentation is very vague. However it is
> > clear to me that they should be close to where they are right now, so
> > they very likely do not need to move.
> >
> > There is also the new _DSM intent to turn display on 9 call. Which
> > meshes with the sleep call. That call is made before Sleep Exit, if
> > the kernel knows that the wake-up will cause the display to turn on,
> > to boost the thermal envelope of the device and help it wake up
> > quicker. If the Sleep call is moved then we would also have to
> > introduce that somewhere to avoid wake-up time regressions on devices
> > that support it, which also raises the question of how would the
> > kernel decide if an interrupt will cause the display to turn on before
> > unfreezing userspace (bulk of resume) (or should it be done after
> > unfreezing?).
> >
> >> OTOH IMHO it would be good to take patches 1 - 3 . Certainly 1 + 2 would
> >> be good to have. 3 is a bit unfortunate and not necessary with the current
> >> special ROG Ally handling in the asus-wmi driver. It might be better to
> >> just keep the quirks there.
> >
> > From what I know Luke plans to remove that quirk ASAP due to new
> > firmware. I would keep it around until this patch series merges
> > personally and remove it as part of that.
>
> Ack I replied to Luke to say something like that.
>
> > As it will probably cause regressions if both are in place
>
> I don't see how having both this patch-sets + the asus-wmi
> quirks will cause regressions?  The suspend delay will be done
> twice, but that is harmless.

Probably it will be harmless, but I think the Display On being done
twice, and one of the times being inside the suspend sequence might
result in sub-optimal behavior. Well, the behavior that exists now.

> > and require manual intervention if
> > either is not. I will also note that the quirk in asus-wmi calls the
> > Display On/Off calls a second time and during the suspend sequence,
> > which is not in any way proper.
>
> AFAICT asus-wmi does not call the display on / off callbacks instead
> it directly calls "\\_SB.PCI0.SBRG.EC0.CSEE" to control the power ?

Refer to [1]. CSEE with B7, B8 is in fact the _DSM 3,4 Display On/Off
internal call. There is also a spurious Lid switch call on Display On
that does not exist and causes dmesg errors.

Link: https://github.com/hhd-dev/hwinfo/blob/21b7442219922233c41c0568995214ba92873f69/devices/ally_x/decoded/ssdt28.dsl#L841-L855
[1]

> > So if future devices need this kind of
> > quirk, it really does not seem like a good idea to me to paper over
> > their problems by calling the notifications a second time in random
> > platform drivers. There is the question of where that quirk should be
> > placed, that is true, but I IMO it should be a pm problem.
> >
> > Perhaps not in the location where I put it though and perhaps it
> > should be done with LSB0 callbacks instead. Although, being done this
> > way allows for it to blend with the suspend sequence. Ideally, the
> > Display Off delay would be blended with userspace going down such that
> > if e.g., there is heavy userspace activity that requires ~2s to
> > freeze, the quirk would add no delay. Instead, it would only add delay
> > if userspace freezes quickly (less than .5s). Same can be said with
> > Sleep Entry and beginning prepare_late, which blocks the EC interrupts
> > (that would need a lot of investigation though).
> >
> > On that note, it seems to me that the Ally has 2 bugs related to the
> > _DSM calls 3 and 4. First bug is that Display On is gated on current
> > firmware and only works when the USB subsystem is powered on.
> > Allegedly, this is fixed on the upcoming firmware but it is not
> > something I have verified personally. I will verify it in 10 days or
> > so, if the new firmware does not fail QA I guess.
> >
> > However, there is a second bug with Display Off in _DSM 4. The
> > controller of the Ally needs time to power off, around 500ms.
> > Otherwise it gets its power clipped and/or does not power off
> > correctly. This causes the issues mentioned in the discussion and I
> > have no indication that this is fixed with newer controller firmware.
> > It is also my understanding that most of the testing of the new
> > firmware happened with the asus-wmi quirk in place, which papers over
> > that issue, so removing the quirk might be premature in any case.
>
> Ok.
>
> > We have currently released this patch series in Bazzite and I am happy
> > to report that it completely fixes all controller related issues in
> > the Ally devices and makes them behave exactly as they do in Windows,
> > regardless of firmware and bug for bug.
> >
> > So we will be keeping it around and extending it as appropriate to
> > include the Sleep calls. I am reminded multiple times per week that
> > the Ally has TDP suspend bugs, where if the user is playing a heavy
> > game, the EC of the device tends to get stuck at 6W and fail to
> > respond after waking the device. So moving calls 7, 8 is the natural
> > next step in this investigation. I already have a draft patch on
> > standby, that we plan to AB test soon.
> >
> >> IMHO it would be good to submit a v2 of just patches 1 - 3 run through
> >> checkpatch. Also the commit message of patch 3 should point to the existing
> >> quirk code in asus-wmi.c and mention that then is no longer necessary after
> >> patch 3, then we can discuss what is the best place for these quirks.
> >
> > I did run it through before sending the patch. However, some of the
> > warnings were a bit cryptic to me... I will run it again.
> >
> > I will add a note for asus-wmi on future patch series.
> >
> > First 3 patches of the series are designed to NOOP before patch 4. Did
> > you mean patch 3 (which adds the delay) instead of 4?
>
> Ah I misread the series and failed to notice that patch 4 actually hooks
> things up, I was under the impression that patch 4 hooks things up.
>
> But I did mean that patch 3 might lead to discussion not patch 4.
>
> Now that I have taken a better look some more detailed review comments:
>
> * Patches 1 and 2 should be squashed into a single patch IMHO.
>
> * Patch 3 adds the quirks to kernel/power/suspend.c but this
> really should be added to drivers/acpi/x86/s2idle.c and then do
> the sleep as part of the display_off callback.
>
> * Given my comment on patch 3 I would swap the order of patch 3 and 4
>   and only add the quirks after moving the display off ACPI call to
>   the new callback
>
> * Patch 4 does too much in a single patch, specifically besides
> actually implementing the new callbacks it also does s/SCREEN/DISPLAY
> on all the ACPI_LPS0_* defines. This renaming of the defines must
> be done in a separate patch.

All are fair comments. I will fix them on the next revision.

On the Patch 3 comment, do you think there is merit with blending the
quirk with userspace freezing? Moving it inside LPS0 would make that
difficult, however at the same time 500ms for just the Ally (and
perhaps 2-3 other affected devices) is not something particularly
noticeable anyway.

Antheas

