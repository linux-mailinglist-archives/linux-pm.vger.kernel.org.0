Return-Path: <linux-pm+bounces-13176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E496492E
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3036B26254
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38331B14FA;
	Thu, 29 Aug 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnTWMlW4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02371B1414;
	Thu, 29 Aug 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943272; cv=none; b=m/Dwjho3kFF4ghxXPcjWKtMBjOjTP3H5bOS85dnspeTwsDu4bVFHEecIb+JOBKygowWQ5G0qiv4xEEMVZMING9S0BTCml/Bv44U7LrbR3kkJimLW7Cb6btZ7wEZKp+aiWEz4PKuy6jcmI+OrnrU9QfoED5aDamIXlU84Dy6FZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943272; c=relaxed/simple;
	bh=FaCb4F5WVY3FLk9+Oak4LuOKMiyfZkaWU3vPnoYA7B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs1fJ4r51r7zVDQNbSXwxQps+FDxts05x20qyjzY37CK5nMtpOaWZAYPnuS/qx9dBhH82NrQVOH+DNg6dgPfpWxZfdWmdoQbY0q/vtSI4bGemvSsbsnDfjyc190pnNQfsZBIG7lI0WGy1VQ59gT71PUX8cqTSLrKjoc2bh1xaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnTWMlW4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso8777335e9.2;
        Thu, 29 Aug 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724943269; x=1725548069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RvHnm+3SHXcwDriTXTVCIgrco9MOYfTgil1a/kVBbU=;
        b=EnTWMlW4MSyRt4mtksANrZQLFvUr0Z10NU555/cmaGa5zjcQTKW54swUhSHhArOKza
         m70KH/aN+8vnQXD23L3rHynoRqmNmL8ZUnzOCFvjh6uwNzdBhmMpf4ts0X6+FtYceFT7
         DqJmzcWaOq6JU4X880CVqc7YKQ9qd/Ffep5GirM/PBGfyPbW6Ju8nkx/zoj6iZRGWF5E
         oZLm4dZrKkWowapSVqwQacN9FPSuhE21lZUdS8AdWH2TIH+5lHuTEpI/LU+6m4s5ZtSx
         DXJeLpC8ekIy5oSMXEGsjo8n0iTPAzM7F6J3OhaimbH13XHyCgG5mM0dh1WhaNPO4jOA
         uFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943269; x=1725548069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RvHnm+3SHXcwDriTXTVCIgrco9MOYfTgil1a/kVBbU=;
        b=dCgLPGKdDBnnWaOi3nA8sdVwhEUe/NvVXq0L02ViFaOm9vB/OVknLc68WkBfBfbmrV
         OIvxvyF4WCDzpmglLCCrD1bMxWW4uASQsVu847A3yxW2n2MzExv4dRF2GhRh4IhSANRo
         D6b6kUfFoIVTc40veEh9urwZTW20fWRTiq+CIFb/KJm56s6b+hbcM6e3XMBHHTqfIDsI
         pxrCt+WCb2QKZIo/XW4NL1Dxs7w/NY/NPvrcv5O4L8dbpc9MZauT/R6Thd3QUE8mYCh6
         bKSky3pTWSDp46sCC9mznoKyRmY4nyAxCjOfA+bmIC1wgBaW4uB7IanH7Ofa29yhdzhu
         MYjA==
X-Forwarded-Encrypted: i=1; AJvYcCUbadY7WHFjVyMKPxL5Iy1WNrhBzczhvGnJ201MOVDK65/C2kizjOlW2obKbFqXspv4I0xsQtujIk6LjrY=@vger.kernel.org, AJvYcCXx6YtH3e7QdGLt2s9cCMMcAymiZR7ctJFdKf8+DWO6WT/ntrD34e8slMESqy5o9JLXv0xptQc51A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtzVPDhNOBw8bIG9veFUM429trJ6ulRBTICwAbLqEwnLfG2Cp
	lSVmLPGMSYfn3YYyIGGakzsN8bH8fDqk4HKBoq6L/A2wGFNFudbx
X-Google-Smtp-Source: AGHT+IEPLCpekV/0oFK0K++9ZKbbV8Mvl/fcHb+h9oB2OFRyYNoSj2kCBKYooopQ1WUrfkSCee3Qng==
X-Received: by 2002:a05:600c:45c4:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-42bb01ae2d7mr31296905e9.1.1724943268412;
        Thu, 29 Aug 2024 07:54:28 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639d440sm54374335e9.13.2024.08.29.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:54:28 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:54:26 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: digetx@gmail.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, 
	cw00.choi@samsung.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH -next] PM / devfreq: tegra30: Add missing
 clk_disable_unprepare in devm_tegra_devfreq_init_hw
Message-ID: <5vuj7r3wxiqa2nr46tdafe3zf4ru56ja2dz742lt6yfmv7ft5d@26rhlgfleqsx>
References: <20240803063748.325133-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sut5e6g7ajzxwlz6"
Content-Disposition: inline
In-Reply-To: <20240803063748.325133-1-cuigaosheng1@huawei.com>


--sut5e6g7ajzxwlz6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 02:37:48PM GMT, Gaosheng Cui wrote:
> Add the missing clk_disable_unprepare() before return in
> devm_tegra_devfreq_init_hw().
>=20
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--sut5e6g7ajzxwlz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbQi54ACgkQ3SOs138+
s6HkfBAAogvpzmkjnZheaoSrMYwuM/l5MZpdrAdKsbdQyoVwHG4N/krzIcJXCi/O
tq6dyJ1gTUZlo9x6mczat4X3jFKIJYhq5hfVxCqeNetoVaszJl1i46+F8vH6mmsg
x6L/ioDI1OIu9zLMP/vyROfKm8c2NzwLi+mv8zPG+K0U2tn/SNR49NW/ETxNvKvy
GFASUtY5wO1rDXtdXH6By73+b4F4LznPOZ6W6pjvPRm2wnATzqiyxXdofl0CrLAS
M72eftABhlncMCk6dyGUZ1RAUeOpVFI2Zlu5FLv3suf0Dpm0uS1sHM1GIy4qebs1
Nkwr1koMe9LXEgB/JtdviCdrJPz/8IM0fQc4qCDAhViFWwyUCS2LhtFtzQAf2LWT
dhfre6HZXLwruwVjnD4hsGuDpRHzOJcI/GCr835cqtsBCqXaihSZlAemAUI04uel
Wafj6zublJq6UstqaE2OtW7qMt/9U/E2IS9n1zFnC2fmDegKfYgr20sFQ/XBioN1
rfS5cIJDcVsFIx6f7dsQbXKfVhKiXND89FDhSEwMABgbZg9pBfhh3UUDdn4B3IuU
mlXomOd85T6Ib9NW4YGEtT8u2/9yVvjUGbW/hlw/4miGYZ95WJmBzSuuRHc4SnY8
19Ehp7hLKzgAvD8r7NyTJjSrUJUX6747OYF/INV1z/s0uIl5gk0=
=GGiR
-----END PGP SIGNATURE-----

--sut5e6g7ajzxwlz6--

