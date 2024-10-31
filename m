Return-Path: <linux-pm+bounces-16807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92C9B7650
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 09:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EE5282ACB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ADA154BEA;
	Thu, 31 Oct 2024 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7OVgWjl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D81509B4;
	Thu, 31 Oct 2024 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362932; cv=none; b=pjZlVtPs8bpzfyRtnq5s06FS2AuWiuxlra0ucMFFxrqKU34MElLQZXyQzj7ilXkZdGG5SBBwU1tXmQwY9IFgWYWcGIy7JCEezN6Oyrzu8WJ10zRN0gEiHbm94LSneHjBGMnhclGm7Uyy+EZsJBPq/5/5rhb5kVpduwPVbkJwEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362932; c=relaxed/simple;
	bh=iMQsAvtgf1C6HFetqzQc6MDi4RaxZpL1fb4SwcciNaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgOPxx8pPXJN0YC23EioWyGJ/zgcPsJhkUTIsAcC4DisZtsN2pkBkmBqanL+3cS8RW/HTDnmLN6p5DlYnp1W+GxLgtLc2OCFUFw1ByicKzMD2gL0lulcW1b5ip0swPdf7MC5sAHtrM+1BnVq3c1YnQhLj9fLr9bV8Fow73fAYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7OVgWjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14225C4CEC3;
	Thu, 31 Oct 2024 08:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730362932;
	bh=iMQsAvtgf1C6HFetqzQc6MDi4RaxZpL1fb4SwcciNaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7OVgWjl/mrLi3qI0hTRX+uqXcCzAN0rn2C7eBE9A4iaJQ0p7cbaBY0eAAiFlWNAF
	 Cjwg1SZBGpP/258UtgeJiXEXc/oAO7dAh2NbclkYX0K1NVP7SFx5oyJEfdhJipR3Ot
	 xVKM+JZiHui91/XcRntc8j9zwwV2QEiAPA8o4VorCmQcTtGXBNQNU9bCs2pZh8cOpa
	 pQtOWG+2ogIWpSVcco3NhtaBJZPp2ZVXbreRkcp2VumegQKcLdd6ZpJ/p259lUfVjV
	 ez2mTZ3DhthKDqQp60y7s21V75q4g4K+8RupjJY93j8DN6QPo2fvMOinKPRXP/WlNa
	 1uS/0WZD3jEYg==
Date: Thu, 31 Oct 2024 09:22:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 09/15] dt-bindings: thermal: tsens: Add MSM8937
 compatible
Message-ID: <ctnfz5xatrksie3eu6uvgwrkbqmkfn2nrlo56hwvwjlm75ftn5@gs56ggh76hxo>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-9-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031-msm8917-v2-9-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:50AM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Document the compatible string for tsens v1.4 block found in MSM8937.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


