Return-Path: <linux-pm+bounces-20673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B453AA16721
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C918F3A4720
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD51018E75A;
	Mon, 20 Jan 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c298KXws"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916713D51E;
	Mon, 20 Jan 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357200; cv=none; b=dB7R9WSBE46lLI4Yd/pUX/XRd+6duZyziPprV//Rb4dJq2c0pbLSNR11uyUtXhpDMhX8CeZSueAgryrQWFZHUGwH7bKav0BoglmLvUr+dDA4IgTwyiEM5yGnlcl1G0Vzcc4Uvgbh8seAvcsAhlzugO8rRqpwxCtC3Q7ui6LTmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357200; c=relaxed/simple;
	bh=IRYNLtNzo6bdDY0Icg+xlR+wT71/yUTDcJvl/kP2U60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeR/PqMWcpRok5n0uGFwfZyxMQXVbYhu+rhAUPQezWNZCL11PFPKMCHdTpTSimE5iAlKv/5O1oC8rLMPd0yoN3oU8nneE7M54aMtXfc6tth8r+FqULAhrXdcOl85YIkay7fgZ0dAUHMGMFimk937zBrNhQ3cBUFQ4kiYSQ2fxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c298KXws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A548CC4CEDD;
	Mon, 20 Jan 2025 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357198;
	bh=IRYNLtNzo6bdDY0Icg+xlR+wT71/yUTDcJvl/kP2U60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c298KXwst3MpwRf6Xs2UJo5gV4oSz0/sb7XkOEE5zfG7KaGB8RfvE5uTIX7WAaSIU
	 crzrnSZYFIiGxsUjodk63VxgzRw3itXIkTLNM8pH4dfcnIqNj26YZykR0qwSeUHlKf
	 zOl+A94M5gp//nUKuQTaX1PTeERjxE5k1qU/KP/qHvfdIPQw9Jc++gYPulmyiF9KMU
	 nPpK8BZriEboDsYkQjB8kDr1rJmn6kK6mo5uvPxhxRwQu/rf4vNpmTxu7MLzqKmUO+
	 BecAXmwmuXWbHt6L6hTDEbbKsBg7z4zn4M6pBdWO39XQe99xCHiY/QXTgXSJo5vsJU
	 5RJS1kSfHVwYA==
Date: Mon, 20 Jan 2025 07:13:11 +0000
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
Subject: Re: [PATCH v2 12/12] reboot: retire hw_protection_reboot and
 hw_protection_shutdown helpers
Message-ID: <Z433h78ahaT2d5Qe@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-12-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-12-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:37PM +0100, Ahmad Fatoum wrote:
> The hw_protection_reboot and hw_protection_shutdown functions mix
> mechanism with policy: They let the driver requesting an emergency
> action for hardware protection also decide how to deal with it.
> 
> This is inadequate in the general case as a driver reporting e.g. an
> imminent power failure can't know whether a shutdown or a reboot would
> be more appropriate for a given hardware platform.
> 
> With the addition of the hw_protection parameter, it's now possible to
> configure at runtime the default emergency action and drivers are
> expected to use hw_protection_trigger to have this parameter dictate
> policy.
> 
> As no current users of either hw_protection_shutdown or
> hw_protection_shutdown helpers remain, remove them, as not to tempt
> driver authors to call them.
> 
> Existing users now either defer to hw_protection_trigger or call
> __hw_protection_trigger with a suitable argument directly when
> they have inside knowledge on whether a reboot or shutdown would
> be more appropriate.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

