Return-Path: <linux-pm+bounces-27487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6EAC062E
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 09:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527744A2884
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256D2505D2;
	Thu, 22 May 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhoVKYdE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20E24EA8E;
	Thu, 22 May 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900331; cv=none; b=B73bQuV1cU0E+qsleTD/cmB8l/xImhklshk1xV/UEY9mv8bbSIpVjKy1tG1HFlTjUo5lN8teW/Wq8k+IgcJTcQRzib740Ld1dEgNQYRyId5SdU6VaqZ3Ti1c0f1cYlQvcmnLYjYyj7ae25/RwHY44iaBjoOB+X1clMysnDs5u1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900331; c=relaxed/simple;
	bh=T6UY1TqGv//MKV9QGiY+pagJxws1WT6fHX3Dckvh8xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyllpH76Xq6R+WGBhlY2q1iMM9P3GUTf2gkG6rc4cFQXloOpNw2gsh3Aou+7NSZ1xniACisYLrh+mPRUTS3A3CzQIzQ7UIR0ZCgpJHmHwAaY3o1OhbAMeWhxPm2ILPaJebl6qMoX51Oiu89zq9CTPMWLbEJa6WB01c/0BY3U8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhoVKYdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD75C4CEE4;
	Thu, 22 May 2025 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747900330;
	bh=T6UY1TqGv//MKV9QGiY+pagJxws1WT6fHX3Dckvh8xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhoVKYdEO+x6EgNOUvVzOtcWCsJW/PERVPRppCRhBEYlRsbztMloi3w6rNpXaC6cQ
	 XEima4m1fFyVB8RUEoezKyuuoC0BCx9rgwPH2MtW+R5LiqeCqUwzQU54pesJXFAu3f
	 ZsWRoxrPv0lrWj3NzRWjY2kDdAf3m2bFFcFpW+XlmhV/zAO0D79dECPPg/FSQBLlZ+
	 bjgQig4eXpbHM0mfvMiYSSPhv6f6zDSdqRGwdim1muGBD9cTgVtP/DsaTDzZT3ZybJ
	 JOwTxPwiNYDTSsBlDqFH7nZXxFFYWAwpmc3PCt5NiYXpWQAbNSHg8F49jeKeP9CYiE
	 iyViKA7eIJ7ug==
Date: Thu, 22 May 2025 09:52:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: kernel@collabora.com, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>, Hui Liu <hui.liu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Tinghan Shen <tinghan.shen@mediatek.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: mediatek: mt6397: Add
 #sound-dai-cells property
Message-ID: <20250522-independent-ginger-bullfrog-4552d1@kuoka>
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
 <20250514-mt8395-dtb-errors-v2-1-d67b9077c59a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514-mt8395-dtb-errors-v2-1-d67b9077c59a@collabora.com>

On Wed, May 14, 2025 at 10:19:56AM GMT, Julien Massot wrote:
> The 'mt6359.dtsi' file already uses the '#sound-dai-cells' property.
> Add the corresponding property to the binding to fix the following
> dtb-check error:
> 
> mediatek/mt8395-radxa-nio-12l.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

If this is a random drive-by, would be fine, but if that's your platform
which you should know, then I expect this to be a real reason instead
something which can easily be rejected with: what if DTS is wrong?

I could not find the ASoC driver for that compatible and quick glance to
MFD shown me no usage of dai cells, so you need proper explanation here.

Especially, that there is a subnode audio-codec, so adding dai cells to
the parent node feels just wrong. One is wrong - either subnode or
parent is a codec.

> 
> Fixes: 9bc8353be720 ("arm64: dts: mt6359: Add #sound-dai-cells property")
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..9580c4ec1ae00f1dd1182357d8b0a5035a1b7f82 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -30,6 +30,9 @@ description: |
>    See the following for pwrap node definitions:
>    Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
>  
> +allOf:
> +  - $ref: /schemas/sound/dai-common.yaml#
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -53,6 +56,9 @@ properties:
>    "#interrupt-cells":
>      const: 2
>  
> +  '#sound-dai-cells':
> +    const: 1

Also extend the example, if there is one for such device.

Best regards,
Krzysztof


