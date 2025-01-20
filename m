Return-Path: <linux-pm+bounces-20670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671BA16714
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918A516A16F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489018E76F;
	Mon, 20 Jan 2025 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5L2v4Pj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C3145A18;
	Mon, 20 Jan 2025 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357151; cv=none; b=oIkXMsqlf9TXXcJU637Vu6ziXFtrhK4/1lYzDI3NnbkWN7EJO61kOiyhY8LiGOTKjtVXtsIfZB5JObncSG9qHHgoqKz+ExoktMS9a+Y3fEAzRtTJB82F9ynRodr2mFGJFU3iW9Z7STiTO4H4wVXINf2duE4P6LiUjejxqDsxLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357151; c=relaxed/simple;
	bh=QS1LXxg7UI7EocGr8KzebCZCoC8/u+5kQnGxVDbm7nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjMfMkAZDIiUx0YEYpQUiw8vR7mGfjYnYr8zAbpzxyLqmnAUnMCsKzvpiuk9TpcWI6+W1Sbzb1h/0cJ4K2JqX+EOl5a7Jjj9v8PPU/cj2Gx4Et2W7P4QzWE8IL8evGOkwQ1udzZJdSCJauGR9cC+RusILYWJtSwvSjEOp6u5oSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5L2v4Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267A7C4CEDD;
	Mon, 20 Jan 2025 07:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357150;
	bh=QS1LXxg7UI7EocGr8KzebCZCoC8/u+5kQnGxVDbm7nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5L2v4PjLHEfWrH51CobGDDELtSWQDD1L03na7hq2kOGvNS2K/0BntuvqWh1qOltq
	 x+is7YT2KFluPMZXKVIhKAa49mckUAfaFpW4WKYDAy2IhBNwnKwKKLT+jvcQnlAukt
	 t7H2mt2JBz7c+PXOshiQqhkJjA5cC57C1jJNtKKpC2fUHdF3M6lV56MIjzsLTfruDD
	 xxgCwtDwoLDIVJnLXuZV/PkzWkAKLetPvXo6t0qtOhoggVpZ43cU7jYffOD1WWf+cB
	 Efl8tfVoOrqeOoPYatIr7WyaJ5I7kZ9mHT12oTd88jwmn3NDfGGspr9ZU1pmRYSc1H
	 /WJ0w2iOmi7ww==
Date: Mon, 20 Jan 2025 07:12:24 +0000
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
Subject: Re: [PATCH v2 08/12] regulator: allow user configuration of hardware
 protection action
Message-ID: <Z433WMKjFx7KJJqN@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-8-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-8-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:33PM +0100, Ahmad Fatoum wrote:
> When the core detects permanent regulator hardware failure or imminent
> power failure of a critical supply, it will call hw_protection_shutdown
> in an attempt to do a limited orderly shutdown followed by powering off
> the system.
> 
> This doesn't work out well for many unattended embedded systems that don't
> have support for shutdown and that power on automatically when power is
> supplied:
> 
>   - A brief power cycle gets detected by the driver
>   - The kernel powers down the system and SoC goes into shutdown mode
>   - Power is restored
>   - The system remains oblivious to the restored power
>   - System needs to be manually power cycled for a duration long enough
>     to drain the capacitors
> 
> Allow users to fix this by calling the newly introduced
> hw_protection_trigger() instead: This way the hw_protection commandline
> or sysfs parameter is used to dictate the policy of dealing with the
> regulator fault.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

