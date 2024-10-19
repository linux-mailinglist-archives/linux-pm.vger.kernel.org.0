Return-Path: <linux-pm+bounces-16030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B09A4E42
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59DD1C2336B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520318DF84;
	Sat, 19 Oct 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK+Md1Zq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86A13635F;
	Sat, 19 Oct 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344079; cv=none; b=bexbWilj/TlHXZH3TrlvwEvthOFUlZVT4ua8UIGon0NjU3Mnp2IRmE0uyzEPjsy3WagMOwvFilKLYtiTu8szCvTRs0NXHBolWAZJyn0eVbXVZIafIlD83J7GdsnATq9dq5iOBiTb538Rh7OAItW3Eu19p3CnZFPpYzbyhCFIXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344079; c=relaxed/simple;
	bh=gQhICnSvSHv9yD1EiEkSUgTa69qxK8AgGvR65Aui+EY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ish9HOefps5YXwBWGCRlvU5QSpnHuuM51lRoiX1NlAXWAA2YmcGI1vgN1p+fpU/q5LDGBn/CX/nkuUcze21/JDgQIe02mWc5NEI2f5NfpSNffm/Scm0qKS2f9esN8uiW7/qKD8A+R6G1m0yz4j8qmYuSmNKtKmrWH25V770cl98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK+Md1Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2FBC4CEC5;
	Sat, 19 Oct 2024 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344079;
	bh=gQhICnSvSHv9yD1EiEkSUgTa69qxK8AgGvR65Aui+EY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BK+Md1ZqWSec5uuVwfaspttydKxG3jkKC1bmsSiYVCjlflUe1IquYCzDD4Eq0s6iE
	 JwlgJzC4anr+T/bbLII6Lku/ekGUKlgnuFrijiHAbJBkeP/bPByEUmmlr0Dv9nXywh
	 AFEerCPB2Bt1WtMl+Ux+qcF21RzN4AH1hByCdslIDFcXQ17vCuSEVVJopEO+9+xpVk
	 sGPkeH/A/gYxt5y8VMbGiQgGbLTA4lgCb4OyeIOVQjlUwpvkFBFm97Lfi9y8lKR4AN
	 GWuOjol4dVpCNmgJz5CEqyIbKqPNGMRGgsWH/hW778ODr8e6vb2j88ESEfliPltox3
	 MGSTMoYq7KGiQ==
Date: Sat, 19 Oct 2024 08:21:18 -0500
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
Cc: linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org, 
 iommu@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-gpio@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
 Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>
In-Reply-To: <20241019-msm8917-v1-11-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-11-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934406893.3231847.5057428038723447811.robh@kernel.org>
Subject: Re: [PATCH RFC 11/14] dt-bindings: nvmem: Add compatible for
 MS8917


On Sat, 19 Oct 2024 13:50:48 +0200, Barnabás Czémán wrote:
> Document the QFPROM block found on MSM8917.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-11-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


