Return-Path: <linux-pm+bounces-8432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48388D4F1A
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AFF1F22564
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77A17D892;
	Thu, 30 May 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRP95coT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7C13212C;
	Thu, 30 May 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082977; cv=none; b=fWDH0+mBgJaGbWUXkEPzMeczg9RCQKtsaSO1oxII0oxGsE2K9FM1L8YcuCNBeJIS7qJedC/xYofSZ7ITnZ74qr+ygNVDr0O7GblTxKiNEzCR7WQf9C26pq/OpFf7lwWPYsk6OrD8abHecFw18LyI7kQtVlOmOG/HqEKO/EqW7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082977; c=relaxed/simple;
	bh=Gi2b4tAeapnVFAVHATW9DZyWTw7+azG8pibOfQ/C8e8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sbQCiKahrisEDEvllruYyrY/HioO2P6h6TAlg5w9m7r5lwEqTkN2VgwDjKqXG4pkhvyYifnRivtCFrVcLy/4cQkdasvBohIvco2W1BWHO01orMfMUrzo0k6Hcchw6foD8sC9ZbjN6X3sD+suIBnO8G9JnrAG3TANr5sF4R+OAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRP95coT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB4EC2BBFC;
	Thu, 30 May 2024 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717082977;
	bh=Gi2b4tAeapnVFAVHATW9DZyWTw7+azG8pibOfQ/C8e8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vRP95coT68pAHJGBDi9kVMTJ79uAxqNsBKkOE7p29gfV0pBjoJlkwJDsQn8qnUevx
	 j/BWVwTSOHbEz6cNq3tQ6JsSgd4RNTrmK3YTK4ARwD+WfahSqquHNcXLySqnILMPFQ
	 SKCLHykULGRWDBwl/LIVAT6TxMXiXIL7qPJPATG+gZVAvfCG0SAGyMQCh0X+b7lZId
	 Ilau25M9Vr7x40oj/UCveD5JnyisJIUhvp7NmF4PlqzcFCuqNQR2XeHJREN17NwS8K
	 1arLemDqGbB2LiXhzTlZO+E1Ah3jD+HKdU6Auz53G2IRp9wDBzp+MqYHeie6qncroH
	 Vu8kMXAzmFpUQ==
Date: Thu, 30 May 2024 10:29:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 linux-pm@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, devicetree@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: 
 <SEYPR01MB4221BD44992A23E2B0061023D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221BD44992A23E2B0061023D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Message-Id: <171708297616.2297193.3978844021510397590.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: sophgo,cv180x-thermal: Add
 Sophgo CV180x thermal


On Thu, 30 May 2024 13:48:25 +0000, Haylen Chu wrote:
> Add devicetree binding documentation for thermal sensors integrated in
> Sophgo CV180X SoCs.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  .../thermal/sophgo,cv180x-thermal.yaml        | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv180x-thermal.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/sophgo,cv180x-thermal.example.dtb: temperature_sensor@30e0000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/thermal/sophgo,cv180x-thermal.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/SEYPR01MB4221BD44992A23E2B0061023D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


