Return-Path: <linux-pm+bounces-14984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33E98B3A0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE1A282DA6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 05:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F68194A43;
	Tue,  1 Oct 2024 05:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZqChmdl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD8653;
	Tue,  1 Oct 2024 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760435; cv=none; b=LbwnlUoESw3I13eD/xBkfxSLidqmDaPTjm/WU5hUI5XmkNkhStESsOXUFmye5UwucLT/evCnVQDBVHKxGUZxZc3EGf4+quYkA1513F435fP8X/XztC85QyczNCv7qkxX/Ae4nzYjMhAqNOtA455RlGz04J8Jem3JYZywSZg+Uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760435; c=relaxed/simple;
	bh=oKI19iAtAvAoJtl1exIQLMbgeJ3sVbyO3DmgF8Sh0Pc=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=p3Bs2Mvj6G5hOX3DcoRv9Fcs2vLF8Bh5k4HQs100VsX3dGcwHY8OrWDc9P7mpbwet+jZEXTUEKH56RTKhIrWozP5GGsSiUJA7sY8L0s3YMmjYG8y8qprp7DDOxqTPR+WEPoHxKeuGeL4GO2qn8yWZyyTRh/F8mbr1iD+TiLsov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZqChmdl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so49164675e9.0;
        Mon, 30 Sep 2024 22:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727760432; x=1728365232; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mSNy5y8MRampAtLcSp3doOd62kowEaAUNqS9Ck/CGwo=;
        b=ZZqChmdlVD528ISyj2fVV8VIrpihTF+Zspe4FdV7BWtXGFlHuaPIu4Wd3NZLMCex35
         8uzFmfA8CJdExJNsxkG9GbbIdg9QW/OwiJtBIOFrymd19d5T7NeKqW5iOSioAWdxwM7e
         M0cVmfyDYzx/z66P0JhOPzbowtAhl7YWCwURC2HwLs5sT2dGUkJIBOYg6eZWwIwPox/q
         0szFym46vqx1GQpLi4fFFHsRz+of45S1nOx0hLeNzmlOr9T/FON4hGONwEs3KDvWbiZC
         VSJFdEI67D/hlq4UZbmcYcUlE6tA3XlfQzt0Gqbg/7D+9nePDqiid7mcdW6gj9StzAGs
         RILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760432; x=1728365232;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSNy5y8MRampAtLcSp3doOd62kowEaAUNqS9Ck/CGwo=;
        b=SxngGykeRM6cmgvjPy4y8eE3wKW99lc+pXykc/+HPEk+KccFyB0ZP2MSLk+iz+bchs
         ZlvPnf1ozZHdwLbecHPXR1aK6w5Z4xrQoa1eEugFTiCvnU/zAVcw2bkqe+fRAa7z7+v2
         jpQAOQ1G2teBZYzyXXEFkd84laWQjzq2oDKwNUrDudUmkg9u4a7ajc9rWdEymbTIFxMS
         XXHwesZJDWCVZTr2/Ycrn/RlDq+5JLVYu9itQDef+IGxYJFDSxQVTqkXwBe7n2qwdU1p
         UjAckSyntsTkrSq2yZM8cD2xwHm9CIFkK7ky+o+bLYPfW9rUS1B/erzgK/6MtQk2+uFs
         Q3bw==
X-Forwarded-Encrypted: i=1; AJvYcCUTyuqVQnI0vZTeuU0/17KNjYcEVQbeUD5hsYeAPIzxELkPWlv2cALlL5ynfsfvcvI9ikdbauepT0w+sqs=@vger.kernel.org, AJvYcCXC6qOupcADzuuB+grqOviHtOCcubPYyBGkM/YxIWnddpAO84d3xtfwXRkek+V30EdKq1jUH/pox1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfoirw6O8a3uXaymJPsLV6A3S3Dclr3pTuIVT5tK50nKMqt5FN
	l5rdTe6gpInGdfGHTAoLYZi0DUej+KBC7XkGTs9eyKrGxyyAIKkv
