Return-Path: <linux-pm+bounces-23897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14135A5D15B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 22:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8310189E9B1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661F26389D;
	Tue, 11 Mar 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Pz04Z1fv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7651386DA;
	Tue, 11 Mar 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727175; cv=none; b=holqbe8VdIjrBVm8LOPTEZMTVOvfMfJMZvj44nnKe9wcOxpPve7LY84yqqGzoUwY+UECDLR4EoEqdqIi/VKmaMEWNRcAkGN03jC/3CwDdyIHyP0+Z1dAeVk/raJmElpfjC8WPywPfZ0Hs+cqJhS9u5VpkOB2XEYTzrwYEaFw+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727175; c=relaxed/simple;
	bh=aGHrqIf6TaZnD6AIuiiF2VpR10cGUHRJs2RNL3cvJJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8Ml93DCGMzm8Je3ZvsZOoJ9bfPEPXm812Rb/KT8pvky0UwF5tbo5woa41KQHFQiYbbzpI13lWdi73AdGWHDup/aTkqHdQceuWpJgpCZTmtEkEeuxYlVaDIxnu2nvQRGGRVjKN2DhBGz3nFUPtbk7V6fnsE4XB/j+IFd6f2f74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Pz04Z1fv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=8cQ/NQPSdJvXIo45BwmVpV7YAKqa0qFriHj8RB6qbiE=; b=Pz04Z1fvHkkbn+am
	bDaVD+7ggiir2qFZ2Iqkr7OXYGTOz8FuXkQ2AP4fsFAAgsWetrP6mohkF0dCc9GMbLL9M8VmTztz4
	msU/eXqHFhgCyS3670Sj3w1LlpeJnRr7fTL26B8NOwlW1jSckvtiDi+6PrZvycwDhznZLa8N4az8D
	oc5MOLb6mleltSBbkpodGkqU71/JhnLe+f9SC2ZjKp0A1C8sDMcW9sUMyRgCCoMVkzNU3I3uGOTzW
	8TTrrk+vMkCdGnYb5dww4Cbeln3tIOs8l8/Qx8jom91OlYW2NjXW1s2qfM+4dmTo3hWQ9qCLfk3aL
	rxKKxORjsRATavJ46w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1ts6nV-004Gh7-2p;
	Tue, 11 Mar 2025 21:05:57 +0000
Date: Tue, 11 Mar 2025 21:05:57 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Mark Brown <broonie@kernel.org>
Cc: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com,
	sre@kernel.org, lgirdwood@gmail.com, alexandre.belloni@bootlin.com,
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	linus.walleij@linaro.org, brgl@bgdev.pl, tsbogend@alpha.franken.de,
	linux-mips@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/9] Remove pcf50633
Message-ID: <Z9CltdJsg_qaTKzQ@gallifrey>
References: <20250309193612.251929-1-linux@treblig.org>
 <174172393659.371198.1480937233663952854.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <174172393659.371198.1480937233663952854.b4-ty@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:05:11 up 307 days,  8:19,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Mark Brown (broonie@kernel.org) wrote:
> On Sun, 09 Mar 2025 19:36:03 +0000, linux@treblig.org wrote:
> > The pcf50633 was used as part of the OpenMoko devices but
> > the support for its main chip was recently removed in:
> > commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> > 
> > See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> > 
> > Remove it.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [6/9] regulator: pcf50633-regulator: Remove
>       commit: 248bc01138b11ff3af38c3b4a39cb8db7aae6eb6

Thanks!
Although....I'd only tested this as part of the series and assumed
someone (Lee?) would pick the lot up in one go.

Dave

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

