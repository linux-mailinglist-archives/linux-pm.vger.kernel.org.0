Return-Path: <linux-pm+bounces-23562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB771A54A87
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 13:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE013188A5CF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27D20897A;
	Thu,  6 Mar 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jTAC4v8c"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901F1853;
	Thu,  6 Mar 2025 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263579; cv=none; b=J6lEUuYlmAqhFoj5LXfCmVC2TR+CRhTexfh9CYY7HjUINUVgx3LbbAM7eYF2QULRqha49IuaXoF5VNKdyfwxo8RvwmrOy8hx8bZy5/IRZEuRawT/fiL9bYYcTZUvyaCzTSl1RuYPiT/7IsF/i94idqTfHTxKXt3++A4DhuP504E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263579; c=relaxed/simple;
	bh=bRmppDD3UR7+vn2dZ4ulwCSuB4hzHfQscGhABBmBL1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mITzGx5o+ZFl3664l0KltsHvgpJK8QfwZ21lPc8+FuwLMjfVsLFjaSOOs+uSnuVq666oO9DMwhHa2OFsDC8osWqZj8UG7SRwEL99/W1WwgbkGVL2+wlnBDqbCeXgLbFGwHhgk/xmc/PCMODYXjHTRIMr89oifaoJha+HQkGMiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jTAC4v8c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741263569;
	bh=bRmppDD3UR7+vn2dZ4ulwCSuB4hzHfQscGhABBmBL1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTAC4v8chbBR5zWYrExx/9feWvRDBAz/LoFBo5IIwdoskEr4r4MBezh1BjF9cWhn+
	 tjB7pNeZO9E8O5wZ/xWAtARkBL4EenhqpLMpN4Sp66HE4LZy/cnIayknvG3sKTf/ai
	 np6xd/fWMbxKm90MukAR1sIuNERigRVsSFFop5ejqhGc0Digb+w8PbAGR1fIbfS1Py
	 P+Y5J87e1U0tGrR+x5Lc4aBMzRGYVBxmsFwm39XSPtjG719uhridTSX2nTINBVrex1
	 N+P0+LiOw6QYBsUCy8Gwd6bSotIzLjdiNVXEZfU0lhOmHxBx21VBn6l3KVwg1eyxYg
	 kLxABJhWONk/g==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CF14317E09AA;
	Thu,  6 Mar 2025 13:19:24 +0100 (CET)
Date: Thu, 6 Mar 2025 09:19:22 -0300
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
Message-ID: <2fa6037d-b5e9-45b2-a5d5-dbc92fb3434b@notapiano>
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
 <20250305-mt6359-accdet-dts-v4-1-e5ffa5ee9991@collabora.com>
 <20250306-certain-jasmine-mastiff-fd67ba@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250306-certain-jasmine-mastiff-fd67ba@krzk-bin>

On Thu, Mar 06, 2025 at 08:57:27AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Mar 05, 2025 at 03:58:16PM -0300, Nícolas F. R. A. Prado wrote:
> > Describe the accessory detection (accdet) module as a possible subnode
> > of the MT6359 PMIC.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >  .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> > index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..51012b8bbfaef3df7bdb619a4f8d828d6f9cc15a 100644
> > --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> > @@ -24,6 +24,7 @@ description: |
> >    - LED
> >    - Keys
> >    - Power controller
> > +  - Accessory Detection
> >  
> >    It is interfaced to host controller using SPI interface by a proprietary hardware
> >    called PMIC wrapper or pwrap. MT6397/MT6323 PMIC is a child device of pwrap.
> > @@ -224,6 +225,30 @@ properties:
> >      description:
> >        Pin controller
> >  
> > +  accdet:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      The Accessory Detection module found on the PMIC allows detecting audio
> > +      jack insertion and removal, as well as identifying the type of events
> > +      connected to the jack.
> > +
> > +    properties:
> > +      compatible:
> > +        const: mediatek,mt6359-accdet
> 
> You just removed the other file, no folding happened here. Drop the
> accdet node and fold this into parent.

Sorry, I'm still not sure what you mean by folding here then. Right now the
accdet is a subnode of the PMIC. If you want me to remove the accdet node, where
would its compatible and property go?

    pmic {
        compatible = "mediatek,mt6359";
        interrupt-controller;
        #interrupt-cells = <2>;

        accdet {
            compatible = "mediatek,mt6359-accdet";
            mediatek,hp-eint-high;
        };
    };

Thanks,
Nícolas

