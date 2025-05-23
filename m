Return-Path: <linux-pm+bounces-27584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0CAC24DC
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013943BDD77
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5DF2951D6;
	Fri, 23 May 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goAQq1FS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588214286;
	Fri, 23 May 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010207; cv=none; b=Rz48IgUmZmefyxlweeX4DwJdOOCvFb4vv7OngRWDXaVnxgz2NVQgV56ATmwwSoHEzxTcvnFpX2TVuY3x3whCxKOlO0HKWntq6CryiANsWefyoeTSAOfPtubdR7EDmQDJP3ZuzqogryQUI9sZ4EMotioZF8qwazUbLzxTEIv6/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010207; c=relaxed/simple;
	bh=pR9fA4NdXQryYOB0kCjJuwhWY+v7ZXFuSKqfZ1iPpXY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=HuKqT5UaYf0xVIL3hRfoMbkUrGSEOsNrWvh527Z8yzV5TzeXsJjL/U0J0hphGKIdMM2G5wIbXHSTDGHgEDfPa1weDOeXLdhdegWO9NGEXNbNh12NtXeJ+6v0UR/uaki+Azbx4mJSF3d9hliWRiDncEUeLCoSr/kp4Z2S7jykeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goAQq1FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8F2C4CEE9;
	Fri, 23 May 2025 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748010206;
	bh=pR9fA4NdXQryYOB0kCjJuwhWY+v7ZXFuSKqfZ1iPpXY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=goAQq1FSEeTn60D4goiuky385GlbCKp/cuANcZdpE55R5AzKlNc2mfFQLVwjp5yP4
	 30ORao35sm4F03Mt0G9gMNE03eS7cQewA/JuuS8kM2wEbjRJ9gKWf4UH+gOD+maak8
	 i3d39A84sJfy4PIq7mXK9e0FawzTOMjcb3ZvbbCN2XRXj4IKW0ka84gGbfj2Hytw2L
	 z6jtmNQf9FfaULjoBABVQ4yU5BKGgBf649sKb+b/bMi5mZDlVsq4deWn+Swls0KjWz
	 2xl/z7rR0jCcTwFl1vGZMC/LCPieqc5w9YTxmELuJRMqi/euLqjqTDNuIbmm4CD13S
	 D5Py+xMQ78J8w==
Date: Fri, 23 May 2025 09:23:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Will Deacon <will@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
To: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-3-b49904e35a34@uclouvain.be>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-3-b49904e35a34@uclouvain.be>
Message-Id: <174801020213.1711113.345093338339691791.robh@kernel.org>
Subject: Re: [PATCH v4 3/5] dt-bindings: power: supply: add max77759-fg
 flavor


On Fri, 23 May 2025 14:51:46 +0200, Thomas Antoine wrote:
> The Maxim MAX77759 is an IC used to manage the power supply of the battery
> and the USB-C. Based on drivers from google, it contains at least a PMIC,
> a fuel gauge, a TCPCI and a charger.
> 
> Use max77759-fg compatible to avoid conflict with drivers for other
> functions.
> 
> The Maxim MAX77759 has no non-volatile memory so it doesn't require an
> address and instead requires a value for the current sensing resistor.
> 
> Keep shunt-resistor-micro-ohms optional for the MAX17201/MAX17205 as it is
> not be used at the moment but could be in the future. (e.g. as a default
> value to be used in case of nvmem failure)
> 
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  .../bindings/power/supply/maxim,max17201.yaml      | 42 ++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml: properties:reg: {'items': [{'description': 'ModelGauge m5 registers'}, {'description': 'Nonvolatile registers'}], 'minItems': 1, 'maxItems': 2} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml: properties:reg-names: {'items': [{'const': 'm5'}, {'const': 'nvmem'}], 'minItems': 1, 'maxItems': 2} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250523-b4-gs101_max77759_fg-v4-3-b49904e35a34@uclouvain.be

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


