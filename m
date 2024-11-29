Return-Path: <linux-pm+bounces-18238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D49DC356
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 13:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A9EB23152
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219719884C;
	Fri, 29 Nov 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWUAFgHO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649C14D6ED;
	Fri, 29 Nov 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882621; cv=none; b=MJ+ohojBmwmSeY70yzjglnFOS5/ro5s8iejAgyQhHzSlPeenL/WkIifJC6ZnBmpUvdXwVkqPlajAfpxiUfKZxn5O+8//CEhfgoVOTSgyqXbBoOOlpcRg3p2UvcrAIcmX9h+cV/JiUvRRSLJ5QRusr9WFpzfxwjhO3dULw8j72bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882621; c=relaxed/simple;
	bh=YrfkWkBNfUFcRu8D5OR5SjCDNZ0lBRUVOaoaAXnyOLM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Oi40NPkO0SN9+Z4zXvY7buZF51nr2rxS68MC7Yje90Of61QV9jh5c44Cdl1//7aiX+sZ812uPgQiWlr+SUnFJ+AcOlSDB1oZmrXOtFt25dW8oYdEEvlnZBubvxoGl/fL1dFVaIjivZyuXi1+u8dZTRspF7i2LMISAaz3gZ0x4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWUAFgHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD22C4CECF;
	Fri, 29 Nov 2024 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732882619;
	bh=YrfkWkBNfUFcRu8D5OR5SjCDNZ0lBRUVOaoaAXnyOLM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TWUAFgHOGZCLwaPT6XtWNTwwstx1LCnTc0yUiojlTFvQEmmmitYWvLiGjQsOFe0Sz
	 FFWhVPmdgX0fMLyzCiOTzpdjWe6EXi181cbRsRojIlnhtWQyuxPpfOuS2D8Ay5ZyPZ
	 jQrlVLQ1RHKMgSjojRACpDgFFgsqWBXqwoG3ksULIpQw4HM8OjmcpFcU8ryMmeru3Q
	 UEsVud37EvMh3wNbTSX8eoKNPhZr+W2hO/S+Wht0FBT3ulPOCOm/oOnWmNM+5Jlth3
	 OA86wQpaYFLc3vtxAEQcBvltf/6U8XGYsvQaTn7wEZ8mCCh7B9Ufs2XrrNaDTFtomr
	 WggCvaggsM9gQ==
Date: Fri, 29 Nov 2024 06:16:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 krzk+dt@kernel.org, sre@kernel.org
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
In-Reply-To: <20241129114200.13351-2-bhavin.sharma@siliconsignals.io>
References: <20241129114200.13351-1-bhavin.sharma@siliconsignals.io>
 <20241129114200.13351-2-bhavin.sharma@siliconsignals.io>
Message-Id: <173288261719.3943565.10177731429596139501.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: power: supply: Add STC3117 Fuel
 Gauge


On Fri, 29 Nov 2024 17:10:45 +0530, Bhavin Sharma wrote:
> The STC3117 provides a simple fuel gauge via I2C.
> Add a DT schema to describe how to set it up in the device tree.
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  .../bindings/power/supply/st,stc3117.yaml     | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml: properties:sense-resistor:maxItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Error: Documentation/devicetree/bindings/power/supply/st,stc3117.example.dts:39.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/power/supply/st,stc3117.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241129114200.13351-2-bhavin.sharma@siliconsignals.io

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


