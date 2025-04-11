Return-Path: <linux-pm+bounces-25258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FBAA85F73
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2D01888832
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543991D5ACF;
	Fri, 11 Apr 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYtYR9HT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461A13E898;
	Fri, 11 Apr 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379012; cv=none; b=N0z5RB5pP1pxMGh6ZY7PshWNByzPtYLhMHlrN+BLuMPogvOZn5cv+rq28MXssxOcPMu7Ut6lqfnnfWHfZVihtxwc4GZpV6rczywAnHdH9px10oKq0EiIGrye8e777BR7nWy8v+yDL7VeKtLzuVHZKtVoopKxZGkcRWoUqMm2oRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379012; c=relaxed/simple;
	bh=tliAMtv1OcJaSk4zt2mFjXPHpuo4+e2d80RH30k39qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9BMWAiVSINdGsFMg0i0jZSRbwJQ+P4iJXYcMtALcWOgp9rD/mXwWOJfF0rrbh5xXhz4UfxaqTHFCg66zRxgUxY9fhoM9XBRtXo3Ff+SjrNCgAZqjYQoqno+7wuRhHX/xMxqdUUz0YnWdlZvLW3gtozupv+bCwUswM9SBIvOhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYtYR9HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A24C4CEE7;
	Fri, 11 Apr 2025 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744379011;
	bh=tliAMtv1OcJaSk4zt2mFjXPHpuo4+e2d80RH30k39qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYtYR9HTZBwMP5Oi7bPretfsvPfOvYCRBS72D97j7i3aPPNTx2mrMavXTUE6McB9f
	 eTbX6bKtprpTBwHE2o48DSGO3p5BNHOT+nxdbcl0Gq6RpscUvQrNXjeLq4pZV15Afx
	 Ntbw5YpLpXkixY2/VcHFc1SpYlgJHv9tGOVUeceRLfMjUPmbLjGftwcOXvB1ErfW1k
	 z+rdIwx6u/uhB7vbmz8CcpHuPlSmtfoANznSJIhe/6W4TJ/goaw/USm8ZNj5qdPXgS
	 ozeIXMulaLNv2bYN3z3FZkW/VtEbFHxfl/4UuxBFw8Y7oE/dRrYMe50F5OZeTH9Rqh
	 3DtQX7+3B2iKA==
Date: Fri, 11 Apr 2025 08:43:30 -0500
From: Rob Herring <robh@kernel.org>
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
Message-ID: <20250411134330.GA3054295-robh@kernel.org>
References: <20250411003827.782544-1-iuncuim@gmail.com>
 <20250411003827.782544-7-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411003827.782544-7-iuncuim@gmail.com>

On Fri, Apr 11, 2025 at 08:38:26AM +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add dt-bindings description of the thermal sensors in the A523 processor.

That's obvious from the diff. What's not is how is the h/w different 
from prior versions? For example, why is there another clock?

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
>        - description: Module Clock
>  
>    clock-names:
>      minItems: 1
>      items:
>        - const: bus
> +      - const: gpadc

You cannot add new entries in the middle. They must go on the end and 
you then need to restrict the existing users to 2 clocks. And for the 
new users, how many clocks are required? 1, 2, or 3?

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
> -- 
> 2.49.0
> 

