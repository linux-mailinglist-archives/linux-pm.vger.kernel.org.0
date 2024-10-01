Return-Path: <linux-pm+bounces-15032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861CA98C620
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 21:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ABD1C221D1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE41CDA11;
	Tue,  1 Oct 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI3vE93R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CE1CCB34;
	Tue,  1 Oct 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811342; cv=none; b=Xwdu1tru14pX3ZtJAIgalhyxrXMxdH8+CB5fL87Ffun+aZJ9jBnQ4mcq5i+pLYQ4KNIrBFDKvZheiUkqf6Nst919cc4mu7Qme+6uiEPvFQi5X1gzRHMHzcTtEr6dENxEm+HJusYL5+KDSURMQvurSCS2zwl0Ju8An+wIfXTUHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811342; c=relaxed/simple;
	bh=Z0clHml1dTIK+YNtu4Ht16lj/ka/qUISbK751rEG6S4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=qq9pdUezLIjjrUav324rP2elDPFcqmGe0gTBS6C9BVEUVyUAW0CU649tx9aOe7XXJ40I7U1nf1uLqUDvtBpE7iAEWCDDIFvoxFR5N6NQHo8JU2pGgOam8W9ZwFpCMeDMiDl3oQ9BZ6WdzP7Aoe0lCOgk1mjuQAd7yHmCzc/3MrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI3vE93R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cafda818aso56678455e9.2;
        Tue, 01 Oct 2024 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727811339; x=1728416139; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xCTuePUoRhh+Dxoy6aKZPhNHAoOweYHKOFFIiRN7MJQ=;
        b=GI3vE93RVHA1TJj5/JE5OtRMCykSSZ8HseZLae7LHPlGxkGA/bRUKZ0KonuJ8h1pNO
         8OOmJZUVJAueBwntfm8XbsUi0IXwvK2dKw46sxnvyD8tQOZSfWVe27f/k3wKAbm3WC5B
         hl42aFpQ+wETCvNk8Ta1dys2YEsVKLHOyXGRIRgVlHLQkAyIxLpa0erU/Tfe3TEGLN+w
         FskMbGvkv428BtsLL0Dmnsyb+60IgpMAC3Q9Jt+rQQWnV3T7orZzI2FDTBV5MdJ/nfde
         wqTsmpKHzOhF4KDY7xEN6CSCf5A5EWQbYhNfJQu0SRpZ3Ax78YrWctkDw2buOzi0nsLm
         g54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811339; x=1728416139;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCTuePUoRhh+Dxoy6aKZPhNHAoOweYHKOFFIiRN7MJQ=;
        b=t7XI3zpmzNbjqgdqS9cMq4BEudqPb+qHB7rjzWRf83KX9ZMKtkYTfbTF3CNRMH31IY
         Ns6p9lH+tC3MGDJyPd/Hh8twttuYlOo3+QATKk7mJnTM7331BY5TrqKuLAaggbmn+H58
         XVi533a1blF/6s46JtFdm+uG43b5LvMnbxHCvoUYB1W1KfrQ99WuI7idirCXlR+Tiu0r
         2FsLjpmIPHB8UUkDx3ZXcn685QDQ4Ok7e18mkkSj4BlpkGQOrMFGa5akHQgdHSEX66py
         CLGuXF5y3J0F+6Tdsm78YSIIzkDjSjCwztqXSwFqJTDRTsQXo3KRJTHdbTHpCEwVImhq
         incQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3+ANuJKRPk8erP6KloTmD2Wn85nPM5S6Uiz3tm0L8vnZ0NzQNbbFEEVtI7EwK3lB0PTVan+WkzUk=@vger.kernel.org, AJvYcCWudqQn0c2KDy01EjMJ6X9XZ0vgeZF1SAtkUUWhOXpDgickJ22gnfLkMvsOznOdOBvjApRhKVCaqzXC5Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKsLNkYO3Etygvmie2mYSiblxK0BzHEkLSSe1a6hokh/aQunp
	BgEBIF9/CT7fMtug6zXs4JNFdw16YJMKE9NidLj8NPgLG3VFjD1SQh8E1Q==
X-Google-Smtp-Source: AGHT+IFu6vC/AeeLXRjrlVxO7o6O1ILa2Bcqm5rC5okFyw9/4xPRPi/phlxUBOUpnBQikfZhChjLVA==
X-Received: by 2002:a05:600c:1d81:b0:42c:b1e1:a45b with SMTP id 5b1f17b1804b1-42f777c31ebmr3809765e9.19.1727811338286;
        Tue, 01 Oct 2024 12:35:38 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec11bsm143079705e9.23.2024.10.01.12.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:35:37 -0700 (PDT)
