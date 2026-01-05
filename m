Return-Path: <linux-pm+bounces-40177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE85CF27AA
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 760543004BB0
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F25313533;
	Mon,  5 Jan 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt7inGru"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD627F754;
	Mon,  5 Jan 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602125; cv=none; b=eWyyYrRV0Pr8+JaIFQI684hNUpMgqUzTkRCPk79kZPA19FUXwxDo43ND31IiMOgdSSycrw6W6HgQi75p/7pkdHBzyrTrJgvBmMEBWp35Ya9MUYmBD60vSEdlI0ckP29+uhfEuQn5Nz+x4gd+55iQq/yk9zuTzlJ6v21t+GXezvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602125; c=relaxed/simple;
	bh=5BG9GD5tzxlgpo0fpFvXnFFO5JdVa3ur9v+uv3OzPOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsUHRuLyLn8n+m+SFDUo7o5mbPYEJ7bZILanIlirxLFBimc7o5iNJl1/othsrYGYou5qARzPPW7Im5rOTP7s2hk4N9Jt25Osy4aZpPf2X0h/GlrvPqdQRlI2CqA3YsOy9i7BmzcdAWAoMwg9xQ8yPuPa1Nliz80rLL0Op4iKRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt7inGru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736E2C116D0;
	Mon,  5 Jan 2026 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767602125;
	bh=5BG9GD5tzxlgpo0fpFvXnFFO5JdVa3ur9v+uv3OzPOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dt7inGrujEUEquTjd6QkbLSE4dU3RYh+293qKlFjAt1qPVFoV9oIWSQ9+JLRQZM2T
	 /Y3PQ/ha0SknxemeMtJ+jZyMC4NJgGee5a4AqlFJKJ12zx3leoTQZjWMZra4gfpzXG
	 RJb3F38WsZ6YSQwePz0NzfiBwraz7UQehVUbzqUUlHyQR/tX0xSZ+IXiVqPMwvbcFQ
	 9tYLLbdhUXx4Sre7MtsOi3SmqTDOKykyedyTjuXBfNs0TOBjHoONfJrUdjrmrhfQZL
	 LVUnyXxM3w7Xwa1xRoo4vXr4nG5YiwY9he7OCXGMq7uPX1L+Mk/ig1w2Y7lC+cr3VY
	 tvgzPM6r4H75Q==
Date: Mon, 5 Jan 2026 09:35:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Josua Mayer <josua.mayer@jm0.eu>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: netronix,ntxec: add reference to
 power-supply
Message-ID: <20260105-auspicious-swallow-of-prestige-3c13cb@quoll>
References: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
 <20260102-kobo-aura-battery-v1-1-501f2a8fa575@jm0.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260102-kobo-aura-battery-v1-1-501f2a8fa575@jm0.eu>

On Fri, Jan 02, 2026 at 07:00:30PM +0100, Josua Mayer wrote:
> The Netronix Embedded Controller supports monitoring of battery voltage.
> 
> Voltage monitoring functionality is self-contained and requires no
> supply- or battery-specific runtime configuration.
> 
> Battery design characteristics (e.g. voltage-min-design-microvolt) are
> useful for users to understand the charge level and are commonly
> provided by a separate battery node linked with monitored-battery
> property.

b4 diff '20260102-kobo-aura-battery-v1-1-501f2a8fa575@jm0.eu'
Breaking thread to remove parents of 20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu
---
Analyzing 6 messages in the thread
Could not find lower series to compare against.


Make it easier for us to review, not more difficult.

> 
> Add reference to power-supply.yaml so that power-supplies and
> monitored-battery properties become available.
> 
> Further drop reg property description and replace it with maxItems 1 as
> is common for i2c devices with single bus address.
> 
> Finally replace additionalProperties with unevaluatedProperties to
> allow properties from referenced schemas.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


