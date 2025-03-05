Return-Path: <linux-pm+bounces-23475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2BA4FA9F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C201892FA4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D67205AB7;
	Wed,  5 Mar 2025 09:51:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9F1FDA89
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168280; cv=none; b=G5tHJ4vxVKEeUUkkG2VMnHZBBNTLbINFRWhiADYUQ8AFe90SE6U9ldrTZdgFQzAxhkafkaDQEHI8+xEIWNzUQubP94agPvCmOQk+ar7Yw5X1xd78ElRA/4Iwk7WSHHnlUNqPpVckiCpEdc4bXk1V4tKJJkMNDRdeJwTBRKGIJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168280; c=relaxed/simple;
	bh=rvj0a+vHA+NZlGBw9NSx/eWYj1OESCfRgSHcNayQehw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeTiNFoJB4sTKnElT9ALoOpPKPKNc1UvUY5hOOmyx14PzAINBe92A+vIiMtHjOuk9uXvfTWGdmxmbEgduqV03cnCzQ3j2QAz7hDmuKuIOWDj8C9Mt0XE4oR48zUiC88u/+rRjJu9mNzJv7uECi/7TrhwBaYTZ8MkqhnWfX2okgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tplP3-0005JY-Sw; Wed, 05 Mar 2025 10:51:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tplP2-0047c0-2t;
	Wed, 05 Mar 2025 10:51:00 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tplP2-00EP5R-2W;
	Wed, 05 Mar 2025 10:51:00 +0100
Date: Wed, 5 Mar 2025 10:51:00 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v3 2/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <Z8gehLMlc1qiA2HE@pengutronix.de>
References: <20250304132433.210355-1-o.rempel@pengutronix.de>
 <20250304132433.210355-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304132433.210355-3-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Tue, Mar 04, 2025 at 02:24:28PM +0100, Oleksij Rempel wrote:
> +/**
> + * set_power_state_change_reason - Record reason for next reboot/shutdown
> + * @reason: The enumerated reason code to record
> + *
> + * Other drivers (e.g. regulator, thermal) call this whenever they detect
> + * a condition that may lead to or cause a reboot.
> + */
> +void set_power_state_change_reason(enum pscr_reason reason);

this declaration should be removed, otherwise it fails on disabled
CONFIG_PSCRR.
...

> +#if IS_ENABLED(CONFIG_PSCRR)
> +
> +void set_power_state_change_reason(enum pscr_reason pscr);
> +
> +#else
> +
> +static inline void set_power_state_change_reason(enum pscr_reason pscr)
> +{
> +}
> +#endif
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

