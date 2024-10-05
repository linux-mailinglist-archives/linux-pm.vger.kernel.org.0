Return-Path: <linux-pm+bounces-15219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD890991AF0
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 23:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791A6283CB0
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD7F165EEF;
	Sat,  5 Oct 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV8WQzKe"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4A156677
	for <linux-pm@vger.kernel.org>; Sat,  5 Oct 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164867; cv=none; b=pq0Kipw7pXHWTLeGNvN0iTXhP7MmFgBA3anT0ng71tOryyDjz3Mn0iH9GclD6nAVfZclPGKlcGIFua7ueZIZWX7071yOs6nUb4HESHuQPuGY70+zDovBeFvJRJfsoFmkPFmwDErB7LECWA1DMaNdZC1BA63z+cLP0yI2r6upacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164867; c=relaxed/simple;
	bh=NdWB6tkTfJQBTHuHMl/LqhuaodLimA7O/JaRYDI1rLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aMP37yva6YGUJQ1R7v/QpgzSLXGvf0OsSG6t6+djEizo3SWCzQkshvuEyrcS5rECQ/ZOQE28rTY48ffKlqlqOgSQgvcWVm9wFZmbI8sbHr/6k4OSuWVKWrKz7emsBTDZOELPLcgIePX3fc6y+9uq2uVZqkBLnPdcHi9hQMAJEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV8WQzKe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728164863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0NSJiR66+W771sdnOGv74U1sxc3iHB99ouGFHcVcZU=;
	b=bV8WQzKeO6qp2CRihT8b3KTfPZF1UtpUGYHK585tNGRrQAsIF7z/MNa8Z1yArcMY+gxsh7
	Zhw1gQD62UanNlXrrcI2SkffbaWBFcAf/OzQ1zzqMObzPZssYAkjHuc8MTSMd70XlnDgnD
	Cgu+0xPLdvm4Vy+NfzB1l/IDDnUe7UE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-nPILxdcyNSOdQL3ISUMNgQ-1; Sat, 05 Oct 2024 17:47:42 -0400
X-MC-Unique: nPILxdcyNSOdQL3ISUMNgQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a994d8d6004so395866b.2
        for <linux-pm@vger.kernel.org>; Sat, 05 Oct 2024 14:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728164861; x=1728769661;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0NSJiR66+W771sdnOGv74U1sxc3iHB99ouGFHcVcZU=;
        b=jzD3QyVAHKdDCaMNMqBcwXBTv0A1z3KUOLoTnaLJhYz2rAAY84CGq8UsR+9jAqfSPv
         ep24w+usrIrJ7eUzAyg4LDz2vuabDIVjlaTPxv3lI5+X6f5lRdijOni72yfzpaUxWNGs
         ZPne1T7tWDWYgclMm8RLFuTMHbMCf9cz2Xch38o6ugnNKWlBxfUwm2aLiNWviVqEhyiN
         C86csr1h9QiXuerarVe/++bX2kTBUSyGyCUxhETUO6sJvx5RGXVj46MQO1NmFLGuS56R
         GURlG311xXwlOGHq5uRfG77sfpnBOJfzp8AJQg9bNOW9DcB+mXeM2b/QxXQd1SB0g0ON
         JYZw==
X-Gm-Message-State: AOJu0Yw5LVZufbvHI2Ul44F7q8z3g6neEZi660/GhWiM11VCCkBDGUu9
	Q30y5rRBrHQF3um0knTKI2nv9xWw1UX6OJrzyWrAcu2mjNZUgzVT8LeuCJ/HLiC3xvUw+1EJfhr
	lriMHZmZEAwlijKTdW1gLmQ1/O0bfzU85WF8Hck9sMZV7Jq1f6Hi7YUxm
X-Received: by 2002:a17:907:6d10:b0:a99:4b63:f810 with SMTP id a640c23a62f3a-a994b6400d6mr48917966b.46.1728164860633;
        Sat, 05 Oct 2024 14:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ2nIqt2GW2qnkJIS/piJpH6dU7yov1f0/TF+eMzKyEOyYD3cwOf8O3sX7Dr71grfuaa8Srw==
