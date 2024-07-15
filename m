Return-Path: <linux-pm+bounces-11082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F349A930D5F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 06:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1723C1C20E4B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 04:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946F4500D;
	Mon, 15 Jul 2024 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L74PKLs+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738D28FA;
	Mon, 15 Jul 2024 04:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018729; cv=none; b=bTWlKjB3NREWma4f4gOePc3JYsJIZ9nW7yLwe+G+H3KLqrJ/RSHb1GCSA6PbBt10ul4/CSK5l5nBxM97q3JdRw5LpPcUEH309d0pTAGtf53PEtYyu+H1+GtF2a+6GQE8b66omY1a14tXOsRZr0pIZNBtVGwAzw4UNiRImqvJmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018729; c=relaxed/simple;
	bh=dmwckEozZOxfYWPsH5K7q9jjZbrRCrhk5aZ3XiX2IEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXkhMuNLeQ73BWXnjteu+faiFTWZlSU+6U37n+5rmhT+uJFAfCqr3pR+0W6kcHlOcsIUIyGP62m32hG59LxhH2L4EQJuHdmKw//HvOIwqX+P3uzo4iFPzOrCxQVzDs0ZOOc110lO6L1d07gVE/2LI7YX5qw6UZY8azeaLRP29ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L74PKLs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E15AC4AF0A;
	Mon, 15 Jul 2024 04:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721018729;
	bh=dmwckEozZOxfYWPsH5K7q9jjZbrRCrhk5aZ3XiX2IEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L74PKLs+13hB9RUudNATkLyXhvd4KYwevczb3NDG0Q1O8NIRFlWZ68xTN+Xraaopi
	 MuGwV0QqOjMoWnwuYwuaJ04B/69+gb/8R8GDZUJG1v16s1CnjlvuPwEEjXGXpKO7nt
	 REMaA0drEFIEiu8FauRxrqzzsAX7PrRe+037b0sNeyUKBoZkkw9VtRrHQFi1WnLCZl
	 OFsoIsmReeugvrdHHb1Ks3prllMxY9gn1FHUXMw3z79XYo3t4ntYmL0jYF+Mkb64Cj
	 rnl71tun9pA0+nsmtrKhOTf2Qj8sP3zD6f8W+PMblZ2JPMgzEi1d4sWn0WltnwA/Yf
	 5SLtnJpoFo7vA==
Date: Sun, 14 Jul 2024 21:45:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
Message-ID: <20240715044527.GA1544@sol.localdomain>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6064157.lOV4Wx5bFT@rjwysocki.net>

Hello,

On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> if zone temperature is invalid") caused __thermal_zone_device_update()
> to return early if the current thermal zone temperature was invalid.
> 
> This was done to avoid running handle_thermal_trip() and governor
> callbacks in that case which led to confusion.  However, it went too
> far because monitor_thermal_zone() still needs to be called even when
> the zone temperature is invalid to ensure that it will be updated
> eventually in case thermal polling is enabled and the driver has no
> other means to notify the core of zone temperature changes (for example,
> it does not register an interrupt handler or ACPI notifier).
> 
> Also if the .set_trips() zone callback is expected to set up monitoring
> interrupts for a thermal zone, it needs to be provided with valid
> boundaries and that can only be done if the zone temperature is known.
> 
> Accordingly, to ensure that __thermal_zone_device_update() will
> run again after a failing zone temperature check, make it call
> monitor_thermal_zone() regardless of whether or not the zone
> temperature is valid and make the latter schedule a thermal zone
> temperature update if the zone temperature is invalid even if
> polling is not enabled for the thermal zone (however, if this
> continues to fail, give up after some time).
> 
> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org
> Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On v6.10 I'm seeing the following messages spammed to the kernel log endlessly,
and reverting this commit fixes it.

    [  156.410567] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  156.666583] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  156.922598] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  157.178613] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  157.434636] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  157.690774] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  157.946659] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  158.202717] thermal thermal_zone0: failed to read out thermal zone (-61)
    [  158.458697] thermal thermal_zone0: failed to read out thermal zone (-61)

/sys/class/thermal/thermal_zone0/type contains "iwlwifi_1".

- Eric

