Return-Path: <linux-pm+bounces-16534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13D79B2156
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBA31C209DF
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F818952C;
	Sun, 27 Oct 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILViyzp7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A66161;
	Sun, 27 Oct 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730070802; cv=none; b=hPK4dL72x7Z5Jg3tnAdbyCYztsMGrty+D7CCuyDFWWNEaoRxRPu/8S9gl2MI8Xn2XYnpUDslCaShvmK1U55vdHYx+QpjBZKFVq6i8CslOsqcHizfEq8LWmLE7Xxql34DBpJhhS12QQBwtbxhdvIUd8lDIyijaCuLCXUH+DdQ9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730070802; c=relaxed/simple;
	bh=/XC0fCHixgr2EOVeP3XO7qlWEpFr8F+vd5s3Nqrv5Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXeKzN9i2CBw7FYJ3p43vAJ650hsHGNoRVZDR8pNdI4ZslJgWFkyNnvG4+6hTaQz/lx7tD8QcPfLIKKg6wNvf2+USaTf71MdbjjU4pIqnOBQIi6oRtvoQfaYvbqCUC0KBJcR5Jnc9JXmSFFFLigPHeMLRizy4BRaiy/qHV813uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILViyzp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A640C4CEC3;
	Sun, 27 Oct 2024 23:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730070801;
	bh=/XC0fCHixgr2EOVeP3XO7qlWEpFr8F+vd5s3Nqrv5Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILViyzp7e2kW1Y6O/KR0gJyw6avHfFbOeEjYt4z+RdgspP+7kOLyWlBmdSGpCllkR
	 n8+CbGhxkPPA/OCGOdi1hKK9N+g6gJ9jCLCNyNpywHnpHNk8jTQ4a/malXgpOvRtA7
	 eZZ4DWBmHv+akXLezfq4J3Y9yMGqT8geOnOTeiT2QM+dvNWGfBXNFOIo26ii3FnxlX
	 SNHbHYVxSrMVyv5YdwX59a2Ip8bpJQmyWqtkXeTvcEMN5nvNaIAq3NcrBe/ZOLbdip
	 e4ZKn5g2T/pHZaVfxSgfl5YO/ZhA/fDADiECSId/wO+DgWwb0WraBzbY1qz2qlxJx1
	 R8tvmigQATdBw==
Date: Sun, 27 Oct 2024 18:13:20 -0500
From: Rob Herring <robh@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] dt-bindings: power/supply: Add ltc4162-f/s and
 ltc4015
Message-ID: <20241027231320.GA217360-robh@kernel.org>
References: <20241027071852.56240-1-kimseer.paller@analog.com>
 <20241027071852.56240-2-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027071852.56240-2-kimseer.paller@analog.com>

On Sun, Oct 27, 2024 at 03:18:51PM +0800, Kim Seer Paller wrote:
> Add support for ltc4162-f/s and ltc4015
> 
> - Add compatible entries for ltc4162-f/s and ltc4015
> - Include datasheets for new devices

What's the difference between the l, f, and s variants? Please make the 
commit msg describe that rather than what I can read in the diff.

> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> index 29d536541..9b546150d 100644
> --- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> @@ -17,12 +17,18 @@ description: |
>    panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
>  
>    Specifications about the charger can be found at:
> +    https://www.analog.com/en/products/ltc4162-l.html
> +    https://www.analog.com/en/products/ltc4162-f.html
>      https://www.analog.com/en/products/ltc4162-s.html
> +    https://www.analog.com/en/products/ltc4015.html
>  
>  properties:
>    compatible:
>      enum:
>        - lltc,ltc4162-l
> +      - lltc,ltc4162-f
> +      - lltc,ltc4162-s
> +      - lltc,ltc4015
>  
>    reg:
>      maxItems: 1
> -- 
> 2.34.1
> 

