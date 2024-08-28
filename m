Return-Path: <linux-pm+bounces-13042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA4962B24
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2B1F25937
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7E1A0B04;
	Wed, 28 Aug 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgTUfgrm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8A1DFCF;
	Wed, 28 Aug 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857601; cv=none; b=fsTYTUFwU3mtq8Fha0HrVuQKOcUZTWb2SGFfcA7pDbD6FscqZxIkSGU5ST+ayhkqr3xqNYgt6Mq7OVMVYeIS4/8AbnrZ/maD7yUEXeLN+lpfZHffACtNCCl08C21WOK8Gh/NJK9R0w56iU9XaWPXc4gJNgXh/TbJCkT44hKljOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857601; c=relaxed/simple;
	bh=FNakJuO9x11e+rM2RyFP653AqTP4do8fqN0Y0orFg1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqzuKy7+wLM6S8LxSyXK6ExZExK35pbU8jVkcj2XZSAP0zherPuSbYqEpeQqMr+d1LdanrfPAGzb8cKgkn9cwiTKU9tVR9F7d3MuRPgKfLsRyBzJAeNfX9iEsTA4U9A8M5B9RgnAWbgZPmV7p+7ASP893jZ1bVPMVBe/A1fhGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgTUfgrm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e3129851so62050185e9.3;
        Wed, 28 Aug 2024 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724857598; x=1725462398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xsp/dr2A8RVuOSv7+bZ/A8ygfp3xRZkvD/aPe5ZNFqc=;
        b=SgTUfgrmvdoHM8dmwfsEbhCzeMU9roiPVlYV2rltyzSRh4sYa3ouXW8Ysoicce85Bj
         4WoCYx2+etOv/GLOOQBklg3N+1sYbT9oea8FpaV3NXsC/FUr+1VkKE5ivJpcGNsrCObv
         +mMqOoULdsoF91DvMnBh4g7WFcSOFnjUCv3133jUezPS+b7sV/pXdFjhhYUoo8kc+of6
         slj4jT+pddJGW9asVeBu2iJxqYFOHRIg1IRPiXZb9nvKB27kDnB8dei+zzgWUdB4XxBg
         G4NkSsMgjFDdRxSbSZsvJhgqYwM2QJr1n3sx04r5OUCYosba/jbjfE0NR8bfGsbjDHpT
         LC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857598; x=1725462398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsp/dr2A8RVuOSv7+bZ/A8ygfp3xRZkvD/aPe5ZNFqc=;
        b=IX5Cza2wUN4RaK1vYaeaaVJl8PxgICoQRcliUywc/n8ZCucAE9vyI1tBeDwfAopWRe
         n06lM/IgjLM1+9zki52GRbykMGWqoBzSOf+k2Zawq1gEhTs6VNRYWCTK7Fm2Hm/Bjk1X
         P3+lZqAH6Jgt/yO79G26WkrMCEl3dpDp3hUEZFQ+Lcko+0YZEIKkUgc5bxlppMrUVSol
         95k8tGpkneX8OCjBdD4W9LT64WXvD957thscVfQTdBKNZ4u1wWvZwd9V8HwaFJXti738
         qqmk3sgm5KB6ZNNTJcQ7K/AlorCuDyvNuTP9dF0j2rXCI4ffY6gvebJ0px87EUyspwKn
         SX4A==
X-Forwarded-Encrypted: i=1; AJvYcCU/0x7QnpmHay00XiU6W7JehCiaCpmSdM2BxxTD18ATfA0dkWVikez2LalSUcIF7amzyfLiuEgnNXH38Q8=@vger.kernel.org, AJvYcCUvsC4pI+ylRtUBDa4BvpGOYTCKttTc9JtorzWM+fDIO2aWNZawYcl5NszvW0qL/C3dp1V+9gf35OhjQso=@vger.kernel.org, AJvYcCXmkvkQ9Kj/EioU6N6e24DxH2w+5pSyGQnP5mshPJBUqq/yzQq2seh6X30CRJLvetaVod2X9RN/aIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhcQCblnnjAd7Ra+92uVJWwhpfC8FlRTrZy0LowZTxl1YHO6j
	rQd0gMx24x96yEPL2wtwyeBLDdC/oSPPNc2sZKqVDmdKvL1VXugM
X-Google-Smtp-Source: AGHT+IEtKSwVFOAj8K0EesofDPxVdQBuGr/T5I/4UwAh0DQKQ+QRh0aGT7KQA5RnRwNrawAeR2+h9A==
X-Received: by 2002:a05:600c:474c:b0:426:5f02:7b05 with SMTP id 5b1f17b1804b1-42bb01ae32bmr403155e9.2.1724857597242;
        Wed, 28 Aug 2024 08:06:37 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396516sm24453705e9.4.2024.08.28.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:06:36 -0700 (PDT)
Date: Wed, 28 Aug 2024 17:06:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/tegra: gr3d: Convert into
 dev_pm_domain_attach|detach_list()
Message-ID: <4455ntyh3v5kk6p2hlprcdc3twy5lgwcihl6fg7akxxlxixr6f@vrpesypllh3o>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-2-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aakd2g3kzltfaxa3"
Content-Disposition: inline
In-Reply-To: <20240723144610.564273-2-ulf.hansson@linaro.org>


--aakd2g3kzltfaxa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 04:46:07PM GMT, Ulf Hansson wrote:
> Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
> and manage the device-link, let's avoid the boilerplate-code by converting
> into dev_pm_domain_attach|detach_list.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/gpu/drm/tegra/gr3d.c | 46 ++++++++++--------------------------
>  1 file changed, 13 insertions(+), 33 deletions(-)

Applied to drm-misc-next, thanks.

Thierry

--aakd2g3kzltfaxa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbPPPsACgkQ3SOs138+
s6EqkBAAojWU4An2bsf2ExMcxFSnLZAgTy+0oKT19spuBuBMom06c0dqUYE5JPc4
a5H1jDf9Tkqp6n9C1ipsfs5zQZudyd4TKw0V+6zsa3AgUfB2Z56Fi+0N97Rx5+Ho
D89QbZ4KKJJ7TAjt/bGut989SXNjx5mwJ2TMpZyANRimtrpPwTgJfZUHf5mJatOr
PccfAUwdMVgxaRhgZKcG1fTv7aoiQ8ip2GgOgiXqnUa8uGV8SkwmHPalaJehl2AP
nx2A3R9hMAdNTKNZ2khY6XgEiwlwxmxEDT9KYEL5YWo/jhswxMccLAW8ku043Bf2
Lk7H7rCiGxokQ+kGGLMYPDii54kk73Pwjlam2Rw4YjO1G/X7cb+5sEA6MQviBP9u
K0Hb/TCtUlArvTeMZAb2vcmvInVbqjsYtGakp/ANzdFgOiUe3+q9MoCp+2j6UH74
/q2FubZqi58ETEYAWcVwCpFhp37pHed8xXT0rxbxRLR5nnQx9yzZITxYZ0lQUdgs
gIabqrw5Ezk7gJzJ0jx8rXnt7cgxquhIoxPde6vyLJYqRK+nNu7N84X0yiqzCSvU
083uT95ssekN8TrG0rpXj56C3tyqR1/MsGg1vNSrzzTQAQohW1qNWubIG0wUz975
Pg6ZU0M1BaVAZS+0OtpkEYPLMvL15p7znNg5GdDIElQeYlWZgNQ=
=9p8x
-----END PGP SIGNATURE-----

--aakd2g3kzltfaxa3--

