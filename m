Return-Path: <linux-pm+bounces-33796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A55B43203
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C61BC7DEA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C724677F;
	Thu,  4 Sep 2025 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Oc2xHTLB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch [109.224.244.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F534245032
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966135; cv=none; b=YoNc56L2v7GgSkWvcPo1c+oEYnet6Y16fpgtac5AUeiy8kgwHv7GtCJwVXby/veR/A5auV4RQ8umnvozW2ulfAHgTJOa1Wjhszp7x+0kzl7YJFYNvrwK3V/85/yQxfb3TJl1RBeXG20FzbdPQz5UFplKCry+Df6XwVvi/vOczlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966135; c=relaxed/simple;
	bh=V8teur4SDWqDVTxFOydyor0bfXi/rLRSN4jnQG7/GxI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQakT8+GoPRHu/bt/l4y7N/4xu2o/AZhWtTGLzlpknAjqzHwHJmbAqhCqS+1x8lCY6T+ek9g8K3HEygX+1Ip/apZqaRFeSBWK4nbYQJf/ThecWwGLz0bcvQ3xXxyx63coOnqkPGygTjK+HHVYVDuL2V+uXpLmcexLy2Kpv5HNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Oc2xHTLB; arc=none smtp.client-ip=109.224.244.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1756966109; x=1757225309;
	bh=V8teur4SDWqDVTxFOydyor0bfXi/rLRSN4jnQG7/GxI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Oc2xHTLBeCZ2MIIXF0j8/3/XUFU1AIqEsqIyrlpaPBXMlEK80+qCzWetxVc9TVg3F
	 JWWEVD/DIxb659ALWe1qom90YbiCo1XMvSSDgS3hvMEzJ9n4Yh6Yuj0/GJEIXxRrYd
	 f4GjnUsO4C6YhVFRm3zdWZn/zXGXk3/Hq4I7oN0oT3qKjlv3BlJmpPRmdun2CqAYh4
	 bQ0ut9iJKekgLRcKJEkJl/scKZD+rae3NnA4LfLmVZ/APgwKATfQWTNjd0rDNicZgJ
	 K2ygWc4vjNhwNxjqP20QkYzbh63gp8aBET3D9+et03xMH7Opsz5F74KJarx9aYClxZ
	 0fDNODuINXrfw==
Date: Thu, 04 Sep 2025 06:08:25 +0000
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From: aprilgrimoire <aprilgrimoire@proton.me>
Subject: Fw: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted s2idle wakeups
Message-ID: <t_XcoJxQhVr8bLjSsy8n4-7hKzBhuOAXpr6hcNA42d8qLOl3sS2oqb1Nnj1ryIEYVuW5tKPVN1FXmZKrMO0aGDVAZTpYYZoXOrPUqzRgRRU=@proton.me>
In-Reply-To: <vVnKVxELkDdxFLiNbtGhT9X7GA_OV3Wk7q6YB_K4Qz3N8Dfp-MCcZqeobEP8dX-H4kjqKzYqyloahoaxB6ZEp8l9XgkIrD8S27Ertjwq324=@proton.me>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me> <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org> <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me> <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org> <vVnKVxELkDdxFLiNbtGhT9X7GA_OV3Wk7q6YB_K4Qz3N8Dfp-MCcZqeobEP8dX-H4kjqKzYqyloahoaxB6ZEp8l9XgkIrD8S27Ertjwq324=@proton.me>
Feedback-ID: 151975985:user:proton
X-Pm-Message-ID: 89fc801a994497da7fe8a45e7f28e3d4f958d847
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






Sent with Proton Mail secure email.

------- Forwarded Message -------
From: aprilgrimoire <aprilgrimoire@proton.me>
Date: On Thursday, September 4th, 2025 at 2:07 PM
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwante=
d s2idle wakeups
To: Mario Limonciello <superm1@kernel.org>


> > IRQ1 doesn't show up in this report, so this is not a problem with the
> > keyboard wakeup.
> >=20
> > There's a few things that stand out to me.
> >=20
> > 1) There are ACPI errors with the PEP _DSM; specificially the screen on
> > action. This isn't likely the cause of this issue but it's most
> > definitely a BIOS bug.
> >=20
> > ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ACDC.RTAC],
> > AE_NOT_FOUND (20250404/psargs-332)
> > ACPI Error: Aborting method \_SB.PEP.DSM due to previous error
> > (AE_NOT_FOUND) (20250404/psparse-529)
> > ACPI: \SB.PEP: Failed to transitioned to state screen on
> >=20
> > 2) The wakeup is from IRQ 7 (like you said) which is the GPIO controlle=
r.
> > PM: Triggering wakeup from IRQ 7
> > Woke up from IRQ 7 (IR-IO-APIC 7-fasteoi pinctrl_amd)
> >=20
> > The GPIO controller wakes up the system when any of the pins that are
> > marked as wake pins are triggered. In your case this is GPIO 0.
> > GPIO 0 is active: 0x38157800
> >=20
> > According to the SSDT _EVT handler this notifies the _PWRB ACPI object.
> >=20
> > Case (Zero)
> > {
> > M000 (0x3900)
> > Notify (\_SB.PWRB, 0x80) // Status Change
> > }
> >=20
> > We can see that notify happened here:
> > Dispatching Notify on [PWRB] (Device) Value 0x80 (Status Change)
> >=20
> > So based on above what it looks like is going on to me is that the lid
> > is likely indirectly tied to GPIO 0 in this design. It's not clear if
> > it's a mux, directly connected or if the EC drives that GPIO or what no=
t.
> >=20
> > It's worth noting that we did have a Linux kernel change to turn off
> > debounce for all GPIOs recently at suspend time [1]. You can see in
> > your log this message associated with it.
> >=20
> > Clearing debounce for GPIO #0 during suspend.
> >=20
> > I don't expect it's the cause of your issue, but you could try to rever=
t
> > it to confirm.
> >=20
> > Instead I think what's going on is that they have their design expectin=
g
> > that Windows does a "dark screen wakeup". This is where it exits a
> > hardware sleep state but doesn't fully wake the system. If no input
> > activity happens then it goes back to hardware sleep.
> >=20
> > This is something that common userspace (systemd on most systems)
> > doesn't support today.
> >=20
> > One option for you is to try to set this GPIO not to be a wake source b=
y
> > gpiolib_acpi.ignore_wake=3DAMDI0030:00@0.
> >=20
> > If this helps, please also check whether this breaks power button wakeu=
p
> > though. If it does we might be trading one wakeup source for another if
> > they're muxed.
> >=20
> > [1]
> > https://github.com/torvalds/linux/commit/8ff4fb276e2384a87ae7f65f3c28e1=
e139dbb3fe
>=20
>=20
> Hi, Mario!
>=20
> I tested clearing debounce, and it didn't make a difference.
>=20
> The gpiolib_acpi.ignore_wake option worked!
>=20
> It seemed that IRQ 1 is just a regular device, with wake up settable via =
udev. Even without the kernel modification, gpiolib_acpi.ignore_wake alone =
could stop the lid from waking the system up.
>=20
> It seems this quirk should not be applied here: The lid triggers two even=
ts, one from IRQ1 and another from IRQ7. The kernel cmdline option can disa=
ble the IRQ7 signal from waking the system up, and the IRQ1 event can be di=
sabled by either
>=20
> 1. Enabling the quirk
> 2. Setting ACTION=3D=3D"add", SUBSYSTEM=3D=3D"input", ATTR{name}=3D=3D"Li=
d Switch", ATTR{inhibited}=3D"1"
> in udev
>=20
> The problem is, the quirk also stops other on-laptop methods from waking =
the system up: builtin keyboard, builtin touchpad and power button, none of=
 those would work with the quirk enabled. With the udev workaround, the lid=
 event can be disabled, and I can still wake up with the builtin keyboard.
>=20
> Thanks!

