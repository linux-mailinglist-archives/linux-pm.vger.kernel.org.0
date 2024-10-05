Return-Path: <linux-pm+bounces-15212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30BB99183A
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A994282B24
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E97156C73;
	Sat,  5 Oct 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gu2gOF6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46743155382
	for <linux-pm@vger.kernel.org>; Sat,  5 Oct 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145465; cv=none; b=iVt9QzkPBS+eBClRcyJMrScpoyxANKIRMPBHo89j21aJTtRgMrxc/HSNF2JZjN7SAsG4n8VPS69Q5Hq/xk1dc8CaFlauY8DQ6vTcnUVwfZKISOt+bMmBXGUvs4CQWww9+MX6KaMlz+2UvxQpt6Tre+fvK5Js4UDRjHpNYJ0NR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145465; c=relaxed/simple;
	bh=CeVoX48NXn1L/SFRpHDcpdd0HSdyqTIYT57DWi2WFLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pB2IKSg+YggslaFCWSAeo0VRvZo25QjNRNN8eUIbkT2WL5kRuY080JhU5Rxe7MhHN6U+vZL2rN3mWj9b4MNBn2gYBesrNvvLI0IPxKBbp+wHu4sPy+rWxTGYBfrem5mWcNERWgz1KPU8vVtJ/6OwkpY+kZNGRiyHXIb5oNy15/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gu2gOF6q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728145462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HySLp1gZrJOhtmnbvjvLrkEQ7EK5lPOt+awQiFCFWPc=;
	b=gu2gOF6q0FiP0qMPTRJAlXa61jxjsGFVdbVAGSSmWaRxXLKM6SDV3oA1WuJRc8XPpWIr3U
	6cMh0Rq2hvYu/AS+P7HGC/K5KfK+esw7+4V/kBmPMq9skcUGlo46nYF19NxUzkVFtJVzKN
	29hlKgPpQMffvcVLpn0LdkEkWXxVvyg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-rD5kZqWNNSGHq-pYB81I_A-1; Sat, 05 Oct 2024 12:24:18 -0400
X-MC-Unique: rD5kZqWNNSGHq-pYB81I_A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a7f3f191dso242347466b.3
        for <linux-pm@vger.kernel.org>; Sat, 05 Oct 2024 09:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728145457; x=1728750257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HySLp1gZrJOhtmnbvjvLrkEQ7EK5lPOt+awQiFCFWPc=;
        b=uJlTdgJ4R89UUuohJ5bKM/94P07q0xeBjcTHTFk10zlzdvwDvfKRtl1oOT5y9KUeqO
         pwA5EcYKt/uEG06gH10Ue8dKj/Ksne6iOd3W8qHDsb6fqALmkafG/dnRdLsHx3XUnCRX
         8Rtmc5hTUOIaQGsycl9NORqMeMUSpmlfjMhxhc0fDd6PygP/q99HvE2qfGbgaDCXQHLu
         u3EPHoXBedQU5cTVGPkOpl4ZraFHDL2290bcZN3SbvixZg2GulF9Enq+0BLI/h2eKO8b
         LiTVBdouKtOHdpHsDZOLf3nb/lVK/eQw2QBbuc7LSSLYnY0MxEEMcppRc60xYSmFF5z/
         veRg==
X-Gm-Message-State: AOJu0Yx34+GCZIwUwmGFvHYUnn+6S8dgGTETcadcE8jdOQPTNWm3Q2GO
	/0/lCBKy5yKljzH3+d/5bbx04R2gLWsDzFKFMKqff6R9UDpD7lESaAnsIa+nKhqzCe49POXazJF
	iaB5L5ulVCTRD/9Yz/UNHPrz0T+8S6j89m3G7Ruq5mlcTjQAmG5a2ro/O
X-Received: by 2002:a17:907:2681:b0:a8a:91d1:5262 with SMTP id a640c23a62f3a-a991bd71ddcmr720127066b.28.1728145457500;
        Sat, 05 Oct 2024 09:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIXwe6jRK6F5oUpBTo1GVkdjoj3AAvgE8smzJpoWOxZ3irTCSG4Ywm0zTP8GHmyJWLQii+/g==
X-Received: by 2002:a17:907:2681:b0:a8a:91d1:5262 with SMTP id a640c23a62f3a-a991bd71ddcmr720125066b.28.1728145457091;
        Sat, 05 Oct 2024 09:24:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a7cfcfcsm99426466b.143.2024.10.05.09.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 09:24:16 -0700 (PDT)
Message-ID: <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
Date: Sat, 5 Oct 2024 18:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
 <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
 <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Antheas,

