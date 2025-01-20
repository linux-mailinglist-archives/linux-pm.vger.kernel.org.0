Return-Path: <linux-pm+bounces-20665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613DA166F7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93D91699C8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC7118C34B;
	Mon, 20 Jan 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ17/4Jk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E661442E8;
	Mon, 20 Jan 2025 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357072; cv=none; b=Va3GPdi/8Mh2JSAAVZVDTKxpcIvNzdgWO5A1FzoDtXqFVhKU8cJFuLiy2jCLiLL+wB0TOiqkNFJw6xG2fGiQ7blaZYaxz8/+rKs2nALbjhdbz4V+XagxXvSrKdjUWBAXIyH80hSNCXQybM3KK3tZBTh6uvFck5To+VajxHgytHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357072; c=relaxed/simple;
	bh=38I2TwMCqqilG2XBKnBpjOcjQWKVr3qLbHU+u/xh1nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na9JBGdNBMBeuCoo2dEMXTZzTE7/jqYMC/a7pxQxC+ussZ1qrnQIu+YKVksQyiSHNQlWMavUdvemqXbSGPFlG8ic3fpllAU2L5qvHWIa4ax/nKU8WqBmGKcQVOB5FOcLLiNrjzGN3XlL6sjUd8qrUlhiWY8IBp5KxHz7BqrAZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ17/4Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77775C4CEDD;
	Mon, 20 Jan 2025 07:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357071;
	bh=38I2TwMCqqilG2XBKnBpjOcjQWKVr3qLbHU+u/xh1nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQ17/4JkZW1n+aZJxDL9bez/mLUb3e7LcCa9WpPeXtjVQ/BzrMNvPPhlOLwf19DGe
	 8WN3NZ2JW45kOsk/+hweaz4lDKZB0Q3WQjTnOF4tDk0bCYW2J0QJze7cBcf7nHQQbx
	 dHd4zLA0ialsOF52/gT8IGHGLd+W/TWiKwlrzwnqdYmhHwsUnQoWTEwqGSexb4Hd0P
	 POE75xg11qIg65tFL2oABhZVLUaVet2DIh1tKiyBO8iOoFjUPS+XHm74HF+3BnG4qd
	 qqcFEiyNUhNN3+20AgJ7Q4U/cWmEUj+bXHBwOUKreFJdiN14MG6VCI9bKByG4VL1dC
	 C7J9KnW1/yotA==
Date: Mon, 20 Jan 2025 07:11:05 +0000
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
Subject: Re: [PATCH v2 03/12] docs: thermal: sync hardware protection doc
 with code
Message-ID: <Z433CXhyYHqYEn4N@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-3-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-3-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:28PM +0100, Ahmad Fatoum wrote:
> Originally, the thermal framework's only hardware protection action was
> to trigger a shutdown. This has been changed a little over a year ago to
> also support rebooting as alternative hardware protection action.
> 
> Update the documentation to reflect this.
> 
> Fixes: 62e79e38b257 ("thermal/thermal_of: Allow rebooting after critical temp")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

With a possible typo,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> +At first, the kernel will attempt an orderly power-off or reboot, but
> +accepts a delay after which it proceeds to do a forced power-off or
> +reboot, respectively. If this fails, ``emergency restart()`` is invoked
                                                   ^
s/ /_/?

