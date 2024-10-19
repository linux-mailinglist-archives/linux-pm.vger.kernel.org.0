Return-Path: <linux-pm+bounces-16028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4DD9A4E38
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC40CB22488
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA015B10D;
	Sat, 19 Oct 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRuW5yvX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3C13635F;
	Sat, 19 Oct 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344076; cv=none; b=AiiJ0SsQGX4VtBQEX3TPnADeDc8tB/LYat2C7BYtBP33NvoguuIyjE+cn30u15/3pvir1LLIYZ/h57RZXLJ/Ff3HPg6TctkdqMFr8+Hdzg5sstI7REcvZaoIUweCkS1J5ezm9hl53wFaDhrtOHuAnLv9er+PodnbLPfBVSTn31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344076; c=relaxed/simple;
	bh=miGmSpPgNCz76tl037DQV8N+1tOrZIQXLN0+FIV2qXg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GMlTDUlO3tTgv8sZhFFIwIOz1VqnqSEnyIONzWDQwPCcOCKr2YiWVooRU36C/DoLIhpSUpO7e+XDzETsuv2T0SnCeBzMYapAdxXp5Vlm+OI4WkHtx/3rnH4xkdot7ftd7f5oOcEvPKdnR3z5N7Wc51pLpSdhM8RhP8XTjs1XBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRuW5yvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3DC4CECE;
	Sat, 19 Oct 2024 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344075;
	bh=miGmSpPgNCz76tl037DQV8N+1tOrZIQXLN0+FIV2qXg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oRuW5yvXcYCFfgAPAbAW0dZDHLdWu22dJkJpeuPhZx6yqiD5WYxn8UAYJsnEAIGnh
	 50Ev5qAtcJd4Qd4HSBjP17q5O8X5muMH0fDc6hPs1VH5bVWjdFDTtPyHQhIr+6ULkp
	 y3+nNu431IJnzlYFxyEWkD39k22JFlyD+VZo9266M8ZjyZTtlIJdXDm9ZvUF8+xKDn
	 i/2uxUZ1bKpzyAySZsLl0ryUbgKeXrcO1pVyTE9Jy5fiB4VFhuWY2BRyEwAF13YQBX
	 2A+hLa0VtvJtKAjnfFLs0U0Ich7fMfC7eeXa/AfEuU/AicXWJU0mOwWIIDTEHU9OsL
	 K7/qf0zsE9xjA==
Date: Sat, 19 Oct 2024 08:21:14 -0500
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
Cc: linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev, 
 Zhang Rui <rui.zhang@intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Thara Gopinath <thara.gopinath@gmail.com>, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20241019-msm8917-v1-8-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-8-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934406466.3231704.1975557906882710451.robh@kernel.org>
Subject: Re: [PATCH RFC 08/14] dt-bindings: mfd: qcom,tcsr: Add compatible
 for MSM8917


On Sat, 19 Oct 2024 13:50:45 +0200, Barnabás Czémán wrote:
> Document the qcom,msm8917-tcsr compatible.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-8-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


