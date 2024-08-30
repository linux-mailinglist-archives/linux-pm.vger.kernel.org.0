Return-Path: <linux-pm+bounces-13244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF839966480
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 16:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB381C23F9A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07631B2ECF;
	Fri, 30 Aug 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoElR0+B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF71B1D64;
	Fri, 30 Aug 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029458; cv=none; b=mw2f7xLp2ly4cwwnFf7nsnz4Vcu5Vu5HZvD5fA5aXm/gFXaCag0gs9DtI9gU5fpVzIy+k7Z2vh2QKkEvFHDHyxC3FZo89iMXF5gMemNRZCw5ki/TyDPxLrwBv4/UVHPgpohZdKpQ4+8gQwxGxY+9avf3qvpR8SZU3eIbaEiCw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029458; c=relaxed/simple;
	bh=kRMCF26wuGa6fCppevhtQabJCmV3ZfyXGSTCv60EXrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI8iyc6qXOyg9JfHNG4Y1rBD5oRbDiww1fKOotZc3Lj/i5GHshQCYZNfk769QKhovDZX1EHwQpFMLKwFxgrn01XAP1uyt8u8diM8hIbk5Yf+1wTBQ7gTGX+jzsPA+S0HG6EBzKpHraBvuDTYEh6tuq+a47W9xj3lMEchD5Jnfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoElR0+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4B2C4CEC2;
	Fri, 30 Aug 2024 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029457;
	bh=kRMCF26wuGa6fCppevhtQabJCmV3ZfyXGSTCv60EXrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoElR0+BEKAItp3ZltAJ4hfx15LW5ZCBAIc7a1KybMqxjcIKMC67E4rWLEpWHvb4a
	 G6dOkp47XunRM8zTYmFTInlOIdnkF66zoiAgixQyarenRCAkfIKMLyVYsDuU9o/kCS
	 f231oaHLP7VFwo8EsZ56fhIJTKsgzpO2kLD+FJETFf/hCbHS2PhN7sckV2nvwO3W0u
	 HJIRer6USNXJJK1SS4jTdiHTgYeKKaMKjKg3mlngzLVgu1OzQgocT4PNsMxNQsmUKc
	 xobBZQAtAVWC14jVsyb3ZpYLWIhBBpxe9LjJbsDFMaeiqyHU/hAJD+Mgocba0Dv/Jm
	 W8f85o2c7pE6g==
Date: Fri, 30 Aug 2024 09:50:56 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 1/7] regulator: dt-bindings: mt6323: Convert to DT
 schema
Message-ID: <20240830145056.GA4170065-robh@kernel.org>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110732.30080-1-macpaul.lin@mediatek.com>

On Fri, Aug 30, 2024 at 07:07:26PM +0800, Macpaul Lin wrote:
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
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
> new file mode 100644
> index 0000000..f7c2a03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6323-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6323 Regulator
> +
> +maintainers:
> +  - John Crispin <john@phrozen.org>
> +  - Sen Chu <sen.chu@mediatek.com>
> +  - Macpaul Lin <macpaul.lin@mediatek.com>
> +
> +description:
> +  Regulator node of the PMIC. This node should under the PMIC's device node.
> +  All voltage regulators provided by the PMIC are described as sub-nodes of
> +  this node.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt6323-regulator
> +
> +patternProperties:
> +  "^(buck_)?v(pa|proc|sys)$":
> +    description: Buck regulators
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes: false
> +    unevaluatedProperties: false
> +
> +  "^(ldo_)?v(camio|cn18)$":

Why are buck_ and ldo_ prefixes optional? The old binding didn't reflect 
actual (upstream) users? If so, that's fine, but mention that in the 
commit message.

Rob

