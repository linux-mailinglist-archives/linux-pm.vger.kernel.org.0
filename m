Return-Path: <linux-pm+bounces-34728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D83B5978F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 15:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FB481D63
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B883191C6;
	Tue, 16 Sep 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IVUJhPTX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F63311C1E
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029119; cv=none; b=tdCTz2Oc/9aBZU2DM2xydUbi+77rJ33bgNA66OThbF+Fctgb8HCue1upg63pXveVS3Mk2Ybf5C8XjTlsPcqTRBW9go4u1JfsAwfbWqHQH/wfUKuI/oUEoWIxOzz6rQkS32pLdC0Jc8v3iIqiAaUZlNcIrJqt11BO+RxHO70rx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029119; c=relaxed/simple;
	bh=PRpXH+sZjdebPpC4rWrrnPimJkKolPv4aO3TWAccum0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEFSoAD8kUmDCeJSSJx+y2tfuAnHRL4bGqrcL1ZoShH1tPQSB3SW3ABMBCAovH3iygE7yT96p0oosUuZ+TuUbeWExfhhaTK+thNOYdfMcligtGpUPqraZbHXd2PmipXuQLda8jBqfHsHVlHQkgqNIaYsabWPAE2FOzaOP0a8yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IVUJhPTX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78ead12so776732366b.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758029116; x=1758633916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cec1ryxoXhXjrqFSDj+/T+n/YhygzPX418Utr1UQ+9Q=;
        b=IVUJhPTXbWR8QfUsBnQZUZsqv5OFAueWaiCO4FxXmaMFpwLs7Pn4IJfZI02C64cAwC
         +RgPjPf/6I3Oinz0CfZfrNgP7pN061/hDfV7X9c9YjDJNJ3ZMEY73YBuR1O7zk2Eh+q+
         PWWlULY8Z1Otvpz9z8SeD1zIryMmxf1/sOo/IY5drClwgKZwHO6GFxoe1kHpwzZhjccK
         YvfRAHeYHblSiA0dTjjrXZ5VN9WoI3/KH+ADNaIBupDiMGgalOrgDpeTyLYRt//VNlPX
         UXAuNW0mj1WnYYNdx1WB4K6sho7+aDhccOu5MqHlHEnHxdO9hQUctqvXimcR7o+I+9IH
         08AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029116; x=1758633916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cec1ryxoXhXjrqFSDj+/T+n/YhygzPX418Utr1UQ+9Q=;
        b=Vo7IcVgD8GwEIuJ5sDpFTxtDKfu5DwktQBpAJORM1A+vm/luS7XfBspMjoy2hPuWuE
         gEhI7ASf4uSVkPrTtuFSQ62S7+z8SJGRZhXQ6P8y8uxzYp5TFKIX+evlGxNn8h3eG9tZ
         B5pFGDAVLKFdt7DZ9Ioy8WYSzWMvNgEv+6uFCCh19Jei5A0ahSaeQuUcvy1ue+NeTNOs
         gZNehqltI/ptBkAIm1qKoFcGrTaJ4aKiFu30ryub1LFi4IrALZ+vmCfdyNEkyVrbLdMn
         iZRfk/Wf6BubaUhaEF8z5qMS8kmqP5IWKIKUf716r+kLHd2wMzdE6amw8M9/NUlTj//2
         IiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLMQwKksDJ9o+ODKC0V1N1cFXZ3nIZgGPs4IVh3BLv6x2igJm7aioKDFE7XmaI/ijKig0irYDD2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAALUQW4VXBdWiqt3xJltMXBc1LrQ+f5AurSuRMml8MgVO1atf
	nbzxbyrfCrlQP8TbK3Y5odqbZWVlyLWzEBj478RojIGdgn/QlQqFqGZVNPIe5dMPsIM=
