Return-Path: <linux-pm+bounces-5747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A48937B6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9DFB20D90
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539654A1B;
	Mon,  1 Apr 2024 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm5oCHMM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DBA138C;
	Mon,  1 Apr 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941092; cv=none; b=W0gQWtm8QvnF6PC2Nej72Tcr677/WDG+/qbLJ7h05n4RD+35saWTLrcbunKDBvBrPIF/trUXRwzwtBXEkBJ4iT4e5ljWP79Z6e2nv+BlGI+diomeNwOZmwyRZ+cKV++csTKxWC0mS5YVp5/CDlp5GCh/0I0+sO80LZWNJs1FQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941092; c=relaxed/simple;
	bh=4vMlevL0VYNfLajuRPYgB2jzajxU3dD9vRrfIKDvjic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2KQT/6myugit+c0QujdKD9AETXQqPRwnox6idZ/s4PybdYeS2bsW5G9fMKMVOp8HmZoLllFKzF/K/9K+Vaf8Mpl2G3B9rvQu6/2SpINf3if1dHrDmydgzwdLjXO6n8Xw/ND4bqFhz0Saoy/lYOee4WqC6Pf6ZbK2IDG/HxTIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm5oCHMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752D7C433C7;
	Mon,  1 Apr 2024 03:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711941091;
	bh=4vMlevL0VYNfLajuRPYgB2jzajxU3dD9vRrfIKDvjic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mm5oCHMMBhw6AMloVj1sWWg8vk5E6y/OgXYqAHaE5OmhW6Zni8wkFlA3/FKzk0v2u
	 7RhaPSa/xsooRdO6LaHhi2DwLZnLvQCjNSUgiKzfD/v0F5/eMbM5+XhpAzIVhBGFdd
	 HEPwusABI7bhi8B1lfvXH60xE120PIRqH2ji6qL9Wb6Ft5m93w1GdKiR6eKp8rYAPX
	 42/Vn2wq2ShYhnGKe9WjGle1ZHTADNlQPmkxNQ1DWzo1e4JdtRQB+7J00SzCuaVknm
	 PAqgdMoymK3s/nB36n2zOksTl+R0heltN9Y178T7gt7Cq75r3txo/LLEjELALwhCT5
	 mhsMz2R3FW9mg==
Date: Mon, 1 Apr 2024 11:11:27 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	sre@kernel.org, alexandre.belloni@bootlin.com,
	chrome-platform@lists.linux.dev, pmalani@chromium.org,
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 14/18] platform/chrome: cros_kbd_led_backlight: provide
 ID table for avoiding fallback match
Message-ID: <Zgol3-ZLbqBx-oIN@google.com>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
 <20240329075630.2069474-15-tzungbi@kernel.org>
 <680ff14e-97b8-4baf-a2a3-a5b7859517f9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680ff14e-97b8-4baf-a2a3-a5b7859517f9@kernel.org>

On Fri, Mar 29, 2024 at 04:53:48PM +0100, Krzysztof Kozlowski wrote:
> On 29/03/2024 08:56, Tzung-Bi Shih wrote:
> > Instead of using fallback driver name match, provide ID table[1] for the
> > primary match.
> > 
> > Also shrink the name for fitting to [2].
> > 
> > [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353
> > [2]: https://elixir.bootlin.com/linux/v6.8/source/include/linux/mod_devicetable.h#L608
> > 
> 
> I think this should be two commits, where the first one is a fix (Fixes
> tag) for the size of name.

Splitted to 2 commits in v2[3].  It doesn't include a Fixes tag as the compiler
complaints the oversize only if putting the original driver name to struct
platform_device_id.

[3]: https://patchwork.kernel.org/project/chrome-platform/patch/20240401030052.2887845-6-tzungbi@kernel.org/

