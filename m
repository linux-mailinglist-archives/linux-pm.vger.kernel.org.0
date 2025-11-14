Return-Path: <linux-pm+bounces-38035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C7C5D4F0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 14:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7094E68A9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB8D245012;
	Fri, 14 Nov 2025 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU0C3J0u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA62DF149
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125979; cv=none; b=dznxcxpBkaseaMO7iE1Yx/EsV0E/AU01vseNm8nrggfLrXMRoT/clsNEqBPXjxT+1qy4YTfH/86ZRTe5HkC4GhXfqDmjatm1JJ3wyTld6ptirekvdCLURS1uyx3RFfX007srYuRnmAEJsRQA3WeT5lapyP8H4/zGLH+tPtfrvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125979; c=relaxed/simple;
	bh=fiNxHJ+1t9jRy5tfY62JXn4CK9QS2Ve3oxBYjn2oCMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNEsSVH36f3zG6ed11L4wcprBLRY+2VRXlpBVeCuHQkaU6/8I6Hu/JQbM7JfZzmuxkYsZqtm/EvSbZvJOt+sExerjtzLLs/pIF5HW80O96TwM18dQz9BZnwB1h65VhMhmRbw+kbzqz1kzN5eFBujesYNFgyXg45JBfE6/eWcX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU0C3J0u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477775d3728so20090385e9.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763125976; x=1763730776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aiaRyE3KzbZU6jR11ZQbwcOI3+XogZwM7yC3xD5Qlk=;
        b=nU0C3J0uAlFW+LOJ22+Ek2nwrOxHqRHasPhYeoFgEx/YtI8uKcLcDKs4twm1QZl7UB
         HXkL0lGtTHb7HQiJaZPusQ8R2V1+Mpymq6v10YypiTUB9fDrPckj7FRwZ9U+6GeGNxLx
         rHdevzus+sQ/l0PDbDqs0vrzinJ+fG6Blue5In/3jS46+HDYHO33ECaHGwYMiRZYyDnM
         6BXjBTUg7inWqKmZgS/t+elsc4yl6O02boZXJ1Vx64+zbzK9txgldQY4kyv7vBSNF7lY
         tA/FMAdTFrRHEXdo3RWRARKvO/b7F8XB+g0btf2TfS8SO+6bsDb6rnf+S0d1WOtRiFnP
         hpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125976; x=1763730776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aiaRyE3KzbZU6jR11ZQbwcOI3+XogZwM7yC3xD5Qlk=;
        b=Avxi6LHGOWjWobXSU61YDdWVTlJKTcfPIPhsczo84OnDU796YeYsSqVM3hRa4srGA6
         DQ523oJ9AReItUFmxudjPmUG1T/Q5KNcr12sy/ie9gLdBM34182NHvo6KZu8WiBR5ATf
         JrSnFwur6oD/IiSmb6Mv2rMYELCFQb5aw3q28xtSvUaWaVtkVr+iEeufLkFpm0/D4+bF
         EwqhvgL+S4DhG0pDkWuWyTIdCcYyZtHL5GtbhqO4ky3TGlqZM7liwYYmgiCdwJaGgWLS
         Dj55nt19A5sPx6DoqUG8pbGqjxnvP+dMSENkDDvPN0dofVTJ5qcezOJ9ap6JsnKFujhf
         0Gfg==
X-Forwarded-Encrypted: i=1; AJvYcCVy4FuSjS8Yb5moPv5zuFtOLF0DMiLhxIZ3NwMrmVrCFpzfaIAEUaQUTYtyVv7ubiiQb58pU69ClQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5SuRm+SuvFXoc2cmhvfLyu9om0dH4o+Ejzf57yyMLpBg3TFd
	9zGCNc+PQXkUJXkyb3r8e9ZUuodYmbHe4JoGeqmrTlnoO46mVSzR7Nf4
