Return-Path: <linux-pm+bounces-26519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1B1AA64FE
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA491898392
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4A257436;
	Thu,  1 May 2025 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="a8jxLWq2"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1D256C6F;
	Thu,  1 May 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133184; cv=pass; b=px+lYuGHH9WVdY9+l/gIp4DKCmRnhcwYH9A83qTHTFJy4byNlAJZGCcXquJeZO8UP+95BOsw6ajRKGUEe/NCT3eSLnV36VE6rxx+IgIteD3cR5qsEeOEEcoMn5rAgjVfG+nD7NWAi1ai1my1ej+H4p56xOnsCuwSGZDOr7H8reU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133184; c=relaxed/simple;
	bh=Tj4FkkrZvsB2maiC806EUMjK7SnDEzY/91hRnDmXD/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVhYfpYTtxEkgdzuCVHCfAlXzDe26dyoqEuWkws4Jy638v8k7E24FexAx/ZQjOmeOOvs0+vjky8rAmYkWp6zRsTcqJ0EfLCVryIodXt1OzTo++vGmd8AVnbCwflS5fWeKvwHE/el8M38bAJBNq2XaFfjvVUN9MC0ZxsGitvmX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=a8jxLWq2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746133166; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lCcbmb+W2Tie3QctiCvTewK6zzhTBwBr9d8rZdx56zXsV2wnaT3NL0ECFf2+v3BgdiUQmoBGHo2QOjpcFDRViVDKgjPA0ScklgQHfQFDDaZdP0Oy/saISqh3TgHjdJLq/hKprKrvg6IkTXYm1m68ELNuM6YZO8rHBeeCihiZZu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746133166; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KBLoDZx40etsHxiD6+f4YnG0HqAxRojVOyVHXmA7Y1Q=; 
	b=boDiSkMVwFhiVQEgZhWtflbfZIGdmPEdifwe5bZfHRVb/MdO/bNVQf6yuWFxDsRsBO4oqtRFCm8zN6g2HN8X3VIfNfIs67XPlhzBX/5j/QFF0m+YFrXDkY+WrJeeL5+zOzQDw0+BrO9NiH0ZU1ek2Exg7Zc8cuivpXRidoB8ykg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746133166;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=KBLoDZx40etsHxiD6+f4YnG0HqAxRojVOyVHXmA7Y1Q=;
	b=a8jxLWq24ACRpbiOiS/VirPsYzmXpIvodwiGGaY0rUUcW8NrKVyF0ONECrWWwmIf
	Ub2hcuLeqxQwsegs6r6I23pFUaviup7gjad9joH28H00LoYhqJo4uuty7iEBFnSkIBn
	RqoXlwa0N2h/TWvR7K1RTVgTFCWNFCaXdNqmjn5I=
Received: by mx.zohomail.com with SMTPS id 1746133165242855.708041863016;
	Thu, 1 May 2025 13:59:25 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id B3E63180F5C; Thu, 01 May 2025 22:59:19 +0200 (CEST)
Date: Thu, 1 May 2025 22:59:19 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>, Guenter Roeck <groeck@chromium.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9 4/7] nvmem: provide consumer access to cell size
 metrics
Message-ID: <dixmyhyj6b66vyizfotpqw6yzaavi2o2mauloa5x6zn3qgk5ub@huoal5ucdd44>
References: <20250422085717.2605520-1-o.rempel@pengutronix.de>
 <20250422085717.2605520-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="txcrry3e57y7fctt"
Content-Disposition: inline
In-Reply-To: <20250422085717.2605520-5-o.rempel@pengutronix.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/246.120.57
X-ZohoMailClient: External


--txcrry3e57y7fctt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 4/7] nvmem: provide consumer access to cell size
 metrics
MIME-Version: 1.0

Hi,

On Tue, Apr 22, 2025 at 10:57:14AM +0200, Oleksij Rempel wrote:
> Add nvmem_cell_get_size() function to provide access to cell size
> metrics. In some cases we may get cell size less as consumer would
> expect it. So, nvmem_cell_write() would fail with incorrect buffer size.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v6:
> - update function comment for nvmem_cell_get_size()
> ---

This is also needed for the following patch:

