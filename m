Return-Path: <linux-pm+bounces-20669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ADDA1670F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A9F169AF8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBB218E054;
	Mon, 20 Jan 2025 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwvmPTuq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA513D51E;
	Mon, 20 Jan 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357137; cv=none; b=rnZy3RBPlT0RZSazQOPUGB8SuCQCwES6egj2GCNDxZL+zHerWXJjdRVhOxYxkKjBjFHAM71N9U/3gFbDA5ybhUNvwG0iOkezRniMtj7v/wpV5y82lu+LZ4iZETlxSZo0uS4YGj8YbBMl/0HASyzfRwHwSE3HgLfocVe4rQimq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357137; c=relaxed/simple;
	bh=GSuvmwgujWLvjtQ0kXfh/uYXyb3X/2AbdMW2za39cWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8HBGpuVF1xjQ9ri3rZQz3BD9ArEfSMUrRriWKHBaYNYnyfDjlAmoeMVxQG1MGdp6YaWFdsD67E//UXioiEwHpmY5LNiJzIMSIUwEeTRMN0W9l/Ed1/ZYKosJRPYhcHqh7/0E7iRIPw0a6/Lx/cdJrKm3l9YP/Cb2/PPMifY3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwvmPTuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAA1C4CEDD;
	Mon, 20 Jan 2025 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357135;
	bh=GSuvmwgujWLvjtQ0kXfh/uYXyb3X/2AbdMW2za39cWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwvmPTuqll9nS7fSTP/JQ23IpSjCbj8Y2+uaEoTQ/OIIQDvg4UVyumwgtpK8bnnYi
	 FspJkblkW5qpFJ85d7n8SeynyUmlZmD2afIC9aVKbOWA2bowDET2kftB0Zvoz+vqCo
	 0+7xVIKb4pZV9413DODfcTzc1nzl/T09UMSbjgNH3WOW39R0KEsBJG/bPQMzNhBmfL
	 zb0m0uVto5WGEm9X+mPvvIZaJPcDZ0QH7GNsaFkSDz89LfKP1ribfIPAej35kLNRM8
	 vu5aLkUy2dpxSf2E/3BD6Levypq83UnSHxPE8XwvNntYkfEyCxzmludru8B0dveMcw
	 uANSVDTFxUUMw==
Date: Mon, 20 Jan 2025 07:12:09 +0000
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
	kernel@pengutronix.de, Matteo Croce <mcroce@microsoft.com>
Subject: Re: [PATCH v2 07/12] reboot: add support for configuring emergency
 hardware protection action
Message-ID: <Z433SVbr-h3JCycF@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-7-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-7-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:32PM +0100, Ahmad Fatoum wrote:
> We currently leave the decision of whether to shutdown or reboot to
> protect hardware in an emergency situation to the individual drivers.
> 
> This works out in some cases, where the driver detecting the critical
> failure has inside knowledge: It binds to the system management controller
> for example or is guided by hardware description that defines what to do.
> 
> In the general case, however, the driver detecting the issue can't know
> what the appropriate course of action is and shouldn't be dictating the
> policy of dealing with it.
> 
> Therefore, add a global hw_protection toggle that allows the user to
> specify whether shutdown or reboot should be the default action when the
> driver doesn't set policy.
> 
> This introduces no functional change yet as hw_protection_trigger() has
> no callers, but these will be added in subsequent commits.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

With a minor comment,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
> index 837330fb251134ffdf29cd68f0b2a845b088e5a0..133f54707d533665c68a5946394540ec50b149e5 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-reboot
> +++ b/Documentation/ABI/testing/sysfs-kernel-reboot
> @@ -30,3 +30,11 @@ KernelVersion:	5.11
>  Contact:	Matteo Croce <mcroce@microsoft.com>
>  Description:	Don't wait for any other CPUs on reboot and
>  		avoid anything that could hang.
> +
> +What:		/sys/kernel/reboot/hw_protection
> +Date:		Feb 2025
> +KernelVersion:	6.14

The info might need to be adjusted if the series would be for 6.15. 

