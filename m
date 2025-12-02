Return-Path: <linux-pm+bounces-39046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF44C9A8F0
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263A43A600A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88223303A37;
	Tue,  2 Dec 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rvcAOdQK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx-relay09-hz2.antispameurope.com (mx-relay09-hz2.antispameurope.com [83.246.65.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD630170B
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661807; cv=pass; b=qU6R9HvhBar8vQ84lazUWo/XAXTNjp3+uYpVyc2g1MF3ykPXxVr6gI/wBPMQuiEqylyHbCEpDhwZeOgcRwz3ZOCWlwLM5gXTlO9AuBkplISlZcCyNPg1HP8QzUpHZObiyR/gXhAnraUlgIjN3DCm9DUjs1xcq+Srfw6JnwziBfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661807; c=relaxed/simple;
	bh=PxmqLwTGHCcOlhvRAYqtPMxIQXNBtYQuY9nf7xWR7F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aG6rmijsZ/SPzh6H/QOg0+wyU9ubQ/x8lCVB06I/h1j/Gzn00D7c5dE9hWXlXfuVUQwEOAbSkte5qyCtJ2xfp4ylxzN3SQBDx45W2XNEUVvuUBOLGwLbSPI/FaEgfZjzO+6+obZSFCCqAHRQvSTF8hHBD4Oq1GzuG1S6vRyjPS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rvcAOdQK; arc=pass smtp.client-ip=83.246.65.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate09-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=T7axZz2df+9J33mOBW3vXS7fIUw+GxQw5eU/LsYk4ww=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764661754;
 b=gnIktLejq49oqb1EFBHg8dWBhfe/jUlULN4gAFlg34brNNwHcu1pw74f4sgDjUZiNRVQDEBq
 zJ1+tySa/soyRnsDdADgjzP00N3M+ntSggElBtMU1EGDkAx307gBryPxc9kCFjoY/Eex4Nsa1c0
 5PxpDEKk+M8pSC7i1ECo7qH9SyNUPalhzjGANtl4M9d9urBMsbctn0jYQFmMSu5M6nB+P2pNOGn
 pUC20BF+smcpPHHHfs8mmMy757zCMmfrnIUH8oB0+enaxZpdZj1Yb7Ze8tKXOpaYa+gIgA5O4yR
 IXQWg3CoU4zkHjzCkvLEnJhTBXmaI3Cby3MbkuKbRCqrQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764661754;
 b=oZj1TtjBybeTeFWeC/XnLyneUTfovMrjj9XyTUPUY8MEcAEI4BsccNNed1V9SHFD+mGxYxi/
 yfcrjdkYzF9fQIKGBe6bTznrx2YVeSi/n9iHhhFk5FRNQprsJaLsLwCpd0IrPLHvY55LxGRalD8
 Wq6YNTRtsGzCXL3Jjj92PQtAaIBBEBO2QM9NyFEYpYI1vceI+94k0EpY33YP2tQuGADdXKQ306b
 cbeFA4bZVBePNY9obq6QT/5hKSI9yI1YBSE2x8oux1DrpxUrVAgDHqurBl0Kh+18atwYs6p+Zdn
 gK0JW7JHQJx3OosZR+S/nxXU2/G2xajlmr0BDvPJohsrA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay09-hz2.antispameurope.com;
 Tue, 02 Dec 2025 08:49:14 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 0FBFA220D91;
	Tue,  2 Dec 2025 08:49:02 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Felsch <m.felsch@pengutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>
Subject:
 Re: [PATCH 3/3] pmdomain: imx93-blk-ctrl: add support for optional subnodes
Date: Tue, 02 Dec 2025 08:49:01 +0100
Message-ID: <5948751.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <20251201-v6-18-topic-imx93-blkctrl-v1-3-b57a72e60105@pengutronix.de>
References:
 <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
 <20251201-v6-18-topic-imx93-blkctrl-v1-3-b57a72e60105@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6220726.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-pm@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay09-hz2.antispameurope.com with 4dLCZk50ntz20pyl
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:60d645e73f706042f63d5b5154e78e90
X-cloud-security:scantime:1.971
DKIM-Signature: a=rsa-sha256;
 bh=T7axZz2df+9J33mOBW3vXS7fIUw+GxQw5eU/LsYk4ww=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764661753; v=1;
 b=rvcAOdQKFgBsXVT936cZTLEDfmHbzPUpp/5Mx474E1o31bymglJRmiGZWN1WEeIcPy2sCwnV
 B2G/5wDG2eFCKlx1FFhgHs0nsMzxnSD+64rMO+MNr7n8B6Rcwwlw97HF96dctV6B22K62jHHePe
 zmOupkdYklp0tO1614KrNQG/99dkwUNyPz9icV5s9pT2jBcGWHup7MMxjqZBX3lKuO3YTywAVnU
 qF14Oog3sb84cD0M6/ihw8w4HE2DLzKm94pHjKK65p33ejyheEp5TBxzgvrpMblsMr/oKal29eg
 Oi74uvoBV9zFnEfzep2xxE5+G7iZRZjGjQ3P6/nUaXSEQ==

--nextPart6220726.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Tue, 02 Dec 2025 08:49:01 +0100
Message-ID: <5948751.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
MIME-Version: 1.0

Am Montag, 1. Dezember 2025, 18:12:07 CET schrieb Marco Felsch:
> This particular block can have DT subnodes describing the LVDS LDB, MIPI
> DSI and parallel DPI bridge.
>=20
> Scan for possible sub-devices within the driver, instead of misusing the
> simple-bus to perform the scan.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx=
/imx93-blk-ctrl.c
> index 13b0de6dd689cf944e034f7666a4e97b0118e3bd..8f79cabe07face872cb396bfb=
7329c230c4a97fe 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -311,6 +312,10 @@ static int imx93_blk_ctrl_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to add genpd_provider release c=
allback\n");
> =20
> +	ret =3D devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to populate blk-ctrl sub-device=
s\n");
> +
>  	return 0;
>  }
> =20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/
--nextPart6220726.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEByESxqszIvkmWRwbaS+g2M0Z/iUFAmkume0ACgkQaS+g2M0Z
/iX2lggAjXJx/4qelXC+7BDMe922feOOwInko8Lie9ONTE7qj6W7OFZpk+lw3FzN
uckuThVlH8J/DFn1iGpYrVg3QnZAdh5wsgibfcZm67i894UiianaQOlqgtRpA7Oq
E+Kb9+gVB3vr5Nj9eaghmTFfXHFrVvDAsi7SIhq7oXJLO288+LbacOL5SzJVV/Gt
HvcoZwTu+eudlm0Dlu2/99zRaxHhQqpzSko46NY6Zn+UsR+0kx7FsqgQEwOo/Hg9
h4Uvf6VYLdFs/CYu9L5W1o9Ovov/axFFFkDW67miip5KQO9WpcYppaWSHJ9QxqSL
LS/86Nft9wctDFklkTJPdEYpWZc7xA==
=DoZw
-----END PGP SIGNATURE-----

--nextPart6220726.lOV4Wx5bFT--




