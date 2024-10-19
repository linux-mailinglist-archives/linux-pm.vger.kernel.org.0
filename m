Return-Path: <linux-pm+bounces-16032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033249A4E4A
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA586286D8B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33C19067A;
	Sat, 19 Oct 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDRdH2Vj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2409B190074;
	Sat, 19 Oct 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344081; cv=none; b=Zpbq3h2T+zWOielULeH/in+igpCclw3YwNZz/A4aopjfC6HEWOF92368VlxR3rI2v4xE44cUvTFrvZMfST6OTTm2FK8KqDreAsWD/5y0Mfgmdo9VwL6EuohPR1QKgDCdSYMhMwvZa55plnjzvDgPksat+Z/04qYIYnfEb+GiVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344081; c=relaxed/simple;
	bh=or3247cKJ1jKd4U/sgvypGpqvn18gzAUK+zAzepboWc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=RasJ9m73VDGUY11rN9m3EcVBNYZPZ3l9QZsfroOnaBB+7X27cpxNGXWdqWD6bvXcCuLSvAB6OPYlDZzXw3Rk+yl5w69Hqi5rEHEUv1DkX0FeU1HO5QXSAVTcIEjs4Jhl46jg1HezKRIYa53/7DwYMdSn3LtTmB1JWrDFQGgsHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDRdH2Vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B64C4CED1;
	Sat, 19 Oct 2024 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344080;
	bh=or3247cKJ1jKd4U/sgvypGpqvn18gzAUK+zAzepboWc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KDRdH2VjyfkDPGVIvimt99E565twkG3eVFjqmTSCjYICabR7cl3Xl0YZVdOYDGwS4
	 wJFUJKvGuQeFOlYDvEnXujaj4tSG3kKdJ8L0oOOh9+uOm0P7TWybkjTyMUYzLte3JM
	 u1LSFQKbg9mQf9vyTDuCaZk1DOQ6cVCJlr1zHWzXy2+jlMfWQ46I9tDDjf0MoyD/Kz
	 KBkEbXJrPNZ3HHBwVA9jUjannhvRFOup7HqO1+f7nfyPyJrH+pp36T35/8c8KPAWyr
	 wkNlvb8NLx+mG7hVwRg0J4+mo8nuYV2KgRutTVnQXbkTMMsVY1FrJwpZl3LEJC7m9b
	 X9m+Y9levIQ3w==
Date: Sat, 19 Oct 2024 08:21:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Amit Kucheria <amitk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 linux-gpio@vger.kernel.org, Thara Gopinath <thara.gopinath@gmail.com>, 
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20241019-msm8917-v1-13-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-13-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934407034.3231899.7392899989980103960.robh@kernel.org>
Subject: Re: [PATCH RFC 13/14] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A


On Sat, 19 Oct 2024 13:50:50 +0200, Barnabás Czémán wrote:
> Document Xiaomi Remi 5A (riva).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-13-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


