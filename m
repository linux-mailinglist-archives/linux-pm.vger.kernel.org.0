Return-Path: <linux-pm+bounces-39045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B42C9A8ED
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC283A4973
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF1303A03;
	Tue,  2 Dec 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="S9SUL1mh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx-relay93-hz2.antispameurope.com (mx-relay93-hz2.antispameurope.com [94.100.136.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FC30277E
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661807; cv=pass; b=B4tdq1kahrTmc7NrpIddCYGYw5h3VudL3YBtHlxJw3P08nYCO/U0FtGgGcM+TgX3qV0Cu1TL9e5AffPES5EDH3nAIuqJlafYoQ4Y5+qtdbHW9eeUPWRIxhDLpc7ngWI/euU2yXghR7O5bQeTLQlYKOZ0TAvDYeJKja4jPxOx+bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661807; c=relaxed/simple;
	bh=5E8tONvGDYNXqEcU4jADlGAWcbtLghmGBN2qCeMt8X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6S8dVNRg193jLcsadvY+YM5D7L2hlGPE1JwtrEPvQ5AiogwdGiEkZdQJ5/7tHW7mNVIOOmGYFv3ZS8QEkpN0JbJeJE2j/XNQZwbwKV8SLILnGaoAMpxlus8ol2qHuXI5Y0RcXRSoPTaiwdjNbmh2Ni3jAs6U0LAa4qeAvoDi3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=S9SUL1mh; arc=pass smtp.client-ip=94.100.136.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate93-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=ZuuiLfEXz8Diy3RFrr3LRL4zmPRzauswvFKI19W6Rz8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764661748;
 b=Du1sqCc5W5NOQq0B8IjCK9tXBvlsBTA+DyQR1LshAT1yv1jY5FQOXK1bQScK+Hx9iJ5TiP/7
 UasrfDl0miJW+ZYcgyamv/h5jGjfxfs2kgH0y4lMKcoouWZ2SuYeRk0nWxf85CvFXoKQDIfbnMv
 YRPZceRb0mr45qSy60TxL+PQ3tl+m9/AB9Jru+iMQzgxgZfjOWK+IgoNxXGrwtJ6/X0FL59yRs7
 k8Tl6RvRWAhQVtRI3JIfNqDjPDZv2P8HoyZ7rrqEvyr+jZr6ppCmC3UUotnEc0VwnZxFymGMmOk
 zK0b4mCBibDA0P69VxpO+psaj1qwVyMYGWyPrBGhMCqQQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764661748;
 b=VlOPJXzcNBF3r9M+2WH4ZbtvVkBiFLkfILmg4fbRtToWuXP1Qq5KRN63T4Bfgk5l3fYNYE9M
 uXVBIoSiHCv6Bf/yaKxUUNAhZo7tRU537ABDf7aimlDRhAVSmbASPrzqVZL2SinvC38IIASoRd5
 HHpHrk5FvjRmO1xqHw0V414lLdmLEbUCy14Yeynt1KD5An4IIZZsEJkqVzzQUqvN+zVOKB/6PdR
 0Qe0Fdf4Kc8O/czRbA5OEPdEOBdHKnHCWRJ8I89788cPY+jytPVov4D2d52hIe64bXFbulYuP+b
 y3b9uPrK/xFIx4ObLEXqw4W+rXw/hvmj33/XcuLKxaJww==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay93-hz2.antispameurope.com;
 Tue, 02 Dec 2025 08:49:07 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 5F6F9CC0E91;
	Tue,  2 Dec 2025 08:48:55 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Felsch <m.felsch@pengutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 1/3] pmdomain: imx93-blk-ctrl: cleanup error path
Date: Tue, 02 Dec 2025 08:48:54 +0100
Message-ID: <2812632.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <20251201-v6-18-topic-imx93-blkctrl-v1-1-b57a72e60105@pengutronix.de>
References:
 <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
 <20251201-v6-18-topic-imx93-blkctrl-v1-1-b57a72e60105@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-pm@vger.kernel.org
X-cloud-security-body-digest:8acd2ce67e20b48317200392c5473c1b
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay93-hz2.antispameurope.com with 4dLCZc0Cw6z4Qbbv
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:49e900fe4f7bb522495f22f55c5fbd5b
X-cloud-security:scantime:2.076
DKIM-Signature: a=rsa-sha256;
 bh=ZuuiLfEXz8Diy3RFrr3LRL4zmPRzauswvFKI19W6Rz8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764661747; v=1;
 b=S9SUL1mhS59FpiTbymyg2+CI7ctRdrLNJxklbQRJg2piNVJQ0deb12UZtexaoLZPM+Gcjd+c
 ysNHZ6zg4dTTivLlB702DUuTysTMg92xMfGPMlTTpnW4UtCrnPNvNlC7x7GqNM6eenJbIy0XmOp
 7RATWxUjlOXDe7SdnQDPT0Mm/omBHaNr1eGePc50j9dkDr3w9Lk+3T9nhySwDKzyhXfSyHvGvHR
 9uThG2ofxcS2vyXWxAayxVKc0TnZR0cke+EnQrFUGopUFXbUKDY2gKCXpEdwgl2pyFltjk8rTkD
 bajj89iWis2efsj7dMXTRNLlnsEGivE7kecpeduV/ea5Q==

Am Montag, 1. Dezember 2025, 18:12:05 CET schrieb Marco Felsch:
> Call dev_err_probe() directly during return to make the code more
> compact.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx=
/imx93-blk-ctrl.c
> index e094fe5a42bf646c712f3eca4e66a313fa5a914c..2aa163aef8de4ee901b9cde76=
ce2aad246c8c08a 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -240,10 +240,8 @@ static int imx93_blk_ctrl_probe(struct platform_devi=
ce *pdev)
>  	bc->num_clks =3D bc_data->num_clks;
> =20
>  	ret =3D devm_clk_bulk_get(dev, bc->num_clks, bc->clks);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "failed to get bus clock\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get bus clock\n");
> =20
>  	for (i =3D 0; i < bc_data->num_domains; i++) {
>  		const struct imx93_blk_ctrl_domain_data *data =3D &bc_data->domains[i];
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



