Return-Path: <linux-pm+bounces-18993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67FD9EC912
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EF1284ABD
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067EB86338;
	Wed, 11 Dec 2024 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyyqoWvW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A5236FBC;
	Wed, 11 Dec 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909405; cv=none; b=ufKJ+hlW/4/YaZRJuBnDdq7U63u6kpva7HZfNnifyqty9PKIoO7xfo8BTZOD0yOiJXcw+AykbxDQ8sGZ3RIis6LxIKHq70lNiC9BA+gBN8HGSUjq4LO0OUgVwWMhDIExloDSmpDJgh6WKxxpDAXs0TD8sK1eW/dkku+Zvg9ZL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909405; c=relaxed/simple;
	bh=gVRl4kdZgtoj0eklg7ILQcwVJ0aZh2Qywqranpfvyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQtdib3mKS0PEL4zKmldxvExI606MFxw/f003iEtMLRf3GKZcFo21xvZ7E0BzrX8Ol6yRK7kMxduUuq4tdVEzs7GTEzSnIequIWUV65prDqyF1SQ4QtvKq2d8cIe9wgt3VXsvbrY/nwq21ZYkBoT/fTqXHWgEaJJNPDMGdZ3xQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyyqoWvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4A3C4CED2;
	Wed, 11 Dec 2024 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733909405;
	bh=gVRl4kdZgtoj0eklg7ILQcwVJ0aZh2Qywqranpfvyb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyyqoWvWCVQrxGKhl9ezuwh9naIG+KL2zLJ+zW+0mv8z57L5GZ5FJUbMVftyFMqLM
	 v7+LzpuKRUdWYOt61vZ10D6+CtAdEzEvOHoG01BchA55wQEAHsz6FplfwNZuXAdVLQ
	 /4SeNp9+v3wDauVNTLuczxiYiKKEuswI9kH/HB2hCkU5L5g/a4pUJupoplSdwzXfzg
	 lu1wpDCJFk3MsQ12gMpCSUgPhCOHLoIpAVBqKl6ct3XTXTyE7DMGxmf2tiveL4iVB/
	 APF+uEutJTPUTA1ASp2MV5ljNTDpieUfEyo1bZyAByD8podxbzSp8RFj9Z6IpVO11e
	 qc+F4I+hkMtpQ==
Date: Wed, 11 Dec 2024 10:30:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Raufhake <raufhakestefan@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, s.raufhake@beckhoff.com, 
	s.dirkwinkel@beckhoff.com, Stefan Raufhake <s.raufhake@beckhoff.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] power: supply: gpio-charger: Support to disable
 charger
Message-ID: <4tvn5k6zbsbyc2n3r2jnkrasyfhzfua4cap6ql65yjfmwzu3xw@lx6jmqvzypqv>
References: <20241210092343.3537-1-raufhakestefan@gmail.com>
 <20241210092343.3537-2-raufhakestefan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210092343.3537-2-raufhakestefan@gmail.com>

On Tue, Dec 10, 2024 at 09:23:43AM +0000, Stefan Raufhake wrote:
> From: Stefan Raufhake <s.raufhake@beckhoff.de>
> 
> Some GPIO-controlled power supplies can be turned off (charging disabled).
> Support changing the charging state by setting charge_type to
> POWER_SUPPLY_CHARGE_TYPE_STANDARD and disabling charging by setting
> charge_type to POWER_SUPPLY_CHARGE_TYPE_NONE. One potential use case for
> this is disabling battery backup on a UPS.
> 
> Signed-off-by: Stefan Raufhake <s.raufhake@beckhoff.de>
> ---
>  .../bindings/power/supply/gpio-charger.yaml   |  6 +++
>  drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> index 89f8e2bcb2d7..084520bfc040 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> @@ -44,6 +44,10 @@ properties:
>      maxItems: 32
>      description: GPIOs used for current limiting
>  
> +  enable-gpios:
> +    maxItems: 1
> +    description: GPIO is used to enable/disable the charger
> +

You did not respond to my comments, nothing improved. Without
explanation based on hardware - which I asked - this is still a no.

Implement and respond fully to previous feedback.

Best regards,
Krzysztof


