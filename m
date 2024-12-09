Return-Path: <linux-pm+bounces-18823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254539E9487
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 13:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1941888648
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D6226ED8;
	Mon,  9 Dec 2024 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS9IjNmq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601BA224AEE;
	Mon,  9 Dec 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748018; cv=none; b=ZYjH2j+sHLnEuvcADvoReeBqUjwD6Fc2tckCHNySwAsCaLt/RFum6Gudo/B2QhlRk0orN7VHhqzP432hmEP9UXwXuqKFESf1ZscxWx23XL50Aa6E+oy1ZO3aycFSz/2c95RbvhGgfeSWuOsZ2bMUcf3YGiwpT8lVAS4tDWF2JaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748018; c=relaxed/simple;
	bh=r1y2bZ+c+3Ff9Cb7WwsV2utut88vNUkPy2wrLMTOb6Q=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=V66rfMuW9RjjD4RBcwaigHBS90lS/kkwVRKLG65UuMgLiov+t5xx/1atMbXaxykpzfU/HBc1X3fvabcnKYQL81yeoxuJeDgg9TWjZxOxmKF+nIRNa/EtjJeI4/9ps8MtJz/33Bh8qhS+mK8ckA1s3VxtEzi+W+pZONhFOR2Pkc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS9IjNmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD475C4CEE5;
	Mon,  9 Dec 2024 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733748016;
	bh=r1y2bZ+c+3Ff9Cb7WwsV2utut88vNUkPy2wrLMTOb6Q=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=fS9IjNmqpxSlbgxt6H64fVsHAZinOsTi4S7LnACr+qtwiO71aYA1E57jWLdX8CD/G
	 rKugCGLVRkqWrJtDirPEypi1uXk4gGUohJS09hyxZYjI53p+8BSjwV/QVBvLEFLyan
	 R7sbm8VSg2n+aZABBPHNDhm+mrFhKeIG/CW1wTW6ckVoyWTe0FAZ7WAsT7SEsaesAc
	 +l5cU6tTIBQIlxqh+80bu44M/lOcfVjl6fm41FBPrVGPLI+26xHXfJod6kdmLciKBI
	 oUV66nHLI3RSEc/KotT5qmAkw3thKkBYar5NGBMNLuG1AbNUiLJOAAgERfZC1Oy/VP
	 krrHYoJO3uAWw==
Date: Mon, 09 Dec 2024 06:40:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Conor Dooley <conor+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-leds@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
 linux-pm@vger.kernel.org, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Hans de Goede <hdegoede@redhat.com>, Purism Kernel Team <kernel@puri.sm>
To: Dzmitry Sankouski <dsankouski@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-3-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
 <20241209-starqltechn_integration_upstream-v11-3-dc0598828e01@gmail.com>
Message-Id: <173374801505.3246398.1590933015937792151.robh@kernel.org>
Subject: Re: [PATCH v11 3/9] dt-bindings: power: supply: max17042: split on
 2 files


On Mon, 09 Dec 2024 14:26:27 +0300, Dzmitry Sankouski wrote:
> Move max17042 common binding part to separate file, to
> reuse it for MFDs with platform driver version.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml      | 49 +------------------------------------------------
>  MAINTAINERS                                                             |  2 +-
>  3 files changed, 68 insertions(+), 49 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/maxim,max17042.example.dtb: battery@36: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max17042-base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241209-starqltechn_integration_upstream-v11-3-dc0598828e01@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


