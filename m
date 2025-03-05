Return-Path: <linux-pm+bounces-23464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255EA4F79B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 08:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591B83AB851
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 07:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0511E5B96;
	Wed,  5 Mar 2025 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj/yz0O7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B0156F44;
	Wed,  5 Mar 2025 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158307; cv=none; b=TEnNTeTpDzrs6NY7668RqV8iAasobPu05S36s5s2Etzhz4Uj4A66ZB1edN2Vk6JooLRY9o4BpziwdxS33s8MGCHipWw/oJeP+8UIAmAP37JSb/6uxyzljietpmlYxOjRbSdy0kO652gMuzjjvQPvHi4cZZnDQ92Zz1WYg+1Q50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158307; c=relaxed/simple;
	bh=UzdLNCI0bfSar6q7q7rZ73KBcX1BCzYbwcMYrNzDXQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBLRaUoi705TJxZQ+EWGVKQKgER2vexS56asqbS7h+gJh2lnFsf3Nbj/g7pBmqmCHVisHdw1Q+Nky0/Oj/Od7K6cuGTeeeq8H+LipyEYpbb08HN4GAmG4ysdBpjieb2Aoves1QLka4UjvQ0oBlx8QsavXAgoGw+nGjl+CkD+3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj/yz0O7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B58AC4CEE2;
	Wed,  5 Mar 2025 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741158305;
	bh=UzdLNCI0bfSar6q7q7rZ73KBcX1BCzYbwcMYrNzDXQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pj/yz0O7pjEBKga/lkQ2UIlP5JHjwdc95mwGGdwFtSrK2EF3Sw5hVWJQZcDgdxMch
	 zuyubpPULuh80KoCz19ZE0hlZJ9I+2L61+WT2wH98AqF/1Cc3f9NnkbXUlLO+bKPQe
	 3ZSGMPGGW8Adzo/1FNjDXzE+Z612U5iacNThZ0KoIcSXPFbnAiR2QE/y79RMvGNlyy
	 USKcSDi7NdhVkos0GFyQ9ffkAmo/X8aRZPE9vIZgboDD//IIyliPAyxgTyZxdV/los
	 SYZMXwdKK4/RjMZZc1DoLMBZQ7NYFgK/JZe2xQCtq6xrRnY9tqLrBRWWu1gAwWFbjZ
	 RKwdxU+NI5YfQ==
Date: Wed, 5 Mar 2025 08:05:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, kernel@collabora.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 01/20] ASoC: dt-bindings: Add document for
 mt6359-accdet
Message-ID: <20250305-stylish-grumpy-chital-ea6e4c@krzk-bin>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
 <20250304-mt6359-accdet-dts-v3-1-5b0eafc29f5b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250304-mt6359-accdet-dts-v3-1-5b0eafc29f5b@collabora.com>

On Tue, Mar 04, 2025 at 12:15:42PM -0300, N=C3=ADcolas F. R. A. Prado wrote:
> Add dt-binding for the MT6359 ACCDET hardware block.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  .../bindings/sound/mediatek,mt6359-accdet.yaml     | 42 ++++++++++++++++=
++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accd=
et.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.ya=
ml
> new file mode 100644
> index 0000000000000000000000000000000000000000..1d27148ed7bffee3f73015c8a=
f88bfffa8701843
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt6359-accdet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6359 Accessory Detection
> +
> +maintainers:
> +  - N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> +
> +description:
> +  The MT6359 Accessory Detection block is part of the MT6359 PMIC and al=
lows
> +  detecting audio jack insertion and removal, as well as identifying the=
 type of
> +  events connected to the jack.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6359-accdet

There are no resources here, so this should be folded into parent node.

Best regards,
Krzysztof


