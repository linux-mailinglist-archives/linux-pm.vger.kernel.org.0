Return-Path: <linux-pm+bounces-11685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE09419CD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51055B28438
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FDC183CD5;
	Tue, 30 Jul 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa1fiIMP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD11A619B;
	Tue, 30 Jul 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357373; cv=none; b=mG+fPV3mpLDveHPUy9oeyCAPPCvfIS9bRN4FvLONN0DQpEWNfs7wjORfhrtomHn/ZgQnFjyrUNYD0xgNqXxTceIekLhhSL7PF6DNHN5WR5bOxPe605hrfHpHgRjoS6Zi1dZ6ZTBCWVwK7tiABG6AU0lhobeFYNH9fdvfgu/DhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357373; c=relaxed/simple;
	bh=XIyhNqlDuxm6pMJEOSO1+GWCuSX84v5KFQMHzdYZowk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMwiX/PSWMoB4ZX/8UmfLq87f/xtSDd3zcb5o8p07rIj952C1nLkg6iro0IH0KMpzctBUIDSdYzAbjpcL1lMb9WK+4OKQ3WEVW3Pyc19pEYju1V9Yc5iCbE7f8ooWXrbObPjwpIDajEAGxnnBSjlZIMMlda7le33PfDyv98G4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa1fiIMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED1BC4AF0E;
	Tue, 30 Jul 2024 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722357373;
	bh=XIyhNqlDuxm6pMJEOSO1+GWCuSX84v5KFQMHzdYZowk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oa1fiIMP/Qq19dk9m/TykXR6UPGsj5AAZaSkQOJbA007ujDvSJdnu/krhIoxDz+IO
	 kpVtW9XVRUlBpXxhTZhPqheieUr0lClJRe3LHOwpmiqSmRLhwemYcyQT9KbgMeh6kS
	 k5n2SWMeya//V2RwOmMltmx0TO4XDso6somvqluwSyiny4OSLx+O0pXqD5aq0lnrVT
	 FpmHSUl7GHlqjri8/0JhWNSE1mhz2GnhupGUe+XSGxql049jNibA+hwPqynvt4QKi6
	 VpNgei8lTfNvyTDPZQ9YY0/GJiQP/vLRrQbzSLxbi2n1CmwkWThqrakyVmDKAcN4mp
	 2k3DRMvIhMbwg==
Date: Tue, 30 Jul 2024 10:36:11 -0600
From: Rob Herring <robh@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, jagan@edgeble.ai, andyshrk@163.com,
	jonas@kwiboo.se, sre@kernel.org, t.schramm@manjaro.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: supply: add dual-cell for cw2015
Message-ID: <20240730163611.GA1485886-robh@kernel.org>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726194948.109326-2-macroalpha82@gmail.com>

On Fri, Jul 26, 2024 at 02:49:44PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> According to the datasheet for the cw2015 the device supports dual-cell
> configurations. Add a new device tree property for this condition so
> that the voltage values reported to userspace are correct.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../devicetree/bindings/power/supply/cw2015_battery.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> index dc697b6147b2..0e7866d42cca 100644
> --- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> @@ -34,6 +34,12 @@ properties:
>      minItems: 64
>      maxItems: 64
>  
> +  cellwise,dual-cell:
> +    description: |

Don't need '|' if no formatting.

Acked-by: Rob Herring (Arm) <robh@kernel.org>

> +      This property specifies if the battery is used in a dual-cell series
> +      configuration so that the correct voltage is presented to userspace.
> +    type: boolean
> +
>    cellwise,monitor-interval-ms:
>      description:
>        Specifies the interval in milliseconds gauge values are polled at
> -- 
> 2.34.1
> 

