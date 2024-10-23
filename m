Return-Path: <linux-pm+bounces-16331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFBC9AD593
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 22:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C921F234DE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161691D3624;
	Wed, 23 Oct 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPvVUlf/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0D75809;
	Wed, 23 Oct 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715712; cv=none; b=KdPiZGaCAzJa9UOZaBbPLhCuhZtq3tRFmhhfq6VRGL+BUBazcsgNT8FBt5PwR5Wnhhm5spq4sn2gy486WXmPHeQq+wvt7OP+t2Kkw5cCnaP1Czv0pdDDcCBWCJr9OQibAobIy9lqVxmzFpJO5Af3hyumjy+cI2lKgN3t21tglQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715712; c=relaxed/simple;
	bh=SQRpUhcDzsAv3OqYqZzBoLiJktFW/ICG/wyiLq793cA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QfM3oBoutUNpBxwvfgA1L/mcnI6R1lATTxlqFxi6RD76CE/x5MOjUWeijFP4zcux7WMmq3PgQojLbeQd5RxVEsuJ37EfnVXOuLaxqsH2sUOvCz4UQn/aj3cNZPtFAV0IB0rU6c2qU6pEHCGypF/sKJIQYLbMHsGCe8UK2VVmUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPvVUlf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F76CC4CEC6;
	Wed, 23 Oct 2024 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715711;
	bh=SQRpUhcDzsAv3OqYqZzBoLiJktFW/ICG/wyiLq793cA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UPvVUlf/F3miqjlJpUtGZ42x9NLaX3gTFHxlA8CrIRSQIDU7sbsvzyG+OlUcBQNU7
	 8vWpcyW/3Hyeq096UG2Nb0FdHDL+F/SzpeiSC2IoiCUxzTksGSa4UgF9sE8uGNjupl
	 m/xrmHIHRezPRNdplMIHyay5kBlr15VSi9GAdawk1GVRCV2ri2BXYp5X94lMLjqMBA
	 h5Wb1oaSnHZaMj9safq38/gFlseBQllYRF4u7bhhkBEpWMdNFwN4u7OcZbtwxuouI7
	 otSraztNw3OkMJmD2fpiZNL/4fOFqFSUUFkzNypCyCQbQGBsye1oo4Z49A6cNcxq96
	 fJ+RoyuWLwNTg==
Date: Wed, 23 Oct 2024 15:35:10 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20241023-starqltechn_integration_upstream-v7-2-9bfaa3f4a1a0@gmail.com>
References: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
 <20241023-starqltechn_integration_upstream-v7-2-9bfaa3f4a1a0@gmail.com>
Message-Id: <172971571004.1852226.15537632667573865513.robh@kernel.org>
Subject: Re: [PATCH v7 2/7] dt-bindings: mfd: add maxim,max77705


On Wed, 23 Oct 2024 22:42:50 +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 core binding part.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v6:
> - unevaluatedProperties must be false
> - drop excessive sentence from description,
>   just describe the device
> - change leds compatible to maxim,max77705-rgb
> 
> Changes in v5:
> - formatting changes
> - add unevaluatedProperties: false for nodes referencing
>   common schemas
> - remove additionalProperties on nodes with
>   unevaluatedProperties: false
> - add min and max to led index
> Changes in v4:
> - change dts example intendation from tabs
>  to spaces
> - remove interrupt-names property
> - remove obvious reg description
> - split long(>80) lines
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                               |   1 +
>  2 files changed, 175 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: leds:compatible:0: 'maxim,max77705-rgb' was expected
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: /example-0/i2c/pmic@66/leds: failed to match any schema with compatible: ['maxim,max77705-led']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241023-starqltechn_integration_upstream-v7-2-9bfaa3f4a1a0@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


