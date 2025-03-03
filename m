Return-Path: <linux-pm+bounces-23315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8566A4C3BA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2FF170E2A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E21F473A;
	Mon,  3 Mar 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pR0IFrRI"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A08F142E6F;
	Mon,  3 Mar 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013158; cv=none; b=GXEBwbAsqXsgf0HeejCcIpMkc3djSEFTPt5uSDbbBHty0vwczuwgkktqybn73/eiyfxY00b/XmZF/wpN2SAiSD8zWAUjrxoz9jCINU39BDMRS/ahDXgsV19+3Obpi6Njrs8O8SpVamJAEjGlxRPPYLZRUegA2SSwCRJzpD2Wvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013158; c=relaxed/simple;
	bh=oQYo31W0WahUUgGafPAeoZtr6PUwTcxwzU94GR9sNHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHFbhiEQaaUWaqhPq1MqFiMdYZe7DWZKdk1v3xoLgjrg2iMsNdQwBdGBLe+xORWOrMQsvov/oERZjsSZ1zH/evDfxfmoMVEbu/YT60GpjwMmF52QAy6rj97xR9+NnRJkk8tjAtGebHEXBcIqT2YQGOzYcdSnMHO5MkOQyu0MEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pR0IFrRI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741013154;
	bh=oQYo31W0WahUUgGafPAeoZtr6PUwTcxwzU94GR9sNHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pR0IFrRInKm/4EW6eI5mCbpu6AcfVVOO9d1GKUgU8zBG7hrdEKWti0g2z9qKTo7gY
	 TIySusZ81Wlxzu0ugr8hSJHkluVicHzHktayYvlfQ4JY4C69Xs5d49ZVZ6VP4GF+xF
	 6x/X1Q1rWFk4lojtvsxX04cw/WDmhoz8DRzu77hkZqIwfXOvX53TDdtA/kVJdWvDSg
	 tmJPG7aZWAePfIVwt4zSMqPpShGVez3MrIzhk6GdTU3a3lDV8epkhGjXQKMo5WxJ7m
	 9lKkFUxXIl8HQz2256mS7B6P4G9A2R/UfRp3swUIQHxuY4jUNWGJwtron53UPxB3uN
	 nbZzneyQzINPw==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 909A317E0E8D;
	Mon,  3 Mar 2025 15:45:49 +0100 (CET)
Date: Mon, 3 Mar 2025 11:45:47 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel@collabora.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/20] ASoC: dt-bindings: Add document for
 mt6359-accdet
Message-ID: <0120fe30-43c4-4fec-8b5e-fdb6b382fc2a@notapiano>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-1-5bd633ee0d47@collabora.com>
 <628a81c5-b9f1-4be9-84ec-90022a3526da@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <628a81c5-b9f1-4be9-84ec-90022a3526da@collabora.com>

On Mon, Mar 03, 2025 at 12:14:51PM +0100, AngeloGioacchino Del Regno wrote:
> Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> > Add dt-binding for the MT6359 ACCDET hardware block.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   .../bindings/sound/mediatek,mt6359-accdet.yaml     | 42 ++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..d08a79301409374714c76135b061e20e8e8acfaf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/mediatek,mt6359-accdet.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MT6359 Accessory Detection
> > +
> > +maintainers:
> > +  - Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > +
> > +description: |
> > +  The MT6359 Accessory Detection block is part of the MT6359 PMIC and allows
> > +  detecting audio jack insertion and removal, as well as identifying the type of
> > +  events connected to the jack.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6359-accdet
> > +
> > +  mediatek,hp-eint-high:
> > +    type: boolean
> > +    description:
> > +      By default, the HP_EINT pin is assumed to be pulled high and connected to
> 
> Just to be clearer about this pin being an internal one and not externally sourced,
> so, *not* a SoC GPIO, but somehing that is completely provided and handled by the
> accdet IP...
> 
> "By default, the accdet IP's internal HP_EINT pin is assumed to be pulled ..."

The HP_EINT is an external, not internal, pin of the MT6359 PMIC. It is an input
pin of the MT6359 IC that gets wired to the tip (left channel) of a 3.5mm audio
jack to allow for detecting when a plug is connected.

Since this dt-binding is about an IP in the MT6359 PMIC, I think when saying
"HP_EINT pin" it is already clear that the pin is on the MT6359 IC, but if you
think it's necessary I could make it "MT6359's HP_EINT pin".

Thanks,
Nícolas

