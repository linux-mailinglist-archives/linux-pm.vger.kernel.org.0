Return-Path: <linux-pm+bounces-38089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CEBC61394
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF10E346B4B
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0E29CB4C;
	Sun, 16 Nov 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAUcib0Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTFzdkzg"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D3238C29
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293136; cv=none; b=cdIg8WpcSFC3ZuOb6c7UNA+sGd1uttf7PGJw8R9RRfEBJxkU1iSGDL4Q0urqCLFRr9PLZshTsB6uqipv2omAeLmx8ZEVWubo2xxHu9uw/0MiU/ZnN9ywKZOEQV4eETNWzZmTlYspIO8xH2ZXlBTzfNeU995lLntauf8s57HIYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293136; c=relaxed/simple;
	bh=Rkmp8nk9YPwAc1Krs/u7fCIQnRQEkc8AB4UPMFi8Ixo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paLXQGQkn4NUC8JOhDzZZT5VN0646E/gXQ2QpDlaAt9U6JPfrqYbWpLKLaicUw8aWyHJOVq8eFfVT0YoWmRBYvl6Uh0rKtBuLp/5LckoR6pYhDxFmeV2BvLUBdBYljRft0eFVOWk7qyyzPrI1OpBsGMeNsoQDFkGKjD5B2wNKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAUcib0Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTFzdkzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763293132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHkZ/fK1g8OIbwauzu6LXr6MNLKI40irhP6OOIOoypA=;
	b=AAUcib0Zvi7wJLzFzonlV5utZtXEGDvfBnkC9B0isc0tOL7q1Ym+R/8gqgQMtC8l05O8j4
	5DSUxUUdGCDbzBLJ7iwNmw3Ulw4Kq+uqqq//LCKCKl/Yqf2FOk0pq6851AgzrOJFk12aHS
	Mao1w60iASbLFBZ+HD4f35IFoY5c1D0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-Gd2EAgpXOBOhgPXWZVQPvw-1; Sun, 16 Nov 2025 06:38:50 -0500
X-MC-Unique: Gd2EAgpXOBOhgPXWZVQPvw-1
X-Mimecast-MFC-AGG-ID: Gd2EAgpXOBOhgPXWZVQPvw_1763293130
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso1845770f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 03:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763293129; x=1763897929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHkZ/fK1g8OIbwauzu6LXr6MNLKI40irhP6OOIOoypA=;
        b=TTFzdkzgR6hO7kU3h6XwZhzigq7igmVBdovnVnS9b3BjlAS6SttQLfREvRiDSEvdw+
         5ACeLITdJPxikYoSpLb+xtFhBDd7mQgr4NJxG4QF3HMRynM8u+KDtiAf6M6UoBCpK1iq
         JDjysXrpLNI/EGipe8iQvN90Ylg2ObD81HswRAcfpXTJPEXTVg4GFYLZprwv4GcEww/J
         MDoIRfhQSXtf/LoqCAx8X95dsx+5IUhEQtWLZdUf/7bs3fM8oyJxpz0Q1kbXAUCmD0gL
         oC6PnxHNnnS5GCL2XKZhwcXqqzBC36N+pyXCPs35JI6zEhbt+EE2R35xmzWVYIRfz9HD
         miGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763293129; x=1763897929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHkZ/fK1g8OIbwauzu6LXr6MNLKI40irhP6OOIOoypA=;
        b=V87US2Jtpy913CXQ2LlIdCU3CIUjdayienANfKGwzSV2Iu63bBCPOex2mxK7feo6t7
         TdM7VfDs3o16BPhS68lFqbRsjLXrmv3yC0uNI+xxp+gv0j/55Wb1r/NgHwABn0dFiJTq
         OUPFqUEfDjf/saSjVZYOyYs9a8fPk+xmeFRZYroByMp717Nf830758lxlRyswp7teYH9
         PXR0sjj58uvm6dd+Z5A7TrCSyhFiYEzCtW5ysUsUsvM2ytq4EYQj3VkzSc0VULG6C1LK
         GjR6timsUAY7yzy2pEZ0ojZf+H7HAXfhGeNUYil3SOsfSyCJ19Usj/a4/vwqTIL63Xgo
         hHhg==
