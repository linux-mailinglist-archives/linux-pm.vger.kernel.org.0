Return-Path: <linux-pm+bounces-20766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D573A17B2D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552053A2841
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18FD1E9B2A;
	Tue, 21 Jan 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVLeeITk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66721BEF67;
	Tue, 21 Jan 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454538; cv=none; b=XcehwKPLWC/Iqy8w23o1w/n+U9oDI0nbx6n0Q/wPRQcT8mBEoQJ0RASV5+nfvWQ3g+5uEP+mw0o/6oeB5e8oOLFj148bTOwttopKvrdYN4wGYleRdO5AvNWaFeVeE/rvK7WMQituaETrprY80XDM6oT9k2Hhw5jlwdUi3uxSsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454538; c=relaxed/simple;
	bh=2f6NguNRm7CAVpx5BaUGtLCj2Ck4g9QdKcKsfodhByo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKnCYBHOmWee3Dl9dwTEzsKZcxYymKrwkPp+xIwFts4Bpu7wFSJobi/5uLtfh8dfActC2+DBwRNyUgpJIICZnFIzcC9+E1fMhvr7rpbd6xCUDZrAy66uvVUCUCPxEsetqrVQNmhiyJCwxojmY3xRfld/5EjKJVKM69lyTxdfbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVLeeITk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD92CC4CEDF;
	Tue, 21 Jan 2025 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737454538;
	bh=2f6NguNRm7CAVpx5BaUGtLCj2Ck4g9QdKcKsfodhByo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVLeeITkQtBHF5j2p2QD9jfjXv50PVv3ipgtKNNKClIucUZAI00RVdbj6MyzW2ANP
	 +NgySnE1xuORfSy8kqOhpHElpHoYjlNYhOUn5mR+poTSJ+NElVXQuyqzrBxxwWMwUD
	 8FAHIVJJXS2CudyJpmRfoCJqv6LBjBKfBaYsfT9WBe/PQyvzV8dDiDuJIiH1cp7QGC
	 2R/Xepbu6fTGcJs5JP0h9UfPububx/m2THbEh3UgbPKu+GtlPEq4bOe1tcmRNqYI9f
	 zNWrQKeMYjEi8KSLLfy3nXTetS7LLUT7VIF6j07IZ0S2lidmCyq+g6rZkZwJ1s1By2
	 HHD41xmUo5QlA==
Date: Tue, 21 Jan 2025 10:15:31 +0000
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
Message-ID: <20250121101531.GA1045870@google.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>
 <20250109120158.GH6763@google.com>
 <CABTCjFAky55btJz3B=K2kL5gSJD9BYi5t15jaA2ga5asVT=3NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABTCjFAky55btJz3B=K2kL5gSJD9BYi5t15jaA2ga5asVT=3NQ@mail.gmail.com>

On Wed, 15 Jan 2025, Dzmitry Sankouski wrote:

> чт, 9 янв. 2025 г. в 15:02, Lee Jones <lee@kernel.org>:
> >
> > On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:
> >
> > > Add MAX77705 support - fuel gauge and hwmon devices.
> > > Hwmon provides charger input and system bus measurements.
> > >
> > > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> (...)
> > >  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> > >       { .compatible = "kontron,sl28cpld" },
> > >       { .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> > >       { .compatible = "maxim,max5970", .data = &maxim_max5970},
> > >       { .compatible = "maxim,max5978", .data = &maxim_max5970},
> > > +     { .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
> >
> > Drop the battery part from the MFD (group) name please.
> >
> 
> It will then conflict with MAX77705 mfd driver compatible.

Where is that used?

-- 
Lee Jones [李琼斯]

