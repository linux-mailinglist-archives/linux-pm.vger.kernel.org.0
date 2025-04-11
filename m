Return-Path: <linux-pm+bounces-25211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAAA857B1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB51189C133
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE732980A2;
	Fri, 11 Apr 2025 09:14:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9654427C865;
	Fri, 11 Apr 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362848; cv=none; b=IuWX0HGExe8CB8D+xPdcaCpQkeZjGf7quIIZEN2cBfU20sz1T7Y9oK9BiU5p6+IZE6ArR4S4U2LRXVG9JtSzNTfb6Q8+UdeWJ39Hn2Mnbi9v/UkEFUze+jAykijaVCJabEFS7hStsKkBA0vKSrNuLhb06B7y0k3kVtMB3ZILQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362848; c=relaxed/simple;
	bh=E7a+VLvOKB5W9tiYzsAlpLHLtnyCT6ABiTee8X7K0bI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5zp1WjaCklSQLvIgNnh5Si3zcCVjCCgldMMjO787IfL1wsgXvjxVWPRpsXWKB+LTLV0pR4LSgdJX8FO073DfMqV8tAJkUTSiAotibeAemqi3DTu4xW6ywGnGqdBLBvFw7Tbm5Hzt/QM/NFFw1BgFzeYu8CBCp4o3lJLHItZvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627F2106F;
	Fri, 11 Apr 2025 02:14:04 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DCDD3F6A8;
	Fri, 11 Apr 2025 02:14:01 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:13:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
Message-ID: <20250411101358.03b100ba@donnerap.manchester.arm.com>
In-Reply-To: <20250410165044.766460-7-iuncuim@gmail.com_quarantine>
References: <20250410165044.766460-1-iuncuim@gmail.com>
	<20250410165044.766460-7-iuncuim@gmail.com_quarantine>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 00:50:44 +0800
iuncuim <iuncuim@gmail.com> wrote:

Hi Mikhail,

many thanks for sending!

This patch needs to come earlier in the series, before the .dts patches,
and I think ideally even before the driver patches.
The repo needs to be clean at any given commit, as it stands right now the
DT validation would fail if run on patch 5/6 only.

More below...

> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add dt-bindings description of the thermal sensors in the A523 processor.
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index 3e61689f6..70ac395ef 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -24,17 +24,21 @@ properties:
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
> +      - description: GPADC Clock

The new clock needs to come last, to preserve the order for the existing
chips.

>        - description: Module Clock
>  
>    clock-names:
>      minItems: 1
>      items:
>        - const: bus
> +      - const: gpadc

Same here, of course.

And don't you need to adjust the number of clocks in the allOf: section
below, to require exactly three clocks for the A523?

Cheers,
Andre

>        - const: mod
>  
>    reg:
> @@ -107,6 +111,7 @@ allOf:
>              enum:
>                - allwinner,sun8i-h3-ths
>                - allwinner,sun20i-d1-ths
> +              - allwinner,sun55i-a523-ths0
>  
>      then:
>        properties:


