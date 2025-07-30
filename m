Return-Path: <linux-pm+bounces-31576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B204BB15A02
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D5D7AFBFA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A9290092;
	Wed, 30 Jul 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXAcMkMC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2571F1537;
	Wed, 30 Jul 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861852; cv=none; b=cqh4ochcsBsYr4CyEXt6CcaHLBf1fLOMjQileK0YZ+RHv+J4FjTb9pPYWIR9YvdXxjMJ8xj1vrHKk/3LmxtVZl/zGldonHkFB3BgaG5p0UwND2oZUYKImI2ogyCikehRf2PWyqRDEky+BEWUA6pmFt/AlG4753eWPEpgKM94VrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861852; c=relaxed/simple;
	bh=TMcBBZ8n9IMNaJwCFya59fGEYacW1l+xZAaQ7cAKSy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrDGIWhUZgjDouwaJRw6JcWTVGINQiUPuJYC0CPONi3mGObISJcZiugNaENHpZO1DMuNIeki9Mo59T8Tn1WlHQ8kKDOHaApXVRzMFMSpffICJhFtEimpIg2bZJ79gMoW9okQ8nBcSwHJxS0wM7tURZWxVrAUpnVYop6hA9bdgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXAcMkMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8F4C4CEE7;
	Wed, 30 Jul 2025 07:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753861852;
	bh=TMcBBZ8n9IMNaJwCFya59fGEYacW1l+xZAaQ7cAKSy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXAcMkMC/I5S0O9jzLpdT/gC+27hD6Ls4vrrsWnyfAqSpcyhkCjkC/ck1GL2w/zeu
	 NNIpPTo1DeXzV9tFU7h9B9NmucveAqMZQe/Yy8GJ+/D03d/ej5Y2XoxR8U0GjziX76
	 WnidD5pZ1eGyPNhz38D8bfRXiMWbeHwUNQcTPUbGRv64vlWMSftra2C5rdD0sEASVB
	 A86o+3Y3fqZ7QfZLhJ71J7ezfMirsGj2vAXxnePDqU2e7FHZpbJ2THAgj1Y6Brz1yX
	 FVgb63+nsJT7ZXTzd1ceGAHBHWaY979FREqOSiy8nKo9LU0bb2zlJgXSIB/1hJWxac
	 kuE8BLbqASG3Q==
Date: Wed, 30 Jul 2025 09:50:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: ChiYuan Huang <cy_huang@richtek.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: Add Richtek RT9756 smart
 cap divider charger
Message-ID: <20250730-giga-cricket-of-development-f886fb@kuoka>
References: <cover.1753759794.git.cy_huang@richtek.com>
 <3fa997b42b4aec43fc182a043cf521f7e3e7fcb3.1753759794.git.cy_huang@richtek.com>
 <3603a744-e898-49ef-968a-2388e14cae54@kernel.org>
 <aIl+VKFURqFfXKz3@git-send.richtek.com>
 <20250730-sassy-competent-mule-d94f1a@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730-sassy-competent-mule-d94f1a@kuoka>

On Wed, Jul 30, 2025 at 09:39:38AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 30, 2025 at 10:07:16AM +0800, ChiYuan Huang wrote:
> > On Tue, Jul 29, 2025 at 05:40:32PM +0200, Krzysztof Kozlowski wrote:
> > > On 29/07/2025 06:21, cy_huang@richtek.com wrote:
> > > > +
> > > > +  shunt-resistor-micro-ohms:
> > > > +    description: Battery current sense resistor mounted.
> > > > +    default: 2000
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - wakeup-source
> > > 
> > > Why do you require this? I cannot find any use of it, so maybe I missed
> > > some change in Linux code (and that's second question like that for
> > > Richtek, so refer to your other patchsets for contexr).
> > > 
> > 
> > This will mark the interrupt as wakeup capable.
> > https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-of.c#L57
> > https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-base.c#L547
> 
> OK, but this does not explain why this is required. Why it is impossible
> to make board which uses this PMIC and wires the interrupt in a way it
> is not waking up the system?
> 
> To my limited knowledge this should be possible, but what do I know
> about hardware...

Another question is still valid, although you provided more context - if
the device is ALWAYS waking up, this is implied by compatible and you do
not need this property at all.

That would be the first usage of I2C client wakeup flag in drivers, but
maybe that is how it should be done? You can consult I2C folks on IRC.

Best regards,
Krzysztof


