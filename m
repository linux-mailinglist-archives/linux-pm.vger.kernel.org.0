Return-Path: <linux-pm+bounces-18583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624039E46AA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEB8282F76
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4F1922E8;
	Wed,  4 Dec 2024 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFLG3MSO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523281922D3;
	Wed,  4 Dec 2024 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347807; cv=none; b=ATQ2YWWA6kCzPlPDfWX3HqiW3tAmXYhbLM6g9Nbwg4XtciDX/G2Hn1B3BYZ93cDBu/HR70ISjyWGrQ8zR1GtaoYMKHOS7EOBbdMUqsh775QnDV2AxWvLdsFaf9Mw0CHzOLzGbiZmDNSkXYtxuqEKfgq0LLyIgxOLLYddLlnV2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347807; c=relaxed/simple;
	bh=Fb7g9HgjCaNTFR2TXE6bIbdeyc0ft1NVlc+xykXnmUA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=K/1N4z0i4nW4kbCnheomE2OJnoH4SxDw26H0U+BqkhNKMjfYAk+sgVMoLxBWtfy0aZFbQ4qOd2k33X9KzAd8pGixDtBQlD5QHyUPHkNDADQ6VZUTJLv5MfCEL8lJmY1LEQVrMyrg1qDb0MM4NkIYxUAdntVwllLCwJCXJnx6HfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFLG3MSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99671C4CECD;
	Wed,  4 Dec 2024 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733347806;
	bh=Fb7g9HgjCaNTFR2TXE6bIbdeyc0ft1NVlc+xykXnmUA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UFLG3MSOBl7X0DjQqg0i97iI8YBi/Y2yklrluEnVyIZd9vXSEu0WLwO6WoKBQPKtJ
	 lv3pIARO/Eo6C6/MUTIoKDzDf83MwICS6/cGHwdbtA4nvPXMBzbbY4j4BjKF3d2RSh
	 xQNCm/2JCH1u7eJC8q+EAvT+UzuwyukNiW7vUvFUSBeYTM+fh4HEu5iie1R6L1Rz6N
	 nfXqNRwVXNtY9uwvuc0GDO+n8loPo4FeSAyykd6k2jjmxqRzG1xjwPzcdHmdgGpc6W
	 1CdM59hQy64OMAEuCZQNOHCebnVIP8Sy67ayyJgXTeefzBKXNnpLwPsCiAt9jV+NXM
	 B9X3oXvlOe4Vw==
Date: Wed, 04 Dec 2024 15:30:04 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, linux-input@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com>
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
 <20241204-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com>
Message-Id: <173334780474.1329015.17978320703905985001.robh@kernel.org>
Subject: Re: [PATCH v10 3/8] dt-bindings: mfd: add maxim,max77705


On Wed, 04 Dec 2024 23:09:53 +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 binding.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v10:
> - leds: replace label with color and function properties
> - leds: add support for leds-class-multicolor
> - move fuelgauge node to patternProperties "^fuel-gauge@[0-9a-f]+$"
>   to comply with max17042 binding
> 
> Changes in v9:
> - replace max77705 fuel gauge with max17042
> - remove monitored battery because not supported by max17042
> 
> Changes in v8:
> - fix leds compatible
> 
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
>  Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                               |   1 +
>  2 files changed, 193 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: fuel-gauge@36:compatible:0: 'maxim,max77705-battery' is not one of ['maxim,max17042', 'maxim,max17047', 'maxim,max17050', 'maxim,max17055', 'maxim,max77849-battery']
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: fuel-gauge@36: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: /example-0/i2c/pmic@66/fuel-gauge@36: failed to match any schema with compatible: ['maxim,max77705-battery']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241204-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


