Return-Path: <linux-pm+bounces-20143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050EAA07539
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFFB3A7C42
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878C2165F3;
	Thu,  9 Jan 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow5rJl3s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C51195;
	Thu,  9 Jan 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424194; cv=none; b=SAez7s9LMgkLooxPFKPfEhew3rrPQsYCYLQQeMJebIGgyUkJo3a/Gszt4hiwKu8ngqAespwzQYKUPG4Qp+xsqL5pffAUMxB3+cXH6+QppUNo4iohWd8VEtO6pmd5SJlVERjnpBL0ir0BvVcPUPAUWuMr1ZNoybfew3lHl6FWCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424194; c=relaxed/simple;
	bh=dUdumsvPLpAVvX8INYGr+r+MDjjIZOTO4U5VGD4h2jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow86PijrypuMPvr96pWJ4jih6WuznXT2o+1jqQgcQ4MTc79K2gSdyVnA12Ofed8OtvevxetItdp3DTQ9WbxpKrNqGLZAhii3CkuUhSsViPXSYA2KwZ91WAzVKPwuxuX1/oi2zF/OzB7ElJ8Sb64aocO7wdqdMbNCRMoQ9+UiIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow5rJl3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE58CC4CEE6;
	Thu,  9 Jan 2025 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736424194;
	bh=dUdumsvPLpAVvX8INYGr+r+MDjjIZOTO4U5VGD4h2jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ow5rJl3sPDhM5FpuH+cmhQZAOh5vcf00RBXoD4Bt4kIi2r7ygD3hlPmxuLa1nt/0p
	 b4T3tOmCFq5AEIHq2B60uxXnZ94oDtR+ARMkTvugEK5orJhNhHcXq9edaBqQ6Z6oIh
	 nspQ9lJ7mMvcHkXORKn3JPBZgHu3f3sMrF8YLy/RYzjErU4quTon8Tzsxyyuww3IGr
	 u9LQU1ytXpPvKUt90mX0yEJObqMaXYaNmiWFyXadq9kaE88PQiY5Fk8Wja4WvwUdAb
	 YKG0L9K+QsGZpfOIx7vjf7U1Zt6ymzQfIjiaA4HeGWjFq/m51rNdab0Nka/W4HxXeY
	 Ylj7QdA3Tthvg==
Date: Thu, 9 Jan 2025 12:03:08 +0000
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v14 07/10] mfd: simple-mfd-i2c: Add MAX77705 support
Message-ID: <20250109120308.GI6763@google.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>
 <20250109120158.GH6763@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109120158.GH6763@google.com>

On Thu, 09 Jan 2025, Lee Jones wrote:

> On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:
> 
> > Add MAX77705 support - fuel gauge and hwmon devices.
> > Hwmon provides charger input and system bus measurements.
> > 
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> > Changes in v13:
> > - remove compatible from cells
> > - change mfd compatible to match max77705 fuel gauge node
> > ---
> >  drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > index 6eda79533208..22159913bea0 100644
> > --- a/drivers/mfd/simple-mfd-i2c.c
> > +++ b/drivers/mfd/simple-mfd-i2c.c
> > @@ -83,11 +83,22 @@ static const struct simple_mfd_data maxim_max5970 = {
> >  	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
> >  };
> >  
> > +static const struct mfd_cell max77705_sensor_cells[] = {
> > +	{ .name = "max77705-battery" },
> > +	{ .name = "max77705-hwmon", },
> > +};

Why not register these from the proper MFD driver?

> > +static const struct simple_mfd_data maxim_mon_max77705 = {
> > +	.mfd_cell = max77705_sensor_cells,
> > +	.mfd_cell_size = ARRAY_SIZE(max77705_sensor_cells),
> > +};
> > +
> >  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> >  	{ .compatible = "kontron,sl28cpld" },
> >  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> >  	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
> >  	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
> > +	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
> 
> Drop the battery part from the MFD (group) name please.
> 
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

-- 
Lee Jones [李琼斯]