X-Google-Smtp-Source: AGHT+IH4/tldL4pRTuNdDUjX9RV3d5PPP0q/x4GoUfPF0RdBDxFK2Me8cmWrcOvnSLCnT0x768oJ4A==
X-Received: by 2002:a05:600c:a4b:b0:42c:b6e4:e3aa with SMTP id 5b1f17b1804b1-42f5840d0e8mr107343195e9.5.1727760431641;
        Mon, 30 Sep 2024 22:27:11 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ffa22sm170038555e9.25.2024.09.30.22.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 22:27:10 -0700 (PDT)
Message-ID: <66fb882e.7b0a0220.1118d5.90ca@mx.google.com>
X-Google-Original-Message-ID: <871q1075qr.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: rafael@kernel.org
Cc: viresh.kumar@linaro.org,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Avoid a bad reference count on CPU node
In-Reply-To: <20240917134246.584026-1-mikisabate@gmail.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Tue, 17 Sep 2024
 15:42:46 +0200")
Organization: Linux Private Site
References: <20240917134246.584026-1-mikisabate@gmail.com>
Date: Tue, 01 Oct 2024 07:27:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dt., de set. 17 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> In the parse_perf_domain function, if the call to
> of_parse_phandle_with_args returns an error, then the reference to the
> CPU device node that was acquired at the start of the function would not
> be properly decremented.
>
> Address this by declaring the variable with the __free(device_node)
> cleanup attribute.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
>  include/linux/cpufreq.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d4d2f4d1d7cb..aabec598f79a 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1113,10 +1113,9 @@ static inline int parse_perf_domain(int cpu, const=
 char *list_name,
>  				    const char *cell_name,
>  				    struct of_phandle_args *args)
>  {
> -	struct device_node *cpu_np;
>  	int ret;
>=20=20
> -	cpu_np =3D of_cpu_device_node_get(cpu);
> +	struct device_node *cpu_np __free(device_node) =3D of_cpu_device_node_g=
et(cpu);
>  	if (!cpu_np)
>  		return -ENODEV;
>=20=20
> @@ -1124,9 +1123,6 @@ static inline int parse_perf_domain(int cpu, const =
char *list_name,
>  					 args);
>  	if (ret < 0)
>  		return ret;
> -
> -	of_node_put(cpu_np);
> -
>  	return 0;
>  }

Gently ping :)

Do you have some time to take a look at this fix?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmb7iCwVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVl+FYQAJiRWLjb+cys0g8k9a5Ga1kqMuuw
j+TxywI/JQvzbbdH+hKfiCh/AtoobXrpxl7rKZG0TKvVIGShEdJ9oBkul2XY4KF4
RWyKgo6AEHLIK7dUtdqoaQbvdkSo4VXpaHUScYwsLVXtwWKDZchQPaaRlz9TVkVX
0hR+EIP+9fLSzKyEu3KXidwajZsaHdH15EFPwsiPtAyVDFvFdPrbXXmBita5Bkn1
P2yIfja1kmdYlugRVATbRm6m75vYw5A6PbhpTT0h0k8U3v3c+tN6Fiy56ZVxzgku
iuXTz1J8Q4QBmNIRTmul+cmvk0ldPJxFi7G4wHgR0Jj+CN0XngQDPukrjy99tDx/
EADEsj5iFfzWB5H1tFo4OpVI8YiTJViZ1e35pb67niM32bUxY7NTm5ETH0OoClId
2SGhtkQ2hKKhQrZDAMUUCreOrp5WFNPjaDAiYWHOzL0NabXfuadpOICH3yTFk9i6
xX9GMKZAM7XUyml0vAr5O4ZBefTWQ+CayHyZQlM6NQUE3R4yN766BJAfWL5V8eE5
8qYNqPaly2DLudg+eqdbwi4N2sH4k8HkFeUj13BFPg2F/4vEzQ3X8oXsXlNSXRZZ
tFdERZ/MEpQsASXvPgXFM4I4hgUz7xKNQe44l1h6HP5DlSnUM324+lPE1f9vS6bo
JbAzs6baX9cDSu82
=i1bU
-----END PGP SIGNATURE-----
--=-=-=--

