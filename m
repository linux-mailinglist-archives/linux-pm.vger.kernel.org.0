Return-Path: <linux-pm+bounces-23007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E641A464F5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA1D4216C6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667922FE0E;
	Wed, 26 Feb 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HilZ7t2w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E622A1C0;
	Wed, 26 Feb 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583762; cv=none; b=JWPTaTXqlavLwHOVEYbLY7IcLQ7WB25kzGkQM6phmfZaQhqF0pwdjg77natzKY9khpbKzRSfXQ10DSlbsJfmWRL/vnEbAhh9htmcFKS2nnGBFUozV2443M9yNT2ii6A/xT6ZTNwgTpgJNQLLy/ketSGvqG4NI/fbPs9gX3SR0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583762; c=relaxed/simple;
	bh=Bm71IuLHpYa+LH4zujKKceLccQmp+vSPPfk2dsBqhhg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cb0k6aWhgisZWN/NNK28PQXLbjEXzY8cZ4mNcdWpMLhECCLtonM+s8luDPUXgNLV+J3H66MCVBREg0TR2pR5Ohn9H3O3Y2GpQ6CUuBNYhu9LaDPAJ39JDZ1de35uOTcYL0DPzEKFPErGGx0PAQVmPrTJ2crYocgOTTMB5uud3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HilZ7t2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9836BC4CED6;
	Wed, 26 Feb 2025 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740583761;
	bh=Bm71IuLHpYa+LH4zujKKceLccQmp+vSPPfk2dsBqhhg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HilZ7t2wWB8b8ymJeBpJHUhU2queDOpDymlV/9zGK4XuC/ksujSel9RpP9CGsHZPI
	 iPovdXeGZ4dGC+MZOUH7ZVKARszZbEs0f6tcg5rjJyS0TztU7vXcn93If6laQZu/IO
	 xRoCCx6i1oCckJ4vol8hpBURsACh8NZ43GGK0ktcRAKcTesh2Epf5QjoH0seK2sy3o
	 ysX7pDYLnVksz4pkIuv8RaWN+6P0AHvKjYcpFIuBPCTrs4773qjsV+wtUB0+f8M0yC
	 PEU6VjCkFhBTrx+m0JLdBlUamxNgiAaCed8hnYaznkjWNke1IZLNtxQjRNfZBgF+0e
	 IqjFU+qW4gE8w==
Date: Wed, 26 Feb 2025 09:29:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will McVicker <willmcvicker@google.com>, 
 linux-kernel@vger.kernel.org, kernel-team@android.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
In-Reply-To: <20250226-syscon-reboot-reset-mode-v1-1-91c1b62166ae@linaro.org>
References: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
 <20250226-syscon-reboot-reset-mode-v1-1-91c1b62166ae@linaro.org>
Message-Id: <174058375994.2463209.9948592153423144239.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: syscon-reboot: support reset
 modes


On Wed, 26 Feb 2025 14:08:20 +0000, André Draszik wrote:
> Add support for specifying different register/mask/value combinations
> for different types of reset.
> 
> In particular, update the binding to allow platforms to specify the
> following reset modes: soft, warm, cold, hard.
> 
> Linux can perform different types of reset using its reboot= kernel
> command line argument, and some platforms also wish to reset
> differently based on whether or not e.g. contents of RAM should be
> retained across the reboot.
> 
> The new properties match the existing properties, just prefixed with
> one of the reset modes mentioned above.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/power/reset/syscon-reboot.yaml        | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:113:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:115:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:123:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:125:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:133:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:135:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:143:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml:145:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250226-syscon-reboot-reset-mode-v1-1-91c1b62166ae@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


