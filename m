Return-Path: <linux-pm+bounces-32546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B441B2AB0E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 16:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EB77B9BA4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEBF321F4A;
	Mon, 18 Aug 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StG9+XEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BE321F3A;
	Mon, 18 Aug 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527821; cv=none; b=U00JWnV4Nxbu3CWTTAhI7B8YmQ7TVxL1mChQmALFogdpWe+FizlgNdUvMMnGEZhWOA4K3wFdnF3g49WNZVB8HpdV9fsz5LVnY4ISwiGhCutlqppD9hY6wVfHDfJtOOb1AQKKLTgcKyZteQcT7X8fHs96IIyJCjDYy/FJqC42/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527821; c=relaxed/simple;
	bh=jyvUe/Uvlpxb8/WNMi/NIGIZMsdMiJ0vXIXKRErcUzo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=f77EHiD1X7Jutzw9gmwcPK//CriJ01mDmT37JsJ0awuFJUXjn4VDXkPWWpgDFj9eFlLnAMHN1EDmJ1wWKSwCh3qpWgmUDkgxZateq8KI7QJXj0h2Sm5PiT8JR2vesQjEFraR6ibBuRlqZom2Xrm+k4tdrzKjjiYI1ccuiLCpDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StG9+XEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675E4C4CEEB;
	Mon, 18 Aug 2025 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755527820;
	bh=jyvUe/Uvlpxb8/WNMi/NIGIZMsdMiJ0vXIXKRErcUzo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=StG9+XEFrgzNq+p79mD4ztZh0jbQ1vCwRuSeLqB1qS7Iu+Hc6Dfv4L7qwJOeHaktO
	 6/fmIiqF9ac1+tO36JaKI+zl2+ZEUliWcQ/ODtzUbqjqvvPWAOS8pVpeE2sT9l+VDb
	 ex4s6gE53WqcTeibIamkuc8N8Fmzt0nb9ZZSEvOc1Css7SabPCqh0xuj9EdtZ8moG/
	 YrZeo0YIhIRUo2D93AMpTEG2YgyqV+LLy8LrVPUq2c0+Qd2vJfBy8z5WNJFjtC6gPk
	 PJ5N2LmpwpflXWqZUf0Ptng9v1BBoqlb2a7+s1LwEWOB+mf4iV1W7XrW2WCtUDy2Dj
	 0p5yTt0prT/7g==
Date: Mon, 18 Aug 2025 09:36:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-clk@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
 netdev@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, jh.hsu@mediatek.com, 
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-mediatek@lists.infradead.org, vince-wl.liu@mediatek.com, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
In-Reply-To: <20250818115754.1067154-2-irving-ch.lin@mediatek.com>
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
 <20250818115754.1067154-2-irving-ch.lin@mediatek.com>
Message-Id: <175552781756.1170283.17952756043799676005.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: clock: mediatek: Add new MT8189 clock


On Mon, 18 Aug 2025 19:57:29 +0800, irving.ch.lin wrote:
> From: Irving-ch Lin <irving-ch.lin@mediatek.com>
> 
> Add the new binding documentation for system clock
> and functional clock on MediaTek MT8189.
> 
> Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
> ---
>  .../bindings/clock/mediatek,mt8189-clock.yaml | 89 +++++++++++++++++++
>  .../clock/mediatek,mt8189-sys-clock.yaml      | 58 ++++++++++++
>  2 files changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.example.dtb: imp_iic_wrap_ws_clk@11b21000 (mediatek,mt8189-iic-wrap-ws): reg: [[0, 296882176], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8189-clock.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.example.dtb: topckgen_clk@10000000 (mediatek,mt8189-topckgen): reg: [[0, 268435456], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8189-sys-clock.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.example.dtb: topckgen_clk@10000000 (mediatek,mt8189-topckgen): reg: [[0, 268435456], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250818115754.1067154-2-irving-ch.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


