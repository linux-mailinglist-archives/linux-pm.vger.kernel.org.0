Return-Path: <linux-pm+bounces-38300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C8C740D8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 13:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09B384E6BAE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1A337B8D;
	Thu, 20 Nov 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMihkJwo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A70337699;
	Thu, 20 Nov 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643379; cv=none; b=Ucmg7ZRKEfy+2Q7eJFRq/vahBe8jqnbS+/MGO1ZrQQKFY8dZkcqWAubnpJGU7NTnkMCTWDEm/4Aj/sQPmTD4GtYUT/jzgIEXl/we9Q9+FZzBj9Zeu4LN/EjCo41BWStnepdvODwUWt8/I+qKAi3aNZYOXDshBAkn2KJLJnce4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643379; c=relaxed/simple;
	bh=jkm+2/O2fv0YxoQqRRbJnf3LB1jc0nFx3ySZBS/Nrss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ5vDNsu0IKSyulSv9Cye4FvGIWIz8VOelzLrZzbax6RCCe/mWwFtVn6/18Oc8j9I4dpU5Gx/RL8pNv5OqjBsVTkBNEf5LK5iCMAoR3869BSOC6X5pYf9uWdjAYrsEnnL/ywxytqx+rQkz/Zpd9vd4EIN6KIXOtfXmi4k6HFGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMihkJwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C96DC4CEF1;
	Thu, 20 Nov 2025 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763643378;
	bh=jkm+2/O2fv0YxoQqRRbJnf3LB1jc0nFx3ySZBS/Nrss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMihkJwoUkTyVD1/Z2zHY5/D4Pl88PENok29V+fj7r+5t0flDidM3FbJKFzxP886Q
	 wM6jtdtkRNhU1VtePbX2rbRygaheDAJNGKpyiV59uEV+W5rGPJd+64Nj6aSvoTsatx
	 2jFWMBfof2+kueDy3QLTmksH3rOf64HTSpxPB1SZ1f+ZT5XcbtSaWUYX+FlP6zoeI9
	 DAPyBWHzP3dCZDm1gI8eyXuWI1A3ULdHUQmdzVuDPpClbmhxhkuAF9Jle5nNcmxhdb
	 7NfXMtVcSV8kAIgBM+6rWHKnrNlj0uU8Ucf2ZV+0aI6Oelu6EZcV9KIlGSBvuheKw0
	 sCM034al621Uw==
Date: Thu, 20 Nov 2025 13:56:14 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/1] HID: Add support for multiple batteries per device
Message-ID: <lgv3t6wlrg5t6tcrotwez3ashykfblikfvj7eayxdpdivfflmx@7uax54wnfnuq>
References: <20251120105442.150508-1-lzampier@redhat.com>
 <pr3w6zp5hoza27fncktfj3qx3wp2nhdglbx46fbfx6swm4772d@7hg7a6dxom7p>
 <CAOOg__BCM_s+Mm8e6NcwwVhQLyZ3z2iMwX1FOwC_7drNd8gEjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOg__BCM_s+Mm8e6NcwwVhQLyZ3z2iMwX1FOwC_7drNd8gEjg@mail.gmail.com>

On Nov 20 2025, Lucas Zampieri wrote:
> On Thu, Nov 20, 2025 at 11:05 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > On Nov 20 2025, Lucas Zampieri wrote:
> > > This series adds support for HID devices with multiple batteries.
> > >
> > > Currently, the HID battery reporting subsystem only supports one battery per
> > > device. There are several devices with multiple batteries that would benefit
> > > from this support:
> > > - Gaming headsets with batteries in both the headset and charging dock
> > > - Wireless earbuds with per-earbud batteries plus charging case
> > > - Split keyboards with per-side batteries
> > >
> > > ## Proposed Solution
> > >
> > > This series introduces struct hid_battery to encapsulate individual battery
> > > state, replaces the old battery fields with a list-based approach, and adds
> > > support for multiple batteries tracked within struct hid_device. Batteries
> > > are identified by report ID. The implementation is fully backwards compatible
> > > with single-battery devices through a helper function.
> > >
> > > ## Testing
> > >
> > > Tested with split keyboard hardware (Dactyl 5x6) using custom ZMK firmware
> > > that implements per-side HID battery reporting. Each battery (left and right
> > > keyboard halves) reports independently through the power supply interface with
> > > distinct report IDs (0x05 and 0x06).
> > >
> > > Test firmware available on my personal fork at:
> > > https://github.com/zampierilucas/zmk/tree/feat/individual-hid-battery-reporting
> > > If this series gets merged, these changes will be proposed to upstream ZMK.
> > >
> > > HID descriptor and recording captured with hid-recorder:
> > >
> > > D: 0
> > > R: 162 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 05 07 75 08 95 01 81 03 05 07 15 00 25 01 19 00 29 67 75 01 95 68 81 02 c0 05 0c 09 01 a1 01 85 02 05 0c 15 00 26 ff 0f 19 00 2a ff 0f 75 10 95 06 81 00 c0 05 84 09 05 a1 01 05 85 85 05 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0 05 84 09 05 a1 01 05 85 85 06 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0
> > > N: ZMK Project Dactyl 5x6
> > > P: usb-0000:2d:00.3-4.2/input2
> > > I: 3 1d50 615e
> > > D: 0
> > > E: 0.000000 3 05 00 56
> > > E: 0.000977 3 05 00 56
> > > E: 1.490974 3 06 00 52
> > > E: 1.491958 3 06 00 52
> > > E: 6.492979 3 06 00 53
> > > E: 6.493962 3 06 00 53
> > >
> > > The recording shows both batteries reporting with different charge levels
> > > (Report ID 05: 86%, Report ID 06: 82%-83%), demonstrating the multi-battery
> > > functionality. This can be used to verify UPower compatibility.
> > >
> > > ## Future Work: Userspace Integration
> > >
> > > As suggested by Bastien, semantic battery differentiation (e.g., "left
> > > earbud" vs "right earbud") requires userspace coordination, as HID
> > > reports typically lack role metadata.
> > >
> > > This will require:
> > > 1. systemd/hwdb entries for device-specific battery role mappings
> > > 2. UPower updates to enumerate and group multi-battery devices
> > > 3. Desktop environment changes to display batteries with meaningful labels
> > >
> > > This kernel infrastructure is a prerequisite for that userspace work.
> > >
> > > Lucas Zampieri (1):
> > >   HID: input: Add support for multiple batteries per device
> > >
> > > Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> > >
> > > Changes in v4:
> > > - Added missing hidinput_update_battery() stub in #else block for
> > >   CONFIG_HID_BATTERY_STRENGTH=n builds
> > > - Reported-by: kernel test robot <lkp@intel.com>
> > > - Closes: https://lore.kernel.org/oe-kbuild-all/202511201624.yUv4VtBv-lkp@intel.com/
> >
> > I don't think you need to keep the formal tags here in changlogs of the
> > cover letter. A simple "as reported by kernel test robot
> > <lkp@intel.com>" should be sufficient (given that usually we end up
> > dropping the cover letter as we apply the patches only).
> >
> > >
> > > Changes in v3:
> > > - Squashed the three v2 patches into a single patch as suggested by
> > >   Benjamin
> >
> > Sorry we didn't understood each other: I was asking you to squash
> > patches 1 and 2 only, and keep 3 separated. I was just complaining about
> > a blank header change. Separating the non functional changes from the
> > functional ones is important.
> >
> I get it, but the reason I made it one patch instead of two was to
> have one functional patch hid-multi-battery patch, instead of one just
> adding the structure, and then another one to really make use of the
> multi-battery stuff, but I guess I can make it two again, even tho the
> first one will have no real change in behavior

