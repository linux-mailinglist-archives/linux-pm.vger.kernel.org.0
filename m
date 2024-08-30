Return-Path: <linux-pm+bounces-13236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F29661BA
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C042AB2A2D2
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B0199FDA;
	Fri, 30 Aug 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7r9MGDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E25199FC5;
	Fri, 30 Aug 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020966; cv=none; b=LhyoG7L6kyzU0Mfz70eVerout2lQEiRUqcx1fei9kykWRHhoO/Wf9PsJbCWf4mfkWsHRR2CQMBj5T5ASHnMzbFWlceUj0vUdoTE+v8DWJibuwWpc+f22xRZG5KbpTMax6Y3PVcHqRoBi/xtixRBNH8ngi+6PifHFstX2DVKR32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020966; c=relaxed/simple;
	bh=dWcO4HpmxD2VUhZ0j6XxpQ5q7RtFhg5rZL51PUt1w2I=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ujzmwahMbBM7+nh/l+FCx7E7opiCEmSVqDiJLnmduxu03nqS6ffb8TGSgD5n1MvKM4GA12p8MypB1MQ0n+eWUpgaeJKAgqIsLEomljS1vHa5ZOzNFJx+8JOtAJgu8Ywv8FywJUcd0NQ+dT/0PMMlpDDbFuuEO6Ej9oDhTF4PXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7r9MGDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FC3C4CEC2;
	Fri, 30 Aug 2024 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725020966;
	bh=dWcO4HpmxD2VUhZ0j6XxpQ5q7RtFhg5rZL51PUt1w2I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=i7r9MGDWKFdIUkU0YekBibM1WFwxMlYCk5qxWxdeCbp4l4DrC/Q+s5zC1z8vrYGSy
	 vL8fOqwV/DL2Hti30wTdcn2nvdEoLPT5Yw92x/H1R7eqrGwNqvfx0/U3WJJtqUFZYR
	 68/wATucLIxOONL/A28TQOMK+T0AIdNvamp3dLqHzbj2TSd07iaKLvqFXu5xZfiqgE
	 btVgyGLHYqWYXEllwk1polYJTO84ctWiw5xuj0yLS83WpN3k9MpDvicJud8EJUGWEZ
	 9pUEIUAlhyb9p7Jrnz7MI9+KAJVnd/XEgOVVqDZVbe5pDR03k9eNT30L330htOnqHd
	 eFFifg3u1sTEw==
Date: Fri, 30 Aug 2024 07:29:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org, Sen Chu <sen.chu@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Macpaul Lin <macpaul@gmail.com>, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Bear Wang <bear.wang@mediatek.com>, Mark Brown <broonie@kernel.org>, 
 linux-sound@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-pm@vger.kernel.org, 
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pablo Sun <pablo.sun@mediatek.com>, linux-leds@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, linux-rtc@vger.kernel.org
In-Reply-To: <20240830110732.30080-1-macpaul.lin@mediatek.com>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
Message-Id: <172502096265.3785833.16915280284565594254.robh@kernel.org>
Subject: Re: [PATCH v2 1/7] regulator: dt-bindings: mt6323: Convert to DT
 schema


On Fri, 30 Aug 2024 19:07:26 +0800, Macpaul Lin wrote:
> Convert this from the old style text based binding to the new DT schema
> style.
> 
> The examples have been trimmed down and move to parent schema
> mfd/mediatek,mt6397.yaml.
> 
> Add new maintainers and submitter from MediaTek.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../regulator/mediatek,mt6323-regulator.yaml  |  84 +++++++
>  .../bindings/regulator/mt6323-regulator.txt   | 237 ------------------
>  2 files changed, 84 insertions(+), 237 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> 
> Changes for v1 and v2:
>  - This is the first version of converting mt6323-regulator.
>    This is because converting mt6323-regulator together
>    with mfd/mediatek,mt6397.yaml, so we've create a patch set
>    instead of single patch for each skydives.
>  - This patch has been made base on linux-next/master git repo.
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml references a file that doesn't exist: Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml: Documentation/devicetree/bindings/regulator/mt6323-regulator.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240830110732.30080-1-macpaul.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


