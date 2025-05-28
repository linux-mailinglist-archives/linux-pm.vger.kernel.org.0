Return-Path: <linux-pm+bounces-27764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D67AC7487
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 01:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20929501D48
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 23:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9507207DF7;
	Wed, 28 May 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAJDYHbO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A574685;
	Wed, 28 May 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748475148; cv=none; b=aXuHJHVj1jLpRpdXo2RGZMDNqqNi0K4TNvrVWt7AudK/wrbCjJlPhjlP15UWHcTmIbJyYLSalxBH21Zh5r9vquGGtlnVATYCPq1LYge+cJ/ndZTA4+cwkPpa8YA1qtOjt6XYOZwj1Agb8Ed/BMjiPOA5RlFvdOBkDn1fWFJ2URc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748475148; c=relaxed/simple;
	bh=4aKrX970HlgQ+JdihNfwN5qAE0p+0Jvx9ru62vyW8IY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KlXF//jisIlBsP1XOQCmuFwN04xlLkJx7VRJBybpBdfRAupNAuSKK6H+bPWUTP2BrR2vBxGWIrBm0Kd/gamIg46HGEwSEJsgQtY5YbIoEc8F7QLvR/Q5JI7yjfPNCDoCJsW82Rk0OMaXwBlS/SlOjPM0x3oCrd4+SPR44kWOzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAJDYHbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0391C4CEE3;
	Wed, 28 May 2025 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748475148;
	bh=4aKrX970HlgQ+JdihNfwN5qAE0p+0Jvx9ru62vyW8IY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FAJDYHbOX4Th3H5g7MvkE6jrg5V58S4Qv464ec8gk0/aM2rBHPzWcsyAFWZchxZDt
	 jDAwpJpE3jcOfNqzzOn/aHbZ1FbSZvDgtY3b1KbKleAbOMk5jK9KPWzo27Z3TjZO9R
	 gWrUevVG3RBXZklz1BdBANprbTirpeab+O4QPsUA/CCVb+TLp5jD5LKaxBu5axmGT3
	 qCH1GOMZp204WdXg9S0HBD0TJAqTk/IyNsSh0KU6BCkNUGWtMqgBuGe+A0+L9NgfA1
	 PyEx3Cubwem3/ZsGZKLTeExQYV6w0JcSpmq74It5gWKV8rBIukbOqTEw3OJTWFjQE2
	 Ca7SEys+QF/5A==
Date: Wed, 28 May 2025 18:32:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
 arm-scmi@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20250528-pmdomain-hierarchy-onecell-v2-1-7885ae45e59c@baylibre.com>
References: <20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com>
 <20250528-pmdomain-hierarchy-onecell-v2-1-7885ae45e59c@baylibre.com>
Message-Id: <174847514622.1183193.5216863446447451692.robh@kernel.org>
Subject: Re: [PATCH RFC v2 1/2] dt-bindings: power: add nexus map for
 power-domains


On Wed, 28 May 2025 14:58:51 -0700, Kevin Hilman wrote:
> Add support for nexus map to be able to support hierarchical power
> domains for providers with #power-domain-cells > 0.
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250528-pmdomain-hierarchy-onecell-v2-1-7885ae45e59c@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


