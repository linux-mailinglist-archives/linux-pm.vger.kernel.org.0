Return-Path: <linux-pm+bounces-23041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B5A47AAA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041E91711B5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D4221DA7;
	Thu, 27 Feb 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibIJ0tGN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38E1EB5E8;
	Thu, 27 Feb 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653153; cv=none; b=tk1J0z/bmvqHCzdXYkNlUHPvhKLDVCArN7UGwiuMD8uC5odeY6nYqScxdhP++MTgrrzV2nlHXAQWSdKUSq8INhOtfTQu012Q4+9cZLpUFvwqtC7MWMn1j1cvQ9+/J5/ff0fAhr1Pq/q2tbEuLIJscCNlikNXBlwJPeNBXW0xyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653153; c=relaxed/simple;
	bh=sRc81rsNx8VOK7VP5opBGjZMA86PBpVNKgJXwBSOo24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccpOgeQBnEbhHpk9S0gwVIvcvzuD8z7ww5FQh4htUddgVwaz/3tMZNnlYbnSL5WeumQsa0rgYqMrhS7xqEo5fcmTeEC3VhuujSr2ofQ7pfd9o2PmX/L1uZeqjy9bhH9B2aoylWX0ZkbqbGBRJVO9DIyxfT+F7vfw0vhbxVr8T8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibIJ0tGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0C9C4CEDD;
	Thu, 27 Feb 2025 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740653152;
	bh=sRc81rsNx8VOK7VP5opBGjZMA86PBpVNKgJXwBSOo24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibIJ0tGNCMUjgwabSqp3/JUBa/J327EpdZ6FK+/Ygpb9pmOPvmuY8zFSFaU5wcGYT
	 dFL1Gg4PooAuVEqg2FbyfDLjjIwWY9JCgB9r1AObMhURA8MOuZpz/ET6weJfysnr0F
	 FqYqCCi1vfdxo6z8B2J+vWx/rDEWrWPv+ei/aN71Aimv5fyugcLnjJH5lLMNuLUqdO
	 c0YZSdu6nKpmi8j7mC7AoXNTh3iklM0d1eXzSCeXaGEoaalkMVa+AaToAuCVDwaaFG
	 v/1VmyblALlu87TiPEgGMuRQ97+DSA/OGL9C50Jx+ql0YE/J/hX4QtFVTHZlHc8mA4
	 mihgwxlWWLr9A==
Date: Thu, 27 Feb 2025 11:45:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim
 MAX8971 charger
Message-ID: <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
References: <20250226093700.44726-1-clamor95@gmail.com>
 <20250226093700.44726-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226093700.44726-2-clamor95@gmail.com>

On Wed, Feb 26, 2025 at 11:36:59AM +0200, Svyatoslav Ryhel wrote:
> +  maxim,fcharge-current-limit-microamp:
> +    description:
> +      Fast-Charge current limit
> +    minimum: 250000
> +    default: 500000
> +    maximum: 1550000
> +
> +  maxim,fcharge-timer-hours:
> +    description:
> +      Fast-Charge timer in hours. Setting this value 3 and lower or 11 and higher
> +      will disable Fast-Charge timer.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 5

You still did not answer why this is board specific. This was rejected
in the past because of that reason and nothing here changed. Nothing
will change without detailed explanation, so use other interfaces if you
need user-space to configure it (see other drivers, e.g. maxim)

> +
> +  maxim,fcharge-rst-threshold-high:
> +    description:
> +      Set Fast-Charge reset threshold to -100 mV
> +    type: boolean
> +
> +  maxim,in-current-limit-microamp:
> +    description:
> +      Input current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,topoff-timer-minutes:
> +    description:
> +      Top-Off timer minutes
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
> +    default: 30

Same.

> +
> +  maxim,topoff-current-threshold-microamp:
> +    description:
> +      Top-Off current threshold
> +    enum: [50000, 100000, 150000, 200000]
> +    default: 50000
> +
> +  maxim,fcharge-usb-current-limit-microamp:
> +    description:
> +      Fast-Charge USB current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,fcharge-ac-current-limit-microamp:
> +    description:
> +      Fast-Charge AC current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,usb-in-current-limit-microamp:
> +    description:
> +      USB Input current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,ac-in-current-limit-microamp:
> +    description:
> +      AC Input current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000

Half of these properties as well are not suitable and duplicate existing
sysfs interface.

And for remaining, still no battery.

Best regards,
Krzysztof


