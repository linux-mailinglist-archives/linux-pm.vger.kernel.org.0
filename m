Return-Path: <linux-pm+bounces-18735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A09E7F0B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 09:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13E918818F3
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1671369BC;
	Sat,  7 Dec 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mZ4VkOmU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAB76034
	for <linux-pm@vger.kernel.org>; Sat,  7 Dec 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560666; cv=none; b=BsNcJxIh/4JS0Kg9ZARN9WGvz7M8BRltapw1Y1Zrhz9ifWZSMJFZvzwy04IjrxIPuIIzzKM4Mmh6BfGe8iG8bCz6P1bHP8toNN+g8jjcqRpYrcndyQh9XKMbZ+FjaNDH7p6pzFtc1A+uFtylopXftAf8RIzWR5zepZKqv3DkOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560666; c=relaxed/simple;
	bh=/D1e2w5YRxeqPPDidhNdNYaoxsQuK3x9X1wBvFHJMcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPe0qqTnhN1ZndVAzUhat8+8TrMv2CiBD/4L0zonUcU+n2aV3Pb3EN9wBcrKVSKjG2hI8CLhDMGdvTMkZm0rpVqg8rf3B5ZgWwb6ZkDPjSpbDDTjFzzlY6VXj7SkhtfVX9yz6gRNri4EPDP2swlIHIXkz6XfWV9XwSGbAMAEpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mZ4VkOmU; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aa55da18f89so381158866b.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Dec 2024 00:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733560660; x=1734165460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIXXcor5BT4H9ajmkBhx7ZtMU3/w+Af84RJxwBSl1LM=;
        b=mZ4VkOmUXEDojIMoubacb1FBCUdoqr3Jg7Z4tA1QikOCeHe52doKMPINGk/MpR9Tl7
         COnhVww327xrmfKgP1VXU2XyTG+hQW2+gZMLSFArWsLW2NBEF4IjI1qZeOSg8Jcf2fqt
         Elw5uDvz63nkFdsMySbWPp4edWZdhJbrA0TrW7fC+WccQ346tstrDeH76YAgPOF978XK
         BQV6/GzWRGTNOYBQezCtcHboKMWX/j4hWr3xln4Yi0jBk18Lc2MHlUm2oMFvdGeXmeLh
         Qt+2rTGQmJRVDGsFurCIl+4mMaGhv2MJk82j085jlrY0HHOBIcXEDkQq6Z1GA1hlf/o3
         alow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733560660; x=1734165460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIXXcor5BT4H9ajmkBhx7ZtMU3/w+Af84RJxwBSl1LM=;
        b=v8FV+Q2TMKOWb82XH8LOi5sdJvRefKO8CggkYXJX3of8wKmstbARc15KPwcl+4rAv9
         VdUApR/BJnZdI5lC+3yWzLI8IYL6++TG7d5LJ9uzp1DPXQbsZywiwk4NY6F7qiYDzBpV
         ISavI84X86FSJyaYKsxZlX/gh5e3W5kxgC36BaeGHffUO59HTrRrVlSXKMrnEiDzyMh/
         7XWnHiZ+1iQwyWdadfQsqwA5EuM5MSWzh+aLEkPLi20XHsdsVo5hZe2imzMvVsnimtu5
         8BBNmkppL+eOBrPgSzFQxZPcRay9P+6tu+jGbiVriuL6ZflF0Sxvop1UrmLEWk9B302j
         q+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZN+XX9ZqeddyAqaa4yQO1Pkb0vf3f8W5a6xj+NHfKXRub/KP3wQF9Hxgl7bIEIFGxaltHBxojw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr0/XmcrZNjxhL+gi8gyptJqAURVmqauZMMMPnLU63IiVEjDYu
	ljtfX3jxcQYwVLxxjOQwW9da1O8DlU0pCC1tpMeedSxuE4VRZuiq3ghB7/ak4RY=
X-Gm-Gg: ASbGncvII6bkLTNNHJ1oIcRw/N7v5GCUDfLeoqAnnGB6h69xSmTucyUC2icQd8Y8wcy
	tNRgPJi/ovqfxkdEGgvIHqTsTp317eOSdfsk5XMLRXAp6TzcY3/E5ZkGzIFJ3SNzb769f0x+FPc
	SdtSSDjbwCD0e0AgygX3+V9yhCwO0JU35E+fq7ynT5PIyGAtc3lyKRkHYYx2XOu9AQbrbfEbGzf
	wtd48RObHCqpzm1yz2R4HxoWblm5BDxSTXeAiKVi8p217vApERR2lY=
