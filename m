Return-Path: <linux-pm+bounces-10306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295491EC7E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 03:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52091C21776
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA424A22;
	Tue,  2 Jul 2024 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTLG4PuT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFA4A06;
	Tue,  2 Jul 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882934; cv=none; b=PzntgPGGqXUozD62iEnYY6fq8eYPpRXMuJin1NUQu3qozxd/y7Z7cGVy0pqAweGzkgA0hkBeOAg+C/e8g3LhGXQa32Ob/Ipy2DlH2kPKXJ41Rh0Cb4itFY9LgBx/H6yf8FyAe/B93KXjAtIls7RMa/cfJck34UD6GoLc4miao3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882934; c=relaxed/simple;
	bh=Gtrt6hGFdlUrCR0r7K3OdsOn2P42A6OdRY4ERZo9r70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbft0/k5OOx3W8dQAOe3sA7J62+7R0dglD/arhgZQqIuuHLsqQSfM3BuTo3775ljYonYZIbthzzCl6PMzufDxjzTc6B2DunmyJkK/t4EXOPGm2VqkngICTEedE/1NvApwpzQ5upCioIT90KtPHuXl0q/yVmMIsDDcu1n137iR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTLG4PuT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-71884eda768so1970606a12.1;
        Mon, 01 Jul 2024 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719882932; x=1720487732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=urlS9+H2rKMJUth4dq3lOVQ77liEguo0Lq3ss6wvw5Q=;
        b=nTLG4PuT2koQFDCifkM45vHIR/aNJXISioHhZHYqHe/6o8+nDGbYl2fVWRHJ0uo4/n
         F+QJ5JfwRNICC7V4i1F/oiTzkjPppgTfRUXnB9c0ctNYqTaLfFH+W7H98w6URLyNRir1
         LEq+w+SCFXJYo1CBYaZfrJJKHk+3V9FWBwLUqhu3nGcmyGHLExjN96DWrXRCYmaiNXH3
         VelmNb+n3m1XorAirAER6Cd4ZaO+D24mcAH4mCfQMa6OLl6tuE5eMbB52dSdgb73cuu2
         trfurN3sIbNrod5K0edQlAKxiZjWCSWqcgWrlQdsFTRBAwDmIiUSVrAh7icPZwwyBFO8
         BaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719882932; x=1720487732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urlS9+H2rKMJUth4dq3lOVQ77liEguo0Lq3ss6wvw5Q=;
        b=NJhypjxW4vRdU1HzrSobUDaBeY8+2MjjsuZqVVlFBeTdob05Rt+KZYUosRrUOuMeDN
         RnXnyOd5J5eFMdj3Vs6vvZ6r9RHRdoeZWbzlxWrBkAffJ+jAQ9JS5TRkctNvaojjXnVI
         AQ6RrAhf1ZaNmebEvpWb1/WGSTQWzHInVFqwlZnEaqwIzb51ZiTRc8Q4GnY75zoXpiRJ
         NfFbKUZECczQb6qi/BypncS4DYQRtPhElDR7vJvGg9mphfy16EFNQn2m8pzLL7n3Eu3e
         NbZiRTCAc2PzeB7gY1Loz/FVKE7zpLc+0u3VjWrxh1M9SrOWgymFLKxX8n/Arn9UCCqd
         qjNw==
X-Forwarded-Encrypted: i=1; AJvYcCXb4dCUia5okaLY+DKlBeclK5UwQPFaCYz1stAD1qBdbEPsHB9nk1WT0mS9gI/l6cxm6rVTinVET1QauS1Ns42mFg+svd8QaeYhcwm1PcgHO+fqHNNkRcWm9WcupBDwxjzr+JvOMFNH
X-Gm-Message-State: AOJu0YyS5WMJGHu/ceF5ekezWQDlJejK9SFtGl1ORFwRA+zDMJqncCZ8
	nd5LwwRqe9LGmnZLUGtiT1GTgvDdvDVpZB+1gaROUrAeXT8pCW+s
X-Google-Smtp-Source: AGHT+IHGBjNarJxkMTwR1vMfijoLiLQNzgEK7uXM4+u3EZpSJkCYQ0nWUNT6zcB7AAoLL2Ohvh6O4Q==
X-Received: by 2002:a05:6a21:191:b0:1bd:22b6:121d with SMTP id adf61e73a8af0-1bef62141f3mr6633091637.52.1719882932208;
        Mon, 01 Jul 2024 18:15:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15693f3sm71464175ad.218.2024.07.01.18.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 18:15:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D8FB51816BD2C; Tue, 02 Jul 2024 08:15:28 +0700 (WIB)
Date: Tue, 2 Jul 2024 08:15:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: docs: Add missing scaling_available_frequencies
 description
Message-ID: <ZoNUsBou78XACmdc@archie.me>
References: <20240701171040.369030-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AFijACploa3LrsLr"
Content-Disposition: inline
In-Reply-To: <20240701171040.369030-1-rgallaispou@gmail.com>


--AFijACploa3LrsLr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 07:10:40PM +0200, Raphael Gallais-Pou wrote:
> +``scaling_available_frequencies``
> +	List of available frequencies of the CPUs belonging to this policy
> +	(in kHz).
> +

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--AFijACploa3LrsLr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZoNUsAAKCRD2uYlJVVFO
owD7AP0WIyBtpy7PzyR7Qxahrz6raKGfHhvs7okvWJu7UHKUmQEAzP8mOwd3yD8H
vSh623WaG75qA0IHEQvcoPW79Zo5VwM=
=dPo2
-----END PGP SIGNATURE-----

--AFijACploa3LrsLr--

