Return-Path: <linux-pm+bounces-35660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2405ABB2665
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 04:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED30327118
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFA157493;
	Thu,  2 Oct 2025 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyDfaXMj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C8335C7;
	Thu,  2 Oct 2025 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373626; cv=none; b=LtecOUzvCpUhsgbYNU1tmHjPWgfBdFbhnh4ErIxD34tL4Bdqcv5P8SFiWFcxhPGf6KBFy97wQhqYuCERzJy5XwWhAQbX/iaAaPY2tCIN/fYbOzJCHdIw99twPlKFSufzScGVS9l7Zec7AqDxahTvw/yHW8j9LhpLdxt51RWr52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373626; c=relaxed/simple;
	bh=k5Fo7WwY3d4EfZhjNQelpmfw9Ke+RYCe8Y1iFx4rh6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbcfAIEU4tB0oG2Q10C+j65voPXprB5Jcne70pdoyse10p82x0PpU9UvvcBT4BO8XPtyAZEc5y5WL7Gb+X3y8WFGfJwQFFW/c32J7z9RG0LprAc59vL3+Yhxk9ze50Pknj6F8yIttzc4cnaJthBI6EPxHkH9Rvk8WI2lKyRMDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyDfaXMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9B1C4CEF7;
	Thu,  2 Oct 2025 02:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759373626;
	bh=k5Fo7WwY3d4EfZhjNQelpmfw9Ke+RYCe8Y1iFx4rh6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyDfaXMjrk99bGqmhy78acCjsU/K613xe7YU9tO0izmOmI4uhnQsY/iZT/2TbIMpE
	 MoBuwV6NvjgHL5i8YXGAX9DuIsL8pVKi58vNuS7ijeUJbWzhafrtZ1PYkM30AyS8nb
	 jUv2RIujj7kPYZ3/2XnZZZkGVeCDRaSEbXB4KyygfCo/QZj7K2VsKHPkR8Oc2JJGy2
	 iDJpL963nA3Atv+S53scx/gWeaBRSdHmu3udIHV4W4P++He3Xq3c9E9e+KpImjfktN
	 qpQK3XLBWSaJQsdmU0UgLd22yZmO47Y9ELThsU2OhSt0stLM7vzfIn66/WDyIUb8Mf
	 a3qj3TZLufFFw==
Date: Wed, 1 Oct 2025 21:53:44 -0500
From: Rob Herring <robh@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: mfd: sc2731: Reference
 sprd,sc2731-poweroff
Message-ID: <20251002025344.GA2958334-robh@kernel.org>
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
 <20250926-sc2730-reboot-v1-2-62ebfd3d31bb@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926-sc2730-reboot-v1-2-62ebfd3d31bb@abscue.de>

On Fri, Sep 26, 2025 at 06:23:24PM +0200, Otto Pflüger wrote:
> Reference the new sprd,sc2731-poweroff bindings and add an example.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> index b023e1ef8d3ccdb1d82d64ed1a60d5a712a1b910..a78d7e26b3a2c77b84da84fc23e52f3a22ab14df 100644
> --- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> +++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> @@ -52,6 +52,10 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  poweroff:
> +    type: object
> +    $ref: /schemas/power/reset/sprd,sc2731-poweroff.yaml#

You don't need a child node here as there's no DT resources. Just make 
the parent node the power off provider.

IOW, a node with only a compatible property is pretty much always wrong 
(though yes, you can find examples).

> +
>    regulators:
>      type: object
>      $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
> @@ -221,6 +225,10 @@ examples:
>            reg = <0xec8>;
>          };
>  
> +        poweroff {
> +          compatible = "sprd,sc2731-poweroff";
> +        };
> +
>          regulators {
>            compatible = "sprd,sc2731-regulator";
>  
> 
> -- 
> 2.50.0
> 

