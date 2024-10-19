Return-Path: <linux-pm+bounces-16027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062449A4E33
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD18A286CB6
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDF13D281;
	Sat, 19 Oct 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMgHac0X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998B179BC;
	Sat, 19 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344075; cv=none; b=RoSFuJEfAm6R5p9zjXJj+j0zRNbhxVJCAUYnXpu4nf55WpNqR0G/lR99+f0ynXfk1+EAH74HWhN2Wq44btx4T8qVOLKBIBqx1hLc/9RK+wxkNmf2HSzLMqVTtn/7IXI0v/rnGvEweYpoyt767TE30OtRXGRYStShGV3k0+1BdAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344075; c=relaxed/simple;
	bh=1gvvEFBwFBXin6yqZrPUD4LNna7GVVr8y4TfyI5EhGc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=daih3A3yc6Yr3UklUqDHBwipvOHbjXkvNU1RSAJpiZRTvAjA9hwsv15Potc9iw0q1vzQ1YDZp9C2Wz5/7O+MtVpkcdKKIwR3zt+Jn66t/6vc8Q4Q4JFsOvMenWKdvJb+fYm2TrYZ1yyLJLKFhFIhrwFdzH5lQwUAqE3QkdK9vOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMgHac0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B49EC4CEC5;
	Sat, 19 Oct 2024 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344074;
	bh=1gvvEFBwFBXin6yqZrPUD4LNna7GVVr8y4TfyI5EhGc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HMgHac0Xd7kobhbzUZcWGaaEuq7saSmCEn06k2s4BgPwobRuq6T3tgiw9O/LurHCI
	 xpCicdfBk4LumpdixiQfJanSV1AsEphPqnx+l/rMVo9ye5zKuLDLeo5hSxfH9M3OaJ
	 LmAP3zVZ4spdT0onD9xT+bI2CwvGiRFntG7JC/1TwqEUeMYrFrZvu8nN9LP3hwQ+6G
	 SSKY4Xqy8zu7yT8YQ+7NrO0WoOOGaZY7bi1HQud5wDdC3wTA3qbf6xuERq0Hia9Rll
	 x1Va+UXOVKKDEv9aO2h6INIceYHeCBFuUL0oum31Rdv9saFNkt71DC/zTO/lphGZPt
	 CVzt05Jdc5p6g==
Date: Sat, 19 Oct 2024 08:21:13 -0500
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
Cc: Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org, 
 Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 devicetree@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 linux-gpio@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, iommu@lists.linux.dev, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Will Deacon <will@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>
In-Reply-To: <20241019-msm8917-v1-6-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-6-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934406329.3231662.1363402863577036185.robh@kernel.org>
Subject: Re: [PATCH RFC 06/14] dt-bindings: pinctrl: qcom: Add MSM8917
 pinctrl bindings


On Sat, 19 Oct 2024 13:50:43 +0200, Barnabás Czémán wrote:
> Add device tree bindings documentation for Qualcomm MSM8917
> pinctrl driver.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  .../bindings/pinctrl/qcom,msm8917-pinctrl.yaml     | 155 +++++++++++++++++++++
>  1 file changed, 155 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,msm8917-pinctrl.yaml: ignoring, error parsing file

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-6-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