On 5-Oct-24 5:10 PM, Antheas Kapenekakis wrote:
> Hi Hans,
> 
>> Thank you for your work on this and thank you for the comprehensive write-up
>> on how Windows does modern standby.
>>
>> First of all may I suggest that you take the above write-up, minus the ROG
>> Ally specific bits and turn this into a new documentation file under
>> Documentation/power ?  And also document at which point Linux currently
>> makes the various transitions.
> 
> I will try to move some of that documentation there, this is a great idea.
> 
>> And then in patches where you move the transitions, also update the docs
>> on what Linux does to match.
>>
>> I have read the discussion about tying the display on/off calls to CRTC state
>> and/or exposing a userspace knob for that. I think that this needs more
>> discussion / design work.
> 
> Yes, you are right. To become a knob this would require a much bigger
> discussion. I would also like to move Sleep calls as part of that. The
> Legion Go and OneXPlayer devices turn off their controllers as part of
> that and other modern standby devices limit their power envelope
> (perhaps the Legion Go too). I think the Sleep call is where most of
> the userspace usability will come from. Display On/Off is a bit of a
> NOOP on most devices.
> 
> As for the LSB0 enter and exit, I do not know where the correct place
> for those would be, and perhaps someone from Microsoft needs to be
> consulted on that. The documentation is very vague. However it is
> clear to me that they should be close to where they are right now, so
> they very likely do not need to move.
> 
> There is also the new _DSM intent to turn display on 9 call. Which
> meshes with the sleep call. That call is made before Sleep Exit, if
> the kernel knows that the wake-up will cause the display to turn on,
> to boost the thermal envelope of the device and help it wake up
> quicker. If the Sleep call is moved then we would also have to
> introduce that somewhere to avoid wake-up time regressions on devices
> that support it, which also raises the question of how would the
> kernel decide if an interrupt will cause the display to turn on before
> unfreezing userspace (bulk of resume) (or should it be done after
> unfreezing?).
> 
>> OTOH IMHO it would be good to take patches 1 - 3 . Certainly 1 + 2 would
>> be good to have. 3 is a bit unfortunate and not necessary with the current
>> special ROG Ally handling in the asus-wmi driver. It might be better to
>> just keep the quirks there.
> 
> From what I know Luke plans to remove that quirk ASAP due to new
> firmware. I would keep it around until this patch series merges
> personally and remove it as part of that.

Ack I replied to Luke to say something like that.

> As it will probably cause regressions if both are in place

I don't see how having both this patch-sets + the asus-wmi
quirks will cause regressions?  The suspend delay will be done
twice, but that is harmless. 

> and require manual intervention if
> either is not. I will also note that the quirk in asus-wmi calls the
> Display On/Off calls a second time and during the suspend sequence,
> which is not in any way proper.

AFAICT asus-wmi does not call the display on / off callbacks instead
it directly calls "\\_SB.PCI0.SBRG.EC0.CSEE" to control the power ?

> So if future devices need this kind of
> quirk, it really does not seem like a good idea to me to paper over
> their problems by calling the notifications a second time in random
> platform drivers. There is the question of where that quirk should be
> placed, that is true, but I IMO it should be a pm problem.
> 
> Perhaps not in the location where I put it though and perhaps it
> should be done with LSB0 callbacks instead. Although, being done this
> way allows for it to blend with the suspend sequence. Ideally, the
> Display Off delay would be blended with userspace going down such that
> if e.g., there is heavy userspace activity that requires ~2s to
> freeze, the quirk would add no delay. Instead, it would only add delay
> if userspace freezes quickly (less than .5s). Same can be said with
> Sleep Entry and beginning prepare_late, which blocks the EC interrupts
> (that would need a lot of investigation though).
> 
> On that note, it seems to me that the Ally has 2 bugs related to the
> _DSM calls 3 and 4. First bug is that Display On is gated on current
> firmware and only works when the USB subsystem is powered on.
> Allegedly, this is fixed on the upcoming firmware but it is not
> something I have verified personally. I will verify it in 10 days or
> so, if the new firmware does not fail QA I guess.
> 
> However, there is a second bug with Display Off in _DSM 4. The
> controller of the Ally needs time to power off, around 500ms.
> Otherwise it gets its power clipped and/or does not power off
> correctly. This causes the issues mentioned in the discussion and I
> have no indication that this is fixed with newer controller firmware.
> It is also my understanding that most of the testing of the new
> firmware happened with the asus-wmi quirk in place, which papers over
> that issue, so removing the quirk might be premature in any case.

Ok.

> We have currently released this patch series in Bazzite and I am happy
> to report that it completely fixes all controller related issues in
> the Ally devices and makes them behave exactly as they do in Windows,
> regardless of firmware and bug for bug.
> 
> So we will be keeping it around and extending it as appropriate to
> include the Sleep calls. I am reminded multiple times per week that
> the Ally has TDP suspend bugs, where if the user is playing a heavy
> game, the EC of the device tends to get stuck at 6W and fail to
> respond after waking the device. So moving calls 7, 8 is the natural
> next step in this investigation. I already have a draft patch on
> standby, that we plan to AB test soon.
> 
>> IMHO it would be good to submit a v2 of just patches 1 - 3 run through
>> checkpatch. Also the commit message of patch 3 should point to the existing
>> quirk code in asus-wmi.c and mention that then is no longer necessary after
>> patch 3, then we can discuss what is the best place for these quirks.
> 
> I did run it through before sending the patch. However, some of the
> warnings were a bit cryptic to me... I will run it again.
> 
> I will add a note for asus-wmi on future patch series.
> 
> First 3 patches of the series are designed to NOOP before patch 4. Did
> you mean patch 3 (which adds the delay) instead of 4?

Ah I misread the series and failed to notice that patch 4 actually hooks
things up, I was under the impression that patch 4 hooks things up.

But I did mean that patch 3 might lead to discussion not patch 4.

Now that I have taken a better look some more detailed review comments:

* Patches 1 and 2 should be squashed into a single patch IMHO.

* Patch 3 adds the quirks to kernel/power/suspend.c but this
really should be added to drivers/acpi/x86/s2idle.c and then do
the sleep as part of the display_off callback.

* Given my comment on patch 3 I would swap the order of patch 3 and 4
  and only add the quirks after moving the display off ACPI call to
  the new callback

* Patch 4 does too much in a single patch, specifically besides
actually implementing the new callbacks it also does s/SCREEN/DISPLAY
on all the ACPI_LPS0_* defines. This renaming of the defines must
be done in a separate patch.

Regards,

Hans



