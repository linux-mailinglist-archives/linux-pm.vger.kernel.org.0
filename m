Return-Path: <linux-pm+bounces-19400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFA9F585C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 22:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953E97A2ECD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 21:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583A1F9F5F;
	Tue, 17 Dec 2024 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPF964+q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE331F9F44;
	Tue, 17 Dec 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469579; cv=none; b=DgT83WrPnzcNLo4dq27ZiJNU7cB8t0L6iR8h2z9frt8ohhabmDD7MvzPntNcsSRWalxeo1MDQmzRFlQRjc9C7KpK4n+4f70Bb47OSC3T/cM4G48WY+HcIw0czENGvaiLrOoYh7i3Lh+qHRw3VZ8Aa+woCoN0t9kvk2T4bGdDlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469579; c=relaxed/simple;
	bh=6BIHdtEzcXSXZ+JBnh804aXJtDUVjAEcytppCIP84nY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uMH2Myz2VqpzWJfCAG/ObNEHMF2p0NoP+fWWOFMSbgyiAygmEwbYRN5CYBDWjtEjYYJLp25Vzm0YUXAcOKT0KRhIVMvMBrOkHuPo7E0LMknn26YyEL7qXCfz6ihChjzVJlehjb+8cxAxuNAlgQWwkqbr18Jr1T3Tl47AumlSMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPF964+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B5EC4CEDD;
	Tue, 17 Dec 2024 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469577;
	bh=6BIHdtEzcXSXZ+JBnh804aXJtDUVjAEcytppCIP84nY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aPF964+q0FEH0SCL47fWdrJPl4ydOT6FZdQ/Sxx/ifikIlIX7zYP+JsFR4eFA5LY8
	 +YLGc/jpl5n+ABjOJ4jG+at6zo/b0knyB6SahU8WIM/8HhHFSuzeVDRW0PTTWKW3AB
	 LtXnTZ0n7GzUs7zyB3hTlUGgHAZin2cxTJ4/RnYbjcJtEX+l8AsuebNSi3N3CpjOeZ
	 6D4lXRJXr/NlkcZQN7Jd4+jifMCZDYMrEy0yBMJ6arPqrDzZcowCG3bmSjt4wna5Vi
	 4UbYQpYmlc4R7lwo7BAwgezRT9t7o7EIFYBGYqDMsdMKK/54PiADSp8/WhLFfSBL68
	 uRVIMcG4uw72A==
Date: Tue, 17 Dec 2024 15:06:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-input@vger.kernel.org, 
 Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-5-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
 <20241217-starqltechn_integration_upstream-v12-5-ed840944f948@gmail.com>
Message-Id: <173446957568.3352044.2208837286818207483.robh@kernel.org>
Subject: Re: [PATCH v12 05/11] dt-bindings: mfd: add maxim,max77705 sensors


On Tue, 17 Dec 2024 20:30:03 +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 sensors binding part.
> This includes fuelgauge and voltage/current sensor on
> chip input and system bus.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml: fuel-gauge: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241217-starqltechn_integration_upstream-v12-5-ed840944f948@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


