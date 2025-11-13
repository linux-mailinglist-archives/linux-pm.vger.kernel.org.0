Return-Path: <linux-pm+bounces-37934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD160C56F82
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83AC24E6424
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43338334C17;
	Thu, 13 Nov 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKrbqIVy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178ED3321A4;
	Thu, 13 Nov 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030659; cv=none; b=UV1mxFiI+A13d1fqFZOVbAlZMojVbU0GkSnO7/AO8V0lBw0DtKdrXj+AZfnIIwRKHhEyXCWvpsPY0UBQ2Ixg9RWy9KffTbuYatWTkoCg1AkaGe5TDHQI/Nko2zdrxF4e6uN0Ak7wBJX74XiesYZ0SW0AMN23FF45Sc5JX60lFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030659; c=relaxed/simple;
	bh=doOu73A/baQQtoQbTZKLUlfNvk+R4uFSI7Dk3v8t5Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z201cMGNqjN4PnY/f6hag0uwd21uBRjAD7tS8zSvbLEd+vu3B2lGnvp6fMF/fl4e3IQLesG+G9J4HRYRMURPcb08ixY5NVjl41g2GQr8qMcWoKzQWx0Cf3RcPy9ETkMHWZgm01HmLGx7tfPMxkm4e23Iv1RRY6hDRnnhZ6EuanQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKrbqIVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E8C16AAE;
	Thu, 13 Nov 2025 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763030658;
	bh=doOu73A/baQQtoQbTZKLUlfNvk+R4uFSI7Dk3v8t5Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKrbqIVyrZQsVjcXoLQ5T0SDLiSw6nxnRtJp0jgyFRFFoWHpAUJx80Zd1awgQV3+0
	 Q+JmWtQhbFSVc0OhMGywKhRQvARBdYmHegCgJyW+c5yvGQFt8CAVrWrWAUnIT9e84m
	 LWmQ/fqfDFZrCwyiKpOCJEpMslwkk8HuZnPJYwp1ollO0v9hZlczQMbbAAFEtda+X6
	 FeHPn+CvKVVVX67zSExM+m+WZy2CpB8STsHakp8FMxS5D3GINEDl6cWPHO1QBfttdm
	 f5ROYsRzNmxzUVf1vjrF8liciQP+xVR65lKDcFCvlr8z1VykWXWE7YMpyGogQH6NVO
	 w/WAWKAbGwlzA==
Date: Thu, 13 Nov 2025 11:44:14 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] HID: Add support for multiple batteries per
 device
Message-ID: <em2u4ncbsu3ivwkiucthvqzhzbklu72eo3ovhshzy4m6iqiv4v@bvlk4w4ux2qh>
References: <20251113001508.713574-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113001508.713574-1-lzampier@redhat.com>

Hi Lucas,

On Nov 13 2025, Lucas Zampieri wrote:
> This RFC introduces support for multiple batteries per HID device, addressing
> a long-standing architectural limitation in the HID battery reporting subsystem.

(TBH, that cover letter screams AI :-P)

Stating a "long-standing architectural limitation" is a bit rough. The
need wasn't there or nobody took the time and effort to plug this hole
:)

General comment on this cover letter actually: it is way too detailed,
and try to iron out every corner case the AI bot thought would be fought
against.
Which leads to people actually nitpicking on the details below:
for example, I immediately thought the Wacom bit down below was wrong.

But really, all you need is multiple battery support on devices.
And this is fine. A couple of example would be good enough, and we can
move on.

> 
> ## Background
> 
> The current HID implementation explicitly prevents multiple batteries per device
> through an early return in hidinput_setup_battery() that enforces a single-battery
> assumption. Linux treats peripheral batteries (scope=Device) differently from system
> batteries, with desktop environments often displaying them separately or ignoring
> them entirely. However, this design doesn't account for modern multi-battery hardware patterns.
> 
> ## Problem Statement
> 
> Multiple battery scenarios that cannot be properly reported today:
> 
> 1. Gaming headsets with charging docks (e.g., SteelSeries Arctis Nova Pro
>    Wireless) - headset battery reported, dock battery invisible
> 2. Graphics tablets with stylus batteries (Wacom) - requires driver-specific
>    workarounds

