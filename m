Return-Path: <linux-pm+bounces-20664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF6A166F2
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2FD3AA111
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CACF18BBB0;
	Mon, 20 Jan 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY+AAQho"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128D13D531;
	Mon, 20 Jan 2025 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357055; cv=none; b=hGa8mCXFJ2KOgOrD4/G3bzkgcjVfoONdHr2wxu5UrYUMXSh2Wnhp41f8ILb+bj9MoP2rej2odve0/SkhAhkdXhG28h8ZUjsb931xaFpRPZ276emQF7JzlfodcRcEMzORkJ5nWTFri/nYtyhlJ6+c5751Hw3mAp7IkDP1LkrES5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357055; c=relaxed/simple;
	bh=tTl/AxD44lehf3XjUNIpXDTawzKl3yELQWzOEVtf3Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOROJ8BE5mhXXNfMTkr2LjzIziRUkQi/WwrM0TVCrK+L4snPf+14FTFKUx/lBr92yJIlZO3a8LGZ2NYEWX9EYGYh+gQxjGJwhhugp9E6zBKQe82445MZvdfzF2jngm5SgUKFr3CdMwPpZVvVW9lSFSDts/wIYu0V0PRMh63tv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY+AAQho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC76C4CEDD;
	Mon, 20 Jan 2025 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357054;
	bh=tTl/AxD44lehf3XjUNIpXDTawzKl3yELQWzOEVtf3Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY+AAQho/kZrw3C0UnV78A2/UU2IB5lhigLGc33yc0xWiB1YsiM4Fm+ZUX4J1tK+A
	 s9IrlcrGmg3EKPa0+vLxQkZK14vSfy32cb5iZeVOUwEPZhb+ViCWIzd1OK40/EjAcs
	 Q/dtXnptSrUdilem+1evGWtyNFhqKuo8Bv8xnE6fd6I1QYN9DHDwXx800g7/OIdDw6
	 IXDboCF/lLjn9cinKIqGwqiG6rALG+cmhKPmhx9HbtuznGVE1nX7z074I3eDV0jk72
	 DMIxyUph+hMC3LDBpr+Xh9Z8WItrV6pE9ddE9pL3x3JqDEMd+f2ulPzH3lDcPOXdgp
	 iovR+v4V5eVOg==
Date: Mon, 20 Jan 2025 07:10:48 +0000
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
Subject: Re: [PATCH v2 02/12] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
Message-ID: <Z432-IV0VTgnl7Rf@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-2-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-2-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:27PM +0100, Ahmad Fatoum wrote:
> hw_protection_shutdown() will kick off an orderly shutdown and if that
> takes longer than a configurable amount of time, an emergency shutdown
> will occur.
> 
> Recently, hw_protection_reboot() was added for those systems that don't
> implement a proper shutdown and are better served by rebooting and
> having the boot firmware worry about doing something about the critical
> condition.
> 
> On timeout of the orderly reboot of hw_protection_reboot(), the system
> would go into shutdown, instead of reboot. This is not a good idea, as
> going into shutdown was explicitly not asked for.
> 
> Fix this by always doing an emergency reboot if hw_protection_reboot()
> is called and the orderly reboot takes too long.
> 
> Fixes: 79fa723ba84c ("reboot: Introduce thermal_zone_device_critical_reboot()")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

