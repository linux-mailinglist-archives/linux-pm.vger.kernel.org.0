Return-Path: <linux-pm+bounces-26729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B84AAC0C8
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A437BBBBF
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C7278158;
	Tue,  6 May 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EkpS9PDJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597D274641;
	Tue,  6 May 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525833; cv=none; b=QLY4o6sgWtjTm02XpYWntCl3EMwh1Wc8xu0hx/tMLgXyQEhbj3T9MSznD7g+nqmAWF4wbhLjHrT020WM/TiBH/5/c0x7fXHhDCiu2ZjXe8x8MGo5OYgFN+ZiLrIYh+F1YrpYgFwjIdcq3Ui9XYhNJsWm9RSdNw9CSmk3lTgXGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525833; c=relaxed/simple;
	bh=bJyJ7jyIeAMfkphkSNgQEG8wgYNfIHi+6aTP9xuWgv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbyWd55+KHOGvS/dQedTLWXAHYrmhTG4SyhA1w+2VZ4JtlrA02ISsSnBTI9qr5h+RNgYGGKrjdSs7Q13xiXM1spoNWYLAXztRPZe8z3wbEEalpioUiYUBWs/deXOMaUO0TsU6apVfoFFBOLtc8lHN8Ri0S8+H6XrApT08pvUuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EkpS9PDJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746525829;
	bh=bJyJ7jyIeAMfkphkSNgQEG8wgYNfIHi+6aTP9xuWgv8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EkpS9PDJ/Fh5iHdAM4qMNFDGXu/z7Y4zulpt9PekKugbvg3VZ8WDRGbRC0xh9cH0l
	 q3YBP51512gdwfgnKnbqw1XTN9XeeI1zU1F6NNitqWHFrwzeAJDpbgxsTSep5PccBh
	 PfPd2vWVkH749k/4LmdKmEdZqB6fefI5xFphAw9LzCxRvaQcSkeHXU6R7j2PGMHZUt
	 En6duHN3Sl7zcS94fCuXe1/4ddC91gp5rC7lQ9ABa9CzSOpDVFJFeIqiNZVAaTEejf
	 2ui1sci/X+Fisxkdz4DH751jEIBRLqcJDfgXtXkiGRFm5WDzfh2OxIAgAXegJiLqaP
	 WKpnPFPKFzWCA==
Received: from apertis-1.home (2a01cb0892f2D600c8F85cf092D4aF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2793117E088B;
	Tue,  6 May 2025 12:03:48 +0200 (CEST)
Message-ID: <2d3a8e55105526c999b490a2e92dd448c099faab.camel@collabora.com>
Subject: Re: [PATCH 2/4] dt-bindings: iommu: mediatek: mt8195 Accept up to 5
 interrupts
From: Julien Massot <julien.massot@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	kernel@collabora.com, Sen Chu <sen.chu@mediatek.com>, Sean Wang	
 <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones
	 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger	
 <matthias.bgg@gmail.com>, =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado"	
 <nfraprado@collabora.com>, Hui Liu <hui.liu@mediatek.com>, Yong Wu	
 <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon	
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tinghan Shen	
 <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Date: Tue, 06 May 2025 12:03:47 +0200
In-Reply-To: <cb715936-3a44-4002-8d64-565f8d31820c@collabora.com>
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
	 <20250505-mt8395-dtb-errors-v1-2-9c4714dcdcdb@collabora.com>
	 <cb715936-3a44-4002-8d64-565f8d31820c@collabora.com>
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

Hi Angelo,

On Tue, 2025-05-06 at 10:34 +0200, AngeloGioacchino Del Regno wrote:
> Il 05/05/25 15:23, Julien Massot ha scritto:
> > Some Mediatek IOMMU can have up to five interrupts so increase
> > the 'maxItems' to 5.
> >=20
> > Fix the following dtb-check error:
> >=20
> > mediatek/mt8395-radxa-nio-12l.dtb: infra-iommu@10315000: interrupts:
> > [[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 79=
9, 4, 0]] is too long
> >=20
> > Fixes: 3b5838d1d82e3 ("arm64: dts: mt8195: Add iommu and smi nodes")
> > Signed-off-by: Julien Massot <julien.massot@collabora.com>
> > ---
> > =C2=A0 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 =
++-
> > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yam=
l
> > b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > index 75750c64157c868725c087500ac81be4e282c829..035941c2db32170e9a69a53=
63d8c05ef767bb251 100644
> > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > @@ -97,7 +97,8 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0 interrupts:
> > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
>=20
> Isn't minItems already implicitly 1? :-)
>=20
> Looks not, from my understanding if 'minItems' is omitted then
dt-schema is setting it to 'maxItems'.
https://github.com/devicetree-org/dt-schema/blob/v2025.02/dtschema/fixups.p=
y#L129

And you will have an error for a one item interrupts:
Documentation/devicetree/bindings/iommu/mediatek,iommu.example.dtb: iommu@1=
0205000: interrupts: [[0,
139, 8]] is too short

Regards,
Julien

