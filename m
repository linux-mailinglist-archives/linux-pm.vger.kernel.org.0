Return-Path: <linux-pm+bounces-32547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B438DB2AB84
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119DB5C4E70
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C3322537;
	Mon, 18 Aug 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aofF9fJl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF505322526;
	Mon, 18 Aug 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527821; cv=none; b=FZDWtv/BOrl1O8BoP08Xl6vXIbCCulgIKrazSmWK13cL5S9ZycUHo23h3fl8beksa9rbbc3LZoZzze8sP9PjDuzkIy9uoaNl57ZNsN/l6biTbiV7dJANsqnZ0h2gvddv/80nd9fS1sAup5Po/mNxU3kT1AQ9UZ/TPQgz+d2jrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527821; c=relaxed/simple;
	bh=W4/OLIkNQoKN0jnkznTsepA876QEW7U+ue1hYsKNaH0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hRvazTiX93rdytQ9+qoGaRKhD9Vv5B20LrdBBYD4nlxKbVEMv6hKEFXtf13ZioUhdGdSzrLbM/hxMfMp1rjxiOBB9iAJLoVDoJhfayNFZzUzsJyy9eTSzVF45394nV2tGVeCY2GaaEXb2Lg5Cw6qyl3wGWBgxNGIjIoXsBrjzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aofF9fJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63474C19422;
	Mon, 18 Aug 2025 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755527821;
	bh=W4/OLIkNQoKN0jnkznTsepA876QEW7U+ue1hYsKNaH0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aofF9fJlEhlYoZ/K2HbzIr4HZ1ZEq4MGsQ4F5/eyZVP/CZuY9ro3cVyQ2WfnxxVHO
	 g6P2tSEj9VU+fjwnOi3jIkFxSDOjh/aC1nv8K16JTqf4cT2TB7Pg9d4Y23fpZBqmCm
	 tMP4MXwUXcMqkUKb9xwtqvg+zPER+rFILsA90/yJyQGDdySvVyUF/JsKFciDs8JUam
	 mDiHT7fB/Tklg4TdlQCM107p7e3OQpG6Q9vS26DQ/tqoWAEDjbYeItkDk37jPpxrkL
	 UO6sjEQa661N21yMwHu3cqLdmTE/eg7hljFJkF7eII8IAcy0IamHB8ZWbKS3K2Qta5
	 hnlZ4xj+zQ+KQ==
Date: Mon, 18 Aug 2025 09:37:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, vince-wl.liu@mediatek.com, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 sirius.wang@mediatek.com, linux-arm-kernel@lists.infradead.org, 
 jh.hsu@mediatek.com, linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
 Qiqi Wang <qiqi.wang@mediatek.com>, netdev@vger.kernel.org, 
 Richard Cochran <richardcochran@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-clk@vger.kernel.org
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
In-Reply-To: <20250818115754.1067154-3-irving-ch.lin@mediatek.com>
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
 <20250818115754.1067154-3-irving-ch.lin@mediatek.com>
Message-Id: <175552781827.1170419.2767571062327495497.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: power: mediatek: Add new MT8189 power


On Mon, 18 Aug 2025 19:57:30 +0800, irving.ch.lin wrote:
> From: Irving-ch Lin <irving-ch.lin@mediatek.com>
> 
> Add the new binding documentation for power controller
> on MediaTek MT8189.
> 
> Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
> ---
>  .../mediatek,mt8189-power-controller.yaml     | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.example.dts:18:18: fatal error: dt-bindings/clock/mt8189-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/mt8189-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250818115754.1067154-3-irving-ch.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


