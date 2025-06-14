Return-Path: <linux-pm+bounces-28707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC8AD9933
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 02:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F3E3BDEBD
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9051BDCF;
	Sat, 14 Jun 2025 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpAC0tsR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396518EAB;
	Sat, 14 Jun 2025 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861893; cv=none; b=irqwV26QX+Q9/pfCDOqFxKciZP+G1doL8S/l3NGw8MSjaTRKEaQxlbiGtwDPDz7HyoNuUoQo2DQHjDffq6zQCeGy4U+wRetWG9cZT4f3GnkC+XPWq8IiRAGFDF1bGKACdnEc8S8SqizqhoCvigRL/yQ1Y7P7difLAe+g9F/Y22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861893; c=relaxed/simple;
	bh=mobwSB6amj+rTcEdWirjricXAGuRR+bEQKMFiG+ydEk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bzDmwzdNPSuwRWb/egD0jlk8mzf1OlcFyse7iZ8wpbJ0kVFs4IHlfnfz/w7XmBZHKk/DfLzdD4gLe1l5XyZUqTJGYrrVeoPnKmM9nHpY/JWZPZIcd9TRbHnnVFcDiPW4LJA37VR/7i6fWAE6RW8shq1SIvVVmT5ygCnI5Ozpxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpAC0tsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1832C4CEE3;
	Sat, 14 Jun 2025 00:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749861893;
	bh=mobwSB6amj+rTcEdWirjricXAGuRR+bEQKMFiG+ydEk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KpAC0tsRTngOsaS8c0TNZ3MUAK9k1z19EpTh4N2YmgUPYubYRQDjUHjRQgsHSMTCD
	 s8VdjoRwe6dApPsSK736OVofiQ9ZLYw6EVy8Vpd+xIvg2px/XEv4WmenhuF7miKmlQ
	 hDqQvq1XYXzzkJ7woJnOUNGSu6+RuMlCOGAL9Omd49u7Noa+DTdQ76AGDhqqyZ52HD
	 BcHZhahq2Pen/4/DBHRqG52yHB0RcgRtcw2OWlqhpoovtm+Jlct++rzbQvdU2enIPC
	 ObmypXUcMBwZP35RKBKNy//EzFfQX5MBN8QcxtGwTQNei4+RX//I8p+PC0UX72RP3C
	 XmKOq+fCmumkw==
Date: Fri, 13 Jun 2025 19:44:51 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: arm-scmi@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20250613-pmdomain-hierarchy-onecell-v3-1-5c770676fce7@baylibre.com>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-1-5c770676fce7@baylibre.com>
Message-Id: <174986189194.368040.11959133664895822373.robh@kernel.org>
Subject: Re: [PATCH RFC v3 1/2] dt-bindings: power: add nexus map for
 power-domains


On Fri, 13 Jun 2025 15:39:27 -0700, Kevin Hilman wrote:
> Add support for nexus map `power-domain-map` to be able to support
> hierarchical power domains for providers with #power-domain-cells > 0.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  Documentation/devicetree/bindings/power/power-domain.yaml | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/power/power-domain.example.dts:136.18-19 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/power/power-domain.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250613-pmdomain-hierarchy-onecell-v3-1-5c770676fce7@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


