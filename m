Return-Path: <linux-pm+bounces-16805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B29B7645
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F216283E5E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E553A154449;
	Thu, 31 Oct 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X230h09V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55414F9F4;
	Thu, 31 Oct 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362854; cv=none; b=eMRieOm55U7AhT/q2nDxioxvFXW+2vY9AtU2VH7VpAW9zSnMSxu3bwhm/Nr2ivGLJTCzx4OfsSQrJPUo9vQXMMriu8/Cy67wIgwxySh7CjfCtlWB79b7nCOeuE0+dxKQRfSeHeCi1UvGwsk97+VFuCmGiFGNQ+o/0UU7wXSrhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362854; c=relaxed/simple;
	bh=FEGPr7eoy84GzZDQ3he5fsI7b5IYOckek+ZGUdMQ3zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSScZTH6PAQy5LcS7W3fYLvf6eU00L0I7/sZLbTIrdgxjejYgKc5TApHjmVvhdWfkWJW7ei6y7m81QQkOdH6dvzlfco2fgNg58IvtjMNd71Vei7NV6J4zeuKBJxWOvk+i6/Or3NUKOe+fHx5qC2GvBwYGwYvKZ0z97W/lFdSWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X230h09V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FB9C4CEC3;
	Thu, 31 Oct 2024 08:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730362854;
	bh=FEGPr7eoy84GzZDQ3he5fsI7b5IYOckek+ZGUdMQ3zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X230h09VEu91FWvNPPdlulJt5QeNPUDnihiqxFwcSSI3VQ3KYfTLwJz5+O6KWdkEp
	 swSZlf14rQZ3qsqSihlLlHkBlAtOh8GGN0x8s25LTwdm6bclvRBSDrLHSYyGVwlgjR
	 t/7qEO46rz7oHJVe0nOcklX+cJy7VfhhaZHIc2e+JbpqrQczOQJS+7YYLYWWi0IB7h
	 R1kWVWjqKntwD2IsCZbr3q/YOF5KaaLUUSUgiADjkLoodhYdQQOfFOXdQ6BKlaTn+s
	 3KL7M1bn4HQ3E6sT0XQ8BVjPj69uFpA0FG4FKI5EjOEOmGN4AMtufRYm4PSUtAc8cM
	 iPjXuFBhmm/AQ==
Date: Thu, 31 Oct 2024 09:20:50 +0100
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
Subject: Re: [PATCH v2 01/15] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
Message-ID: <6xwnrlxyladajzp4oqgksxzsvwuff3p3zpw46kogxen4hdamig@zbvgrcqetpmo>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:42AM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Document the 8 GPIOs found on PM8937. It has holes on
> 3,4 and 6 pins.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