X-Gm-Gg: ASbGncvXLBbPrjVYY2jfF5jK1bhp3nqDafUlUNJO7TFS/EdVx9d+KLAggg2sxi1JSuq
	4RzEDjxjjaFrHnN18VgxhS7mj268ag9S1rn+TOCd3n1fG1mentIEUycwDtuJ6KjJ9/D3ncdPNJ6
	1uISsRVhxwJB57/kwc/fkaPzlqFpsWT6PxeWx27KO/uPUYKP+n9AdLcDq5UrXs2/vgA4yVbPgma
	NHBN5ynU4Gw1t6qSLADW1HLJqqjD8AYXnjrtdhg1GEw6rX2g5W5RTlVPYBpPJQX387sFBFUOr+a
	0aY9NkthY35kJ6a2cCYTbfl7nqQgtu4JYVIZ/cdNetfeakPYOGIxfono5jihLv3j2qAywr3CZaa
	1QY3STg74meoqd2oZqrOkYAO8FPo2V2IJAaD3QNxDo2QjpYAsEC1USlfhlIHjWQGVxutq+88roi
	/qeKphQm8LtIf6A2LfXgOvd/Cjof/PeZiah1bJLiG+HwCSuHRKaQ76m9L1mk7vhPIi067yRauQI
	AJpVnRWe77J
X-Google-Smtp-Source: AGHT+IHOpWHrHqFphSBVI+F4WpyTTKMUMPqtOPB7RmuTO3vcOlkBc46UawWS9SYWEbgllEpctm9RBQ==
X-Received: by 2002:a05:600c:4503:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-4778feb23dfmr27934765e9.36.1763125975967;
        Fri, 14 Nov 2025 05:12:55 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e846afsm9878614f8f.13.2025.11.14.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:12:54 -0800 (PST)
Date: Fri, 14 Nov 2025 14:12:53 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Dmitry Osipenko <digetx@gmail.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PM / devfreq: tegra30: use min to simplify
 actmon_cpu_to_emc_rate
Message-ID: <o6gkgk7tp42ye2nrbw2jiowkopaivzy47qhmuo3yjiomkkzarq@sha2bsxwelam>
References: <20251112172121.3741-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p45begdea6uxenuw"
Content-Disposition: inline
In-Reply-To: <20251112172121.3741-2-thorsten.blum@linux.dev>


--p45begdea6uxenuw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND] PM / devfreq: tegra30: use min to simplify
 actmon_cpu_to_emc_rate
MIME-Version: 1.0

On Wed, Nov 12, 2025 at 06:21:21PM +0100, Thorsten Blum wrote:
> Use min() to improve the readability of actmon_cpu_to_emc_rate() and
> remove any unnecessary curly braces.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--p45begdea6uxenuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkXKtUACgkQ3SOs138+
s6Gngw/7BmbsbDrrjYNv97Qt6va/Qu76bdimMjs502sFuMJ6pCBLuqE6o7hZ3Ewn
/FC/B00xdY3e66GXNtNLxV7C5JcWE9RJhvW7x+mGLW5YP0XUonmkpNzKiPZh/+c4
ulf/wqWZW42WuvZ/RZWi+wUh/rwzv6WTp6RYDyruAKiWRmp/ZWmo60TRrMj7QOBz
kVbXpFNUZ4o7RzCE8APvk+UoNQeKMA8fyg5UqdXwy/HvuOVxNGGzJEKCKTbPya6d
B0mfWFEkGR4J7tNDjKvYkbNuRuv0cVcivRpTwvXrg8d/NwvS4zlo2FvScetKuepS
kUVCNGW+/UQJF61kfotPGzttWdia9DCiqfE8yf4g663h4JokOqma7ocNulxMnNu/
+t4zrTq03rS951b6yfB3EV9m/EdCEQdOYvCIyhSuxbdwhIUcW3XmQRL515cOXKq+
IG0QawfMEjy//ArLDgESqH6GUeuT5Sf6GkMS0KELJH91AVmVSJ9re3A5xZFVVgT9
QsLjJE0x+2myGIJk6uVNcUkIr9cQP3oIDt/APi1EFXRTgnffAm+d5iNAOpZmASgK
6lTwF63Q62hbpZLdlvhi8NgWhtOj/e6detpyyQqEvCsxQl11Mw7RhoehtrXMCHmQ
tVqom2vrYOfBETXAimB3fS7XTLO1ce4XpLosYX1eb/ehQs40eKI=
=gjUv
-----END PGP SIGNATURE-----

--p45begdea6uxenuw--

