Return-Path: <linux-pm+bounces-15210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FFD99174B
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E0EB20D1D
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A81150994;
	Sat,  5 Oct 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St0WcgjS"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435B1B960
	for <linux-pm@vger.kernel.org>; Sat,  5 Oct 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138112; cv=none; b=mGbcnHb60QdQ+gsNUGq6hweYmPjuqT70P9fe8VurjdeyvzXRbS8DQ8pOtBb6a3O57+VLuD84kUaxMwQFN8OInI3CjKPODJnr7ea1QzOxYAX3WPsXAe3WrbNYiLHBvWMqfzWl/lV3MAKIJ5NrigxfT63OcfeArHGqWk/oRCyT+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138112; c=relaxed/simple;
	bh=x2MGenC9dWcWd4u6SMtCfuxLLZwMiAf5QnyZkcDNxOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4I4VLVyYV39IoeqbhFFBRPouSv1nt+XUrdqfU8W78nNuHpFPKrAGiV4ZT/qI7IZmj1ktZ/tosVdyIvtLbPsqFSDsigvFQqlw9QTH7jkMCd6Paqv2nFLMJXUdZ9A5xi7LXATHb/rNIHmxW+c2KvSA9GIsvYyob4FWsTvHFojxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=St0WcgjS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728138109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPqVbGCbjIr9a+NpG93NtbvFHaodkJKm5MMZCUHR91E=;
	b=St0WcgjSfkVPDvIdJB5WVAMksWQQ54YUUVmanOtOirQTwiWpJd6hABGZidwvX+PCgGIWGr
	VBCshNIORyxDWqBbWG4apVDSMn7YE0F0yrNtpnPzR0R/fgs70xnmSAo6nwXCL31Bkj2j6F
	AkFoUSgpaQGQFwpPk2gvqot1vqTgxGg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-yHWWOh3sPcG5EMe_48zBjw-1; Sat, 05 Oct 2024 10:21:48 -0400
X-MC-Unique: yHWWOh3sPcG5EMe_48zBjw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a84b60255so270218066b.1
        for <linux-pm@vger.kernel.org>; Sat, 05 Oct 2024 07:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728138107; x=1728742907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPqVbGCbjIr9a+NpG93NtbvFHaodkJKm5MMZCUHR91E=;
        b=CMowv+4oJMScO3L9msur1Ij9bzWb5WuQcg07U6lrelXPMOa3Ae/x0jKwOMIWAsTGCl
         ZBxTvgd3Q3Wv2OdTYw7oeS9jB86EIDKqez5QSpwTpERcsBCF9iSRGqJ1/7/rb9FPQFau
         TWRU+0HJiYxejsRPwgxFiQoTAGWkbhuMuNTPQtR4Tv4X/nRNQe7m7476ocO6rpao95P0
         RDoObToYEPSTKdfd9hj79S2URN0rJ7jqeYm8IiA4P38bI83HWWlLsAEcrxx2M0zneeQw
         x4I2GDnt52nhrRosrPPK3DpoUS4zhYFCRa9w+V6+OziXk7v3kRCedFs/yalkCZ/eBdI+
         K4ng==
X-Forwarded-Encrypted: i=1; AJvYcCVWg/XzbJke24xtiBj/bOFKaw2762fuiVgU9MlJb4NsbsgClO0Ojtx+spwDLQ6m6kU9oh1AzvY6+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY4Lhaz70U6416wFig44ieSnDNMCfWXftN8L6tdbb5xH+zSR+w
	8oqACYDqIxhZsyVJXLZBbtbopKYmS1+7ecJ+gtVXNrNiKy/hXOfsNTeOdalfjRpm80JqHri9ELB
	FKUk6dWYz2qBXwkFNLEq9MlOJEcpsq3myE8QIrhZZQJE10bqq2Bjhil/d
X-Received: by 2002:a17:907:9450:b0:a99:c0e:2430 with SMTP id a640c23a62f3a-a991bd09e85mr706342366b.19.1728138107407;
        Sat, 05 Oct 2024 07:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoYdKRdo11pz2X6Ms7neemVs+JqkPqonSaAcL4z9PvsulAS7sYtIxUjsT2/oPRvtZ2pZgEww==
X-Received: by 2002:a17:907:9450:b0:a99:c0e:2430 with SMTP id a640c23a62f3a-a991bd09e85mr706339366b.19.1728138106929;
        Sat, 05 Oct 2024 07:21:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993d927706sm81921266b.146.2024.10.05.07.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:21:45 -0700 (PDT)
