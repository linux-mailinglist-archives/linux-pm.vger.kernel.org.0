Return-Path: <linux-pm+bounces-25424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17068A8924A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 04:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1214189C07C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 02:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDE621ABC6;
	Tue, 15 Apr 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCmDq0Xv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093D1B0430;
	Tue, 15 Apr 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685580; cv=none; b=WNYfGy5D++uv03TaWvN/UAeD479Ax41wvzu9S/hWbemspZtzh3GmArvRrxIG0B8sWzE8GSovkBzRq2RC7z14mPOo8SBhsJwbqpyARKOHPZQsAUSYefVeDhPzwrTj4Dznhaz5zx1l5OArThr2uqn6FSpzSGD+BxESsEfFwFmkGbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685580; c=relaxed/simple;
	bh=oe32vFwjvXSWEc5QPi2s6lExfArkB3jNgqubGPspKuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e54spws3AsrffHBqegAxVoW96fCYpP62ciM6w4QHNUzLF6b9G31jY4B1lCcSIYEnJ8iuy2hL2Kw8tuxiOkKTrKM996o6uNxyV1uG3ThXK1vC0WbTzNSl4qRWPME8X0D8vzLpP95s9c3kWLdMmUb8NPf8zXJm99ikcLfjF3NIPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCmDq0Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C015C4CEE2;
	Tue, 15 Apr 2025 02:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744685580;
	bh=oe32vFwjvXSWEc5QPi2s6lExfArkB3jNgqubGPspKuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCmDq0XvQ19IW31yaIRdbzOuxL/oigyeUfR3OaiuD+zeIo04UNI8k0/Ffro2ZDles
	 REn2mZAdh/6M/Yhu86EScT8LeA0lgDP/6TcaIi7Ujnb+7ZE4ahiaIG44qu80Bwceqt
	 n6RPHCjmKAjSiA0RxUiQ5L46eO9dGK4udN8SeQlSCmfJZ/5aq3oIVR9yNhQhgPMatF
	 hL4sfls5Z5WPCZZk0EjRW9ISRUbqHop9+YYeoMHGIFjEhQlz9j9O0WVj2QgSuqI0EX
	 vdVtVI19Aol4gQyfdFg8gOYzOWjLW7LIwYs8WiSoPrOj5YC+5p3t3ZnkhF5oZOeBQr
	 0ywJwrfNRCriQ==
Date: Tue, 15 Apr 2025 02:52:55 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v8 2/7] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
Message-ID: <Z_3KB0tLX6sKhdFI@google.com>
References: <20250411121757.573419-1-o.rempel@pengutronix.de>
 <20250411121757.573419-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411121757.573419-3-o.rempel@pengutronix.de>

On Fri, Apr 11, 2025 at 02:17:52PM +0200, Oleksij Rempel wrote:
> Prepares the kernel for the Power State Change Reason (PSCR) recorder,
> which will store shutdown and reboot reasons in persistent storage.
> 
> Instead of using string-based reason descriptions, which are often too
> large to fit within limited storage spaces (e.g., RTC clocks with only 8
> bits of battery-backed storage), we introduce `enum psc_reason`. This
> enumerates predefined reasons for power state changes, making it
> efficient to store and retrieve shutdown causes.
> 
> [...]
>  drivers/platform/chrome/cros_ec_lpc.c |  2 +-

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

