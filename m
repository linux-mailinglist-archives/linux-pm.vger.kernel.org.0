Return-Path: <linux-pm+bounces-8543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2928D8B2D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 23:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59D01F2275A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE93A13C9A3;
	Mon,  3 Jun 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gUcgaZjp"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746F13C90B;
	Mon,  3 Jun 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448396; cv=none; b=fA99S83JfJsssXX2iHgpCyb8XHm+1jEDOIqjRu95N9sEMeEe98684g+i707o8ry+WG7MzPNVzNKYLkO76j5+fOI8LKlzS642Lv6PTxpnrIJq/OPVHxoaEiXtFceauq9JPn9kfu+vo8cMhV/P3QbDUZfcEasr9TV34jAoHcAU3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448396; c=relaxed/simple;
	bh=n83K36thiF+lJBy27bSJupNp7twUTuCmlxqyf9CdgCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lab/jPM9+Tv6NU19J0uXAfK8/cxfHEL4RC2LDA4A3uTxvjcDk7H6t49G6eiQx04y30kfF/jWLHEIbXVhkssx1BWpiRFnoTDAHWpSgbQN049iArE7RmGZq+gn59aa6s2v188lEUd97CqXK83vHtVnyyCUFRvfFJJlAz8WL1JnGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gUcgaZjp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717448393;
	bh=n83K36thiF+lJBy27bSJupNp7twUTuCmlxqyf9CdgCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUcgaZjpWGlbqmbB65yifUBjyhvcJt0LTk69PJK6iiq7JDLZlp3XKwjsvvWohWWrT
	 zBnRS1nc8f8fgYp58ru9UzuJxE3uSh3mFj2XhhPLjCYW4aeEY4aHtmjCyVpzAfzCxa
	 Yowh9W5kkjcJFD0CR26ADM9DGO4KusR8y0rNhllQ=
Date: Mon, 3 Jun 2024 22:59:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Dustin Howett <dustin@howett.net>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
Message-ID: <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com>

On 2024-06-02 18:40:18+0000, Dustin Howett wrote:
> On Tue, May 28, 2024 at 3:05 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Add a power supply driver that supports charge thresholds and behaviour
> > configuration.
> >
> > This is a complete rework of
> > "platform/chrome: cros_ec_framework_laptop: new driver" [0], which used
> > Framework specific EC commands.
> >
> > The driver propsed in this series only uses upstream CrOS functionality.
> >
> > Tested on a Framework 13 AMD, Firmware 3.05.
> >
> 
> I've tested this out on the Framework Laptop 13, 11th gen intel core
> and AMD Ryzen 7040 editions.

Thanks!

> The problem is that the AMD framework laptop *reports* support for the
> CrOS charge controller, but it does not truly support it.
> As with the 11th Gen Intel Core (and by proxy the 12th, 13th) it still
> does require the OEM-specific command.

This is surpising, it works on my machine, which is also a AMD 7040.

> This is evinced by a mismatch between the firmware-configured value
> and the value reported by the charge control subsystem through this
> driver.
> 
> $ cat /sys/class/power_supply/BAT1/charge_control_end_threshold
> 100
> 
> $ ectool raw 0x3E03 b8 # OEM command 0x3E03 with BIT(3) in the payload
> is Framework's charge limit query host command
> Read 2 bytes
>  50 00                                           |P.              |
> (in my case, 80 in decimal)
> 
> The charge limit is managed at [1], and it does not appear to
> integrate with the standard charge control machinery.
> 
> I'll pursue getting this board not to report support for CrOS charge
> control. This driver is still entirely fit for purpose, just not for
> this board.

Can you try disabling all of the Framework-specific charge control
settings and test again?
Probably the different, disparate logics in the Framework ECs are
conflicting with each other.

Thomas

