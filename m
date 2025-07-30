Return-Path: <linux-pm+bounces-31575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DCB159B7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1843B9303
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6E28FFE5;
	Wed, 30 Jul 2025 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeGpVIki"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28DE156CA;
	Wed, 30 Jul 2025 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861181; cv=none; b=EgzqDR5MtZoqfEMEp5tAArxCXkpKYw7MONrw/hJ4woxaGHKu/EQi+i6P6Obr5LLsKWvR5g7/Ip3esffxJDkVOzmuEIGMTT5NNYSg7q4H5wcQXEWbzB2ixqLFIy+i2NwtntjA6/956f1+mGBAGDNBz+VilH02EvL3iXa0ah+UADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861181; c=relaxed/simple;
	bh=9vE/0YRE5m4T2yAc8ysN75M/3WfwPx5PcISQ5OcHdFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvzzIEZns95RdA0YwPiUsiyOYTUrFaAvzP7TeW8X9GHTxepRDRgushHXZN7TCD8+/P0C60BpJt1Gpb+hrDvpoANzdx79fjL4Bg4K9A7eqcGN4flxMdY4d4BHif/5h+Y0RLbtWi60s1FGQ8uScOmaxjzvXDqkXyg9vVYwgSoMkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeGpVIki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FB1C4AF09;
	Wed, 30 Jul 2025 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753861180;
	bh=9vE/0YRE5m4T2yAc8ysN75M/3WfwPx5PcISQ5OcHdFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeGpVIkikgjaTGHmA4hJCNVe9x06ZFQKqv5nneRs2qThAeFD/IYOTWYJb3Rx0cyUM
	 QwRqnNJN2DCeEZwMmQEP3VBuU4ecfNuLR4tR9Wt6nsYeibvVY4k4pmSe0e4nWfrniv
	 165h2RNS2GMF32TeT3aIkhNqKFihzsVWnCVUJ8GFCrLaEXlIMYB3r1AVUskau1cJ2b
	 WIvrf+979UBYt3vVKQD3xddvUZBdG6tFXCBKTk/zNHHR25y/euhIibds7kXHm55A60
	 Fvr7Kom3D5ZMaPbZpqb9bCuA3+Zj9Q1P5uzjAg7cDwErVH0igyMmlhZfB+t5m1/8Yd
	 HwpVcCY3Rsemg==
Date: Wed, 30 Jul 2025 09:39:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: ChiYuan Huang <cy_huang@richtek.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: Add Richtek RT9756 smart
 cap divider charger
Message-ID: <20250730-sassy-competent-mule-d94f1a@kuoka>
References: <cover.1753759794.git.cy_huang@richtek.com>
 <3fa997b42b4aec43fc182a043cf521f7e3e7fcb3.1753759794.git.cy_huang@richtek.com>
 <3603a744-e898-49ef-968a-2388e14cae54@kernel.org>
 <aIl+VKFURqFfXKz3@git-send.richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIl+VKFURqFfXKz3@git-send.richtek.com>

On Wed, Jul 30, 2025 at 10:07:16AM +0800, ChiYuan Huang wrote:
> On Tue, Jul 29, 2025 at 05:40:32PM +0200, Krzysztof Kozlowski wrote:
> > On 29/07/2025 06:21, cy_huang@richtek.com wrote:
> > > +
> > > +  shunt-resistor-micro-ohms:
> > > +    description: Battery current sense resistor mounted.
> > > +    default: 2000
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - wakeup-source
> > 
> > Why do you require this? I cannot find any use of it, so maybe I missed
> > some change in Linux code (and that's second question like that for
> > Richtek, so refer to your other patchsets for contexr).
> > 
> 
> This will mark the interrupt as wakeup capable.
> https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-of.c#L57
> https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-base.c#L547

OK, but this does not explain why this is required. Why it is impossible
to make board which uses this PMIC and wires the interrupt in a way it
is not waking up the system?

To my limited knowledge this should be possible, but what do I know
about hardware...

Best regards,
Krzysztof