https://lore.kernel.org/linux-pm/20250321161449.1175473-1-jberring@redhat.c=
om/

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/nvmem/core.c           | 29 +++++++++++++++++++++++++++++
>  include/linux/nvmem-consumer.h |  7 +++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index fff85bbf0ecd..754a9448c39d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1828,6 +1828,35 @@ int nvmem_cell_write(struct nvmem_cell *cell, void=
 *buf, size_t len)
> =20
>  EXPORT_SYMBOL_GPL(nvmem_cell_write);
> =20
> +/**
> + * nvmem_cell_get_size() - Retrieve the storage size of an NVMEM cell.
> + * @cell: Pointer to the NVMEM cell structure.
> + * @bytes: Optional pointer to store the cell size in bytes (can be NULL=
).
> + * @bits: Optional pointer to store the cell size in bits (can be NULL).
> + *
> + * This function allows consumers to retrieve the size of a specific NVM=
EM
> + * cell before performing read/write operations. It is useful for valida=
ting
> + * buffer sizes to prevent mismatched writes.
> + *
> + * Return: 0 on success or negative on failure.
> + */
> +int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes, size_t *=
bits)
> +{
> +	struct nvmem_cell_entry *entry =3D cell->entry;
> +
> +	if (!entry->nvmem)
> +		return -EINVAL;
> +
> +	if (bytes)
> +		*bytes =3D entry->bytes;
> +
> +	if (bits)
> +		*bits =3D entry->nbits;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_cell_get_size);
> +
>  static int nvmem_cell_read_common(struct device *dev, const char *cell_i=
d,
>  				  void *val, size_t count)
>  {
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consume=
r.h
> index 34c0e58dfa26..bcb0e17e415d 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -56,6 +56,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
>  void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
>  void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
>  int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
> +int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes, size_t *=
bits);
>  int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
>  int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *va=
l);
>  int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *va=
l);
> @@ -128,6 +129,12 @@ static inline int nvmem_cell_write(struct nvmem_cell=
 *cell,
>  	return -EOPNOTSUPP;
>  }
> =20
> +static inline int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *b=
ytes,
> +				      size_t *bits)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int nvmem_cell_read_u8(struct device *dev,
>  				     const char *cell_id, u8 *val)
>  {
> --=20
> 2.39.5
>=20

--txcrry3e57y7fctt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgT4KcACgkQ2O7X88g7
+priChAAhBa2jS9PNKKJX4SU92UX/skvv6BYd12ckO6cGpe5H44x3q8fZq4S41Kn
+IKmI0Lp5BM9IPMAuiC+p5GeeLhWlHbq5HPR/tlhj8IxGSIlTr7xgxEs4WsaGw20
skKZIKS6d4UhEIxI5W1SvbvdbLe/VUgSLg/AHAr9MQt+hHjX2lnCjBqvX9IhMP8I
CQouDIr/bYwIimnQICrHhlhgQAo7TiKxaw9rXDNui757iU7PrLPhilF9YvL8rJSP
KBeSVpGoCmW0Wg9i+at+vDG0xpcugLm6UFt3cNP9eqrXa2pMO9kfjn7MUJ8AowKB
BtKtK9Sw7/HvMadW6zWS0pd/5GvxVkPJIWYsnh16crnu9eX/v0uYnblZW6qyu7cO
lIMBdLErio97FaaXGD9bloDj+brOwYw13ZJfQ7ZaJftlDWcV+ru0LgCrMbiIp05V
S92NZUyEKLpIGXdiYHPz08pI+qMJjvb8FuCSlSUieW6Ea7zUKOOLIGb95i8Yg+wA
EjnIbXB3UHxVQb+UGMQ1yjsTmE2LGQy3T/y3tqDXryHV8sVMeZRanM/OpnkVKMve
mlHaGEa+zGXamMN6OT7jHVbfgNmMbZVFWQ+Il3UOkdcTufl6b0OOoDmIPu6v6EY8
cSIltAGqZfUgmKtxDZbjBRkMjPNwGuLgz9MifrBKZL++OvDlvdE=
=FfKc
-----END PGP SIGNATURE-----

--txcrry3e57y7fctt--

