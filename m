Return-Path: <linux-pm+bounces-29501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EAAE829C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98851899435
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751A25DAF7;
	Wed, 25 Jun 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVkBNJYh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CC3595D;
	Wed, 25 Jun 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854251; cv=none; b=gVL+uoR8oyodpvr99bcS4+jX48QHNvApHtVpiN+pbrInEWfXbuDCP3W6tBKs08NLPvcCbcZlpID0XXX8wVWzIri/1nQ0XNa2XiXUAUXen7lHdVu6UI8pdorEX/iR4a4WvxbRlAvadeKOExAT2+YBhBNuF401i6U6ZE8pZiFfFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854251; c=relaxed/simple;
	bh=GnG3Fx4/tRglWsgTMCpBf55NzwKfzZTAii167KIZ4cE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=EuGkvboOywKgcgZr10MW8+zyYgEnV93IXuAv4+LCQiWDKMlbtnErYHAC+f4Zk9nmxULeH3EaxxNyXaxeJRhw/gPTzTnyT3pPUp+y8iCQCRsCFqu89hqwy/r+D/Nziqgdyt3UeUYMj65XYlTmYYtmqregtNBuh7vZzX6anZdgV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVkBNJYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C523FC4CEEE;
	Wed, 25 Jun 2025 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750854250;
	bh=GnG3Fx4/tRglWsgTMCpBf55NzwKfzZTAii167KIZ4cE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DVkBNJYhaDxHPZ2VJqYLreEXFL3IQ3f0XFP6qywuPuHcVw8RDlcY9zbt/ZjxshWtQ
	 gIjIl1GjvlKpAMrD3z5/YvuHj2qYJZIJhhB3z6IfXlewjLzNWMt3tQQkNbLW7/Tito
	 rsdaoyEyshVaJeYJHCK8iJA1kqnFvpaisnqJZG4iPqT/UKZ8kP8e0TJ1yzTz5x3HVy
	 Grsp1PDrQvozx4ryOl1peEZN5kxrI0cruuxUo92qlwB7MiXeDyGDOsLYadwqJxeJ66
	 wPagjD0YrRARPPAbqAOyAYvy7Vzt5z9038Sf6jno8ZSfVsO3MN/Cmv+5Dk+Z3kBM0X
	 xXdOHVtRIZPUg==
Date: Wed, 25 Jun 2025 07:24:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, Georgi Djakov <djakov@kernel.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20250625-sm7635-icc-v1-1-8b49200416b0@fairphone.com>
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
 <20250625-sm7635-icc-v1-1-8b49200416b0@fairphone.com>
Message-Id: <175085424996.330301.5673192572760030454.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip Interconnect in Qualcomm SM7635 SoC


On Wed, 25 Jun 2025 11:13:47 +0200, Luca Weiss wrote:
> Document the RPMh Network-On-Chip Interconnect of the SM7635 platform.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/interconnect/qcom,sm7635-rpmh.yaml    | 136 ++++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sm7635-rpmh.h    | 141 +++++++++++++++++++++
>  2 files changed, 277 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/qcom,sm7635-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,sm7635-gcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,sm7635-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/interconnect/qcom,sm7635-rpmh.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250625-sm7635-icc-v1-1-8b49200416b0@fairphone.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


