Return-Path: <linux-pm+bounces-20663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DDEA166EC
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C139318884DD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A0189BAC;
	Mon, 20 Jan 2025 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn+lGuxF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33C13D531;
	Mon, 20 Jan 2025 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357035; cv=none; b=TNms7Bu5Rj9ODrEBKHGKwpQV+kfEBHoOfK/sI3pln/TnyyKbX6hjjms2OD2qvJgZ7Wu61xalyKEzFla3qSBabrqDiHTVORaOjDlspl8xqrdNutUFyJIZJFNQoczBRWF4UGMiTKy7Gvidzg2shlEHFAigXaZEnp0aQiHmzywpKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357035; c=relaxed/simple;
	bh=hhiIowDDPlKiniZiubya6fCr04S5es+7qxmNrFX3e3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTBA7QsG5Z3BM8BwPzT75ekqRIFClKIhfQdwr3tLRDAEaM/F/iiU6wNjru8EochlMp0WDeTxw7KnrCpsqEQaQSb6rUvRWSGHybiaKIWwUQ6lExpFA04IKwYQkEmX1D15UKJW+2c7aRarf0JOyxeBi7qcI1G/gtOtAXSHgdX++tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn+lGuxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25A1C4CEDD;
	Mon, 20 Jan 2025 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357035;
	bh=hhiIowDDPlKiniZiubya6fCr04S5es+7qxmNrFX3e3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gn+lGuxFY2FGoDwKruU5Ne3KVPiRvv5hBu5t1P/hqGYkJwBwjBYY21D1eeaiGNveA
	 sEd+0LX2e5z9YmJhr+NZeRdI16bCcPVhJsngLJJOKjGX7wAWrHWzkGWL5qreaEOWfg
	 atMrpDwLBBXsw07FSOjqxOwxK3IOSs8ESvgRj4f1cBhPUoLrrK0YgN9FP8cYxI1CqI
	 XC8q1iNsDLpOgfvtyGrwvd5zDAXV79MOWjdM1TTndT5SrTS6oALQXrk3dDKu2+Qj3N
	 bn+QwUrDJfbuXOEILXLcVbw4b+h7+/WUoBIRXaERch22SrpVp3Css63cc3wERxjxKc
	 xDzkdM8lI5sbg==
Date: Mon, 20 Jan 2025 07:10:28 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@denx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 01/12] reboot: replace __hw_protection_shutdown bool
 action parameter with an enum
Message-ID: <Z4325IopvxTN_34R@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-1-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-1-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:26PM +0100, Ahmad Fatoum wrote:
> Currently __hw_protection_shutdown() either reboots or shuts down the
> system according to its shutdown argument.
> 
> To make the logic easier to follow, both inside __hw_protection_shutdown
> and at caller sites, lets replace the bool parameter with an enum.
> 
> This will be extra useful, when in a later commit, a third action is
> added to the enumeration.
> 
> No functional change.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

With a minor question,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> @@ -1009,10 +1007,10 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shut
>  	 * orderly_poweroff failure
>  	 */
>  	hw_failure_emergency_poweroff(ms_until_forced);
> -	if (shutdown)
> -		orderly_poweroff(true);
> -	else
> +	if (action == HWPROT_ACT_REBOOT)
>  		orderly_reboot();
> +	else
> +		orderly_poweroff(true);

It probably doesn't really matter.  Does it intend to change the branch
order?  As s/shutdown/action == HWPROT_ACT_SHUTDOWN/ should be more
intuitive for the hunk to me.

