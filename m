Return-Path: <linux-pm+bounces-16029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D39A4E3C
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1B1C2106E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81776188A08;
	Sat, 19 Oct 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB0fG0oL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BE18734F;
	Sat, 19 Oct 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344077; cv=none; b=QtZ72DvvR9iLXg135cxNclGUzcfgT+7i/Vpr/WJb2o+GRRP6R5DuZCn3+zb8pC7OzL1AG18YIbFfaLuJ/Pflz3W8dG/zaJAq3M8HOZEFCnGFvGSaHQ6EPiAcZdPwfr16Mn/W2dS+H0OFcZ36nfKmAKERINLL0UtlaqHoqX7vAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344077; c=relaxed/simple;
	bh=uz65MZHqm91U1b3AiMM4JZkVFGTA2wPr7A12uXrXE8g=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oNF7WV3hCnGAJumQh4VS5D1AWAREtztTJK3yN3uupIGiXg9vlvfg3dLO4KO8MtiK5LFE0NU64w+nJQV7Su2hcQqq41+eplSZH/fQZh8oLlSY9AKcp5MT7hXjq455q1/YeLGOzllnE1bh916tJoieBu9KifjNgHwnmj3RVYNwAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB0fG0oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B6C4CEC5;
	Sat, 19 Oct 2024 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344076;
	bh=uz65MZHqm91U1b3AiMM4JZkVFGTA2wPr7A12uXrXE8g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pB0fG0oLljFPdfaajFI8a7GQC4KLcKxU8VHyyPBZh75Bc9MGNx+C1q2AgJ4bhUltQ
	 T81oVMy4AKY0vlfPf63Dxh22hXje0l+Ow54hxKSyykQlVLTV/+hQ4H3DM9S0Np476J
	 bYAQrN0kJ1rXuGo/UluKsFUr9/wM0MwlSNbKz4oknzkogOFiHLNJkunzePkLZYxZqc
	 8hJ+RHJFUoXFKFV6N1MitOV35W8rNXHBoGdC/43QFi+X4dPgf9W02tje6sGNxm9YOG
	 uwTWwVIhlhderKonjpQQA0ul4YCJYhsPdGNE/q8iXC+CwN2XcIzUPLO1SVWKVA5ksx
	 LlITdJW65iHwg==
Date: Sat, 19 Oct 2024 08:21:15 -0500
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
Cc: Thara Gopinath <thara.gopinath@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-gpio@vger.kernel.org, 
 Lukasz Luba <lukasz.luba@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Will Deacon <will@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20241019-msm8917-v1-9-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-9-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934406611.3231743.3141053067673883115.robh@kernel.org>
Subject: Re: [PATCH RFC 09/14] dt-bindings: thermal: tsens: Add MSM8917
 compatible


On Sat, 19 Oct 2024 13:50:46 +0200, Barnabás Czémán wrote:
> Document the compatible string for tsens found in MSM8917.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-9-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