Message-ID: <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
Date: Sat, 5 Oct 2024 16:21:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240922172258.48435-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-Sep-24 7:22 PM, Antheas Kapenekakis wrote:
> The following series moves the Display off/on calls outside of the suspend
> sequence, as they are performed in Windows. This fixes certain issues that appear
> in devices that use the calls and expect the kernel to be active during their
> call (especially in the case of the ROG Ally devices) and opens the possibility
> of implementing a "Screen Off" state in the future (which mirrors Windows).
> In addition, it adds a quirk table that will allow for adding delays between
> Modern Standby transitions, to help resolve racing conditions.
> 
> This series requires a bit of background on how modern standby works in Windows.
> Fundamentally, it is composed of four states: "Active", "Screen Off", "Sleep",
> and "DRIPS". Here, I take the liberty of naming the state "Active", as it is
> implied in Windows documentation.
> 
> When the user actively interacts with a device, it is in the "Active" state.
> The screen is on, all devices are connected, and desired software is running.
> The other 3 stages play a role once the user stops interacting with the device.
> This is triggered in two main ways: either by pressing the power button or by
> inactivity. Once either of those targets is met, the system enters Modern Standby.
> 
> Modern Standby consists of an orchestration of the "Screen Off", "Sleep", and
> "DRIPS" states. Windows is free to move throughout these states until the user
> interacts with the device again, where the device will transition to being
> "Active". Moving between the states implies a transition, where Windows performs
> a set of actions. In addition, Windows can only move between adjacent states
> as follows:
> 
> "Active" <-> "Screen Off" <-> "Sleep" <-> "DRIPS"
> 
> "Screen Off" is the state where all active displays in the device (whether
> *virtual* or real; this means unrelated to DRM) are off. The user might still
> be interacting with the device or running programs (e.g., compiling a kernel).
> 
> "Sleep" is a newer state, in which the device turns off its fan and pulses its
> power button, but still supports running software activities. As part of this,
> and to avoid overheating the device a lot of manufacturers lower the TDP (PLx)
> of the device [3; _DSM 9 description].
> 
> Finally, DRIPS stands for Deepest Runtime Idle Power State, i.e. suspend.
> 
> While Windows may transition from any state to any state, doing so implies
> performing all transitions to reach that state. All states other than DRIPS
> have a fully active kernel (Wifi, USB at least) and allow userspace activity.
> What changes is the extent of the activity, and whether some power consuming
> devices are turned off (this is done with Modern Standby aware drivers and
> firmware notifications). The Windows kernel suspends during the transition from
> the "Sleep" state to the "DRIPS" state. In all other states it is active.
> 
> After finishing each transition, the kernel performs a firmware notification,
> described in the _DSM document [3]. Moving from left to right with function num.,
> we have Display Off (3; Active -> Screen Off), Sleep Entry (7; Screen Off -> Sleep),
> and Lowest Power State Entry Notification (5; LPSEN; Sleep -> DRIPS). Then, from
> right to left, we have Lowest Power State Exit Notification (6; DRIPS -> Sleep),
> Sleep Exit (8; Sleep -> Screen) and Display On (4; Screen Off -> Active).
> 
> The Linux kernel is not currently Modern Standby aware but will still make these
> calls. Currently, the problem is that the kernel calls all of the firmware
> notifications at the point LPSEN (5, 6) should be called, which is when the
> kernel is mostly suspended. This is a clear deviation from Windows, and causes
> undesirable behavior in certain devices, the main one focused in this patch
> series being the ROG Ally. Although series patch is aimed at Modern Standby
> devices in general.
> 
> The ROG Ally is a Modern Standby capable device (uses Secure Core too; really
> ticks all the MS boxes) and in it, there are issues with both Display 3,4
> calls and Sleep 7,8 calls cause issues (7,8 are suspected and todo).
> 
> The Display 3,4 calls are responsible for the controller. The Display Off call
> disconnects (if powersave is off) or powers off (if powersave is on and on DC
> power) the MCU(s) responsible for the controller and deactivates the RGB of the
> device. Display On powers on or reconnects the controller respectively.
> This controller, in the Ally X, is composed of 6 HID devices that register to
> the kernel. From testing, it seems that the majority of the problem in the Ally
> comes from Display Off being called way too late timewise, and Display
> 
> The Sleep 7,8 calls, in general, are responsible for setting a low power state
> that is safe to use while the device is sleeping, making the suspend light
> pulse, and turning off the fan. Due to a variety of race conditions, there is
> a rare occasion where the Ally EC can get stuck in its Sleep mode, where the
> TDP is 5W, and prevent increasing it until the device reboots. The sleep entries
> contain actions in the Ally, so there is a suspicion that calling them during
> DRIPS is causing issues. However, this is not the subject of this patch and
> has not been verified yet.
> 
> This patch centers around moving the Display 3,4 calls outside the suspend
> sequence (which is the transition from Sleep to DRIPS in Modern Standby terms),
> and by implementing the proper locks necessary, opening up the possibility of
> making these calls as part of a more elaborate "Modern Standby"-like userspace
> suspend/wakelock implementation. As of this patch, they are only called before
> the suspend sequence, including with the possibility of adding a delay.
> 
> This makes the intent of this patch primarily compatibility focused, as it aims
> to fix issues by the current implementation. And to that end it works.
> After moving the calls outside of the suspend sequence, my ROG Ally X test unit
> can suspend more than 50 times without rebooting, both with powersave on or off,
> regardless of whether it is plugged/unplugged during suspend, and still have the
> controller work with full reliability. In V1, there was an unsolved race condition
> that was dealt by (5) before Display Off triggers. Essentially, Linux suspends
> too fast for the current version of the firmware to deal with. After adding a
> quirk table, which delays suspend after the Display Off call, the controller
> of the original Ally should power off properly (a lot of testing will be done).

Thank you for your work on this and thank you for the comprehensive write-up
on how Windows does modern standby.

First of all may I suggest that you take the above write-up, minus the ROG
Ally specific bits and turn this into a new documentation file under
Documentation/power ?  And also document at which point Linux currently
makes the various transitions.

And then in patches where you move the transitions, also update the docs
on what Linux does to match.

I have read the discussion about tying the display on/off calls to CRTC state
and/or exposing a userspace knob for that. I think that this needs more
discussion / design work.

OTOH IMHO it would be good to take patches 1 - 3 . Certainly 1 + 2 would
be good to have. 3 is a bit unfortunate and not necessary with the current
special ROG Ally handling in the asus-wmi driver. It might be better to
just keep the quirks there.

IMHO it would be good to submit a v2 of just patches 1 - 3 run through
checkpatch. Also the commit message of patch 3 should point to the existing
quirk code in asus-wmi.c and mention that then is no longer necessary after
patch 3, then we can discuss what is the best place for these quirks.

Rafael, what do you think about at least taking patches 1 - 3 upstream?
Reading through how Windows handles things making the display on/off
calls before suspending devices sounds like it is the right thing to do
to me.

Regards,

Hans



