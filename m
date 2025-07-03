Return-Path: <linux-pm+bounces-30079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75AAF7FFE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 20:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572BA581F1C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4A2E6D1A;
	Thu,  3 Jul 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="lB5lACBU"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955528E616;
	Thu,  3 Jul 2025 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567308; cv=pass; b=Xnv3yBKLCIdRJk3fQZyyFz4CvsRrxdDqDLLUn8iAXgglriWvWA6e/djjhL9yuCNYsm8uBETwOUSb0xqs4QrBpCGqye5A4CCfVVEraguj/BrzBqHzSgVCxxPBPKjbXWYfJmgwaolZAFEGcPla9ONCnFx+6wKClQNksKY+N+y7M3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567308; c=relaxed/simple;
	bh=EIGTeSFGl+y3lSh82LnuwOwDvyKO/NJTdsF2vBpDxJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOI843MKyM6YVuLsI1QxO8QmxAW1U1Gd/6tuQ7HcCwAmMrYOBZieqIr0hJZTx2zP4edATqVagHt78ipdB632TG0fCsBTLyauYv9GA0CssMo7KH9XbVAgkyhas4CvtIFDa/Yb0cPtGs0z3dPFJj7sBlVXJ32A7Gs7JQZz3Zrs/hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=lB5lACBU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751567269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EAwRzK/atLZp81y99CJDlb538jQm470pWJL4qPIlO8yDaz/DWV2sIUxttUGQHjEl44LLYuE4sHAVToGp3ItB4hvFekOq1tkPgSHMhWmyBO0b+edEooKS8kV0ovrSYr3icN1n4sMdmnLop98XqG7Sk9kEt8I1Ab6bAzG/USpdsiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751567269; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EIGTeSFGl+y3lSh82LnuwOwDvyKO/NJTdsF2vBpDxJ0=; 
	b=oB0LfmZBG66ZUZ/wv2kO3rQ97NauunYjM3/lZhpzefJ4wUSNUf15RztBrKGu7NBuyE4lFC5hwuyj0wBCPTHU3df5Eiq/AV1roJVSMbp0NyYEYnzBRPBNR0yKbmGWAgK0ZHyWewIRMIjFESDHy9RjAEGPSiA7vsdR0h17mRUOduQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751567269;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=EIGTeSFGl+y3lSh82LnuwOwDvyKO/NJTdsF2vBpDxJ0=;
	b=lB5lACBUqAuSqEfnmk/y2Ek/zH4biccP08KIK/ORsFGlJv/GtpNvLOKD96lJEfkC
	io0PymrNsahr9NRUjcE28owwMk57ai76yrZR6iFrzMzFSYWU6z6+jjXEMIOVNENEopU
	OUosdZjl2cu7sFBOMDJ6QRDtaa1d5+CmypeIdqss=
Received: by mx.zohomail.com with SMTPS id 1751567267207310.7183175991179;
	Thu, 3 Jul 2025 11:27:47 -0700 (PDT)
Message-ID: <5bfcd5e059e86a96807426bfc6543209d09b557f.camel@collabora.com>
Subject: Re: [PATCH 00/10] pmdomain: Partial refactor, support modem and RTFF
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ulf.hansson@linaro.org, y.oudjana@protonmail.com, 
	fshao@chromium.org, wenst@chromium.org, lihongbo22@huawei.com, 
	mandyjh.liu@mediatek.com, mbrugger@suse.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Date: Thu, 03 Jul 2025 14:27:45 -0400
In-Reply-To: <20250703110247.99927-1-angelogioacchino.delregno@collabora.com>
References: <20250703110247.99927-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Thu, 2025-07-03 at 13:02 +0200, AngeloGioacchino Del Regno wrote:
> This series is a subset of [1], leaving out the Hardware Voter
> specific
> bits for MT8196 until the discussion around it reaches a conclusion.
[..]
> Compared to v1 in [1]:
> =C2=A0- Changed mediatek,bus-protection to access-controllers
> =C2=A0=C2=A0 as suggested by Rob (thanks!)
> =C2=A0- Added commits to document #access-controller-cells on all of
> =C2=A0=C2=A0 the access control providers
[..]
> [1]
> https://lore.kernel.org/all/20250623120154.109429-1-angelogioacchino.delr=
egno@collabora.com
>=20
> AngeloGioacchino Del Regno (10):
> =C2=A0 dt-bindings: memory: mtk-smi: Document #access-controller-cells
> =C2=A0 dt-bindings: clock: mediatek: Document #access-controller-cells
> =C2=A0 dt-bindings: power: mediatek: Document access-controllers property
> =C2=A0 pmdomain: mediatek: Refactor bus protection regmaps retrieval
> =C2=A0 pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
> =C2=A0 pmdomain: mediatek: Move ctl sequences out of power_on/off
> functions
> =C2=A0 pmdomain: mediatek: Add support for modem power sequences
> =C2=A0 pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
> =C2=A0 pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
> =C2=A0 arm64: dts: mediatek: Convert all SoCs to use access-controllers

As already pointed out by rob's bot you're missing adding the
properties to

mediatek,mt8195-sys-clock.yaml
mediatek,mt8188-sys-clock.yaml

on patch 2. But other than that, for the whole series (since the tag
wasn't added from the previous version):

Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

--=20
Thanks,

N=C3=ADcolas

