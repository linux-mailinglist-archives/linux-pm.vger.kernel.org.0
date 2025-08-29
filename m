Return-Path: <linux-pm+bounces-33424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7310B3C11D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F41C18986D8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B81C5F39;
	Fri, 29 Aug 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX0MBAoq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EBDC2EF
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485957; cv=none; b=iJtYIHtAFTPaefU1BHwhdepbiFI1kseEyf8nQpybhgClsWpU6734TL7n07Ra7yLdrA7ikIdRsjvmkA/GhCy+LV+Sg+UmGAxQ46v41dGU8RqF5uOQ9zKh9qY4FWlCZo2JK6Xw19c0cQVSh4SX9cfEaovUcXHCPjoFQNSXTbwOIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485957; c=relaxed/simple;
	bh=7aD8kZaIvCxauExQXYZOWutD96OKKArkr064wCLw96I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMRe1SxYqiTR5tyy+7Zl0q4a4FTrs/yeE0/UjRBixuxaMP4Npz52t9sQ2tb+VSvgodNa1HVR4vzGWByDdXMeT57R1asvoEgXYZ+bpHWAF7M1lwRgjBuwkEJ3V7qYSNky+k5URjS08nlLbiW6WOUgzzDsWRe/qUbZM9hSAu/gHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX0MBAoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D168C4AF0B
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485956;
	bh=7aD8kZaIvCxauExQXYZOWutD96OKKArkr064wCLw96I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CX0MBAoqW8XB4HG36fEM9kwtpXpojntlAZDoiIfYiXFh7W3QX+OlPDsKnTNvRhdou
	 Lni9AICQ7xNNfnszM+aHUKg0kAWf6n8wxnjBao+8A14EcZiK8tpQVfiZFh0JalBqSs
	 I4JJ6z54CiooFX2OyVZ7NscKCl2llMyCX31HdD8I4MIh8Mb+BHOrD4oY+jl1L53xIs
	 H1+g2Th9OXVSzXEbCeWl9JQ8hZw94Q7WWF2FlPXUc4pZPcQav2+5c3zuqudiNn5i5U
	 3RFPvRMyjRtiM7Q6S9oTTpxNEK6RKNefjp8/kNgfFD19z1G2WNykasOsjt3ggZ/bG+
	 7QQMDIoevqMPw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61e23ec2538so497597eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 09:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWX9HH3grQ+KSNJWYvwtEmehCV0C0CB71q1HYQyZUlj6GHiGyJN8InkCRMrM8bdYqduZLX5hnKQ4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzISwYRxw2dEqhqrrFg0W38iPdPRsXQOMmRIycDRUl3SMdny0vh
	HXfqc13UsWjA6JYis73j/SvmC08mwOmrlLmjruGNqrza0ePWjZAai2N1LEG30eoQRWO6UyJ8kWD
	RiWk55PgsFqsAYVk7VC41OrWt0WV0AMQ=
X-Google-Smtp-Source: AGHT+IFGAxuCf7CnoKtukLYq+2CCIgFhoRSBfSA1gTksMCArIth0ENa+76zKKe6Pe2/7lKJIzQJb6WAeIFEnR5cojOI=
X-Received: by 2002:a05:6820:1518:b0:61e:2ffb:e820 with SMTP id
 006d021491bc7-61e2ffbeac4mr139329eaf.4.1756485955745; Fri, 29 Aug 2025
 09:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com> <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
In-Reply-To: <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 18:45:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hC6GwuPSBgQYqNWu95YyR4yN4OiUWkJEd1wM6q9cS7Zg@mail.gmail.com>
X-Gm-Features: Ac12FXwLgsjA3ZmBRWrv5BYT8OhoTR4Ahmi_OjGAats0KT2tH7BpjFMT0FC7yFg
Message-ID: <CAJZ5v0hC6GwuPSBgQYqNWu95YyR4yN4OiUWkJEd1wM6q9cS7Zg@mail.gmail.com>
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU topology
To: Christian Loehle <christian.loehle@arm.com>
Cc: Kenneth Crudup <kenny@panix.com>, lukasz.luba@arm.com, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:31=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/28/25 18:42, Kenneth Crudup wrote:
> >
> >> So there's probably a problem here, but presumably your proposal break=
s the late boot
> >> (i.e. what this code was initially supposed to support).
> >
> > Please explain?
> >
> > It seems to me (and I really don't know, just guessing here) that if th=
ere were remaining errors from not getting any further CPU policies that th=
e loop would just run thru all CPUs "harmlessly".
>
> It would miss not-online-yet CPUs and never run again (potentially).
>
> >
> > Now perhaps to ensure the schedule_delayed_work() gets run, what about =
a flag that gets set if any CPU policy was accessed, and the schedule_delay=
ed_work() gets run if it's never set?
>
> Yeah that's the obvious immediate fix here, I've attached a patch for it.=
 (please test!)
> I wonder though, given that this works fine on my x86 nosmt hybrid (presu=
mably something like
> yours?) is this actually an issue for you?
> With intel_pstate=3Dpassive (and neutering a bunch of userspace stuff tha=
t insists on switching
> schedutil to something inferior) I get a working
> # cat /proc/sys/kernel/sched_energy_aware
> 1
>
> with all online CPUs having an EM (see /sys/kernel/debug/energy_model/ )
>
> > [snip]
>
> +CC
> Dietmar who has also played with this and reviewed the x86 EM part.

The message can be printed where it is printed now and failed_cpu can
be replaced with a counter, as far as I'm concerned.  Apart from this
it looks reasonable to me.

