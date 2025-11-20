Return-Path: <linux-pm+bounces-38297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE08C73A48
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 12:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1170234A75F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F725306B05;
	Thu, 20 Nov 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frALlGhV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73BC1F5617;
	Thu, 20 Nov 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636714; cv=none; b=RIBbrEFEqtInaMQi+PREyC59xH4sgEZkmLOqAmKd9VSeqScu+v/A7nF972jb0yK2f8eHgKOJlBORdMLrq5x3j+h7BKQtS9QHBvHvfMBzHbnwnobHVj9wABL3TISn29Hu7EI079VBTMp6+FpB4b5cPXL7FGJYW7mVJWV7r9kphUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636714; c=relaxed/simple;
	bh=WxFz3CaShF8+qMN0ByNt5QB3ybTN7mXPoCqLHNOZu2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piqBtdsTwki9vCXXB6KyfjeHnp8K0sTl7N45vCbcA/1ce+ImEv/xQ0g7Ox9T/gRtY+t6eO//7aCbErPnK1CQtUmXvDC/FH0mVuknx/4iOd7/ErkR24Y6juBrAfebMH5b+R6YDpsm1lTzrLhJ7Mnm0sWckBi1AEaAsvWj+Z7CL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frALlGhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBB2C116D0;
	Thu, 20 Nov 2025 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763636713;
	bh=WxFz3CaShF8+qMN0ByNt5QB3ybTN7mXPoCqLHNOZu2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frALlGhVJUpEjJQT14ToMiz5vkACAqiEf4AWagA/6ISh7vOJ1mIJjUAzbHJ9+W7Ng
	 9FPasS1ewq3yMHFiFymv6V6WFTVkw6yVfA9+BSSvSzcDBN2eOo7/Q+AkMrPx42z0QG
	 MI9NheyuSELKQ2rkB0FKMQCtZ2PvRx9mINEsvMEVENprWIdFy7bOAxJ34IdiB0uniL
	 cMIRClQu5nYAbX6tPtxkAZMekqp0AC5xNwAos+9vB91DUTJu54jcerWC8JXXN+R+vo
	 m3TBbb+ajpoHiFNl8LhmOjiX7ARYK1u1dhh/+g1E35WkCb0RImzXFvXJMW3d+uRbz5
	 DxQuRKrETh1kw==
Date: Thu, 20 Nov 2025 12:05:08 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/1] HID: Add support for multiple batteries per device
Message-ID: <pr3w6zp5hoza27fncktfj3qx3wp2nhdglbx46fbfx6swm4772d@7hg7a6dxom7p>
References: <20251120105442.150508-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120105442.150508-1-lzampier@redhat.com>

On Nov 20 2025, Lucas Zampieri wrote:
> This series adds support for HID devices with multiple batteries.
> 
> Currently, the HID battery reporting subsystem only supports one battery per
> device. There are several devices with multiple batteries that would benefit
> from this support:
> - Gaming headsets with batteries in both the headset and charging dock
> - Wireless earbuds with per-earbud batteries plus charging case
> - Split keyboards with per-side batteries
> 
> ## Proposed Solution
> 
> This series introduces struct hid_battery to encapsulate individual battery
> state, replaces the old battery fields with a list-based approach, and adds
> support for multiple batteries tracked within struct hid_device. Batteries
> are identified by report ID. The implementation is fully backwards compatible
> with single-battery devices through a helper function.
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
> 
> ## Future Work: Userspace Integration
> 
> As suggested by Bastien, semantic battery differentiation (e.g., "left
> earbud" vs "right earbud") requires userspace coordination, as HID
> reports typically lack role metadata.
> 
> This will require:
> 1. systemd/hwdb entries for device-specific battery role mappings
> 2. UPower updates to enumerate and group multi-battery devices
> 3. Desktop environment changes to display batteries with meaningful labels
> 
> This kernel infrastructure is a prerequisite for that userspace work.
> 
> Lucas Zampieri (1):
>   HID: input: Add support for multiple batteries per device
> 
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> 
> Changes in v4:
> - Added missing hidinput_update_battery() stub in #else block for
>   CONFIG_HID_BATTERY_STRENGTH=n builds
> - Reported-by: kernel test robot <lkp@intel.com>
> - Closes: https://lore.kernel.org/oe-kbuild-all/202511201624.yUv4VtBv-lkp@intel.com/

I don't think you need to keep the formal tags here in changlogs of the
cover letter. A simple "as reported by kernel test robot
<lkp@intel.com>" should be sufficient (given that usually we end up
dropping the cover letter as we apply the patches only).

> 
> Changes in v3:
> - Squashed the three v2 patches into a single patch as suggested by
>   Benjamin

Sorry we didn't understood each other: I was asking you to squash
patches 1 and 2 only, and keep 3 separated. I was just complaining about
a blank header change. Separating the non functional changes from the
functional ones is important.

> - Removed all legacy dev->battery_* fields, using list-based storage only
> - Changed battery naming to include report ID: hid-{uniq}-battery-{report_id}
> - Converted battery memory management to devm_* for automatic cleanup

Haven't checked the code yet but that would require probably a separate
patch so we can bisect to it if anything breaks.

> - Updated hidinput_update_battery() to take struct hid_battery directly
> - Added hid_get_first_battery() helper for external driver compatibility
> - Updated hid-apple.c and hid-magicmouse.c to use new battery API
> - Simplified cover letter based on feedback

Heh, thanks :)

Cheers,
Benjamin

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
>  drivers/hid/hid-apple.c      |  10 +-
>  drivers/hid/hid-core.c       |   4 +
>  drivers/hid/hid-input-test.c |  39 ++++---
>  drivers/hid/hid-input.c      | 196 +++++++++++++++++++----------------
>  drivers/hid/hid-magicmouse.c |  10 +-
>  include/linux/hid.h          |  54 +++++++---
>  6 files changed, 187 insertions(+), 126 deletions(-)
> 
> 
> base-commit: 0678f5630429a5049d7663703b897e1bf8d13cd1
> -- 
> 2.51.0
> 

