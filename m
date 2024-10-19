Return-Path: <linux-pm+bounces-16031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E09A4E46
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B20F1F2597C
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B3B18FDB9;
	Sat, 19 Oct 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpBi8EkO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93618EFED;
	Sat, 19 Oct 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344080; cv=none; b=spKRPOIvhn3r8ChAZxgvgR1Z2yuY64gcUdZmz7mLsWPrJikEIboXeXKYRnw/I1WqwU000R6qTmuVfaEvrraKTYjErjkVQrYbb6FOsdlzWOxHcWBLo+n4hxXGsKvZaHl3Ze9heKZvRSp3PWUIN6FhjQiCWL6/2d0QHTrtllilxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344080; c=relaxed/simple;
	bh=q7fIMWvEeO403QIX9kaH38XSloQwTbU8a+27gR0coIY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=C/31R02jIiiuCeK8328gseEGbVHQihKYWGYqs8ni3adD50gzL/V3P5dB5tLaww3GLdwwi9A9kp6/Ruum+0j5VlSuWFz+sTWwBT32z90LlB2QaEtcf8LvNs7StsrW9YubHbNiSf8A4F92eqKrK8L6KAovdMriBDxSMDLWnFWRpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpBi8EkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D15C4CED4;
	Sat, 19 Oct 2024 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344078;
	bh=q7fIMWvEeO403QIX9kaH38XSloQwTbU8a+27gR0coIY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bpBi8EkOKNHDrH3nSMZVuTgugmoGNvxYPgW4decsipisidnYT8KCztvNz/spMm2rO
	 +X2SubA5qLYHzaRro+EBO0/OuFge5QlM2D+Hgt9/5grmQ9cHIwD2sLG1wIvC4e735w
	 DPf148mkTnpqs/v3hOoIx/s+/4b7WVyFofMdggi2C0QVxqaCo/OQlA7wnQhldZjU6x
	 IdjXL5UWZYIfx0rcnJ5KcEE1vSni4Vvi4Fw9l2tFv0f/d26s+Qnuo1mn23k7rM6svi
	 lnBD30NGSZKCFOdK3lbE3WcobympJaxWwI9ChQUKi3EtPiG19C7C71cwHNqAI6ZATX
	 xPHgPrXUIlqcA==
Date: Sat, 19 Oct 2024 08:21:16 -0500
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
Cc: iommu@lists.linux.dev, Zhang Rui <rui.zhang@intel.com>, 
 Lee Jones <lee@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-gpio@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pm@vger.kernel.org, 
 Amit Kucheria <amitk@kernel.org>
In-Reply-To: <20241019-msm8917-v1-10-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-10-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934406753.3231809.282041778335117501.robh@kernel.org>
Subject: Re: [PATCH RFC 10/14] dt-bindings: iommu: qcom,iommu: Add MSM8917
 IOMMU to SMMUv1 compatibles


On Sat, 19 Oct 2024 13:50:47 +0200, Barnabás Czémán wrote:
> Add MSM8917 compatible string with "qcom,msm-iommu-v1" as fallback
> for the MSM8917 IOMMU which is compatible with Qualcomm's secure
> fw "SMMU v1" implementation.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-10-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