X-Forwarded-Encrypted: i=1; AJvYcCV7TqaQ1Itg9OUQLrbTmFsLKQ/RkwFLVk7QarvjQhwVgIVk1XvDu2DBZzr001X8mvWZlJc9ZQHhIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySLV/vWN3DdgcnHKYhmERCZlm/iZtA2Eq9UmsfS+gmgpOIFoqy
	ue9iNkOEYNUil9/NqndHo+eKm/uyDIeew3OgBrBkYJAicW9610JOGHzM/aXEg5SXf/CfaeCpU2e
	JHbdNnTavkwcjE3NUOrsAE0vBkOWmSc3M3HE1ENlct0nXjn9GlbCCQsi3eKTkTNIr7Beoxap0Rv
	HGXCyHGq706Lff6tGByMRdwSm8UH5oDoFdIZd7jJS4mvw72Q==
X-Gm-Gg: ASbGncuWUyes2mPQsPYZ/0J+XFbZ9uVQC/E2DKtT21UzHk8pxlkMvXUYr3TPj9YVGqn
	CoI+NZp0mXY/8fV4ToWhxT24tLtwnHlLMbRJs4T+HVcgFrV4Ygv2nYdt0lcaZx5F81OKxj3OouI
	2R8YqYdchScKK8Hk+YGoxeFj5fYSPtH4LNbm/8IBSidCHs+a2bMXPol1QDFfuVWYB/kZCBbDkLm
	54DPGHckD3uObd080Pg9Vku2eT1
X-Received: by 2002:a05:6000:2083:b0:42b:3867:b39c with SMTP id ffacd0b85a97d-42b593745c4mr8417329f8f.34.1763293129156;
        Sun, 16 Nov 2025 03:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETOCFVzc8BB00Owfa1i3+3Q0yqDizEYCn3a3fdBPIaGMhwbfLsq30o1dTe4jzls1nYHL0VBK5XTZfUo48pK2E=
X-Received: by 2002:a05:6000:2083:b0:42b:3867:b39c with SMTP id
 ffacd0b85a97d-42b593745c4mr8417306f8f.34.1763293128622; Sun, 16 Nov 2025
 03:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113001508.713574-1-lzampier@redhat.com> <em2u4ncbsu3ivwkiucthvqzhzbklu72eo3ovhshzy4m6iqiv4v@bvlk4w4ux2qh>
In-Reply-To: <em2u4ncbsu3ivwkiucthvqzhzbklu72eo3ovhshzy4m6iqiv4v@bvlk4w4ux2qh>
From: Lucas Zampieri <lzampier@redhat.com>
Date: Sun, 16 Nov 2025 11:38:37 +0000
X-Gm-Features: AWmQ_bmpeG04rWxCoIFg1PQDQIsMKIhVz8Tcqr7b22vCvYHj9wwDUO3RrUwV1UA
Message-ID: <CAOOg__BCa3WC5xc5-Qiy9FS1umWN-yr-j+KG5k=qOf7ue68MoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] HID: Add support for multiple batteries per device
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Benjamin

On Thu, Nov 13, 2025 at 10:44=E2=80=AFAM Benjamin Tissoires <bentiss@kernel=
.org> wrote:
>
> Hi Lucas,
>
> On Nov 13 2025, Lucas Zampieri wrote:
> > This RFC introduces support for multiple batteries per HID device, addr=
essing
> > a long-standing architectural limitation in the HID battery reporting s=
ubsystem.
>
> (TBH, that cover letter screams AI :-P)
(partly yes, but also the cover letter kept growing and growing with
more things to point out/data to make this request seem sane)

>
> Stating a "long-standing architectural limitation" is a bit rough. The
> need wasn't there or nobody took the time and effort to plug this hole
> :)
>
> General comment on this cover letter actually: it is way too detailed,
> and try to iron out every corner case the AI bot thought would be fought
> against.
> Which leads to people actually nitpicking on the details below:
> for example, I immediately thought the Wacom bit down below was wrong.
>
> But really, all you need is multiple battery support on devices.
> And this is fine. A couple of example would be good enough, and we can
> move on.
>
Ack, will make it simpler and remove those many examples.