Message-ID: <66fc4f09.050a0220.10e651.1506@mx.google.com>
X-Google-Original-Message-ID: <87wmir62gn.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Avoid a bad reference count on CPU node
In-Reply-To: <CAJZ5v0i+BaCdBOoAk6a7EjDdwpjyimR_=r10kYvq9btOj3f_Rw@mail.gmail.com>
	(Rafael J. Wysocki's message of "Tue, 1 Oct 2024 20:46:31 +0200")
Organization: Linux Private Site
References: <20240917134246.584026-1-mikisabate@gmail.com>
	<20241001063220.dj53f3dbdiwnpkrh@vireshk-i7>
	<CAJZ5v0i+BaCdBOoAk6a7EjDdwpjyimR_=r10kYvq9btOj3f_Rw@mail.gmail.com>
Date: Tue, 01 Oct 2024 21:35:36 +0200
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

On dt., d=E2=80=99oct. 01 2024, Rafael J. Wysocki wrote:

> On Tue, Oct 1, 2024 at 8:32=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>>
>> On 17-09-24, 15:42, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>> > In the parse_perf_domain function, if the call to
>> > of_parse_phandle_with_args returns an error, then the reference to the
>> > CPU device node that was acquired at the start of the function would n=
ot
>> > be properly decremented.
>> >
>> > Address this by declaring the variable with the __free(device_node)
>> > cleanup attribute.
>> >
>> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> > ---
>> >  include/linux/cpufreq.h | 6 +-----
>> >  1 file changed, 1 insertion(+), 5 deletions(-)
>> >
>> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> > index d4d2f4d1d7cb..aabec598f79a 100644
>> > --- a/include/linux/cpufreq.h
>> > +++ b/include/linux/cpufreq.h
>> > @@ -1113,10 +1113,9 @@ static inline int parse_perf_domain(int cpu, co=
nst char *list_name,
>> >                                   const char *cell_name,
>> >                                   struct of_phandle_args *args)
>> >  {
>> > -     struct device_node *cpu_np;
>> >       int ret;
>> >
>> > -     cpu_np =3D of_cpu_device_node_get(cpu);
>> > +     struct device_node *cpu_np __free(device_node) =3D of_cpu_device=
_node_get(cpu);
>> >       if (!cpu_np)
>> >               return -ENODEV;
>> >
>> > @@ -1124,9 +1123,6 @@ static inline int parse_perf_domain(int cpu, con=
st char *list_name,
>> >                                        args);
>> >       if (ret < 0)
>> >               return ret;
>> > -
>> > -     of_node_put(cpu_np);
>> > -
>> >       return 0;
>> >  }
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> --
>
> Applied as 6.12-rc material, thanks!

Great, thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmb8TwgVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlisUQAMHuxdND6ld60g9us2ZCuAB4wqRQ
WOc0/XBZWb5i+VPU2r14vWPOeBUP7mbreD3TqQvQ7yQIabeDuYK8l0VrV/041QPG
HUaEXKwiC/W+1Vo/dFiwUPkOQ5NftXyBGDQ8HtwRednuyxwK/eJxsQITT44HBqG9
77fI/bElW1QpkVQU0uNtLEiNvgzbSZeIwnsMIcvbc8+bTT1+EGspygveWf0icwRH
cr7z3s/fK4D0zWORPY3eidDz0LItnN/2njSaUtx53ZAB6otoekui0ayLMyQn4iqD
EumFyeHzaoCBBcE2+xQeP0oIvf1stmi+Wzdg2YZI/dMzdnA6WWEqjsxZChj88iil
7wYzuGK36oayw/xSAGF5MbXMmF37kDQQqi5TI/vZdw2wU70GQgnw3Zuv5NCpZSwz
n/YHomoi6I9oNc0OWPvaGUaNm/gCDGGjc1w43RFQY7FUeG7MvrijVC1ThJOaZeDU
0sDF3yyrnaifbhhJaGeDzYpnpUdrG+wrd1sWPp/W8M635J6JbEbVH1dK4JjPQw3s
fd+Q4lj4Dn6qJG+gla0d+bo+OuVfv12pnYvCEgQc1bobxAKat12GCGYVBNDIZFaU
yV7vmLOWWgjN0IHQfmU8Oz8LYJCbn4A/YacHjAKLAX6GXsOdr/fft8eeE0dayBY+
5e82ZeByajgQ/jM3
=/m+0
-----END PGP SIGNATURE-----
--=-=-=--