X-Google-Smtp-Source: AGHT+IEgwPnM9sPqFkWQqo05LsRPXpGvYSumqiwGGHjQd1CCHO5rDBZBKvG5CxqJf9nYGUPeZ8qaFg==
X-Received: by 2002:a17:907:9507:b0:aa6:38e9:9d03 with SMTP id a640c23a62f3a-aa63a09a422mr347657166b.30.1733560659823;
        Sat, 07 Dec 2024 00:37:39 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:e614:87a3:d4c7:31de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58da5sm358595366b.28.2024.12.07.00.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 00:37:39 -0800 (PST)
Date: Sat, 7 Dec 2024 09:37:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org, 
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [chanwoo:devfreq-next 4/4]
 drivers/devfreq/sun8i-a33-mbus.c:384:47: error: passing argument 1 of
 'devm_clk_rate_exclusive_get' from incompatible pointer type
Message-ID: <faqkdyfv4wstpsc6miyfwq73nyj7tke4epses4msjewrh26her@vpovriyfjtcv>
References: <202412070231.MzXdNrLv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jcsufy4xftaiyta6"
Content-Disposition: inline
In-Reply-To: <202412070231.MzXdNrLv-lkp@intel.com>


--jcsufy4xftaiyta6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [chanwoo:devfreq-next 4/4]
 drivers/devfreq/sun8i-a33-mbus.c:384:47: error: passing argument 1 of
 'devm_clk_rate_exclusive_get' from incompatible pointer type
MIME-Version: 1.0

Hello,

On Sat, Dec 07, 2024 at 02:37:41AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git=
 devfreq-next
> head:   27d1a5d95c5202f927f1155ad8f919778cd9f155
> commit: 27d1a5d95c5202f927f1155ad8f919778cd9f155 [4/4] PM / devfreq: sun8=
i-a33-mbus: Simplify by using more devm functions
> config: arm64-randconfig-002-20241206 (https://download.01.org/0day-ci/ar=
chive/20241207/202412070231.MzXdNrLv-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241207/202412070231.MzXdNrLv-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412070231.MzXdNrLv-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/devfreq/sun8i-a33-mbus.c: In function 'sun8i_a33_mbus_probe':
> >> drivers/devfreq/sun8i-a33-mbus.c:384:47: error: passing argument 1 of =
'devm_clk_rate_exclusive_get' from incompatible pointer type [-Wincompatibl=
e-pointer-types]
>      384 |         ret =3D devm_clk_rate_exclusive_get(priv->clk_mbus);
>          |                                           ~~~~^~~~~~~~~~
>          |                                               |
>          |                                               struct clk *
>    In file included from drivers/devfreq/sun8i-a33-mbus.c:6:
>    include/linux/clk.h:214:48: note: expected 'struct device *' but argum=
ent is of type 'struct clk *'
>      214 | int devm_clk_rate_exclusive_get(struct device *dev, struct clk=
 *clk);
>          |                                 ~~~~~~~~~~~~~~~^~~

Huh, back then something with my build testing must have been broken.
The right thing is to squash the following into said commit:

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-m=
bus.c
index fae0793182a7..52e146fe389d 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -381,7 +381,7 @@ static int sun8i_a33_mbus_probe(struct platform_device =
*pdev)
 		return dev_err_probe(dev, ret, "failed to lock dram clock rate\n");
=20
 	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
-	ret =3D devm_clk_rate_exclusive_get(priv->clk_mbus);
+	ret =3D devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to lock mbus clock rate\n");
=20

If you don't want to rewrite history, tell me, then I create a proper
patch.

Thanks and sorry,
Uwe

--jcsufy4xftaiyta6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdUCTIACgkQj4D7WH0S
/k6pTQf/ZNMr6G1osHstlEbW5AvZB/ypQH/I2voXnpFoICddPGYkbSrt64h5uOnO
iya7M5O00BnB6FG3pq4GrfnX/NQ2n/7kks21ZyWYXyA65GdFcG3BcQ0lscU2LQSv
mUQY/7tYSPCEZ+Fz3RITUMmRoaOMR9tf2pO01bWYt93Wrd0zfMsTfA78PRgwufAS
doU1PYPCYGYcULbaNgokBGEagif6M65PBvCql1waxKD4S3k2Fqtu48T9KfB6cah+
fpfaeE/zwMF/z/ujVq8S6Vu7oMVEseejuv5KFgFMCOpSFOuScK4bf89/eK3U750L
BySiEwk68SfroBEuSS9Ac6dhIMxLyg==
=y/74
-----END PGP SIGNATURE-----

--jcsufy4xftaiyta6--

