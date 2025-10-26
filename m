Return-Path: <linux-pm+bounces-36859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6062C0B3E4
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 22:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02103AF689
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C6283121;
	Sun, 26 Oct 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUR1M4l/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC972633;
	Sun, 26 Oct 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761512947; cv=none; b=m5rYzDYAkIP/0VpoRwDVJde95OaAmNV3kyQeCO1UgB9HhB+FmSFoYZ/K6StsMj9ZJ6pYfCSZL4POA+nP1zPNisqxyOhoHy640rt0yP2jQDYYC5uzUAuKK9BBXxtpgiOroe6D+4aFUUcyB768EMLqU1u8YNQzCOKR7IqE5Wdt/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761512947; c=relaxed/simple;
	bh=PgGZkxx9eVXClCW73EbY+KTGYweRYJk4TsXoUCP0ekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8bH4Ahtv/DplOi7oWo/kFnHRmFjGTAqidTbsIQ9ikV++cM0jC0i20tqLrAxi17a/hl9voxG6C7ts+9CQfsMUPUG+B9ifUNwZ3Ci1QAPkss1OKAjUNI5aJ13G/md+VECHuaPQ7/uPXb5p/KGY9aDVfFFtnDFmIJcJcWfumyqgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUR1M4l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0288BC4CEE7;
	Sun, 26 Oct 2025 21:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761512947;
	bh=PgGZkxx9eVXClCW73EbY+KTGYweRYJk4TsXoUCP0ekU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUR1M4l/hP8HpiVUCzrPwKHQLA71phjUp7BimzWp+4GClN0UQGwSfzsd8fVfX8wRV
	 0KoytM0amuJJnfRidVHRhWF4gVgqbUjaYBkx0UgwbwhUxE7brFWpTs3cfPKaXZM/I8
	 n6dJKg1SqGyGQ0zzhY5F6uCksj42hmsX7iazM8feVgjyg6S9EWHkRQHbXDLxKUzJbJ
	 c3RU3rCDY8rckM0EqsfDfWfpuz1NJQluvNWhvQ0sPexN6jKfSq5Uibhp/z7R5ims10
	 /y4N93U9eb/LS2ZoU9sCmehKWKB0ja+59U53OG8NS5eVEGuiB3tGhyqAPKBeWVZ09p
	 VJDTdJX0SgnXw==
Date: Sun, 26 Oct 2025 16:09:05 -0500
From: Rob Herring <robh@kernel.org>
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
Message-ID: <20251026210905.GA2941518-robh@kernel.org>
References: <20251025043129.160454-1-iuncuim@gmail.com>
 <20251025043129.160454-2-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025043129.160454-2-iuncuim@gmail.com>

On Sat, Oct 25, 2025 at 12:31:24PM +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add a binding for D1/T113s thermal sensor controller. Add dt-bindings
> description of the thermal sensors in the A523 processor.
> The controllers require activation of the additional frequency of the
> associated gpadc controller, so a new clock property has been added.
> 
> The calibration data is split into two cells that are in different areas
> of nvmem. Both controllers require access to both memory cell, so a new
> property nvmem-cells has been added. To maintain backward compatibility,
> the name of the old cell remains the same and the new nvmem-cell-names is
> called calibration-second-part
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 56 ++++++++++++++++++-
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index 3e61689f6..b2f750ef2 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -24,18 +24,23 @@ properties:
>        - allwinner,sun50i-h5-ths
>        - allwinner,sun50i-h6-ths
>        - allwinner,sun50i-h616-ths
> +      - allwinner,sun55i-a523-ths0
> +      - allwinner,sun55i-a523-ths1
>  
>    clocks:
>      minItems: 1
>      items:
>        - description: Bus Clock
>        - description: Module Clock
> +      - description: GPADC Clock
>  
>    clock-names:
>      minItems: 1
> +    maxItems: 2

How can the max be both 2 and...

>      items:
>        - const: bus
>        - const: mod
> +      - const: gpadc

...3 entries?