The first one is not just adding the structure, it's also a clean
refactor of the existing code where the battery information is nicely
regrouped into a single struct. And if that patch is all by itself, we
can again bisect it because we know it's not supposed to break anything
because there is no functional changes. So yes, no changes in bahavior
seems pointless but it is very important for your next patch so it's
reviewable.

> 
> > > - Removed all legacy dev->battery_* fields, using list-based storage only
> > > - Changed battery naming to include report ID: hid-{uniq}-battery-{report_id}
> > > - Converted battery memory management to devm_* for automatic cleanup
> >
> > Haven't checked the code yet but that would require probably a separate
> > patch so we can bisect to it if anything breaks.
> >
> I guess I kinda coded myself into a corner here, as with the new
> devm_* changes, I wrote the v4/v5 hid-multi-battery feature to be made
> for it, so I would have to go back to the v2 implementation (which is
> fine, its just that the new devm_* makes it much cleaner), and then
> have another patch converting the whole to use devm_*, which might as
> well be a separate series at that points so it's easier to
> review/test/bisect. Likewise, I'm fine with either approach, your
> call.

Up to you. I didn't mean necessarily to make the devm changes right now.

In an ideal world we would have:
- first patch which convert the existing code into devm
- second patch which introduces struct hid_battery
- third patch with the multi-battery feature.

But the order doesn't really matter (except 2 needs to come before 3).
The devm patch can be inserted anywhere. Having it first will simplify a
bit your 2 other patches, but having it last is also fine because we can
see the cleanup easily as well.

So if you want to postpone the devm patch, that's fine by me. But the
more you postpone it the higher the chances are that you forgot one kfree
or introduced a use-after-free, which means a lot more complications for
everybody :)

Cheers,
Benjamin

> 
> > > - Updated hidinput_update_battery() to take struct hid_battery directly
> > > - Added hid_get_first_battery() helper for external driver compatibility
> > > - Updated hid-apple.c and hid-magicmouse.c to use new battery API
> > > - Simplified cover letter based on feedback
> >
> > Heh, thanks :)
> >
> > Cheers,
> > Benjamin
> >
> > >
> > > Changes in v2:
> > > - Split the monolithic v1 patch into three logical patches for easier review:
> > >   1. Introduce struct hid_battery (pure structure addition)
> > >   2. Refactor existing code to use the new structure (internal changes)
> > >   3. Add multi-battery support (new functionality)
> > > - Added detailed testing section with hardware specifics
> > > - Added hid-recorder output (dactyl-hid-recording.txt) demonstrating two-battery
> > >   HID descriptor for UPower validation
> > > - Added "Future Work: Userspace Integration" section addressing Bastien's feedback
> > >   about semantic battery differentiation
> > > - Added hardware examples with product links to commit messages (per Bastien's
> > >   suggestion)
> > > - No functional changes from v1, only improved patch organization and documentation
> > >
> > >  drivers/hid/hid-apple.c      |  10 +-
> > >  drivers/hid/hid-core.c       |   4 +
> > >  drivers/hid/hid-input-test.c |  39 ++++---
> > >  drivers/hid/hid-input.c      | 196 +++++++++++++++++++----------------
> > >  drivers/hid/hid-magicmouse.c |  10 +-
> > >  include/linux/hid.h          |  54 +++++++---
> > >  6 files changed, 187 insertions(+), 126 deletions(-)
> > >
> > >
> > > base-commit: 0678f5630429a5049d7663703b897e1bf8d13cd1
> > > --
> > > 2.51.0
> > >
> >
> 

