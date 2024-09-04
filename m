Return-Path: <linux-pm+bounces-13558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27E96BB3A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483D9281740
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BFD1D0DD2;
	Wed,  4 Sep 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QhU2CU5O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="RW47dMR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD91D04B3;
	Wed,  4 Sep 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450547; cv=none; b=hZBJcbE2Fus9PRldhH+itVZlBaB99EyOdxzoRMiJBY/kc/bwL7Am+q5Z3JtwjH0J81FRI02JB8phiDz55NqdzRF7VYMq5OhUdD4Vsig3XoD3zlF3nJVbA6IEcM1uTnSXZRWHcPytU4/BCEGUBQmOi3uPdfLfIi/liB6/1OtNWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450547; c=relaxed/simple;
	bh=2gOlhhRV2C/00MxCV/AqhWoEpYeVgT9ATkmcgljMQMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2kuvYEGrYsOkWpHkvtYsJhgirWWtyTCNGUy12DFMx+TMOYlrEdi+osaTLZ2mHywgFEdyL/01CvyN9b1BlTZm5puBhpHcQPmvlSlNo7wKKfsu8GmZZSz6nEY1l4XN/yDgnH/Zh4icCWH2EKI7c+q5mDGljZjVmJB9fx00ZoC+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QhU2CU5O; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=RW47dMR4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725450544; x=1756986544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzRpGWmOUix4GzvJgR42aKUg/d33bVXixR5pEp0iclU=;
  b=QhU2CU5OtGuQN2c7kb3WXmDF2xY/Ea+D5MTozwqAlvXBKXzfQGNrdQCG
   NEn6nFYtpWk7BQLU8oPrdNxVuX+z3G3rwarHeEQyEeBjmQYyAX4IjJoNi
   +t286k7i+vuhsTGJbju+2mHhFg8Lj/7/3PwBqzGpsQ0v+VQWOIfOof4dS
   qp5mBC39aVbgvyynHIK9zbtRC/xd/aQAM3OGkEoRibfLbAvkjy+2T3xy0
   bBiu/qebM10wHr0MWyyZ8NtWxqDakiRMwUNQLDZjYzjH8ZTHlWeC4fDeN
   Y4O94VNhb+fya78pTUq27Cs00iWY4Y5dy+B5IM4ZzZ0IvS0CUkBHNxMkQ
   Q==;
X-CSE-ConnectionGUID: 9/WIsxHeSR2jvPm7H/3/kg==
X-CSE-MsgGUID: sap4pEGZRByHLhM8G9AR7g==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38761957"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 13:49:01 +0200
X-CheckPoint: {66D8492D-2E-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: FAD731A5A9D3F1B35E470B14FF3F3207_0
X-Control-Analysis: str=0001.0A782F24.66D8492D.0165,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEE15168F91;
	Wed,  4 Sep 2024 13:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725450537;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PzRpGWmOUix4GzvJgR42aKUg/d33bVXixR5pEp0iclU=;
	b=RW47dMR4CCCZ6YbXSUgNtokRaSoNQb0UAB6xzuEfd3TxrUPNps1B3PI+dbYayXq2QwRRtZ
	32roHomfmXWZcoKFDZ0Dh06NvEEdbCMaDIyEMrMPfamxMRQ40I3aDbZFLBWktgP2jE1Jqo
	QrE3u+AgGmXZi+atF+wisomNM9mgCOYBtU9WaaRtwse75qkHni+WkTyABW8SOQi2Ve7JqD
	8iQTkUW+1COaBFyTnlpFxthng6s7mngHuGlrLHctW338i8jp7vYNViPHJ6uTfn/6EREZ+X
	iHeUtCKunTlMyOVC7Mi0DOLeu60AwPZuSnvU8wxeIdtLgAQIBU38A7+KGxLBew==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: Use dev_err_probe
Date: Wed, 04 Sep 2024 13:48:55 +0200
Message-ID: <8423953.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240717085517.3333385-1-alexander.stein@ew.tq-group.com>
References: <20240717085517.3333385-1-alexander.stein@ew.tq-group.com>
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

Am Mittwoch, 17. Juli 2024, 10:55:16 CEST schrieb Alexander Stein:
> This adds the error code to the error message and also stores that
> message in case of probe deferral.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/thermal/imx_sc_thermal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_th=
ermal.c
> index 7224f8d21db97..88558ce588807 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -111,8 +111,7 @@ static int imx_sc_thermal_probe(struct platform_devic=
e *pdev)
>  			if (ret =3D=3D -ENODEV)
>  				continue;
> =20
> -			dev_err(&pdev->dev, "failed to register thermal zone\n");
> -			return ret;
> +			return dev_err_probe(&pdev->dev, ret, "failed to register thermal zon=
e\n");
>  		}
> =20
>  		devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd);
>=20

Ping! Any feedback?

Thanks,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