Technically, most Wacom styluses are battery-less for their pencils. The
battery issue that was related below is for a AES device, which is an
integrated wacom tablet in a laptop, so the only battery we have is on
the stylus itself. Arguably we can have several styluses, but only one
can be used at the same time, so reusing the same power supply device is
fine.

(see, I told you, that's the "someone is wrong on the internet effect")

> 3. Wireless earbuds with per-earbud batteries plus charging case
> 4. Multi-device receivers (Logitech Unifying) - requires proprietary HID++
>    protocol parsing

That's an entire different reason why there is HID++, and the fact that
Solaar handles batteries itself is lack of support in the kernel for
some devices. (and because sometimes it's much simpler to update a user
space client than a kernel driver)

> 
> This forces manufacturers to use proprietary protocols and vendor-specific
> software. Community projects parse USB packets directly because standard HID
> battery reporting cannot handle multi-battery scenarios.

I don't think Linux ever forced any manufacturer to use proprietary
protocols or vendor-specific software. For Logitech (or any gaming mouse
FWIW), those protocols were in place well before Linux ever had support
for them.

> 
> ## Why This Matters
> 
> The current limitation creates a cycle: OS lacks support, so manufacturers
> implement proprietary protocols, which makes vendor software necessary, which
> reduces pressure to fix the OS limitation. Improving HID core support for
> multiple batteries would enable standardized reporting, reduce the need for
> vendor software, improve OS integration, reduce driver duplication, and provide
> a foundation for future multi-battery devices.

This is completely BS and AI generated. There is no such cycle.

But again, the need is there, so we need to push this series forward.
The packaging of the cover letter is wrong. We are not salesmen, there
is no need to pitch this like that.

> 
> ## Proposed Solution
> 
> This series introduces struct hid_battery to encapsulate individual battery
> state, refactors the code to use this structure internally, and adds support
> for multiple batteries tracked in a list within struct hid_device. Batteries
> are identified by report ID. The implementation maintains full backwards
> compatibility with existing single-battery code.

That paragraph is good. Keep it please :)

> 
> ## Testing
> 
> Tested with split keyboard hardware (Dactyl 5x6) using custom ZMK firmware
> that implements per-side HID battery reporting. Each battery (left and right
> keyboard halves) reports independently through the power supply interface with
> distinct report IDs (0x05 and 0x06).
> 
> Test firmware available on my personal fork at:
> https://github.com/zampierilucas/zmk/tree/feat/individual-hid-battery-reporting
> If this series gets merged, these changes will be proposed to upstream ZMK.
> 
> HID descriptor and recording captured with hid-recorder:
> 
> D: 0
> R: 162 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 05 07 75 08 95 01 81 03 05 07 15 00 25 01 19 00 29 67 75 01 95 68 81 02 c0 05 0c 09 01 a1 01 85 02 05 0c 15 00 26 ff 0f 19 00 2a ff 0f 75 10 95 06 81 00 c0 05 84 09 05 a1 01 05 85 85 05 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0 05 84 09 05 a1 01 05 85 85 06 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0
> N: ZMK Project Dactyl 5x6
> P: usb-0000:2d:00.3-4.2/input2
> I: 3 1d50 615e
> D: 0
> E: 0.000000 3 05 00 56
> E: 0.000977 3 05 00 56
> E: 1.490974 3 06 00 52
> E: 1.491958 3 06 00 52
> E: 6.492979 3 06 00 53
> E: 6.493962 3 06 00 53
> 
> The recording shows both batteries reporting with different charge levels
> (Report ID 05: 86%, Report ID 06: 82%-83%), demonstrating the multi-battery
> functionality. This can be used to verify UPower compatibility.

Same, please keep that testing note in future versions.

