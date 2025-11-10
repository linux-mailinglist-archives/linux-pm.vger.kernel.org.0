Return-Path: <linux-pm+bounces-37705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA4C45C4A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE0E3A72B0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DC2FF66A;
	Mon, 10 Nov 2025 09:54:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B1301021
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768452; cv=none; b=XpG6WOReM3TMxxmEkoffOP46xT+vL+jHI6zo97kBOzSRWECgns1lVJa0jULjY2ZktCyw9AryUjfVop+DzS6/An4/WJBSpOnDw8mYk3AXAQPQcQk9aixH+s+Goh8Kirp/Up0S6MPx3+NWLpJwlOAHcRAMCfK0M8JyckTcLPpDzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768452; c=relaxed/simple;
	bh=PVXLDkuHHFvyZQz+1o4/lWragmCZ5hrUErTyRjPbQpg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDTlBfCkd/HBQBXJgIhM7Yw/Hl2fhpI1eDomLDccaHgVGa15JHe3DZj4Pb37GTUxrLJVBBo8yfHV7EgTPVE+fjmRGmgwusPzh8rwMjycKaRKtStVLDZd/+FSV7dxUqO6afaLO0f1iEv+oFzrQBCSf7trqVcrBpD0ttvVkrx2Ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIOav-0007E6-9l; Mon, 10 Nov 2025 10:53:53 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIOas-00802Y-2g;
	Mon, 10 Nov 2025 10:53:50 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIOas-000000006yf-36Uu;
	Mon, 10 Nov 2025 10:53:50 +0100
Message-ID: <802768a286aa167f7fdc80857508180964ac7f8c.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Add MT8189
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Hanchien Lin <hanchien.lin@mediatek.com>, "Rafael J . Wysocki"	
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui	
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Balsam CHIHI <bchihi@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com,
 raymond.sun@mediatek.com, 	Irving-CH.lin@mediatek.com
Date: Mon, 10 Nov 2025 10:53:50 +0100
In-Reply-To: <20251110094113.3965182-3-hanchien.lin@mediatek.com>
References: <20251110094113.3965182-1-hanchien.lin@mediatek.com>
	 <20251110094113.3965182-3-hanchien.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Mo, 2025-11-10 at 17:40 +0800, Hanchien Lin wrote:
> Add support for the MediaTek MT8189 SoC to the LVTS thermal driver.
>=20
> Signed-off-by: Hanchien Lin <hanchien.lin@mediatek.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 155 ++++++++++++++++++++++--
>  1 file changed, 144 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index ab55b20cda47..8c15fdaac48c 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
[...]
> @@ -1334,9 +1359,15 @@ static int lvts_probe(struct platform_device *pdev=
)
>  	if (IS_ERR(lvts_td->base))
>  		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io re=
source\n");
> =20
> -	lvts_td->reset =3D devm_reset_control_get_by_index(dev, 0);
> -	if (IS_ERR(lvts_td->reset))
> -		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get rese=
t control\n");
> +	if (!lvts_data->reset_no_need) {
> +		lvts_td->reset =3D devm_reset_control_get_by_index(dev, 0);

This should be devm_reset_control_get_exclusive(dev, NULL) instead of
devm_reset_control_get_by_index(dev, 0).

No need to use by_index for a single reset control.

regards
Philipp

