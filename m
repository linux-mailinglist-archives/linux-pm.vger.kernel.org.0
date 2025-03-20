Return-Path: <linux-pm+bounces-24334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21DA6AA62
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 16:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D855480A94
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B91EB195;
	Thu, 20 Mar 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd3BucY0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890921E2852;
	Thu, 20 Mar 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486117; cv=none; b=iehwpfIVzlqdNKRt/kg1raMlM7JmFEwAAMgcjUwmA8I2JZFPQV3e+nyIqE8dUW+ZZEHgtfmpA/Ln49U73+EprHSFjYUsSytkIwz6IyEQmFP+1AWK7OLHSt0Kj9YRtIkHwiU4RGY+ifYEsSyIDVfpF8Ix0+/EDJfJGBGRUDdUaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486117; c=relaxed/simple;
	bh=ugGwmlbHI7Ylp9+3EGFLGWP7T2pY9hjUfzoAi22qRmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OW6eOFCiqEgINxoY2JQ5kcNANmgk86n6OVkLSkrSQhc6A6NugapP87Fk/AS6Q8LhTBUyEVTZ5u16gJ3KTu86dnZyZrt8HSl9kj6fgZC7KWNYmyMXrJP7JELrYzdEgzRheWU1Yevcr0fupy7Ok8rABLyYVjtCQgn4gc632vL/uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd3BucY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC98C4CEDD;
	Thu, 20 Mar 2025 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486117;
	bh=ugGwmlbHI7Ylp9+3EGFLGWP7T2pY9hjUfzoAi22qRmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gd3BucY03/Of2qRjDDfcWqXci4x+52BbNqKJlbn1+/2lK13Cc8/Cazm5geAeGNBBV
	 SLXwLFt+DLDTpGyRjXVl5+MdalEu+NPPrSlGpdMzTC/+n6mU5zM3ocd0bpRWJLpFJi
	 qIyLoJZoPtQSQ5OyDJfestAahVs+FTOz7BU0O8VD1zGYYqWj2zOhX6AyHXD9x8l3X2
	 q1ZZ5Ob0ilEGCmki51IANAjWZrUUCSTzcnUmq7DmQG41QCQuywMJ1xq5M2BpRPWA2g
	 N1fwHOuFJWe4DyRe5+n1MyXvbwAcJl8cHhq1O2uscVbWY093yvHxlTDb0QsyvbIHOM
	 seHFb4K/I3ARw==
Date: Thu, 20 Mar 2025 15:55:10 +0000
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, Input, LEDs and Power
 due for the v6.15 merge window
Message-ID: <20250320155510.GU3890718@google.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
 <20250221160322.GE824852@google.com>
 <CAL_Jsq+f23KniKZuTHkOq5a7WL=pBy6PwuQwXmbPXMjq3Qax4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+f23KniKZuTHkOq5a7WL=pBy6PwuQwXmbPXMjq3Qax4A@mail.gmail.com>

On Mon, 17 Mar 2025, Rob Herring wrote:

> On Fri, Feb 21, 2025 at 10:03 AM Lee Jones <lee@kernel.org> wrote:
> >
> > Enjoy!
> >
> > The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> >
> >   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> >
> > are available in the Git repository at:
> >
> >   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-input-leds-power-v6.15
> >
> > for you to fetch changes up to aebb5fc9a0d87916133b911e1ef2cc04a7996335:
> >
> >   leds: max77705: Add LEDs support (2025-02-20 16:38:37 +0000)
> >
> > ----------------------------------------------------------------
> > Immutable branch between MFD, Input, LEDs and Power due for the v6.15 merge window
> >
> > ----------------------------------------------------------------
> > Dzmitry Sankouski (7):
> >       dt-bindings: power: supply: add maxim,max77705 charger
> >       dt-bindings: mfd: Add maxim,max77705
> >       power: supply: max77705: Add charger driver for Maxim 77705
> >       mfd: simple-mfd-i2c: Add MAX77705 support
> >       mfd: Add new driver for MAX77705 PMIC
> >       Input: max77693 - add max77705 haptic support
> >       leds: max77705: Add LEDs support
> 
> None of this seems to be in linux-next, but now we have users in .dts files.

None of what is in -next?  All of these patches are applied and pushed.

-- 
Lee Jones [李琼斯]

