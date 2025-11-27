Return-Path: <linux-pm+bounces-38769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A224C8D4D8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 09:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2037C4E1C2F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1026F29F;
	Thu, 27 Nov 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUCYiEde"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203D523A;
	Thu, 27 Nov 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764231397; cv=none; b=r/WT2kcT8qfondJxUuoB1bwN997Dtxq5WopgfYoRkDEyvxo/TpT++6DRTtNjU0FkMuUTwGlj2y1uWvheupoC3iIUpeWj9mTQ05bWtpmNTW4yG+fZaVvP6Fd/Ff6lmiwUge8TLmc/ok7pmoPRA2aTwdVP50ui1pGk+GFeFa11HKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764231397; c=relaxed/simple;
	bh=7Rk8c66XN0l5S5JcqfocJB+VVsyduUHmIjF/OJYBuoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J22k19lHHSlTp/OVDKPpQQh+YRDp7nqbTz1vzap9aJoMzGhMp8ZXhLwHvW8FyotRhuo06v/CCwXpV+HC0/xUu8mrLhMxkXM8M1MM3ojk/DV9ViGwU9zW8vCJ6LPCYI1f1XaxHVU8goPhvq2DGM+d/EGvNRwqluDKw5789PlzKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUCYiEde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2414C4CEF8;
	Thu, 27 Nov 2025 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764231397;
	bh=7Rk8c66XN0l5S5JcqfocJB+VVsyduUHmIjF/OJYBuoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUCYiEdekSX2PWhfCLMIULcQHcP4/WhEX2i5W4RLlSVW3EJtunvYVIpBLFVEzABAF
	 pa8pfKrq48LJ9cpMaufKWR3CN+/XAK++dgXC8S8LTvaBXpN+myoh2VB/JuPcykx1Pu
	 5rFQDWBD1h5Wf2V1wgMljs7VsBYKPH52E+/FEHRoSPE3eREC349DNRyaZ21NGHCTYy
	 Z0aphyvPcpIe60YZHCqosrnFt+ENCXPfN4F12FPxzaG2rFttamel+xLo2VseZz2afy
	 /WLVFGgmlot+JXontYODJkGFYl6P9cFfaBOcdqyhYcLAuYM71cCazVKSzfvMfOcbFo
	 ga9TriXe7ur7w==
Date: Thu, 27 Nov 2025 09:16:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shuwei Wu <shuweiwoo@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add SpacemiT K1 thermal sensor
Message-ID: <20251127-tangible-chipmunk-of-economy-c0ff61@kuoka>
References: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
 <20251127-b4-k1-thermal-v1-1-f32ce47b1aba@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127-b4-k1-thermal-v1-1-f32ce47b1aba@163.com>

On Thu, Nov 27, 2025 at 02:44:07AM +0800, Shuwei Wu wrote:
> Document the SpacemiT K1 Thermal Sensor Unit (TSU), which supports
> monitoring temperatures for five zones: soc, package, gpu, cluster0,
> and cluster1.
> 
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> ---
>  .../bindings/thermal/spacemit,k1-thermal.yaml      | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