> 
> ## Future Work: Userspace Integration
> 
> As suggested by Bastien, semantic battery differentiation (e.g., "left
> earbud" vs "right earbud") requires userspace coordination, as HID
> reports typically lack role metadata.

The sad part is that HID can report a lot of things, but manufacturers
don't make a full use of it.

For example, in the split keyboard case, you could make use of the
Handedness NAry of the generic device Controls page (0x06) which can
help describing Left Hand (0x32) and Right Hand (0x33).

But the problem is more likely that no known manufacturer will follow
your lead on this, and the NAry code you put here will only be used by
your firmware.

For the bluetooth earbuds, the Logical collection Channel Left (0x161,
page Consumer Page 0x0c) and Channel Right (0x162, same page) could be
used.

> 
> This will require:
> 1. systemd/hwdb entries for device-specific battery role mappings
> 2. UPower updates to enumerate and group multi-battery devices
> 3. Desktop environment changes to display batteries with meaningful labels
> 
> This kernel infrastructure is a prerequisite for that userspace work.
> 
> ## Request for Comments
> 
> Is list-based storage appropriate or would another structure work better?

List based storage should be fine. We don't receive battery updates that
often, so if that is simpler for you, that's all right.

> Should we support usage-based identification in addition to report ID for
> devices using the same report ID?

If the question is:
- should we enforce each battery to have a different name, the answer is
	yes
- should we take the report ID as the battery identifier in the name:
	why not?
- should we make use of other collections to split up batteries: maybe.
	If you have a device which reports multiple batteries on the same
	report ID, then yes, we will need a way to split them.

But again, we are only theorically speaking here, so it's hard to
answer. I really wish we had an actual consumer device we could use as a
reference, not a custom firmware we can tune in any way we want.

> Is sequential naming (battery-N) sufficient
> or should batteries have semantic role identifiers like "main", "stylus", "dock"?

Semantic would be ideal, but at least having a unique identifier is a
requirement. That's more a question for the upower guys.

> 
> To HID maintainers (Jiri Kosina, Benjamin Tissoires): Does this belong in
> hid-input.c or should it be separate? 

hid-input.c seems fine to me. There are technically not a lot of
differences from the existing AFAICT, it's just that we iterate over a
list.

> Any concerns about the backwards
> compatibility approach? Meaning, should I have removed the whole
> dev->bat legacy mapping and use the new struct?

I'm not sure I follow that backwards compatibility. AFAIU that API is
kernel internal, so it should be easier to drop it entirely instead of
duplicating the data for no benefit.

> 
> To power supply maintainers (Sebastian Reichel): Any issues with multiple
> power_supply devices from a single HID device?

Not a power supply maintainer, but unless upower builds a graph of the
devices it sees, I don't see why this would be a problem.

> 
> Related commits:
> - c6838eeef2fb: HID: hid-input: occasionally report stylus battery
> - a608dc1c0639: HID: input: map battery system charging
> - fd2a9b29dc9c: HID: wacom: Remove AES power_supply after inactivity

What the point of those?

> 
> Community projects demonstrating the need:
> - HeadsetControl: https://github.com/Sapd/HeadsetControl
> - Solaar: https://github.com/pwr-Solaar/Solaar
> - OpenRazer: https://github.com/openrazer/openrazer
> 
> Lucas Zampieri (3):
>   HID: input: Introduce struct hid_battery
>   HID: input: Refactor battery code to use struct hid_battery
>   HID: input: Add support for multiple batteries per device
> 
> Changes in v2:
> - Split the monolithic v1 patch into three logical patches for easier review:
>   1. Introduce struct hid_battery (pure structure addition)
>   2. Refactor existing code to use the new structure (internal changes)
>   3. Add multi-battery support (new functionality)
> - Added detailed testing section with hardware specifics
> - Added hid-recorder output (dactyl-hid-recording.txt) demonstrating two-battery
>   HID descriptor for UPower validation
> - Added "Future Work: Userspace Integration" section addressing Bastien's feedback
>   about semantic battery differentiation
> - Added hardware examples with product links to commit messages (per Bastien's
>   suggestion)
> - No functional changes from v1, only improved patch organization and documentation
> 
>  drivers/hid/hid-core.c  |   4 +
>  drivers/hid/hid-input.c | 196 +++++++++++++++++++++++++++-------------
>  include/linux/hid.h     |  42 ++++++++-
>  3 files changed, 179 insertions(+), 63 deletions(-)
> 
> --
> 2.51.1
> 

And now after all of this bikeshedding, I can move on to the review of
the series.

Cheers,
Benjamin

