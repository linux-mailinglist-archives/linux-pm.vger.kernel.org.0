Return-Path: <linux-pm+bounces-26390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333AAAA1C4A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA654A8700
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57271267AF2;
	Tue, 29 Apr 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="F1KxhSkH"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3326ACD;
	Tue, 29 Apr 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959101; cv=none; b=UHFApDpLpimhHicN//UxTNjuP4mIUD68maDx/1nr9M0JJuP654szmS5qJmS2H2KJusM9LDoMFeNI8p/xGQnhgt+OUlJDeIunnFZqr9EaLfxEcT2MObIzWtSjZqdY//EuHslpVZSMTpuXp+XJ/oT5LWiNGHSIYPUuf4K1dsuGViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959101; c=relaxed/simple;
	bh=/eWBP36b0R6vQ02TvTg1IX/OQuDQ0fjODeXqIrCufOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTwJnP8RjhQKeBb6aRk5yUY8toEvJ0JDUaupXvPj4sDqIYCIVyfitW/aprFoOlNVyAIgabGziBsR5DFal5gSQHh42nNjPRmFKnn872y+Vvh+3PKImOjolYj8VX28qYjoFSwKzmmz280y8H9wGpf05i8WBAzRgMgyqGoSpXYRP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=F1KxhSkH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745959097;
	bh=/eWBP36b0R6vQ02TvTg1IX/OQuDQ0fjODeXqIrCufOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1KxhSkHutUmilajknwg+FUaRBHlfgi8EAHlRtfKQGWf4PPdvz/xb+5FHc0rtJX5r
	 BvZDkqwQjhQfiBo6mdBeRICLEyXGOTgDD5K5t9cNcrnuOQ6Gzqo/UupaO+GpKuHeSX
	 kILIEEc3GwPenxaL5E7k3mDevKdS/D/jGQPld0x0=
Date: Tue, 29 Apr 2025 22:38:16 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] power: supply: cros_charge-control: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <f920aa2d-b180-4532-bd29-d8740883617f@t-8ch.de>
References: <aBEwnKtUOTYzS7C3@kspp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBEwnKtUOTYzS7C3@kspp>

On 2025-04-29 14:03:40-0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Replace an on-stack definition of a flexible structure with a call
> to utility function cros_ec_cmd().
> 
> So, with these changes, fix the following warning:
> 
> drivers/power/supply/cros_charge-control.c:57:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks,

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
> Changes in v2:
>  - Use utility function cros_ec_cmd() instead of DEFINE_RAW_FLEX(). (Thomas Weißschuh)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aBEmk6ixfrQ2XpTw@kspp/
> 
>  drivers/power/supply/cros_charge-control.c | 23 +++++++---------------
>  1 file changed, 7 insertions(+), 16 deletions(-)

<snip>

