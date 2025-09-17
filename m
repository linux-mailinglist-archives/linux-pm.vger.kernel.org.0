Return-Path: <linux-pm+bounces-34924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568AB82238
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 00:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA26D1C80D31
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07830304BB9;
	Wed, 17 Sep 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ZZhhSZtG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71FA55;
	Wed, 17 Sep 2025 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147526; cv=pass; b=NTcfRJmGbziD15OIgYq32MKi2rv7u9wXeQ9rG0fb4ZEUIPW01LAhWM5lfFkeADEhlWVrBvSfUqeKJT5UqxsQ2zu0hpvcx25bg+NFKewMkEd8Co3FgHClCaMjP61BlMNafJ5muyPuQAywY6/0cn6UDcHAp1yOWSjLuFxdAJBI/yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147526; c=relaxed/simple;
	bh=SmRT7XrOnFZUcQSEEWJW9mAal75IRBUO1H/bYI3eI6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By5fe57cgPfvBhxLyIaNTXwDg8LMoGfSBtn8pG3FjY+iVCxE7UUIK0V03TSyC/GiiAK3r2PqKPri3oIPeejLfeOLmobbYUaGceitg8xz9fieIKQUM+CO4lQtqHvNOo0TVy+SdrN9v07VxDndx0P4Hp0v4cjllIsjfM3yj8ClaSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ZZhhSZtG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758147502; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nBE0qAD96oeV19lQZr8E0NjaLxoWvB0jgBlajshoa/O5cKG/7nCHvmpr+1eNMJzoveQ1BYXhnOMrW73lxY/G4r05nzoOvGnDWKJ84jiFmdI1F5ulao5lk5ju9Q+WSEZjU2Uf9v9BEoeFs6MwJVjr9lXDCBifwGlGCfX2Nx+EZBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758147502; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SmRT7XrOnFZUcQSEEWJW9mAal75IRBUO1H/bYI3eI6c=; 
	b=NzVDIFHvdLSXB2uWjgClO8n7uCGKBWxMYNkRzHet++HlSp3NZX2R+Lxk+dkOhmFcBmLGMxVvwr+dV6PDFsk1d7P/3hkhqBbpUMVw6/F7X1/tCSHw8sMBrjcs22opQhuNNvHSbMBAJeHpXPsq5SoM0BlIpe6ibHminnhftacXorc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758147502;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=SmRT7XrOnFZUcQSEEWJW9mAal75IRBUO1H/bYI3eI6c=;
	b=ZZhhSZtGafjSiuoJZoLSdScrJOKz28apFezuJMJK4TgwKEZ5HJkX5Dc8QWx9d1im
	3JnT0E+2RU1c2fcqcTk9fFE+vR+VuaFXb7n8rf65Xjf07D35zTLYK7BcnqRK6TlFxsG
	ayw7W3iN9nw/L8Q5jLXr1n8Wbr9nhNvW5lx4qXQo=
Received: by mx.zohomail.com with SMTPS id 1758147499547326.778506325556;
	Wed, 17 Sep 2025 15:18:19 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id D120F18067C; Thu, 18 Sep 2025 00:18:15 +0200 (CEST)
Date: Thu, 18 Sep 2025 00:18:15 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Drew Fustini <fustini@kernel.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] driver: reset: th1520-aon: add driver for
 poweroff/reboot via AON FW
Message-ID: <7ru5tunm3vlmtuulkbc7kpunyim3ks3he4ielc77ivm7vxieqk@iw6xmwmsn3lk>
References: <20250818074906.2907277-1-uwu@icenowy.me>
 <20250818074906.2907277-2-uwu@icenowy.me>
 <i6slr5csro54ys5g7diqyacq4deidwm6f2nhpm2uwmgjlu6tyn@otrbpij4vdya>
 <aMm6UIMTFOH0Z3Ug@x1>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w6tltlbzi43cl2ip"
Content-Disposition: inline
In-Reply-To: <aMm6UIMTFOH0Z3Ug@x1>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.96.42
X-ZohoMailClient: External
X-ZohoMail-Owner: <7ru5tunm3vlmtuulkbc7kpunyim3ks3he4ielc77ivm7vxieqk@iw6xmwmsn3lk>+zmo_0_sebastian.reichel@collabora.com


--w6tltlbzi43cl2ip
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] driver: reset: th1520-aon: add driver for
 poweroff/reboot via AON FW
MIME-Version: 1.0

Hi,

On Tue, Sep 16, 2025 at 12:28:16PM -0700, Drew Fustini wrote:
> On Tue, Sep 16, 2025 at 08:22:02PM +0200, Sebastian Reichel wrote:
> > On Mon, Aug 18, 2025 at 03:49:05PM +0800, Icenowy Zheng wrote:
> > > This driver implements poweroff/reboot support for T-Head TH1520 SoCs
> > > running the AON firmware by sending a message to the AON firmware's W=
DG
> > > part.
> > >=20
> > > This is a auxiliary device driver, and expects the AON channel to be
> > > passed via the platform_data of the auxiliary device.
> > >=20
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> >=20
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >=20
> > Greetings,
> >=20
> > -- Sebastian
>=20
> Thanks for looking at this patch.
>=20
> What tree do you think it should go through?

I'm fine with Uffe taking this together with the second patch or I
can take it and provide an immutable branch once the second patch is
ready.

Greetings,

-- Sebastian

--w6tltlbzi43cl2ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjLM6cACgkQ2O7X88g7
+poEjg/8CGap9CHM025XqzM6ldM8EKrDBwYRnSNsZPCtSkh4HGSAeUnsGbGG1qjw
fW+0ntyctMO9qOE0xrHzc1KtvZnWiHgGeHwOs0MLMwGME1+TQ+qYe/dF/ED47Pcc
4jsoTqjih39dmXMfA8xKBRO/cosIntrqGHGcNdEVyl1LFc8p3pNztPnYrSQiNYSL
7iXgOZqMYGdSw3eEAtg9nEreog9CZkmbmEn4dj+KBdwir0x47WN05FmJlWlgX2mc
5tul9fjvdK3oxVVT8FrmZ066hn8rpPH8+vdBxbWc43A/kJcF4rNIqf7rC2wrAHcL
bNHmUN7Nc8dMkmjm+v2ozG7uIBSLvuLoighxWvVEAPDTe3FTaVh2BSfEr1mmrTrY
uoIVF4TjEZGaMlwVUVUWhmPvKx0X9jsfO6z/YFqtQmwtLdJlnsydZAHQUNg0LG1W
U+WkH5w1NI/xw3GR3TtiJeiUIaxRkUl9N8bhebabtbEWLihEpnPWxscaAJe/+Lmr
OlcplQWPmKlkuioAzkdehZgKM4hquEblLuGtn/fNdOmFVwQY/T9/mhAFFAj2MPld
qit6UU9AsyRZgpRkTfqkygKjQVb9rnDHnKEI4DPb/BfSTcjZUPIlv51y+/El61tr
rxDw1ttlRlMmXArjnemcExbOhOeiftumhhoPlLln3A+Vj2d2j8A=
=LvX1
-----END PGP SIGNATURE-----

--w6tltlbzi43cl2ip--

