Return-Path: <linux-pm+bounces-27121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DBAB6584
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E45B3B3C61
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD622129A;
	Wed, 14 May 2025 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fPNowCp8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D621D59C;
	Wed, 14 May 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210408; cv=none; b=NHCpXUX4uAYqPlSWJe3Na8r29i60ZTUzyrU9+Ah54CUr86HkYZY1bhHD/kch/vuhRtoMAtBiQ64ieQie7xHFAFIHkFxkeJ5l8WSZMSMMHjoCtUwGgfcOHYp+stxoG1vYLFJtvG3kMb/LPt3BsOIqco1ysJ42mSk8jMqjXuPbpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210408; c=relaxed/simple;
	bh=oHkcxL3Y62ikM1d3qC7iYxA+tfz6ICk3Lt28MrW2oio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kytae+MlNiloLKhynS9zdMtT1jdk1qHWxLOqfz9+OdoBePv4w9tH9IeoJTA7Yo7iegpHXM5ldRP9gyrEBI3008JuGjupP0LPn1PYUnbkIR9Q4mLGUfp7khxgBSwhYCXq1U3y2GcywM3673yYyyVbTutKfNM/+evwK4rId03RbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fPNowCp8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747210404;
	bh=oHkcxL3Y62ikM1d3qC7iYxA+tfz6ICk3Lt28MrW2oio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fPNowCp8+2Wc5dg7WuiJqGnBVHm2WzyPKohjuS9pBe+MyFzvIeiAP2JxTCXhDftzG
	 Uk5t/2BxTzIzFnfGpJYpABQzb9fSO+Ml9b6mS6g/hywuGotXZATD25aUsJVk2JKnfq
	 JcvVX4akRf9oJAnBTwM/g2T3sKFMeztoFcy6PWrigwwUsabjn7zQaf+1xMLWp4Zp90
	 GEJB8wMRjYssM/BA+FaJ6/o8T8HY0lQ3g6czB1z3JNR744pb8BhAjfBQNfbZoQ0O/l
	 ZnSH7VW5I4CPw+Ta12jAsJlRvgt8iZcli5tKKi7Qb3UqTI3/8t086fa/r/zYE49qtj
	 gGEs0c9dDTboQ==
Received: from apertis-1.home (2a01cb0892F2d600c8f85Cf092D4AF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 36FE817E0FC3;
	Wed, 14 May 2025 10:13:23 +0200 (CEST)
Message-ID: <8cb04f202171821ceab379df78c4801f35443d77.camel@collabora.com>
Subject: Re: [PATCH 2/4] dt-bindings: iommu: mediatek: mt8195 Accept up to 5
 interrupts
From: Julien Massot <julien.massot@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski	 <krzk@kernel.org>, kernel@collabora.com, Sen Chu
 <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Lee Jones	 <lee@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger	 <matthias.bgg@gmail.com>,
 =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado"	 <nfraprado@collabora.com>, Hui
 Liu <hui.liu@mediatek.com>, Yong Wu	 <yong.wu@mediatek.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon	 <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Tinghan Shen	 <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Date: Wed, 14 May 2025 10:13:22 +0200
In-Reply-To: <ff8da58b-9e87-46d9-b4d2-4059ef05780d@collabora.com>
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
	 <20250505-mt8395-dtb-errors-v1-2-9c4714dcdcdb@collabora.com>
	 <baeae909-4d12-4cbd-a063-7ad165304b96@kernel.org>
	 <ff8da58b-9e87-46d9-b4d2-4059ef05780d@collabora.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof, Angelo,

On Thu, 2025-05-08 at 10:34 +0200, AngeloGioacchino Del Regno wrote:
> Il 08/05/25 08:03, Krzysztof Kozlowski ha scritto:
> > On 05/05/2025 15:23, Julien Massot wrote:
> > >=20
> > > Fixes: 3b5838d1d82e3 ("arm64: dts: mt8195: Add iommu and smi nodes")
> > > Signed-off-by: Julien Massot <julien.massot@collabora.com>
> > > ---
> > > =C2=A0 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | =
3 ++-
> > > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.y=
aml
> > > b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > index 75750c64157c868725c087500ac81be4e282c829..035941c2db32170e9a69a=
5363d8c05ef767bb251
> > > 100644
> > > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > @@ -97,7 +97,8 @@ properties:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0 interrupts:
> > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 5
> > > =C2=A0=20
> > Every iommu or just some (as described in commit msg) can have 5
> > interrupts? Looks you miss here proper constraints per variant.
> >=20
> Technically, all of the IOMMUs can have more than one interrupt - but it'=
s not
> clear which one and why, as documentation is lacking.
>=20
> Let's restrict this discussion to MT8195 anyway, as it's the only one dec=
laring
> those 5 interrupts...
> ...all of the IOMMUs declare just one, and mediatek,mt8195-iommu-infra de=
clares 5.

Setting 5 interrupts will be restricted to mt8195 infra iommu in the v2.

Regards,
Julien

