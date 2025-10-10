Return-Path: <linux-pm+bounces-35913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139CCBCCDBF
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A77189FD16
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77A2877D0;
	Fri, 10 Oct 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9Dedpxe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDF22688C;
	Fri, 10 Oct 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098988; cv=none; b=YEwE4C5/zwi/tOXhUrYMIzuCB7GJAdQPlmuneXxxQzcRoZUWvd0hKxXDZUz47PqRxmoYlJVosYbpQJ+yOoMupZRtiElWc//qGzglISuNT8YhAsLwOJDqUQrIuQcPEQHgNQtnR+GsqYW/GBL8WMUv7Y0PDVQGc+yBffABs5jsXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098988; c=relaxed/simple;
	bh=R/kafU+m4XW/sdA5FXdw8G0Cze3OBc3X+cHKIZZOcF4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PpPmyUjdu14W5B1kad7Gx1FzDeCJmvn1gNMXv+CKhp34sXNOnIHjmuDtPF/T7QcFpixwXXQRDER/yPvZ7FZ9EkLs6S8VkKWuhwFioYxnHGDKn63Zc7aqmR2fsdgqyEBxZ5hWGzK6glyAkq8b5gZsMc/LOF6shvgv5Spn3Awl0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9Dedpxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBF7C4CEF1;
	Fri, 10 Oct 2025 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760098988;
	bh=R/kafU+m4XW/sdA5FXdw8G0Cze3OBc3X+cHKIZZOcF4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=O9DedpxeYgxvGTE3qra42PaTuxXlqEo5zRrbgWrcTkeypkLVm0UhI/8MjYFTlYxSr
	 GQyYO+lHKGdK3xP2Z6a18q33zHaSDMw12VsGjxBVzv0jAauWJLW/sYXCkoguCZMQbH
	 PVEwVpvxpHJh0bgZDc7do4OKGgEUrQ7q2gYbzlnLd/qmas0QOEb9VEvD01JZiCNuO7
	 kA6S4rZTP9HCmWHPWdvMvjS0wbJiVoBDBOPmqFL2lGBMj2+k6Kclju/GlnuY3HU5Bl
	 oqqBE0JUYniQaQczzfjK+XIw3Qp5TBo3uohK18Tgwv0aZSjoT9KVs1nkkt3IxrI84y
	 FGOs0AkFl6tgw==
Date: Fri, 10 Oct 2025 07:23:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-2-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
 <20251009-gs101-pd-v2-2-3f4a6db2af39@linaro.org>
Message-Id: <176009895995.7689.883182155048414797.robh@kernel.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding


On Thu, 09 Oct 2025 16:25:04 +0100, André Draszik wrote:
> The gs101-pmu binding is going to acquire various additional (pattern)
> properties that don't apply to other PMUs supported by this binding.
> 
> To enable this, move google,gs101-pmu into a separate binding.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 67 ++++++++++++++++++++++
>  .../bindings/soc/samsung/exynos-pmu.yaml           | 20 -------
>  MAINTAINERS                                        |  1 +
>  3 files changed, 68 insertions(+), 20 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/soc/samsung/google,gs101-pmu.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251009-gs101-pd-v2-2-3f4a6db2af39@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


