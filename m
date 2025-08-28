Return-Path: <linux-pm+bounces-33226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87080B39616
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDE23AF905
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8536F2D4809;
	Thu, 28 Aug 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="puqHU76G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CAnb7nIE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5762773E2;
	Thu, 28 Aug 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367930; cv=none; b=Xc3yy1HEWIvNjxwqgFryidoU1uPlLrpiE5DuV6HWXzkRz6LXPps/AIN8gZHbKXnUsEx1DWTGvESDkyCDklXr/XBk4ZkCSfG9zncZvXJQPunG31MI69HVD4AxYO3/8VyG4oYdHr91K7fOsxpf+jlmv5Li1MqSjnOfGB78BsW7oOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367930; c=relaxed/simple;
	bh=gaSpXv0ICwsK/7v7Tncv+J8aK2en0MPZUcPtGMmZDLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMzbjgM1lcI9M3ciyT645UFk4mMwUjOFAfuUD79KvpqZEDJIPHbsEyhjRds8AygcEh7zfLyZB40bgTHIwERTrElsqA3banCcw7E9AkDGKtfaAhF7cR6FOdSdB+x3NIxGjlRGQWqNr+fLv3GGxU5b4oCyx5iHPIScz2CEnG7Bj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=puqHU76G; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CAnb7nIE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756367927; x=1787903927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nz66e75Mw/joctaT7IK/sW+8Q9QeMNVlbhhEkyRonII=;
  b=puqHU76G4dB21QNxQ3GiDSyjNm/0N3l/kRIfPIaTmHf7W+DlOP93MMD/
   ZY/p7LcieqA+mKv8wRtvy9t5GcXqD+efrQuHaI4v0Fg2s0bxt6ayA9H7x
   fOUQyfnw7f/mqcstHBx6yC5dws7KDZvygburoeiKPBOyeWghMMvJ0Vur2
   FkNxQvmFdd02UNfFX55PoVivZNobS8aFQePSaRJCsaN4+zF0+0LfZ+xev
   llM2t1Zh5pZZgb2FJHHXTgw6HVT8hv8NMQHE8HwybNvMec156dmPf26J5
   ukb6Od3gyCPU9+WB8GjcRJzxKcFsIdg8aHB9SIqYy6sRe2XPnOW5WCn7b
   w==;
X-CSE-ConnectionGUID: m84Vz8+GRPe/MrLV5ldJOA==
X-CSE-MsgGUID: JvIyF86oT1OFgkVW/kgS2w==
X-IronPort-AV: E=Sophos;i="6.18,217,1751234400"; 
   d="scan'208";a="45949539"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2025 09:58:44 +0200
X-CheckPoint: {68B00C34-24-299FBAB0-EF52EDE7}
X-MAIL-CPID: 284D0053C170DCD727D862DA4D118536_5
X-Control-Analysis: str=0001.0A002121.68B00BC8.007F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E67321612FF;
	Thu, 28 Aug 2025 09:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756367920;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nz66e75Mw/joctaT7IK/sW+8Q9QeMNVlbhhEkyRonII=;
	b=CAnb7nIEGTqAegv5WMD3yN1b6wd/oPzGGLaKxLhMcLOxzsBQayUmACfoRTfXzbIPh794MQ
	7xQGApYa0RHNPGoTQ+rSREEbMOse3K2oC37eRg/ESDaLDxCYxXhrY44sFjJwKHVp1Ubj+Q
	FRY40wvGre4dJxxF/4p3G2WD1P1vkfRkFIr+fCtMPKG+7yWiTBp+6bDUFDuyt8vqU7YTfF
	Z6BAfZ8qRTGLcKfYRhUbkJSk6+zCpBI6/iGmQKTKohhdIaUyH9VT7xjWoP6CjTk1FsP+xL
	8zFG/dPwuIteSmVAIjKUv1ovaxg++aibXUv1nUzGAlqGKBUrqECGVtSMOUmiJA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 frieder.schrempf@kontron.de, primoz.fiser@norik.com, othacehe@gnu.org,
 Markus.Niebel@ew.tq-group.com, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
 Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v9 6/6] net: stmmac: imx: add i.MX91 support
Date: Thu, 28 Aug 2025 09:58:36 +0200
Message-ID: <3304317.5fSG56mABF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250825091223.1378137-7-joy.zou@nxp.com>
References:
 <20250825091223.1378137-1-joy.zou@nxp.com>
 <20250825091223.1378137-7-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Montag, 25. August 2025, 11:12:23 CEST schrieb Joy Zou:
> Add i.MX91 specific settings for EQoS.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> Changes for v5:
> 1. add imx91 support.
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac-imx.c
> index c2d9e89f0063..2c82f7bce32f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -301,6 +301,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struc=
t device *dev)
>  	dwmac->clk_mem =3D NULL;
> =20
>  	if (of_machine_is_compatible("fsl,imx8dxl") ||
> +	    of_machine_is_compatible("fsl,imx91") ||
>  	    of_machine_is_compatible("fsl,imx93")) {
>  		dwmac->clk_mem =3D devm_clk_get(dev, "mem");
>  		if (IS_ERR(dwmac->clk_mem)) {
> @@ -310,6 +311,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struc=
t device *dev)
>  	}
> =20
>  	if (of_machine_is_compatible("fsl,imx8mp") ||
> +	    of_machine_is_compatible("fsl,imx91") ||
>  	    of_machine_is_compatible("fsl,imx93")) {
>  		/* Binding doc describes the propety:
>  		 * is required by i.MX8MP, i.MX93.
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