> >
> > ## Background
> >
> > The current HID implementation explicitly prevents multiple batteries p=
er device
> > through an early return in hidinput_setup_battery() that enforces a sin=
gle-battery
> > assumption. Linux treats peripheral batteries (scope=3DDevice) differen=
tly from system
> > batteries, with desktop environments often displaying them separately o=
r ignoring
> > them entirely. However, this design doesn't account for modern multi-ba=
ttery hardware patterns.
> >
> > ## Problem Statement
> >
> > Multiple battery scenarios that cannot be properly reported today:
> >
> > 1. Gaming headsets with charging docks (e.g., SteelSeries Arctis Nova P=
ro
> >    Wireless) - headset battery reported, dock battery invisible
> > 2. Graphics tablets with stylus batteries (Wacom) - requires driver-spe=
cific
> >    workarounds
>
> Technically, most Wacom styluses are battery-less for their pencils. The
> battery issue that was related below is for a AES device, which is an
> integrated wacom tablet in a laptop, so the only battery we have is on
> the stylus itself. Arguably we can have several styluses, but only one
> can be used at the same time, so reusing the same power supply device is
> fine.
>
> (see, I told you, that's the "someone is wrong on the internet effect")
>
oh okay, thats the only type of driver that I found did a similar
thing to what I'm proposing, but yeah I missed the part we most
styluses where battery-less.

> > 3. Wireless earbuds with per-earbud batteries plus charging case
> > 4. Multi-device receivers (Logitech Unifying) - requires proprietary HI=
D++
> >    protocol parsing
>
> That's an entire different reason why there is HID++, and the fact that
> Solaar handles batteries itself is lack of support in the kernel for
> some devices. (and because sometimes it's much simpler to update a user
> space client than a kernel driver)
>
I know I was picking an specific HID++ feature, over the many others
that it provides just to make a point.

> >
> > This forces manufacturers to use proprietary protocols and vendor-speci=
fic
> > software. Community projects parse USB packets directly because standar=
d HID
> > battery reporting cannot handle multi-battery scenarios.
>
> I don't think Linux ever forced any manufacturer to use proprietary
> protocols or vendor-specific software. For Logitech (or any gaming mouse
> FWIW), those protocols were in place well before Linux ever had support
> for them.
>
Yes, what I mean, it that there's no path to make the multi-battery
reporting native to Linux(Other than ofk you can report only the
lowest of the average of all batteries, but not individual batteries),
so I feel manufactures have no other option other than write their own
perfiferal-sw (eg, steelseries sonar, Logitech GHUB, etc.)(and sure,
many of those dont even work on linux, but then we are left
reverse-engineering protocols in Solaar, HeadsetControl and others).

> >
> > ## Why This Matters
> >
> > The current limitation creates a cycle: OS lacks support, so manufactur=
ers
> > implement proprietary protocols, which makes vendor software necessary,=
 which
> > reduces pressure to fix the OS limitation. Improving HID core support f=
or
> > multiple batteries would enable standardized reporting, reduce the need=
 for
> > vendor software, improve OS integration, reduce driver duplication, and=
 provide
> > a foundation for future multi-battery devices.
>
> This is completely BS and AI generated. There is no such cycle.
>
> But again, the need is there, so we need to push this series forward.
> The packaging of the cover letter is wrong. We are not salesmen, there
> is no need to pitch this like that.
>
Well, BS maybe, but completely human fabricated :p
And sure, I have no ground in reality for this supposition other than
inferring from the peripherals that I've seen. But my questions here
mostly is, why would manufactures spend time and money creating and
maintaining their custom protocols and accompanying desktop-software
if there was a native way? But I guess you got to the same conclusion
as I did, so then, I'll remove my suppositions, and only keep the real
world examples.

> >
> > ## Proposed Solution
> >
> > This series introduces struct hid_battery to encapsulate individual bat=
tery
> > state, refactors the code to use this structure internally, and adds su=
pport
> > for multiple batteries tracked in a list within struct hid_device. Batt=
eries
> > are identified by report ID. The implementation maintains full backward=
s
> > compatibility with existing single-battery code.
>
> That paragraph is good. Keep it please :)
>
> >
> > ## Testing
> >
> > Tested with split keyboard hardware (Dactyl 5x6) using custom ZMK firmw=
are
> > that implements per-side HID battery reporting. Each battery (left and =
right
> > keyboard halves) reports independently through the power supply interfa=
ce with
> > distinct report IDs (0x05 and 0x06).
> >
> > Test firmware available on my personal fork at:
> > https://github.com/zampierilucas/zmk/tree/feat/individual-hid-battery-r=
eporting
> > If this series gets merged, these changes will be proposed to upstream =
ZMK.
> >
> > HID descriptor and recording captured with hid-recorder:
> >
> > D: 0
> > R: 162 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 0=
8 81 02 05 07 75 08 95 01 81 03 05 07 15 00 25 01 19 00 29 67 75 01 95 68 8=
1 02 c0 05 0c 09 01 a1 01 85 02 05 0c 15 00 26 ff 0f 19 00 2a ff 0f 75 10 9=
5 06 81 00 c0 05 84 09 05 a1 01 05 85 85 05 09 44 15 00 25 01 35 00 45 01 7=
5 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0 05 84 0=
9 05 a1 01 05 85 85 06 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 6=
5 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0
> > N: ZMK Project Dactyl 5x6
> > P: usb-0000:2d:00.3-4.2/input2
> > I: 3 1d50 615e
> > D: 0
> > E: 0.000000 3 05 00 56
> > E: 0.000977 3 05 00 56
> > E: 1.490974 3 06 00 52
> > E: 1.491958 3 06 00 52
> > E: 6.492979 3 06 00 53
> > E: 6.493962 3 06 00 53
> >
> > The recording shows both batteries reporting with different charge leve=
ls
> > (Report ID 05: 86%, Report ID 06: 82%-83%), demonstrating the multi-bat=
tery
> > functionality. This can be used to verify UPower compatibility.
>
> Same, please keep that testing note in future versions.
>
> >
> > ## Future Work: Userspace Integration
> >
> > As suggested by Bastien, semantic battery differentiation (e.g., "left
> > earbud" vs "right earbud") requires userspace coordination, as HID
> > reports typically lack role metadata.
>
> The sad part is that HID can report a lot of things, but manufacturers
> don't make a full use of it.
>
> For example, in the split keyboard case, you could make use of the
> Handedness NAry of the generic device Controls page (0x06) which can
> help describing Left Hand (0x32) and Right Hand (0x33).
>
> But the problem is more likely that no known manufacturer will follow
> your lead on this, and the NAry code you put here will only be used by
> your firmware.
>
> For the bluetooth earbuds, the Logical collection Channel Left (0x161,
> page Consumer Page 0x0c) and Channel Right (0x162, same page) could be
> used.
>
> >
> > This will require:
> > 1. systemd/hwdb entries for device-specific battery role mappings
> > 2. UPower updates to enumerate and group multi-battery devices
> > 3. Desktop environment changes to display batteries with meaningful lab=
els
> >
> > This kernel infrastructure is a prerequisite for that userspace work.
> >
> > ## Request for Comments
> >
> > Is list-based storage appropriate or would another structure work bette=
r?
>
> List based storage should be fine. We don't receive battery updates that
> often, so if that is simpler for you, that's all right.
>
> > Should we support usage-based identification in addition to report ID f=
or
> > devices using the same report ID?
>
> If the question is:
> - should we enforce each battery to have a different name, the answer is
>         yes
> - should we take the report ID as the battery identifier in the name:
>         why not?
> - should we make use of other collections to split up batteries: maybe.
>         If you have a device which reports multiple batteries on the same
>         report ID, then yes, we will need a way to split them.
>
> But again, we are only theorically speaking here, so it's hard to
> answer. I really wish we had an actual consumer device we could use as a
> reference, not a custom firmware we can tune in any way we want.
>
yeah, but I guess we are also showing the way of how it could be
implemented in a future device,  so might as well stress the
theoretical aspect of it, so we can provide a well rounded api. For
now I'll work on a v3 with report ID, but I'm open to changing things
around if we come up with something better.

> > Is sequential naming (battery-N) sufficient
> > or should batteries have semantic role identifiers like "main", "stylus=
", "dock"?
>
> Semantic would be ideal, but at least having a unique identifier is a
> requirement. That's more a question for the upower guys.
>
> >
> > To HID maintainers (Jiri Kosina, Benjamin Tissoires): Does this belong =
in
> > hid-input.c or should it be separate?
>
> hid-input.c seems fine to me. There are technically not a lot of
> differences from the existing AFAICT, it's just that we iterate over a
> list.
>
> > Any concerns about the backwards
> > compatibility approach? Meaning, should I have removed the whole
> > dev->bat legacy mapping and use the new struct?
>
> I'm not sure I follow that backwards compatibility. AFAIU that API is
> kernel internal, so it should be easier to drop it entirely instead of
> duplicating the data for no benefit.
>
Got it, I was mostly worried that it was expected somewhere else, but
given your feedback, I'll make sure to have a proper new api without
so many edge case handling for a single device.

> >
> > To power supply maintainers (Sebastian Reichel): Any issues with multip=
le
> > power_supply devices from a single HID device?
>
> Not a power supply maintainer, but unless upower builds a graph of the
> devices it sees, I don't see why this would be a problem.
>
> >
> > Related commits:
> > - c6838eeef2fb: HID: hid-input: occasionally report stylus battery
> > - a608dc1c0639: HID: input: map battery system charging
> > - fd2a9b29dc9c: HID: wacom: Remove AES power_supply after inactivity
>
> What the point of those?
Mostly to say, "Hey I know it has been done there!", but I'll get rid
of those in v3 as its just noise.

>
> >
> > Community projects demonstrating the need:
> > - HeadsetControl: https://github.com/Sapd/HeadsetControl
> > - Solaar: https://github.com/pwr-Solaar/Solaar
> > - OpenRazer: https://github.com/openrazer/openrazer
> >
> > Lucas Zampieri (3):
> >   HID: input: Introduce struct hid_battery
> >   HID: input: Refactor battery code to use struct hid_battery
> >   HID: input: Add support for multiple batteries per device
> >
> > Changes in v2:
> > - Split the monolithic v1 patch into three logical patches for easier r=
eview:
> >   1. Introduce struct hid_battery (pure structure addition)
> >   2. Refactor existing code to use the new structure (internal changes)
> >   3. Add multi-battery support (new functionality)
> > - Added detailed testing section with hardware specifics
> > - Added hid-recorder output (dactyl-hid-recording.txt) demonstrating tw=
o-battery
> >   HID descriptor for UPower validation
> > - Added "Future Work: Userspace Integration" section addressing Bastien=
's feedback
> >   about semantic battery differentiation
> > - Added hardware examples with product links to commit messages (per Ba=
stien's
> >   suggestion)
> > - No functional changes from v1, only improved patch organization and d=
ocumentation
> >
> >  drivers/hid/hid-core.c  |   4 +
> >  drivers/hid/hid-input.c | 196 +++++++++++++++++++++++++++-------------
> >  include/linux/hid.h     |  42 ++++++++-
> >  3 files changed, 179 insertions(+), 63 deletions(-)
> >
> > --
> > 2.51.1
> >
>
> And now after all of this bikeshedding, I can move on to the review of
> the series.
>
> Cheers,
> Benjamin
>
Thank you for the bikeshedding, and sorry for such a long cover
letter, I just wanted to justify every aspect of what/why/how was
needed, and ended up with this monstruosity :D I'll clean this up for
v3 and make sure only what is relevant needed for this to the throught
is there.

Best,
Lucas Zampieri


