Return-Path: <linux-pm+bounces-22560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB1A3E131
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EA97AC8C8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A720DD47;
	Thu, 20 Feb 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD1ElzAr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF3204840;
	Thu, 20 Feb 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069827; cv=none; b=WhcMePPDZrCPsYgEG9cKKPdFz5YlGJKGCBhMXN9zNLau4qQdvQNyDis8V60nHjaGx4xhxCSoMWeuf9175X6RVF2gCDMcifq9dglbmleflnIHb+uHwLMDFLMV2MYI+ndJ5FdXTGVB+dMaxQPePbSw7LzYsBxsaAyc9TPhka5ostg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069827; c=relaxed/simple;
	bh=agaBIrDK1n0Kan1E1UYRbKAbf9aZnrkrgIyeTlCVzvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDuifU9MG+mcnRNKVh84wWA/+f4tyu163XcdP4zbdqM6DK3fexw8Fg5E/MPkw0gDZGPmhyqK41pzgkclIoPbO15qNh1G3Ni2iKXgH6zvGXReyPVTOQ4cmL87juaEeg5wIhLT9D33gCFmqHmJkyuuPT5PBmSwHJIfwXC0FMDStFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD1ElzAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69619C4CEDD;
	Thu, 20 Feb 2025 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740069827;
	bh=agaBIrDK1n0Kan1E1UYRbKAbf9aZnrkrgIyeTlCVzvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gD1ElzArVkSpKTBC3O/68z63VvDXMGrm2LqeH+QQ+iMrHGv3z7+6Ic+q6I4tD3FTq
	 XS1p86MB07tN8Aif56Q0wrMdnUPJR6oDm5AMK5b2iRAQblVOmH9KUSFFnvuA+ExS7L
	 3Mqmi6gMUZIBDIQNSSaTwlXmsxUv91Uhb2tITNri2+prLUp57wxov0RtApDX701WjQ
	 Ws34qJN5D68ibJRq/ysQSJsVVTSnjm/PPVNyiuzad5bPj8n7/Ea8WDwFyuzaoO+c2S
	 eTb/m5mwzBX2aOBHiVBFvrCbIbsRbhJag3qWAyFZGAO6f9MK5vkFVtjIrBQtJdsecQ
	 Pu9g8sw+p9ZBg==
Date: Thu, 20 Feb 2025 16:43:40 +0000
From: Lee Jones <lee@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v17 0/7] Add support for Maxim Integrated MAX77705 PMIC
Message-ID: <20250220164340.GD824852@google.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
 <174006961563.882548.1668950876404410080.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174006961563.882548.1668950876404410080.b4-ty@kernel.org>

On Thu, 20 Feb 2025, Lee Jones wrote:

> On Thu, 23 Jan 2025 18:04:25 +0300, Dzmitry Sankouski wrote:
> > The Maxim MAX77705 is a Companion Power Management and Type-C
> > interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> > Type-C management IC. It's used in Samsung S series smart phones
> > starting from S9 model.
> > 
> > Add features:
> >   - charger
> >   - fuelgauge
> >   - haptic
> >   - led
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/7] dt-bindings: power: supply: add maxim,max77705 charger
>       commit: af280f29f32c885942f67edacfeae7d9b6e897a4
> [2/7] dt-bindings: mfd: add maxim,max77705
>       commit: 2ae4ffff28bf48a7144591eed7081f746b98e130
> [3/7] power: supply: max77705: Add charger driver for Maxim 77705
>       commit: a6a494c8e3ce1fe84aac538b087a4cab868ed83f
> [4/7] mfd: simple-mfd-i2c: Add MAX77705 support
>       commit: 7b591ef98b3fc1ce20c3ccb86715429b72e2e6f0
> [5/7] mfd: Add new driver for MAX77705 PMIC
>       commit: c8d50f029748b73313838b64b829992b66ccb704
> [6/7] input: max77693: add max77705 haptic support
>       commit: eb79f3a5a51a1f484e2570d983dc9d8217e8f912
> [7/7] leds: max77705: Add LEDs support
>       commit: aebb5fc9a0d87916133b911e1ef2cc04a7996335

I'll send out a PR once the build tests are complete.

Note to self: ib-mfd-input-leds-power-6.15

-- 
Lee Jones [李琼斯]

