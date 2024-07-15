Return-Path: <linux-pm+bounces-11095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F97931295
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BF0284A03
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61C188CB3;
	Mon, 15 Jul 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX+E3/J7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494B27442;
	Mon, 15 Jul 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040593; cv=none; b=CicTwSaxN1R7Vx4k1pQiKPR6x2zg4oy0z2LHSZEiBfbmD2RgeasqTXJFkb8+MjhEoCtHw/JChx7AIS6JfL+D4AiJ67CABlZ8ive7oHgwIlFghtPklZxfRpPBFCClIEtgKButqAd1+OdNCQ9Dyznc0iIK4WfAvKBARWvHQf3bHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040593; c=relaxed/simple;
	bh=amKKRYb4jsp8lDpavdYRf12yBGwl8BweWaMm5bRY83E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulfZwAYvk8vWwrGYiGJVhjepIc7mjLtqN5ayZjydIiXfv2mkk/oCNGI1eKFICn/wZVZ9UpsiHG2m6/A8syoN6HUQFIIQbBWHyMITNXmXIoKZ9nE52z7xXVepaVS6OG/a7MCnHfBjsZtIN5Ortzyhf5ZQHkea3Pp+dipikBqLmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX+E3/J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512E1C4AF0B;
	Mon, 15 Jul 2024 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721040593;
	bh=amKKRYb4jsp8lDpavdYRf12yBGwl8BweWaMm5bRY83E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qX+E3/J7nW6Q+BINa3vu9IOsh7zHd6W7Qe9bTz29dyqVn6r9oOvzKUNbxK2FxYu0K
	 4+Q4ciUCzAlYr3DeGSh6Qrctpm3NYf2a8G0CeKd0CU1CqEwY4mT0p8CGJRix52X/2x
	 t9JgAFQtKSu3pCzt+Fe6QpjqyAXEOoem7/WbXCOWaJI6EFu0IPQEqUQC7qeF6GcpWl
	 +p80MPvemc6fqDs++qJqcOHQXT8v45XFfLWfJfXHpSxNrg8GXRFxUrNbBMSURr3LCS
	 zGPTKSWSQNn2IuKffl58X8TGKf8DnobJGmJNYvU1fsRTWnL/HW1SY79PlGN8PAChg7
	 +flaVfRomqynQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3dab33691f4so169620b6e.1;
        Mon, 15 Jul 2024 03:49:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQpvD6KqW6VsBkNEisAd00Fk/CUXYcVgVLSSiZH0fisHHGB2tWl/zFgq500GnceNCcyAI2EH1/s/dEQG/1q1oDqvB5w25yUdooA7IxFIVOf5e2bcLrBfQUrnzQc7Qt5eDDC8J9oGE=
X-Gm-Message-State: AOJu0YzZ1DltiIlMaZufDKfJm3njPwCgkW4HsXcROaKxn/nlilyjw/o7
	O0/3gET7aU8qMfS9qbSmjKvXUh1WYp/sT7qEKwcehyoBS9CZgM1qzpHklrjjKz+mHRy4YUut0W0
	caQVUNg0AHrG0ctpZHAVLrQ/obWU=
X-Google-Smtp-Source: AGHT+IG3f0u0YC6jT9gT2iSqaBriX8edgd/p0OE9FDVXSSL8n07LQl+0yRtrbcFwx5uiuZmWoBwN55m4HWXtRMDTDrg=
X-Received: by 2002:a05:6820:2c05:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5c7b58743aemr10866287eaf.1.1721040592635; Mon, 15 Jul 2024
 03:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240715044527.GA1544@sol.localdomain>
In-Reply-To: <20240715044527.GA1544@sol.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 12:49:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGig2=Rr29Mdq8VZVZmTT7eZN12MJ0O9-R4y1jdaV1sA@mail.gmail.com>
Message-ID: <CAJZ5v0iGig2=Rr29Mdq8VZVZmTT7eZN12MJ0O9-R4y1jdaV1sA@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 6:45=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Hello,
>
> On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> > if zone temperature is invalid") caused __thermal_zone_device_update()
> > to return early if the current thermal zone temperature was invalid.
> >
> > This was done to avoid running handle_thermal_trip() and governor
> > callbacks in that case which led to confusion.  However, it went too
> > far because monitor_thermal_zone() still needs to be called even when
> > the zone temperature is invalid to ensure that it will be updated
> > eventually in case thermal polling is enabled and the driver has no
> > other means to notify the core of zone temperature changes (for example=
,
> > it does not register an interrupt handler or ACPI notifier).
> >
> > Also if the .set_trips() zone callback is expected to set up monitoring
> > interrupts for a thermal zone, it needs to be provided with valid
> > boundaries and that can only be done if the zone temperature is known.
> >
> > Accordingly, to ensure that __thermal_zone_device_update() will
> > run again after a failing zone temperature check, make it call
> > monitor_thermal_zone() regardless of whether or not the zone
> > temperature is valid and make the latter schedule a thermal zone
> > temperature update if the zone temperature is invalid even if
> > polling is not enabled for the thermal zone (however, if this
> > continues to fail, give up after some time).
> >
> > Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() =
if zone temperature is invalid")
> > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033f=
ca16@linaro.org
> > Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> On v6.10 I'm seeing the following messages spammed to the kernel log endl=
essly,
> and reverting this commit fixes it.
>
>     [  156.410567] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  156.666583] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  156.922598] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  157.178613] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  157.434636] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  157.690774] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  157.946659] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  158.202717] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>     [  158.458697] thermal thermal_zone0: failed to read out thermal zone=
 (-61)
>
> /sys/class/thermal/thermal_zone0/type contains "iwlwifi_1".

thermal_zone0 is useless on your system and hence the message (note
that it is a debug-level one).  That thermal zone certainly shouldn't
have been enabled and it probably shouldn't have been registered
either.

Previously, the core would just leave it alone and now it is poked at
periodically.

You can make the message go away by echoing "disabled" to the mode
attribute of thermal_zone0.

I think we'll see more of this, so we'll probably need to add some
kind of a backoff to it.

