Return-Path: <linux-pm+bounces-36823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F629C08B5A
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 07:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FA764E5A4F
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 05:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1D298CA2;
	Sat, 25 Oct 2025 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLGSFs9r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475027AC41;
	Sat, 25 Oct 2025 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370142; cv=none; b=biNBjH+Z1+KcHmcGsv9UDkvNMeuE6N+9UXioHQ8Zt/4fHBblYr+jdNcYy7G6ECAwJ+WAmAKz3Zn1LlOHUaFdN6JglzAL5lcfPGXW+w2Ptx/myLTewzEZ7FzuZ6xOYJpyU6q9sdkeKhcJgrtMLMtk4j8z+5JLkxHmz/eqmaWlVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370142; c=relaxed/simple;
	bh=MBe+jjtIDr5IzoKNMAI2MGqHi0h3OkoveqndsJQpEK0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=f4Fh3aDuDU2oBaGTpKdzTzY1odgXezBxJrhbyS+Ut/pyr5rYYdi7FxQ69ULv4MlwLVgZiL+IMTxbA4ERTKn39azPUxiQMkvCg68+qYG7dzPxn3jdq9mqLoqAwXIO4XrR+h1w3pZzc36oBg97NUxnxi2xRkHwHD6EEVfev7z69uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLGSFs9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A84C4CEF5;
	Sat, 25 Oct 2025 05:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761370142;
	bh=MBe+jjtIDr5IzoKNMAI2MGqHi0h3OkoveqndsJQpEK0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HLGSFs9rY1X/SHLe+lLF9c+e3TE8ymj+c9UGRxTkzXVc/ublB4JRB8wN7MngtMawh
	 LZBHigEL6GrNk6xZRJtpS3KCaZjizM1aYu0bTsrI3bDUOowU/36cQ7ocU8f9BWEJk8
	 /kdIpkC1EeHaejB3xc/dxjUb3fOh0iIPYpYp7QWvD3WoTWMNOuajya9NW4Vm0WxP+4
	 h9SrzHniO8fP1zcbGLtQerjTk9/M7zLb+1BM0gv+zUZwE36T+0zUqUwyp3Z/p8fW9l
	 /IUVa5J/aN8qUz2ZrZ66yYREm3nBmAwTgYzAzRqEoj9PMES7yXZ2DQMRyRCW/v7/lX
	 o5RTO9O2snzeA==
Date: Sat, 25 Oct 2025 00:29:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>, 
 Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Yangtao Li <tiny.windzz@gmail.com>, Samuel Holland <samuel@sholland.org>
To: iuncuim <iuncuim@gmail.com>
In-Reply-To: <20251025043129.160454-2-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
 <20251025043129.160454-2-iuncuim@gmail.com>
Message-Id: <176137014046.3772400.925640654044482315.robh@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers


On Sat, 25 Oct 2025 12:31:24 +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add a binding for D1/T113s thermal sensor controller. Add dt-bindings
> description of the thermal sensors in the A523 processor.
> The controllers require activation of the additional frequency of the
> associated gpadc controller, so a new clock property has been added.
> 
> The calibration data is split into two cells that are in different areas
> of nvmem. Both controllers require access to both memory cell, so a new
> property nvmem-cells has been added. To maintain backward compatibility,
> the name of the old cell remains the same and the new nvmem-cell-names is
> called calibration-second-part
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 56 ++++++++++++++++++-
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml: allOf:4:else:properties:nvmem-cell-names: {'maxItems': 1, 'items': [{'const': 'calibration'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml: properties:clock-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'bus'}, {'const': 'mod'}, {'const': 'gpadc'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
Lexical error: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dts:126.25-32 Unexpected 'GIC_SPI'
Lexical error: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dts:126.36-55 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
Lexical error: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dts:127.26-37 Unexpected 'CLK_BUS_THS'
Lexical error: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dts:127.46-56 Unexpected 'CLK_GPADC1'
Lexical error: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dts:129.26-37 Unexpected 'RST_BUS_THS'
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1528: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251025043129.160454-2-iuncuim@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


