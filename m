Return-Path: <linux-pm+bounces-16811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C19B766D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEABA284117
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DB616A92E;
	Thu, 31 Oct 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeEFFMZp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8C14D2BD;
	Thu, 31 Oct 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363184; cv=none; b=BANHB4Tmn6TY9aPtj8CbCzktaYbXx8R6DP+r61rNzjorUGFTgsIrEcM/jzj5e+ryL4dBwSVNhrQXTeEVJzAeHl+ZnisN/XV7VjO3jI1FooS+wuhCRun2sg8L6aY/cCBI9qsIj2DpzSkrOsrZuRHtjXUysEdvOvX/339FFw53SDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363184; c=relaxed/simple;
	bh=UtIXWQBAHO8WTXHrZu/AkAEBVnJP9D5emFtpxuIFMvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJxRjcPvBiPowW0rjTI2+JVsn2MDYZZFJVNpZg90CdVP+jkMJBtBblnqnK5hUE8RhPL064ujUX2+d8qwbBP/uW6/6Ny7xPo6zGzSAXxJALtWwCtwX7k2VUmzF4UWX0Wd4QrDgS//mgPEUtpei7N7lcn6b/fI0ghuV0dOdYM+s5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeEFFMZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C27FC4CEC3;
	Thu, 31 Oct 2024 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730363184;
	bh=UtIXWQBAHO8WTXHrZu/AkAEBVnJP9D5emFtpxuIFMvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeEFFMZpP6DoCamFnyQ50bv7Ao+RUdeqE4tPDB9lEajI5qk2EDrEyOpQHSb0gUsU5
	 HG89lfnC8iI0g3+6xCEobTFObjTDgofn056W3QEayJqaU4bABRZRDUulP7e2lZFTRh
	 HXbJpI95d7O6dnCVMbWlIWg3fJVeiAfVjOLAXylxE4O9AyIH1WW8FVFQf+CmT31FbJ
	 NS8v/xn8WWWtR30KAE6PwjsEASvy5BaipWMH/hCZkTmtR8+BbHo5Mex9hFxA6i9z/p
	 skiG0/MLzCHUdNxbQqDCNFfkNxr/C8klT8NSj9r6ua0AXlLJmMxi0BCRjXOnW/M4/a
	 66i6Kd81UPsQA==
Date: Thu, 31 Oct 2024 09:26:20 +0100
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
Subject: Re: [PATCH v2 12/15] dt-bindings: nvmem: Add compatible for MS8917
Message-ID: <xumpu7pmqkspjo54adg6xbnavrgqopwchr36gbgajhzzuq5wuo@cntjka45h577>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-12-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031-msm8917-v2-12-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:53AM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Document the QFPROM block found on MSM8917.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


