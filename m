Return-Path: <linux-pm+bounces-2397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462AE832F67
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 20:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36232826B3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C01F56762;
	Fri, 19 Jan 2024 19:35:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14B5644C
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692902; cv=none; b=ECMDL3WES4dDckdTwRBymeNG9rzmmFX7uwETBWSOU5H1Le9yzfitAbx57Y9Sv8YfaaSzFq3L8QrzODGOeKJW0tmh0HOKKrZozOzwQoFCuW90MMN0ccj/UgV1fcFv9HzXaSXDURJ+589CewuKcQoKTJdiY/iSYQ26KQaEjSFj+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692902; c=relaxed/simple;
	bh=oHAu0+c3vfnOnCboGZ1Ny5kms5BbTNuknWiDW4aWif0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqM3YfbvLsgyUDtBkYkUX81+f8uOa6YB1mc+8FC1gPobt2+eJtjhi7d4CnUqeOuaOXuU1EvRjsRvM9dHovfgLLANTcqHcXTc2kfjsIq4dbIBchYoXhpO0W51YNmvSlOGmw8YNJORWB2MMv+qtdkfwDW58Lq4ONQAfJcPw6rDPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rQudW-0006ix-Jm; Fri, 19 Jan 2024 20:34:42 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rQudV-000zB8-Ce; Fri, 19 Jan 2024 20:34:41 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rQudV-000mMD-9d; Fri, 19 Jan 2024 20:34:41 +0100
Date: Fri, 19 Jan 2024 20:34:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	kernel@pengutronix.de, linux-pm@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH v1 7/7] thermal: core: set Power State Change Reason
 before hw_protection_shutdown()
Message-ID: <20240119193441.GB163482@pengutronix.de>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
 <20240119132521.3609945-8-o.rempel@pengutronix.de>
 <CAJZ5v0gfOaCvsxX5QFzgcTeEZgWGZvqJ3C9d8_Pu6pSp=78m9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gfOaCvsxX5QFzgcTeEZgWGZvqJ3C9d8_Pu6pSp=78m9Q@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Fri, Jan 19, 2024 at 07:34:26PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 19, 2024 at 2:25 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > Store the state change reason to some black box for later investigation.
> 
> Seriously?
> 
> What black box, where, how this is useful and who is going to use it,
> pretty please.

The 'black box' refers to a non-volatile memory (NVMEM) cell used by the
Power State Change Reasons (PSCR) framework. This cell stores reasons
for sudden power state changes, like voltage drops or over-temperature
events. This data is invaluable for post-mortem analysis to understand
system failures or abrupt shutdowns. It's particularly useful for
systems where PMICs or watchdogs cannot record such events. The data can
inform recovery routines in the bootloader or early kernel stages during
subsequent boots, enhancing system reliability and aiding in debugging
and diagnostics.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

