Return-Path: <linux-pm+bounces-31138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A283B0B949
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 01:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AF81898225
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 23:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C5C22F769;
	Sun, 20 Jul 2025 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nky8uBrB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48377221F1C;
	Sun, 20 Jul 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753054905; cv=none; b=WcmI3k4xBLWuttuC93tu90SoFWrevPMZVoCZ6Mu7yTVLyLMeg28fYaNGJrjhzNtL5Ox9jn2eA9g3O1vkYmG/9y7Zey6RvI0NuVOqHnRva9AwNgxhVJoy8AVt/K754kAl4cAMQuNnWU+sAwPJVCag6nhZqAaG8KE3joKvbjeDGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753054905; c=relaxed/simple;
	bh=NhV7g08fNchnFfGQ92cKt4QKjfGGOaHm0GdCOyMWic4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwMJvXKvaIRD32qUQ0/h6SQseO8wbp3hXKTNTndX32XLQg1xuChfGwMKzMLP6S7xyXlZF9t5SaNdAgM+ovuSrZzTPDM914fspu+sQ2U40il/eGi+thyVi7/cPvir9oChkwnknxu5zRx9hNOcpk8U+RCCpcAN0nhELlCF6U70UWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nky8uBrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B38C4CEE7;
	Sun, 20 Jul 2025 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753054903;
	bh=NhV7g08fNchnFfGQ92cKt4QKjfGGOaHm0GdCOyMWic4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nky8uBrB/EvnKM+oitV/yd5SqlKBu3bud1ogpJumYos/CaS01zyftcs9h5Wd8Am8M
	 TlMV7ZyuwxqtmAFOHr/36PyMPDSK7c4LaTEItH+ifoNQqQPpI2yHHFzFItv9Six6Kb
	 fdFxcnN1UwsnsqlGzi4dNHddsF68OqHNS3Mu3F8NI255UGznsYRLUJK7LMkX3RjzHX
	 TsT3KnZVLf8cbCsQawOJGEL2eiMRHX5qpe7eluxFMj8JO+0fB7Xe/4sDW2uj0jqoMg
	 xm6XDyeeT8S3FLDkXie3zkBvkw5mFyJMXZX0ohP8CuuQxDNrne/6Vhj/O2DFxDhNgy
	 /GD4jswr3eTng==
Date: Sun, 20 Jul 2025 18:41:42 -0500
From: Rob Herring <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Liming Xue <liming.xue@amlogic.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: amlogic: Add compatible string
 for C3
Message-ID: <20250720234142.GA3079305-robh@kernel.org>
References: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
 <20250718-c3-thermal-v1-1-674f9a991690@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-c3-thermal-v1-1-674f9a991690@amlogic.com>

On Fri, Jul 18, 2025 at 02:37:41PM +0800, Xianwei Zhao wrote:
> Add the compatible properties for Amlogic C3 SoC family.
> C3 family supports only one thermal node - CPU thermal
> sensor.
> 
> Signed-off-by: Liming Xue <liming.xue@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> index 70b273271754..095b92aa5ace 100644
> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -22,6 +22,7 @@ properties:
>                - amlogic,g12a-ddr-thermal
>            - const: amlogic,g12a-thermal
>        - const: amlogic,a1-cpu-thermal
> +      - const: amlogic,c3-cpu-thermal

Combine with the a1 entry using 'enum'.

>  
>    reg:
>      maxItems: 1
> 
> -- 
> 2.37.1
> 