X-Gm-Gg: ASbGnct4rFlvg8YMyqpEo43L8ZXFLm6z6c+VrV2G0ehRTrXzEUYAD0aPZ3v8PWalO9X
	Ui8fLMB1wHWYwz3dwlceMcwrawnAl8U5bQGM7Fda1h8yLJtFduStiowXy5/PE7AisceC8aNLLI2
	UQeRuHNlYIqP7kZhVIt31b+OMkV+8AYzYx5T+tlW+Sm0SAaPYD1vRwWkXyxneHo7oGZW6wku9DU
	SmH7L2pVUS7SP0BjrfpjqGn2RgYYrv/83O8C653rX9k6sOM0TFbWiEHDrgS4OQsLmWFcSNhVGO2
	gJbDo6X/koAHLVkdNyYDWPFU0O0ax23WAwHbnysUl8rgeV+WNWsVX3b93HbGBCAEJH8Xiiae8JB
	6qODS7MN8Fe6Pr+o+piODJ1AmyWc7MZYPM7ZrSu9vAsCixhbkLQUjU+GV/fIk11cVPRDaPF2cKE
	s=
X-Google-Smtp-Source: AGHT+IHULzH6kKOXUPbwiu6vHARKbboHWXDMpcq23vOfkgCUTSIFoBy+/FHZDfo4eSTeHnxRnGrBPQ==
X-Received: by 2002:a17:906:eca2:b0:b12:3f5f:603b with SMTP id a640c23a62f3a-b123f5f70c4mr542368966b.3.1758029116046;
        Tue, 16 Sep 2025 06:25:16 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f35cdsm1135878466b.92.2025.09.16.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:25:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:25:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <mr7gqhvom5soofn2oujzxtsuczsnx2yizkushar64cojwnvhd6@dt64ojgjqdxw>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6v4vfa6gjhs5clj"
Content-Disposition: inline
In-Reply-To: <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>


--j6v4vfa6gjhs5clj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
MIME-Version: 1.0

Hello AngeloGioacchino,

On Tue, Sep 16, 2025 at 10:44:39AM +0200, AngeloGioacchino Del Regno wrote:
> +/**
> + * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
> + * @sparent:	SPMI parent device with previously registered SPMI controller
> + *
> + * Returns:
> + * Pointer to newly allocated SPMI sub-device for success or negative ERR_PTR.
> + */
> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent)
> +{
> +	struct spmi_subdevice *sub_sdev;
> +	struct spmi_device *sdev;
> +	int ret;
> +
> +	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
> +	if (!sub_sdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
> +	if (ret < 0) {
> +		kfree(sub_sdev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	sdev = &sub_sdev->sdev;
> +	sdev->ctrl = sparent->ctrl;
> +	device_initialize(&sdev->dev);
> +	sdev->dev.parent = &sparent->dev;
> +	sdev->dev.bus = &spmi_bus_type;
> +	sdev->dev.type = &spmi_subdev_type;
> +
> +	sub_sdev->devid = ret;
> +	sdev->usid = sparent->usid;
> +
> +	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);

If I understand correctly sub_sdev->devid is globally unique. I wonder
if a namespace that is specific to the parent spmi device would be more
sensible?!

> +	if (ret)
> +		goto err_put_dev;
> +
> +	ret = device_add(&sdev->dev);
> +	if (ret) {
> +		dev_err(&sdev->dev, "Can't add %s, status %d\n",

I'd use %pe instead of %d here.

> +			dev_name(&sdev->dev), ret);
> +		goto err_put_dev;
> +	}
> +
> +	return sub_sdev;
> +
> +err_put_dev:
> +	put_device(&sdev->dev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_alloc_and_add, "SPMI");
> +

Best regards
Uwe

--j6v4vfa6gjhs5clj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjJZTcACgkQj4D7WH0S
/k4DDQf9Fn1HPf8O4u3moGauabP4ZoOg+KJoOMMHiL4JAWvb+ihWLP7SpGDPBfiO
DjMRfgEltRK7S1XHVZqjpkIAREqaRc6TQCYX7uafwyX9JXpUGPvjoVWeywhnWJU3
5vE9b9lEeFfiRzBq8RQ0tr17GyPpmviyXdL6kimCDDWkKzCqU9mXskQiO/HYxzDV
mJBLPPQQ6aRxVVBLLqdsggxptBQ+8BtkqUy9+yqjncsbYTwEgj4QY65d9yQXPTgL
st+pYh7Ra8xceTMOExplwPHN/uSqPBTMTRomAsrtOz09tETIkR6mOuEOUO3fsy9q
v/FjPX6SlBekOqw7TnPDq/t/204YwA==
=j8SY
-----END PGP SIGNATURE-----

--j6v4vfa6gjhs5clj--

