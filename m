Return-Path: <linux-pm+bounces-7550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE4A8BDB2E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 08:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EC3281CF6
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457086EB7D;
	Tue,  7 May 2024 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="d0S05ZBx"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810F6D1C8;
	Tue,  7 May 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062271; cv=none; b=XrzVa3ZBCqznoBvKo+z45fIKrD5maqUDYC8wlyHJp86yT0fQ/pMrc8x2wOAsF4S4oJXtkEUDT10GPjhvzOwgsLYKF9wFWO/XEk/65h6o+/V6Peke5W12y1e8/fFZYbI5v05ECv1p0AYsrDMp2HpCGw8lw2kTM9Ql/4I5tySoWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062271; c=relaxed/simple;
	bh=aOz9fe41WAKNxF6hfkGSEIu6azwOFn4nkwJSjri5io4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTkZsOcgi44QUl4nEDk+kQleKpszcYwzgWYRB0q22OZ6q6s7slu7G5KLMBa3N9j3X2mM9dAUCcMLuV3mWuBXEW/eqZ1cq71TvqxkBddvhunaXkftgNT0U1DlP7bw7HVncXXVOOiDaRiVIFLY4COrykTxSyr3Xumw+AawCmbIs0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=d0S05ZBx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715062265;
	bh=aOz9fe41WAKNxF6hfkGSEIu6azwOFn4nkwJSjri5io4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0S05ZBxRizCGgFtKbQ7BtcO+yYMGuBiYUmrS2xORY55741JGhtObzfNA8rTfLGk+
	 9J0XF+qHkeklti47dfmnUxFvdzO6At3vTtBjx3I59GGcYvwdOwbqm/OOAEN+ZIb/67
	 OnCT5Vi9jUFNHV1c4oT6/bYZrhuEFfXy3ClXgoc8=
Date: Tue, 7 May 2024 08:11:04 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Dustin Howett <dustin@howett.net>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] platform/chrome: cros_ec_framework_laptop: new driver
Message-ID: <99ae4866-a8cd-408c-8227-006f96f14dc7@t-8ch.de>
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
 <613369f9-42c5-4a59-b83f-45bd1773ffe4@t-8ch.de>
 <a7ae8fc0-5e53-487a-86c6-f49dc6623688@amd.com>
 <e716716e-87fe-46f5-8ea9-5f649f1da11b@t-8ch.de>
 <CA+BfgNJzazn55wUMzjX=thqZGYz0LYU4cnO1Pn8U80B5FrSvxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+BfgNJzazn55wUMzjX=thqZGYz0LYU4cnO1Pn8U80B5FrSvxQ@mail.gmail.com>

Hi Dustin,

On 2024-05-06 13:29:32+0000, Dustin Howett wrote:
> On Mon, May 6, 2024 at 12:43 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > On 2024-05-06 08:09:07+0000, Limonciello, Mario wrote:
> > > On 5/6/2024 1:09 AM, Thomas Weißschuh wrote:
> > > > On 2024-05-05 22:56:33+0000, Thomas Weißschuh wrote:
> > > > > Framework Laptops are using embedded controller firmware based on the
> > > > > ChromeOS EC project.
> > > > > In addition to the standard upstream commands some vendor-specific
> > > > > commands are implemented.
> > > > >
> > > > > Add a driver that implements battery charge thresholds using these
> > > > > custom commands.
> > > >
> > > > It turns out that standard ChromesOS EC defines EC_CMD_CHARGE_CONTROL.
> > > > The kernel headers however only define v1 of the protocol, which is very
> > > > limited.
> > > >
> > > > But in the upstream firmware repo there is a v3 which is much better.
> > > >
> > > > The Framework laptop only implements v2 which is also fine.
> > > > Given that v3 was only introduced late last year, it seems better to
> > > > stick to v2 anyways for now.
> > > >
> > > > So please disregard Patch 2, I'll see on how to use this via a normal
> > > > cros_ec driver.
> > > >
> > > > There are some other Framework-only features that will use Patch 1,
> > > > so feedback for that would still be good.
> > >
> > > What other kinds of features do you have in mind?
> >
> 
> Definitely privacy switch reporting belongs in a driver like this.

If it can't be done via one of the upstream CrOS EC commands, surely.

> Overall, I'm not sure about making it a subjugate driver under the
> cros_ec_mfd virtual "bus"... even though a lot of the features take a
> dependency on cros_ec.
> Doing so centralizes the work in the platform-chrome tree and may
> serve as a guidepost for any future laptop OEMs that derive their
> embedded controller firmware from ChromeOS's.
> If the owners of this tree sign off on that, that's awesome! I'd be
> concerned about making it all their responsibility.

Yes, some guidance from the maintainers will be great.

> I may be a bit biased, as I have been working on a driver of my own[1]
> for this purpose. It currently supports battery charge limiting[3],
> reporting fan speed via hwmon, the keyboard backlight[2], and has an
> open pull request that exposes the status of the privacy switches.

I have taken a look at that driver but wasn't fond of the fact that it
is not using cros_ec mfd. Taking a reference on a completely different
device looks iffy to me and in violation of the device hierarchy.

FYI I have completely non-Framework-specific implementations for
keyboard backlight [0], charge limiting [1] and hwmon [2].
(I didn't look at the privacy switches yet, maybe there is a generic
solution)
(I'm currently polishing [1] and [2], any feedback already would also be
much appreciated)

All of them work correctly on my Framework 13 AMD, Firmware 3.05.
These standard APIs are more powerful than the Framework-only ones.

Charge control can do start_threshold, stop_threshold and
charge_behaviour. Hwmon can do fans and temperature sensors.

Keyboard backlight just reuses the existing mainline driver.

> It is destined--once I find the time to clean it up--for
> drivers\platforms\x86 instead of ...\chrome.
> 
> This may be a good place for us to combine our efforts!

Surely!

Personally I only have the AMD 13 device (Azalea),
so I can't test anything else.
And I'd like to focus on the mainline-compatible APIs (first).

Feel free to contact me (privately?) if you have any suggestions.

> [1] https://github.com/DHowett/framework-laptop-kmod
> [2] I found that the Azalea did not report its keyboard backlight
> values through the standard cros ec KBLIGHT interface like hx20/30
> did, so the driver as it stands implements a fallback that uses the
> raw PWM state. I'm sure that you'd've noticed this if it was still
> true... so I am always happy to drop an unnecessary workaround. :)

For me the posted driver under [0] works as expected.

> [3] Which I believe still requires a special host command and is not
> integrated into the charge manager, at least as of Azalea/Lotus and
> _definitely_ not as of hx20/30!

This also works for me correctly with [1].
Do you know if there are plans by Framework to move the older devices to
a newer firmware?
This would also make their own maintenance work easier in the future,
especially considering their commitment to software longevity[3].

> [..]

Thomas

[0] https://lore.kernel.org/lkml/20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net/
[1] https://git.sr.ht/~t-8ch/linux/tree/b4/cros_ec-charge-control
[2] https://git.sr.ht/~t-8ch/linux/tree/b4/cros_ec-hwmon
[3] https://frame.work/de/en/blog/enabling-software-longevity

