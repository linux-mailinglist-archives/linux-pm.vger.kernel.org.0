Return-Path: <linux-pm+bounces-35443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C93BA2995
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B68188C6F8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BDE284695;
	Fri, 26 Sep 2025 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="BLg6SYgb"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81D27AC37;
	Fri, 26 Sep 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758870016; cv=pass; b=LWPOjqmqqGcfWdnXDiR935G3kwO+sR7V9rxRVOJAOenqN+mfRxqATjXqmmsv1Mdt+UbeYTX1Gz1m5DdLKCmY7w9InkjHO1BQ/zHtdlCf6Vzgkn4MNyIUYQoe253ENfxIw0Z/haC10H3oNr+isuurJPkyf5va0nWGjrUkJA4EIp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758870016; c=relaxed/simple;
	bh=0d9+QhwLUeUPH+Ao+04JvPakxKcbgowNGfFk3Ill9Lc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bEN1revlz98PbQYdWqqMHUzLgcXYweeVkgka82L+L07fn+arFMxTph8u7kFNVkftjZ+CM5dpBpBCJtm+ohlaotz3EJE3quolQLm3i6HgTyN7oL03DocOO4SjlB/hFTvJRMTpVP6CTOJAZOir8zcZerVfzKjZ95P5jemHNRm5YOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=BLg6SYgb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758869995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QkTOcOfFY4baMchg3LR2JuebeFgUlm+dPMtjYbMgxme/rr0cyHoIpKLTedhQ3bZJ41v65Fzlo1Y1lPvVfNJAMPDWE8rHyj5AoRwoqEnSijU/2duMHGODkLNsHAr4EqpTwjpFJOozY0Pcetc7DHw5ZWRITAS1WJxZ9MUo6Fn1oH0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758869995; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0d9+QhwLUeUPH+Ao+04JvPakxKcbgowNGfFk3Ill9Lc=; 
	b=Skie3Y2qByPr0+fZ3z+bHHr3qmnDzvCmLMaTyVV4Mlbuk0IYBU8fRslxmqjAgXB3u7EnPV0thbnkePfJqQuf2L+WejXXX2k8x0Co10Hhiyg03UOjZwunMTibAfV2ICnNYmIMx0iZ0a2qEnK0be8Sbd7Nx6/nJ1HPAjUZ79Zkqs0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758869995;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=0d9+QhwLUeUPH+Ao+04JvPakxKcbgowNGfFk3Ill9Lc=;
	b=BLg6SYgbtAdkYngvl718gBszCAox2SMv7/VsoRaT0FLf0L6hiITao+dr/T2W+7A4
	67Tr3cRdlBcBsMbPha6ZACAGjEh4+0RCXKguBazNW1LBWtaRsXtA0X2QiRGdJhVqz3G
	PMrZvp2q2PDNLHU9nBYJenPEE0Jmu1u3Ulus3kPpoiPKnRl58CLbUw0FnKotDW8jQYX
	gHkE9+FSzClOi77oPNpwrDsHifFWhkdBGiPZhJJvROO3bh3Vc7fw5K1C2Ncuthchyxf
	E0R24scAB2b5AFp54iSCKWXZ0H6K9va4RW1cFvkEPJNkut08cYRfJxR6wNXgrNz50cX
	ylYzzgIETA==
Received: by mx.zohomail.com with SMTPS id 17588699937861009.4088550034123;
	Thu, 25 Sep 2025 23:59:53 -0700 (PDT)
Message-ID: <6ded068f5c004f8735dca378502b91ccdf56bc21.camel@icenowy.me>
Subject: Re: [PATCH next] pmdomain: thead: Fix error pointer vs NULL bug in
 th1520_pd_reboot_init()
From: Icenowy Zheng <uwu@icenowy.me>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
	 <wefu@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Fri, 26 Sep 2025 14:59:48 +0800
In-Reply-To: <aNYQkVuVpP3Daq7x@stanley.mountain>
References: <aNYQkVuVpP3Daq7x@stanley.mountain>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-09-26=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 07:03 +0300=EF=BC=
=8CDan Carpenter=E5=86=99=E9=81=93=EF=BC=9A
> The devm_auxiliary_device_create() returns NULL on error.=C2=A0 It never
> returns error pointers.=C2=A0 Using PTR_ERR_OR_ZERO() here means the

Checked the implementation of auxiliary devices, and this is true.

So

```
Acked-by: Icenowy Zheng <uwu@icenowy.me>
```

> function
> always returns success.=C2=A0 Replace the PTR_ERR_OR_ZERO() call check
> with
> a NULL check.
>=20
> Fixes: 64581f41f4c4 ("pmdomain: thead: create auxiliary device for
> rebooting")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> =C2=A0drivers/pmdomain/thead/th1520-pm-domains.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c
> b/drivers/pmdomain/thead/th1520-pm-domains.c
> index 5213994101a5..d7cb9633c7c8 100644
> --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -179,8 +179,10 @@ static int th1520_pd_reboot_init(struct device
> *dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct auxiliary_device *=
adev;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adev =3D devm_auxiliary_d=
evice_create(dev, "reboot", aon_chan);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!adev)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -ENODEV;

> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return PTR_ERR_OR_ZERO(adev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int th1520_pd_probe(struct platform_device *pdev)


