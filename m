Return-Path: <linux-pm+bounces-37531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA25C3B53E
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7803561007
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4421330D42;
	Thu,  6 Nov 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llznu7vx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FB330326;
	Thu,  6 Nov 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436079; cv=none; b=Yivu7YZAWgQCINGE2Z39l1pAQYsCl9uE9gJdcwpxvi/JIofCC7rM+EJz5a3BDOanjH8l2JrR4CXdvU16o5KDyYARSoqzsncvxJ1JtM2U2zEI6UtIgXPPWT4TMybIDkIYHTYd6ZvHvaz2a28JTYoFS6ML0gGHv9oluqd0zEJLvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436079; c=relaxed/simple;
	bh=UxsA7mpBbTvyv+g/LrSCFPsTpp7DeoIh9dJ/dkCgAxY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JJldS6UEMbX0Tu25rGi/tFofkreOxFWVxd85ZqBSfvU3J7V+I+ClQBBoRBZVthzPB4eUpH+8b5xR2XD5WBDz3IlOw5oadTWSan1I1CzE/ImflH1flk1yESAKjx+4mzuQKOZeY5gh0/cPxqzH2hHSYQQnAr/y23EQLSN92BRHIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llznu7vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4C6C116C6;
	Thu,  6 Nov 2025 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762436078;
	bh=UxsA7mpBbTvyv+g/LrSCFPsTpp7DeoIh9dJ/dkCgAxY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=llznu7vxVvCdwnCl/IdM4fTDwJiq1ztqiQ6zJ2Ed1+c3HAjvpQk1TkOwDcnTxNJRZ
	 wWff58/kXcPtX0BGe7JdTaR4eGFQSAUwCj2ySVW6AYwbPeVsN463BW05DfIpCWw/hl
	 Jj06IfZCO6KqhJ0grsxnLXj72NGc6eQw5N1vyoBG8o7dBfKxaUqBZ/Bg5VwJpot8/O
	 CvuRqY0Q0zTKdoKJinZos92gB/UOC/NIbZwxyhbXL+BeTpjbnSQOo7CUBr7c+L9Zc6
	 P4WKltBa+np+i9Frx4hv7oveioFV9m0sYcgu5mhVs4L50JnJ7xN3RgtvTtIp0le4rg
	 jmxcZgsRfxNtg==
Date: Thu, 06 Nov 2025 07:34:37 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, sirius.wang@mediatek.com, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, 
 linux-clk@vger.kernel.org, netdev@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, jh.hsu@mediatek.com, 
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Qiqi Wang <qiqi.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Michael Turquette <mturquette@baylibre.com>, vince-wl.liu@mediatek.com, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
In-Reply-To: <20251106124330.1145600-3-irving-ch.lin@mediatek.com>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-3-irving-ch.lin@mediatek.com>
Message-Id: <176243607706.3652517.3944575874711134298.robh@kernel.org>
Subject: Re: [PATCH v3 02/21] dt-bindings: power: mediatek: Add MT8189
 power domain definitions


On Thu, 06 Nov 2025 20:41:47 +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add device tree bindings for the power domains of MediaTek MT8189 SoC.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  1 +
>  .../dt-bindings/power/mediatek,mt8189-power.h | 38 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251106124330.1145600-3-irving-ch.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


