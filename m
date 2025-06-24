Return-Path: <linux-pm+bounces-29446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D590AE6BDC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 17:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C01E168320
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE71A274B4E;
	Tue, 24 Jun 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMzZ2gJG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127C3074A1;
	Tue, 24 Jun 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780427; cv=none; b=CIcpDI1ZJMctViq8m6+5zoffNDegUgYdXViOqFcnr9meGVSUcigywbtJgQJ2cBCiBvr9zuktT3PlutIZB8HzOAR2RXA/5GHZpgX1cbGnvfrcgknhJkwrrhZVpt6QAp6UAWuFMilp31ZLHgoI632BRjm7itCdMrF3JQ0QM+lD56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780427; c=relaxed/simple;
	bh=5gIuZaIyM0SgNtIvnnpKjpM1YltAyHByEE6D09stErU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sImN6caA5St/mipH/l1cYiSoqhOTs+LyI6pnfHkws81V8ZNZTv8ok+liVOncuc9nyQr8G6mQtj20ZmpuqZO6xTJyZ92hLHbyLYIWBcuRXQIx1sa0esJt6vxtD6pdiweY0ccp88/50wYcJRZFNcOTkvu1L80qyvEKexZJPxX3FgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMzZ2gJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCA4C4CEE3;
	Tue, 24 Jun 2025 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750780427;
	bh=5gIuZaIyM0SgNtIvnnpKjpM1YltAyHByEE6D09stErU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMzZ2gJG0TMEGpMVxiZHeLdfiXSAJ+T3/T4x4bgZPBc9wtt2C3vBJZPx7RUO7pzV7
	 lD1VDfRASF6KaK7Ww3fKSeaTkws+AN8Mzz8FMLUOawupf+ELUiRAimpcF0vDk8mbXP
	 IT2Dpmqp/nyuQzLRfPWyJoODLt0LUIFydHyeIgh7EQz3onJNCtYU1NVsLwBA+lMiIC
	 3I1D6u/4aXIIzafWyePJlp1uBqE6C21sn79PgMfrG5DZtfAQVTAYUfx1EwPkUWAb9J
	 0lYpVqNzO1TQycN+lcjutyS5WcGz8+JUjiIwEzBUNzXdOGud8oNexRNPY5l/c6a9mC
	 IdwDZTxK4Twug==
Date: Tue, 24 Jun 2025 16:53:40 +0100
From: Lee Jones <lee@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 05/10] mfd: Add Apple Silicon System Management
 Controller
Message-ID: <20250624155340.GL795775@google.com>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-5-556cafd771d3@kernel.org>
 <20250619114958.GJ587864@google.com>
 <f30406ae-90ed-4f81-9519-e6ae2dcc9e03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f30406ae-90ed-4f81-9519-e6ae2dcc9e03@kernel.org>

On Sat, 21 Jun 2025, Sven Peter wrote:

> On 19.06.25 13:49, Lee Jones wrote:
> > On Tue, 10 Jun 2025, Sven Peter wrote:
> > 
> > > The System Management Controller (SMC) on Apple Silicon machines is a
> > > piece of hardware that exposes various functionalities such as
> > > temperature sensors, voltage/power meters, shutdown/reboot handling,
> > > GPIOs and more.
> > > 
> > > Communication happens via a shared mailbox using the RTKit protocol
> > > which is also used for other co-processors. The SMC protocol then allows
> > > reading and writing many different keys which implement the various
> > > features. The MFD core device handles this protocol and exposes it
> > > to the sub-devices.
> > > 
> > > Some of the sub-devices are potentially also useful on pre-M1 Apple
> > > machines and support for SMCs on these machines can be added at a later
> > > time.
> > > 
> > > Co-developed-by: Hector Martin <marcan@marcan.st>
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> > > Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > > Signed-off-by: Sven Peter <sven@kernel.org>
> > > ---
> > >   MAINTAINERS                |   2 +
> > >   drivers/mfd/Kconfig        |  18 ++
> > >   drivers/mfd/Makefile       |   1 +
> > >   drivers/mfd/macsmc.c       | 498 +++++++++++++++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/macsmc.h | 279 +++++++++++++++++++++++++
> > >   5 files changed, 798 insertions(+)
> > 
> > This is ready.  Let me know when you have all of the other driver/* Acks.
> > 
> 
> They've all been reviewed by the respective maintainers.
> 
> I assume you want to take this all through the mfd tree and we'll need acks
> from Sebastian for power/reset and either Linus or Bartosz for gpio then.

That's right.

> The one line change inside drivers/soc/apple would usually go through my
> tree and I'm fine with taking that through mfd instead.

If there are no build-time dependencies on it, you can take it.

I'm happy to take only the inter-dep ones or all (except the arch/ ones).

-- 
Lee Jones [李琼斯]