X-Received: by 2002:a17:907:6d10:b0:a99:4b63:f810 with SMTP id a640c23a62f3a-a994b6400d6mr48916266b.46.1728164860134;
        Sat, 05 Oct 2024 14:47:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9945cdcc60sm54460366b.28.2024.10.05.14.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 14:47:39 -0700 (PDT)
Message-ID: <ede128c0-46e7-4c94-ac7f-39db0efa612d@redhat.com>
Date: Sat, 5 Oct 2024 23:47:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
From: Hans de Goede <hdegoede@redhat.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
 <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
 <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
 <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Antheas,

On 5-Oct-24 6:24 PM, Hans de Goede wrote:
> Hi Antheas,
> 
> On 5-Oct-24 5:10 PM, Antheas Kapenekakis wrote:
>> Hi Hans,
>>
>>> Thank you for your work on this and thank you for the comprehensive write-up
>>> on how Windows does modern standby.
>>>
>>> First of all may I suggest that you take the above write-up, minus the ROG
>>> Ally specific bits and turn this into a new documentation file under
>>> Documentation/power ?  And also document at which point Linux currently
>>> makes the various transitions.
>>
>> I will try to move some of that documentation there, this is a great idea.
>>
>>> And then in patches where you move the transitions, also update the docs
>>> on what Linux does to match.
>>>
>>> I have read the discussion about tying the display on/off calls to CRTC state
>>> and/or exposing a userspace knob for that. I think that this needs more
>>> discussion / design work.
>>
>> Yes, you are right. To become a knob this would require a much bigger
>> discussion. I would also like to move Sleep calls as part of that. The
>> Legion Go and OneXPlayer devices turn off their controllers as part of
>> that and other modern standby devices limit their power envelope
>> (perhaps the Legion Go too). I think the Sleep call is where most of
>> the userspace usability will come from. Display On/Off is a bit of a
>> NOOP on most devices.
>>
>> As for the LSB0 enter and exit, I do not know where the correct place
>> for those would be, and perhaps someone from Microsoft needs to be
>> consulted on that. The documentation is very vague. However it is
>> clear to me that they should be close to where they are right now, so
>> they very likely do not need to move.
>>
>> There is also the new _DSM intent to turn display on 9 call. Which
>> meshes with the sleep call. That call is made before Sleep Exit, if
>> the kernel knows that the wake-up will cause the display to turn on,
>> to boost the thermal envelope of the device and help it wake up
>> quicker. If the Sleep call is moved then we would also have to
>> introduce that somewhere to avoid wake-up time regressions on devices
>> that support it, which also raises the question of how would the
>> kernel decide if an interrupt will cause the display to turn on before
>> unfreezing userspace (bulk of resume) (or should it be done after
>> unfreezing?).
>>
>>> OTOH IMHO it would be good to take patches 1 - 3 . Certainly 1 + 2 would
>>> be good to have. 3 is a bit unfortunate and not necessary with the current
>>> special ROG Ally handling in the asus-wmi driver. It might be better to
>>> just keep the quirks there.
>>
>> From what I know Luke plans to remove that quirk ASAP due to new
>> firmware. I would keep it around until this patch series merges
>> personally and remove it as part of that.
> 
> Ack I replied to Luke to say something like that.
> 
>> As it will probably cause regressions if both are in place
> 
> I don't see how having both this patch-sets + the asus-wmi
> quirks will cause regressions?  The suspend delay will be done
> twice, but that is harmless. 
> 
>> and require manual intervention if
>> either is not. I will also note that the quirk in asus-wmi calls the
>> Display On/Off calls a second time and during the suspend sequence,
>> which is not in any way proper.
> 
> AFAICT asus-wmi does not call the display on / off callbacks instead
> it directly calls "\\_SB.PCI0.SBRG.EC0.CSEE" to control the power ?
> 
>> So if future devices need this kind of
>> quirk, it really does not seem like a good idea to me to paper over
>> their problems by calling the notifications a second time in random
>> platform drivers. There is the question of where that quirk should be
>> placed, that is true, but I IMO it should be a pm problem.
>>
>> Perhaps not in the location where I put it though and perhaps it
>> should be done with LSB0 callbacks instead. Although, being done this
>> way allows for it to blend with the suspend sequence. Ideally, the
>> Display Off delay would be blended with userspace going down such that
>> if e.g., there is heavy userspace activity that requires ~2s to
>> freeze, the quirk would add no delay. Instead, it would only add delay
>> if userspace freezes quickly (less than .5s). Same can be said with
>> Sleep Entry and beginning prepare_late, which blocks the EC interrupts
>> (that would need a lot of investigation though).
>>
>> On that note, it seems to me that the Ally has 2 bugs related to the
>> _DSM calls 3 and 4. First bug is that Display On is gated on current
>> firmware and only works when the USB subsystem is powered on.
>> Allegedly, this is fixed on the upcoming firmware but it is not
>> something I have verified personally. I will verify it in 10 days or
>> so, if the new firmware does not fail QA I guess.
>>
>> However, there is a second bug with Display Off in _DSM 4. The
>> controller of the Ally needs time to power off, around 500ms.
>> Otherwise it gets its power clipped and/or does not power off
>> correctly. This causes the issues mentioned in the discussion and I
>> have no indication that this is fixed with newer controller firmware.
>> It is also my understanding that most of the testing of the new
>> firmware happened with the asus-wmi quirk in place, which papers over
>> that issue, so removing the quirk might be premature in any case.
> 
> Ok.
> 
>> We have currently released this patch series in Bazzite and I am happy
>> to report that it completely fixes all controller related issues in
>> the Ally devices and makes them behave exactly as they do in Windows,
>> regardless of firmware and bug for bug.
>>
>> So we will be keeping it around and extending it as appropriate to
>> include the Sleep calls. I am reminded multiple times per week that
>> the Ally has TDP suspend bugs, where if the user is playing a heavy
>> game, the EC of the device tends to get stuck at 6W and fail to
>> respond after waking the device. So moving calls 7, 8 is the natural
>> next step in this investigation. I already have a draft patch on
>> standby, that we plan to AB test soon.
>>
>>> IMHO it would be good to submit a v2 of just patches 1 - 3 run through
>>> checkpatch. Also the commit message of patch 3 should point to the existing
>>> quirk code in asus-wmi.c and mention that then is no longer necessary after
>>> patch 3, then we can discuss what is the best place for these quirks.
>>
>> I did run it through before sending the patch. However, some of the
>> warnings were a bit cryptic to me... I will run it again.
>>
>> I will add a note for asus-wmi on future patch series.
>>
>> First 3 patches of the series are designed to NOOP before patch 4. Did
>> you mean patch 3 (which adds the delay) instead of 4?
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

Thinking some more about this I am having second doubts about
moving the LPS0 display power off call to before devices are suspended,
doing so would mean that the display might still be on when that call
is made and that call could disable power-resources which are necessary
for the display causing issues when the display driver's suspend method
runs.

So I think that we need something closer to Mario's POC from:

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/dsm-screen-on-off

here where the call is made when the last display is turned off.

IOW have the drm modesetting core call this.

Maybe have something like a enabled_displays counter in the
drm-core which gets increased / decreased by helpers and
have the drm-core call platform_suspend_screen_off() /
platform_suspend_screen_on() when the counter goes from 1 -> 0
resp. 0 -> 1, ignoring the very first 0 -> 1 transition
which will be done when the first GPU with an enabled
output is found ?

The idea being that the first increase() call gets made when
a drm/kms driver probes a display and finds outputs which are
light up during probe() and then further increase / decrease
calls are made either when all displays go off; or maybe
per crtc when the crtc gets enabled / disabled.

Anyways how best to do this at display off time should be
discussed with the drm/kms community on the dri-devel list.

Regards,

Hans










