Return-Path: <linux-pm+bounces-23631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12587A568C5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 14:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCEB16B88E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDD218EBD;
	Fri,  7 Mar 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UH30BZtw"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C0D39ACC;
	Fri,  7 Mar 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353773; cv=none; b=sEtHYYwRR2g2g13XiNv9y6DKfn5U4ILSMscQD6hRTa07obzSUz+VnKh+l5g3/5l72fvNEX5cl2H70MoYBysix4BGq1jnzn8otkoJoeo6Fm93emdaMRLZe1yyLEvc8jxGVeKKI6FlRhFpsqgw1HR1mBHsvOqS/OGMCadpNZlqtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353773; c=relaxed/simple;
	bh=nMdElkX27SYzjIYLE2Nq3THJhnIkeKxIRL8VmbGk6kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abWB9QQ9JjZbBWYLlQlNBXq7d1hQak6UZuYtZ1Wbaa+M/uNvPYx3V5PtXPJoiBRo8m+J6s1llQmzDRz55YLV3L2BOw4gv3kx3LDaoNr0pgBbev4OhAGF66mni8ACf5k1Cp4d4wqGyDkICY41UT15FOUBc0SRsNCqu5otwMYUPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UH30BZtw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741353763;
	bh=nMdElkX27SYzjIYLE2Nq3THJhnIkeKxIRL8VmbGk6kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UH30BZtwjumsTG+ymcK82JDw2TOztk6pPaFGRIpxdfLL1yrF5Rmrv9L+JIpB89d94
	 ka7coYAc8FoQpIRTFFbPiKgBC//VrsODHU+kGTJxpx9+Ng0X/71/Ny2kMGDpjBVY+0
	 ODUgWtfT8q1pjxowPX9FiTO3UPu+04ep7laZhiObugs3aPEkCrZr2FrZI6FDCHxv3g
	 BXWuwjjbT9K0PdGHnHZh131bbuZcUHc1yWlKt0ZMbXggm/q6uOk8W3E54qS4BZJvd6
	 mkdlKAI6qFkfL7sDjOm41FPFfpS7Qp7vgQzpDzA3oRd6sKGVbxDXyy2Ac0NupiiBG3
	 9Q96c+BviI4RQ==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A168917E05C1;
	Fri,  7 Mar 2025 14:22:38 +0100 (CET)
Date: Fri, 7 Mar 2025 10:22:36 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel@collabora.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 01/19] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
Message-ID: <cb2820d8-84e8-49ca-b497-1ea815679a3d@notapiano>
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
 <20250305-mt6359-accdet-dts-v4-1-e5ffa5ee9991@collabora.com>
 <20250306-certain-jasmine-mastiff-fd67ba@krzk-bin>
 <2fa6037d-b5e9-45b2-a5d5-dbc92fb3434b@notapiano>
 <0663e03e-e331-4a06-be95-ce8d9059ed6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0663e03e-e331-4a06-be95-ce8d9059ed6b@kernel.org>

On Fri, Mar 07, 2025 at 08:11:26AM +0100, Krzysztof Kozlowski wrote:
> On 06/03/2025 13:19, Nícolas F. R. A. Prado wrote:
> >>>    It is interfaced to host controller using SPI interface by a proprietary hardware
> >>>    called PMIC wrapper or pwrap. MT6397/MT6323 PMIC is a child device of pwrap.
> >>> @@ -224,6 +225,30 @@ properties:
> >>>      description:
> >>>        Pin controller
> >>>  
> >>> +  accdet:
> >>> +    type: object
> >>> +    additionalProperties: false
> >>> +    description:
> >>> +      The Accessory Detection module found on the PMIC allows detecting audio
> >>> +      jack insertion and removal, as well as identifying the type of events
> >>> +      connected to the jack.
> >>> +
> >>> +    properties:
> >>> +      compatible:
> >>> +        const: mediatek,mt6359-accdet
> >>
> >> You just removed the other file, no folding happened here. Drop the
> >> accdet node and fold this into parent.
> > 
> > Sorry, I'm still not sure what you mean by folding here then. Right now the
> > accdet is a subnode of the PMIC. If you want me to remove the accdet node, where
> 
> Yes
> 
> > would its compatible and property go?
> 
> compatible: nowhere, because it is close to redundancy.
> 
> property: to the parent pmic node.
> 
>     pmic {
>         compatible = "mediatek,mt6359";
>         interrupt-controller;
>         #interrupt-cells = <2>;
> 
>         mediatek,hp-eint-high;
>     };

I'm not sure that's right. The ACCDET submodule does have some resources, IRQs,
that it registers in its mfd cell, see patch 2 of this series [1]. It also has
its own driver (sound/soc/codecs/mt6359-accdet.c) that probes based on this
compatible and handles those interrupts. Why would it not get its own node like
the other MFD cells?

[1] https://lore.kernel.org/all/20250305-mt6359-accdet-dts-v4-2-e5ffa5ee9991@collabora.com

Thanks,
Nícolas

