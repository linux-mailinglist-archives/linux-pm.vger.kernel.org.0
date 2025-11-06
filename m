Return-Path: <linux-pm+bounces-37499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D12C397DD
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 09:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 260734EE658
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DC2FFF9D;
	Thu,  6 Nov 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYq0/d4C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13D288C25;
	Thu,  6 Nov 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416089; cv=none; b=QfTvOBZ8v2JuoDPysZxskJoJ7vIdbDkwO1XpuZ32kUCmykavXwgxiKb2IRzdqBC1VnzHU7wx/niMQ3i4rIDZ7R1A51Myrzs4n3BjeYU2wE2e9lk3hSLSdmF4ObPr9TYQPxZDFeBGl55CNHf9g/J3gI28NLTiQIdtKzGBwOtdplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416089; c=relaxed/simple;
	bh=uowgofq6EGyEpedmqAkpKpF/ILvzv603fruxW1Nk0UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O63TovgdZ0/oBM40FzH2eB49oQlUrwxyZP4mcjqMfLj0C33hHhGy+kNFRRjD4JwNZTIsJAV5rLJXid/p2T0JuQbFTPMSrnDg07+KfFl6nmmXtT2yS5sHj9JwrS6QmUeOs5G+sJGdWhsOpHyx8n2T0T6KdcaZcjNZ09vRIL4akpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYq0/d4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15BFC116C6;
	Thu,  6 Nov 2025 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762416088;
	bh=uowgofq6EGyEpedmqAkpKpF/ILvzv603fruxW1Nk0UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYq0/d4CSKp6QODh9TvYWER3c1cothVgTSjcNsFm6a3395+K0lz16xIHjrsewNagG
	 h1538HAdqxKUaLBB6ZzCO69ZZzcE1FSQvxmqjlhYm8EqFfGuEIB0wszZygOXl5ohWT
	 VnTWUtTThUBSgYtUjj9moAwnZqmwGGWeVkxhaldWQGtW4b9uWEuEHGWqKMvLpKl4lj
	 kL0kpDKW2F4nNdJlJWAEApGWndgwo6NcsvO2fQ9YNZlgeIi0H9NAR8CVaAEiNjyrdg
	 tYbOrMAIS+4Ssx9V5clbPXP45pQQTCY33GHM9V3NlzFMOknC81HBo5PDIIOxmVoXTY
	 pyWaJPqtB8zXA==
Date: Thu, 6 Nov 2025 09:01:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 03/16] dt-bindings: battery: Add trickle-charge upper
 limit
Message-ID: <20251106-aromatic-outgoing-chameleon-dadf02@kuoka>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
 <1babb4f8e9a1d21daab737e3427005852ec304fb.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1babb4f8e9a1d21daab737e3427005852ec304fb.1762327887.git.mazziesaccount@gmail.com>

On Wed, Nov 05, 2025 at 09:36:31AM +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Some of the chargers for lithium-ion batteries use a trickle-charging as
> a first charging phase for very empty batteries, to "wake-up" the battery.
> Trickle-charging is a low current, constant current phase. After the
> voltage of the very empty battery has reached an upper limit for
> trickle charging, the pre-charge phase is started with a higher current.
> 
> Allow defining the upper limit for trickle charging voltage, after which
> the charging should be changed to the pre-charging.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


