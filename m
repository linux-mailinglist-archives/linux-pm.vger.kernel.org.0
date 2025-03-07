Return-Path: <linux-pm+bounces-23605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31794A56027
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 06:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518BB1896346
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 05:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B018DF6B;
	Fri,  7 Mar 2025 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la4OyzAA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CA15B54C;
	Fri,  7 Mar 2025 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326181; cv=none; b=QkGvwBoC6cw5u09PbV3cecs44evsAZ8eGi+nYR/MNp3PjQ3jkXpjBYCl3nG4m+CLrW8MJSnOdATnokvdrGe2mFBGazqrpcJuRPtChG/RRchhNPUY2aPZEpLfdgUVDbN56d1y16lwfgg3FBTnKcvUcRBrdOHAk31C1jwh8veNl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326181; c=relaxed/simple;
	bh=d6P3+GeoANuNR+y6EWdLUIcEG+o+je61v4CL1BkvFVc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=S+D7pQs7RStrDn/MNjPgGU44f1mQZbOZ2m3Vvdo262m+PLjCLwxg7NSmGWXGYAiu882iFjsnji3ZnuEiWbniZ1PtMYzdtcI2SamDUDvQOaQiPb5tWDkOaVt20dfAIdvulp46u6VTFIDrZp3dTV/KzsURnsO8BnGlWFmVPan2NQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la4OyzAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4E4C4CEE2;
	Fri,  7 Mar 2025 05:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741326180;
	bh=d6P3+GeoANuNR+y6EWdLUIcEG+o+je61v4CL1BkvFVc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=la4OyzAAvaX0xU8H4oPoH4tX6uTSOfYArgPd+EM3TMX6vSxx0dnHyzdAQ3l+Tg00q
	 riJthLtqHIZltVkxfeUfgLMip24vlO2xaYtIjliAXl8OiwElCwKOV86NYjOYMkZ0kx
	 4V9Kc/uyKiZNnd4oWNk0HDq8/3v45oypwVJJQeNVuu2CH3R3Iv2C2jc7qlBbdL85Ao
	 ve/xV/8+EZeFsRhM3/Efl23U32cU38MyJ3igzIdUyslM+O7oOfWa6NaBW+3kVtQ0TN
	 yo23R7NWCa+trDtUtxKXqBmfzKqVVMWVEQG0Nh8Iw8pXja46OiNu6KReR2VIXpez5C
	 irF8AcJHYda0Q==
Date: Thu, 06 Mar 2025 23:42:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
To: Guangjie Song <guangjie.song@mediatek.com>
In-Reply-To: <20250307034454.12243-13-guangjie.song@mediatek.com>
References: <20250307034454.12243-1-guangjie.song@mediatek.com>
 <20250307034454.12243-13-guangjie.song@mediatek.com>
Message-Id: <174132617868.2934304.16819918690236058573.robh@kernel.org>
Subject: Re: [PATCH 12/13] dt-bindings: power: mediatek: Add new MT8196
 power domain


On Fri, 07 Mar 2025 11:44:36 +0800, Guangjie Song wrote:
> Add the binding documentation for power domain on MediaTek MT8196.
> 
> Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
> ---
>  .../mediatek,mt8196-power-controller.yaml     | 74 +++++++++++++++++++
>  include/dt-bindings/power/mt8196-power.h      | 57 ++++++++++++++
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
>  create mode 100644 include/dt-bindings/power/mt8196-power.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.example.dtb: power-controller@1c004000: compatible: ['mediatek,mt8196-scpsys', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/power/mediatek,mt8196-power-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.example.dtb: power-controller@1c004000: reg: [[0, 469778432], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250307034454.12243-13-guangjie.song@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


